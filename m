Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E764969915A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjBPKdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjBPKdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:33:47 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8730F20057
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:33:17 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 18B78660219B;
        Thu, 16 Feb 2023 10:33:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676543596;
        bh=Lavf09jyhdS+ewCEWzduKnGfji+NNs/v8MNjkeD6LV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SdYotCyjGxEC59z5vvsg8tUCHQYuttvDuoXkFA2KqDTlWwbX9m3zi8pqClqyMzoWT
         FAfGrJAFU90XrJ4p0WRrX7q4CQoqDOHjgxhcOHLm04Yn+BY2VRJBOYzH7udzIuHtNj
         OLfuJvJZ4YtSFgXI4FQAPLFOu2hfckb6Q8EH2sJjanAAAwxbcO2zrXjVWK3NHMVhOg
         z3TZzb4qPkXNRjvMMjA+lHQF5d+v5nOCLtkG6NHIj7AMzEx1PnRYNAcSXxklBWeXVl
         lCl+H0Rn6Yn0mkOTwZsbCRZUCWH9HeK1NiX5qqcbb9Xc+f/K+Fvo8SVzGZR5/JdsUP
         +FRCSFW7JvLgg==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH 1/9] ASoC: amd: vangogh: Remove unnecessary init function
Date:   Thu, 16 Feb 2023 10:32:52 +0000
Message-Id: <20230216103300.360016-2-lucas.tanure@collabora.com>
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

Remove empty acp5x_cs35l41_init function

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index eebf2650ad27..5bd9418919a0 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -73,11 +73,6 @@ static int acp5x_8821_init(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
-static int acp5x_cs35l41_init(struct snd_soc_pcm_runtime *rtd)
-{
-	return 0;
-}
-
 static const unsigned int rates[] = {
 	48000,
 };
@@ -258,7 +253,6 @@ static struct snd_soc_dai_link acp5x_dai[] = {
 		.dpcm_playback = 1,
 		.playback_only = 1,
 		.ops = &acp5x_cs35l41_play_ops,
-		.init = acp5x_cs35l41_init,
 		SND_SOC_DAILINK_REG(acp5x_bt, cs35l41, platform),
 	},
 };
-- 
2.39.2

