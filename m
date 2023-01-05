Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE7F65EDC1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjAENsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbjAENr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:47:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BC53D9DF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:47:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1A35B81AE4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 13:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47060C433D2;
        Thu,  5 Jan 2023 13:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926442;
        bh=PXqOv0LctzShAq7q8kG4dABXJIY3SUF939BAdbcjLEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ua1EpTbehUxbw/Ic9Uz2vQyvyrsKyksmt2Vyi6cGfsesz04RTE1JtjsR6+uyc2Azn
         8H5rIZWotkUqE3CIPIDVSm067bcRneXSmmp1vypSuIlUOSFaypLq2giJmi/5ml5M8s
         6kANTUb/T1tq3Q+oVgz84jtAU+QaaMyEEEN7Y822FWonHiGfmC1H6m6noj1gRRyvk/
         bNPhkjK6FVLLAR2aGLBIZ7WgG6pC29njQXqjw/ge90WKxQazqmixXbeeXi1sX8AzeN
         VIM1rWPwJkSfbIlDcDy3Bwyv+lUrckDwX2L8saGzh0jxKQMY7rsxtx1YWs4V/30/Cy
         bCJ5Uc7cWgsWA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Ian Molton <spyro@f2s.com>,
        Ken McGuire <kenm@desertweyr.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH 15/27] ASoC: pxa: remove unused board support
Date:   Thu,  5 Jan 2023 14:46:10 +0100
Message-Id: <20230105134622.254560-16-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105134622.254560-1-arnd@kernel.org>
References: <20230105134622.254560-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Most PXA/MMP boards were removed, so the board specific ASoC
support is no longer needed, leaving only support for DT
based ones, as well as the "gumstix" and "spitz" machines
that may get converted to DT later.

Cc: Ian Molton <spyro@f2s.com>
Cc: Ken McGuire <kenm@desertweyr.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/platform_data/asoc-palm27x.h |   9 -
 include/linux/platform_data/asoc-poodle.h  |  16 -
 include/linux/platform_data/mmp_audio.h    |  18 -
 sound/soc/pxa/Kconfig                      | 176 ----------
 sound/soc/pxa/Makefile                     |  33 --
 sound/soc/pxa/brownstone.c                 | 133 --------
 sound/soc/pxa/corgi.c                      | 332 -------------------
 sound/soc/pxa/e740_wm9705.c                | 168 ----------
 sound/soc/pxa/e750_wm9705.c                | 147 ---------
 sound/soc/pxa/e800_wm9712.c                | 147 ---------
 sound/soc/pxa/em-x270.c                    |  92 ------
 sound/soc/pxa/hx4700.c                     | 207 ------------
 sound/soc/pxa/magician.c                   | 366 ---------------------
 sound/soc/pxa/mioa701_wm9713.c             | 201 -----------
 sound/soc/pxa/mmp-pcm.c                    | 267 ---------------
 sound/soc/pxa/palm27x.c                    | 162 ---------
 sound/soc/pxa/poodle.c                     | 291 ----------------
 sound/soc/pxa/tosa.c                       | 255 --------------
 sound/soc/pxa/ttc-dkb.c                    | 143 --------
 sound/soc/pxa/z2.c                         | 218 ------------
 sound/soc/pxa/zylonite.c                   | 266 ---------------
 21 files changed, 3647 deletions(-)
 delete mode 100644 include/linux/platform_data/asoc-palm27x.h
 delete mode 100644 include/linux/platform_data/asoc-poodle.h
 delete mode 100644 include/linux/platform_data/mmp_audio.h
 delete mode 100644 sound/soc/pxa/brownstone.c
 delete mode 100644 sound/soc/pxa/corgi.c
 delete mode 100644 sound/soc/pxa/e740_wm9705.c
 delete mode 100644 sound/soc/pxa/e750_wm9705.c
 delete mode 100644 sound/soc/pxa/e800_wm9712.c
 delete mode 100644 sound/soc/pxa/em-x270.c
 delete mode 100644 sound/soc/pxa/hx4700.c
 delete mode 100644 sound/soc/pxa/magician.c
 delete mode 100644 sound/soc/pxa/mioa701_wm9713.c
 delete mode 100644 sound/soc/pxa/mmp-pcm.c
 delete mode 100644 sound/soc/pxa/palm27x.c
 delete mode 100644 sound/soc/pxa/poodle.c
 delete mode 100644 sound/soc/pxa/tosa.c
 delete mode 100644 sound/soc/pxa/ttc-dkb.c
 delete mode 100644 sound/soc/pxa/z2.c
 delete mode 100644 sound/soc/pxa/zylonite.c

