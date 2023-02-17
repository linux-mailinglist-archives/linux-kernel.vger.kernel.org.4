Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5362C69A9E5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBQLKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjBQLKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:10:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F9F6536C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:09:35 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 42C80660212C;
        Fri, 17 Feb 2023 11:09:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676632174;
        bh=Lavf09jyhdS+ewCEWzduKnGfji+NNs/v8MNjkeD6LV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GMyJPqhYCuxwVTGB2Mr1nfVnR8dNJyvk1wUJG5Db2PG4wXrf43ucbFDymO23abiHe
         +RD9MhUAN3LcrrMfMPR1XaX6tBFtHwBumoRo9N0jKMz2IOeIh2D/kuVu7m0edqFCFz
         +/HxvVPI342Rrj4uIhCCX9SZemzd/PK9ZEQOlCfgoxPw66dR3kY8IoDrCaJLQzCzWa
         4m9uDo2tFuFZebzaRt+hJVDFKgL9ZyYDgDLIDexrYV5JoURpLqBaGKWaZWJbvZJQlJ
         rBxG+suG1AwaRYqZXNskWmtxu0OoY3HWU4bu1/+j8UcQG8e07ZuTFti0tMImT+1sP8
         aj46qY5YlFikQ==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH v2 1/9] ASoC: amd: vangogh: Remove unnecessary init function
Date:   Fri, 17 Feb 2023 11:08:42 +0000
Message-Id: <20230217110850.1045250-2-lucas.tanure@collabora.com>
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

