Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3F36AA857
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 07:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjCDGfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 01:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDGfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 01:35:01 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2685A14206;
        Fri,  3 Mar 2023 22:35:01 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so4348714pjp.2;
        Fri, 03 Mar 2023 22:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677911700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T048gzoendUKibWZ/X4Bm8MewyYs5DGrcTS2K/kI5RM=;
        b=mMIKequIHtyoUjxlB2vJ53dSAHvde+tQxQDdv9453hMKFzvYUuPhfY5mQXiQt4eO81
         9Mqq2t26NXyYPwYC1NI4y4QrcA/kN5kMzaLqlHQDh5HqIvtU0TMnVKQ3XafAKNxtHvEL
         hlgBBGamRp0G4irRa1IwSGtlpVbeJ6Sidy4dDgWC3eI6viS2Qu1WfaBWccszAtK2EvzF
         ghjB1812x1fLdCAJAAfBkiqgB+k+DbNooKKwbGYNmLnb9MQPkh8KzlA9UblqJ0XXxO8S
         COZ/NZXfTmlpvn0Z7wQyCduOsbxt5/XssMxWkKicuUIr+2L1cDcRFJsqTKbaJr7JTU3e
         asaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677911700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T048gzoendUKibWZ/X4Bm8MewyYs5DGrcTS2K/kI5RM=;
        b=gZhZN4HRBrij4Y9baeVH+NFtzF3g6YYXtL0xpNOI9tg0TvQyToU326EgporN16a0EP
         PEmZdWPY6nYncHjvsPriBykLvI8zYZy2RtUDgxqRvX4DnoBjayHQq2hbwNSqh2a4gpKa
         2iqrwkzeRp/+m6Bnc5mIUSnlMJBCFwWdAeUYrpCRvJECRU5aua38O3YS0OfArX57TYy+
         XqfzbWfwdRMRL7RKvGAny8ElAejlQvQKxVDnoxQmEqg9F59LZH+v+gE1IKvy6kr+KSK8
         cnaeggqOK91K1r0GLUw+rmmvov2U3vF5LcjrCktyg4/5Y9OuvgZy1EcDCVpWh4+rLmOs
         ZxjA==
X-Gm-Message-State: AO0yUKXUHROLNwfdPIkm6zG/9mYfBzimQlZrEm9Oo9y7jS4wKUrJgDN9
        wg0D0Bw4LAxjLSaQaRLeV5SKKH/wkoZKtqSYFxs=
X-Google-Smtp-Source: AK7set9cG9ev50caKlxkvaeq+6LssDjwP6FKoLXGJLBQo2DEG1KhoeSr0XAUOj56LdEYPXFW3duQBg==
X-Received: by 2002:a17:903:18d:b0:19a:eb93:6165 with SMTP id z13-20020a170903018d00b0019aeb936165mr6196097plg.22.1677911700543;
        Fri, 03 Mar 2023 22:35:00 -0800 (PST)
Received: from y.ha.lan ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b0019aa6bf4450sm2520938plg.188.2023.03.03.22.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 22:35:00 -0800 (PST)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] Add CRG driver for Hi3798MV100 SoC
Date:   Sat,  4 Mar 2023 14:33:22 +0800
Message-Id: <20230304063333.162309-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
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

This series adds CRG driver for Hi3798MV100 SoC.

v2: move bindings to a separate patch

David Yang (6):
  clk: hisilicon: Rename Hi3798CV200 to Hi3798
  clk: hisilicon: Extract common functions
  dt-bindings: clock: Add Hi3798MV100 CRG driver binding
  clk: hisilicon: Rename some symbols for Hi3798CV200
  clk: hisilicon: Add inner clocks for Hi3798MV100
  clk: hisilicon: Add CRG driver for Hi3798MV100 SoC

 .../devicetree/bindings/clock/hisi-crg.txt    |   2 +
 drivers/clk/hisilicon/Kconfig                 |   6 +-
 drivers/clk/hisilicon/Makefile                |   2 +-
 drivers/clk/hisilicon/crg-hi3798.c            | 612 ++++++++++++++++++
 drivers/clk/hisilicon/crg-hi3798cv200.c       | 401 ------------
 include/dt-bindings/clock/histb-clock.h       |  10 +
 6 files changed, 628 insertions(+), 405 deletions(-)
 create mode 100644 drivers/clk/hisilicon/crg-hi3798.c
 delete mode 100644 drivers/clk/hisilicon/crg-hi3798cv200.c

-- 
2.39.2

