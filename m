Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1888C6BCD1C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjCPKr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjCPKrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:47:18 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69586B854D;
        Thu, 16 Mar 2023 03:47:17 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id h8so1237324plf.10;
        Thu, 16 Mar 2023 03:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678963636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sARMOewAiJNOJtS/RRcjmmgBbN0L7rWCfxuqDehP+MQ=;
        b=dpGSN3jOw4n9s1Ax3nsBLmwBq4kF6qhUNyP5tdxK+zYs5m39cF1Axk/vNSA11kT2Pq
         MCAlSSHBgtyCEnGZ/vJduGlsVXL9u/LBP91KyEkAtRd4G0HbuV3j3iqwoTVaBihCJ3Z9
         NyIzSqnioJhYp4P3SbYcjOKaVEAjqihAGG8TbQIFIr0J1vN0EaYZfvNxEyJu8eX4K9r+
         S/3aUHv+1vRqMapbD59ygvnfcrCH8eySbwLzu9sYnW/MoXiiNAq0ig/17YI62X9ja1/i
         AxweE44CM+HbmxwmD4A3J8ltetlqiBgGsdiozsLRIqcnU+Nacm25oQxo1+xELk/07AQ1
         hGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678963636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sARMOewAiJNOJtS/RRcjmmgBbN0L7rWCfxuqDehP+MQ=;
        b=4dqOTmt0i09W12d/ncZ3FCPqZt/KWAaWH+8CMFtvFCGG9FaNuOAieTlEh7o+38g3my
         ijl2pYTS3VSjXd+svNN2YYxpR0QHQbq+pnZ6WAOAwiaNe6GR5Ptja6H+bIthRBQA0D7N
         7cQ7QD90I6SiZKFZG+TrgTpzzzfrlwJvCTKfahN9Zyhp2XTPyza8BHdyf5j+R+CepMpS
         Og8rQFxAjtj/yoE5Q76vsDOuI8zqBllxkjZ8U7ZAL28uU81iUDTNXe79AwHclMjhX3tu
         EIYanOryvCkk1XVPCtX45KeClymTZ2ZP/3SnWDJlv7Xt1F7WKKTaBAUvDfJpSiVnCN1c
         8djA==
X-Gm-Message-State: AO0yUKX2+0naItSnhn1bHjca4BRqNNsg+nSbXlJkU9IqZF5Glo/7441j
        o5S5GV9eLw2C/tUhexHnAReti7ujox6J/w==
X-Google-Smtp-Source: AK7set8RKHXbcmQkOIL7eB7IjStAEF3yZHLQ4Yv28epu2B3lhayzDR0FHUU7j01EpjMG4i67nD5sDA==
X-Received: by 2002:a05:6a20:c124:b0:d4:72ab:df31 with SMTP id bh36-20020a056a20c12400b000d472abdf31mr2774384pzb.11.1678963636478;
        Thu, 16 Mar 2023 03:47:16 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id f11-20020aa78b0b000000b005d4e89b69e5sm5143263pfd.127.2023.03.16.03.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 03:47:16 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v3 0/4] Devicetree support for Loongson-1 clock
Date:   Thu, 16 Mar 2023 18:47:03 +0800
Message-Id: <20230316104707.236034-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes the old Loongson-1 clock driver and related code
mainly because of no DT support and outdated implementation.

Then, re-implement it to solve the above issues,
along with the devicetree binding document.

Changelog
V2 -> V3: Add 'reg' property into the 'required' field
          Delete the unnecessary property 'clock-names'
          Use the same license as binding document for the header file.
          Add MODULE_AUTHOR and MODULE_DESCRIPTION info
          Add patch "MIPS: loongson32: Update the clock initialization" into this series
	  Add Acked-by tag from Stephen Boyd and Thomas Bogendoerfer
V1 -> V2: Change to one clock controller (suggested by Krzysztof Kozlowski)
          Add clock-related dt-binding header file
          Fix the warning of dt_binding_check
          Split the driver removal to a separate patch
          Implement one clock controller instead of single clocks
          (suggested by Krzysztof Kozlowski)

Keguang Zhang (4):
  dt-bindings: clock: Add Loongson-1 clock
  clk: loongson1: Remove the outdated driver
  clk: loongson1: Re-implement the clock driver
  MIPS: loongson32: Update the clock initialization

 .../bindings/clock/loongson,ls1x-clk.yaml     |  45 +++
 .../include/asm/mach-loongson32/platform.h    |   1 -
 arch/mips/loongson32/common/time.c            |   3 +-
 drivers/clk/Makefile                          |   2 +-
 drivers/clk/clk-loongson1.c                   | 301 ++++++++++++++++++
 drivers/clk/loongson1/Makefile                |   4 -
 drivers/clk/loongson1/clk-loongson1b.c        | 118 -------
 drivers/clk/loongson1/clk-loongson1c.c        |  95 ------
 drivers/clk/loongson1/clk.c                   |  41 ---
 drivers/clk/loongson1/clk.h                   |  15 -
 include/dt-bindings/clock/loongson,ls1x-clk.h |  19 ++
 11 files changed, 368 insertions(+), 276 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/loongson,ls1x-clk.yaml
 create mode 100644 drivers/clk/clk-loongson1.c
 delete mode 100644 drivers/clk/loongson1/Makefile
 delete mode 100644 drivers/clk/loongson1/clk-loongson1b.c
 delete mode 100644 drivers/clk/loongson1/clk-loongson1c.c
 delete mode 100644 drivers/clk/loongson1/clk.c
 delete mode 100644 drivers/clk/loongson1/clk.h
 create mode 100644 include/dt-bindings/clock/loongson,ls1x-clk.h


base-commit: 6f173737e1b5670c200329677e821cce1d3d755e
-- 
2.34.1

