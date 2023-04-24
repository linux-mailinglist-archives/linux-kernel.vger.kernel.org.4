Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D8B6ED47D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjDXSeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjDXSee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:34:34 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E47FA;
        Mon, 24 Apr 2023 11:34:30 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33OIYI02050510;
        Mon, 24 Apr 2023 13:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682361258;
        bh=houVssO47MUBZN1UdKiDtz0Lt6fnMFyp2UzbI+eF8ag=;
        h=From:To:CC:Subject:Date;
        b=qme4ef58RdCN0xT81fyQkeMM8RhY0CwNJ0jFWyNXyA5TaBSM/UJET6ST63gbo6xRq
         1DaOgQ98G4SQle8AAkX4u0NGFqXlQIQZaClLd4AzBE9gpsbioFzVFMQ3PRME3CrHbC
         ncxMP3ObVIctPhMsI+udr6giwadxtbiCfBaBxqoU=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33OIYId0106005
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Apr 2023 13:34:18 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 24
 Apr 2023 13:34:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 24 Apr 2023 13:34:17 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33OIYHKm095675;
        Mon, 24 Apr 2023 13:34:17 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH] arm: dts: k3-am62a7-sk: Describe main_uart1 and wkup_uart
Date:   Mon, 24 Apr 2023 13:33:55 -0500
Message-ID: <20230424183355.68360-1-bb@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2535; i=bb@ti.com; h=from:subject; bh=x4alynRBcpF03fu+jVdAgmluJ1ERyZhBFnusirj2cq4=; b=owNCWmg5MUFZJlNZXfWljQAAbf/////9+2Prqv33Pr36H/b+/K//11zO/1vv9sqvj/Pkn90wA RswGKAyaAAxANGgyDIAGgANBoAyNNABoAANGgANNDTIaNMTTRpo0ZNNpPKaZpDkAAGQGgA0xANG mjNRoZNAAxNA9QDQDGoGmgxAyPSBkGmmjI0aAyYmmRoAGUMmE9TBGhoaADRoDIGQ000NABoBkA0 yAAGExNAaMJoDRoaADJk0GmJkAChc8GuBPB8h/G8Yq69R+Iuv5wyTBAzU1s20dz8/h8VDAdXiBg PqkyfLe8rfC+UNS4EmDZ2pwPe2BJbKAnPyBYZYlS2cB4GYjk7m+Y1RP1YLlQiOEbGQXBuGSVfrG J2KCBqPlSBSX27RM1mwHkI3GCCmEMPsUOb8vQ2zT8myeg6sBEg5rs6wt2zy1A0nssZ7RVcw0p7j rOaqGyKqkKdQda0IQbqiMRh5rDnt/ou9sbBLV6zkZJlDA6n/HlGrCKifRc9Dbwkz+n1y022T0AC AhSKsxrHrWhoZsHUCrCSlCRlHp6nsuLdhHuFBNOETj5rCyQaVaTeWvAHD15NgxFZ286EEUsWPG2 +KtCOcGOAnEMGUK+qSTMBunklIB82CGGQHgiNp4nktw/JIr9zgoPLhv4iJyXFGJX7+qiOM+C3yZ yCbcuYmMYrP8XckU4UJBd9aWNA=
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

From: Nishanth Menon <nm@ti.com>

wkup_uart and main_uart1 on this platform is used by tifs and DM
firmwares. Describe them for completeness including the pinmux.

Signed-off-by: Nishanth Menon <nm@ti.com>
[bb@ti.com: updated pinmux]
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 40 +++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index f6a67f072dca6..65caa5611d6d5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -17,7 +17,9 @@ / {
 	model = "Texas Instruments AM62A7 SK";
 
 	aliases {
+		serial0 = &wkup_uart0;
 		serial2 = &main_uart0;
+		serial3 = &main_uart1;
 		mmc1 = &sdhci1;
 	};
 
@@ -114,11 +116,38 @@ led-0 {
 	};
 };
 
+&mcu_pmx0 {
+	wkup_uart0_pins_default: wkup-uart0-pins-default {
+		pinctrl-single,pins = <
+			AM62AX_MCU_IOPAD(0x0024, PIN_INPUT, 0) /* (C9) WKUP_UART0_RXD */
+			AM62AX_MCU_IOPAD(0x0028, PIN_OUTPUT, 0) /* (E9) WKUP_UART0_TXD */
+			AM62AX_MCU_IOPAD(0x002c, PIN_INPUT, 0) /* (C10) WKUP_UART0_CTSn */
+			AM62AX_MCU_IOPAD(0x0030, PIN_OUTPUT, 0) /* (C8) WKUP_UART0_RTSn */
+		>;
+	};
+};
+
+/* WKUP UART0 is used for DM firmware logs */
+&wkup_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_uart0_pins_default>;
+	status = "reserved";
+};
+
 &main_pmx0 {
 	main_uart0_pins_default: main-uart0-pins-default {
 		pinctrl-single,pins = <
-			AM62AX_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14) UART0_RXD */
-			AM62AX_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14) UART0_TXD */
+			AM62AX_IOPAD(0x1c8, PIN_INPUT, 0) /* (E14) UART0_RXD */
+			AM62AX_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (D15) UART0_TXD */
+		>;
+	};
+
+	main_uart1_pins_default: main-uart1-pins-default {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x01e8, PIN_INPUT, 1) /* (C17) I2C1_SCL.UART1_RXD */
+			AM62AX_IOPAD(0x01ec, PIN_OUTPUT, 1) /* (E17) I2C1_SDA.UART1_TXD */
+			AM62AX_IOPAD(0x0194, PIN_INPUT, 2) /* (C19) MCASP0_AXR3.UART1_CTSn */
+			AM62AX_IOPAD(0x0198, PIN_OUTPUT, 2) /* (B19) MCASP0_AXR2.UART1_RTSn */
 		>;
 	};
 
@@ -254,6 +283,13 @@ &main_uart0 {
 	pinctrl-0 = <&main_uart0_pins_default>;
 };
 
+/* Main UART1 is used for TIFS firmware logs */
+&main_uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart1_pins_default>;
+	status = "reserved";
+};
+
 &usbss1 {
 	status = "okay";
 };

base-commit: 891db0c48efb48c3af334006f9d7ea6a0aa49cb9
-- 
2.40.0

