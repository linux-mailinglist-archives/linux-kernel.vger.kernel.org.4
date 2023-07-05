Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC62749025
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjGEVsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjGEVsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:48:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DAE198E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 14:48:09 -0700 (PDT)
Received: from localhost (unknown [188.24.137.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1874C6606F9F;
        Wed,  5 Jul 2023 22:48:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688593688;
        bh=VTB4I9zZ57rcfuMONYpW7VWpXed1exZT873tCPi37oM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQFVyoMKB0OqLynwIk63QP7mYFo2d0969SBpY7m2h/uP4rnElyu4enFCXc7tI6K/C
         4o7881+ipfyOAHQS3a7GKwU1gyAFQuadTOmBxFLJr/yOiOYu7HJ6VNH2iLCf+GLzTX
         EuclGphI/aQfIhlLAI31lGha7xv6mLQlQL+Tesb77UFAtXASdISNpwZs7NNWZ3Zift
         WgmYcKhjAv0gz5WotbgEh+GlsNrQvFXRDLrFCpYvl/emtuS3ISDRl0Yvqg5n2FG6fW
         vrZLJb4AnrolDtfF3dSh7eghnPGABBHSXeSLIPTbnX3bBLzaJ66LG/9xsDqSIsnFnf
         m7GoKeB8MNZgg==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v3 1/3] ASoC: amd: vangogh: Make use of DRV_NAME
Date:   Thu,  6 Jul 2023 00:47:58 +0300
Message-ID: <20230705214800.193244-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705214800.193244-1-cristian.ciocaltea@collabora.com>
References: <20230705214800.193244-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "acp5x_mach" string is provided for both driver name and
MODULE_ALIAS. Since they need to match, ensure DRV_NAME macro is used in
both locations.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index e5bcd1e6eb73..5e36179cf611 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -381,7 +381,7 @@ static int acp5x_probe(struct platform_device *pdev)
 
 static struct platform_driver acp5x_mach_driver = {
 	.driver = {
-		.name = "acp5x_mach",
+		.name = DRV_NAME,
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = acp5x_probe,
-- 
2.41.0

