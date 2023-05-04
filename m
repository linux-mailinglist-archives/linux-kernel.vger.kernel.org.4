Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1C36F6D3D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjEDNr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjEDNrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:47:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBE57A99
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 06:47:39 -0700 (PDT)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <m.felsch@pengutronix.de>)
        id 1puZIW-0004SX-OF; Thu, 04 May 2023 15:47:04 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
Date:   Thu, 04 May 2023 15:46:53 +0200
Subject: [PATCH v2 4/4] arm64: dts: imx8mp-evk: add dual-role usb port1
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-4-3889b1b2050c@pengutronix.de>
References: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-0-3889b1b2050c@pengutronix.de>
In-Reply-To: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-0-3889b1b2050c@pengutronix.de>
To:     andreas@fatal.se, jun.li@nxp.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.12.1
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8MP-EVK has a dual-role usb-type-c port marked as PORT1. By this
commit the dual-role support is added which allows the user-space to
assign usb-gadget functions to it via the configFS.

Below is the test results of a basic usbgadget-ethernet test using by
iperf3.

Accepted connection from 192.168.60.1, port 48172
[  5] local 192.168.60.2 port 5201 connected to 192.168.60.1 port 48176
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec   101 MBytes   850 Mbits/sec
[  5]   1.00-2.00   sec   105 MBytes   883 Mbits/sec
[  5]   2.00-3.00   sec   105 MBytes   885 Mbits/sec

...

- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-100.04 sec  10.3 GBytes   882 Mbits/sec                  receiver

Accepted connection from 192.168.60.1, port 42104
[  5] local 192.168.60.2 port 5201 connected to 192.168.60.1 port 42110
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   110 MBytes   925 Mbits/sec    0    540 KBytes
[  5]   1.00-2.00   sec   112 MBytes   938 Mbits/sec    0    566 KBytes
[  5]   2.00-3.00   sec   115 MBytes   969 Mbits/sec    0    566 KBytes

...

- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-37.00  sec  4.27 GBytes   990 Mbits/sec    0             sender

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 88 ++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 7816853162b3..20c3c41d6209 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -5,7 +5,9 @@
 
 /dts-v1/;
 
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/phy/phy-imx8-pcie.h>
+#include <dt-bindings/usb/pd.h>
 #include "imx8mp.dtsi"
 
 / {
@@ -83,6 +85,22 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	usb-ss-mux {
+		compatible = "gpio-ss-mux";
+		enable-gpios = <&gpio2 20 GPIO_ACTIVE_LOW>;
+		select-gpios = <&gpio4 20 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb_ss_mux>;
+
+		orientation-switch;
+
+		port {
+			usb_ss_mux: endpoint {
+				remote-endpoint = <&usb_con_ss_mux>;
+			};
+		};
+	};
 };
 
 &flexspi {
@@ -336,6 +354,40 @@ &i2c2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
+
+	tcpc@50 {
+		compatible = "nxp,ptn5110";
+		reg = <0x50>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tcpc>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "dual";
+			data-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_VAR(5000, 20000, 3000)>;
+			op-sink-microwatt = <15000000>;
+			self-powered;
+
+			port {
+				usb_con_ss_mux: endpoint {
+					remote-endpoint = <&usb_ss_mux>;
+				};
+			};
+		};
+
+		port {
+			usb_con_ss: endpoint {
+				remote-endpoint = <&usb_dwc3_0_drd>;
+			};
+		};
+	};
 };
 
 &i2c3 {
@@ -442,14 +494,37 @@ &uart2 {
 	status = "okay";
 };
 
+&usb3_phy0 {
+	status = "okay";
+};
+
 &usb3_phy1 {
 	status = "okay";
 };
 
+&usb3_0 {
+	status = "okay";
+};
+
 &usb3_1 {
 	status = "okay";
 };
 
+&usb_dwc3_0 {
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
+	status = "okay";
+
+	port {
+		usb_dwc3_0_drd: endpoint {
+			remote-endpoint = <&usb_con_ss>;
+		};
+	};
+};
+
 &usb_dwc3_1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb1_vbus>;
@@ -659,6 +734,12 @@ MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
 		>;
 	};
 
+	pinctrl_tcpc: tcpcgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19	0x1e0
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX	0x140
@@ -690,6 +771,13 @@ MX8MP_IOMUXC_ECSPI1_MISO__UART3_DCE_CTS		0x140
 		>;
 	};
 
+	pinctrl_usb_ss_mux: usbssmuxgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_WP__GPIO2_IO20		0x104
+			MX8MP_IOMUXC_SAI1_MCLK__GPIO4_IO20	0x144
+		>;
+	};
+
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x190

-- 
2.39.2

