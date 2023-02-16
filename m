Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3C6699160
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjBPKd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjBPKds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:33:48 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C33241FA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:33:17 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 684A266021A3;
        Thu, 16 Feb 2023 10:33:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676543596;
        bh=eMkPLVqgn/rm7daKEO/Uj9TaCgE+rT2FdXYO0f+0Kb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LzD7pKqsIJ1ZAHOId5A8AzFh29YIOkrsIOkrcz6vQcsrdjNbV6S1d66PEcqoKJuZB
         W3c6XMl7N/ElIacrM9tJhOnJs5x5GgSJrbQ0PL93ZBDi0UQN9h7pSaRIrTlV4f+ltx
         VPchrA50yPtB3Sp4P396dfOFNIyfnCJHWGR4linKt327i1wAf/w1sUn97iCgPsKPTk
         d4ZFAXmvkx/PLQqp6MUYSKCyG9CFGZS/cen2GzRu/GQ07aO9s6Uo3utMNT/eZIcm7n
         hVhpZVG9EJnKdVMoV2OiZC4cXnLfoVszPHApX4AGTefoEsDuB8UVcFX/bZWKXISa5R
         J/QGmLP8N0ITw==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH 2/9] ASoC: amd: vangogh: Update code indentation
Date:   Thu, 16 Feb 2023 10:32:53 +0000
Message-Id: <20230216103300.360016-3-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230216103300.360016-1-lucas.tanure@collabora.com>
References: <20230216103300.360016-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of 100 character limit and modify indentation so code is
easier to read.
While at it:
 - sort includes in alphabetical order
 - sort variables declarations by line length
 - use smaller variables names
 - remove unnecessary "struct snd_soc_card *card" lines
 - insert blank lines before return
 - align defines

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 172 ++++++++++++-----------------
 1 file changed, 71 insertions(+), 101 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index 5bd9418919a0..2675fbff9f6f 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -5,34 +5,31 @@
  *
  * Copyright 2021 Advanced Micro Devices, Inc.
  */
-
-#include <sound/soc.h>
-#include <sound/soc-dapm.h>
-#include <linux/module.h>
-#include <linux/io.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-
-#include <sound/jack.h>
+#include <linux/acpi.h>
 #include <linux/clk.h>
+#include <linux/dmi.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
+#include <linux/io.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
-#include <linux/acpi.h>
-#include <linux/dmi.h>
+#include <linux/module.h>
+#include <sound/jack.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
 
 #include "../../codecs/nau8821.h"
 #include "../../codecs/cs35l41.h"
-
 #include "acp5x.h"
 
-#define DRV_NAME "acp5x_mach"
-#define DUAL_CHANNEL		2
-#define ACP5X_NUVOTON_CODEC_DAI	"nau8821-hifi"
-#define VG_JUPITER 1
-#define ACP5X_NUVOTON_BCLK 3072000
-#define ACP5X_NAU8821_FREQ_OUT 12288000
+#define DRV_NAME			"acp5x_mach"
+#define DUAL_CHANNEL			2
+#define ACP5X_NUVOTON_CODEC_DAI		"nau8821-hifi"
+#define VG_JUPITER			1
+#define ACP5X_NUVOTON_BCLK		3072000
+#define ACP5X_NAU8821_FREQ_OUT		12288000
 
 static unsigned long acp5x_machine_id;
 static struct snd_soc_jack vg_headset;
@@ -50,16 +47,14 @@ static struct snd_soc_jack_pin acp5x_nau8821_jack_pins[] = {
 
 static int acp5x_8821_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
 	int ret;
-	struct snd_soc_card *card = rtd->card;
-	struct snd_soc_component *component =
-					asoc_rtd_to_codec(rtd, 0)->component;
 
 	/*
 	 * Headset buttons map to the google Reference headset.
 	 * These can be configured by userspace.
 	 */
-	ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
+	ret = snd_soc_card_jack_new_pins(rtd->card, "Headset Jack",
 					 SND_JACK_HEADSET | SND_JACK_BTN_0,
 					 &vg_headset, acp5x_nau8821_jack_pins,
 					 ARRAY_SIZE(acp5x_nau8821_jack_pins));
@@ -70,6 +65,7 @@ static int acp5x_8821_init(struct snd_soc_pcm_runtime *rtd)
 
 	snd_jack_set_key(vg_headset.jack, SND_JACK_BTN_0, KEY_MEDIA);
 	nau8821_enable_jack_detect(component, &vg_headset);
+
 	return ret;
 }
 
