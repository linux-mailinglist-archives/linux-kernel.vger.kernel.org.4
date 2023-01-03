Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0570E65BA01
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 05:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbjACEVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 23:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjACEVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 23:21:34 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D45297;
        Mon,  2 Jan 2023 20:21:32 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3034LP5a099120;
        Mon, 2 Jan 2023 22:21:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672719685;
        bh=Pd0mYcegahaejQV/JjfY9EKzj1a59BiUjHBhdXWCjAI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=F5fLkqikkIYzHipwAMjC5v5Vep2hreDk/Bs3GfhoA34BOYFvY98oN1n6mAOvnt6hU
         uiJAjlWDqSAPTU51aoocWqxuJE+zIdjVMcpffjPlrlGibOGOBqokS68UA3P4y5UEkP
         XhDItEj/mBae0SuA8+p5vJczZo+ZZKlHqs/uyK6g=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3034LPt6053090
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jan 2023 22:21:25 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 2
 Jan 2023 22:21:24 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 2 Jan 2023 22:21:25 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3034LDwu084970;
        Mon, 2 Jan 2023 22:21:22 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bb@ti.com>
Subject: [PATCH 3/4] arm64: dts: ti: k3-am62a7-sk: Enable  ethernet port
Date:   Tue, 3 Jan 2023 09:51:09 +0530
Message-ID: <20230103042110.1092122-4-vigneshr@ti.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103042110.1092122-1-vigneshr@ti.com>
References: <20230103042110.1092122-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM62A7 SK has a DP83867 PHY on the board connected to first port of
CPSW, enable the same.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 54 +++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 576dbce80ad8..bdc363fcbb4b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -9,6 +9,7 @@
 
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/net/ti-dp83867.h>
 #include "k3-am62a7.dtsi"
 
 / {
@@ -158,6 +159,30 @@ usr_led_pins_default: usr-led-pins-default {
 			AM62AX_IOPAD(0x244, PIN_OUTPUT, 7) /* (D18) MMC1_SDWP.GPIO1_49 */
 		>;
 	};
+
+	main_mdio1_pins_default: main-mdio1-pins-default {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x160, PIN_OUTPUT, 0) /* (V12) MDIO0_MDC */
+			AM62AX_IOPAD(0x15c, PIN_INPUT, 0) /* (V13) MDIO0_MDIO */
+		>;
+	};
+
+	main_rgmii1_pins_default: main-rgmii1-pins-default {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x14c, PIN_INPUT, 0) /* (AB16) RGMII1_RD0 */
+			AM62AX_IOPAD(0x150, PIN_INPUT, 0) /* (V15) RGMII1_RD1 */
+			AM62AX_IOPAD(0x154, PIN_INPUT, 0) /* (W15) RGMII1_RD2 */
+			AM62AX_IOPAD(0x158, PIN_INPUT, 0) /* (V14) RGMII1_RD3 */
+			AM62AX_IOPAD(0x148, PIN_INPUT, 0) /* (AA16) RGMII1_RXC */
+			AM62AX_IOPAD(0x144, PIN_INPUT, 0) /* (AA15) RGMII1_RX_CTL */
+			AM62AX_IOPAD(0x134, PIN_INPUT, 0) /* (Y17) RGMII1_TD0 */
+			AM62AX_IOPAD(0x138, PIN_INPUT, 0) /* (V16) RGMII1_TD1 */
+			AM62AX_IOPAD(0x13c, PIN_INPUT, 0) /* (Y16) RGMII1_TD2 */
+			AM62AX_IOPAD(0x140, PIN_INPUT, 0) /* (AA17) RGMII1_TD3 */
+			AM62AX_IOPAD(0x130, PIN_INPUT, 0) /* (AB17) RGMII1_TXC */
+			AM62AX_IOPAD(0x12c, PIN_INPUT, 0) /* (W16) RGMII1_TX_CTL */
+		>;
+	};
 };
 
 &main_i2c0 {
@@ -221,3 +246,32 @@ &main_uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
 };
+
+&cpsw3g {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_rgmii1_pins_default>;
+};
+
+&cpsw_port1 {
+	status = "okay";
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&cpsw3g_phy0>;
+};
+
+&cpsw_port2 {
+	status = "disabled";
+};
+
+&cpsw3g_mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mdio1_pins_default>;
+
+	cpsw3g_phy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+};
-- 
2.39.0

