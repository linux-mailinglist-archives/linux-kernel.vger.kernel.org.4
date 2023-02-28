Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734176A5ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 15:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjB1O07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 09:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjB1O05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 09:26:57 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FEE1BC9;
        Tue, 28 Feb 2023 06:26:56 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j3so6551739wms.2;
        Tue, 28 Feb 2023 06:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/tq/zszDMcZ/q4+NmurCt/9UiLLyD1boBQYOIvlny1E=;
        b=OdqxhqK9TLRXQDeY4kvDV/5/PNlSSqSsW2dwVR+wcKiNh6ED+N5Pivk06LtJSAUEIp
         HBHOpsrBWvtvvfZIcS6NE2/kfIlMUOMrWDGcIS7lRoK03bSTRGCnMBHqQHtF7zhOU+gS
         cwkK1G0jE2aJS3NggWztmSS9fiJ29IQV4pafrpTZwU79uPOCnJmszgZgEYx2R58DeDBc
         NUdVPJ2Ii3FLICIm7kII4x26XxPxo/kxix9ecmc39zEuQMVN5gYMS5/CWU8iw4nhwWkK
         lTERhbJJJ62ASK3dMr0ZJ2U0g8jLXFh5ZnLmcBhcoNQ8mKW75kLH3SD06z+3GcoYE0OC
         SMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/tq/zszDMcZ/q4+NmurCt/9UiLLyD1boBQYOIvlny1E=;
        b=o1phTk/xod5GbQl3E6bCafoqNySZuuZNpLiNVThTIEzA1hI9IUcTf6mF1/HyeOqYJ2
         oBGS8YdmB3wOVZLBlQQTDtxoABN4D0yQIE0NPw6pPrFHVIRPa9NL+kjVcZ4nlhIhsr8R
         F9wiEaX4/fVMasWEeTA5XHJK9Px55M3MV0aRQKHL5h7sDiFF18sXaKL47t2AFPoVsu8P
         13vfCPJB53Ep4U1RywAIzM3PQTSEr8/+n7rt1H6+FsqWv9IdeGZYl1Lnbj/rF6NERIkc
         x9qEBG2vdlU6BJFu7Pw0O4YFdbHsCpOdQL5JmboySs+Rnvs+XDPZJXdGtrjHDyB274A5
         Hkfw==
X-Gm-Message-State: AO0yUKUneY2GTHFNEA/ws53e6rrDe24mouatP36E8KyxX4q3oJDhFxzx
        IE24/kdagiega2JoLYMgHCc=
X-Google-Smtp-Source: AK7set/Njfuc3yKOHWNK5KXQxBrJfvz/OT7fbh+EXYFYdrzRcEvWk4rSnTHuKLQTu25xMxoXo8xxRA==
X-Received: by 2002:a05:600c:a293:b0:3eb:3e24:59e2 with SMTP id hu19-20020a05600ca29300b003eb3e2459e2mr2258301wmb.25.1677594414614;
        Tue, 28 Feb 2023 06:26:54 -0800 (PST)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id bi22-20020a05600c3d9600b003dc42d48defsm12822098wmb.6.2023.02.28.06.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 06:26:54 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v6.3-rc1
Date:   Tue, 28 Feb 2023 15:26:51 +0100
Message-Id: <20230228142651.3839023-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Linus,

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.3-rc1

for you to fetch changes up to cf70d01a62c712ee715df1f7892b58c77474bcfb:

  pwm: dwc: Use devm_pwmchip_add() (2023-02-20 12:26:35 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v6.3-rc1

This rather small set of changes includes some minor fixes and
improvements. The AB8500 driver gained support for reading the initial
hardware state and the Synopsys DesignWare driver received some work to
prepare for device tree and platform support.

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      dt-bindings: pwm: mediatek: Convert pwm-mediatek to DT schema

Ben Dooks (4):
      dt-bindings: pwm: Document Synopsys DesignWare snps,pwm-dw-apb-timers-pwm2
      pwm: dwc: Change &pci->dev to dev in probe
      pwm: dwc: Move memory allocation to own function
      pwm: dwc: Use devm_pwmchip_add()

Emil Renner Berthing (1):
      pwm: sifive: Always let the first pwm_apply_state succeed

Fabrice Gasnier (1):
      pwm: stm32-lp: fix the check on arr and cmp registers update

Geert Uytterhoeven (1):
      pwm: Move pwm_capture() dummy to restore order

Jeff LaBundy (1):
      pwm: iqs620a: Replace one remaining instance of regmap_update_bits()

Uwe Kleine-König (3):
      pwm: lp3943: Drop unused i2c include
      pwm: ab8500: Fix calculation of duty and period
      pwm: ab8500: Implement .get_state()

 .../bindings/pwm/mediatek,mt2712-pwm.yaml          |  93 +++++++++++++++++
 .../devicetree/bindings/pwm/pwm-mediatek.txt       |  52 ----------
 .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml      |  68 +++++++++++++
 drivers/pwm/pwm-ab8500.c                           | 112 +++++++++++++++++++--
 drivers/pwm/pwm-dwc.c                              |  38 +++----
 drivers/pwm/pwm-iqs620a.c                          |   4 +-
 drivers/pwm/pwm-lp3943.c                           |   1 -
 drivers/pwm/pwm-sifive.c                           |   8 +-
 drivers/pwm/pwm-stm32-lp.c                         |   2 +-
 include/linux/pwm.h                                |  14 +--
 10 files changed, 302 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
