Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002CF720B3A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 23:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbjFBVuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 17:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236665AbjFBVtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 17:49:52 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18791E40;
        Fri,  2 Jun 2023 14:49:50 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 352LndGD072497;
        Fri, 2 Jun 2023 16:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685742579;
        bh=XmH/7b2jgWDrCo4pqahu53GTXlvcTm6dtDowrecpg8I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GmuFXIMYpl5ojMmuJdJ/qmrNtwwaaYf2WEQVii+gpaDIzaS3qxSWtCZEo+ZJAou8B
         WlGnPToRaTyUveH6CZbHf9WUwI33/QobZN8vkq3SuHPlwmRzG0zUlLReDVjShNVaW8
         hY07WNaCnqBQ0Lt+qPxOav7NoKgl06ET73wWtBmA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 352Lndvj028993
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Jun 2023 16:49:39 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Jun 2023 16:49:39 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Jun 2023 16:49:38 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 352LndbS001305;
        Fri, 2 Jun 2023 16:49:39 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Udit Kumar <u-kumar1@ti.com>, Nitin Yadav <n-yadav@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>,
        Thejasvi Konduru <t-konduru@ti.com>,
        Dasnavis Sabiya <sabiya.d@ti.com>
Subject: [PATCH 8/8] arm64: dts: ti: k3-am69-sk: Add pinmux for RPi Header
Date:   Fri, 2 Jun 2023 16:49:37 -0500
Message-ID: <20230602214937.2349545-9-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230602214937.2349545-1-nm@ti.com>
References: <20230602214937.2349545-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dasnavis Sabiya <sabiya.d@ti.com>

Add pinmux required to bring out the i2c and gpios on 40 pin RPi
expansion header on AM69 SK board.

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Depends on https://lore.kernel.org/linux-arm-kernel/20230503083143.32369-1-t-konduru@ti.com/

Changes since V1:
* Rebased on the pinmux split up done from the dependency.
* Some minor style fixups.

V1: https://lore.kernel.org/linux-arm-kernel/20230316104743.482972-3-sabiya.d@ti.com/

 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 63 +++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index a0e7872f31f2..093c6f8391e4 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -141,6 +141,25 @@ vdd_sd_dv_pins_default: vdd-sd-dv-pins-default {
 			J784S4_IOPAD(0x0C4, PIN_INPUT, 7) /* (AD36) ECAP0_IN_APWM_OUT.GPIO0_49 */
 		>;
 	};
+
+	rpi_header_gpio0_pins_default: rpi-header-gpio0-pins-default {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x0BC, PIN_INPUT, 7) /* (AD33) MCASP1_AFSX.GPIO0_47 */
+			J784S4_IOPAD(0x06C, PIN_INPUT, 7) /* (AJ37) MCASP4_AFSX.GPIO0_27 */
+			J784S4_IOPAD(0x0B4, PIN_INPUT, 7) /* (AL34) MCASP1_AXR4.GPIO0_45 */
+			J784S4_IOPAD(0x0C0, PIN_INPUT, 7) /* (AD38) MCASP1_AXR0.GPIO0_48 */
+			J784S4_IOPAD(0x00C, PIN_INPUT, 7) /* (AF33) MCAN13_TX.GPIO0_3 */
+			J784S4_IOPAD(0x0B8, PIN_INPUT, 7) /* (AC34) MCASP1_ACLKX.GPIO0_46 */
+			J784S4_IOPAD(0x090, PIN_INPUT, 7) /* (AC35) MCASP0_AXR8.GPIO0_36 */
+			J784S4_IOPAD(0x0A8, PIN_INPUT, 7) /* (AF34) MCASP0_AXR14.GPIO0_42 */
+			J784S4_IOPAD(0x0A4, PIN_INPUT, 7) /* (AJ36) MCASP0_AXR13.GPIO0_41 */
+			J784S4_IOPAD(0x034, PIN_INPUT, 7) /* (AJ34) PMIC_WAKE0n.GPIO0_13 */
+			J784S4_IOPAD(0x0CC, PIN_INPUT, 7) /* (AM37) SPI0_CS0.GPIO0_51 */
+			J784S4_IOPAD(0x08C, PIN_INPUT, 7) /* (AE35) MCASP0_AXR7.GPIO0_35 */
+			J784S4_IOPAD(0x008, PIN_INPUT, 7) /* (AJ33) MCAN12_RX.GPIO0_2 */
+			J784S4_IOPAD(0x004, PIN_INPUT, 7) /* (AG36) MCAN12_TX.GPIO0_1 */
+		>;
+	};
 };
 
 &wkup_pmx2 {
@@ -167,6 +186,13 @@ J784S4_WKUP_IOPAD(0x088, PIN_OUTPUT, 0) /* (J37) WKUP_GPIO0_12.MCU_UART0_TXD */
 		>;
 	};
 
