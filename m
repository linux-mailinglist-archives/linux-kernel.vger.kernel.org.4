Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2FF6F5B82
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 17:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjECPtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 11:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjECPto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 11:49:44 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344994EDC;
        Wed,  3 May 2023 08:49:42 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bc25f0c7dso8367752a12.3;
        Wed, 03 May 2023 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683128980; x=1685720980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tETsKMX2tnbq04Ram2NTU5I+3P2hJGPmdkjf8f881/c=;
        b=bwq4mF86a1xlcBwdEgHnM//lmE25bW8kY7mq8Eb70aT4AHp9XEcNc2xxJEMMo+BZF+
         h69vI0Rv6ZI7k1KSct6jgHgdlm2XcaueyEPNZ23QW+PWXx5O8aPQ4oRoqbrMaXlxVGe7
         4+rDF68hndvDqTQBamKpCUVEo0BzIDqvWjiAvZ9L+xBuruZEz7MRaoTwTpiiW+0OOQUA
         ZczI/V74JVrpKhKHBVsrr8wGMtxA5DEhNDqZ4L6iGY/tOciOanl4GuzidfeWbC6DvZ+I
         HYUouuAoEIQ5qv5aDZ3DPNsOcpLurqJ6UmjJk31fTP+Mo5jvBiduwoH8StlXxYCzykBm
         RrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683128980; x=1685720980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tETsKMX2tnbq04Ram2NTU5I+3P2hJGPmdkjf8f881/c=;
        b=B/tVznjPLb+LKujDtPa/5/P7bTI8kir5XTRwxsh5XieJ+FjEo0Z/aYSzBB96kE9NC/
         hmQp9LPktJMCRQvP3QstWO2Zx3yV3WSOQaYGUj4Q0NoP4ETuZxmjrPB7gnxvrl8ihqmZ
         D8fdfeNrcgW6b+XTCNABDBY8t+NrDr+Wo73wjGtDZR07syeCKsy8n2XbQzyhrpQjPYXG
         tLiruuQgao/+0pXdqjjXCCOkhvJnDG82BMFGVwbBdSD1KesW+rjTEnLGUgl6BTIhvM9y
         yXyLlKzT8uex41jZcSPbspqKPCMQbk25BKuywnfqwhhVi8rep04mpb64z80olVmw8JSZ
         Nbng==
X-Gm-Message-State: AC+VfDwD9J/rqwja2rpilC4tDbGBR6H5yYDM6EYOFoXAob+xxPjO+iu/
        VRC3rdKkKF262s1o3OsiUUI=
X-Google-Smtp-Source: ACHHUZ6pzgR3ME9djQJDyipBlhiBL37NkjvADP9CwcpHZSnhBZ2fgGFwJhb4NmnG9qP4MCUNOuxJrg==
X-Received: by 2002:a17:906:ee86:b0:958:cc8:bd55 with SMTP id wt6-20020a170906ee8600b009580cc8bd55mr3755739ejb.0.1683128980422;
        Wed, 03 May 2023 08:49:40 -0700 (PDT)
