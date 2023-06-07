Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4954F7253EA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbjFGGMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbjFGGLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:11:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C3C1712;
        Tue,  6 Jun 2023 23:11:39 -0700 (PDT)
X-UUID: 25c1826604fa11eeb20a276fd37b9834-20230607
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=tk3XutL9e2YWZ1gDFC/8kPKTgAad11wdBVRkC6GJm48=;
        b=VYpLY0UxH/aEutD/PQXb2rRCLeb6WIxbC/OJlmBnuSCj6lFzZMhp7f/QV3KbsZa6d7sQd299OXi/OJ4WG/K6VOyZLNLDrliZxfzjF4quw7lXzRTxhTUUzGt5+ZOu8fpM7gw/I2u+ozausHhmg2GWhpKG6y1d/ODhP8F0lEm3MZM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:f9a5f6ac-7617-4ae3-ab32-a92e0af26015,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.25,REQID:f9a5f6ac-7617-4ae3-ab32-a92e0af26015,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:d5b0ae3,CLOUDID:f80aa33d-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230607141134563LMNJP,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 25c1826604fa11eeb20a276fd37b9834-20230607
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1987876138; Wed, 07 Jun 2023 14:11:31 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 14:11:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 7 Jun 2023 14:11:30 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Hsiao Chein Sung <shawn.sung@mediatek.com>,
        Fei Shao <fshao@google.com>
Subject: [PATCH v1 2/6] dt-bindings: reset: mt8188: Add reset control bits for VDOSYS1
Date:   Wed, 7 Jun 2023 14:11:17 +0800
Message-ID: <20230607061121.6732-3-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230607061121.6732-1-shawn.sung@mediatek.com>
References: <20230607061121.6732-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset control bits for  MT8188 VDOSYS1.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 include/dt-bindings/reset/mt8188-resets.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/dt-bindings/reset/mt8188-resets.h b/include/dt-bindings/reset/mt8188-resets.h
index 377cdfda82a9..439a9a25ca19 100644
--- a/include/dt-bindings/reset/mt8188-resets.h
+++ b/include/dt-bindings/reset/mt8188-resets.h
@@ -33,4 +33,16 @@

 #define MT8188_TOPRGU_SW_RST_NUM               24

+/* VDOSYS1 */
+#define MT8188_VDO1_RST_MERGE0_DL_ASYNC         9
+#define MT8188_VDO1_RST_MERGE1_DL_ASYNC         10
+#define MT8188_VDO1_RST_MERGE2_DL_ASYNC         11
+#define MT8188_VDO1_RST_MERGE3_DL_ASYNC         32
+#define MT8188_VDO1_RST_MERGE4_DL_ASYNC         33
+#define MT8188_VDO1_RST_HDR_VDO_FE0_DL_ASYNC    64
+#define MT8188_VDO1_RST_HDR_GFX_FE0_DL_ASYNC    65
+#define MT8188_VDO1_RST_HDR_VDO_BE_DL_ASYNC     66
+#define MT8188_VDO1_RST_HDR_VDO_FE1_DL_ASYNC    80
+#define MT8188_VDO1_RST_HDR_GFX_FE1_DL_ASYNC    81
+
 #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8188 */
--
2.18.0

