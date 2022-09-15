Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E445B9810
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiIOJsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiIOJrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:47:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E849A6B6;
        Thu, 15 Sep 2022 02:46:49 -0700 (PDT)
X-UUID: 3e433b46dd624de4ab70071a45a1e5eb-20220915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xgfFopHRoYeA1RQ6DEpp5+/B5hYSDxuNukCqQVXBOr0=;
        b=kUaagV3vHqXQ7drxiFc2/5wS0cNA8OGk5YEXPBXkZ0ZUt+1fpH7ecfZ6suSNVwOsD/5o0SvoF3/W/X3MqsBISYYZHbbirhZSl0lNyrmsecvZGlAFQJpak87mQInG5Mkue3rFI1yaE5GkVtsAV4mij3z/RAN4fJ6rQizDXUJoebg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:1392d9b1-ec75-4aa8-85f1-f70415536f30,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:4500be7b-ea28-4199-b57e-003c7d60873a,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3e433b46dd624de4ab70071a45a1e5eb-20220915
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2019624178; Thu, 15 Sep 2022 17:46:42 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 15 Sep 2022 17:46:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 15 Sep 2022 17:46:41 +0800
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v2 1/4] arm64: dts: mt8195: Add dp-intf nodes
Date:   Thu, 15 Sep 2022 17:46:37 +0800
Message-ID: <20220915094640.5571-2-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220915094640.5571-1-rex-bc.chen@mediatek.com>
References: <20220915094640.5571-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
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

