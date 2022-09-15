Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085135B95D6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiIOH7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiIOH7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:59:06 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E382979EB;
        Thu, 15 Sep 2022 00:58:58 -0700 (PDT)
X-UUID: f2baa954dd6642a3a4880e0296123775-20220915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5pXFUuNNkvX/Cn54bUu5mnnDNovYaXiTGpv0te35ZHI=;
        b=ts76M5c2ioNN9701ZoX24P3tTLAAz5PxFF6/CNmR2TQgM48vkL3y+mr1W0qt1X5oFE/C93jATsvwrkrIf9mwEEuIco2QhykiwIFcS55KPiRhI2zA7lWKINO0+dPRBmVLfDqMkYgk27U1phE/PGSS+5jt5pE8qE6D8zAcvpqHHt4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:16e2fa3d-700e-4286-a165-154cfd663673,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:16e2fa3d-700e-4286-a165-154cfd663673,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:d371b97b-ea28-4199-b57e-003c7d60873a,B
        ulkID:220915155855ZO7WERB3,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: f2baa954dd6642a3a4880e0296123775-20220915
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 335012239; Thu, 15 Sep 2022 15:58:52 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 15 Sep 2022 15:58:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 15 Sep 2022 15:58:51 +0800
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH 4/4] arm64: dts: mediatek: cherry: Add edptx and dptx support
Date:   Thu, 15 Sep 2022 15:58:49 +0800
Message-ID: <20220915075849.1920-5-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220915075849.1920-1-rex-bc.chen@mediatek.com>
References: <20220915075849.1920-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add pinctrl for edptx and dptx.
- Add port for edptx and dptx.

Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
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

