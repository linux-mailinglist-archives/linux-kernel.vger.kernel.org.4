Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9B8663CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237937AbjAJJ2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238136AbjAJJ1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:27:15 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2891110E0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:26:38 -0800 (PST)
X-UUID: 352f9f6e967e406cb11fcbb769b0f9f4-20230110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=m6bacnecUtdM1hbKPv2z66h484gG8YgJGlszjLRLPPU=;
        b=eephG9V7j1QXYIeMDFiFR8QE+evi+aKRpWoM3/zWuC++fOjtOjZ/YBTkVWQN4/sFiVY5cmSoYKjAPv9urOqAYaF/42Qr7+uMxqr5pQd7O6vvrtbg7WdKOgLBPDQ9Dv4XpLpLWi6zR6G8t5ivUevI10MfXRVg9zNa8c/887VP3+E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:685305fc-785c-42cb-ac5e-6421f8130bd7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.17,REQID:685305fc-785c-42cb-ac5e-6421f8130bd7,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:543e81c,CLOUDID:f4b9d38b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:230110172633FWP4HJAK,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 352f9f6e967e406cb11fcbb769b0f9f4-20230110
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunxu.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1059939004; Tue, 10 Jan 2023 17:26:30 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 10 Jan 2023 17:26:29 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 10 Jan 2023 17:26:28 +0800
From:   Chunxu Li <chunxu.li@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <jiaxin.yu@mediatek.com>
CC:     <matthias.bgg@gmail.com>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <project_global_chrome_upstream_group@mediatek.com>,
        Chunxu Li <chunxu.li@mediatek.com>
Subject: [PATCH] ASoC: mediatek: mt8186: add AFE_DAC_CON0 to volatile register list
Date:   Tue, 10 Jan 2023 17:26:23 +0800
Message-ID: <20230110092623.13035-1-chunxu.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark AFE_DAC_CON0 as volatile since DSP firmware will access this
register too.

Signed-off-by: Chunxu Li <chunxu.li@mediatek.com>
---
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
index d7e94e6a19c7..41172a82103e 100644
--- a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
@@ -2395,6 +2395,7 @@ static bool mt8186_is_volatile_reg(struct device *dev, unsigned int reg)
 	case AUDIO_TOP_CON1:	/* reg bit controlled by CCF */
 	case AUDIO_TOP_CON2:
 	case AUDIO_TOP_CON3:
+	case AFE_DAC_CON0:
 	case AFE_DL1_CUR_MSB:
 	case AFE_DL1_CUR:
 	case AFE_DL1_END:
-- 
2.25.1

