Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D0574CCBA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjGJGVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGJGVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:21:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9A0102
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 23:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688970092; x=1720506092;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4DYkzzaGOmkC/IR1L1cn4Jljb8ThFrnYnFevIJ7DRlk=;
  b=JOAJylVI7LBDD3rozWuienXk9IARoZU6NhGmwtXEhbJj/crROLqQ3WYt
   rNihhuJlse0D+S6MCsjXS8L2lg6A9YLTyFYJMi61tWZ/I7NUwT9P8CQzM
   C0Yq0WOuiWTEaqnxdrSXTosD+XVA8nbs1y1kVd4BUyHTfOzt0kjHPFble
   qoSwRZNBrwxW2/GFV6pZ6hV5riglH0snwewTOl5dCK44ilQyN4OgfUpla
   eAD8OTvDVX2Tycbv1g1x2ZR+P3kTQ8FAbRCxSQxGLz5nIldxWmrtXM+1F
   Wtgzfx2znGKf1Kxknc47DjTduakvWMZzTrpY04MDrpnsJTxkySgrBjcn0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="344595905"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="344595905"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 23:21:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="834151191"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="834151191"
Received: from brentlu-desktop.itwn.intel.com ([10.5.252.92])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jul 2023 23:21:28 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Yong Zhi <yong.zhi@intel.com>,
        Uday M Bhat <uday.m.bhat@intel.com>,
        Gongjun Song <gongjun.song@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Arnd Bergmann <arnd@arndb.de>, Brent Lu <brent.lu@intel.com>,
        Terry Cheong <htcheong@chromium.org>,
        "Dharageswari . R" <dharageswari.r@intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: Intel: sof_rt5682: add jsl_rt5650 board config
Date:   Mon, 10 Jul 2023 22:16:10 +0800
Message-Id: <20230710141610.227988-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This configuration supports JSL boards which implement ALC5650 dual
I2S interface codec. Two DAI links are added: AIF1 (on codec side) for
headphone and AIF2 for speakers.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/Kconfig                |  5 +-
 sound/soc/intel/boards/sof_rt5682.c           | 81 ++++++++++++++++++-
 .../intel/common/soc-acpi-intel-jsl-match.c   | 12 +++
 3 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index f472f603ab75..1fe830af2b84 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -475,7 +475,7 @@ endif ## SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC || SND_SOC_SOF_HDA_AUDIO_CODEC
 
 if SND_SOC_SOF_HDA_LINK || SND_SOC_SOF_BAYTRAIL
 config SND_SOC_INTEL_SOF_RT5682_MACH
-	tristate "SOF with rt5682 codec in I2S Mode"
+	tristate "SOF with rt5650/rt5682 codec in I2S Mode"
 	depends on I2C && ACPI
 	depends on ((SND_HDA_CODEC_HDMI && SND_SOC_SOF_HDA_AUDIO_CODEC) &&\
 		    (MFD_INTEL_LPSS || COMPILE_TEST)) ||\
@@ -485,6 +485,7 @@ config SND_SOC_INTEL_SOF_RT5682_MACH
 	select SND_SOC_RT1011
 	select SND_SOC_RT1015
 	select SND_SOC_RT1015P
+	select SND_SOC_RT5645
 	select SND_SOC_RT5682_I2C
 	select SND_SOC_RT5682S
 	select SND_SOC_DMIC
@@ -494,7 +495,7 @@ config SND_SOC_INTEL_SOF_RT5682_MACH
 	select SND_SOC_INTEL_SOF_REALTEK_COMMON
 	help
 	   This adds support for ASoC machine driver for SOF platforms
-	   with rt5682 codec.
+	   with rt5650 or rt5682 codec.
 	   Say Y if you have such a device.
 	   If unsure select "N".
 
diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 7c034d671cf3..53451c1b67f8 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -22,6 +22,7 @@
 #include <sound/soc-acpi.h>
 #include "../../codecs/rt5682.h"
 #include "../../codecs/rt5682s.h"
+#include "../../codecs/rt5645.h"
 #include "../../codecs/hdac_hdmi.h"
 #include "../common/soc-intel-quirks.h"
 #include "hda_dsp_common.h"
@@ -60,6 +61,7 @@
 #define SOF_MAX98390_SPEAKER_AMP_PRESENT	BIT(24)
 #define SOF_MAX98390_TWEETER_SPEAKER_PRESENT	BIT(25)
 #define SOF_RT1019_SPEAKER_AMP_PRESENT	BIT(26)
+#define SOF_RT5650_HEADPHONE_CODEC_PRESENT	BIT(27)
 
 
 /* Default: MCLK on, MCLK 19.2M, SSP0  */
