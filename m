Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B446360DB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbiKWOBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238156AbiKWOAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:00:35 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2FD65841;
        Wed, 23 Nov 2022 05:55:46 -0800 (PST)
X-UUID: 9691b78b84e24b979fed4c196ddb4872-20221123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=it+Cfe+nep+eXCTEyV1LJbHTkjSienPUhvJ3nl2xO/E=;
        b=CwLRbujt8a0sLvNUA9KRCZ078kSX6GOtvinpCIZttgk4E7Lg97814f023CmpA63/YveNXxgJgLYZFaElCemokRIazZvjKjRnylpb3pXZxkWT6vF9iXelS7lebquwGLnkgbqIASKZRsxSSIh9OH7XFwZOESpxfQ3ey69oUqQ17ds=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:77546c6e-e740-40fc-94bb-b5bb25d0ae19,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d12e911,CLOUDID:57ca09dc-6ad4-42ff-91f3-18e0272db660,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 9691b78b84e24b979fed4c196ddb4872-20221123
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1704401998; Wed, 23 Nov 2022 21:55:42 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 23 Nov 2022 21:55:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 23 Nov 2022 21:55:41 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <hsinyi@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v2 5/5] arm64: dts: mt8186: Add mtu3 nodes
Date:   Wed, 23 Nov 2022 21:55:31 +0800
Message-ID: <20221123135531.23221-6-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221123135531.23221-1-allen-kh.cheng@mediatek.com>
References: <20221123135531.23221-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mtu3 nodes for mt8186 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 75 ++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 4a2f7ad3c6f0..1761211f1464 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -848,6 +848,43 @@
 			status = "disabled";
 		};
 
+		ssusb0: usb@11201000 {
+			compatible = "mediatek,mt8186-mtu3",
+				     "mediatek,mtu3";
+			reg = <0 0x11201000 0 0x2dff>,
+			      <0 0x11203e00 0 0x0100>;
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
+				compatible = "mediatek,mt8186-xhci",
+					     "mediatek,mtk-xhci";
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
@@ -878,6 +915,44 @@
 			status = "disabled";
 		};
 
+		ssusb1: usb@11281000 {
+			compatible = "mediatek,mt8186-mtu3",
+				     "mediatek,mtu3";
+			reg = <0 0x11281000 0 0x2dff>,
+			      <0 0x11283e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			clocks = <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_SYS>,
+				 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_REF>,
+				 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_HCLK>,
+				 <&clk26m>;
+			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck";
+			interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&u2port1 PHY_TYPE_USB2>,
+			       <&u3port1 PHY_TYPE_USB3>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_SSUSB_P1>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			usb_host1: usb@11280000 {
+				compatible = "mediatek,mt8186-xhci",
+					     "mediatek,mtk-xhci";
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

