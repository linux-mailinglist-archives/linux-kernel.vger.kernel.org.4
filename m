Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEF76360E0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbiKWOBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbiKWOAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:00:35 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A450A5E9E1;
        Wed, 23 Nov 2022 05:55:45 -0800 (PST)
X-UUID: a4bff9e288a04cca89ea3b0382910151-20221123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OqvYTWnxXrI3EYd1RQCHHYnyQ2I7IUO7KBmbsNLlJ68=;
        b=PcZpBOdUdZ2BdwtgsHE88KIkTCEozOu93rxZz3dOguQ06gCrQmuhVAT6UDfWmsuLfhFAlfRrjjE0ksaPIsW0dBtY9qmb+7C1oxZ1pBfJlR4/3o0O/sge2k1eAFmRTLItVEZZEk+s44YtcTYiMvkfIIW75vunqa/3Fv3FyaTMqak=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:09f4717d-0b09-4d0a-a74e-f51b5a72d4fa,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:46ca09dc-6ad4-42ff-91f3-18e0272db660,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a4bff9e288a04cca89ea3b0382910151-20221123
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 477963619; Wed, 23 Nov 2022 21:55:40 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 23 Nov 2022 21:55:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 23 Nov 2022 21:55:38 +0800
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
Subject: [PATCH v2 2/5] arm64: dts: mt8186: Add power domains controller
Date:   Wed, 23 Nov 2022 21:55:28 +0800
Message-ID: <20221123135531.23221-3-allen-kh.cheng@mediatek.com>
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

Add power domains controller for mt8186 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 188 +++++++++++++++++++++++
 1 file changed, 188 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index c326aeb33a10..2b03a342b8db 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -332,6 +332,194 @@
 			#interrupt-cells = <2>;
 		};
 
