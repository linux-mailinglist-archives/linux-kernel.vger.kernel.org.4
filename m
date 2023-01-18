Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF71867119D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 04:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjARDP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 22:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjARDPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 22:15:25 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9B94FCEB;
        Tue, 17 Jan 2023 19:15:18 -0800 (PST)
X-UUID: 51b713a296de11eda06fc9ecc4dadd91-20230118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ifg38jsHZ5BkXiCbGKdBNAbLJn5lRjxgR90wcI2X0zY=;
        b=gVyKJzQ6yZaNhrDszApX3UEKyk5IEBgOxgqzqgDHA4D7VcyoCQymngO8iKQH141yeSLlyrv64PwY5Sl2QScFGxbP2GyCKDL0okHFHv8Uv3MB7gjnTuB+6IyDSbDI/OlJcH68KJdd7DRhjFpZf9O/y0cbNhG7/vGDyE/6Vkf/tns=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:c68d75f6-d1b3-4523-9323-e348d2727961,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.18,REQID:c68d75f6-d1b3-4523-9323-e348d2727961,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:3ca2d6b,CLOUDID:771bf654-dd49-462e-a4be-2143a3ddc739,B
        ulkID:230118111512RE1WU1ND,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-BVR: 0
X-UUID: 51b713a296de11eda06fc9ecc4dadd91-20230118
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1841336925; Wed, 18 Jan 2023 11:15:11 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 18 Jan 2023 11:15:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 18 Jan 2023 11:15:10 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v6 2/4] dt-bindings: arm: mediatek: mmsys: Add support for MT8195 VPPSYS
Date:   Wed, 18 Jan 2023 11:15:07 +0800
Message-ID: <20230118031509.29834-3-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230118031509.29834-1-moudy.ho@mediatek.com>
References: <20230118031509.29834-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For MT8195, VPPSYS0 and VPPSYS1 are 2 display pipes with
hardware differences in power domains, clocks and subsystem counts,
which should be determined by compatible names.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
index 84de12709323..b08ae7405b1a 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
@@ -33,6 +33,8 @@ properties:
               - mediatek,mt8186-mmsys
               - mediatek,mt8188-vdosys0
               - mediatek,mt8192-mmsys
+              - mediatek,mt8195-vppsys0
+              - mediatek,mt8195-vppsys1
               - mediatek,mt8365-mmsys
           - const: syscon
 
-- 
2.18.0

