Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3722607FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiJUUiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJUUiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:38:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFD32995FA;
        Fri, 21 Oct 2022 13:38:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3351EB80D4D;
        Fri, 21 Oct 2022 20:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4D5C433D6;
        Fri, 21 Oct 2022 20:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666384688;
        bh=EMXTC8vxkKjdXgI+eVCKU+wJJGSmqfnG+k4tjBrTLY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rFPYccdJ+D+uatVE0VZ4rCzv0fqkgoUjRX9i1za8ayafI/8PmoBtf6CTJKSvF3XeZ
         ijsSOkPKHTxx2HCyhQb9lpa16CNeu088akUeFtBSHgsRw1WyfzVCI2qjIhcmv0LMon
         Vjls1F/MVDzaf55PWVTa3kCvUVECEV4l2VivghnMoweP4h0kNrJZhDK2OKQrM+C22p
         /Y+adC/4FCrBjdfaNLq9YmNxFohyIvgVoH3GAGbP8Z8vtvbY1ziqZ8tYuCgSR5JYdG
         Qx9CHw1fiXKETZFNAKb9/Jcl5JD1l/V6Biq6Fqs1oieFIysVWOdNL08f9ug5FSjTUg
         LR6kn/fvj7cfw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kwangwoo Lee <kwangwoo.lee@gmail.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Darius Augulis <augulis.darius@gmail.com>,
        Maurus Cuelenaere <mcuelenaere@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 03/21] ARM: s3c: remove most s3c64xx board support
Date:   Fri, 21 Oct 2022 22:27:36 +0200
Message-Id: <20221021203329.4143397-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221021202254.4142411-1-arnd@kernel.org>
References: <20221021202254.4142411-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

All traditional board files except for MACH_WLF_CRAGG_6410 were
marked as unused, so remove them now.

Cc: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Darius Augulis <augulis.darius@gmail.com>
Cc: Maurus Cuelenaere <mcuelenaere@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c/Kconfig.s3c64xx         | 206 -------
 arch/arm/mach-s3c/Makefile.s3c64xx        |  13 -
 arch/arm/mach-s3c/dev-backlight-s3c64xx.c | 137 -----
 arch/arm/mach-s3c/mach-anw6410.c          | 230 -------
 arch/arm/mach-s3c/mach-hmt.c              | 282 ---------
 arch/arm/mach-s3c/mach-mini6410.c         | 365 -----------
 arch/arm/mach-s3c/mach-ncp.c              | 100 ---
 arch/arm/mach-s3c/mach-real6410.c         | 333 ----------
 arch/arm/mach-s3c/mach-smartq.c           | 424 -------------
 arch/arm/mach-s3c/mach-smartq.h           |  16 -
 arch/arm/mach-s3c/mach-smartq5.c          | 154 -----
 arch/arm/mach-s3c/mach-smartq7.c          | 170 ------
 arch/arm/mach-s3c/mach-smdk6400.c         |  90 ---
 arch/arm/mach-s3c/mach-smdk6410.c         | 706 ----------------------
 14 files changed, 3226 deletions(-)
 delete mode 100644 arch/arm/mach-s3c/dev-backlight-s3c64xx.c
 delete mode 100644 arch/arm/mach-s3c/mach-anw6410.c
 delete mode 100644 arch/arm/mach-s3c/mach-hmt.c
 delete mode 100644 arch/arm/mach-s3c/mach-mini6410.c
 delete mode 100644 arch/arm/mach-s3c/mach-ncp.c
 delete mode 100644 arch/arm/mach-s3c/mach-real6410.c
 delete mode 100644 arch/arm/mach-s3c/mach-smartq.c
 delete mode 100644 arch/arm/mach-s3c/mach-smartq.h
 delete mode 100644 arch/arm/mach-s3c/mach-smartq5.c
 delete mode 100644 arch/arm/mach-s3c/mach-smartq7.c
 delete mode 100644 arch/arm/mach-s3c/mach-smdk6400.c
 delete mode 100644 arch/arm/mach-s3c/mach-smdk6410.c

