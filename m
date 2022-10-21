Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E117760805D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiJUUyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiJUUyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:54:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC7D2582F4;
        Fri, 21 Oct 2022 13:54:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F3A7CCE2B9F;
        Fri, 21 Oct 2022 20:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB03C4314D;
        Fri, 21 Oct 2022 20:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666385648;
        bh=GREUXMczQux4RH5vwxHKXsUql623TGianvEPo8hFJuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yp78RVKRTufhpNjf10sOOcm/K0r2DcJso+mY4iotIHm9YHQMK6y2RoAtbP4V4KuvQ
         vEq8K6SaKuJwkVQb6pK9fqyUiQdFLRJyAxK7eXQMrT1y9654b/lIHl/Lw7n1Qk7RW2
         Vokn7LtnXT3VeCN5F8TdkI2sNUVTt3aboKQuuhZ2rmd+Igb0nhIKmt/lg2ge8dZHyE
         rcZVz9xqo/SKKSL9WAORK7/0uWqjkaO3Gm5yL6TuFSD9PMOEs12TTim8vdIIx0JUxs
         CrKaOaFn5ACGJku/AMi+A6jpzjRu659R0K02k/TuQq+UQNT4G9nTLi9bEsnK/UQjCa
         2qAWCoBGIj5dw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 21/21] ASoC: samsung: remove unused drivers
Date:   Fri, 21 Oct 2022 22:27:54 +0200
Message-Id: <20221021203329.4143397-21-arnd@kernel.org>
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

The s3c24xx SoC platform was completely removed, as were most of the
s3c64xx based board files, leaving only the DT based machines as well
as the MACH_WLF_CRAGG_6410 machine. All other board specific ASoC
driver can can now be recycled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../linux/platform_data/asoc-s3c24xx_simtec.h |  30 -
 include/sound/s3c24xx_uda134x.h               |  14 -
 sound/soc/samsung/Kconfig                     |  93 ---
 sound/soc/samsung/Makefile                    |  26 -
 sound/soc/samsung/h1940_uda1380.c             | 224 ------
 sound/soc/samsung/jive_wm8750.c               | 143 ----
 sound/soc/samsung/neo1973_wm8753.c            | 360 ----------
 sound/soc/samsung/regs-i2s-v2.h               | 111 ---
 sound/soc/samsung/regs-iis.h                  |  66 --
 sound/soc/samsung/rx1950_uda1380.c            | 245 -------
 sound/soc/samsung/s3c-i2s-v2.c                | 670 ------------------
 sound/soc/samsung/s3c-i2s-v2.h                | 108 ---
 sound/soc/samsung/s3c2412-i2s.c               | 251 -------
 sound/soc/samsung/s3c2412-i2s.h               |  22 -
 sound/soc/samsung/s3c24xx-i2s.c               | 463 ------------
 sound/soc/samsung/s3c24xx-i2s.h               |  31 -
 sound/soc/samsung/s3c24xx_simtec.c            | 372 ----------
 sound/soc/samsung/s3c24xx_simtec.h            |  18 -
 sound/soc/samsung/s3c24xx_simtec_hermes.c     | 112 ---
 .../soc/samsung/s3c24xx_simtec_tlv320aic23.c  | 100 ---
 sound/soc/samsung/s3c24xx_uda134x.c           | 257 -------
 sound/soc/samsung/smartq_wm8987.c             | 224 ------
 sound/soc/samsung/smdk_wm8580.c               | 211 ------
 23 files changed, 4151 deletions(-)
 delete mode 100644 include/linux/platform_data/asoc-s3c24xx_simtec.h
 delete mode 100644 include/sound/s3c24xx_uda134x.h
 delete mode 100644 sound/soc/samsung/h1940_uda1380.c
 delete mode 100644 sound/soc/samsung/jive_wm8750.c
 delete mode 100644 sound/soc/samsung/neo1973_wm8753.c
 delete mode 100644 sound/soc/samsung/regs-i2s-v2.h
 delete mode 100644 sound/soc/samsung/regs-iis.h
 delete mode 100644 sound/soc/samsung/rx1950_uda1380.c
 delete mode 100644 sound/soc/samsung/s3c-i2s-v2.c
 delete mode 100644 sound/soc/samsung/s3c-i2s-v2.h
 delete mode 100644 sound/soc/samsung/s3c2412-i2s.c
 delete mode 100644 sound/soc/samsung/s3c2412-i2s.h
 delete mode 100644 sound/soc/samsung/s3c24xx-i2s.c
 delete mode 100644 sound/soc/samsung/s3c24xx-i2s.h
 delete mode 100644 sound/soc/samsung/s3c24xx_simtec.c
 delete mode 100644 sound/soc/samsung/s3c24xx_simtec.h
 delete mode 100644 sound/soc/samsung/s3c24xx_simtec_hermes.c
 delete mode 100644 sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
 delete mode 100644 sound/soc/samsung/s3c24xx_uda134x.c
 delete mode 100644 sound/soc/samsung/smartq_wm8987.c
 delete mode 100644 sound/soc/samsung/smdk_wm8580.c

