Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E96623BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiKJGhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbiKJGh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:37:27 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8562CDFB;
        Wed,  9 Nov 2022 22:37:22 -0800 (PST)
X-UUID: 5c24d21a09404077a48aa50daced8de0-20221110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=o4SwcYmQeEsPhNZNiOlAz3LSIKt52BQiCkN0gMjK+lM=;
        b=ZkKnoofum6hASHZt3TZG5BNd4iNfpwShZ/FMMGsAyaKsywM8huesT3wOzfQd0ei9hb2pXrHwFofmV5uurhpCIpH2nN6rr+h1Vz/7lDIwX1mmkkkGTsnJkWWAZ+tv0Cr28Rsp5SVSRG5u/Gjr4XosOaQNJZTISgClDnhUZNbkg/U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:7d90d25e-dfd1-4590-8ace-0e558026d7f5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:5f99de85-088c-4756-8f76-577be701e693,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5c24d21a09404077a48aa50daced8de0-20221110
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1697423243; Thu, 10 Nov 2022 14:37:19 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 10 Nov 2022 14:37:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 10 Nov 2022 14:37:18 +0800
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <matthias.bgg@gmail.com>
CC:     <angelogioacchino.delregno@collabora.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v4 4/4] arm64: dts: mediatek: cherry: Add edptx and dptx support
Date:   Thu, 10 Nov 2022 14:37:16 +0800
Message-ID: <20221110063716.25677-5-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221110063716.25677-1-rex-bc.chen@mediatek.com>
References: <20221110063716.25677-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cherry projects, we use edptx as the internal display interface
and use dptx as the external display interface. To support this, we
need to add more properties.

- Add pinctrls for edptx and dptx.
- Add ports for edptx and dptx.

The port connections for the internal and external display:
dp-intf0 -> edptx -> panel
dp-intf1 -> dptx

The edptx endpoint is kept empty for now, as the panel addition will
come in a later commit.

Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 303dc32c64dc..560103e29017 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -125,6 +125,7 @@
 
 	port {
 		dp_intf0_out: endpoint {
+			remote-endpoint = <&edp_in>;
 		};
 	};
 };
@@ -134,6 +135,59 @@
 
 	port {
 		dp_intf1_out: endpoint {
+			remote-endpoint = <&dptx_in>;
+		};
+	};
+};
+
+&edp_tx {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&edptx_pins_default>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			edp_in: endpoint {
+				remote-endpoint = <&dp_intf0_out>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			edp_out: endpoint {
+				data-lanes = <0 1 2 3>;
+			};
+		};
+	};
+};
+
+&dp_tx {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dptx_pin>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dptx_in: endpoint {
+				remote-endpoint = <&dp_intf1_out>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			dptx_out: endpoint {
+				data-lanes = <0 1 2 3>;
+			};
 		};
 	};
 };
@@ -497,6 +551,20 @@
 		};
 	};
 
+	edptx_pins_default: edptx-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO7__FUNC_EDP_TX_HPD>;
+			bias-pull-up;
+		};
+	};
+
+	dptx_pin: dptx-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO18__FUNC_DP_TX_HPD>;
+			bias-pull-up;
+		};
+	};
+
 	i2c0_pins: i2c0-default-pins {
 		pins-bus {
 			pinmux = <PINMUX_GPIO8__FUNC_SDA0>,
-- 
2.18.0

