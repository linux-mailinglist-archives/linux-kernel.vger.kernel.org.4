Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACBC5BA4C3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 04:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiIPCvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 22:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIPCvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 22:51:12 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D5A98A6E;
        Thu, 15 Sep 2022 19:51:07 -0700 (PDT)
X-UUID: eca0733e52624733861866cb70429251-20220916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=A2boyUMI62PGkfAXY8Q9C0h4jRd50SVJCo47zEUPaUc=;
        b=KzsstLbVABMMqzefmR8KTKWQ2fUSvn4ilDByCwhYfN+XAcsch6NoLFXIPyw8pT2cHDVsx9ci3Xp1jJsH5FPABZyR4ZuxFSRmRqC9jghygVocDghydBnrDeOox7ehnKiY7A4VA4IqBD3VjhbwrDhOLRsmZH9W+0sbG9R0gqpYX94=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:bb51bde2-5cac-4142-9f1b-b03e0da6bf02,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.11,REQID:bb51bde2-5cac-4142-9f1b-b03e0da6bf02,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:39a5ff1,CLOUDID:e158d17b-ea28-4199-b57e-003c7d60873a,B
        ulkID:220916105103EBM83LEM,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: eca0733e52624733861866cb70429251-20220916
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1487704316; Fri, 16 Sep 2022 10:51:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 16 Sep 2022 10:51:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 16 Sep 2022 10:51:00 +0800
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <matthias.bgg@gmail.com>
CC:     <angelogioacchino.delregno@collabora.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v3 1/4] arm64: dts: mt8195: Add dp-intf nodes
Date:   Fri, 16 Sep 2022 10:50:56 +0800
Message-ID: <20220916025059.16673-2-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220916025059.16673-1-rex-bc.chen@mediatek.com>
References: <20220916025059.16673-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Dp-intfs provide the pixel data to edptx and dptx. To support edptx
and dptx, we need to add dp-intf0 and dp-intf1 nodes.

Dp-intf0 is for edptx and dp-intf1 is for dptx.

Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 905d1a90b406..82d28e9f60c3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -2067,6 +2067,17 @@
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c01XXXX 0x4000 0x1000>;
 		};
 
+		dp_intf0: dp-intf@1c015000 {
+			compatible = "mediatek,mt8195-dp-intf";
+			reg = <0 0x1c015000 0 0x1000>;
+			interrupts = <GIC_SPI 657 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&vdosys0  CLK_VDO0_DP_INTF0>,
+				 <&vdosys0 CLK_VDO0_DP_INTF0_DP_INTF>,
+				 <&apmixedsys CLK_APMIXED_TVDPLL1>;
+			clock-names = "engine", "pixel", "pll";
+			status = "disabled";
+		};
+
 		mutex: mutex@1c016000 {
 			compatible = "mediatek,mt8195-disp-mutex";
 			reg = <0 0x1c016000 0 0x1000>;
@@ -2155,5 +2166,17 @@
 			clock-names = "apb", "smi", "gals";
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
 		};
+
+		dp_intf1: dp-intf@1c113000 {
+			compatible = "mediatek,mt8195-dp-intf";
+			reg = <0 0x1c113000 0 0x1000>;
+			interrupts = <GIC_SPI 513 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
+			clocks = <&vdosys1 CLK_VDO1_DP_INTF0_MM>,
+				 <&vdosys1 CLK_VDO1_DPINTF>,
+				 <&apmixedsys CLK_APMIXED_TVDPLL2>;
+			clock-names = "engine", "pixel", "pll";
+			status = "disabled";
+		};
 	};
 };
-- 
2.18.0