diff --git a/include/linux/platform_data/asoc-s3c24xx_simtec.h b/include/linux/platform_data/asoc-s3c24xx_simtec.h
deleted file mode 100644
index 1a7efc98d108..000000000000
diff --git a/include/sound/s3c24xx_uda134x.h b/include/sound/s3c24xx_uda134x.h
deleted file mode 100644
index 0232b80ff486..000000000000
diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 2a61e620cd3b..93c2b1b08d0a 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -11,16 +11,6 @@ menuconfig SND_SOC_SAMSUNG
 
 if SND_SOC_SAMSUNG
 
-config SND_S3C24XX_I2S
-	tristate
-
-config SND_S3C_I2SV2_SOC
-	tristate
-
-config SND_S3C2412_SOC_I2S
-	tristate
-	select SND_S3C_I2SV2_SOC
-
 config SND_SAMSUNG_PCM
 	tristate "Samsung PCM interface support"
 
@@ -31,35 +21,6 @@ config SND_SAMSUNG_SPDIF
 config SND_SAMSUNG_I2S
 	tristate "Samsung I2S interface support"
 
-config SND_SOC_SAMSUNG_NEO1973_WM8753
-	tristate "Audio support for Openmoko Neo1973 Smartphones (GTA02)"
-	depends on MACH_NEO1973_GTA02 || COMPILE_TEST
-	depends on SND_SOC_I2C_AND_SPI
-	select SND_S3C24XX_I2S
-	select SND_SOC_WM8753
-	select SND_SOC_BT_SCO
-	help
-	  Say Y here to enable audio support for the Openmoko Neo1973
-	  Smartphones.
-
-config SND_SOC_SAMSUNG_JIVE_WM8750
-	tristate "SoC I2S Audio support for Jive"
-	depends on MACH_JIVE && I2C || COMPILE_TEST && ARM
-	depends on SND_SOC_I2C_AND_SPI
-	select SND_SOC_WM8750
-	select SND_S3C2412_SOC_I2S
-	help
-	  Say Y if you want to add support for SoC audio on the Jive.
-
-config SND_SOC_SAMSUNG_SMDK_WM8580
-	tristate "SoC I2S Audio support for WM8580 on SMDK"
-	depends on MACH_SMDK6410 || COMPILE_TEST
-	depends on I2C
-	select SND_SOC_WM8580
-	select SND_SAMSUNG_I2S
-	help
-	  Say Y if you want to add support for SoC audio on the SMDKs.
-
 config SND_SOC_SAMSUNG_SMDK_WM8994
 	tristate "SoC I2S Audio support for WM8994 on SMDK"
 	depends on I2C=y
@@ -69,60 +30,6 @@ config SND_SOC_SAMSUNG_SMDK_WM8994
 	help
 		Say Y if you want to add support for SoC audio on the SMDKs.
 
-config SND_SOC_SAMSUNG_S3C24XX_UDA134X
-	tristate "SoC I2S Audio support UDA134X wired to a S3C24XX"
-	depends on ARCH_S3C24XX || COMPILE_TEST
-	select SND_S3C24XX_I2S
-	select SND_SOC_L3
-	select SND_SOC_UDA134X
-
-config SND_SOC_SAMSUNG_SIMTEC
-	tristate
-	help
-	  Internal node for common S3C24XX/Simtec support.
-
-config SND_SOC_SAMSUNG_SIMTEC_TLV320AIC23
-	tristate "SoC I2S Audio support for TLV320AIC23 on Simtec boards"
-	depends on ARCH_S3C24XX || COMPILE_TEST
-	depends on I2C
-	select SND_S3C24XX_I2S
-	select SND_SOC_TLV320AIC23_I2C
-	select SND_SOC_SAMSUNG_SIMTEC
-
-config SND_SOC_SAMSUNG_SIMTEC_HERMES
-	tristate "SoC I2S Audio support for Simtec Hermes board"
-	depends on ARCH_S3C24XX || COMPILE_TEST
-	depends on I2C
-	select SND_S3C24XX_I2S
-	select SND_SOC_TLV320AIC3X
-	select SND_SOC_SAMSUNG_SIMTEC
-
-config SND_SOC_SAMSUNG_H1940_UDA1380
-	tristate "Audio support for the HP iPAQ H1940"
-	depends on ARCH_H1940 || COMPILE_TEST
-	depends on I2C
-	select SND_S3C24XX_I2S
-	select SND_SOC_UDA1380
-	help
-	  This driver provides audio support for HP iPAQ h1940 PDA.
-
-config SND_SOC_SAMSUNG_RX1950_UDA1380
-	tristate "Audio support for the HP iPAQ RX1950"
-	depends on MACH_RX1950 || COMPILE_TEST
-	depends on I2C
-	select SND_S3C24XX_I2S
-	select SND_SOC_UDA1380
-	help
-	  This driver provides audio support for HP iPAQ RX1950 PDA.
-
-config SND_SOC_SMARTQ
-	tristate "SoC I2S Audio support for SmartQ board"
-	depends on MACH_SMARTQ || COMPILE_TEST
-	depends on GPIOLIB || COMPILE_TEST
-	depends on I2C
-	select SND_SAMSUNG_I2S
-	select SND_SOC_WM8750
-
 config SND_SOC_SAMSUNG_SMDK_SPDIF
 	tristate "SoC S/PDIF Audio support for SMDK"
 	select SND_SAMSUNG_SPDIF
