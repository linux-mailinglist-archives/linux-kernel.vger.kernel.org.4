Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CF261F848
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiKGQFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiKGQFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:05:25 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D592099B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:05:14 -0800 (PST)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D1D266602965;
        Mon,  7 Nov 2022 16:05:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667837113;
        bh=oWRkrDOmNJ2dmIVe5ehfgdnkPnZtvtRMYH1LSztA4/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RPN1eQI+7jezHkamwk1HZ83zy7ukfs4L6sTCR6xZHpu/bu1zpRls/3yENC7JX7xvR
         a/FoukoFapv9GKGXxmAiAF89zt6I4untu+Unf5lDZxoIbFoXqrwLV/0KYafeZOlKXx
         /SdtT5fK7JCl75PnyRZ+mbhOvToMtYXVoVhlRyZHBvlF5BxYDs/0fOVLCVKDzAuFPf
         FXkO73a5CVSewIyHYP9P8QhRLITCkE+3ZW9iKMhVI5RyPoEtksEDFMHTAEy9GvdUfI
         YAN9xsthNEmATiRdln1fYBhhweSTNXFiBVeF32tvUhXJT0xUbTMxuuDg36DhuGoRbc
         OF1/GDse4c1SA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 8/9] ASoC: mediatek: mt8192-mt6359: Register to module device table
Date:   Mon,  7 Nov 2022 11:04:36 -0500
Message-Id: <20221107160437.740353-9-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107160437.740353-1-nfraprado@collabora.com>
References: <20221107160437.740353-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the compatibles for this module on the module device table so
it can be automatically loaded when a matching device is found on the
system.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index b93c3237ef2d..16660eda577e 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -1261,6 +1261,7 @@ static const struct of_device_id mt8192_mt6359_dt_match[] = {
 	},
 	{}
 };
+MODULE_DEVICE_TABLE(of, mt8192_mt6359_dt_match);
 #endif
 
 static const struct dev_pm_ops mt8192_mt6359_pm_ops = {
-- 
2.38.1

