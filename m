Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DBB6A1D35
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBXOHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBXOHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:07:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D80169AD1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:07:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3F1261844
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 14:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304BDC433D2;
        Fri, 24 Feb 2023 14:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677247657;
        bh=1KhcJKnYBuXVB3sSo3IhCFYBjgAmMojaWkGnR3yIJN0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=BCG5euaPHPwa5bU6SIZwPSyv+JGLosuVrAXoh0T1j/2kSzF9nwfPE3+zNbOgR4ssl
         FslqXUUv9FNLAIjljixbWGUkb94Hf44RgVCzuQTjk2wdXkmyBNZoKUH4CGZEZu4ree
         2Ii8rJUH6h6TiyJwLZCcP6YliTZqrB7rQnNdHQVx4ME1NYAbWT37PSfWwnDXzPyhdV
         QKGaUuESYAlepZcRkaNp+fk7bPcNy2aGTw+MY+P2DrH5QhZxdV7ZVm1RqGvafAg7JW
         aSITRMmazaCe11oPNvutQ3Tihd6kvn96cPT8MXqPp94bd1SgDNist44/+5QPiaWUbZ
         NqhAseQPBpU2g==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 24 Feb 2023 14:03:55 +0000
Subject: [PATCH 1/4] ASoC: mt8192: Remove spammy log messages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-asoc-mt8192-quick-fixes-v1-1-9a85f90368e1@kernel.org>
References: <20230223-asoc-mt8192-quick-fixes-v1-0-9a85f90368e1@kernel.org>
In-Reply-To: <20230223-asoc-mt8192-quick-fixes-v1-0-9a85f90368e1@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4465; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1KhcJKnYBuXVB3sSo3IhCFYBjgAmMojaWkGnR3yIJN0=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhuQfRxYuTfByVTXWm1M3+WWct/Ysd5ZUbt+yjYp7NlTP40lw
 7TDtZDRmYWDkYpAVU2RZ+yxjVXq4xNb5j+a/ghnEygQyhYGLUwAm0sLL/lc44lTFmnsna6OOPz7DOP
 O+kWyd6aftfsaVezT+7fnOm2X4a3X15bVPuk+ucp7x9nIZH+O7fdNDDosl5GTqn85/0zPxgS5bSKtt
 yvzc419FSiYomde2LKq4lsufWcC31TCh6IxwpJiux6WFhVKupdd17yU32qjK3Htgc6F2T84G2Z0rAj
 PXdBrqvo5UdQn59OhOafNz2ae/r5VMyX+meXdf+fm8N1Z/WsNDdAV3mOjJCS9LlWrJ8ErtEz6gy8Tz
 bUHKullmzl3HDG78COsL6r5VLfbapfbU4+PcKV3ZL8x2ixvYlnTXvOkN0y1d17eYqTvX8fXJdHm/f9
 M3XDAwE2bXDzh7vyR4dtYes9/xAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a lot of info level log messages in the mt8192 ADDA driver which
are trivially triggerable from userspace, many in normal operation. Remove
these to avoid spamming the console.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8192/mt8192-dai-adda.c | 33 -----------------------------
 1 file changed, 33 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-dai-adda.c b/sound/soc/mediatek/mt8192/mt8192-dai-adda.c