diff --git a/sound/soc/samsung/Makefile b/sound/soc/samsung/Makefile
index 398e843f388c..f5d327b90a4e 100644
--- a/sound/soc/samsung/Makefile
+++ b/sound/soc/samsung/Makefile
@@ -2,35 +2,19 @@
 # S3c24XX Platform Support
 snd-soc-s3c-dma-objs := dmaengine.o
 snd-soc-idma-objs := idma.o
-snd-soc-s3c24xx-i2s-objs := s3c24xx-i2s.o
-snd-soc-s3c2412-i2s-objs := s3c2412-i2s.o
-snd-soc-s3c-i2s-v2-objs := s3c-i2s-v2.o
 snd-soc-samsung-spdif-objs := spdif.o
 snd-soc-pcm-objs := pcm.o
 snd-soc-i2s-objs := i2s.o
 
 obj-$(CONFIG_SND_SOC_SAMSUNG) += snd-soc-s3c-dma.o
-obj-$(CONFIG_SND_S3C24XX_I2S) += snd-soc-s3c24xx-i2s.o
-obj-$(CONFIG_SND_S3C2412_SOC_I2S) += snd-soc-s3c2412-i2s.o
-obj-$(CONFIG_SND_S3C_I2SV2_SOC) += snd-soc-s3c-i2s-v2.o
 obj-$(CONFIG_SND_SAMSUNG_SPDIF) += snd-soc-samsung-spdif.o
 obj-$(CONFIG_SND_SAMSUNG_PCM) += snd-soc-pcm.o
 obj-$(CONFIG_SND_SAMSUNG_I2S) += snd-soc-i2s.o
 obj-$(CONFIG_SND_SAMSUNG_I2S) += snd-soc-idma.o
 
 # S3C24XX Machine Support
-snd-soc-jive-wm8750-objs := jive_wm8750.o
-snd-soc-neo1973-wm8753-objs := neo1973_wm8753.o
-snd-soc-s3c24xx-uda134x-objs := s3c24xx_uda134x.o
-snd-soc-s3c24xx-simtec-objs := s3c24xx_simtec.o
-snd-soc-s3c24xx-simtec-hermes-objs := s3c24xx_simtec_hermes.o
-snd-soc-s3c24xx-simtec-tlv320aic23-objs := s3c24xx_simtec_tlv320aic23.o
-snd-soc-h1940-uda1380-objs := h1940_uda1380.o
-snd-soc-rx1950-uda1380-objs := rx1950_uda1380.o
-snd-soc-smdk-wm8580-objs := smdk_wm8580.o
 snd-soc-smdk-wm8994-objs := smdk_wm8994.o
 snd-soc-snow-objs := snow.o
-snd-soc-s3c64xx-smartq-wm8987-objs := smartq_wm8987.o
 snd-soc-smdk-spdif-objs := smdk_spdif.o
 snd-soc-smdk-wm8994pcm-objs := smdk_wm8994pcm.o
 snd-soc-speyside-objs := speyside.o
@@ -44,18 +28,8 @@ snd-soc-tm2-wm5110-objs := tm2_wm5110.o
 snd-soc-aries-wm8994-objs := aries_wm8994.o
 snd-soc-midas-wm1811-objs := midas_wm1811.o
 
