Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769E0706C6B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjEQPPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjEQPPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:15:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A913A5DE
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:15:23 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 999F4660574E;
        Wed, 17 May 2023 16:15:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684336521;
        bh=JXHlQGqLZnwEd+1ywgBD3qSPq+lFVpm0deC33quGJxg=;
        h=From:To:Cc:Subject:Date:From;
        b=hU6gxKKpauEvIDnRRvhNe5X+xvq1mbElAP7P78bkk/hHN4XTRExPEbV+YZ3Pzhtid
         kKq19X8KSghlsJ399B8CEZafU6kvVxFno7r6UGH+R2DBgq8QUdvrC6qDrCyhdhl0CW
         Q/Jy9PIGGy4HAtAzB/Pzto/dUnSC2l4QAe9h/LsXsJ/Yz8XirEyQfAtP8CzMgjG8T0
         j6bPn2QLepvjETscRoG1aV4+9GcnZTs3VzscIdM88AxfkjKOPTHeImTgIBFTHTx6zq
         tWvrb/HDXVO7OY2eRSXaPzukoqLGZp4l27t/Yl50Ec2cXqRak34CuP/WjdzTV3iKzT
         oMYE3MMzvdNew==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        nfraprado@collabora.com, wenst@chromium.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH] ASoC: mediatek: mt8192-mt6359: Remove " Jack" from Headphone pin name
Date:   Wed, 17 May 2023 17:15:16 +0200
Message-Id: <20230517151516.343037-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
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

Function jack_kctl_name_gen() will remove the redundant " Jack" from
the name, if present, and then it will add it back, so that all of
the controls are named "(pin-name) Jack".

Remove " Jack" from the Headphone pin name to spare some CPU cycles.

This commit brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index 5e163e23a207..4e0d5bf12b47 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -46,7 +46,7 @@ struct mt8192_mt6359_priv {
 /* Headset jack detection DAPM pins */
 static struct snd_soc_jack_pin mt8192_jack_pins[] = {
 	{
-		.pin = "Headphone Jack",
+		.pin = "Headphone",
 		.mask = SND_JACK_HEADPHONE,
 	},
 	{
-- 
2.40.1