diff --git a/arch/arm/mach-s3c/Kconfig.s3c64xx b/arch/arm/mach-s3c/Kconfig.s3c64xx
index 0c1b91c3ac5f..0da214c43fba 100644
--- a/arch/arm/mach-s3c/Kconfig.s3c64xx
+++ b/arch/arm/mach-s3c/Kconfig.s3c64xx
@@ -54,17 +54,6 @@ config S3C64XX_SETUP_SDHCI
 	  Internal configuration for default SDHCI setup for S3C6400 and
 	  S3C6410 SoCs.
 
-config S3C64XX_DEV_ONENAND1
-	bool
-	help
-	  Compile in platform device definition for OneNAND1 controller
-
-config SAMSUNG_DEV_BACKLIGHT
-	bool
-	depends on SAMSUNG_DEV_PWM
-	help
-	  Compile in platform device definition LCD backlight with PWM Timer
-
 # platform specific device setup
 
 config S3C64XX_SETUP_I2C0
@@ -113,201 +102,6 @@ config S3C64XX_SETUP_USB_PHY
 
 # S36400 Macchine support
 
-config MACH_SMDK6400
-	bool "SMDK6400"
-	depends on ATAGS && UNUSED_BOARD_FILES
-	select CPU_S3C6400
-	select S3C64XX_SETUP_SDHCI
-	select S3C_DEV_HSMMC1
-	help
-	  Machine support for the Samsung SMDK6400
-
-# S3C6410 machine support
-
-config MACH_ANW6410
-	bool "A&W6410"
-	depends on ATAGS && UNUSED_BOARD_FILES
-	select CPU_S3C6410
-	select S3C64XX_SETUP_FB_24BPP
-	select S3C_DEV_FB
-	help
-	  Machine support for the A&W6410
-
-config MACH_MINI6410
-	bool "MINI6410"
-	depends on ATAGS && UNUSED_BOARD_FILES
-	select CPU_S3C6410
-	select S3C64XX_SETUP_FB_24BPP
-	select S3C64XX_SETUP_SDHCI
-	select S3C_DEV_FB
-	select S3C_DEV_HSMMC
-	select S3C_DEV_HSMMC1
-	select S3C_DEV_NAND
-	select S3C_DEV_USB_HOST
-	select SAMSUNG_DEV_ADC
-	select SAMSUNG_DEV_TS
-	help
-	  Machine support for the FriendlyARM MINI6410
-
-config MACH_REAL6410
-	bool "REAL6410"
-	depends on ATAGS && UNUSED_BOARD_FILES
-	select CPU_S3C6410
-	select S3C64XX_SETUP_FB_24BPP
-	select S3C64XX_SETUP_SDHCI
-	select S3C_DEV_FB
-	select S3C_DEV_HSMMC
-	select S3C_DEV_HSMMC1
-	select S3C_DEV_NAND
-	select S3C_DEV_USB_HOST
-	select SAMSUNG_DEV_ADC
-	select SAMSUNG_DEV_TS
-	help
-	  Machine support for the CoreWind REAL6410
-
-config MACH_SMDK6410
-	bool "SMDK6410"
-	depends on ATAGS && UNUSED_BOARD_FILES
-	select CPU_S3C6410
-	select S3C64XX_SETUP_FB_24BPP
-	select S3C64XX_SETUP_I2C1
-	select S3C64XX_SETUP_IDE
-	select S3C64XX_SETUP_KEYPAD
-	select S3C64XX_SETUP_SDHCI
-	select S3C64XX_SETUP_USB_PHY
-	select S3C_DEV_FB
-	select S3C_DEV_HSMMC
-	select S3C_DEV_HSMMC1
-	select S3C_DEV_I2C1
-	select S3C_DEV_RTC
-	select S3C_DEV_USB_HOST
-	select S3C_DEV_USB_HSOTG
-	select S3C_DEV_WDT
-	select SAMSUNG_DEV_ADC
-	select SAMSUNG_DEV_BACKLIGHT
-	select SAMSUNG_DEV_IDE
-	select SAMSUNG_DEV_KEYPAD
-	select SAMSUNG_DEV_PWM
-	select SAMSUNG_DEV_TS
-	help
-	  Machine support for the Samsung SMDK6410
-
-# At least some of the SMDK6410s were shipped with the card detect
-# for the MMC/SD slots connected to the same input. This means that
-# either the boards need to be altered to have channel0 to an alternate
-# configuration or that only one slot can be used.
-
-choice
-	prompt "SMDK6410 MMC/SD slot setup"
-	depends on MACH_SMDK6410
-
-config SMDK6410_SD_CH0
-	bool "Use channel 0 only"
-	depends on MACH_SMDK6410
-	help
-	  Select CON7 (channel 0) as the MMC/SD slot, as
-	  at least some SMDK6410 boards come with the
-	  resistors fitted so that the card detects for
-	  channels 0 and 1 are the same.
-
-config SMDK6410_SD_CH1
-	bool "Use channel 1 only"
-	depends on MACH_SMDK6410
-	help
-	  Select CON6 (channel 1) as the MMC/SD slot, as
-	  at least some SMDK6410 boards come with the
-	  resistors fitted so that the card detects for
-	  channels 0 and 1 are the same.
-
-endchoice
-
-config SMDK6410_WM1190_EV1
-	bool "Support Wolfson Microelectronics 1190-EV1 PMIC card"
-	depends on MACH_SMDK6410
-	depends on I2C=y
-	select MFD_WM8350_I2C
-	select REGULATOR
-	select REGULATOR_WM8350
-	help
-	  The Wolfson Microelectronics 1190-EV1 is a WM835x based PMIC
-	  and audio daughtercard for the Samsung SMDK6410 reference
-	  platform.  Enabling this option will build support for this
-	  module into the kernel.  The presence of the module will be
-	  detected at runtime so the resulting kernel can be used
-	  with or without the 1190-EV1 fitted.
-
-config SMDK6410_WM1192_EV1
-	bool "Support Wolfson Microelectronics 1192-EV1 PMIC card"
-	depends on MACH_SMDK6410
-	depends on I2C=y
-	select MFD_WM831X
-	select MFD_WM831X_I2C
-	select REGULATOR
-	select REGULATOR_WM831X
-	help
-	  The Wolfson Microelectronics 1192-EV1 is a WM831x based PMIC
-	  daughtercard for the Samsung SMDK6410 reference platform.
-	  Enabling this option will build support for this module into
-	  the kernel.  The presence of the daughtercard will be
-	  detected at runtime so the resulting kernel can be used
-	  with or without the 1192-EV1 fitted.
-
-config MACH_NCP
-	bool "NCP"
-	depends on ATAGS && UNUSED_BOARD_FILES
-	select CPU_S3C6410
-	select S3C64XX_SETUP_I2C1
-	select S3C_DEV_HSMMC1
-	select S3C_DEV_I2C1
-	help
-	  Machine support for the Samsung NCP
-
-config MACH_HMT
-	bool "Airgoo HMT"
-	depends on ATAGS && UNUSED_BOARD_FILES
-	select CPU_S3C6410
-	select S3C64XX_SETUP_FB_24BPP
-	select S3C_DEV_FB
-	select S3C_DEV_NAND
-	select S3C_DEV_USB_HOST
-	select SAMSUNG_DEV_PWM
-	help
-	  Machine support for the Airgoo HMT
-
-config MACH_SMARTQ
-	bool
-	select CPU_S3C6410
-	select S3C64XX_SETUP_FB_24BPP
-	select S3C64XX_SETUP_SDHCI
-	select S3C64XX_SETUP_USB_PHY
-	select S3C_DEV_FB
-	select S3C_DEV_HSMMC
-	select S3C_DEV_HSMMC1
-	select S3C_DEV_HSMMC2
-	select S3C_DEV_HWMON
-	select S3C_DEV_RTC
-	select S3C_DEV_USB_HOST
-	select S3C_DEV_USB_HSOTG
-	select SAMSUNG_DEV_ADC
-	select SAMSUNG_DEV_PWM
-	select SAMSUNG_DEV_TS
-	help
-	  Shared machine support for SmartQ 5/7
-
-config MACH_SMARTQ5
-	bool "SmartQ 5"
-	depends on ATAGS && UNUSED_BOARD_FILES
-	select MACH_SMARTQ
-	help
-	  Machine support for the SmartQ 5
-
-config MACH_SMARTQ7
-	bool "SmartQ 7"
-	depends on ATAGS && UNUSED_BOARD_FILES
-	select MACH_SMARTQ
-	help
-	  Machine support for the SmartQ 7
-
 config MACH_WLF_CRAGG_6410
 	bool "Wolfson Cragganmore 6410"
 	depends on ATAGS
