Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E4E71F1FC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjFAScj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjFAScL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:32:11 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F964184;
        Thu,  1 Jun 2023 11:32:10 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 351IVsc5104371;
        Thu, 1 Jun 2023 13:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685644314;
        bh=sqFw905P8KXJAd2CSpvT/ycvs1xK25WoNNgtoL7ZQ28=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=J1VL305qtm8mE5ev1ZufDDvSwRE1ExGh5C/W3tT10A+1KlmTnFYRsFw63GyYLmUnA
         Pfzp9F8YMVkHBoDgOT5GZO/dDG4fpCZcGBgJfHmyjLIX0HsqVIVNZobBTz8uXW4PlR
         Gbmw40Uv5YVDTPM8tNsFR3bpbyY9UeBDhna85bwM=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 351IVs3h069836
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Jun 2023 13:31:54 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Jun 2023 13:31:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Jun 2023 13:31:53 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 351IVr2x002969;
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
Subject: [PATCH 4/9] arm64: dts: ti: j721e-common-proc-board: Add uart pinmux
Date:   Thu, 1 Jun 2023 13:31:46 -0500
Message-ID: <20230601183151.1000157-5-nm@ti.com>
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

Explicitly define the pinmux rather than depend on bootloader configured
pinmux for the platform.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../dts/ti/k3-j721e-common-proc-board.dts     | 62 +++++++++++++++++--
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 5222ec03022f..25111c86511f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -174,6 +174,36 @@ dp_connector_in: endpoint {
 };
 
 &main_pmx0 {
+	main_uart0_pins_default: main-uart0-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1d4, PIN_INPUT, 1) /* (Y3) SPI1_CS0.UART0_CTSn */
+			J721E_IOPAD(0x1c0, PIN_OUTPUT, 1) /* (AA2) SPI0_CS0.UART0_RTSn */
+			J721E_IOPAD(0x1e8, PIN_INPUT, 0) /* (AB2) UART0_RXD */
+			J721E_IOPAD(0x1ec, PIN_OUTPUT, 0) /* (AB3) UART0_TXD */
+		>;
+	};
+
+	main_uart1_pins_default: main-uart1-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1f8, PIN_INPUT, 0) /* (AA4) UART1_RXD */
+			J721E_IOPAD(0x1fc, PIN_OUTPUT, 0) /* (AB4) UART1_TXD */
+		>;
+	};
+
+	main_uart2_pins_default: main-uart2-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1dc, PIN_INPUT, 3) /* (Y1) SPI1_CLK.UART2_RXD */
+			J721E_IOPAD(0x1e0, PIN_OUTPUT, 3) /* (Y5) SPI1_D0.UART2_TXD */
+		>;
+	};
+
+	main_uart4_pins_default: main-uart4-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x190, PIN_INPUT, 1) /* (W23) RGMII6_TD3.UART4_RXD */
+			J721E_IOPAD(0x194, PIN_OUTPUT, 1) /* (W28) RGMII6_TD2.UART4_TXD */
+		>;
+	};
+
 	sw10_button_pins_default: sw10-button-pins-default {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x0, PIN_INPUT, 7) /* (AC18) EXTINTn.GPIO0_0 */
@@ -295,6 +325,22 @@ J721E_IOPAD(0x200, PIN_INPUT, 7) /* (AC4) UART1_CTSn.GPIO0_127 */
 };
 
 &wkup_pmx0 {
+	wkup_uart0_pins_default: wkup-uart0-pins-default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xa0, PIN_INPUT, 0) /* (J29) WKUP_UART0_RXD */
+			J721E_WKUP_IOPAD(0xa4, PIN_OUTPUT, 0) /* (J28) WKUP_UART0_TXD */
+		>;
+	};
+
+	mcu_uart0_pins_default: mcu-uart0-pins-default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xe8, PIN_INPUT, 0) /* (H29) WKUP_GPIO0_14.MCU_UART0_CTSn */
+			J721E_WKUP_IOPAD(0xec, PIN_OUTPUT, 0) /* (J27) WKUP_GPIO0_15.MCU_UART0_RTSn */
+			J721E_WKUP_IOPAD(0xe4, PIN_INPUT, 0) /* (H28) WKUP_GPIO0_13.MCU_UART0_RXD */
+			J721E_WKUP_IOPAD(0xe0, PIN_OUTPUT, 0) /* (G29) WKUP_GPIO0_12.MCU_UART0_TXD */
+		>;
+	};
+
 	sw11_button_pins_default: sw11-button-pins-default {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0xcc, PIN_INPUT, 7) /* (G28) WKUP_GPIO0_7 */
@@ -369,32 +415,40 @@ J721E_WKUP_IOPAD(0xb8, PIN_INPUT, 7) /* (F28) WKUP_GPIO0_2 */
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
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_pins_default>;
 	/* Shared with ATF on this platform */
 	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
 };
 
 &main_uart1 {
 	status = "okay";
-	/* Default pinmux */
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart1_pins_default>;
 };
 
 &main_uart2 {
 	status = "okay";
-	/* Default pinmux */
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart2_pins_default>;
 };
 
 &main_uart4 {
 	status = "okay";
-	/* Default pinmux */
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart4_pins_default>;
 };
 
 &main_gpio2 {
-- 
2.40.0

