Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893615EB832
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiI0DAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiI0C7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:59:05 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60C5A6C14;
        Mon, 26 Sep 2022 19:56:36 -0700 (PDT)
X-UUID: aaa7025935fc4c40b87df74db5d1f801-20220927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=yI6GMl5JSSj0QYIXkbRugVxR1TX7brIbv7q9Z0V2DfQ=;
        b=hFd1Y1e1SVk3Hu2PBanjSsZYNf8x4nJXXUavlXLCRO1BetlbJ3k3folODqvr07KBVf0iQ2S4vX8C2SsMO47uPPIsGBmyZlD50I/nwruV1FDHBZ9Wo0Ty/xAVhFOmZMos2r8TJmcvdHPN8Wo2MN1iIS4q8fSIlxoOD2zs10EPbBg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:53b5dcd2-c81e-45e3-8afe-90e763f72931,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:09612aa3-dc04-435c-b19b-71e131a5fc35,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: aaa7025935fc4c40b87df74db5d1f801-20220927
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1865484572; Tue, 27 Sep 2022 10:56:27 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 27 Sep 2022 10:56:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 27 Sep 2022 10:56:26 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>
Subject: [PATCH v3 03/11] arm64: dts: mt8195: Add SCP core 1 node
Date:   Tue, 27 Sep 2022 10:55:58 +0800
Message-ID: <20220927025606.26673-4-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220927025606.26673-1-tinghan.shen@mediatek.com>
References: <20220927025606.26673-1-tinghan.shen@mediatek.com>
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

Add the 2nd core(core 1) of MT8195 dual-core SCP to devicetree file.
Reserve some SRAM spaces for the core 1 image.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 905d1a90b406..48d457bd39b8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -760,12 +760,24 @@
 
 		scp: scp@10500000 {
 			compatible = "mediatek,mt8195-scp";
-			reg = <0 0x10500000 0 0x100000>,
+			reg = <0 0x10500000 0 0xa0000>,
 			      <0 0x10720000 0 0xe0000>,
 			      <0 0x10700000 0 0x8000>;
 			reg-names = "sram", "cfg", "l1tcm";
 			interrupts = <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH 0>;
 			status = "disabled";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x105a0000 0 0x105a0000 0x20000>;
+
+			scp_c1: scp-c1@105a0000 {
+				compatible = "mediatek,mt8195-scp-core";
+				reg = <0x105a0000 0x20000>;
+				reg-names = "sram";
+				interrupts = <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH 0>;
+				status = "disabled";
+			};
 		};
 
 		scp_adsp: clock-controller@10720000 {
-- 
2.18.0