@@ -100,42 +96,35 @@ static struct snd_pcm_hw_constraint_list constraints_sample_bits = {
 	.count = ARRAY_SIZE(acp5x_nau8821_format),
 };
 
-static int acp5x_8821_startup(struct snd_pcm_substream *substream)
+static int acp5x_8821_startup(struct snd_pcm_substream *sub)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
-	struct snd_soc_card *card = rtd->card;
-	struct acp5x_platform_info *machine = snd_soc_card_get_drvdata(card);
+	struct snd_pcm_runtime *runtime = sub->runtime;
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(sub);
+	struct acp5x_platform_info *machine = snd_soc_card_get_drvdata(rtd->card);
 
 	machine->play_i2s_instance = I2S_SP_INSTANCE;
 	machine->cap_i2s_instance = I2S_SP_INSTANCE;
 
 	runtime->hw.channels_max = DUAL_CHANNEL;
-	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
-				   &constraints_channels);
-	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-				   &constraints_rates);
-	snd_pcm_hw_constraint_list(substream->runtime, 0,
-				   SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS, &constraints_channels);
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
+	snd_pcm_hw_constraint_list(sub->runtime, 0, SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
 				   &constraints_sample_bits);
+
 	return 0;
 }
 
-static int acp5x_nau8821_hw_params(struct snd_pcm_substream *substream,
-				   struct snd_pcm_hw_params *params)
+static int acp5x_nau8821_hw_params(struct snd_pcm_substream *sub, struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(sub);
 	struct snd_soc_card *card = rtd->card;
-	struct snd_soc_dai *codec_dai =
-			snd_soc_card_get_codec_dai(card,
-						   ACP5X_NUVOTON_CODEC_DAI);
+	struct snd_soc_dai *dai = snd_soc_card_get_codec_dai(card, ACP5X_NUVOTON_CODEC_DAI);
 	int ret;
 
-	ret = snd_soc_dai_set_sysclk(codec_dai, NAU8821_CLK_FLL_BLK, 0,
-				     SND_SOC_CLOCK_IN);
+	ret = snd_soc_dai_set_sysclk(dai, NAU8821_CLK_FLL_BLK, 0, SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		dev_err(card->dev, "can't set FS clock %d\n", ret);
-	ret = snd_soc_dai_set_pll(codec_dai, 0, 0, snd_soc_params_to_bclk(params),
+	ret = snd_soc_dai_set_pll(dai, 0, 0, snd_soc_params_to_bclk(params),
 				  params_rate(params) * 256);
 	if (ret < 0)
 		dev_err(card->dev, "can't set FLL: %d\n", ret);
@@ -145,35 +134,32 @@ static int acp5x_nau8821_hw_params(struct snd_pcm_substream *substream,
 
 static int acp5x_cs35l41_startup(struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
-	struct snd_soc_card *card = rtd->card;
-	struct acp5x_platform_info *machine = snd_soc_card_get_drvdata(card);
+	struct acp5x_platform_info *machine = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	machine->play_i2s_instance = I2S_HS_INSTANCE;
 
 	runtime->hw.channels_max = DUAL_CHANNEL;
-	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
-				   &constraints_channels);
-	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-				   &constraints_rates);
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS, &constraints_channels);
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
+
 	return 0;
 }
 
-static int acp5x_cs35l41_hw_params(struct snd_pcm_substream *substream,
-				   struct snd_pcm_hw_params *params)
+static int acp5x_cs35l41_hw_params(struct snd_pcm_substream *sub, struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
-	struct snd_soc_card *card = rtd->card;
-	struct snd_soc_dai *codec_dai;
-	int ret, i;
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(sub);
 	unsigned int num_codecs = rtd->dai_link->num_codecs;
+	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_dai *dai;
 	unsigned int bclk_val;
+	int ret, i;
 
 	ret = 0;
 	for (i = 0; i < num_codecs; i++) {
-		codec_dai = asoc_rtd_to_codec(rtd, i);
-		if (strcmp(codec_dai->name, "cs35l41-pcm") == 0) {
+		dai = asoc_rtd_to_codec(rtd, i);
+		if (strcmp(dai->name, "cs35l41-pcm") == 0) {
 			switch (params_rate(params)) {
 			case 48000:
 				bclk_val = 1536000;
@@ -183,7 +169,7 @@ static int acp5x_cs35l41_hw_params(struct snd_pcm_substream *substream,
 					params_rate(params));
 				return -EINVAL;
 			}
-			ret = snd_soc_component_set_sysclk(codec_dai->component,
+			ret = snd_soc_component_set_sysclk(dai->component,
 							   0, 0, bclk_val, SND_SOC_CLOCK_IN);
 			if (ret < 0) {
 				dev_err(card->dev, "failed to set sysclk for CS35l41 dai\n");
@@ -216,29 +202,18 @@ static struct snd_soc_codec_conf cs35l41_conf[] = {
 	},
 };
 
-SND_SOC_DAILINK_DEF(acp5x_i2s,
-		    DAILINK_COMP_ARRAY(COMP_CPU("acp5x_i2s_playcap.0")));
-
-SND_SOC_DAILINK_DEF(acp5x_bt,
-		    DAILINK_COMP_ARRAY(COMP_CPU("acp5x_i2s_playcap.1")));
-
-SND_SOC_DAILINK_DEF(nau8821,
-		    DAILINK_COMP_ARRAY(COMP_CODEC("i2c-NVTN2020:00",
-						  "nau8821-hifi")));
-
-SND_SOC_DAILINK_DEF(cs35l41,
-		    DAILINK_COMP_ARRAY(COMP_CODEC("spi-VLV1776:00", "cs35l41-pcm"),
-				       COMP_CODEC("spi-VLV1776:01", "cs35l41-pcm")));
-
-SND_SOC_DAILINK_DEF(platform,
-		    DAILINK_COMP_ARRAY(COMP_PLATFORM("acp5x_i2s_dma.0")));
+SND_SOC_DAILINK_DEF(platform,  DAILINK_COMP_ARRAY(COMP_PLATFORM("acp5x_i2s_dma.0")));
+SND_SOC_DAILINK_DEF(acp5x_i2s, DAILINK_COMP_ARRAY(COMP_CPU("acp5x_i2s_playcap.0")));
+SND_SOC_DAILINK_DEF(acp5x_bt,  DAILINK_COMP_ARRAY(COMP_CPU("acp5x_i2s_playcap.1")));
+SND_SOC_DAILINK_DEF(nau8821,   DAILINK_COMP_ARRAY(COMP_CODEC("i2c-NVTN2020:00", "nau8821-hifi")));
+SND_SOC_DAILINK_DEF(cs35l41,   DAILINK_COMP_ARRAY(COMP_CODEC("spi-VLV1776:00", "cs35l41-pcm"),
+						  COMP_CODEC("spi-VLV1776:01", "cs35l41-pcm")));
 
 static struct snd_soc_dai_link acp5x_dai[] = {
 	{
 		.name = "acp5x-8821-play",
 		.stream_name = "Playback/Capture",
-		.dai_fmt = SND_SOC_DAIFMT_I2S  | SND_SOC_DAIFMT_NB_NF |
-			   SND_SOC_DAIFMT_CBC_CFC,
+		.dai_fmt = SND_SOC_DAIFMT_I2S  | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 		.ops = &acp5x_8821_ops,
@@ -248,8 +223,7 @@ static struct snd_soc_dai_link acp5x_dai[] = {
 	{
 		.name = "acp5x-CS35L41-Stereo",
 		.stream_name = "CS35L41 Stereo Playback",
-		.dai_fmt = SND_SOC_DAIFMT_I2S  | SND_SOC_DAIFMT_NB_NF |
-			   SND_SOC_DAIFMT_CBC_CFC,
+		.dai_fmt = SND_SOC_DAIFMT_I2S  | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC,
 		.dpcm_playback = 1,
 		.playback_only = 1,
 		.ops = &acp5x_cs35l41_play_ops,
@@ -257,37 +231,34 @@ static struct snd_soc_dai_link acp5x_dai[] = {
 	},
 };
 
-static int platform_clock_control(struct snd_soc_dapm_widget *w,
-				  struct snd_kcontrol *k, int  event)
+static int platform_clock_control(struct snd_soc_dapm_widget *w, struct snd_kcontrol *k, int event)
 {
 	struct snd_soc_dapm_context *dapm = w->dapm;
 	struct snd_soc_card *card = dapm->card;
-	struct snd_soc_dai *codec_dai;
+	struct snd_soc_dai *dai;
 	int ret = 0;
 
-	codec_dai = snd_soc_card_get_codec_dai(card, ACP5X_NUVOTON_CODEC_DAI);
-	if (!codec_dai) {
+	dai = snd_soc_card_get_codec_dai(card, ACP5X_NUVOTON_CODEC_DAI);
+	if (!dai) {
 		dev_err(card->dev, "Codec dai not found\n");
 		return -EIO;
 	}
 
 	if (SND_SOC_DAPM_EVENT_OFF(event)) {
-		ret = snd_soc_dai_set_sysclk(codec_dai, NAU8821_CLK_INTERNAL,
-					     0, SND_SOC_CLOCK_IN);
+		ret = snd_soc_dai_set_sysclk(dai, NAU8821_CLK_INTERNAL, 0, SND_SOC_CLOCK_IN);
 		if (ret < 0) {
 			dev_err(card->dev, "set sysclk err = %d\n", ret);
 			return -EIO;
 		}
 	} else {
-		ret = snd_soc_dai_set_sysclk(codec_dai, NAU8821_CLK_FLL_BLK, 0,
-					     SND_SOC_CLOCK_IN);
+		ret = snd_soc_dai_set_sysclk(dai, NAU8821_CLK_FLL_BLK, 0, SND_SOC_CLOCK_IN);
 		if (ret < 0)
-			dev_err(codec_dai->dev, "can't set BLK clock %d\n", ret);
-		ret = snd_soc_dai_set_pll(codec_dai, 0, 0, ACP5X_NUVOTON_BCLK,
-					  ACP5X_NAU8821_FREQ_OUT);
+			dev_err(dai->dev, "can't set BLK clock %d\n", ret);
+		ret = snd_soc_dai_set_pll(dai, 0, 0, ACP5X_NUVOTON_BCLK, ACP5X_NAU8821_FREQ_OUT);
 		if (ret < 0)
-			dev_err(codec_dai->dev, "can't set FLL: %d\n", ret);
+			dev_err(dai->dev, "can't set FLL: %d\n", ret);
 	}
+
 	return ret;
 }
 
@@ -336,6 +307,7 @@ static struct snd_soc_card acp5x_card = {
 static int acp5x_vg_quirk_cb(const struct dmi_system_id *id)
 {
 	acp5x_machine_id = VG_JUPITER;
+
 	return 1;
 }
 
@@ -352,12 +324,12 @@ static const struct dmi_system_id acp5x_vg_quirk_table[] = {
 
 static int acp5x_probe(struct platform_device *pdev)
 {
-	int ret;
 	struct acp5x_platform_info *machine;
+	struct device *dev = &pdev->dev;
 	struct snd_soc_card *card;
+	int ret;
 
-	machine = devm_kzalloc(&pdev->dev, sizeof(struct acp5x_platform_info),
-			       GFP_KERNEL);
+	machine = devm_kzalloc(&pdev->dev, sizeof(struct acp5x_platform_info), GFP_KERNEL);
 	if (!machine)
 		return -ENOMEM;
 
@@ -365,20 +337,18 @@ static int acp5x_probe(struct platform_device *pdev)
 	switch (acp5x_machine_id) {
 	case VG_JUPITER:
 		card = &acp5x_card;
-		acp5x_card.dev = &pdev->dev;
 		break;
 	default:
 		return -ENODEV;
 	}
+	card->dev = dev;
 	platform_set_drvdata(pdev, card);
 	snd_soc_card_set_drvdata(card, machine);
 
-	ret = devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret) {
-		return dev_err_probe(&pdev->dev, ret,
-				     "snd_soc_register_card(%s) failed\n",
-				     acp5x_card.name);
-	}
+	ret = devm_snd_soc_register_card(dev, card);
+	if (ret)
+		return dev_err_probe(dev, ret, "snd_soc_register_card(%s) failed\n", card->name);
+
 	return 0;
 }
 
-- 
2.39.2

