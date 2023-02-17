Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B130D69A9ED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjBQLLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjBQLKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:10:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349D06746B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:09:59 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9DF1E66021D1;
        Fri, 17 Feb 2023 11:09:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676632176;
        bh=gbELMwYg817UFw8p4tgNjb0vJPCHEhsb/q4OUGfCW04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FyXNbKhAN9r8zmjYArexKlKD/sL/zm9FLMU077oMf3dyp+R8wK+zT91Oc46vl+KiY
         hlbPYpApmne/scmjHyIwsIni7n6RYRFS2HP7r+Ct8OlpJiw3ZQtWBVMw+h+GYdZ3Zj
         DWXQih9MJ5S6EJjyjyAlqR5ZKSM1i3wpqwiOmiS+o+Oc5pztwONs2ba8HB5rqCaFFH
         9/o/ufBwHO+FofaHUTL1y3lHtzKaYf70mu/kD89uRHUBS2BKVhm4d5b3zLTNzlMiAQ
         W741CtTUXSmDNOsfftyow3Qs1wrCzUoWTO4u+Mo8ZUrvbeB0k1h6mjKXujryG+tB+o
         UCq/bhLZf5jmA==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH v2 9/9] ASoC: amd: vangogh: Add components prefix in structs and function names
Date:   Fri, 17 Feb 2023 11:08:50 +0000
Message-Id: <20230217110850.1045250-10-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230217110850.1045250-1-lucas.tanure@collabora.com>
References: <20230217110850.1045250-1-lucas.tanure@collabora.com>
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

Add prefixes 8821/35l41 in structs and function names so future platforms
can be added and reference the correct sound card.
Also include acp5x prefix to cs35l41_conf.

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index 367570e5c60f..e5bcd1e6eb73 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -250,7 +250,7 @@ static const struct snd_soc_ops acp5x_cs35l41_play_ops = {
 	.hw_params = acp5x_cs35l41_hw_params,
 };
 
-static struct snd_soc_codec_conf cs35l41_conf[] = {
+static struct snd_soc_codec_conf acp5x_cs35l41_conf[] = {
 	{
 		.dlc = COMP_CODEC_CONF(ACP5X_CS35L41_COMP_LNAME),
 		.name_prefix = "Left",
@@ -266,7 +266,7 @@ SND_SOC_DAILINK_DEF(cs35l41, DAILINK_COMP_ARRAY(COMP_CODEC(ACP5X_CS35L41_COMP_LN
 						COMP_CODEC(ACP5X_CS35L41_COMP_RNAME,
 							   ACP5X_CS35L41_DAI_NAME)));
 
-static struct snd_soc_dai_link acp5x_dai[] = {
+static struct snd_soc_dai_link acp5x_8821_35l41_dai[] = {
 	{
 		.name = "acp5x-8821-play",
 		.stream_name = "Playback/Capture",
@@ -294,7 +294,7 @@ static struct snd_soc_dai_link acp5x_dai[] = {
 
 
 
-static const struct snd_soc_dapm_widget acp5x_8821_widgets[] = {
+static const struct snd_soc_dapm_widget acp5x_8821_35l41_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
@@ -303,7 +303,7 @@ static const struct snd_soc_dapm_widget acp5x_8821_widgets[] = {
 			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 };
 
-static const struct snd_soc_dapm_route acp5x_8821_audio_route[] = {
+static const struct snd_soc_dapm_route acp5x_8821_35l41_audio_route[] = {
 	/* HP jack connectors - unknown if we have jack detection */
 	{ "Headphone", NULL, "HPOL" },
 	{ "Headphone", NULL, "HPOR" },
@@ -316,17 +316,17 @@ static const struct snd_soc_dapm_route acp5x_8821_audio_route[] = {
 	{ "Int Mic", NULL, "Platform Clock" },
 };
 
-static struct snd_soc_card acp5x_card = {
+static struct snd_soc_card acp5x_8821_35l41_card = {
 	.name = "acp5x",
 	.owner = THIS_MODULE,
-	.dai_link = acp5x_dai,
-	.num_links = ARRAY_SIZE(acp5x_dai),
-	.dapm_widgets = acp5x_8821_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(acp5x_8821_widgets),
-	.dapm_routes = acp5x_8821_audio_route,
-	.num_dapm_routes = ARRAY_SIZE(acp5x_8821_audio_route),
-	.codec_conf = cs35l41_conf,
-	.num_configs = ARRAY_SIZE(cs35l41_conf),
+	.dai_link = acp5x_8821_35l41_dai,
+	.num_links = ARRAY_SIZE(acp5x_8821_35l41_dai),
+	.dapm_widgets = acp5x_8821_35l41_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(acp5x_8821_35l41_widgets),
+	.dapm_routes = acp5x_8821_35l41_audio_route,
+	.num_dapm_routes = ARRAY_SIZE(acp5x_8821_35l41_audio_route),
+	.codec_conf = acp5x_cs35l41_conf,
+	.num_configs = ARRAY_SIZE(acp5x_cs35l41_conf),
 	.controls = acp5x_8821_controls,
 	.num_controls = ARRAY_SIZE(acp5x_8821_controls),
 };
@@ -363,7 +363,7 @@ static int acp5x_probe(struct platform_device *pdev)
 	dmi_check_system(acp5x_vg_quirk_table);
 	switch (acp5x_machine_id) {
 	case VG_JUPITER:
-		card = &acp5x_card;
+		card = &acp5x_8821_35l41_card;
 		break;
 	default:
 		return -ENODEV;
-- 
2.39.2

