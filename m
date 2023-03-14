Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973046B8E99
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCNJX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjCNJXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:23:51 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6B481CE1;
        Tue, 14 Mar 2023 02:23:41 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so19713673pjb.3;
        Tue, 14 Mar 2023 02:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678785821;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkRcazuJb7v9nTIQ0dhQR/wIjE8fenM+pHebExHfSRc=;
        b=gDFXjIIIBxk2rJLz6BEGVWRZGsY0bEHGcvQtoBp9I0YSbhTwhuzE4loJTzLmLMA1d3
         YzwiWWsJw7t2R3r39B/Ny0SwHfhP5vywYBCfuyZZDHV56KddrQlh90Y7Z1MOyjDV/XSK
         W3rdzBR/KrF8lRu5DQmtd01Dn//M3xIDf/iFMDGVnVE7tYC3NzMxJQcklE52wFB4OR88
         yNd9dMyngc5sQeMhK655/nTL50O9fQwqFfMFGvkFeyzJvIGo6ufBLe0k1qfmKHo4c5ig
         Bg4BFzP2oZV5dRc0OJVrVmCxgWV0slzuU8YEusvOqHxN5DmW3FldGQxrB2cvfrBbt6/d
         i7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678785821;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkRcazuJb7v9nTIQ0dhQR/wIjE8fenM+pHebExHfSRc=;
        b=xjoJEjKqqzZMYGIW5hGW9FjkMx6KzAL5OKd8h1Mu9Q1dWFcrVkRo12379yqSY+iycj
         QZCpqbS5Zn48CI9If9bGHT6RN8YTbE9jTDjSkMY4SGxLQtJyKQHh9hUH9hVb0WbJ/vM9
         yCPMO+atCvCsDzC3MCCBulytXfEnLyACb4pt29QOQyOQSlzC43Z5QkH1fOzoOlMpFpI8
         sj4FHVj8m31r6M4NOFNJ2UqsbwIGt0ukd3koEyaL5/pOy5j52YkEbhEu02dicAvxePDt
         7PvI39eIxreP3Ra9x9gE3xcBydRKSK96vKMu1tbUct8ptpjeCwZQMxwbOh90DpukE5ZB
         Wycw==
X-Gm-Message-State: AO0yUKXXCh1KETe5MGlhioeZKDJgM5TTBKc0TBl/ueJfwD07YvQ8Gqfw
        jB2eOCuhERvKgWi7tdXh44b8omVBD+Q=
X-Google-Smtp-Source: AK7set9CmVYYHzcHXn+3N7OGiHWr47DueIgz3FHgT31XfMbtEpFH52tbv+yXIF0e5GGnYiFDYxPy6A==
X-Received: by 2002:a05:6a20:8e0a:b0:c7:6a98:5bd8 with SMTP id y10-20020a056a208e0a00b000c76a985bd8mr23210905pzj.0.1678785820982;
        Tue, 14 Mar 2023 02:23:40 -0700 (PDT)
Received: from localhost.localdomain ([1.200.129.193])
        by smtp.gmail.com with ESMTPSA id f21-20020aa782d5000000b00592626fe48csm1120898pfn.122.2023.03.14.02.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 02:23:40 -0700 (PDT)
From:   Jim Liu <jim.t90615@gmail.com>
To:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, jim.t90615@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v5 0/3]Add Nuvoton NPCM SGPIO feature
Date:   Tue, 14 Mar 2023 17:23:08 +0800
Message-Id: <20230314092311.8924-1-jim.t90615@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This SGPIO controller is for NUVOTON NPCM7xx and NPCM8xx SoC.
Nuvoton NPCM SGPIO module is combine serial to parallel IC (HC595)
and parallel to serial IC (HC165), and use APB3 clock to control it.
This interface has 4 pins  (D_out , D_in, S_CLK, LDSH).
NPCM7xx/NPCM8xx have two sgpio module each module can support up
to 64 output pins,and up to 64 input pin, the pin is only for gpi or gpo.
GPIO pins have sequential, First half is gpo and second half is gpi.


Jim Liu (3):
  gpio: nuvoton: Add Nuvoton NPCM sgpio driver
  arm: dts: nuvoton: npcm: Add sgpio feature
  dt-bindings: gpio: add NPCM sgpio driver bindings

 .../bindings/gpio/nuvoton,sgpio.yaml          |  87 +++
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |  30 +
 drivers/gpio/Kconfig                          |   8 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-npcm-sgpio.c                | 648 ++++++++++++++++++
 5 files changed, 774 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
 create mode 100644 drivers/gpio/gpio-npcm-sgpio.c

-- 
2.17.1

