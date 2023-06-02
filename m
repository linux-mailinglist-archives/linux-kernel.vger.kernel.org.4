Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B465720B3D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 23:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbjFBVuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 17:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbjFBVtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 17:49:51 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BED41BB;
        Fri,  2 Jun 2023 14:49:49 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 352Lndr9072489;
        Fri, 2 Jun 2023 16:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685742579;
        bh=jI+nDGX8lCYqPRP99t/hL8phcW6w/q6DhsT4zyCBtC0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=O+tIU+2JibWQuZknB270sKZnjx0hVqxmQrbJb/GGQItecNl7p2opJw5fctwWleuS0
         Y43aQwrU3kjj99jmMx8Gbh02zcF+/y0OytnbBcz9mIapVZHj+WHJqditLnYeX2UaHa
         rQwlCSLVOWj7Z5t8wLX/+kmHG1GjS5CbMKQPCnHI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 352LndkY017965
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Jun 2023 16:49:39 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Jun 2023 16:49:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Jun 2023 16:49:38 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 352LnciY006133;
        Fri, 2 Jun 2023 16:49:38 -0500
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
Subject: [PATCH 2/8] arm64: dts: ti: k3-j784s4-evm: Add mcu and wakeup uarts
Date:   Fri, 2 Jun 2023 16:49:31 -0500
Message-ID: <20230602214937.2349545-3-nm@ti.com>
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

Add wakeup and MCU uart. This allows the device tree usage in
bootloader and firmwares that can configure the same appropriately.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Depends on https://lore.kernel.org/linux-arm-kernel/20230503083143.32369-1-t-konduru@ti.com/

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 33 ++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 34e9bc89ac66..3f499e527523 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -20,6 +20,8 @@ chosen {
 	};
 
 	aliases {
+		serial0 = &wkup_uart0;
+		serial1 = &mcu_uart0;
 		serial2 = &main_uart8;
 		mmc0 = &main_sdhci0;
 		mmc1 = &main_sdhci1;
@@ -142,6 +144,24 @@ J784S4_IOPAD(0x020, PIN_INPUT, 7) /* (AJ35) MCAN15_RX.GPIO0_8 */
 };
 
 &wkup_pmx2 {
+	wkup_uart0_pins_default: wkup-uart0-pins-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x070, PIN_INPUT, 0) /* (L37) WKUP_GPIO0_6.WKUP_UART0_CTSn */
+			J721S2_WKUP_IOPAD(0x074, PIN_INPUT, 0) /* (L36) WKUP_GPIO0_7.WKUP_UART0_RTSn */
+			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (K35) WKUP_UART0_RXD */
+			J721S2_WKUP_IOPAD(0x04c, PIN_INPUT, 0) /* (K34) WKUP_UART0_TXD */
+		>;
+	};
+
+	mcu_uart0_pins_default: mcu-uart0-pins-default {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x090, PIN_INPUT, 0) /* (H37) WKUP_GPIO0_14.MCU_UART0_CTSn */
+			J784S4_WKUP_IOPAD(0x094, PIN_OUTPUT, 0) /* (K37) WKUP_GPIO0_15.MCU_UART0_RTSn */
+			J784S4_WKUP_IOPAD(0x08c, PIN_INPUT, 0) /* (K38) WKUP_GPIO0_13.MCU_UART0_RXD */
+			J784S4_WKUP_IOPAD(0x088, PIN_OUTPUT, 0) /* (J37) WKUP_GPIO0_12.MCU_UART0_TXD */
+		>;
+	};
+
 	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
 		pinctrl-single,pins = <
 			J784S4_WKUP_IOPAD(0x02c, PIN_INPUT, 0) /* (A35) MCU_RGMII1_RD0 */
@@ -167,6 +187,19 @@ J784S4_WKUP_IOPAD(0x030, PIN_INPUT, 0) /* (B35) MCU_MDIO0_MDIO */
 	};
 };
 
+&wkup_uart0 {
+	/* Firmware usage */
+	status = "reserved";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_uart0_pins_default>;
+};
+
+&mcu_uart0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_uart0_pins_default>;
+};
+
 &main_uart8 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.40.0

