Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92555702637
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbjEOHke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjEOHk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:40:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8E9125;
        Mon, 15 May 2023 00:40:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f420618d5bso59866455e9.1;
        Mon, 15 May 2023 00:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684136425; x=1686728425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1PannR/NdG3RrTVN+EGWrTnODPnsXLR6EXQ0H7eh7TU=;
        b=g1FohnEt20m6fBCPGNdPwdwz8xiVt0HHb1H1Jle+zTLXI/UYPHKqkBiFZVZcQ0tnzH
         9vxWA/rHDmuMEOb4h1NoHKH30WMxq6IY5hBLFhMh119eEw/8DAgGWpcbPiXChEamTmg5
         EY31NQ9zpLj7X93r/PmeXmYxcurciQ/aJ76saZ4CJmyMS1MQ0ntIYEAG3dWE49VUPEKV
         XSoAAMXIKr+AXUnkBp4Y+JU/VBOHssRpPzvxNXCrZvfcYqCSV9IWBtMQaCikn4no5lsG
         KCC7DqRF/U+O7ESgZHuPAqDPyNAdBokhIAcJGUgbpZRuLh3zYZgIlOuytTPmsTUhTHAk
         ev2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684136425; x=1686728425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PannR/NdG3RrTVN+EGWrTnODPnsXLR6EXQ0H7eh7TU=;
        b=C3qRyAry+shR5o3ToRjEQ0U+x4UA6ychkieHYMhNSYXwh5/z5YnO2L2MTUQey44q0h
         YBxGumWp6VOgjrscvPF+klkE/0CiPu6ME00dBgRr4ussKszqCSkGUix/fZkmHr/cG8LR
         x1L74JC/xEIl0+fSXL/iFzpRG9bfBMArCG5uMS8wQKwJHJPf1XfCmCok9Yr5fWQ9fA48
         F+ATvSqRGXvwT9GhIqZ4tWrvnVXcIYCBmt5kDl9APvaf49QCOJvstcH27/r8r/sotq5n
         Fckaf7UDlcEQdmpZD4DcrW/6SecOSPFgDa9qivEovy1A9CkdGGTEKr+/5Gj5CpIPQFSj
         0i2w==
X-Gm-Message-State: AC+VfDyeTxCoA9xg2LfCXkpK5NHmotPg8B+tDvQ+jHqybPdXCGD8vTW0
        v2xqh3l6U2aMDBpPLcuQK2Y=
X-Google-Smtp-Source: ACHHUZ5dsZTTbHjnICFG58Kfs4WZypUo7htlBsHihGtVIUTyncpjmmFazB0NSk3DUO8kcgjNkoGAMg==
X-Received: by 2002:a7b:ce0a:0:b0:3f4:239c:f1a with SMTP id m10-20020a7bce0a000000b003f4239c0f1amr17659679wmc.10.1684136424804;
        Mon, 15 May 2023 00:40:24 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id m25-20020a7bcb99000000b003f4f8cc4285sm8622968wmi.17.2023.05.15.00.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 00:40:24 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] ASoC: Add ESS ES9218P codec driver
Date:   Mon, 15 May 2023 08:40:19 +0100
Message-Id: <20230515074021.31257-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ES9218P is a 32-bit stereo codec featuring an integrated
headphone amp with analog volume control and up to 2.0 V rms
output, and a low-power bypass path for passing through an
analog signal from an alternate source.

The digital audio interface supports 16/24/32-bit I2S inputs
ranging from 8 KHz to 384 KHz, and DSD inputs. This driver
only supports I2S operation.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---

Notes:
    v1->v2
    
    - Drop clock names, add __maybe_unused to OF match table
    - Add comment explaining why ess,max-clock-div exists

 sound/soc/codecs/Kconfig       |   6 +
 sound/soc/codecs/Makefile      |   2 +
 sound/soc/codecs/ess-es9218p.c | 805 +++++++++++++++++++++++++++++++++
 3 files changed, 813 insertions(+)
 create mode 100644 sound/soc/codecs/ess-es9218p.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 8020097d4e4c..973ce164e1e5 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -108,6 +108,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_ES8328_I2C
 	imply SND_SOC_ES7134
 	imply SND_SOC_ES7241
+	imply SND_SOC_ESS_ES9218P
 	imply SND_SOC_GTM601
 	imply SND_SOC_HDAC_HDMI
 	imply SND_SOC_HDAC_HDA
