Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2A26DF1B4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjDLKKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjDLKKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:10:01 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CDD2D57;
        Wed, 12 Apr 2023 03:09:59 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33CA9rKv024565;
        Wed, 12 Apr 2023 05:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681294193;
        bh=E80AZRjPhpaeA6V+Y6L+cjipzRsu/DNp4SWm8kgDHCo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Petumi9fEbWzwk0CCoXyobrtVERS6yTYjk7UGkYiL/l8Z0NuxWakSoLkm1yke7wKT
         Kv8Dx1/LphzKmVVE+15mbPNgk4BVO5r0p8gY3VP8H5USS+0bc+ElYagz/ZEUh6n8Fn
         QrDk1ORFop+5BiP9N1ek+A+ygdEI2wYvDZWYnTTU=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33CA9rF4076081
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Apr 2023 05:09:53 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 12
 Apr 2023 05:09:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 12 Apr 2023 05:09:53 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33CA9qBW010569;
        Wed, 12 Apr 2023 05:09:53 -0500
From:   Bhavya Kapoor <b-kapoor@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <b-kapoor@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-j784s4-evm: Add pinmux information for ADC
Date:   Wed, 12 Apr 2023 15:39:49 +0530
Message-ID: <20230412100949.850513-3-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230412100949.850513-1-b-kapoor@ti.com>
References: <20230412100949.850513-1-b-kapoor@ti.com>
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

J784S4 has two instances of 8 channel ADCs in MCU domain. Add pinmux
information for both ADC nodes.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 44 ++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index f33815953e77..907a2153b41d 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -165,6 +165,32 @@ J784S4_WKUP_IOPAD(0x09c, PIN_OUTPUT, 0) /* (A36) MCU_MDIO0_MDC */
 			J784S4_WKUP_IOPAD(0x098, PIN_INPUT, 0) /* (B35) MCU_MDIO0_MDIO */
 		>;
 	};
+
+	mcu_adc0_pins_default: mcu-adc0-pins-default {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x134, PIN_INPUT, 0) /* (P36) MCU_ADC0_AIN0 */
+			J784S4_WKUP_IOPAD(0x138, PIN_INPUT, 0) /* (V36) MCU_ADC0_AIN1 */
+			J784S4_WKUP_IOPAD(0x13c, PIN_INPUT, 0) /* (T34) MCU_ADC0_AIN2 */
+			J784S4_WKUP_IOPAD(0x140, PIN_INPUT, 0) /* (T36) MCU_ADC0_AIN3 */
+			J784S4_WKUP_IOPAD(0x144, PIN_INPUT, 0) /* (P34) MCU_ADC0_AIN4 */
+			J784S4_WKUP_IOPAD(0x148, PIN_INPUT, 0) /* (R37) MCU_ADC0_AIN5 */
+			J784S4_WKUP_IOPAD(0x14c, PIN_INPUT, 0) /* (R33) MCU_ADC0_AIN6 */
+			J784S4_WKUP_IOPAD(0x150, PIN_INPUT, 0) /* (V38) MCU_ADC0_AIN7 */
+		>;
+	};
+
+	mcu_adc1_pins_default: mcu-adc1-pins-default {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x154, PIN_INPUT, 0) /* (Y38) MCU_ADC1_AIN0 */
+			J784S4_WKUP_IOPAD(0x158, PIN_INPUT, 0) /* (Y34) MCU_ADC1_AIN1 */
+			J784S4_WKUP_IOPAD(0x15c, PIN_INPUT, 0) /* (V34) MCU_ADC1_AIN2 */
+			J784S4_WKUP_IOPAD(0x160, PIN_INPUT, 0) /* (W37) MCU_ADC1_AIN3 */
+			J784S4_WKUP_IOPAD(0x164, PIN_INPUT, 0) /* (AA37) MCU_ADC1_AIN4 */
+			J784S4_WKUP_IOPAD(0x168, PIN_INPUT, 0) /* (W33) MCU_ADC1_AIN5 */
+			J784S4_WKUP_IOPAD(0x16c, PIN_INPUT, 0) /* (U33) MCU_ADC1_AIN6 */
+			J784S4_WKUP_IOPAD(0x170, PIN_INPUT, 0) /* (Y36) MCU_ADC1_AIN7 */
+		>;
+	};
 };
 
 &main_uart8 {
@@ -253,3 +279,21 @@ &mcu_cpsw_port1 {
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&mcu_phy0>;
 };
+
+&tscadc0 {
+	pinctrl-0 = <&mcu_adc0_pins_default>;
+	pinctrl-names = "default";
+	status = "okay";
+	adc {
+			ti,adc-channels = <0 1 2 3 4 5 6 7>;
+	};
+};
+
+&tscadc1 {
+	pinctrl-0 = <&mcu_adc1_pins_default>;
+	pinctrl-names = "default";
+	status = "okay";
+	adc {
+			ti,adc-channels = <0 1 2 3 4 5 6 7>;
+	};
+};
-- 
2.34.1