+	mcu_i2c0_pins_default: mcu-i2c0-pins-default {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x0a0, PIN_INPUT_PULLUP, 0) /* (M35) MCU_I2C0_SCL */
+			J784S4_WKUP_IOPAD(0x0a4, PIN_INPUT_PULLUP, 0) /* (G34) MCU_I2C0_SDA */
+		>;
+	};
+
 	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
 		pinctrl-single,pins = <
 			J784S4_WKUP_IOPAD(0x02c, PIN_INPUT, 0) /* (A35) MCU_RGMII1_RD0 */
@@ -190,6 +216,28 @@ J784S4_WKUP_IOPAD(0x034, PIN_OUTPUT, 0) /* (A36) MCU_MDIO0_MDC */
 			J784S4_WKUP_IOPAD(0x030, PIN_INPUT, 0) /* (B35) MCU_MDIO0_MDIO */
 		>;
 	};
+
+	mcu_rpi_hdr1_gpio0_pins_default: mcu-rpi-hdr1-gpio0-pins-default {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x118, PIN_INPUT, 7) /* (N34) WKUP_GPIO0_66 */
+			J784S4_WKUP_IOPAD(0x05c, PIN_INPUT, 7) /* (J34) WKUP_GPIO0_1 */
+			J784S4_WKUP_IOPAD(0x060, PIN_INPUT, 7) /* (J35) WKUP_GPIO0_2 */
+			J784S4_WKUP_IOPAD(0x058, PIN_INPUT, 7) /* (H38) WKUP_GPIO0_0 */
+			J784S4_WKUP_IOPAD(0x0b8, PIN_INPUT, 7) /* (M37) WKUP_GPIO0_56 */
+			J784S4_WKUP_IOPAD(0x114, PIN_INPUT, 7) /* (M36) WKUP_GPIO0_57 */
+			J784S4_WKUP_IOPAD(0x094, PIN_INPUT, 7) /* (K37) WKUP_GPIO0_15 */
+			J784S4_WKUP_IOPAD(0x064, PIN_INPUT, 7) /* (J36) WKUP_GPIO0_3 */
+			J784S4_WKUP_IOPAD(0x11c, PIN_INPUT, 7) /* (M34) WKUP_GPIO0_67 */
+		>;
+	};
+};
+
+&wkup_pmx3 {
+	mcu_rpi_hdr2_gpio0_pins_default: mcu-rpi-hdr2-gpio0-pins-default {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x0, PIN_INPUT, 7) /* (M33) WKUP_GPIO0_49 */
+		>;
+	};
 };
 
 &wkup_uart0 {
@@ -212,12 +260,25 @@ eeprom@51 {
 	};
 };
 
+&wkup_gpio0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_rpi_hdr1_gpio0_pins_default>, <&mcu_rpi_hdr2_gpio0_pins_default>;
+};
+
 &mcu_uart0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_uart0_pins_default>;
 };
 
+&mcu_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_i2c0_pins_default>;
+	clock-frequency = <400000>;
+};
+
 &main_uart8 {
 	status = "okay";
 	pinctrl-names = "default";
@@ -256,6 +317,8 @@ &main_sdhci1 {
 
 &main_gpio0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&rpi_header_gpio0_pins_default>;
 };
 
 &mcu_cpsw {
-- 
2.40.0

