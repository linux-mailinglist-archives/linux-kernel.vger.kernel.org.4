Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96D1748543
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjGENnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjGENnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:43:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA189E5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 06:43:49 -0700 (PDT)
Received: from localhost (unknown [188.24.137.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 711FB6606FB0;
        Wed,  5 Jul 2023 14:43:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688564628;
        bh=VTB4I9zZ57rcfuMONYpW7VWpXed1exZT873tCPi37oM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZywCBNp5GSeyrfKC+xwH0a4fNqw7bSAIOTfRidQahanxqberP+eTkhTIiLCn0yV8J
         LRJJgqFxN/m8Fqyx61ukOLsp5quivZwQOSckUQOrsMkcRkpyRnYtls1505wk6z3IWC
         /RhrASG5Ans9qt/Fp1JJ4dQ9rj2DoBjsLH6tecJaBsDng10jGb7UnB/NdImQraYSBt
         93X+EaOivgdjo/5+8uNEkox2/J3lX4DNNDyot9NnbIX3ipkXuMsvh+0IpN+ExV2zRW
         VET38zRn3uJlbyUCqXMvPMxdFDnPwrlHsJ71Ogj/46j/uysBq1dK0WMPzZvQnzs0yK
         xSxI1AIZUy2sw==
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
Subject: [PATCH v2 1/3] ASoC: amd: vangogh: Make use of DRV_NAME
Date:   Wed,  5 Jul 2023 16:43:39 +0300
Message-ID: <20230705134341.175889-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705134341.175889-1-cristian.ciocaltea@collabora.com>
References: <20230705134341.175889-1-cristian.ciocaltea@collabora.com>
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