Received: from localhost (p200300e41f053a00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f05:3a00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id gx11-20020a1709068a4b00b0094f225c0cd3sm17328106ejc.86.2023.05.03.08.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 08:49:40 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v6.4-rc1
Date:   Wed,  3 May 2023 17:49:36 +0200
Message-Id: <20230503154936.1824529-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 1271a7b98e7989ba6bb978e14403fc84efe16e13:

  pwm: Zero-initialize the pwm_state passed to driver's .get_state() (2023-03-23 14:44:43 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.4-rc1

for you to fetch changes up to 247ee6c780406513c6031a7f4ea41f1648b03295:

  pwm: Remove unused radix tree (2023-04-14 11:35:52 +0200)

This is based on top of the v6.3 fixes pull from a few weeks ago.
Interestingly this brings to a close a journey (legacy API removal)
that I set out on back when I took over maintenance. It's hard to
believe that that was over 11 years ago. I hadn't thought it would
take that long. Thanks to Uwe for helping to get this across the
finish line.

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v6.4-rc1

The bulk of this is trivial conversions to the new .remove_new()
callback for drivers as part of Uwe's effort to clean that up.

Other than that a driver is added for Apple devices and various small
fixes are included for existing drivers.

Last but not least, this finally gets rid of the old pwm_request() and
pwm_free() APIs are removed since the last user was dropped in v6.3.

----------------------------------------------------------------
AngeloGioacchino Del Regno (2):
      pwm: mtk-disp: Disable shadow registers before setting backlight values
      pwm: mtk-disp: Configure double buffering before reading in .get_state()

Daniel Golle (1):
      dt-bindings: pwm: mediatek: Add mediatek,mt7986 compatible

Heiner Kallweit (3):
      dt-bindings: pwm: Convert Amlogic Meson PWM binding
      pwm: meson: Fix axg ao mux parents
      pwm: meson: Fix g12a ao clk81 name

Krzysztof Kozlowski (2):
      pwm: rcar: Drop of_match_ptr for ID table
      pwm: stm32-lp: Drop of_match_ptr for ID table

Olivier Moysan (1):
      pwm: stm32: Enforce settings for PWM capture

Sasha Finkelstein (3):
      dt-bindings: pwm: Add Apple PWM controller
      pwm: Add Apple PWM controller
      MAINTAINERS: Add entries for Apple PWM driver

Thierry Reding (2):
      Merge branch 'fixes' into for-next
      pwm: Remove unused radix tree

Uwe Kleine-König (31):
      pwm: atmel-hlcdc: Convert to platform remove callback returning void
      pwm: atmel-tcb: Convert to platform remove callback returning void
      pwm: atmel: Convert to platform remove callback returning void
      pwm: bcm-iproc: Convert to platform remove callback returning void
      pwm: bcm2835: Convert to platform remove callback returning void
      pwm: berlin: Convert to platform remove callback returning void
      pwm: brcmstb: Convert to platform remove callback returning void
      pwm: clk: Convert to platform remove callback returning void
      pwm: cros-ec: Convert to platform remove callback returning void
      pwm: hibvt: Convert to platform remove callback returning void
      pwm: img: Convert to platform remove callback returning void
      pwm: imx-tpm: Convert to platform remove callback returning void
      pwm: lpc18xx-sct: Convert to platform remove callback returning void
      pwm: lpss-platform: Convert to platform remove callback returning void
      pwm: mtk-disp: Convert to platform remove callback returning void
      pwm: omap-dmtimer: Convert to platform remove callback returning void
      pwm: rcar: Convert to platform remove callback returning void
      pwm: rockchip: Convert to platform remove callback returning void
      pwm: samsung: Convert to platform remove callback returning void
      pwm: sifive: Convert to platform remove callback returning void
      pwm: spear: Convert to platform remove callback returning void
      pwm: sprd: Convert to platform remove callback returning void
      pwm: sti: Convert to platform remove callback returning void
      pwm: stm32: Convert to platform remove callback returning void
      pwm: sun4i: Convert to platform remove callback returning void
      pwm: tegra: Convert to platform remove callback returning void
      pwm: tiecap: Convert to platform remove callback returning void
      pwm: tiehrpwm: Convert to platform remove callback returning void
      pwm: vt8500: Convert to platform remove callback returning void
      pwm: xilinx: Convert to platform remove callback returning void
      pwm: Delete deprecated functions pwm_request() and pwm_free()

 .../devicetree/bindings/pwm/apple,s5l-fpwm.yaml    |  51 +++++++
 .../bindings/pwm/mediatek,mt2712-pwm.yaml          |   1 +
 .../devicetree/bindings/pwm/pwm-amlogic.yaml       |  70 +++++++++
 .../devicetree/bindings/pwm/pwm-meson.txt          |  29 ----
 Documentation/driver-api/pwm.rst                   |  13 +-
 MAINTAINERS                                        |   2 +
 drivers/pwm/Kconfig                                |  12 ++
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 |  71 +--------
 drivers/pwm/pwm-apple.c                            | 159 +++++++++++++++++++++
 drivers/pwm/pwm-atmel-hlcdc.c                      |   6 +-
 drivers/pwm/pwm-atmel-tcb.c                        |   6 +-
 drivers/pwm/pwm-atmel.c                            |   6 +-
 drivers/pwm/pwm-bcm-iproc.c                        |   6 +-
 drivers/pwm/pwm-bcm2835.c                          |   6 +-
 drivers/pwm/pwm-berlin.c                           |   6 +-
 drivers/pwm/pwm-brcmstb.c                          |   6 +-
 drivers/pwm/pwm-clk.c                              |   6 +-
 drivers/pwm/pwm-cros-ec.c                          |   6 +-
 drivers/pwm/pwm-hibvt.c                            |   6 +-
 drivers/pwm/pwm-img.c                              |   6 +-
 drivers/pwm/pwm-imx-tpm.c                          |   6 +-
 drivers/pwm/pwm-lpc18xx-sct.c                      |   6 +-
 drivers/pwm/pwm-lpss-platform.c                    |   5 +-
 drivers/pwm/pwm-meson.c                            |   6 +-
 drivers/pwm/pwm-mtk-disp.c                         |  40 ++++--
 drivers/pwm/pwm-omap-dmtimer.c                     |   6 +-
 drivers/pwm/pwm-rcar.c                             |   8 +-
 drivers/pwm/pwm-rockchip.c                         |   6 +-
 drivers/pwm/pwm-samsung.c                          |   6 +-
 drivers/pwm/pwm-sifive.c                           |   6 +-
 drivers/pwm/pwm-spear.c                            |   6 +-
 drivers/pwm/pwm-sprd.c                             |   6 +-
 drivers/pwm/pwm-sti.c                              |   6 +-
 drivers/pwm/pwm-stm32-lp.c                         |   2 +-
 drivers/pwm/pwm-stm32.c                            |  10 +-
 drivers/pwm/pwm-sun4i.c                            |   6 +-
 drivers/pwm/pwm-tegra.c                            |   6 +-
 drivers/pwm/pwm-tiecap.c                           |   6 +-
 drivers/pwm/pwm-tiehrpwm.c                         |   6 +-
 drivers/pwm/pwm-vt8500.c                           |   6 +-
 drivers/pwm/pwm-xilinx.c                           |   5 +-
 include/linux/mfd/stm32-timers.h                   |   1 +
 include/linux/pwm.h                                |  13 --
 44 files changed, 397 insertions(+), 252 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-meson.txt
 create mode 100644 drivers/pwm/pwm-apple.c