@@ -305,7 +307,7 @@ static int sof_rt5682_codec_init(struct snd_soc_pcm_runtime *rtd)
 	struct sof_card_private *ctx = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
 	struct snd_soc_jack *jack;
-	int ret;
+	int ret, extra;
 
 	/* need to enable ASRC function for 24MHz mclk rate */
 	if ((sof_rt5682_quirk & SOF_RT5682_MCLK_EN) &&
@@ -315,7 +317,16 @@ static int sof_rt5682_codec_init(struct snd_soc_pcm_runtime *rtd)
 						 RT5682S_DA_STEREO1_FILTER |
 						 RT5682S_AD_STEREO1_FILTER,
 						 RT5682S_CLK_SEL_I2S1_ASRC);
-		else
+		else if (sof_rt5682_quirk & SOF_RT5650_HEADPHONE_CODEC_PRESENT) {
+			rt5645_sel_asrc_clk_src(component,
+						RT5645_DA_STEREO_FILTER |
+						RT5645_AD_STEREO_FILTER,
+						RT5645_CLK_SEL_I2S1_ASRC);
+			rt5645_sel_asrc_clk_src(component,
+						RT5645_DA_MONO_L_FILTER |
+						RT5645_DA_MONO_R_FILTER,
+						RT5645_CLK_SEL_I2S2_ASRC);
+		} else
 			rt5682_sel_asrc_clk_src(component,
 						RT5682_DA_STEREO1_FILTER |
 						RT5682_AD_STEREO1_FILTER,
@@ -365,7 +376,12 @@ static int sof_rt5682_codec_init(struct snd_soc_pcm_runtime *rtd)
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
-	ret = snd_soc_component_set_jack(component, jack, NULL);
+
+	if (sof_rt5682_quirk & SOF_RT5650_HEADPHONE_CODEC_PRESENT) {
+		extra = SND_JACK_MICROPHONE | SND_JACK_BTN_0;
+		ret = snd_soc_component_set_jack(component, jack, &extra);
+	} else
+		ret = snd_soc_component_set_jack(component, jack, NULL);
 
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack call-back failed: %d\n", ret);
@@ -402,6 +418,8 @@ static int sof_rt5682_hw_params(struct snd_pcm_substream *substream,
 
 		if (sof_rt5682_quirk & SOF_RT5682S_HEADPHONE_CODEC_PRESENT)
 			pll_source = RT5682S_PLL_S_MCLK;
+		else if (sof_rt5682_quirk & SOF_RT5650_HEADPHONE_CODEC_PRESENT)
+			pll_source = RT5645_PLL1_S_MCLK;
 		else
 			pll_source = RT5682_PLL1_S_MCLK;
 
@@ -422,6 +440,8 @@ static int sof_rt5682_hw_params(struct snd_pcm_substream *substream,
 	} else {
 		if (sof_rt5682_quirk & SOF_RT5682S_HEADPHONE_CODEC_PRESENT)
 			pll_source = RT5682S_PLL_S_BCLK1;
+		else if (sof_rt5682_quirk & SOF_RT5650_HEADPHONE_CODEC_PRESENT)
+			pll_source = RT5645_PLL1_S_BCLK1;
 		else
 			pll_source = RT5682_PLL1_S_BCLK1;
 
@@ -431,6 +451,9 @@ static int sof_rt5682_hw_params(struct snd_pcm_substream *substream,
 	if (sof_rt5682_quirk & SOF_RT5682S_HEADPHONE_CODEC_PRESENT) {
 		pll_id = RT5682S_PLL2;
 		clk_id = RT5682S_SCLK_S_PLL2;
+	} else if (sof_rt5682_quirk & SOF_RT5650_HEADPHONE_CODEC_PRESENT) {
+		pll_id = 0; /* not used in codec driver */
+		clk_id = RT5645_SCLK_S_PLL1;
 	} else {
 		pll_id = RT5682_PLL1;
 		clk_id = RT5682_SCLK_S_PLL1;
@@ -559,11 +582,30 @@ static const struct snd_soc_dapm_route sof_map[] = {
 	{ "IN1P", NULL, "Headset Mic" },
 };
 
+static const struct snd_soc_dapm_route rt5650_spk_dapm_routes[] = {
+	/* speaker */
+	{ "Left Spk", NULL, "SPOL" },
+	{ "Right Spk", NULL, "SPOR" },
+};
+
 static const struct snd_soc_dapm_route dmic_map[] = {
 	/* digital mics */
 	{"DMic", NULL, "SoC DMIC"},
 };
 
+static int rt5650_spk_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	int ret;
+
+	ret = snd_soc_dapm_add_routes(&card->dapm, rt5650_spk_dapm_routes,
+				      ARRAY_SIZE(rt5650_spk_dapm_routes));
+	if (ret)
+		dev_err(rtd->dev, "fail to add dapm routes, ret=%d\n", ret);
+
+	return ret;
+}
+
 static int dmic_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_card *card = rtd->card;
@@ -614,6 +656,17 @@ static struct snd_soc_dai_link_component rt5682s_component[] = {
 	}
 };
 
+static struct snd_soc_dai_link_component rt5650_components[] = {
+	{
+		.name = "i2c-10EC5650:00",
+		.dai_name = "rt5645-aif1",
+	},
+	{
+		.name = "i2c-10EC5650:00",
+		.dai_name = "rt5645-aif2",
+	}
+};
+
 static struct snd_soc_dai_link_component dmic_component[] = {
 	{
 		.name = "dmic-codec",
@@ -652,6 +705,9 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
 	if (sof_rt5682_quirk & SOF_RT5682S_HEADPHONE_CODEC_PRESENT) {
 		links[id].codecs = rt5682s_component;
 		links[id].num_codecs = ARRAY_SIZE(rt5682s_component);
+	} else if (sof_rt5682_quirk & SOF_RT5650_HEADPHONE_CODEC_PRESENT) {
+		links[id].codecs = &rt5650_components[0];
+		links[id].num_codecs = 1;
 	} else {
 		links[id].codecs = rt5682_component;
 		links[id].num_codecs = ARRAY_SIZE(rt5682_component);
@@ -804,6 +860,11 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
 			links[id].init = max_98390_spk_codec_init;
 			links[id].ops = &max_98390_ops;
 
+		} else if (sof_rt5682_quirk & SOF_RT5650_HEADPHONE_CODEC_PRESENT) {
+			links[id].codecs = &rt5650_components[1];
+			links[id].num_codecs = 1;
+			links[id].init = rt5650_spk_init;
+			links[id].ops = &sof_rt5682_ops;
 		} else {
 			max_98357a_dai_link(&links[id]);
 		}
@@ -890,6 +951,12 @@ static int sof_audio_probe(struct platform_device *pdev)
 	/* Detect the headset codec variant */
 	if (acpi_dev_present("RTL5682", NULL, -1))
 		sof_rt5682_quirk |= SOF_RT5682S_HEADPHONE_CODEC_PRESENT;
+	else if (acpi_dev_present("10EC5650", NULL, -1)) {
+		sof_rt5682_quirk |= SOF_RT5650_HEADPHONE_CODEC_PRESENT;
+
+		sof_audio_card_rt5682.name = devm_kstrdup(&pdev->dev, "rt5650",
+							  GFP_KERNEL);
+	}
 
 	if (soc_intel_is_byt() || soc_intel_is_cht()) {
 		is_legacy_cpu = 1;
@@ -1178,6 +1245,14 @@ static const struct platform_device_id board_ids[] = {
 					SOF_RT5682_SSP_AMP(0) |
 					SOF_RT5682_NUM_HDMIDEV(3)),
 	},
+	{
+		.name = "jsl_rt5650",
+		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
+					SOF_RT5682_MCLK_24MHZ |
+					SOF_RT5682_SSP_CODEC(0) |
+					SOF_SPEAKER_AMP_PRESENT |
+					SOF_RT5682_SSP_AMP(1)),
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, board_ids);
diff --git a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
index f5c7e1bbded0..36ea2bacbe7d 100644
--- a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
@@ -34,6 +34,11 @@ static const struct snd_soc_acpi_codecs mx98360a_spk = {
 	.codecs = {"MX98360A"}
 };
 
+static struct snd_soc_acpi_codecs rt5650_spk = {
+	.num_codecs = 1,
+	.codecs = {"10EC5650"}
+};
+
 static const struct snd_soc_acpi_codecs rt5682_rt5682s_hp = {
 	.num_codecs = 2,
 	.codecs = {"10EC5682", "RTL5682"},
@@ -98,6 +103,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
 					SND_SOC_ACPI_TPLG_INTEL_SSP_MSB |
 					SND_SOC_ACPI_TPLG_INTEL_DMIC_NUMBER,
 	},
+	{
+		.id = "10EC5650",
+		.drv_name = "jsl_rt5650",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &rt5650_spk,
+		.sof_tplg_filename = "sof-jsl-rt5650-dual.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_jsl_machines);
-- 
2.34.1

