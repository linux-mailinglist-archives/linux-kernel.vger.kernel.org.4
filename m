Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BFF720652
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbjFBPgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbjFBPgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:36:12 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4C71A1;
        Fri,  2 Jun 2023 08:36:09 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 352FZvau118405;
        Fri, 2 Jun 2023 10:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685720157;
        bh=URQLikW4i6p/yS1LGKoVMXHzfa2hlYD5+Ta3mGuHcYU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=V3ajfBOMAiy2zZFovWNPuJqB+BF3ie4V2XUC3Rfc4vaMOFx8wFstqTXQH+6YWEiUo
         xR3bq5MZmLf0FZypTmlEn3vQ+CBc9dIDKZHyNQpZG2+c/sb5HW7S4RLrkoSVQEh8Zf
         xZ0Fl6ZlTsUxHMnGpj4FVBlcFNcH48uCOPnHADC4=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 352FZvv7056221
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Jun 2023 10:35:57 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Jun 2023 10:35:57 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Jun 2023 10:35:57 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 352FZv6V046548;
        Fri, 2 Jun 2023 10:35:57 -0500
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
        Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH 3/6] arm64: dts: ti: k3-am68-sk-base-board: Add uart pinmux
Date:   Fri, 2 Jun 2023 10:35:51 -0500
Message-ID: <20230602153554.1571128-4-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230602153554.1571128-1-nm@ti.com>
References: <20230602153554.1571128-1-nm@ti.com>
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

Define the wakeup uart pin-mux for completeness and add explicit
muxing for mcu_uart0. This allows the device tree usage in bootloader
and firmwares that can configure the same appropriately.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
New patch in the series

 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index 014ff13d1032..979898bc5b02 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -22,6 +22,8 @@ chosen {
 	};
 
 	aliases {
+		serial0 = &wkup_uart0;
+		serial1 = &mcu_uart0;
 		serial2 = &main_uart8;
 		mmc1 = &main_sdhci1;
 		can0 = &mcu_mcan0;
@@ -202,6 +204,15 @@ J721S2_IOPAD(0x08c, PIN_INPUT, 7) /* (T25) MCASP0_AXR7.GPIO0_35 */
 };
 
 &wkup_pmx2 {
+	wkup_uart0_pins_default: wkup-uart0-pins-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x070, PIN_INPUT, 0) /* (E25) WKUP_GPIO0_6.WKUP_UART0_CTSn */
+			J721S2_WKUP_IOPAD(0x074, PIN_OUTPUT, 0) /* (F28) WKUP_GPIO0_7.WKUP_UART0_RTSn */
+			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (D28) WKUP_UART0_RXD */
+			J721S2_WKUP_IOPAD(0x04c, PIN_OUTPUT, 0) /* (D27) WKUP_UART0_TXD */
+		>;
+	};
+
 	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
 		pinctrl-single,pins = <
 			J721S2_WKUP_IOPAD(0x02C, PIN_INPUT, 0) /* (B22) MCU_RGMII1_RD0 */
@@ -254,6 +265,13 @@ J721S2_WKUP_IOPAD(0x07c, PIN_INPUT, 0) /* (H26) WKUP_GPIO0_9.MCU_I2C1_SDA */
 		>;
 	};
 
+	mcu_uart0_pins_default: mcu-uart0-pins-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x08c, PIN_INPUT, 0) /* (C24) WKUP_GPIO0_13.MCU_UART0_RXD */
+			J721S2_WKUP_IOPAD(0x088, PIN_OUTPUT, 0) /* (C25) WKUP_GPIO0_12.MCU_UART0_TXD */
+		>;
+	};
+
 	mcu_rpi_header_gpio0_pins0_default: mcu-rpi-header-gpio0-pins0-default {
 		pinctrl-single,pins = <
 			J721S2_WKUP_IOPAD(0x118, PIN_INPUT, 7) /* (G25) WKUP_GPIO0_66 */
@@ -305,6 +323,14 @@ &wkup_gpio1 {
 
 &wkup_uart0 {
 	status = "reserved";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_uart0_pins_default>;
+};
+
+&mcu_uart0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_uart0_pins_default>;
 };
 
 &main_uart8 {
-- 
2.40.0

