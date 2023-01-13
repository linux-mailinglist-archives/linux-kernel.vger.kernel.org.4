Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013C5668BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 06:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbjAMFpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 00:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239679AbjAMFnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:43:17 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EBC68C87;
        Thu, 12 Jan 2023 21:43:15 -0800 (PST)
X-UUID: 2821df90930511ed945fc101203acc17-20230113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xQVMUD7okQLHVM5bRj5IZzkMbKVUxbpiSB0vJMJlbZA=;
        b=FemXAjtyYekXaSrHI2sax0xzt+43WqGXUJy1mx+ib5P68wsya8D3buHLERdJASShMUoSD++L59arNNzftjg4kByaNE9llq2MAPOrMJsU1NPMItev0UQbf0e3kf3gLzKD/rGQfKaCR/IX/e5Mv71zi7rNTRI2Z/PzpEL2c23G2iE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:c0d76911-1c8a-4ffe-bae1-ccaafbe65442,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.17,REQID:c0d76911-1c8a-4ffe-bae1-ccaafbe65442,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:543e81c,CLOUDID:ee608a54-dd49-462e-a4be-2143a3ddc739,B
        ulkID:230113134310DUJSG02H,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:0,Malicious:0
X-CID-BVR: 0
X-UUID: 2821df90930511ed945fc101203acc17-20230113
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1617485230; Fri, 13 Jan 2023 13:43:07 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 13 Jan 2023 13:43:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 13 Jan 2023 13:43:06 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v5 05/10] arm64: dts: mediatek: mt8195: add MUTEX configuration for VPPSYS
Date:   Fri, 13 Jan 2023 13:42:59 +0800
Message-ID: <20230113054304.21841-6-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230113054304.21841-1-moudy.ho@mediatek.com>
References: <20230113054304.21841-1-moudy.ho@mediatek.com>
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

In MT8195, the MMSYS has two Video Processor Pipepline Subsystems
named VPPSYS0 and VPPSYS1, each with specific MUTEX to control
Start of Frame(SOF) and End of Frame (EOF) signals.
Before working with them, the addresses, interrupts, clocks and power
domains need to be set up in dts.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 8bc38700b945..206dd534c3f6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1706,6 +1706,15 @@
 			#clock-cells = <1>;
 		};
 
+		mutex@1400f000 {
+			compatible = "mediatek,mt8195-vpp-mutex";
+			reg = <0 0x1400f000 0 0x1000>;
+			interrupts = <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0xf000 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_MUTEX>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+		};
+
 		smi_sub_common_vpp0_vpp1_2x1: smi@14010000 {
 			compatible = "mediatek,mt8195-smi-sub-common";
 			reg = <0 0x14010000 0 0x1000>;
@@ -1811,6 +1820,15 @@
 			#clock-cells = <1>;
 		};
 
+		mutex@14f01000 {
+			compatible = "mediatek,mt8195-vpp-mutex";
+			reg = <0 0x14f01000 0 0x1000>;
+			interrupts = <GIC_SPI 635 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0x1000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_DISP_MUTEX>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
 		larb5: larb@14f02000 {
 			compatible = "mediatek,mt8195-smi-larb";
 			reg = <0 0x14f02000 0 0x1000>;
-- 
2.18.0

