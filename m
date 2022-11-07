Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9492F61EB47
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiKGHAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKGHAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:00:36 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0EB9585;
        Sun,  6 Nov 2022 23:00:35 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A770JY1093080;
        Mon, 7 Nov 2022 01:00:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667804419;
        bh=tAAab/KAtcVE7PGD4xw17lbMGtEahjjN8h1D5UjXh0Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DpGqJBBflmfQsX653++o2ZVH1Jt8Kl4BBLR88XoLH2katMIR5z8XXWWziCNv3glKW
         xcPGJGqWnZS6M6hkZlM6PFO2Rg7MT64U4iTDDaiBnZ5IDr9lDLSYosPeLcrhLqdzfJ
         7Ai5pMXAesveu2XfMRFsRplqru1/AFC00PDxDz2c=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A770Ixa082594
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Nov 2022 01:00:18 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 7 Nov
 2022 01:00:18 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 7 Nov 2022 01:00:18 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A770HiD047636;
        Mon, 7 Nov 2022 01:00:18 -0600
From:   Rahul T R <r-ravikumar@ti.com>
To:     <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <r-ravikumar@ti.com>, <jkridner@gmail.com>
Subject: [PATCH v8 2/2] arm64: dts: ti: k3-j721e-sk: Add pinmux for RPi Header
Date:   Mon, 7 Nov 2022 12:30:09 +0530
Message-ID: <20221107070009.11500-3-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221107070009.11500-1-r-ravikumar@ti.com>
References: <20221107070009.11500-1-r-ravikumar@ti.com>
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

Add pinmux required to bring out i2c5 and gpios on 40 pin RPi header on sk
board

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
Signed-off-by: Rahul T R <r-ravikumar@ti.com>
---

Notes:
    Only GPIO and I2C muxing is enabled, as per the comments and discussion
    in v4

    https://lore.kernel.org/all/20220620144322.x54zitvhjreiy3ey@uda0490373/


 arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 59 ++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 78aa4aa4de57..4640d280c85c 100644
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
@@ -600,6 +641,24 @@ i2c@1 {
 	};
 };
 
+&main_i2c5 {
+	/* Brought out on RPi Header */
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c5_pins_default>;
+	clock-frequency = <400000>;
+};
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
+
 &main_gpio2 {
 	status = "disabled";
 };
-- 
2.38.0