@@ -1017,6 +1018,11 @@ config SND_SOC_ES8328_SPI
 	depends on SPI_MASTER
 	select SND_SOC_ES8328
 
+config SND_SOC_ESS_ES9218P
+	tristate "ESS Technology ES9218P CODEC"
+	depends on I2C
+	select REGMAP_I2C
+
 config SND_SOC_GTM601
 	tristate 'GTM601 UMTS modem audio codec'
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 5cdbae88e6e3..1c119f1d9cb1 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -114,6 +114,7 @@ snd-soc-es8326-objs := es8326.o
 snd-soc-es8328-objs := es8328.o
 snd-soc-es8328-i2c-objs := es8328-i2c.o
 snd-soc-es8328-spi-objs := es8328-spi.o
+snd-soc-ess-es9218p-objs := ess-es9218p.o
 snd-soc-gtm601-objs := gtm601.o
 snd-soc-hdac-hdmi-objs := hdac_hdmi.o
 snd-soc-hdac-hda-objs := hdac_hda.o
@@ -488,6 +489,7 @@ obj-$(CONFIG_SND_SOC_ES8326)    += snd-soc-es8326.o
 obj-$(CONFIG_SND_SOC_ES8328)	+= snd-soc-es8328.o
 obj-$(CONFIG_SND_SOC_ES8328_I2C)+= snd-soc-es8328-i2c.o
 obj-$(CONFIG_SND_SOC_ES8328_SPI)+= snd-soc-es8328-spi.o
+obj-$(CONFIG_SND_SOC_ESS_ES9218P)	+= snd-soc-ess-es9218p.o
 obj-$(CONFIG_SND_SOC_GTM601)    += snd-soc-gtm601.o
 obj-$(CONFIG_SND_SOC_HDAC_HDMI) += snd-soc-hdac-hdmi.o
 obj-$(CONFIG_SND_SOC_HDAC_HDA) += snd-soc-hdac-hda.o
