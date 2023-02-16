Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B13D699163
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjBPKeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjBPKd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:33:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0974D241E1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:33:48 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8386566021A2;
        Thu, 16 Feb 2023 10:33:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676543598;
        bh=UYYJ0M2hdv/ks6BhqzkrJ1QZa+6pdX9WvWLId0MXbes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=htA0/nVIfuHIK/ZlEBWjGYeFc0DijyYp0DzlKu2YTcm+yiPCm0zhTUEpwo96JG4Rx
         UFmBf/1gABVxj3WthcHUt/cn4iVtZ9VTDHVPrY4D+cH87kBMICI7f+/H3/TCBa4iAF
         W3RRIy40XQdW1JCKYGZcP7/8EQhbYKVQ2cn7NoMSDx7HXlBgBCp6PLbBqXE3nVMQ9m
         6HNC7dfgHQedpEj34syVxc3nSyzPLGWFbJEYw1okzF80Iiq+nTHo5W8ey7j1ZKQ0Ht
         XZbJhFI9KK2VSxTQR4Pi0YI1YFMd5meKCfvya+BVu8XNJ3zzaaBk3Y0nKc5kN4tZ9p
         9UL6lMKGkPmqQ==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH 9/9] ASoC: amd: vangogh: Include cs35l41 in structs names
Date:   Thu, 16 Feb 2023 10:33:00 +0000
Message-Id: <20230216103300.360016-10-lucas.tanure@collabora.com>
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

Include cs35l41 in structs names so future platforms can be added and
reference the correct sound card

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index 74c7b267dcfd..129cadcdf468 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -251,7 +251,7 @@ static struct snd_soc_codec_conf cs35l41_conf[] = {
 SND_SOC_DAILINK_DEF(cs35l41, DAILINK_COMP_ARRAY(COMP_CODEC(CS35L41_LNAME, CS35L41_DAI),
 						COMP_CODEC(CS35L41_RNAME, CS35L41_DAI)));
 
-static struct snd_soc_dai_link acp5x_dai[] = {
+static struct snd_soc_dai_link acp5x_8821_35l41_dai[] = {
 	{
 		.name = "acp5x-8821-play",
 		.stream_name = "Playback/Capture",
@@ -273,7 +273,7 @@ static struct snd_soc_dai_link acp5x_dai[] = {
 	},
 };
 
-static const struct snd_soc_dapm_widget acp5x_8821_widgets[] = {
+static const struct snd_soc_dapm_widget acp5x_8821_35l41_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
@@ -281,7 +281,7 @@ static const struct snd_soc_dapm_widget acp5x_8821_widgets[] = {
 			    platform_clock_control, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 };
 
-static const struct snd_soc_dapm_route acp5x_8821_audio_route[] = {
+static const struct snd_soc_dapm_route acp5x_8821_35l41_audio_route[] = {
 	/* HP jack connectors - unknown if we have jack detection */
 	{ "Headphone", NULL, "HPOL" },
 	{ "Headphone", NULL, "HPOR" },
@@ -294,15 +294,15 @@ static const struct snd_soc_dapm_route acp5x_8821_audio_route[] = {
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
+	.dai_link = acp5x_8821_35l41_dai,
+	.num_links = ARRAY_SIZE(acp5x_8821_35l41_dai),
+	.dapm_widgets = acp5x_8821_35l41_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(acp5x_8821_35l41_widgets),
+	.dapm_routes = acp5x_8821_35l41_audio_route,
+	.num_dapm_routes = ARRAY_SIZE(acp5x_8821_35l41_audio_route),
 	.codec_conf = cs35l41_conf,
 	.num_configs = ARRAY_SIZE(cs35l41_conf),
 	.controls = acp5x_8821_controls,
@@ -341,7 +341,7 @@ static int acp5x_probe(struct platform_device *pdev)
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

