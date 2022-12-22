Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD62653C7C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 08:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiLVHXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 02:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiLVHXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 02:23:18 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275FD22B01;
        Wed, 21 Dec 2022 23:23:10 -0800 (PST)
X-UUID: f2bcbfd6031243bbb112612c8ca7fdfa-20221222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=I5wbPKHKnzWyiSg3WCvRk7OUYhVp4BGRWfdopNLnhGk=;
        b=d2sTv/8jF5bPfHj7Xv7Z9ehY+L1BdOBXYeZrNeogBsn0jg7gOYjQ7OrhNydv0mh/WxTipxs06JZQe5GQ0ogZ7qkyWDD3VGTL6FpTZG+U7pKZ/3v8wFsOMkv8UOPRv6+rQLxbl7IBo2AVUJ767asB4jpvEyOD2Dxjg9KpIOGjhFg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:dc0f5937-4eae-4fb7-ba80-4ec207178d23,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.14,REQID:dc0f5937-4eae-4fb7-ba80-4ec207178d23,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:dcaaed0,CLOUDID:b976178a-8530-4eff-9f77-222cf6e2895b,B
        ulkID:221222152307TWEQSHSI,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: f2bcbfd6031243bbb112612c8ca7fdfa-20221222
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 509231344; Thu, 22 Dec 2022 15:23:06 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 22 Dec 2022 15:23:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 22 Dec 2022 15:23:05 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Chunxu Li <chunxu.li@mediatek.com>,
        Dan Carpenter <error27@gmail.com>,
        YC Hung <yc.hung@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <sound-open-firmware@alsa-project.org>,
        <alsa-devel@alsa-project.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v1 3/3] ASoC: SOF: mediatek: Provide debugfs_add_region_item ops for core
Date:   Thu, 22 Dec 2022 15:21:50 +0800
Message-ID: <20221222072150.10627-4-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221222072150.10627-1-tinghan.shen@mediatek.com>
References: <20221222072150.10627-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the generic iomem callback for debugfs_add_region_item to support
sof-logger.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/mediatek/mt8186/mt8186.c | 3 +++
 sound/soc/sof/mediatek/mt8195/mt8195.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/sound/soc/sof/mediatek/mt8186/mt8186.c b/sound/soc/sof/mediatek/mt8186/mt8186.c
index af0dfc2fc4cc..dbea604ebc04 100644
--- a/sound/soc/sof/mediatek/mt8186/mt8186.c
+++ b/sound/soc/sof/mediatek/mt8186/mt8186.c
@@ -588,6 +588,9 @@ static struct snd_sof_dsp_ops sof_mt8186_ops = {
 	.drv		= mt8186_dai,
 	.num_drv	= ARRAY_SIZE(mt8186_dai),
 
+	/* Debug information */
+	.debugfs_add_region_item = snd_sof_debugfs_add_region_item_iomem,
+
 	/* PM */
 	.suspend	= mt8186_dsp_suspend,
 	.resume		= mt8186_dsp_resume,
diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index 3c81e84fcecf..11ceff3acc54 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -642,6 +642,7 @@ static struct snd_sof_dsp_ops sof_mt8195_ops = {
 
 	/* Debug information */
 	.dbg_dump = mt8195_adsp_dump,
+	.debugfs_add_region_item = snd_sof_debugfs_add_region_item_iomem,
 
 	/* DAI drivers */
 	.drv = mt8195_dai,
-- 
2.18.0