diff --git a/include/linux/platform_data/asoc-palm27x.h b/include/linux/platform_data/asoc-palm27x.h
deleted file mode 100644
index 22b69a393a57..000000000000
diff --git a/include/linux/platform_data/asoc-poodle.h b/include/linux/platform_data/asoc-poodle.h
deleted file mode 100644
index 2052fad55c5c..000000000000
diff --git a/include/linux/platform_data/mmp_audio.h b/include/linux/platform_data/mmp_audio.h
deleted file mode 100644
index 83428d8ee18d..000000000000
diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 2036d368c08d..e6bca9070953 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -8,10 +8,6 @@ config SND_PXA2XX_SOC
 	  the PXA2xx AC97, I2S or SSP interface. You will also need
 	  to select the audio interfaces to support below.
 
-config SND_MMP_SOC
-	bool
-	select MMP_SRAM
-
 config SND_PXA2XX_AC97
 	tristate
 
@@ -44,15 +40,6 @@ config SND_MMP_SOC_SSPA
 	  Say Y if you want to add support for codecs attached to
 	  the MMP SSPA interface.
 
-config SND_PXA2XX_SOC_CORGI
-	tristate "SoC Audio support for Sharp Zaurus SL-C7x0"
-	depends on SND_PXA2XX_SOC && PXA_SHARP_C7xx && I2C
-	select SND_PXA2XX_SOC_I2S
-	select SND_SOC_WM8731_I2C
-	help
-	  Say Y if you want to add support for SoC audio on Sharp
-	  Zaurus SL-C7x0 models (Corgi, Shepherd, Husky).
-
 config SND_PXA2XX_SOC_SPITZ
 	tristate "SoC Audio support for Sharp Zaurus SL-Cxx00"
 	depends on SND_PXA2XX_SOC && PXA_SHARP_Cxx00 && I2C
@@ -62,101 +49,6 @@ config SND_PXA2XX_SOC_SPITZ
 	  Say Y if you want to add support for SoC audio on Sharp
 	  Zaurus SL-Cxx00 models (Spitz, Borzoi and Akita).
 
