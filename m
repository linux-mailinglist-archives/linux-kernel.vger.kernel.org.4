Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A7B652F07
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbiLUJ6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbiLUJ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:57:56 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D302E2330D;
        Wed, 21 Dec 2022 01:53:03 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id m21so10746966edc.3;
        Wed, 21 Dec 2022 01:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oj+ZK3/L1t/Bik0ZdQdR6nSS40R6NxUejB4tVSPhHV0=;
        b=Oah5VuGCZtF4gNDGjzK/tEU5QDQdg9En2tMucfllm80hKMn+BqLvmyDOmLVqnQ06vU
         3JX4J/KK3meD6sYLfmsCsIExBGW/bY/zcpAjK652U0o56aE+ikktpfZfqydi3ZpF+Pcs
         DCi37ARvpUOtUJjgnX6JBvKRM2oMC3+xh36qYa9AHD4QuZlzNvMNOCa60ROUO9nOl5jn
         nLfwmzN4qMZFB3Q97CypJ8tTto3vZmqZ2w5xipy+KjG8Pzvxkgd0Qdgt/ktyVXIWG6YZ
         hEeJTbgnYcnqP0erZtoRtOqPJTv4JWVtA3X36uDOrAj4TBbfbG9v7/JvWjn09LilPEQ/
         MMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oj+ZK3/L1t/Bik0ZdQdR6nSS40R6NxUejB4tVSPhHV0=;
        b=52IDGHBr+cyonwxAfxfkGGCKmozSPMAr1OnYhM7Cws0VC0pf4k5jSIR1doHSpi2jG2
         +6uIqCgpqa+cOw653+gmuTeeVTd4GyPwGXT3qafBY9ZRsmVtREifFcsbrbxgyGOe1GHy
         RZEI6uU3z/OYVToL1ZUG6A8iIx434a8Vwf5woqTzCt1ImQyNCh2UHfAtE980WWmMKI3/
         EfK4p3sJv9W1uV5gMEDb/O384OtmPozdrlHMFQvrVlq5zZrgLpJiKmM9eyygR4jp02E+
         /p8OmhvTkxTGay+5XaCvgrdESBwYoT95NsoxeJMWmXo8ipE792ovzg7NOlX5gkp7Keaz
         wDGw==
X-Gm-Message-State: AFqh2koYgetD0HJJ5muFEcJiDzLL0hXiYcoJRGgI2TSY2zv+Q5WHCZLN
        smTXCdS9CbzMAHaPweBTKnt29EkpxuM=
X-Google-Smtp-Source: AMrXdXtGc83AfaO+vwtsYai2XDmV5ufjF4p6zv2MY57G7ew5elGpEI2v2VWe0mhUlLhp4pHYfvAQsQ==
X-Received: by 2002:a05:6402:3998:b0:46b:203:f388 with SMTP id fk24-20020a056402399800b0046b0203f388mr5824167edb.39.1671616382290;
        Wed, 21 Dec 2022 01:53:02 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id dm4-20020a05640222c400b004589da5e5cesm6821209edb.41.2022.12.21.01.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 01:53:01 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v6.2-rc1
Date:   Wed, 21 Dec 2022 10:52:58 +0100
Message-Id: <20221221095258.952766-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
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

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.2-rc1

for you to fetch changes up to 8fa22f4b88e877c0811d2a0e506cf56755add554:

  pwm: pca9685: Convert to i2c's .probe_new() (2022-12-06 12:46:31 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v6.2-rc1

Various changes across the board, mostly improvements and cleanups.

----------------------------------------------------------------
Andre Przywara (1):
      pwm: sun4i: Propagate errors in .get_state() to the caller

Andy Shevchenko (1):
      pwm: core: Remove S_IFREG from debugfs_create_file()

Daniel Golle (2):
      pwm: mediatek: always use bus clock for PWM on MT7622
      pwm: mediatek: Add support for MT7986

Doug Brown (6):
      pwm: pxa: Remove pxa_pwm_enable/disable
      pwm: pxa: Set duty cycle to 0 when disabling PWM
      pwm: pxa: Remove clk enable/disable from pxa_pwm_config
      pwm: pxa: Use abrupt shutdown mode
      pwm: pxa: Add reference manual link and limitations
      pwm: pxa: Enable for MMP platform

Geert Uytterhoeven (2):
      dt-bindings: pwm: renesas,pwm-rcar: Add r8a779g0 support
      dt-bindings: pwm: renesas,tpu: Add r8a779g0 support

Jon Hunter (2):
      pwm: tegra: Improve required rate calculation
      pwm: tegra: Ensure the clock rate is not less than needed

Paul Cercueil (3):
      pwm: jz4740: Force dependency on Device Tree
      pwm: jz4740: Depend on MACH_INGENIC instead of MIPS
      pwm: jz4740: Use regmap_{set,clear}_bits

Steven Price (1):
      pwm: tegra: Fix 32 bit build