index f8c73e8624df..bc8753f1001c 100644
--- a/sound/soc/mediatek/mt8192/mt8192-dai-adda.c
+++ b/sound/soc/mediatek/mt8192/mt8192-dai-adda.c
@@ -303,9 +303,6 @@ static int mtk_adda_ul_event(struct snd_soc_dapm_widget *w,
 	struct mt8192_afe_private *afe_priv = afe->platform_priv;
 	int mtkaif_dmic = afe_priv->mtkaif_dmic;
 
-	dev_info(afe->dev, "%s(), name %s, event 0x%x, mtkaif_dmic %d\n",
-		 __func__, w->name, event, mtkaif_dmic);
-
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		mt8192_afe_gpio_request(afe->dev, true, MT8192_DAI_ADDA, 1);
@@ -345,10 +342,6 @@ static int mtk_adda_ch34_ul_event(struct snd_soc_dapm_widget *w,
 	int mtkaif_dmic = afe_priv->mtkaif_dmic_ch34;
 	int mtkaif_adda6_only = afe_priv->mtkaif_adda6_only;
 
-	dev_info(afe->dev,
-		 "%s(), name %s, event 0x%x, mtkaif_dmic %d, mtkaif_adda6_only %d\n",
-		 __func__, w->name, event, mtkaif_dmic, mtkaif_adda6_only);
-
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		mt8192_afe_gpio_request(afe->dev, true, MT8192_DAI_ADDA_CH34,
@@ -538,9 +531,6 @@ static int mtk_adda_dl_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
 
-	dev_info(afe->dev, "%s(), name %s, event 0x%x\n",
-		 __func__, w->name, event);
-
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		mt8192_afe_gpio_request(afe->dev, true, MT8192_DAI_ADDA, 0);
@@ -564,9 +554,6 @@ static int mtk_adda_ch34_dl_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
 
-	dev_info(afe->dev, "%s(), name %s, event 0x%x\n",
-		 __func__, w->name, event);
-
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		mt8192_afe_gpio_request(afe->dev, true, MT8192_DAI_ADDA_CH34,
@@ -612,9 +599,6 @@ static int stf_positive_gain_set(struct snd_kcontrol *kcontrol,
 				   AFE_SIDETONE_GAIN,
 				   POSITIVE_GAIN_MASK_SFT,
 				   (gain_db / 6) << POSITIVE_GAIN_SFT);
-	} else {
-		dev_warn(afe->dev, "%s(), gain_db %d invalid\n",
-			 __func__, gain_db);
 	}
 	return 0;
 }
@@ -640,9 +624,6 @@ static int mt8192_adda_dmic_set(struct snd_kcontrol *kcontrol,
 
 	dmic_on = ucontrol->value.integer.value[0];
 
-	dev_info(afe->dev, "%s(), kcontrol name %s, dmic_on %d\n",
-		 __func__, kcontrol->id.name, dmic_on);
-
 	afe_priv->mtkaif_dmic = dmic_on;
 	afe_priv->mtkaif_dmic_ch34 = dmic_on;
 	return 0;
@@ -669,9 +650,6 @@ static int mt8192_adda6_only_set(struct snd_kcontrol *kcontrol,
 
 	mtkaif_adda6_only = ucontrol->value.integer.value[0];
 
-	dev_info(afe->dev, "%s(), kcontrol name %s, mtkaif_adda6_only %d\n",
-		 __func__, kcontrol->id.name, mtkaif_adda6_only);
-
 	afe_priv->mtkaif_adda6_only = mtkaif_adda6_only;
 	return 0;
 }
@@ -750,9 +728,6 @@ static int mtk_stf_event(struct snd_soc_dapm_widget *w,
 
 	regmap_read(afe->regmap, AFE_SIDETONE_CON1, &reg_value);
 
-	dev_info(afe->dev, "%s(), name %s, event 0x%x, ul_rate 0x%x, AFE_SIDETONE_CON1 0x%x\n",
-		 __func__, w->name, event, ul_rate, reg_value);
-
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		/* set side tone gain = 0 */
@@ -1163,12 +1138,6 @@ static int mtk_dai_adda_hw_params(struct snd_pcm_substream *substream,
 	unsigned int rate = params_rate(params);
 	int id = dai->id;
 
-	dev_info(afe->dev, "%s(), id %d, stream %d, rate %d\n",
-		 __func__,
-		 id,
-		 substream->stream,
-		 rate);
-
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		unsigned int dl_src2_con0 = 0;
 		unsigned int dl_src2_con1 = 0;
@@ -1441,8 +1410,6 @@ int mt8192_dai_adda_register(struct mtk_base_afe *afe)
 	struct mtk_base_afe_dai *dai;
 	struct mt8192_afe_private *afe_priv = afe->platform_priv;
 
-	dev_info(afe->dev, "%s()\n", __func__);
-
 	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
 	if (!dai)
 		return -ENOMEM;

-- 
2.30.2

