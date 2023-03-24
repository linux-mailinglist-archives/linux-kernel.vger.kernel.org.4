Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD1B6C755D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 03:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjCXCNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 22:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjCXCNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 22:13:15 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA3011666;
        Thu, 23 Mar 2023 19:13:11 -0700 (PDT)
X-UUID: 67c5a36ec9e911edb6b9f13eb10bd0fe-20230324
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=v4C/c+coZf632gYlNNtB8sYdI1ZF+6VwQghIMiH1Nmw=;
        b=DYibyXi4zKMHZz4rDfr/Ophzs1S4IImpkgpUzzDkKM3ZDos9JrzxXyW7l+ygBteobnpZlc8TlE0MqRgpB1alVrWVet4QH157OcVcpYGI5XLiYjbQuQtOGDPkX+LJs9KyAQG9hbNqbFhctzAR5p8u9k1FkS/t7vZa0RtgTo4CBWw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:949a303d-37a6-42a1-9580-e75c357d8e06,IP:0,U
        RL:0,TC:0,Content:-5,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-35
X-CID-META: VersionHash:120426c,CLOUDID:ede0c1f6-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
        L:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 67c5a36ec9e911edb6b9f13eb10bd0fe-20230324
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 610021462; Fri, 24 Mar 2023 10:13:02 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 24 Mar 2023 10:13:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 24 Mar 2023 10:13:01 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <hsinyi@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v5 3/6] arm64: dts: mediatek: mt8186: Add SPMI node
Date:   Fri, 24 Mar 2023 10:12:55 +0800
Message-ID: <20230324021258.15863-4-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230324021258.15863-1-allen-kh.cheng@mediatek.com>
References: <20230324021258.15863-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPMI node for MT8186 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 178421fd8380..0e42bdbd2cb6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -602,6 +602,21 @@
 			clock-names = "spi", "wrap";
 		};
 
+		spmi: spmi@10015000 {
+			compatible = "mediatek,mt8186-spmi", "mediatek,mt8195-spmi";
+			reg = <0 0x10015000 0 0x000e00>, <0 0x1001B000 0 0x000100>;
+			reg-names = "pmif", "spmimst";
+			clocks = <&infracfg_ao CLK_INFRA_AO_PMIC_AP>,
+				 <&infracfg_ao CLK_INFRA_AO_PMIC_TMR>,
+				 <&topckgen CLK_TOP_SPMI_MST>;
+			clock-names = "pmif_sys_ck", "pmif_tmr_ck", "spmimst_clk_mux";
+			assigned-clocks = <&topckgen CLK_TOP_SPMI_MST>;
+			assigned-clock-parents = <&topckgen CLK_TOP_ULPOSC1_D10>;
+			interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH 0>;
+			status = "disabled";
+		};
+
 		systimer: timer@10017000 {
 			compatible = "mediatek,mt8186-timer",
 				     "mediatek,mt6765-timer";
-- 
2.18.0

