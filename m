Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2775BE251
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiITJrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiITJrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:47:42 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97DE6E2DC;
        Tue, 20 Sep 2022 02:47:36 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28K9lNrQ063608;
        Tue, 20 Sep 2022 04:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1663667244;
        bh=tZoKZu70jYLeuAoYabNntehjn0gfTbbdj58tD/NyA5g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=E81EbaIIOhzzUYHCVQNAdAqmjJYY3OWZx+DsBFaUf+Er6cmnrCUOs1N73dsRv10qC
         bzGbZFewWiv8vtgv/K4CzqJQjKqtXZHoNqUQDLm23eKV8c52igrSkKx/zKT8Kin+Rl
         deS46geOS5olhLBKYv+HVTgJyzBHsAnbZrKkPXW4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28K9lNgf078341
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Sep 2022 04:47:23 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 20
 Sep 2022 04:47:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 20 Sep 2022 04:47:23 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28K9lMJA100432;
        Tue, 20 Sep 2022 04:47:23 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <r-ravikumar@ti.com>, <jkridner@gmail.com>
Subject: [PATCH v5 2/2] arm64: dts: ti: k3-j721e-sk: Add pinmux for RPi Header
Date:   Tue, 20 Sep 2022 15:17:13 +0530
Message-ID: <20220920094713.18950-3-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920094713.18950-1-r-ravikumar@ti.com>
References: <20220920094713.18950-1-r-ravikumar@ti.com>
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

From: Sinthu Raja <sinthu.raja@ti.com>

Add pinmux required to bring out i2c5 and gpios on
40 pin RPi header on sk board

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
Signed-off-by: Rahul T R <r-ravikumar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 55 +++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 98a55778f3fe..a418494d1fd6 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -400,6 +400,47 @@ ekey_reset_pins_default: ekey-reset-pns-pins-default {
 			J721E_IOPAD(0x124, PIN_INPUT, 7) /* (Y24) PRG0_PRU1_GPO9.GPIO0_72 */
 		>;
 	};
+
+	main_i2c5_pins_default: main-i2c5-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x150, PIN_INPUT_PULLUP, 2) /* (Y26) PRG0_MDIO0_MDIO.I2C5_SCL */
+			J721E_IOPAD(0x154, PIN_INPUT_PULLUP, 2) /* (AA27) PRG0_MDIO0_MDC.I2C5_SDA */
+		>;
+	};
+
+	rpi_header_gpio0_pins_default: rpi-header-gpio0-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x01C, PIN_INPUT, 7) /* (AD22) PRG1_PRU0_GPO6.GPIO0_7 */
+			J721E_IOPAD(0x120, PIN_INPUT, 7) /* (AA28) PRG0_PRU1_GPO8.GPIO0_71 */
+			J721E_IOPAD(0x14C, PIN_INPUT, 7) /* (AA29) PRG0_PRU1_GPO19.GPIO0_82 */
+			J721E_IOPAD(0x02C, PIN_INPUT, 7) /* (AD21) PRG1_PRU0_GPO10.GPIO0_11 */
+			J721E_IOPAD(0x198, PIN_INPUT, 7) /* (V25) RGMII6_TD1.GPIO0_101 */
+			J721E_IOPAD(0x1B0, PIN_INPUT, 7) /* (W24) RGMII6_RD1.GPIO0_107 */
+			J721E_IOPAD(0x1A0, PIN_INPUT, 7) /* (W29) RGMII6_TXC.GPIO0_103 */
+			J721E_IOPAD(0x008, PIN_INPUT, 7) /* (AG22) PRG1_PRU0_GPO1.GPIO0_2 */
+			J721E_IOPAD(0x1D0, PIN_INPUT, 7) /* (AA3) SPI0_D1.GPIO0_115 */
+			J721E_IOPAD(0x11C, PIN_INPUT, 7) /* (AA24) PRG0_PRU1_GPO7.GPIO0_70 */
+			J721E_IOPAD(0x148, PIN_INPUT, 7) /* (AA26) PRG0_PRU1_GPO18.GPIO0_81 */
+			J721E_IOPAD(0x004, PIN_INPUT, 7) /* (AC23) PRG1_PRU0_GPO0.GPIO0_1 */
+			J721E_IOPAD(0x014, PIN_INPUT, 7) /* (AH23) PRG1_PRU0_GPO4.GPIO0_5 */
+			J721E_IOPAD(0x020, PIN_INPUT, 7) /* (AE20) PRG1_PRU0_GPO7.GPIO0_8 */
+			J721E_IOPAD(0x19C, PIN_INPUT, 7) /* (W27) RGMII6_TD0.GPIO0_102 */
+			J721E_IOPAD(0x1B4, PIN_INPUT, 7) /* (W25) RGMII6_RD0.GPIO0_108 */
+			J721E_IOPAD(0x188, PIN_INPUT, 7) /* (Y28) RGMII6_TX_CTL.GPIO0_97 */
+			J721E_IOPAD(0x00C, PIN_INPUT, 7) /* (AF22) PRG1_PRU0_GPO2.GPIO0_3 */
+			J721E_IOPAD(0x010, PIN_INPUT, 7) /* (AJ23) PRG1_PRU0_GPO3.GPIO0_4 */
+			J721E_IOPAD(0x178, PIN_INPUT, 7) /* (U27) RGMII5_RD3.GPIO0_93 */
+			J721E_IOPAD(0x17C, PIN_INPUT, 7) /* (U24) RGMII5_RD2.GPIO0_94 */
+			J721E_IOPAD(0x190, PIN_INPUT, 7) /* (W23) RGMII6_TD3.GPIO0_99 */
+			J721E_IOPAD(0x18C, PIN_INPUT, 7) /* (V23) RGMII6_RX_CTL.GPIO0_98 */
+		>;
+	};
+
+	rpi_header_gpio1_pins_default: rpi-header-gpio1-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x234, PIN_INPUT, 7) /* (U3) EXT_REFCLK1.GPIO1_12 */
+		>;
+	};
 };
 
 &wkup_pmx0 {
@@ -633,7 +674,9 @@ &main_i2c4 {
 
 &main_i2c5 {
 	/* Brought out on RPi Header */
-	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c5_pins_default>;
+	clock-frequency = <400000>;
 };
 
 &main_i2c6 {
@@ -1153,3 +1196,13 @@ &main_ehrpwm4 {
 &main_ehrpwm5 {
 	status = "disabled";
 };
+
+&main_gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rpi_header_gpio0_pins_default>;
+};
+
+&main_gpio1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rpi_header_gpio1_pins_default>;
+};
-- 
2.37.3