-config SND_PXA2XX_SOC_Z2
-	tristate "SoC Audio support for Zipit Z2"
-	depends on SND_PXA2XX_SOC && MACH_ZIPIT2 && I2C
-	select SND_PXA2XX_SOC_I2S
-	select SND_SOC_WM8750
-	help
-	  Say Y if you want to add support for SoC audio on Zipit Z2.
-
-config SND_PXA2XX_SOC_POODLE
-	tristate "SoC Audio support for Poodle"
-	depends on SND_PXA2XX_SOC && MACH_POODLE && I2C
-	select SND_PXA2XX_SOC_I2S
-	select SND_SOC_WM8731_I2C
-	help
-	  Say Y if you want to add support for SoC audio on Sharp
-	  Zaurus SL-5600 model (Poodle).
-
-config SND_PXA2XX_SOC_TOSA
-	tristate "SoC AC97 Audio support for Tosa"
-	depends on SND_PXA2XX_SOC && MACH_TOSA
-	depends on MFD_TC6393XB
-	depends on AC97_BUS=n
-	select REGMAP
-	select AC97_BUS_NEW
-	select AC97_BUS_COMPAT
-	select SND_PXA2XX_SOC_AC97
-	select SND_SOC_WM9712
-	help
-	  Say Y if you want to add support for SoC audio on Sharp
-	  Zaurus SL-C6000x models (Tosa).
-
-config SND_PXA2XX_SOC_E740
-	tristate "SoC AC97 Audio support for e740"
-	depends on SND_PXA2XX_SOC && MACH_E740
-	depends on AC97_BUS=n
-	select REGMAP
-	select AC97_BUS_NEW
-	select AC97_BUS_COMPAT
-	select SND_SOC_WM9705
-	select SND_PXA2XX_SOC_AC97
-	help
-	  Say Y if you want to add support for SoC audio on the
-	  toshiba e740 PDA
-
-config SND_PXA2XX_SOC_E750
-	tristate "SoC AC97 Audio support for e750"
-	depends on SND_PXA2XX_SOC && MACH_E750
-	depends on AC97_BUS=n
-	select REGMAP
-	select SND_SOC_WM9705
-	select SND_PXA2XX_SOC_AC97
-	help
-	  Say Y if you want to add support for SoC audio on the
-	  toshiba e750 PDA
-
-config SND_PXA2XX_SOC_E800
-	tristate "SoC AC97 Audio support for e800"
-	depends on SND_PXA2XX_SOC && MACH_E800
-	depends on AC97_BUS=n
-	select REGMAP
-	select SND_SOC_WM9712
-	select AC97_BUS_NEW
-	select AC97_BUS_COMPAT
-	select SND_PXA2XX_SOC_AC97
-	help
-	  Say Y if you want to add support for SoC audio on the
-	  Toshiba e800 PDA
-
-config SND_PXA2XX_SOC_EM_X270
-	tristate "SoC Audio support for CompuLab CM-X300"
-	depends on SND_PXA2XX_SOC && MACH_CM_X300
-	depends on AC97_BUS=n
-	select REGMAP
-	select AC97_BUS_NEW
-	select AC97_BUS_COMPAT
-	select SND_PXA2XX_SOC_AC97
-	select SND_SOC_WM9712
-	help
-	  Say Y if you want to add support for SoC audio on
-	  CompuLab EM-x270, eXeda and CM-X300 machines.
-
-config SND_PXA2XX_SOC_PALM27X
-	bool "SoC Audio support for Palm T|X, T5, E2 and LifeDrive"
-	depends on SND_PXA2XX_SOC && (MACH_PALMLD || MACH_PALMTX || \
-			MACH_PALMT5 || MACH_PALMTE2)
-	depends on AC97_BUS=n
-	select REGMAP
-	select AC97_BUS_NEW
-	select AC97_BUS_COMPAT
-	select SND_PXA2XX_SOC_AC97
-	select SND_SOC_WM9712
-	help
-	  Say Y if you want to add support for SoC audio on
-	  Palm T|X, T5, E2 or LifeDrive handheld computer.
-
 config SND_PXA910_SOC
 	tristate "SoC Audio for Marvell PXA910 chip"
 	depends on ARCH_MMP && SND
@@ -164,71 +56,3 @@ config SND_PXA910_SOC
 	help
 	  Say Y if you want to add support for SoC audio on the
 	  Marvell PXA910 reference platform.
