Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AC26360DF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbiKWOBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238200AbiKWOAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:00:35 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5930554B20;
        Wed, 23 Nov 2022 05:55:46 -0800 (PST)
X-UUID: 5fcaf78f0b8941d49ed99dafbfeaab72-20221123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=LPVsFY/4qTcqn/LQQ4deiCHAhR3S6h/hDfr8bhk2LgE=;
        b=qsdzw2q2OYm1IWFSrLD2TXg+jNlDiNxlecRwBaLDzEUfv5ketyvWXd2NN5KjJADc3RkdgMpwl5b9d35Ksb3dgq7mQ2Y14jolzimeWQONzPMwreCGvgu+72Z8ywP+ykWxZz8FlPCFe0s9Nt0oxNujP+DTUtBHXGuzzkHwie7PTPo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:ee08cef9-48f2-41f5-a838-9e4eaae56df1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.12,REQID:ee08cef9-48f2-41f5-a838-9e4eaae56df1,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:62cd327,CLOUDID:96289f2f-2938-482e-aafd-98d66723b8a9,B
        ulkID:22112321554215H9EFXF,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5fcaf78f0b8941d49ed99dafbfeaab72-20221123
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 722371554; Wed, 23 Nov 2022 21:55:40 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 23 Nov 2022 21:55:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 23 Nov 2022 21:55:39 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <hsinyi@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v2 3/5] arm64: dts: mt8186: Add IOMMU and SMI nodes
Date:   Wed, 23 Nov 2022 21:55:29 +0800
Message-ID: <20221123135531.23221-4-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221123135531.23221-1-allen-kh.cheng@mediatek.com>
References: <20221123135531.23221-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iommu and smi nodes for mt8186 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 173 +++++++++++++++++++++++
 1 file changed, 173 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 2b03a342b8db..c0481f0dc527 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/clock/mt8186-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/memory/mt8186-memory-port.h>
 #include <dt-bindings/pinctrl/mt8186-pinfunc.h>
 #include <dt-bindings/power/mt8186-power.h>
 #include <dt-bindings/phy/phy.h>
@@ -947,24 +948,113 @@
 			#reset-cells = <1>;
 		};
 
