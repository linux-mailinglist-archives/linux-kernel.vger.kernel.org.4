Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63C264D65A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiLOGLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLOGLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:11:08 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E9817E20
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:11:02 -0800 (PST)
X-UUID: 902477fd707542469273d357e6f800f1-20221215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=mzkH0/QhnNUKthB0EOesphpVmgsLNcxmI7NqMZkJnhE=;
        b=pzWs8r94mRD5UUOhx3C5NTXdpT+8Y1Q6/+HZvyMYcObi0HfOmjL9uPlsho4yrFmpA47fJBKpwWZqxTYUhC/R2AYjoRfT+iUicpj7cX3ndsdMRIF3X6jt3x9EPCsucmA0RTpd31Vb/a3fTNPUUyiDkRheuRy8LxDQvUYhdGmZV8M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:b4938af0-d4a3-41d7-b2cf-d12514b1edb8,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:2ef6a6b4-d2e2-434d-b6d3-aeae88dfcc78,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 902477fd707542469273d357e6f800f1-20221215
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yc.hung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 842347800; Thu, 15 Dec 2022 14:10:49 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 15 Dec 2022 14:10:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 15 Dec 2022 14:10:48 +0800
From:   YC Hung <yc.hung@mediatek.com>
CC:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        YC Hung <yc.hung@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chunxu Li <chunxu.li@mediatek.com>,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>,
        <sound-open-firmware@alsa-project.org>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Curtis Malainey <cujomalainey@chromium.org>
Subject: [PATCH] ASoC: SOF: mediatek: mt8195: remove a redundant comparison of sram
Date:   Thu, 15 Dec 2022 14:10:46 +0800
Message-ID: <20221215061046.16934-1-yc.hung@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSP SRAM is not used for audio shared buffer between host and DSP so
TOTAL_SIZE_SHARED_SRAM_FROM_TAIL is zero. Remove the definition and
redundant comparison to fix coverity "unsigned compared against 0".

Signed-off-by: YC Hung <yc.hung@mediatek.com>
---
 sound/soc/sof/mediatek/mt8195/mt8195.c | 5 -----
 sound/soc/sof/mediatek/mt8195/mt8195.h | 2 --
 2 files changed, 7 deletions(-)

diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index 3c81e84fcecf..7c831e18483c 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -215,11 +215,6 @@ static int platform_parse_resource(struct platform_device *pdev, void *data)
 
 	adsp->pa_sram = (phys_addr_t)mmio->start;
 	adsp->sramsize = resource_size(mmio);
-	if (adsp->sramsize < TOTAL_SIZE_SHARED_SRAM_FROM_TAIL) {
-		dev_err(dev, "adsp SRAM(%#x) is not enough for share\n",
-			adsp->sramsize);
-		return -EINVAL;
-	}
 
 	dev_dbg(dev, "sram pbase=%pa,%#x\n", &adsp->pa_sram, adsp->sramsize);
 
diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.h b/sound/soc/sof/mediatek/mt8195/mt8195.h
index 7ffd523f936c..b4229170049f 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.h
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.h
@@ -139,8 +139,6 @@ struct snd_sof_dev;
 #define DSP_MBOX1_BAR	6
 #define DSP_MBOX2_BAR	7
 
-#define TOTAL_SIZE_SHARED_SRAM_FROM_TAIL  0x0
-
 #define SIZE_SHARED_DRAM_DL 0x40000 /*Shared buffer for Downlink*/
 #define SIZE_SHARED_DRAM_UL 0x40000 /*Shared buffer for Uplink*/
 
-- 
2.18.0

