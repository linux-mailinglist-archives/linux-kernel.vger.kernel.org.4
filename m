Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9226B91A4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCNL36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjCNL3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:29:55 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808EAAC;
        Tue, 14 Mar 2023 04:29:54 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32EBTfgj051738;
        Tue, 14 Mar 2023 06:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678793381;
        bh=w73ME4BqNLG1jQWq7o3E8JXdQsx94xFuptDNByH+I7U=;
        h=From:To:CC:Subject:Date;
        b=b/xpA8nEHutUQM/OcljYb3+JDRGCnKn+2D9xYe2pAqA1aq/zwbhJtZ6A+BGxUvtls
         A8ds/o+nlgXP8MfiKKHs2/pDAErSV6Uu60KwFlgxuW7pqebTqwhRWSFZ0/dS7GFNCw
         Tky3T/heZxD/1Hkqy6TY5UrNbZLi9sEy22ypl+QM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32EBTf5f099463
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Mar 2023 06:29:41 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 14
 Mar 2023 06:29:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 14 Mar 2023 06:29:41 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32EBTejn012980;
        Tue, 14 Mar 2023 06:29:40 -0500
From:   Bhavya Kapoor <b-kapoor@ti.com>
To:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6] arm64: dts: ti: k3-j721s2: Add support for ADC nodes
Date:   Tue, 14 Mar 2023 16:59:39 +0530
Message-ID: <20230314112939.139894-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J721s2 has two instances of 8 channel ADCs in MCU domain. Add support
for both ADC nodes.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---

Changelog v5->v6:
- Added pinmux for ADCs

link to v5 patch : https://lore.kernel.org/all/20230314095553.110559-1-b-kapoor@ti.com/

Testlog for v6 : https://gist.github.com/a0498981/c70327e178cb11c09b8df757e772e9be

 .../dts/ti/k3-j721s2-common-proc-board.dts    | 44 +++++++++++++++++++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 40 +++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index a7aa6cf08acd..b4b9edfe2d12 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -197,6 +197,32 @@ mcu_mcan1_gpio_pins_default: mcu-mcan1-gpio-pins-default {
 			J721S2_WKUP_IOPAD(0x0c8, PIN_INPUT, 7) /* (C28) WKUP_GPIO0_2 */
 		>;
 	};
+
+	mcu_adc0_pins_default: mcu-adc0-pins-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x134, PIN_INPUT, 0) /* (L25) MCU_ADC0_AIN0 */
+			J721S2_WKUP_IOPAD(0x138, PIN_INPUT, 0) /* (K25) MCU_ADC0_AIN1 */
+			J721S2_WKUP_IOPAD(0x13c, PIN_INPUT, 0) /* (M24) MCU_ADC0_AIN2 */
+			J721S2_WKUP_IOPAD(0x140, PIN_INPUT, 0) /* (L24) MCU_ADC0_AIN3 */
+			J721S2_WKUP_IOPAD(0x144, PIN_INPUT, 0) /* (L27) MCU_ADC0_AIN4 */
+			J721S2_WKUP_IOPAD(0x148, PIN_INPUT, 0) /* (K24) MCU_ADC0_AIN5 */
+			J721S2_WKUP_IOPAD(0x14c, PIN_INPUT, 0) /* (M27) MCU_ADC0_AIN6 */
+			J721S2_WKUP_IOPAD(0x150, PIN_INPUT, 0) /* (M26) MCU_ADC0_AIN7 */
+		>;
+	};
+
+	mcu_adc1_pins_default: mcu-adc1-pins-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x154, PIN_INPUT, 0) /* (P25) MCU_ADC1_AIN0 */
+			J721S2_WKUP_IOPAD(0x158, PIN_INPUT, 0) /* (R25) MCU_ADC1_AIN1 */
+			J721S2_WKUP_IOPAD(0x15c, PIN_INPUT, 0) /* (P28) MCU_ADC1_AIN2 */
+			J721S2_WKUP_IOPAD(0x160, PIN_INPUT, 0) /* (P27) MCU_ADC1_AIN3 */
+			J721S2_WKUP_IOPAD(0x164, PIN_INPUT, 0) /* (N25) MCU_ADC1_AIN4 */
+			J721S2_WKUP_IOPAD(0x168, PIN_INPUT, 0) /* (P26) MCU_ADC1_AIN5 */
+			J721S2_WKUP_IOPAD(0x16c, PIN_INPUT, 0) /* (N26) MCU_ADC1_AIN6 */
+			J721S2_WKUP_IOPAD(0x170, PIN_INPUT, 0) /* (N27) MCU_ADC1_AIN7 */
+		>;
+	};
 };
 
 &main_gpio2 {
@@ -309,3 +335,21 @@ &mcu_mcan1 {
 	pinctrl-0 = <&mcu_mcan1_pins_default>;
 	phys = <&transceiver2>;
 };
+
+&tscadc0 {
+	pinctrl-0 = <&mcu_adc0_pins_default>;
+	pinctrl-names = "default";
+	status = "okay";
+	adc {
+		ti,adc-channels = <0 1 2 3 4 5 6 7>;
+	};
+};
+
+&tscadc1 {
+	pinctrl-0 = <&mcu_adc1_pins_default>;
+	pinctrl-names = "default";
+	status = "okay";
+	adc {
+		ti,adc-channels = <0 1 2 3 4 5 6 7>;
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 0af242aa9816..5da5f0cf7009 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -306,4 +306,44 @@ cpts@3d000 {
 			ti,cpts-periodic-outputs = <2>;
 		};
 	};
+
+	tscadc0: tscadc@40200000 {
+		compatible = "ti,am3359-tscadc";
+		reg = <0x00 0x40200000 0x00 0x1000>;
+		interrupts = <GIC_SPI 860 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 0 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 0 0>;
+		assigned-clocks = <&k3_clks 0 2>;
+		assigned-clock-rates = <60000000>;
+		clock-names = "fck";
+		dmas = <&main_udmap 0x7400>,
+			<&main_udmap 0x7401>;
+		dma-names = "fifo0", "fifo1";
+		status = "disabled";
+
+		adc {
+			#io-channel-cells = <1>;
+			compatible = "ti,am3359-adc";
+		};
+	};
+
+	tscadc1: tscadc@40210000 {
+		compatible = "ti,am3359-tscadc";
+		reg = <0x00 0x40210000 0x00 0x1000>;
+		interrupts = <GIC_SPI 861 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 1 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 1 0>;
+		assigned-clocks = <&k3_clks 1 2>;
+		assigned-clock-rates = <60000000>;
+		clock-names = "fck";
+		dmas = <&main_udmap 0x7402>,
+			<&main_udmap 0x7403>;
+		dma-names = "fifo0", "fifo1";
+		status = "disabled";
+
+		adc {
+			#io-channel-cells = <1>;
+			compatible = "ti,am3359-adc";
+		};
+	};
 };
-- 
2.34.1