+		scpsys: syscon@10006000 {
+			compatible = "mediatek,mt8186-scpsys", "syscon", "simple-mfd";
+			reg = <0 0x10006000 0 0x1000>;
+
+			/* System Power Manager */
+			spm: power-controller {
+				compatible = "mediatek,mt8186-power-controller";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#power-domain-cells = <1>;
+
+				/* power domain of the SoC */
+				mfg0: power-domain@MT8186_POWER_DOMAIN_MFG0 {
+					reg = <MT8186_POWER_DOMAIN_MFG0>;
+					clocks = <&topckgen CLK_TOP_MFG>;
+					clock-names = "mfg00";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8186_POWER_DOMAIN_MFG1 {
+						reg = <MT8186_POWER_DOMAIN_MFG1>;
+						mediatek,infracfg = <&infracfg_ao>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8186_POWER_DOMAIN_MFG2 {
+							reg = <MT8186_POWER_DOMAIN_MFG2>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8186_POWER_DOMAIN_MFG3 {
+							reg = <MT8186_POWER_DOMAIN_MFG3>;
+							#power-domain-cells = <0>;
+						};
+					};
+				};
+
+				power-domain@MT8186_POWER_DOMAIN_CSIRX_TOP {
+					reg = <MT8186_POWER_DOMAIN_CSIRX_TOP>;
+					clocks = <&topckgen CLK_TOP_SENINF>,
+						 <&topckgen CLK_TOP_SENINF1>;
+					clock-names = "csirx_top0", "csirx_top1";
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8186_POWER_DOMAIN_SSUSB {
+					reg = <MT8186_POWER_DOMAIN_SSUSB>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8186_POWER_DOMAIN_SSUSB_P1 {
+					reg = <MT8186_POWER_DOMAIN_SSUSB_P1>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8186_POWER_DOMAIN_ADSP_AO {
+					reg = <MT8186_POWER_DOMAIN_ADSP_AO>;
+					clocks = <&topckgen CLK_TOP_AUDIODSP>,
+						 <&topckgen CLK_TOP_ADSP_BUS>;
+					clock-names = "audioadsp", "adsp_bus";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8186_POWER_DOMAIN_ADSP_INFRA {
+						reg = <MT8186_POWER_DOMAIN_ADSP_INFRA>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8186_POWER_DOMAIN_ADSP_TOP {
+							reg = <MT8186_POWER_DOMAIN_ADSP_TOP>;
+							mediatek,infracfg = <&infracfg_ao>;
+							#power-domain-cells = <0>;
+						};
+					};
+				};
+
+				power-domain@MT8186_POWER_DOMAIN_CONN_ON {
+					reg = <MT8186_POWER_DOMAIN_CONN_ON>;
+					mediatek,infracfg = <&infracfg_ao>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8186_POWER_DOMAIN_DIS {
+					reg = <MT8186_POWER_DOMAIN_DIS>;
+					clocks = <&topckgen CLK_TOP_DISP>,
+						 <&topckgen CLK_TOP_MDP>,
+						 <&mmsys CLK_MM_SMI_INFRA>,
+						 <&mmsys CLK_MM_SMI_COMMON>,
+						 <&mmsys CLK_MM_SMI_GALS>,
+						 <&mmsys CLK_MM_SMI_IOMMU>;
+					clock-names = "disp", "mdp", "smi_infra", "smi_common",
+						     "smi_gals", "smi_iommu";
+					mediatek,infracfg = <&infracfg_ao>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8186_POWER_DOMAIN_VDEC {
+						reg = <MT8186_POWER_DOMAIN_VDEC>;
+						clocks = <&topckgen CLK_TOP_VDEC>,
+							 <&vdecsys CLK_VDEC_LARB1_CKEN>;
+						clock-names = "vdec0", "larb";
+						mediatek,infracfg = <&infracfg_ao>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8186_POWER_DOMAIN_CAM {
+						reg = <MT8186_POWER_DOMAIN_CAM>;
+						clocks = <&topckgen CLK_TOP_CAM>,
+							 <&topckgen CLK_TOP_SENINF>,
+							 <&topckgen CLK_TOP_SENINF1>,
+							 <&topckgen CLK_TOP_SENINF2>,
+							 <&topckgen CLK_TOP_SENINF3>,
+							 <&topckgen CLK_TOP_CAMTM>,
+							 <&camsys CLK_CAM2MM_GALS>;
+						clock-names = "cam-top", "cam0", "cam1", "cam2",
+							     "cam3", "cam-tm", "gals";
+						mediatek,infracfg = <&infracfg_ao>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8186_POWER_DOMAIN_CAM_RAWB {
+							reg = <MT8186_POWER_DOMAIN_CAM_RAWB>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8186_POWER_DOMAIN_CAM_RAWA {
+							reg = <MT8186_POWER_DOMAIN_CAM_RAWA>;
+							#power-domain-cells = <0>;
+						};
+					};
+
+					power-domain@MT8186_POWER_DOMAIN_IMG {
+						reg = <MT8186_POWER_DOMAIN_IMG>;
+						clocks = <&topckgen CLK_TOP_IMG1>,
+							 <&imgsys1 CLK_IMG1_GALS_IMG1>;
+						clock-names = "img-top", "gals";
+						mediatek,infracfg = <&infracfg_ao>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8186_POWER_DOMAIN_IMG2 {
+							reg = <MT8186_POWER_DOMAIN_IMG2>;
+							#power-domain-cells = <0>;
+						};
+					};
+
+					power-domain@MT8186_POWER_DOMAIN_IPE {
+						reg = <MT8186_POWER_DOMAIN_IPE>;
+						clocks = <&topckgen CLK_TOP_IPE>,
+							 <&ipesys CLK_IPE_LARB19>,
+							 <&ipesys CLK_IPE_LARB20>,
+							 <&ipesys CLK_IPE_SMI_SUBCOM>,
+							 <&ipesys CLK_IPE_GALS_IPE>;
+						clock-names = "ipe-top", "ipe-larb0", "ipe-larb1",
+							      "ipe-smi", "ipe-gals";
+						mediatek,infracfg = <&infracfg_ao>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8186_POWER_DOMAIN_VENC {
+						reg = <MT8186_POWER_DOMAIN_VENC>;
+						clocks = <&topckgen CLK_TOP_VENC>,
+							 <&vencsys CLK_VENC_CKE1_VENC>;
+						clock-names = "venc0", "larb";
+						mediatek,infracfg = <&infracfg_ao>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8186_POWER_DOMAIN_WPE {
+						reg = <MT8186_POWER_DOMAIN_WPE>;
+						clocks = <&topckgen CLK_TOP_WPE>,
+							 <&wpesys CLK_WPE_SMI_LARB8_CK_EN>,
+							 <&wpesys CLK_WPE_SMI_LARB8_PCLK_EN>;
+						clock-names = "wpe0", "larb-ck", "larb-pclk";
+						mediatek,infracfg = <&infracfg_ao>;
+						#power-domain-cells = <0>;
+					};
+				};
+			};
+		};
+
 		watchdog: watchdog@10007000 {
 			compatible = "mediatek,mt8186-wdt",
 				     "mediatek,mt6589-wdt";
-- 
2.18.0

