Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA5A6D7AEF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237903AbjDELO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237797AbjDELOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:14:38 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A2B59D5;
        Wed,  5 Apr 2023 04:14:33 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 335BEMNB019360;
        Wed, 5 Apr 2023 06:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680693262;
        bh=BRlbJsoQX8FM0khHXey+jJ5JONeai13EfiYLeaBfKNY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eSff4Eaxn78ul05w6vf89lkTujt43v1vAGU4+0872IwlIO+ZpBqgaqav2QL9Fdih7
         wMqjdk1Pj4GeBIT8g/R60zcNDVgKtGJT+SB4cmN1WIn+UnWX9u77wHEdi1qDr6NKNP
         V7KJgfkNqNyOvHwASCNn/vG90h+agQptybrj9ajU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 335BEMU3078340
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Apr 2023 06:14:22 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 5
 Apr 2023 06:14:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 5 Apr 2023 06:14:22 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 335BELGm003818;
        Wed, 5 Apr 2023 06:14:21 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <s-vadapalli@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH 6/6] arm64: dts: ti: k3-j784s4-evm: Add DP0
Date:   Wed, 5 Apr 2023 16:44:12 +0530
Message-ID: <20230405111412.151192-7-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230405111412.151192-1-j-choudhary@ti.com>
References: <20230405111412.151192-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rahul T R <r-ravikumar@ti.com>

Add the endpoint nodes to describe connection from
DSS => MHDP => DisplayPort connector.

Also add the required nodes gpio expander 4 and pinmux
for main_i2c4 which is required for controlling DP Power
and set status of all the required nodes for DP0 as
okay

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 77 ++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 2b414fd973d0..03c9bf34cb1b 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -102,6 +102,28 @@ vdd_sd_dv: regulator-TLV71033 {
 		states = <1800000 0x0>,
 			 <3300000 0x1>;
 	};
+
+	dp0_pwr_3v3: regulator-dp0-prw {
+		compatible = "regulator-fixed";
+		regulator-name = "dp0-pwr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&exp4 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	dp0: dp0-connector {
+		compatible = "dp-connector";
+		label = "DP0";
+		type = "full-size";
+		dp-pwr-supply = <&dp0_pwr_3v3>;
+
+		port {
+			dp0_connector_in: endpoint {
+				remote-endpoint = <&dp0_out>;
+			};
+		};
+	};
 };
 
 &main_pmx0 {
@@ -169,6 +191,13 @@ dp0_pins_default: dp0-pins-default {
 			J784S4_IOPAD(0x0cc, PIN_INPUT, 12) /* (AM37) SPI0_CS0.DP0_HPD */
 		>;
 	};
+
+	main_i2c4_pins_default: main-i2c4-pins-default {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x014, PIN_INPUT_PULLUP, 8) /* (AG33) MCAN14_TX.I2C4_SCL */
+			J784S4_IOPAD(0x010, PIN_INPUT_PULLUP, 8) /* (AH33) MCAN13_RX.I2C4_SDA */
+		>;
+	};
 };
 
 &wkup_pmx0 {
@@ -313,6 +342,7 @@ &serdes_refclk {
 };
 
 &dss {
+	status = "okay";
 	assigned-clocks = <&k3_clks 218 2>,
 			  <&k3_clks 218 5>,
 			  <&k3_clks 218 14>,
@@ -323,7 +353,12 @@ &dss {
 				 <&k3_clks 218 22>;
 };
 
+&serdes_wiz4 {
+	status = "okay";
+};
+
 &serdes4 {
+	status = "okay";
 	serdes4_dp_link: phy@0 {
 		reg = <0>;
 		cdns,num-lanes = <4>;
@@ -335,8 +370,50 @@ serdes4_dp_link: phy@0 {
 };
 
 &mhdp {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&dp0_pins_default>;
 	phys = <&serdes4_dp_link>;
 	phy-names = "dpphy";
 };
+
+&dss_ports {
+	port {
+		dpi0_out: endpoint {
+			remote-endpoint = <&dp0_in>;
+		};
+	};
+};
+
+&main_i2c4 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c4_pins_default>;
+	clock-frequency = <400000>;
+
+	exp4: gpio@20 {
+		compatible = "ti,tca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&dp0_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	port@0 {
+		reg = <0>;
+		dp0_in: endpoint {
+			remote-endpoint = <&dpi0_out>;
+		};
+	};
+
+	port@4 {
+		reg = <4>;
+		dp0_out: endpoint {
+			remote-endpoint = <&dp0_connector_in>;
+		};
+	};
+};
-- 
2.25.1