diff --git a/arch/arm/mach-s3c/Makefile.s3c64xx b/arch/arm/mach-s3c/Makefile.s3c64xx
index 21e919bf2cd1..ba179a22c2af 100644
--- a/arch/arm/mach-s3c/Makefile.s3c64xx
+++ b/arch/arm/mach-s3c/Makefile.s3c64xx
@@ -39,20 +39,7 @@ obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio-s3c64xx.o
 obj-$(CONFIG_S3C64XX_SETUP_SPI)		+= setup-spi-s3c64xx.o
 obj-$(CONFIG_S3C64XX_SETUP_USB_PHY) += setup-usb-phy-s3c64xx.o
 
-obj-$(CONFIG_SAMSUNG_DEV_BACKLIGHT)	+= dev-backlight-s3c64xx.o
-
 # Machine support
-
-obj-$(CONFIG_MACH_ANW6410)		+= mach-anw6410.o
-obj-$(CONFIG_MACH_HMT)			+= mach-hmt.o
-obj-$(CONFIG_MACH_MINI6410)		+= mach-mini6410.o
-obj-$(CONFIG_MACH_NCP)			+= mach-ncp.o
-obj-$(CONFIG_MACH_REAL6410)		+= mach-real6410.o
-obj-$(CONFIG_MACH_SMARTQ)		+= mach-smartq.o
-obj-$(CONFIG_MACH_SMARTQ5)		+= mach-smartq5.o
-obj-$(CONFIG_MACH_SMARTQ7)		+= mach-smartq7.o
-obj-$(CONFIG_MACH_SMDK6400)		+= mach-smdk6400.o
-obj-$(CONFIG_MACH_SMDK6410)		+= mach-smdk6410.o
 obj-$(CONFIG_MACH_WLF_CRAGG_6410)	+= mach-crag6410.o mach-crag6410-module.o
 endif
 
