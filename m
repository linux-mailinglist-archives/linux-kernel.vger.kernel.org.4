Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BC36FD4CF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbjEJD5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbjEJDzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:55:43 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB193C33;
        Tue,  9 May 2023 20:55:38 -0700 (PDT)
X-UUID: 81130542eee611ed9cb5633481061a41-20230510
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=GoT9X6J7wsyZip+r6sFgd43MCfrubxjY09AMi8u1NjI=;
        b=pbhgp6FSxFq/vsiEnKTGR19YggHV9kL50LgcuM/fTy1zVbBX9nXiKshm7pU8NN/6tatOnrhDzqqCfGvHIqCsGLRY9mKZZ2gd7sqCBNvoW4T6xaykanH50NqEcyaLo53g5+wVYMYwtL13sgEE4ZuQ2zpRRDKMhhvgliL63gqc6wA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:f317cad9-3690-4354-b54d-aa8268bf5c6b,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.24,REQID:f317cad9-3690-4354-b54d-aa8268bf5c6b,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:178d4d4,CLOUDID:7c1d516b-2f20-4998-991c-3b78627e4938,B
        ulkID:230510115532XQREBDNE,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 81130542eee611ed9cb5633481061a41-20230510
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 549006755; Wed, 10 May 2023 11:55:29 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 May 2023 11:55:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 May 2023 11:55:28 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 1/9] ASoC: mediatek: mt8188: remove supply AUDIO_HIRES
Date:   Wed, 10 May 2023 11:55:18 +0800
Message-ID: <20230510035526.18137-2-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230510035526.18137-1-trevor.wu@mediatek.com>
References: <20230510035526.18137-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AUDIO_HIRES is not required in MT8188. Because top_audio_h is disabled
when hires clock is not used, set_parent is a redundant operation.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/mt8188/mt8188-dai-adda.c | 37 ---------------------
 1 file changed, 37 deletions(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-dai-adda.c b/sound/soc/mediatek/mt8188/mt8188-dai-adda.c
index d71696901553..fed9f927e623 100644
--- a/sound/soc/mediatek/mt8188/mt8188-dai-adda.c
+++ b/sound/soc/mediatek/mt8188/mt8188-dai-adda.c
@@ -18,7 +18,6 @@
 #define ADDA_HIRES_THRES 48000
 
 enum {
-	SUPPLY_SEQ_CLOCK_SEL,
 	SUPPLY_SEQ_ADDA_DL_ON,
 	SUPPLY_SEQ_ADDA_MTKAIF_CFG,
 	SUPPLY_SEQ_ADDA_UL_ON,
@@ -242,34 +241,6 @@ static int mtk_adda_ul_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int mtk_audio_hires_event(struct snd_soc_dapm_widget *w,
-				 struct snd_kcontrol *kcontrol,
-				 int event)
-{
-	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
-	struct mt8188_afe_private *afe_priv = afe->platform_priv;
-	struct clk *clk = afe_priv->clk[MT8188_CLK_TOP_AUDIO_H_SEL];
-	struct clk *clk_parent;
-
-	dev_dbg(afe->dev, "%s(), name %s, event 0x%x\n",
-		__func__, w->name, event);
-
-	switch (event) {
-	case SND_SOC_DAPM_PRE_PMU:
-		clk_parent = afe_priv->clk[MT8188_CLK_APMIXED_APLL1];
-		break;
-	case SND_SOC_DAPM_POST_PMD:
-		clk_parent = afe_priv->clk[MT8188_CLK_XTAL_26M];
-		break;
-	default:
-		return 0;
-	}
-	mt8188_afe_set_clk_parent(afe, clk, clk_parent);
-
-	return 0;
-}
-
 static int mtk_afe_adc_hires_connect(struct snd_soc_dapm_widget *source,
 				     struct snd_soc_dapm_widget *sink)
 {
@@ -364,12 +335,6 @@ static const struct snd_soc_dapm_widget mtk_dai_adda_widgets[] = {
 			      mtk_adda_ul_event,
 			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 
-	SND_SOC_DAPM_SUPPLY_S("AUDIO_HIRES", SUPPLY_SEQ_CLOCK_SEL,
-			      SND_SOC_NOPM,
-			      0, 0,
-			      mtk_audio_hires_event,
-			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
-
 	SND_SOC_DAPM_SUPPLY_S("ADDA_MTKAIF_CFG", SUPPLY_SEQ_ADDA_MTKAIF_CFG,
 			      SND_SOC_NOPM,
 			      0, 0,
@@ -397,7 +362,6 @@ static const struct snd_soc_dapm_route mtk_dai_adda_routes[] = {
 	{"ADDA Capture", NULL, "ADDA_MTKAIF_CFG"},
 	{"ADDA Capture", NULL, "aud_adc"},
 	{"ADDA Capture", NULL, "aud_adc_hires", mtk_afe_adc_hires_connect},
-	{"aud_adc_hires", NULL, "AUDIO_HIRES"},
 
 	{"I168", NULL, "ADDA Capture"},
 	{"I169", NULL, "ADDA Capture"},
@@ -406,7 +370,6 @@ static const struct snd_soc_dapm_route mtk_dai_adda_routes[] = {
 	{"ADDA Playback", NULL, "ADDA Playback Enable"},
 	{"ADDA Playback", NULL, "aud_dac"},
 	{"ADDA Playback", NULL, "aud_dac_hires", mtk_afe_dac_hires_connect},
-	{"aud_dac_hires", NULL, "AUDIO_HIRES"},
 
 	{"DL_GAIN", NULL, "O176"},
 	{"DL_GAIN", NULL, "O177"},
-- 
2.18.0

