Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E815FD31B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 04:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiJMCDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 22:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJMCDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 22:03:44 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A181326B2;
        Wed, 12 Oct 2022 19:03:39 -0700 (PDT)
X-UUID: c38f2e913c5e470186c0b2630d7cbaf6-20221013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0Q5kRH18gt6Y/pbwXFl9/gu+4070qb8aRhjVye5Kcvw=;
        b=D5uYOHeUQVJ/NehsKYzoqOKK/B8uQe+k4vRupYd3ncWIcWQkYyPq2MjXqxGe5Fhhh/QN/ugofg6r1yY8qK4UCo2SCloLbf1qHiA2A5fXOkVkJ0zrxyCpLfkIyKmD0T83aYrrrm5yrKwPf4QDE3P8rCep87KvbCWdR9yEfaV/6Cs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:d957c2a8-edcc-4d49-ab0f-a8ca01274e53,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:2dd9c2e1-2948-402a-a6e4-b5d31fe11eb7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c38f2e913c5e470186c0b2630d7cbaf6-20221013
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 338902578; Thu, 13 Oct 2022 10:03:32 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 13 Oct 2022 10:03:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 13 Oct 2022 10:03:30 +0800
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
Subject: [PATCH v3 4/8] arm64: dts: mediatek: mt8195: add MUTEX configuration for VPPSYS
Date:   Thu, 13 Oct 2022 10:03:25 +0800
Message-ID: <20221013020329.8800-5-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221013020329.8800-1-moudy.ho@mediatek.com>
References: <20221013020329.8800-1-moudy.ho@mediatek.com>
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

In MT8195, the MMSYS has two Video Processor Pipepline Subsystems
named VPPSYS0 and VPPSYS1, each with specific MUTEX to control
Start of Frame(SOF) and End of Frame (EOF) signals.
Before working with them, the addresses, interrupts, clocks and power
domains need to be set up in dts.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 1bb6054531c1..4888d5ff9df7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1483,6 +1483,15 @@
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
@@ -1589,6 +1598,15 @@
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