diff --git a/sound/soc/codecs/ess-es9218p.c b/sound/soc/codecs/ess-es9218p.c
new file mode 100644
index 000000000000..bcaacd9cdc4b
--- /dev/null
+++ b/sound/soc/codecs/ess-es9218p.c
@@ -0,0 +1,805 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022-2023 Aidan MacDonald
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+/* Read/write registers */
+#define ES9218P_SYSTEM			0x00
+#define ES9218P_INPUT_SEL		0x01
+#define ES9218P_MIX_AMUTE		0x02
+#define ES9218P_ANALOGVOL		0x03
+#define ES9218P_AMUTE_TIME		0x04
+#define ES9218P_AMUTE_LEVEL		0x05
+#define ES9218P_DOP_VOL_RAMP		0x06
+#define ES9218P_FBW_MUTE		0x07
+#define ES9218P_GPIO_CONFIG		0x08
+#define ES9218P_MODE_SYNC		0x0a
+#define ES9218P_OC_PROTECT		0x0b
+#define ES9218P_DPLL_BANDWITH		0x0c
+#define ES9218P_THD_MONO_MODE		0x0d
+#define ES9218P_SS_CONFIG		0x0e
+#define ES9218P_VOL_CH1			0x0f
+#define ES9218P_VOL_CH2			0x10
+#define ES9218P_MASTER_TRIM		0x11 /* 32-bit */
+#define ES9218P_GPIO_INPUT_SEL		0x15
+#define ES9218P_THD_C2			0x16 /* 16-bit */
+#define ES9218P_THD_C3			0x18 /* 16-bit */
+#define ES9218P_CP_SS_DELAY		0x1a
+#define ES9218P_GEN_CONFIG		0x1b
+#define ES9218P_GPIO_INV_ACG		0x1c
+#define ES9218P_CP_CLOCK		0x1e /* 16-bit */
+#define ES9218P_AMP_CONFIG		0x20
+#define ES9218P_IMASK			0x21
+#define ES9218P_NCO			0x22 /* 32-bit */
+#define ES9218P_FIR_ADDR		0x28
+#define ES9218P_FIR_DATA		0x29 /* 24-bit */
+#define ES9218P_FIR_CONFIG		0x2c
+#define ES9218P_ANALOG_OV_1		0x2d
+#define ES9218P_ANALOG_OV_2		0x2e
+#define ES9218P_ANALOG_OV_3		0x2f
+#define ES9218P_ANALOG_CTRL		0x30
+#define ES9218P_ACG_THRESH		0x31 /* 24-bit */
+#define ES9218P_THD_C2_CH2		0x35 /* 16-bit */
+#define ES9218P_THD_C3_CH2		0x37 /* 16-bit */
+
+/* Read only registers */
+#define ES9218P_CHIP_STATUS		0x40
+#define ES9218P_GPIO_READBACK		0x41
+#define ES9218P_DPLL_NUMBER		0x42 /* 32-bit */
+#define ES9218P_INPUT_STATUS		0x48
+#define ES9218P_RAM_READBACK		0x49 /* 24-bit */
+
+#define ES9218P_MAX_REGISTER		(ES9218P_RAM_READBACK + 2)
+
+#define ES9218P_SYSTEM_OSC_DRV		GENMASK(7, 4)
+#define ES9218P_SYSTEM_CLK_GEAR		GENMASK(3, 2)
+
+#define ES9218P_INPUT_SEL_SER_LEN	GENMASK(7, 6)
+#define ES9218P_INPUT_SEL_SER_MODE	GENMASK(5, 4)
+#define ES9218P_INPUT_SEL_AUTOSELECT	GENMASK(3, 2)
+#define ES9218P_INPUT_SEL_DECODER	GENMASK(1, 0)
+
+#define ES9218P_MODE_SYNC_MASTER	BIT(7)
+
+#define ES9218P_SS_CONFIG_QUAD_RAMP	BIT(5)
+#define ES9218P_SS_CONFIG_TIME		GENMASK(4, 0)
+
+#define ES9218P_GEN_CONFIG_ASRC_EN	BIT(7)
+
+#define ES9218P_AMP_CONFIG_MODE		GENMASK(1, 0)
+#define ES9218P_AMP_MODE_CORE_ON	0
+#define ES9218P_AMP_MODE_LOWFI		1
+#define ES9218P_AMP_MODE_HIFI_1V	2
+#define ES9218P_AMP_MODE_HIFI_2V	3
+
+enum es9218p_supply_id {
+	ES9218P_SUPPLY_AVDD,
+	ES9218P_SUPPLY_VCCA,
+	ES9218P_SUPPLY_AVCC3V3,
+	ES9218P_SUPPLY_AVCC1V8,
+	ES9218P_NUM_SUPPLIES
+};
+
+static const char * const es9218p_supply_names[ES9218P_NUM_SUPPLIES] = {
+	"avdd",
+	"vcca",
+	"avcc3v3",
+	"avcc1v8",
+};
+
+/**
+ * struct es9218p_priv - private data for ES9218P codec
+ * @supplies:		number of supplies
+ * @mclk:		clock for the MCLK/XI input
+ * @reset_gpio:		GPIO for the RESETB pin
+ * @max_clk_div:	maximum safe clock divider for MCLK
+ * @osc_drv_bias:	oscillator drive pad bias
+ * @soft_start_time:	requested soft start time (0-20)
+ * @output_2v:		requested output voltage (true -> 2Vrms, false -> 1Vrms)
+ * @analog_bypass:	requested audio path (true -> AUX input, false -> I2S input)
+ * @fsr:		current sample rate
+ * @master_mode:	true if the codec is supplying the bit and frame clocks
+ * @powered:		true if the codec is powered up
+ * @out_mux_powered:	true if the output mux is powered
+ * @dac_powered:	true if the DAC is powered
+ */
+struct es9218p_priv {
+	struct regmap *regmap;
+	struct regulator_bulk_data supplies[ES9218P_NUM_SUPPLIES];
+	struct clk *mclk;
+	struct gpio_desc *reset_gpio;
+	unsigned int max_clk_div;
+	unsigned int osc_drv_bias;
+
+	unsigned int soft_start_time;
+	bool output_2v;
+	bool analog_bypass;
+
+	unsigned int fsr;
+	bool master_mode;
+	bool powered;
+	bool out_mux_powered;
+	bool dac_powered;
+};
+
+static int es9218p_wide_write(struct regmap *regmap, unsigned int reg,
+			      int count, unsigned int value)
+{
+	u8 data[4];
+	int i;
+
+	for (i = 0; i < count; i++) {
+		data[i] = value & 0xff;
+		value >>= 8;
+	}
+
+	return regmap_raw_write(regmap, reg, data, count);
+}
+
+static void es9218p_apply_clk_params(struct snd_soc_component *component)
+{
+	struct es9218p_priv *priv = snd_soc_component_get_drvdata(component);
+	unsigned int clk_div, clk_gear, nco, ss_time, max_ss_time;
+	unsigned long mclk;
+
+	if (!priv->powered)
+		return;
+
+	/*
+	 * Calculate the maximum safe clock gear setting based on the
+	 * constraint CLK >= 128*FSR and the platform-specific maximum.
+	 */
+	mclk = clk_get_rate(priv->mclk);
+
+	clk_div = mclk / (128 * priv->fsr);
+	if (clk_div > priv->max_clk_div)
+		clk_div = priv->max_clk_div;
+
+	if (clk_div >= 8)
+		clk_gear = 3;
+	else if (clk_div >= 4)
+		clk_gear = 2;
+	else if (clk_div >= 2)
+		clk_gear = 1;
+	else
+		clk_gear = 0;
+
+	snd_soc_component_write_field(component, ES9218P_SYSTEM,
+				      ES9218P_SYSTEM_CLK_GEAR, clk_gear);
+
+	/*
+	 * Calculate soft start time, adjusting for clock gear and clamping
+	 * to ensure the time does not exceed 250ms. That limit is arbitrary,
+	 * but we need to impose _some_ limit because the maximum timeout can
+	 * be absurdly long (minutes to hours).
+	 */
+	if (priv->soft_start_time > clk_gear)
+		ss_time = priv->soft_start_time - clk_gear;
+	else
+		ss_time = 0;
+
+	max_ss_time = ilog2((mclk >> clk_gear) / 4096 / 2 / 4);
+	if (ss_time > max_ss_time)
+		ss_time = max_ss_time;
+
+	snd_soc_component_write_field(component, ES9218P_SS_CONFIG,
+				      ES9218P_SS_CONFIG_TIME, ss_time);
+
+	/*
+	 * NCO sets the frame clock when in master mode, otherwise it's unused.
+	 */
+	if (priv->master_mode)
+		nco = div_u64((u64)priv->fsr << 32, mclk >> clk_gear);
+	else
+		nco = 0;
+
+	snd_soc_component_write_field(component, ES9218P_MODE_SYNC,
+				      ES9218P_MODE_SYNC_MASTER, priv->master_mode);
+	snd_soc_component_write_field(component, ES9218P_GEN_CONFIG,
+				      ES9218P_GEN_CONFIG_ASRC_EN, !priv->master_mode);
+	es9218p_wide_write(priv->regmap, ES9218P_NCO, 4, nco);
+}
+
+static int es9218p_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_component *component = dai->component;
+	struct es9218p_priv *priv = snd_soc_component_get_drvdata(component);
+
+	/* Select I2S decoder, disable decoder autoselection */
+	snd_soc_component_write_field(component, ES9218P_INPUT_SEL,
+				      ES9218P_INPUT_SEL_AUTOSELECT, 0);
+	snd_soc_component_write_field(component, ES9218P_INPUT_SEL,
+				      ES9218P_INPUT_SEL_DECODER, 0);
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		snd_soc_component_write_field(component, ES9218P_INPUT_SEL,
+					      ES9218P_INPUT_SEL_SER_MODE, 0);
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		snd_soc_component_write_field(component, ES9218P_INPUT_SEL,
+					      ES9218P_INPUT_SEL_SER_MODE, 1);
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		snd_soc_component_write_field(component, ES9218P_INPUT_SEL,
+					      ES9218P_INPUT_SEL_SER_MODE, 2);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_BP_FP:
+		priv->master_mode = true;
+		break;
+	case SND_SOC_DAIFMT_BC_FC:
+		priv->master_mode = false;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	es9218p_apply_clk_params(component);
+	return 0;
+}
+
+static int es9218p_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct es9218p_priv *priv = snd_soc_component_get_drvdata(component);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		snd_soc_component_write_field(component, ES9218P_INPUT_SEL,
+					      ES9218P_INPUT_SEL_SER_LEN, 0);
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		snd_soc_component_write_field(component, ES9218P_INPUT_SEL,
+					      ES9218P_INPUT_SEL_SER_LEN, 1);
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		snd_soc_component_write_field(component, ES9218P_INPUT_SEL,
+					      ES9218P_INPUT_SEL_SER_LEN, 2);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	priv->fsr = params_rate(params);
+
+	es9218p_apply_clk_params(component);
+	return 0;
+}
+
+static int es9218p_mute_stream(struct snd_soc_dai *dai, int mute, int direction)
+{
+	struct snd_soc_component *component = dai->component;
+
+	if (mute)
+		snd_soc_component_update_bits(component, ES9218P_FBW_MUTE, 0x01, 0x01);
+	else
+		snd_soc_component_update_bits(component, ES9218P_FBW_MUTE, 0x01, 0);
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops es9218p_dai_ops = {
+	.set_fmt = es9218p_set_fmt,
+	.hw_params = es9218p_hw_params,
+	.mute_stream = es9218p_mute_stream,
+};
+
+static struct snd_soc_dai_driver es9218p_dai = {
+	.name = "es9218p",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min = 8000,
+		.rate_max = 384000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE |
+			   SNDRV_PCM_FMTBIT_S24_LE |
+			   SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.ops = &es9218p_dai_ops,
+};
+
+static int es9218p_power_up(struct snd_soc_component *component)
+{
+	struct es9218p_priv *priv = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(priv->supplies), priv->supplies);
+	if (ret) {
+		dev_err(component->dev, "Cannot enable supplies: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(priv->mclk);
+	if (ret) {
+		dev_err(component->dev, "Cannot enable mclk: %d\n", ret);
+		goto err_regulator;
+	}
+
+	gpiod_set_value_cansleep(priv->reset_gpio, 1);
+	usleep_range(1500, 2000);
+
+	priv->powered = true;
+
+	snd_soc_component_write_field(component, ES9218P_AMP_CONFIG,
+				      ES9218P_AMP_CONFIG_MODE, ES9218P_AMP_MODE_CORE_ON);
+	snd_soc_component_write_field(component, ES9218P_SYSTEM,
+				      ES9218P_SYSTEM_OSC_DRV, priv->osc_drv_bias);
+	es9218p_apply_clk_params(component);
+
+	regcache_cache_only(priv->regmap, false);
+	ret = regcache_sync(priv->regmap);
+	if (ret) {
+		regcache_cache_only(priv->regmap, true);
+		goto err_clk_reset;
+	}
+
+	return 0;
+
+err_clk_reset:
+	priv->powered = false;
+	gpiod_set_value_cansleep(priv->reset_gpio, 0);
+	clk_disable_unprepare(priv->mclk);
+err_regulator:
+	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
+	return ret;
+}
+
+static void es9218p_power_down(struct snd_soc_component *component)
+{
+	struct es9218p_priv *priv = snd_soc_component_get_drvdata(component);
+
+	regcache_cache_only(priv->regmap, true);
+	regcache_mark_dirty(priv->regmap);
+
+	priv->powered = false;
+
+	gpiod_set_value_cansleep(priv->reset_gpio, 0);
+
+	clk_disable_unprepare(priv->mclk);
+	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
+}
+
+static int es9218p_set_bias_level(struct snd_soc_component *component,
+				  enum snd_soc_bias_level level)
+{
+	int ret = 0;
+
+	switch (level) {
+	case SND_SOC_BIAS_STANDBY:
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF)
+			ret = es9218p_power_up(component);
+		break;
+
+	case SND_SOC_BIAS_OFF:
+		es9218p_power_down(component);
+		break;
+
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+/* Returns soft start delay in microseconds */
+static unsigned long es9218p_get_soft_start_delay(struct snd_soc_component *component)
+{
+	struct es9218p_priv *priv = snd_soc_component_get_drvdata(component);
+	unsigned long mclk, clk_gear, ss_time;
+
+	if (!priv->powered)
+		return 0;
+
+	mclk = clk_get_rate(priv->mclk);
+	clk_gear = snd_soc_component_read_field(component, ES9218P_SYSTEM,
+						ES9218P_SYSTEM_CLK_GEAR);
+	ss_time = snd_soc_component_read_field(component, ES9218P_SS_CONFIG,
+					       ES9218P_SS_CONFIG_TIME);
+
+	return div_u64((1000000ull * 4096ull) << (1 + ss_time), mclk >> clk_gear);
+}
+
+static void es9218p_set_amp_mode(struct snd_soc_component *component, int new_mode)
+{
+	unsigned long ss_delay;
+	int cur_mode, ret;
+
+	cur_mode = snd_soc_component_read_field(component, ES9218P_AMP_CONFIG,
+						ES9218P_AMP_CONFIG_MODE);
+	if (cur_mode == new_mode)
+		return;
+
+	ss_delay = es9218p_get_soft_start_delay(component);
+	ret = snd_soc_component_write_field(component, ES9218P_AMP_CONFIG,
+					    ES9218P_AMP_CONFIG_MODE,
+					    ES9218P_AMP_MODE_CORE_ON);
+	if (ret) {
+		/*
+		 * We need an extra ~25ms delay here, otherwise the transition
+		 * to the new mode doesn't work.
+		 */
+		usleep_range(ss_delay + 25000, ss_delay + 26000);
+	}
+
+	ret = snd_soc_component_write_field(component, ES9218P_AMP_CONFIG,
+					    ES9218P_AMP_CONFIG_MODE, new_mode);
+	if (ret)
+		usleep_range(ss_delay, ss_delay + 1000);
+}
+
+static void es9218p_update_amp_mode(struct snd_soc_component *component)
+{
+	struct es9218p_priv *priv = snd_soc_component_get_drvdata(component);
+	int amp_mode;
+
+	if (!priv->out_mux_powered)
+		amp_mode = ES9218P_AMP_MODE_CORE_ON;
+	else if (priv->analog_bypass)
+		amp_mode = ES9218P_AMP_MODE_LOWFI;
+	else if (!priv->dac_powered)
+		amp_mode = ES9218P_AMP_MODE_CORE_ON;
+	else if (priv->output_2v)
+		amp_mode = ES9218P_AMP_MODE_HIFI_2V;
+	else
+		amp_mode = ES9218P_AMP_MODE_HIFI_1V;
+
+	es9218p_set_amp_mode(component, amp_mode);
+}
+
+static int es9218p_output_dapm_event(struct snd_soc_dapm_widget *widget,
+				     struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(widget->dapm);
+	struct es9218p_priv *priv = snd_soc_component_get_drvdata(component);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (widget->id == snd_soc_dapm_dac)
+			priv->dac_powered = true;
+		else
+			priv->out_mux_powered = true;
+		break;
+
+	case SND_SOC_DAPM_POST_PMD:
+		if (widget->id == snd_soc_dapm_dac)
+			priv->dac_powered = false;
+		else
+			priv->out_mux_powered = false;
+		break;
+
+	default:
+		return 0;
+	}
+
+	es9218p_update_amp_mode(component);
+	return 0;
+}
+
+static int outlevel_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct es9218p_priv *priv = snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.enumerated.item[0] = priv->output_2v;
+	return 0;
+}
+
+static int outlevel_put(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct es9218p_priv *priv = snd_soc_component_get_drvdata(component);
+
+	priv->output_2v = ucontrol->value.enumerated.item[0];
+	es9218p_update_amp_mode(component);
+	return 1;
+}
+
+static int softstart_get(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct es9218p_priv *priv = snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.integer.value[0] = priv->soft_start_time;
+	return 0;
+}
+
+static int softstart_put(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct es9218p_priv *priv = snd_soc_component_get_drvdata(component);
+
+	priv->soft_start_time = ucontrol->value.integer.value[0];
+	es9218p_apply_clk_params(component);
+	return 1;
+}
+
+static int output_mux_get(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
+	struct es9218p_priv *priv = snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.enumerated.item[0] = priv->analog_bypass;
+	return 0;
+}
+
+static int output_mux_put(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	struct es9218p_priv *priv = snd_soc_component_get_drvdata(component);
+	unsigned int value = ucontrol->value.enumerated.item[0];
+
+	priv->analog_bypass = value;
+	es9218p_update_amp_mode(component);
+
+	snd_soc_dapm_mux_update_power(dapm, kcontrol, value, e, NULL);
+	return 1;
+}
+
+static DECLARE_TLV_DB_SCALE(analog_vol_scale, -2400, 100, 0);
+static DECLARE_TLV_DB_SCALE(digital_vol_scale, -12750, 50, 0);
+
+static const char * const digfilter_texts[] = {
+	"Linear Phase Fast",
+	"Linear Phase Slow",
+	"Minimum Phase Fast",
+	"Minimum Phase Slow",
+	"Apodizing Fast Type 1",
+	"Apodizing Fast Type 2",
+	"Hybrid Fast",
+	"Brick Wall"
+};
+static SOC_ENUM_SINGLE_DECL(digfilter_enum, ES9218P_FBW_MUTE, 5, digfilter_texts);
+
+static const char * const outlevel_texts[] = { "1V", "2V" };
+static SOC_ENUM_SINGLE_EXT_DECL(outlevel_enum, outlevel_texts);
+
+static const char * const channel_mux_texts[] = { "CH1", "CH2" };
+static SOC_ENUM_DOUBLE_DECL(channel_mux_enum, ES9218P_MIX_AMUTE, 0, 2, channel_mux_texts);
+
+static const struct snd_kcontrol_new es9218p_controls[] = {
+	SOC_SINGLE_TLV("Headphone Playback Volume",
+		       ES9218P_ANALOGVOL, 0, 24, 1, analog_vol_scale),
+	SOC_DOUBLE_R_TLV("Master Playback Volume",
+			 ES9218P_VOL_CH1, ES9218P_VOL_CH2, 0, 0xff, 1, digital_vol_scale),
+	SOC_ENUM("Digital Filter Roll-Off", digfilter_enum),
+	SOC_ENUM_EXT("Output Level", outlevel_enum, outlevel_get, outlevel_put),
+	SOC_ENUM("Channel Mux", channel_mux_enum),
+	SOC_SINGLE_EXT("Soft Start Time", SND_SOC_NOPM, 0, 20, 0, softstart_get, softstart_put),
+};
+
+static const char * const output_mux_texts[] = { "Digital Input", "AUX Input" };
+static SOC_ENUM_SINGLE_EXT_DECL(output_mux_enum, output_mux_texts);
+
+static const struct snd_kcontrol_new output_mux_ctl =
+	SOC_DAPM_ENUM_EXT("Output Source", output_mux_enum, output_mux_get, output_mux_put);
+
+static const struct snd_soc_dapm_widget es9218p_dapm_widgets[] = {
+	SND_SOC_DAPM_INPUT("AUX_L"),
+	SND_SOC_DAPM_INPUT("AUX_R"),
+
+	SND_SOC_DAPM_DAC_E("DAC", "Playback", SND_SOC_NOPM, 0, 0,
+			   es9218p_output_dapm_event,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_MUX_E("Output Mux", SND_SOC_NOPM, 0, 0,
+			   &output_mux_ctl, es9218p_output_dapm_event,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_OUTPUT("OUTL"),
+	SND_SOC_DAPM_OUTPUT("OUTR"),
+
+};
+
+static const struct snd_soc_dapm_route es9218p_dapm_routes[] = {
+	{"Output Mux", "Digital Input", "DAC"},
+	{"Output Mux", "AUX Input", "AUX_L"},
+	{"Output Mux", "AUX Input", "AUX_R"},
+	{"OUTL", NULL, "Output Mux"},
+	{"OUTR", NULL, "Output Mux"},
+};
+
+static const struct snd_soc_component_driver es9218p_component = {
+	.set_bias_level		= es9218p_set_bias_level,
+	.controls		= es9218p_controls,
+	.num_controls		= ARRAY_SIZE(es9218p_controls),
+	.dapm_widgets		= es9218p_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(es9218p_dapm_widgets),
+	.dapm_routes		= es9218p_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(es9218p_dapm_routes),
+};
+
+static const struct regmap_range es9218p_readable_ranges[] = {
+	regmap_reg_range(ES9218P_SYSTEM, ES9218P_THD_C3_CH2+1),
+	regmap_reg_range(ES9218P_CHIP_STATUS, ES9218P_MAX_REGISTER),
+};
+
+static const struct regmap_access_table es9218p_readable_table = {
+	.yes_ranges = es9218p_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(es9218p_readable_ranges),
+};
+
+static const struct regmap_range es9218p_writeable_ranges[] = {
+	regmap_reg_range(ES9218P_SYSTEM, ES9218P_THD_C3_CH2+1),
+};
+
+static const struct regmap_access_table es9218p_writeable_table = {
+	.yes_ranges = es9218p_writeable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(es9218p_writeable_ranges),
+};
+
+static const struct regmap_range es9218p_volatile_ranges[] = {
+	regmap_reg_range(ES9218P_FIR_ADDR, ES9218P_FIR_CONFIG),
+	regmap_reg_range(ES9218P_CHIP_STATUS, ES9218P_DPLL_NUMBER+3),
+	regmap_reg_range(ES9218P_INPUT_STATUS, ES9218P_RAM_READBACK+2),
+};
+
+static const struct regmap_access_table es9218p_volatile_table = {
+	.yes_ranges = es9218p_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(es9218p_volatile_ranges),
+};
+
+static const u8 es9218p_reg_defaults[] = {
+	0x00, 0x8c, 0x34, 0x58, 0x00, 0x68, 0x72, 0x80,
+	0xdd, 0x18, 0x02, 0x00, 0x5a, 0x40, 0x0a, 0x50,
+	0x50, 0xff, 0xff, 0xff, 0x7f, 0x0d, 0x00, 0x00,
+	0x00, 0x00, 0x62, 0xc4, 0xf0, 0x00, 0x00, 0x00,
+	0x00, 0x3c, 0x00, 0x00, 0x00, 0x00, 0x00, 0xcc,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x01, 0x62, 0xc0, 0x0d, 0x62, 0x00, 0x00, 0x00,
+	0x00,
+};
+
+static const struct regmap_config es9218p_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.rd_table = &es9218p_readable_table,
+	.wr_table = &es9218p_writeable_table,
+	.volatile_table = &es9218p_volatile_table,
+	.max_register = ES9218P_MAX_REGISTER,
+	.reg_defaults_raw = es9218p_reg_defaults,
+	.num_reg_defaults_raw = ARRAY_SIZE(es9218p_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static int es9218p_read_properties(struct device *dev,
+				   struct es9218p_priv *priv)
+{
+	u32 val;
+
+	/*
+	 * NOTE: This property determines the maximum value of the MCLK/XI
+	 * divider that supplies the codec internal CLK. A lower CLK saves
+	 * power so we want to use the highest possible divider at all times.
+	 *
+	 * We _should_ be able to calculate the clock divider automatically
+	 * because CLK is constrained only by the sample rate and I2C bus
+	 * frequency:
+	 *
+	 *     MCLK / DIV = CLK >= max { 128 * FSR, 20 * I2C_BUS_FREQ }
+	 *
+	 * The I2C subsystem doesn't yet provide a mechanism to query the
+	 * bus frequency, so we can't implement the automatic calculation.
+	 * Instead, ess,max-clock-div sets the maximum value of DIV that
+	 * ensures CLK >= 20 * I2C_BUS_FREQ, and we use FSR to determine
+	 * the value of DIV within the range [1, ess,max-clock-div].
+	 *
+	 * If/when there's a way to query I2C bus frequency this property
+	 * can be removed.
+	 */
+	if (!device_property_read_u32(dev, "ess,max-clock-div", &val))
+		priv->max_clk_div = val;
+
+	if (!device_property_read_u32(dev, "ess,oscillator-pad-bias", &val))
+		priv->osc_drv_bias = val;
+
+	return 0;
+}
+
+static int es9218p_i2c_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct es9218p_priv *priv;
+	int ret, i;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regmap = devm_regmap_init_i2c(i2c, &es9218p_regmap);
+	if (IS_ERR(priv->regmap))
+		return dev_err_probe(dev, PTR_ERR(priv->regmap), "Failed to create regmap\n");
+
+	/* Codec is only powered when needed */
+	regcache_cache_only(priv->regmap, true);
+
+	for (i = 0; i < ES9218P_NUM_SUPPLIES; i++)
+		priv->supplies[i].supply = es9218p_supply_names[i];
+
+	ret = devm_regulator_bulk_get(dev, ES9218P_NUM_SUPPLIES, priv->supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request supplies\n");
+
+	priv->mclk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->mclk))
+		return dev_err_probe(dev, PTR_ERR(priv->mclk), "Failed to request MCLK\n");
+
+	priv->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
+				     "Failed to request reset GPIO\n");
+
+	ret = es9218p_read_properties(dev, priv);
+	if (ret)
+		return ret;
+
+	/* Arbitrary; must be nonzero */
+	priv->fsr = 48000;
+
+	i2c_set_clientdata(i2c, priv);
+
+	return devm_snd_soc_register_component(dev, &es9218p_component, &es9218p_dai, 1);
+}
+
+static const struct of_device_id __maybe_unused es9218p_of_match[] = {
+	{ .compatible = "ess,es9218p" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, es9218p_of_match);
+
+static const struct i2c_device_id es9218p_i2c_id[] = {
+	{ "ess-es9218p", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, es9218p_i2c_id);
+
+static struct i2c_driver es9218p_i2c_driver = {
+	.driver = {
+		.name = "ess-es9218p",
+		.of_match_table = of_match_ptr(es9218p_of_match),
+	},
+	.probe = es9218p_i2c_probe,
+	.id_table = es9218p_i2c_id,
+};
+module_i2c_driver(es9218p_i2c_driver);
+
+MODULE_DESCRIPTION("ESS ES9218P ALSA SoC Codec Driver");
+MODULE_AUTHOR("Aidan MacDonald <aidanmacdonald.0x0@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.39.2