-
-config SND_SOC_TTC_DKB
-	tristate "SoC Audio support for TTC DKB"
-	depends on SND_PXA910_SOC && MACH_TTC_DKB && I2C=y
-	select PXA_SSP
-	select SND_PXA_SOC_SSP
-	select SND_MMP_SOC
-	select MFD_88PM860X
-	select SND_SOC_88PM860X
-	help
-	  Say Y if you want to add support for SoC audio on TTC DKB
-
-
-config SND_SOC_ZYLONITE
-	tristate "SoC Audio support for Marvell Zylonite"
-	depends on SND_PXA2XX_SOC && MACH_ZYLONITE
-	depends on AC97_BUS=n
-	select AC97_BUS_NEW
-	select AC97_BUS_COMPAT
-	select SND_PXA2XX_SOC_AC97
-	select REGMAP
-	select SND_PXA_SOC_SSP
-	select SND_SOC_WM9713
-	help
-	  Say Y if you want to add support for SoC audio on the
-	  Marvell Zylonite reference platform.
-
-config SND_PXA2XX_SOC_HX4700
-	tristate "SoC Audio support for HP iPAQ hx4700"
-	depends on SND_PXA2XX_SOC && MACH_H4700 && I2C
-	select SND_PXA2XX_SOC_I2S
-	select SND_SOC_AK4641
-	help
-	  Say Y if you want to add support for SoC audio on the
-	  HP iPAQ hx4700.
-
-config SND_PXA2XX_SOC_MAGICIAN
-	tristate "SoC Audio support for HTC Magician"
-	depends on SND_PXA2XX_SOC && MACH_MAGICIAN && I2C
-	select SND_PXA2XX_SOC_I2S
-	select SND_PXA_SOC_SSP
-	select SND_SOC_UDA1380
-	help
-	  Say Y if you want to add support for SoC audio on the
-	  HTC Magician.
-
-config SND_PXA2XX_SOC_MIOA701
-	tristate "SoC Audio support for MIO A701"
-	depends on SND_PXA2XX_SOC && MACH_MIOA701
-	depends on AC97_BUS=n
-	select REGMAP
-	select AC97_BUS_NEW
-	select AC97_BUS_COMPAT
-	select SND_PXA2XX_SOC_AC97
-	select SND_SOC_WM9713
-	help
-	  Say Y if you want to add support for SoC audio on the
-	  MIO A701.
-
-config SND_MMP_SOC_BROWNSTONE
-	tristate "SoC Audio support for Marvell Brownstone"
-	depends on SND_MMP_SOC_SSPA && MACH_BROWNSTONE && I2C
-	select SND_MMP_SOC
-	select MFD_WM8994
-	select SND_SOC_WM8994
-	help
-	  Say Y if you want to add support for SoC audio on the
-	  Marvell Brownstone reference platform.
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index b712eb894a61..406605fc7414 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -4,47 +4,14 @@ snd-soc-pxa2xx-objs := pxa2xx-pcm.o
 snd-soc-pxa2xx-ac97-objs := pxa2xx-ac97.o
 snd-soc-pxa2xx-i2s-objs := pxa2xx-i2s.o
 snd-soc-pxa-ssp-objs := pxa-ssp.o
-snd-soc-mmp-objs := mmp-pcm.o
 snd-soc-mmp-sspa-objs := mmp-sspa.o
 
 obj-$(CONFIG_SND_PXA2XX_SOC) += snd-soc-pxa2xx.o
 obj-$(CONFIG_SND_PXA2XX_SOC_AC97) += snd-soc-pxa2xx-ac97.o
 obj-$(CONFIG_SND_PXA2XX_SOC_I2S) += snd-soc-pxa2xx-i2s.o
 obj-$(CONFIG_SND_PXA_SOC_SSP) += snd-soc-pxa-ssp.o
-obj-$(CONFIG_SND_MMP_SOC) += snd-soc-mmp.o
 obj-$(CONFIG_SND_MMP_SOC_SSPA) += snd-soc-mmp-sspa.o
 
 # PXA Machine Support
-snd-soc-corgi-objs := corgi.o
-snd-soc-poodle-objs := poodle.o
-snd-soc-tosa-objs := tosa.o
-snd-soc-e740-objs := e740_wm9705.o
-snd-soc-e750-objs := e750_wm9705.o
-snd-soc-e800-objs := e800_wm9712.o
 snd-soc-spitz-objs := spitz.o