+		smi_common: smi@14002000 {
+			compatible = "mediatek,mt8186-smi-common";
+			reg = <0 0x14002000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_SMI_COMMON>, <&mmsys CLK_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_SMI_GALS>, <&mmsys CLK_MM_SMI_GALS>;
+			clock-names = "apb", "smi", "gals0", "gals1";
+			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
+		};
+
+		larb0: smi@14003000 {
+			compatible = "mediatek,mt8186-smi-larb";
+			reg = <0 0x14003000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_SMI_COMMON>;
+			clock-names = "apb", "smi";
+			mediatek,larb-id = <0>;
+			mediatek,smi = <&smi_common>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
+		};
+
+		larb1: smi@14004000 {
+			compatible = "mediatek,mt8186-smi-larb";
+			reg = <0 0x14004000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_SMI_COMMON>;
+			clock-names = "apb", "smi";
+			mediatek,larb-id = <1>;
+			mediatek,smi = <&smi_common>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
+		};
+
+		iommu_mm: iommu@14016000 {
+			compatible = "mediatek,mt8186-iommu-mm";
+			reg = <0 0x14016000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_SMI_IOMMU>;
+			clock-names = "bclk";
+			interrupts = <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,larbs = <&larb0 &larb1 &larb2 &larb4
+					  &larb7 &larb8 &larb9 &larb11
+					  &larb13 &larb14 &larb16 &larb17
+					  &larb19 &larb20>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
+			#iommu-cells = <1>;
+		};
+
 		wpesys: clock-controller@14020000 {
 			compatible = "mediatek,mt8186-wpesys";
 			reg = <0 0x14020000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb8: smi@14023000 {
+			compatible = "mediatek,mt8186-smi-larb";
+			reg = <0 0x14023000 0 0x1000>;
+			clocks = <&wpesys CLK_WPE_SMI_LARB8_CK_EN>,
+				 <&wpesys CLK_WPE_SMI_LARB8_CK_EN>;
+			clock-names = "apb", "smi";
+			mediatek,larb-id = <8>;
+			mediatek,smi = <&smi_common>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_WPE>;
+		};
+
 		imgsys1: clock-controller@15020000 {
 			compatible = "mediatek,mt8186-imgsys1";
 			reg = <0 0x15020000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb9: smi@1502e000 {
+			compatible = "mediatek,mt8186-smi-larb";
+			reg = <0 0x1502e000 0 0x1000>;
+			clocks = <&imgsys1 CLK_IMG1_GALS_IMG1>,
+				 <&imgsys1 CLK_IMG1_LARB9_IMG1>;
+			clock-names = "apb", "smi";
+			mediatek,larb-id = <9>;
+			mediatek,smi = <&smi_common>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_IMG>;
+		};
+
 		imgsys2: clock-controller@15820000 {
 			compatible = "mediatek,mt8186-imgsys2";
 			reg = <0 0x15820000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb11: smi@1582e000 {
+			compatible = "mediatek,mt8186-smi-larb";
+			reg = <0 0x1582e000 0 0x1000>;
+			clocks = <&imgsys1 CLK_IMG1_LARB9_IMG1>,
+				 <&imgsys2 CLK_IMG2_LARB9_IMG2>;
+			clock-names = "apb", "smi";
+			mediatek,larb-id = <11>;
+			mediatek,smi = <&smi_common>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_IMG2>;
+		};
+
+		larb4: smi@1602e000 {
+			compatible = "mediatek,mt8186-smi-larb";
+			reg = <0 0x1602e000 0 0x1000>;
+			clocks = <&vdecsys CLK_VDEC_LARB1_CKEN>,
+				 <&vdecsys CLK_VDEC_LARB1_CKEN>;
+			clock-names = "apb", "smi";
+			mediatek,larb-id = <4>;
+			mediatek,smi = <&smi_common>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_VDEC>;
+		};
+
 		vdecsys: clock-controller@1602f000 {
 			compatible = "mediatek,mt8186-vdecsys";
 			reg = <0 0x1602f000 0 0x1000>;
@@ -977,12 +1067,65 @@
 			#clock-cells = <1>;
 		};
 
+		larb7: smi@17010000 {
+			compatible = "mediatek,mt8186-smi-larb";
+			reg = <0 0x17010000 0 0x1000>;
+			clocks = <&vencsys CLK_VENC_CKE1_VENC>,
+				 <&vencsys CLK_VENC_CKE1_VENC>;
+			clock-names = "apb", "smi";
+			mediatek,larb-id = <7>;
+			mediatek,smi = <&smi_common>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_VENC>;
+		};
+
 		camsys: clock-controller@1a000000 {
 			compatible = "mediatek,mt8186-camsys";
 			reg = <0 0x1a000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb13: smi@1a001000 {
+			compatible = "mediatek,mt8186-smi-larb";
+			reg = <0 0x1a001000 0 0x1000>;
+			clocks = <&camsys CLK_CAM2MM_GALS>, <&camsys CLK_CAM_LARB13>;
+			clock-names = "apb", "smi";
+			mediatek,larb-id = <13>;
+			mediatek,smi = <&smi_common>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_CAM>;
+		};
+
+		larb14: smi@1a002000 {
+			compatible = "mediatek,mt8186-smi-larb";
+			reg = <0 0x1a002000 0 0x1000>;
+			clocks = <&camsys CLK_CAM2MM_GALS>, <&camsys CLK_CAM_LARB14>;
+			clock-names = "apb", "smi";
+			mediatek,larb-id = <14>;
+			mediatek,smi = <&smi_common>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_CAM>;
+		};
+
+		larb16: smi@1a00f000 {
+			compatible = "mediatek,mt8186-smi-larb";
+			reg = <0 0x1a00f000 0 0x1000>;
+			clocks = <&camsys CLK_CAM_LARB14>,
+				 <&camsys_rawa CLK_CAM_RAWA_LARBX_RAWA>;
+			clock-names = "apb", "smi";
+			mediatek,larb-id = <16>;
+			mediatek,smi = <&smi_common>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_CAM_RAWA>;
+		};
+
+		larb17: smi@1a010000 {
+			compatible = "mediatek,mt8186-smi-larb";
+			reg = <0 0x1a010000 0 0x1000>;
+			clocks = <&camsys CLK_CAM_LARB13>,
+				 <&camsys_rawb CLK_CAM_RAWB_LARBX_RAWB>;
+			clock-names = "apb", "smi";
+			mediatek,larb-id = <17>;
+			mediatek,smi = <&smi_common>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_CAM_RAWB>;
+		};
+
 		camsys_rawa: clock-controller@1a04f000 {
 			compatible = "mediatek,mt8186-camsys_rawa";
 			reg = <0 0x1a04f000 0 0x1000>;
@@ -1001,10 +1144,40 @@
 			#clock-cells = <1>;
 		};
 
+		larb2: smi@1b002000 {
+			compatible = "mediatek,mt8186-smi-larb";
+			reg = <0 0x1b002000 0 0x1000>;
+			clocks = <&mdpsys CLK_MDP_SMI0>, <&mdpsys CLK_MDP_SMI0>;
+			clock-names = "apb", "smi";
+			mediatek,larb-id = <2>;
+			mediatek,smi = <&smi_common>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
+		};
+
 		ipesys: clock-controller@1c000000 {
 			compatible = "mediatek,mt8186-ipesys";
 			reg = <0 0x1c000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		larb20: smi@1c00f000 {
+			compatible = "mediatek,mt8186-smi-larb";
+			reg = <0 0x1c00f000 0 0x1000>;
+			clocks = <&ipesys CLK_IPE_LARB20>, <&ipesys CLK_IPE_LARB20>;
+			clock-names = "apb", "smi";
+			mediatek,larb-id = <20>;
+			mediatek,smi = <&smi_common>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_IPE>;
+		};
+
+		larb19: smi@1c10f000 {
+			compatible = "mediatek,mt8186-smi-larb";
+			reg = <0 0x1c10f000 0 0x1000>;
+			clocks = <&ipesys CLK_IPE_LARB19>, <&ipesys CLK_IPE_LARB19>;
+			clock-names = "apb", "smi";
+			mediatek,larb-id = <19>;
+			mediatek,smi = <&smi_common>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_IPE>;
+		};
 	};
 };
-- 
2.18.0

