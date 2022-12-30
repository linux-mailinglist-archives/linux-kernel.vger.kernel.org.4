Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6CF659526
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 06:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbiL3FzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 00:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiL3FzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 00:55:02 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B8615733;
        Thu, 29 Dec 2022 21:54:56 -0800 (PST)
X-UUID: 707a25d987174d078e2aa845c5188811-20221230
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gIWP4FCWoysfzcgKdDMeCix44Wh8hNSOFxeqzvUS/k8=;
        b=SOpjvAAfPv0w9TE0uGFKZPdw6RKUcaOO+qcEuyC6c0RELDU1VLfA7zBp5e1wlVpL3TAVkwgitnvbnMVXv/PrIJJK2k87MonO4rb8sIUm7fA9Ar4aIFlkZDYLnpdwhIEzitd1dfKcuLSMhaj3Pv3DtHeCF1KaIJPkETke0776l4o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.16,REQID:1b7f7697-4d89-4856-adde-5848d8194a02,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:09771b1,CLOUDID:0d33d18a-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 707a25d987174d078e2aa845c5188811-20221230
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1274597633; Fri, 30 Dec 2022 13:54:50 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 30 Dec 2022 13:54:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 30 Dec 2022 13:54:49 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <p.zabel@pengutronix.de>
CC:     <trevor.wu@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 06/13] ASoC: mediatek: mt8188: support pcmif in platform driver
Date:   Fri, 30 Dec 2022 13:54:36 +0800
Message-ID: <20221230055443.16024-7-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221230055443.16024-1-trevor.wu@mediatek.com>
References: <20221230055443.16024-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mt8188 pcmif dai driver support

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/mt8188/mt8188-dai-pcm.c | 367 +++++++++++++++++++++
 1 file changed, 367 insertions(+)
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-dai-pcm.c