-snd-soc-em-x270-objs := em-x270.o
-snd-soc-palm27x-objs := palm27x.o
-snd-soc-zylonite-objs := zylonite.o
-snd-soc-hx4700-objs := hx4700.o
-snd-soc-magician-objs := magician.o
-snd-soc-mioa701-objs := mioa701_wm9713.o
-snd-soc-z2-objs := z2.o
-snd-soc-brownstone-objs := brownstone.o
-snd-soc-ttc-dkb-objs := ttc-dkb.o
-
-obj-$(CONFIG_SND_PXA2XX_SOC_CORGI) += snd-soc-corgi.o
-obj-$(CONFIG_SND_PXA2XX_SOC_POODLE) += snd-soc-poodle.o
-obj-$(CONFIG_SND_PXA2XX_SOC_TOSA) += snd-soc-tosa.o
-obj-$(CONFIG_SND_PXA2XX_SOC_E740) += snd-soc-e740.o
-obj-$(CONFIG_SND_PXA2XX_SOC_E750) += snd-soc-e750.o
-obj-$(CONFIG_SND_PXA2XX_SOC_E800) += snd-soc-e800.o
 obj-$(CONFIG_SND_PXA2XX_SOC_SPITZ) += snd-soc-spitz.o
-obj-$(CONFIG_SND_PXA2XX_SOC_EM_X270) += snd-soc-em-x270.o
-obj-$(CONFIG_SND_PXA2XX_SOC_PALM27X) += snd-soc-palm27x.o
-obj-$(CONFIG_SND_PXA2XX_SOC_HX4700) += snd-soc-hx4700.o
-obj-$(CONFIG_SND_PXA2XX_SOC_MAGICIAN) += snd-soc-magician.o
-obj-$(CONFIG_SND_PXA2XX_SOC_MIOA701) += snd-soc-mioa701.o
-obj-$(CONFIG_SND_PXA2XX_SOC_Z2) += snd-soc-z2.o
-obj-$(CONFIG_SND_SOC_ZYLONITE) += snd-soc-zylonite.o
-obj-$(CONFIG_SND_MMP_SOC_BROWNSTONE) += snd-soc-brownstone.o
-obj-$(CONFIG_SND_SOC_TTC_DKB) += snd-soc-ttc-dkb.o
diff --git a/sound/soc/pxa/brownstone.c b/sound/soc/pxa/brownstone.c
deleted file mode 100644
index f310a8e91bbf..000000000000
diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
deleted file mode 100644
index 4489d2c8b124..000000000000
diff --git a/sound/soc/pxa/e740_wm9705.c b/sound/soc/pxa/e740_wm9705.c
deleted file mode 100644
index 4e0e9b778d4c..000000000000
diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
deleted file mode 100644
index 7a1e0d8bfd11..000000000000
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
deleted file mode 100644
index a39c494127cf..000000000000
diff --git a/sound/soc/pxa/em-x270.c b/sound/soc/pxa/em-x270.c
deleted file mode 100644
index b59ec22e1e7e..000000000000
diff --git a/sound/soc/pxa/hx4700.c b/sound/soc/pxa/hx4700.c
deleted file mode 100644
index a323ddb8fc3e..000000000000
diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
deleted file mode 100644
index b791a2ba5ce5..000000000000
diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
deleted file mode 100644
index 0fa37637eca9..000000000000
diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
deleted file mode 100644
index 99b245e3079a..000000000000
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
deleted file mode 100644
index a2321c01c160..000000000000
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
deleted file mode 100644
index 5fdaa477e85d..000000000000
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
deleted file mode 100644
index 30f83cab0c32..000000000000
diff --git a/sound/soc/pxa/ttc-dkb.c b/sound/soc/pxa/ttc-dkb.c
deleted file mode 100644
index 6cc970bb2aac..000000000000
diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
deleted file mode 100644
index 020dcce1df1f..000000000000
diff --git a/sound/soc/pxa/zylonite.c b/sound/soc/pxa/zylonite.c
deleted file mode 100644
index bb89a53f4ab1..000000000000
-- 
2.39.0

