Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55F2652BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 04:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbiLUDoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 22:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbiLUDo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 22:44:26 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219321EC59;
        Tue, 20 Dec 2022 19:44:22 -0800 (PST)
X-UUID: 52b68b1b2c0d453aa661091c506fa1ca-20221221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vpKkQlPxOc+D9lcuAshw5hI22iECWZhtKc+FVAsWhts=;
        b=LP6sXgJnkSvwyguXIjlgbxcyM52n/T/zhfMlZ+lvodyPXsVGr0EGR/p5qFdb8upVDCCgsgblf79oToRKh12yyZwPKKNaloXfCGGC/7zoT/RellZSFPHM6vVYf84LR/Kooh0ss/u0Qxd35zUlJr3DZnxfsLK+5DGbyTEpekjYx9E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:9bbb5edc-3a33-4a30-b83b-5b550e2d2bc6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:c33283f3-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 52b68b1b2c0d453aa661091c506fa1ca-20221221
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 448610885; Wed, 21 Dec 2022 11:44:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 21 Dec 2022 11:44:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 21 Dec 2022 11:44:14 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ikjoon Jang <ikjn@chromium.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v2 6/6] arm64: dts: mediatek: Add the missing ADSP power domains controller for MT8192
Date:   Wed, 21 Dec 2022 11:44:07 +0800
Message-ID: <20221221034407.19605-7-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221221034407.19605-1-allen-kh.cheng@mediatek.com>
References: <20221221034407.19605-1-allen-kh.cheng@mediatek.com>
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

Add the missing ADSP power domains controller for mt8192-scp_adsp clock
controllers.

Fixes: 5d2b897bc6f5 ("arm64: dts: mediatek: Add mt8192 clock controllers")
Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 6b20376191a7..6ee60db3ac23 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -511,6 +511,14 @@
 						};
 					};
 				};
+
+				power-domain@MT8192_POWER_DOMAIN_ADSP {
+					reg = <MT8192_POWER_DOMAIN_ADSP>;
+					clocks = <&topckgen CLK_TOP_ADSP_SEL>;
+					clock-names = "adsp";
+					mediatek,infracfg = <&infracfg>;
+					#power-domain-cells = <0>;
+				};
 			};
 		};
 
@@ -574,6 +582,7 @@
 		scp_adsp: clock-controller@10720000 {
 			compatible = "mediatek,mt8192-scp_adsp";
 			reg = <0 0x10720000 0 0x1000>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_ADSP>;
 			#clock-cells = <1>;
 		};
 
-- 
2.18.0

