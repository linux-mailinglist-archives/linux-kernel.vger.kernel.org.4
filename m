Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0915C5E7B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiIWNMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiIWNMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:12:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8263B13EACF;
        Fri, 23 Sep 2022 06:12:01 -0700 (PDT)
X-UUID: 59ca6e7af96744fa963862e7fc60655e-20220923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=w7JAT1zpPu60OdL94EP7gUEL01Fz7GJdxBym3rpcNbI=;
        b=MWd9mtS1Er7AR5wFA0P6ZJCa3QVJZMi0pS5dKSafckD/ZejS/ikI+UCLZSJKODe4R0Otntc0oOUCWj5T8ZgBYD50pTdnpnbwW6ACJUjNufpiooMMbcwrYoq0KB6r6h/TaEpgtaiYFdfRtqG8h6e62hVednjCuZ2l/wpg9/jb2J0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:66428b21-e23e-4f10-8e16-47aeec8cc712,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:ba23dea2-dc04-435c-b19b-71e131a5fc35,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 59ca6e7af96744fa963862e7fc60655e-20220923
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1214217162; Fri, 23 Sep 2022 21:11:52 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 23 Sep 2022 21:11:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 23 Sep 2022 21:11:51 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <hsinyi@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH 2/5] arm64: dts: mt8186: Add power domains controller
Date:   Fri, 23 Sep 2022 21:11:45 +0800
Message-ID: <20220923131148.6678-3-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220923131148.6678-1-allen-kh.cheng@mediatek.com>
References: <20220923131148.6678-1-allen-kh.cheng@mediatek.com>
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

Add power domains controller for mt8186 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 188 +++++++++++++++++++++++
 1 file changed, 188 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 64693c17af9e..833e7037fe22 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -329,6 +329,194 @@
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
+					clock-names = "adsp_ao0", "adsp_ao1";
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
+					clock-names = "dis0", "dis1", "dis-0", "dis-1",
+						     "dis-2", "dis-3";
+					mediatek,infracfg = <&infracfg_ao>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8186_POWER_DOMAIN_VDEC {
+						reg = <MT8186_POWER_DOMAIN_VDEC>;
+						clocks = <&topckgen CLK_TOP_VDEC>,
+							 <&vdecsys CLK_VDEC_LARB1_CKEN>;
+						clock-names = "vdec0", "vdec-0";
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
+						clock-names = "cam0", "cam1", "cam2", "cam3",
+							     "cam4", "cam5", "cam-0";
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
+						clock-names = "img0", "img-0";
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
+						clock-names = "ipe0", "ipe-0", "ipe-1", "ipe-2",
+							     "ipe-3";
+						mediatek,infracfg = <&infracfg_ao>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8186_POWER_DOMAIN_VENC {
+						reg = <MT8186_POWER_DOMAIN_VENC>;
+						clocks = <&topckgen CLK_TOP_VENC>,
+							 <&vencsys CLK_VENC_CKE1_VENC>;
+						clock-names = "venc0", "venc-0";
+						mediatek,infracfg = <&infracfg_ao>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8186_POWER_DOMAIN_WPE {
+						reg = <MT8186_POWER_DOMAIN_WPE>;
+						clocks = <&topckgen CLK_TOP_WPE>,
+							 <&wpesys CLK_WPE_SMI_LARB8_CK_EN>,
+							 <&wpesys CLK_WPE_SMI_LARB8_PCLK_EN>;
+						clock-names = "wpe0", "wpe-0", "wpe-1";
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

