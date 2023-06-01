Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E422871F208
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjFASc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjFAScH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:32:07 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A411A1;
        Thu,  1 Jun 2023 11:32:05 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 351IVr3h091645;
        Thu, 1 Jun 2023 13:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685644314;
        bh=jBmi77Dkh7N5eQtgiJ3RWIehaeWbAIRPMWVgM24xnLY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=g0pwjwtSL3Jx1L+WWtWld2WDuHYXdeetxq5sIg+HLGga1pSnTmhBwgrhGpObCQf0N
         d/+BimGnO5tr7mG22yo+Ke050PS1+dvJeIi9q4aZbrdHVtIHegP8O5mL8wPDJV20Ya
         Yk1zQgo5Gq607heWw8SlnK4Q7iurL2e0zKvtbR3c=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 351IVruF008357
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Jun 2023 13:31:53 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Jun 2023 13:31:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Jun 2023 13:31:53 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 351IVrmY033837;
        Thu, 1 Jun 2023 13:31:53 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Udit Kumar <u-kumar1@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH 1/9] arm64: dts: ti: k3-j721e-sk: Add missing uart pinmuxes
Date:   Thu, 1 Jun 2023 13:31:43 -0500
Message-ID: <20230601183151.1000157-2-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230601183151.1000157-1-nm@ti.com>
References: <20230601183151.1000157-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than depend on the default pinmuxes, explicitly describe the
pinmux

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 31 ++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index c04e845547fa..c068fa46f60e 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -302,6 +302,13 @@ J721E_IOPAD(0x1ec, PIN_OUTPUT, 0) /* (AB3) UART0_TXD */
 		>;
 	};
 
+	main_uart1_pins_default: main-uart1-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1f8, PIN_INPUT, 0) /* (AA4) UART1_RXD */
+			J721E_IOPAD(0x1fc, PIN_OUTPUT, 0) /* (AB4) UART1_TXD */
+		>;
+	};
+
 	main_i2c0_pins_default: main-i2c0-pins-default {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x220, PIN_INPUT_PULLUP, 0) /* (AC5) I2C0_SCL */
@@ -495,6 +502,22 @@ J721E_WKUP_IOPAD(0xd4, PIN_OUTPUT, 7) /* (G26) WKUP_GPIO0_9 */
 		>;
 	};
 
+	wkup_uart0_pins_default: wkup-uart0-pins-default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xa0, PIN_INPUT, 0) /* (J29) WKUP_UART0_RXD */
+			J721E_WKUP_IOPAD(0xa4, PIN_OUTPUT, 0) /* (J28) WKUP_UART0_TXD */
+		>;
+	};
+
+	mcu_uart0_pins_default: mcu-uart0-pins-default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xf0, PIN_INPUT, 2) /* (D26) MCU_I3C0_SCL.MCU_UART0_CTSn */
+			J721E_WKUP_IOPAD(0xf4, PIN_OUTPUT, 2)/* (D25) MCU_I3C0_SDA.MCU_UART0_RTSn */
+			J721E_WKUP_IOPAD(0xe4, PIN_INPUT, 0) /* (H28) WKUP_GPIO0_13.MCU_UART0_RXD */
+			J721E_WKUP_IOPAD(0xe0, PIN_OUTPUT, 0)/* (G29) WKUP_GPIO0_12.MCU_UART0_TXD */
+		>;
+	};
+
 	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0xf8, PIN_INPUT_PULLUP, 0) /* (J25) WKUP_I2C0_SCL */
@@ -513,11 +536,14 @@ J721E_WKUP_IOPAD(0xdc, PIN_INPUT, 7) /* (H27) WKUP_GPIO0_11 */
 &wkup_uart0 {
 	/* Wakeup UART is used by System firmware */
 	status = "reserved";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_uart0_pins_default>;
 };
 
 &mcu_uart0 {
 	status = "okay";
-	/* Default pinmux */
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_uart0_pins_default>;
 };
 
 &main_uart0 {
@@ -530,7 +556,8 @@ &main_uart0 {
 
 &main_uart1 {
 	status = "okay";
-	/* Default pinmux */
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart1_pins_default>;
 };
 
 &main_sdhci0 {
-- 
2.40.0