diff --git a/arch/arm/mach-s3c/dev-backlight-s3c64xx.c b/arch/arm/mach-s3c/dev-backlight-s3c64xx.c
deleted file mode 100644
index 65488b61e50c..000000000000
diff --git a/arch/arm/mach-s3c/mach-anw6410.c b/arch/arm/mach-s3c/mach-anw6410.c
deleted file mode 100644
index b67eae43e04f..000000000000
diff --git a/arch/arm/mach-s3c/mach-hmt.c b/arch/arm/mach-s3c/mach-hmt.c
deleted file mode 100644
index 49ba16c447aa..000000000000
diff --git a/arch/arm/mach-s3c/mach-mini6410.c b/arch/arm/mach-s3c/mach-mini6410.c
deleted file mode 100644
index 058ae9e8b89f..000000000000
diff --git a/arch/arm/mach-s3c/mach-ncp.c b/arch/arm/mach-s3c/mach-ncp.c
deleted file mode 100644
index 1e65f8bce5c4..000000000000
diff --git a/arch/arm/mach-s3c/mach-real6410.c b/arch/arm/mach-s3c/mach-real6410.c
deleted file mode 100644
index 8c10ebc38a9c..000000000000
diff --git a/arch/arm/mach-s3c/mach-smartq.c b/arch/arm/mach-s3c/mach-smartq.c
deleted file mode 100644
index 5b6e7c2a85ef..000000000000
diff --git a/arch/arm/mach-s3c/mach-smartq.h b/arch/arm/mach-s3c/mach-smartq.h
deleted file mode 100644
index f98132f4f430..000000000000
diff --git a/arch/arm/mach-s3c/mach-smartq5.c b/arch/arm/mach-s3c/mach-smartq5.c
deleted file mode 100644
index ce3fce0bba20..000000000000
diff --git a/arch/arm/mach-s3c/mach-smartq7.c b/arch/arm/mach-s3c/mach-smartq7.c
deleted file mode 100644
index 78ca0e704797..000000000000
diff --git a/arch/arm/mach-s3c/mach-smdk6400.c b/arch/arm/mach-s3c/mach-smdk6400.c
deleted file mode 100644
index a3c1b2a82455..000000000000
diff --git a/arch/arm/mach-s3c/mach-smdk6410.c b/arch/arm/mach-s3c/mach-smdk6410.c
deleted file mode 100644
index e57b2bb61484..000000000000
-- 
2.29.2