Uwe Kleine-König (23):
      pwm: sifive: Call pwm_sifive_update_clock() while mutex is held
      pwm: lpc18xx-sct: Fix a comment to match code
      pwm: Document variables protected by pwm_lock
      pwm: Reduce time the pwm_lock mutex is held in pwmchip_add()
      pwm: Mark free pwm IDs as used in alloc_pwms()
      pwm: Don't initialize list head before calling list_add()
      pwm: fsl-ftm: Use regmap_clear_bits and regmap_set_bits where applicable
      pwm: img: Use regmap_clear_bits and regmap_set_bits where applicable
      pwm: iqs620a: Use regmap_clear_bits and regmap_set_bits where applicable
      pwm: stm32-lp: Use regmap_clear_bits and regmap_set_bits where applicable
      pwm: stm32: Use regmap_clear_bits and regmap_set_bits where applicable
      pwm: Make .get_state() callback return an error code
      pwm/tracing: Also record trace events for failed API calls
      drm/bridge: ti-sn65dsi86: Propagate errors in .get_state() to the caller
      leds: qcom-lpg: Propagate errors in .get_state() to the caller
      pwm: crc: Propagate errors in .get_state() to the caller
      pwm: cros-ec: Propagate errors in .get_state() to the caller
      pwm: imx27: Propagate errors in .get_state() to the caller
      pwm: mtk-disp: Propagate errors in .get_state() to the caller
      pwm: rockchip: Propagate errors in .get_state() to the caller
      pwm: sprd: Propagate errors in .get_state() to the caller
      pwm: Handle .get_state() failures
      pwm: pca9685: Convert to i2c's .probe_new()

xinlei lee (1):
      pwm: mtk-disp: Fix the parameters calculated by the enabled flag of disp_pwm

 .../devicetree/bindings/pwm/renesas,pwm-rcar.yaml  |  1 +
 .../devicetree/bindings/pwm/renesas,tpu-pwm.yaml   |  1 +
 drivers/gpio/gpio-mvebu.c                          |  9 ++-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              | 14 +++--
 drivers/leds/rgb/leds-qcom-lpg.c                   | 14 +++--
 drivers/pwm/Kconfig                                |  6 +-
 drivers/pwm/core.c                                 | 68 ++++++++++++----------
 drivers/pwm/pwm-atmel.c                            |  6 +-
 drivers/pwm/pwm-bcm-iproc.c                        |  8 ++-
 drivers/pwm/pwm-crc.c                              | 10 ++--
 drivers/pwm/pwm-cros-ec.c                          |  8 ++-
 drivers/pwm/pwm-dwc.c                              |  6 +-
 drivers/pwm/pwm-fsl-ftm.c                          | 18 +++---
 drivers/pwm/pwm-hibvt.c                            |  6 +-
 drivers/pwm/pwm-img.c                              | 15 +++--
 drivers/pwm/pwm-imx-tpm.c                          |  8 ++-
 drivers/pwm/pwm-imx27.c                            |  8 ++-
 drivers/pwm/pwm-intel-lgm.c                        |  6 +-
 drivers/pwm/pwm-iqs620a.c                          | 10 ++--
 drivers/pwm/pwm-jz4740.c                           | 20 +++----
 drivers/pwm/pwm-keembay.c                          |  6 +-
 drivers/pwm/pwm-lpc18xx-sct.c                      |  2 +-
 drivers/pwm/pwm-lpss.c                             |  6 +-
 drivers/pwm/pwm-mediatek.c                         |  9 ++-
 drivers/pwm/pwm-meson.c                            |  8 ++-
 drivers/pwm/pwm-mtk-disp.c                         | 17 +++---
 drivers/pwm/pwm-pca9685.c                          | 13 +++--
 drivers/pwm/pwm-pxa.c                              | 58 ++++++++----------
 drivers/pwm/pwm-raspberrypi-poe.c                  |  8 ++-
 drivers/pwm/pwm-rockchip.c                         | 12 ++--
 drivers/pwm/pwm-sifive.c                           | 11 +++-
 drivers/pwm/pwm-sl28cpld.c                         |  8 ++-
 drivers/pwm/pwm-sprd.c                             |  8 ++-
 drivers/pwm/pwm-stm32-lp.c                         | 13 +++--
 drivers/pwm/pwm-stm32.c                            | 34 +++++------
 drivers/pwm/pwm-sun4i.c                            | 14 +++--
 drivers/pwm/pwm-sunplus.c                          |  6 +-
 drivers/pwm/pwm-tegra.c                            | 15 ++++-
 drivers/pwm/pwm-visconti.c                         |  6 +-
 drivers/pwm/pwm-xilinx.c                           |  8 ++-
 include/linux/pwm.h                                |  4 +-
 include/trace/events/pwm.h                         | 20 +++----
 42 files changed, 299 insertions(+), 229 deletions(-)