diff --git a/sound/soc/mediatek/mt8188/mt8188-dai-pcm.c b/sound/soc/mediatek/mt8188/mt8188-dai-pcm.c
new file mode 100644
index 000000000000..3f1696dcf81c
--- /dev/null
+++ b/sound/soc/mediatek/mt8188/mt8188-dai-pcm.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MediaTek ALSA SoC Audio DAI PCM I/F Control
+ *
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Bicycle Tsai <bicycle.tsai@mediatek.com>
+ *         Trevor Wu <trevor.wu@mediatek.com>
+ *         Chun-Chia Chiu <chun-chia.chiu@mediatek.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/regmap.h>
+#include <sound/pcm_params.h>
+#include "mt8188-afe-clk.h"
+#include "mt8188-afe-common.h"
+#include "mt8188-reg.h"
+
+enum {
+	MTK_DAI_PCM_FMT_I2S,
+	MTK_DAI_PCM_FMT_EIAJ,
+	MTK_DAI_PCM_FMT_MODEA,
+	MTK_DAI_PCM_FMT_MODEB,
+};
+
+enum {
+	MTK_DAI_PCM_CLK_A1SYS,
+	MTK_DAI_PCM_CLK_A2SYS,
+	MTK_DAI_PCM_CLK_26M_48K,
+	MTK_DAI_PCM_CLK_26M_441K,
+};
+
+struct mtk_dai_pcm_rate {
+	unsigned int rate;
+	unsigned int reg_value;
+};
+
+struct mtk_dai_pcmif_priv {
+	unsigned int slave_mode;
+	unsigned int lrck_inv;
+	unsigned int bck_inv;
+	unsigned int format;
+};
+
+static const struct mtk_dai_pcm_rate mtk_dai_pcm_rates[] = {
+	{ .rate = 8000, .reg_value = 0, },
+	{ .rate = 16000, .reg_value = 1, },
+	{ .rate = 32000, .reg_value = 2, },
+	{ .rate = 48000, .reg_value = 3, },
+	{ .rate = 11025, .reg_value = 1, },
+	{ .rate = 22050, .reg_value = 2, },
+	{ .rate = 44100, .reg_value = 3, },
+};
+
+static int mtk_dai_pcm_mode(unsigned int rate)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mtk_dai_pcm_rates); i++)
+		if (mtk_dai_pcm_rates[i].rate == rate)
+			return mtk_dai_pcm_rates[i].reg_value;
+
+	return -EINVAL;
+}
+
+static const struct snd_kcontrol_new mtk_dai_pcm_o000_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("I000 Switch", AFE_CONN0, 0, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I070 Switch", AFE_CONN0_2, 6, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_dai_pcm_o001_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("I001 Switch", AFE_CONN1, 1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I071 Switch", AFE_CONN1_2, 7, 1, 0),
+};
+
+static const struct snd_soc_dapm_widget mtk_dai_pcm_widgets[] = {
+	SND_SOC_DAPM_MIXER("I002", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("I003", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("O000", SND_SOC_NOPM, 0, 0,
+			   mtk_dai_pcm_o000_mix,
+			   ARRAY_SIZE(mtk_dai_pcm_o000_mix)),
+	SND_SOC_DAPM_MIXER("O001", SND_SOC_NOPM, 0, 0,
+			   mtk_dai_pcm_o001_mix,
+			   ARRAY_SIZE(mtk_dai_pcm_o001_mix)),
+
+	SND_SOC_DAPM_SUPPLY("PCM_1_EN", PCM_INTF_CON1, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_INPUT("PCM1_INPUT"),
+	SND_SOC_DAPM_OUTPUT("PCM1_OUTPUT"),
+
+	SND_SOC_DAPM_CLOCK_SUPPLY("aud_asrc11"),
+	SND_SOC_DAPM_CLOCK_SUPPLY("aud_asrc12"),
+	SND_SOC_DAPM_CLOCK_SUPPLY("aud_pcmif"),
+};
+
+static const struct snd_soc_dapm_route mtk_dai_pcm_routes[] = {
+	{"I002", NULL, "PCM1 Capture"},
+	{"I003", NULL, "PCM1 Capture"},
+
+	{"O000", "I000 Switch", "I000"},
+	{"O001", "I001 Switch", "I001"},
+
+	{"O000", "I070 Switch", "I070"},
+	{"O001", "I071 Switch", "I071"},
+
+	{"PCM1 Playback", NULL, "O000"},
+	{"PCM1 Playback", NULL, "O001"},
+
+	{"PCM1 Playback", NULL, "PCM_1_EN"},
+	{"PCM1 Playback", NULL, "aud_asrc12"},
+	{"PCM1 Playback", NULL, "aud_pcmif"},
+
+	{"PCM1 Capture", NULL, "PCM_1_EN"},
+	{"PCM1 Capture", NULL, "aud_asrc11"},
+	{"PCM1 Capture", NULL, "aud_pcmif"},
+
+	{"PCM1_OUTPUT", NULL, "PCM1 Playback"},
+	{"PCM1 Capture", NULL, "PCM1_INPUT"},
+};
+
+static int mtk_dai_pcm_configure(struct snd_pcm_substream *substream,
+				 struct snd_soc_dai *dai)
+{
+	struct snd_pcm_runtime * const runtime = substream->runtime;
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	struct mt8188_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_dai_pcmif_priv *pcmif_priv = NULL;
+	unsigned int slave_mode;
+	unsigned int lrck_inv;
+	unsigned int bck_inv;
+	unsigned int fmt;
+	unsigned int bit_width = dai->sample_bits;
+	unsigned int val = 0;
+	unsigned int mask = 0;
+	int fs = 0;
+	int mode = 0;
+
+	if (dai->id < 0)
+		return -EINVAL;
+
+	pcmif_priv = afe_priv->dai_priv[dai->id];
+	slave_mode = pcmif_priv->slave_mode;
+	lrck_inv = pcmif_priv->lrck_inv;
+	bck_inv = pcmif_priv->bck_inv;
+	fmt = pcmif_priv->format;
+
+	/* sync freq mode */
+	fs = mt8188_afe_fs_timing(runtime->rate);
+	if (fs < 0)
+		return -EINVAL;
+
+	val |= FIELD_PREP(PCM_INTF_CON2_SYNC_FREQ_MODE_MASK, fs);
+	mask |= PCM_INTF_CON2_SYNC_FREQ_MODE_MASK;
+
+	/* clk domain sel */
+	if (runtime->rate % 8000)
+		val |= FIELD_PREP(PCM_INTF_CON2_CLK_DOMAIN_SEL_MASK,
+				  MTK_DAI_PCM_CLK_26M_441K);
+	else
+		val |= FIELD_PREP(PCM_INTF_CON2_CLK_DOMAIN_SEL_MASK,
+				  MTK_DAI_PCM_CLK_26M_48K);
+	mask |= PCM_INTF_CON2_CLK_DOMAIN_SEL_MASK;
+
+	regmap_update_bits(afe->regmap, PCM_INTF_CON2, mask, val);
+
+	val = 0;
+	mask = 0;
+
+	/* pcm mode */
+	mode = mtk_dai_pcm_mode(runtime->rate);
+	if (mode < 0)
+		return -EINVAL;
+
+	val |= FIELD_PREP(PCM_INTF_CON1_PCM_MODE_MASK, mode);
+	mask |= PCM_INTF_CON1_PCM_MODE_MASK;
+
+	/* pcm format */
+	val |= FIELD_PREP(PCM_INTF_CON1_PCM_FMT_MASK, fmt);
+	mask |= PCM_INTF_CON1_PCM_FMT_MASK;
+
+	/* pcm sync length */
+	if (fmt == MTK_DAI_PCM_FMT_MODEA ||
+	    fmt == MTK_DAI_PCM_FMT_MODEB)
+		val |= FIELD_PREP(PCM_INTF_CON1_SYNC_LENGTH_MASK, 1);
+	else
+		val |= FIELD_PREP(PCM_INTF_CON1_SYNC_LENGTH_MASK, bit_width);
+	mask |= PCM_INTF_CON1_SYNC_LENGTH_MASK;
+
+	/* pcm bits, word length */
+	if (bit_width > 16) {
+		val |= PCM_INTF_CON1_PCM_24BIT;
+		val |= PCM_INTF_CON1_PCM_WLEN_64BCK;
+	} else {
+		val |= PCM_INTF_CON1_PCM_16BIT;
+		val |= PCM_INTF_CON1_PCM_WLEN_32BCK;
+	}
+	mask |= PCM_INTF_CON1_PCM_BIT_MASK;
+	mask |= PCM_INTF_CON1_PCM_WLEN_MASK;
+
+	/* master/slave */
+	if (!slave_mode) {
+		val |= PCM_INTF_CON1_PCM_MASTER;
+
+		if (lrck_inv)
+			val |= PCM_INTF_CON1_SYNC_OUT_INV;
+		if (bck_inv)
+			val |= PCM_INTF_CON1_BCLK_OUT_INV;
+		mask |= PCM_INTF_CON1_CLK_OUT_INV_MASK;
+	} else {
+		val |= PCM_INTF_CON1_PCM_SLAVE;
+
+		if (lrck_inv)
+			val |= PCM_INTF_CON1_SYNC_IN_INV;
+		if (bck_inv)
+			val |= PCM_INTF_CON1_BCLK_IN_INV;
+		mask |= PCM_INTF_CON1_CLK_IN_INV_MASK;
+
+		// TODO: add asrc setting for slave mode
+	}
+	mask |= PCM_INTF_CON1_PCM_M_S_MASK;
+
+	regmap_update_bits(afe->regmap, PCM_INTF_CON1, mask, val);
+
+	return 0;
+}
+
+/* dai ops */
+static int mtk_dai_pcm_prepare(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
+{
+	if (dai->playback_widget->active || dai->capture_widget->active)
+		return 0;
+
+	return mtk_dai_pcm_configure(substream, dai);
+}
+
+static int mtk_dai_pcm_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	struct mt8188_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_dai_pcmif_priv *pcmif_priv = NULL;
+
+	dev_dbg(dai->dev, "%s fmt 0x%x\n", __func__, fmt);
+
+	if (dai->id < 0)
+		return -EINVAL;
+
+	pcmif_priv = afe_priv->dai_priv[dai->id];
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		pcmif_priv->format = MTK_DAI_PCM_FMT_I2S;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		pcmif_priv->format = MTK_DAI_PCM_FMT_MODEA;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		pcmif_priv->format = MTK_DAI_PCM_FMT_MODEB;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		pcmif_priv->bck_inv = 0;
+		pcmif_priv->lrck_inv = 0;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		pcmif_priv->bck_inv = 0;
+		pcmif_priv->lrck_inv = 1;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		pcmif_priv->bck_inv = 1;
+		pcmif_priv->lrck_inv = 0;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		pcmif_priv->bck_inv = 1;
+		pcmif_priv->lrck_inv = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_BC_FC:
+		pcmif_priv->slave_mode = 1;
+		break;
+	case SND_SOC_DAIFMT_BP_FP:
+		pcmif_priv->slave_mode = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops mtk_dai_pcm_ops = {
+	.prepare	= mtk_dai_pcm_prepare,
+	.set_fmt	= mtk_dai_pcm_set_fmt,
+};
+
+/* dai driver */
+#define MTK_PCM_RATES (SNDRV_PCM_RATE_8000_48000)
+
+#define MTK_PCM_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S24_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver mtk_dai_pcm_driver[] = {
+	{
+		.name = "PCM1",
+		.id = MT8188_AFE_IO_PCM,
+		.playback = {
+			.stream_name = "PCM1 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.capture = {
+			.stream_name = "PCM1 Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mtk_dai_pcm_ops,
+		.symmetric_rate = 1,
+		.symmetric_sample_bits = 1,
+	},
+};
+
+static int init_pcmif_priv_data(struct mtk_base_afe *afe)
+{
+	struct mt8188_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_dai_pcmif_priv *pcmif_priv;
+
+	pcmif_priv = devm_kzalloc(afe->dev, sizeof(struct mtk_dai_pcmif_priv),
+				  GFP_KERNEL);
+	if (!pcmif_priv)
+		return -ENOMEM;
+
+	afe_priv->dai_priv[MT8188_AFE_IO_PCM] = pcmif_priv;
+	return 0;
+}
+
+int mt8188_dai_pcm_register(struct mtk_base_afe *afe)
+{
+	struct mtk_base_afe_dai *dai;
+
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	list_add(&dai->list, &afe->sub_dais);
+
+	dai->dai_drivers = mtk_dai_pcm_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(mtk_dai_pcm_driver);
+
+	dai->dapm_widgets = mtk_dai_pcm_widgets;
+	dai->num_dapm_widgets = ARRAY_SIZE(mtk_dai_pcm_widgets);
+	dai->dapm_routes = mtk_dai_pcm_routes;
+	dai->num_dapm_routes = ARRAY_SIZE(mtk_dai_pcm_routes);
+
+	return init_pcmif_priv_data(afe);
+}
-- 
2.18.0

