Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7D56CD1E0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjC2GBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjC2GBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:01:17 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D6126B7;
        Tue, 28 Mar 2023 23:01:16 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32T611ql038436;
        Wed, 29 Mar 2023 01:01:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680069661;
        bh=wt4xSwJPHwVxOeNl90IK8+byuWNvBIrt26I/jQjG7EM=;
        h=From:To:CC:Subject:Date;
        b=keala8r/71nsiOuUZhWF0yBddDzie/VV53t/kiCTS+z2pFooKx0pjFE913nYqG9le
         MzJVPhGo3ITc8UL7XLIgDpkt/t5hKP/Ri8d2SgZIV+qgCCRsGwXMY8Gf3xhcGZO/Wb
         1QZayNDKMjuvVZ/e4ZGxoLOr5TrSbjCZMm7P8VWQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32T611fC050640
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 01:01:01 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 01:01:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 01:01:01 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32T60wKN006863;
        Wed, 29 Mar 2023 01:00:58 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Apurva Nandan <a-nandan@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-j784s4-evm: Add OSPI0 flash support
Date:   Wed, 29 Mar 2023 11:30:57 +0530
Message-ID: <20230329060057.13654-1-a-nandan@ti.com>
X-Mailer: git-send-email 2.25.1
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

Add support for OSPI flash connected to OSPI0 instance through FSS.
Also enumerate OSPI1 instance in MCU DTSI.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---

Changelog:
- Fixed address 0x0 to 0x00
- Fixed dtbs_check errors (removed syscon and created simple bus)
- Fixed whitespace error

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 45 +++++++++++++++++++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 41 +++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index b9e23697a63b..cc8c2dda7bd2 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -141,12 +141,57 @@ J784S4_IOPAD(0x020, PIN_INPUT, 7) /* (AJ35) MCAN15_RX.GPIO0_8 */
 	};
 };
 
+&wkup_pmx0 {
+	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins-default {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (E32) MCU_OSPI0_CLK */
+			J784S4_WKUP_IOPAD(0x02c, PIN_OUTPUT, 0) /* (A32) MCU_OSPI0_CSn0 */
+			J784S4_WKUP_IOPAD(0x00c, PIN_INPUT, 0) /* (B33) MCU_OSPI0_D0 */
+			J784S4_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (B32) MCU_OSPI0_D1 */
+			J784S4_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (C33) MCU_OSPI0_D2 */
+			J784S4_WKUP_IOPAD(0x018, PIN_INPUT, 0) /* (C35) MCU_OSPI0_D3 */
+			J784S4_WKUP_IOPAD(0x01c, PIN_INPUT, 0) /* (D33) MCU_OSPI0_D4 */
+			J784S4_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (D34) MCU_OSPI0_D5 */
+			J784S4_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (E34) MCU_OSPI0_D6 */
+			J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (E33) MCU_OSPI0_D7 */
+			J784S4_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (C34) MCU_OSPI0_DQS */
+			J784S4_WKUP_IOPAD(0x03c, PIN_OUTPUT, 6) /* (C32) MCU_OSPI0_CSn3.MCU_OSPI0_ECC_FAIL */
+			J784S4_WKUP_IOPAD(0x038, PIN_OUTPUT, 6) /* (B34) MCU_OSPI0_CSn2.MCU_OSPI0_RESET_OUT0 */
+		>;
+	};
+};
+
 &main_uart8 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart8_pins_default>;
 };
 
+&fss {
+	status = "okay";
+};
+
+&ospi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+		spi-max-frequency = <25000000>;
+		cdns,tshsl-ns = <60>;
+		cdns,tsd2d-ns = <60>;
+		cdns,tchsh-ns = <60>;
+		cdns,tslch-ns = <60>;
+		cdns,read-delay = <4>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
+
 &main_i2c0 {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 64bd3dee14aa..f825a8e4b452 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -309,4 +309,45 @@ cpts@3d000 {
 			ti,cpts-periodic-outputs = <2>;
 		};
 	};
+
+	fss: bus@47000000 {
+		compatible = "simple-bus";
+		reg = <0x00 0x47000000 0x00 0x100>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ospi0: spi@47040000 {
+			compatible = "ti,am654-ospi", "cdns,qspi-nor";
+			reg = <0x00 0x47040000 0x00 0x100>,
+			      <0x05 0x0000000 0x01 0x0000000>;
+			interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
+			cdns,fifo-depth = <256>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x0>;
+			clocks = <&k3_clks 161 7>;
+			assigned-clocks = <&k3_clks 161 7>;
+			assigned-clock-parents = <&k3_clks 161 9>;
+			assigned-clock-rates = <166666666>;
+			power-domains = <&k3_pds 161 TI_SCI_PD_EXCLUSIVE>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		ospi1: spi@47050000 {
+			compatible = "ti,am654-ospi", "cdns,qspi-nor";
+			reg = <0x00 0x47050000 0x00 0x100>,
+			      <0x07 0x0000000 0x01 0x0000000>;
+			interrupts = <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>;
+			cdns,fifo-depth = <256>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x0>;
+			clocks = <&k3_clks 162 7>;
+			power-domains = <&k3_pds 162 TI_SCI_PD_EXCLUSIVE>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+	};
 };
-- 
2.34.1