-obj-$(CONFIG_SND_SOC_SAMSUNG_JIVE_WM8750) += snd-soc-jive-wm8750.o
-obj-$(CONFIG_SND_SOC_SAMSUNG_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
-obj-$(CONFIG_SND_SOC_SAMSUNG_S3C24XX_UDA134X) += snd-soc-s3c24xx-uda134x.o
-obj-$(CONFIG_SND_SOC_SAMSUNG_SIMTEC) += snd-soc-s3c24xx-simtec.o
-obj-$(CONFIG_SND_SOC_SAMSUNG_SIMTEC_HERMES) += snd-soc-s3c24xx-simtec-hermes.o
-obj-$(CONFIG_SND_SOC_SAMSUNG_SIMTEC_TLV320AIC23) += snd-soc-s3c24xx-simtec-tlv320aic23.o
-obj-$(CONFIG_SND_SOC_SAMSUNG_H1940_UDA1380) += snd-soc-h1940-uda1380.o
-obj-$(CONFIG_SND_SOC_SAMSUNG_RX1950_UDA1380) += snd-soc-rx1950-uda1380.o
-obj-$(CONFIG_SND_SOC_SAMSUNG_SMDK_WM8580) += snd-soc-smdk-wm8580.o
 obj-$(CONFIG_SND_SOC_SAMSUNG_SMDK_WM8994) += snd-soc-smdk-wm8994.o
 obj-$(CONFIG_SND_SOC_SNOW) += snd-soc-snow.o
-obj-$(CONFIG_SND_SOC_SMARTQ) += snd-soc-s3c64xx-smartq-wm8987.o
 obj-$(CONFIG_SND_SOC_SAMSUNG_SMDK_SPDIF) += snd-soc-smdk-spdif.o
 obj-$(CONFIG_SND_SOC_SMDK_WM8994_PCM) += snd-soc-smdk-wm8994pcm.o
 obj-$(CONFIG_SND_SOC_SPEYSIDE) += snd-soc-speyside.o
diff --git a/sound/soc/samsung/h1940_uda1380.c b/sound/soc/samsung/h1940_uda1380.c
deleted file mode 100644
index fa45a54ab18f..000000000000
diff --git a/sound/soc/samsung/jive_wm8750.c b/sound/soc/samsung/jive_wm8750.c
deleted file mode 100644
index 40a85f539509..000000000000
diff --git a/sound/soc/samsung/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
deleted file mode 100644
index e9f2334028bf..000000000000
diff --git a/sound/soc/samsung/regs-i2s-v2.h b/sound/soc/samsung/regs-i2s-v2.h
deleted file mode 100644
index 867984e75709..000000000000
diff --git a/sound/soc/samsung/regs-iis.h b/sound/soc/samsung/regs-iis.h
deleted file mode 100644
index 253e172ad3b6..000000000000
diff --git a/sound/soc/samsung/rx1950_uda1380.c b/sound/soc/samsung/rx1950_uda1380.c
deleted file mode 100644
index abf28321f7d7..000000000000
diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
deleted file mode 100644
index 2b221cb0ed03..000000000000
diff --git a/sound/soc/samsung/s3c-i2s-v2.h b/sound/soc/samsung/s3c-i2s-v2.h
deleted file mode 100644
index 8c6fc0d3d77e..000000000000
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
deleted file mode 100644
index 0579a352961c..000000000000
diff --git a/sound/soc/samsung/s3c2412-i2s.h b/sound/soc/samsung/s3c2412-i2s.h
deleted file mode 100644
index bff2a797cb08..000000000000
diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
deleted file mode 100644
index 7b7bbe007acd..000000000000
diff --git a/sound/soc/samsung/s3c24xx-i2s.h b/sound/soc/samsung/s3c24xx-i2s.h
deleted file mode 100644
index e073e31855d0..000000000000
diff --git a/sound/soc/samsung/s3c24xx_simtec.c b/sound/soc/samsung/s3c24xx_simtec.c
deleted file mode 100644
index 0cc66774b85d..000000000000
diff --git a/sound/soc/samsung/s3c24xx_simtec.h b/sound/soc/samsung/s3c24xx_simtec.h
deleted file mode 100644
index 38d8384755cd..000000000000
diff --git a/sound/soc/samsung/s3c24xx_simtec_hermes.c b/sound/soc/samsung/s3c24xx_simtec_hermes.c
deleted file mode 100644
index ed0d1b8fa2d4..000000000000
diff --git a/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
deleted file mode 100644
index c03d52990267..000000000000
diff --git a/sound/soc/samsung/s3c24xx_uda134x.c b/sound/soc/samsung/s3c24xx_uda134x.c
deleted file mode 100644
index 6272070dcd92..000000000000
diff --git a/sound/soc/samsung/smartq_wm8987.c b/sound/soc/samsung/smartq_wm8987.c
deleted file mode 100644
index 29bf917242fe..000000000000
diff --git a/sound/soc/samsung/smdk_wm8580.c b/sound/soc/samsung/smdk_wm8580.c
deleted file mode 100644
index 78703d095a6f..000000000000
-- 
2.29.2

