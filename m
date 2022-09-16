Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A275BAE58
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiIPNir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbiIPNif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:38:35 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C530AD994
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:38:28 -0700 (PDT)
X-UUID: 9c5ee4c187ae4618b312ba7113e62544-20220916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NGH5yfWGPndNDuMJPBzva5DZXO1BiDlxLCHAVOtmCBw=;
        b=TNGzOSkS+NvxoqXgedq0dtaqHAZw9s4PoHFanUkfGSnzGlD6i9yy+loXAbo9rwq6RlFfGwfPWEVVo45GuBlh+x9YEUkjZiK4f0J88BXQjGO/JGwIlf3OpCfwBNqNbkgUyRPNpxfOfQY5vPpT1bN1cI72K3locvs9wLqUHpWih4c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:29e80f79-d37d-4bfd-bbf4-0608820e5242,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.11,REQID:29e80f79-d37d-4bfd-bbf4-0608820e5242,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:39a5ff1,CLOUDID:f2597e8a-35ad-4537-90e7-b56a69d5f8a4,B
        ulkID:220916213826IHOKYOEY,BulkQuantity:0,Recheck:0,SF:28|17|19|48|823|824
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
        :0
X-UUID: 9c5ee4c187ae4618b312ba7113e62544-20220916
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1352847579; Fri, 16 Sep 2022 21:38:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 16 Sep 2022 21:38:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 16 Sep 2022 21:38:23 +0800
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>
CC:     <matthias.bgg@gmail.com>, <granquet@baylibre.com>,
        <daniel@ffwll.ch>, <jitao.shi@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>, <ck.hu@mediatek.com>,
        <liangxu.xu@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v2 2/3] drm/mediatek: dp: Remove unused register definitions
Date:   Fri, 16 Sep 2022 21:38:20 +0800
Message-ID: <20220916133821.27980-3-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220916133821.27980-1-rex-bc.chen@mediatek.com>
References: <20220916133821.27980-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some definitions in mtk_dp_reg.h are not used, so remove these
redundant codes.

Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_dp_reg.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp_reg.h b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
index 096ad6572a5e..84e38cef03c2 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp_reg.h
+++ b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
@@ -153,8 +153,6 @@
 #define CH_STATUS_1_DP_ENC0_P0_MASK			GENMASK(15, 0)
 #define MTK_DP_ENC0_P0_3094			0x3094
 #define CH_STATUS_2_DP_ENC0_P0_MASK			GENMASK(7, 0)
-#define MTK_DP_ENC0_P0_30A0			0x30a0
-#define DP_ENC0_30A0_MASK				(BIT(7) | BIT(8) | BIT(12))
 #define MTK_DP_ENC0_P0_30A4			0x30a4
 #define AU_TS_CFG_DP_ENC0_P0_MASK			GENMASK(7, 0)
 #define MTK_DP_ENC0_P0_30A8			0x30a8
@@ -171,8 +169,6 @@
 #define MTK_DP_ENC0_P0_312C			0x312c
 #define ASP_HB2_DP_ENC0_P0_MASK				GENMASK(7, 0)
 #define ASP_HB3_DP_ENC0_P0_MASK				GENMASK(15, 8)
-#define MTK_DP_ENC0_P0_3130			0x3130
-#define MTK_DP_ENC0_P0_3138			0x3138
 #define MTK_DP_ENC0_P0_3154			0x3154
 #define PGEN_HTOTAL_DP_ENC0_P0_MASK			GENMASK(13, 0)
 #define MTK_DP_ENC0_P0_3158			0x3158
@@ -206,8 +202,6 @@
 #define SDP_PACKET_TYPE_DP_ENC1_P0_MASK			GENMASK(4, 0)
 #define SDP_PACKET_W_DP_ENC1_P0				BIT(5)
 #define SDP_PACKET_W_DP_ENC1_P0_MASK			BIT(5)
-#define MTK_DP_ENC1_P0_328C			0x328c
-#define VSC_DATA_RDY_VESA_DP_ENC1_P0_MASK		BIT(7)
 #define MTK_DP_ENC1_P0_3300			0x3300
 #define VIDEO_AFIFO_RDY_SEL_DP_ENC1_P0_VAL		2
 #define VIDEO_AFIFO_RDY_SEL_DP_ENC1_P0_MASK		GENMASK(9, 8)
-- 
2.18.0

