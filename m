Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009BB6BE103
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCQGJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjCQGJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:09:26 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0052C2748A;
        Thu, 16 Mar 2023 23:09:23 -0700 (PDT)
X-UUID: 41d8599ec48a11edbd2e61cc88cc8f98-20230317
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Q9cstHFLJ+gx/qArsmu2CV4neaUdrgqVB6Ig+yYspwo=;
        b=RRb4M1Li/uRhaZKzLp/R/uPknDE0TGGbHR3bClFBxfPN3rit7VJgfrfhlMfpc7bx494u3RgHt/ywmEHLcpPsD58Wh8yBm77JR90P2/pxzOmAYYpa86MeyyOijQvr2Tsj224OQrWNKnfaCPFcGERqn8cZeNFJPdhmKc5quDTBE88=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.21,REQID:96e2f3f7-79d2-4183-90bf-158e580f35a7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:83295aa,CLOUDID:794916f6-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 41d8599ec48a11edbd2e61cc88cc8f98-20230317
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 40073597; Fri, 17 Mar 2023 14:09:20 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 17 Mar 2023 14:09:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 17 Mar 2023 14:09:19 +0800
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
Subject: [PATCH v4 1/7] arm64: dts: mediatek: mt8186: Add MTU3 nodes
Date:   Fri, 17 Mar 2023 14:09:11 +0800
Message-ID: <20230317060917.15175-2-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230317060917.15175-1-allen-kh.cheng@mediatek.com>
References: <20230317060917.15175-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MTU3 nodes for MT8186 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 68 ++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index a0d3e1f731bd..178421fd8380 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -981,6 +981,40 @@
 			status = "disabled";
 		};
 
+		ssusb0: usb@11201000 {
+			compatible = "mediatek,mt8186-mtu3", "mediatek,mtu3";
+			reg = <0 0x11201000 0 0x2dff>, <0 0x11203e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			clocks = <&topckgen CLK_TOP_USB_TOP>,
+				 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_REF>,
+				 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_HCLK>,
+				 <&infracfg_ao CLK_INFRA_AO_ICUSB>;
+			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck";
+			interrupts = <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&u2port0 PHY_TYPE_USB2>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_SSUSB>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			usb_host0: usb@11200000 {
+				compatible = "mediatek,mt8186-xhci", "mediatek,mtk-xhci";
+				reg = <0 0x11200000 0 0x1000>;
+				reg-names = "mac";
+				clocks = <&topckgen CLK_TOP_USB_TOP>,
+					 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_REF>,
+					 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_HCLK>,
+					 <&infracfg_ao CLK_INFRA_AO_ICUSB>,
+					 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_XHCI>;
+				clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
+				interrupts = <GIC_SPI 294 IRQ_TYPE_LEVEL_HIGH 0>;
+				mediatek,syscon-wakeup = <&pericfg 0x420 2>;
+				wakeup-source;
+				status = "disabled";
+			};
+		};
+
 		mmc0: mmc@11230000 {
 			compatible = "mediatek,mt8186-mmc",
 				     "mediatek,mt8183-mmc";
@@ -1012,6 +1046,40 @@
 			status = "disabled";
 		};
 
+		ssusb1: usb@11281000 {
+			compatible = "mediatek,mt8186-mtu3", "mediatek,mtu3";
+			reg = <0 0x11281000 0 0x2dff>, <0 0x11283e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			clocks = <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_SYS>,
+				 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_REF>,
+				 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_HCLK>,
+				 <&clk26m>;
+			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck";
+			interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&u2port1 PHY_TYPE_USB2>, <&u3port1 PHY_TYPE_USB3>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_SSUSB_P1>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			usb_host1: usb@11280000 {
+				compatible = "mediatek,mt8186-xhci", "mediatek,mtk-xhci";
+				reg = <0 0x11280000 0 0x1000>;
+				reg-names = "mac";
+				clocks = <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_SYS>,
+					 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_REF>,
+					 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_HCLK>,
+					 <&clk26m>,
+					 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_XHCI>;
+				clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck","xhci_ck";
+				interrupts = <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH 0>;
+				mediatek,syscon-wakeup = <&pericfg 0x424 2>;
+				wakeup-source;
+				status = "disabled";
+			};
+		};
+
 		u3phy0: t-phy@11c80000 {
 			compatible = "mediatek,mt8186-tphy",
 				     "mediatek,generic-tphy-v2";
-- 
2.18.0

