Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7566E671AD0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjARLhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjARLef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:34:35 -0500
X-Greylist: delayed 161474 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Jan 2023 02:53:20 PST
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BA74ED03
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:53:17 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NxjKD2bsVzMqwpL;
        Wed, 18 Jan 2023 11:53:04 +0100 (CET)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4NxjKC5ZJyzMpxwF;
        Wed, 18 Jan 2023 11:53:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1674039184;
        bh=hcUIogi+1GvOXkLX4kG/3DeG1fiKgZ9VOKvFAAQc7Zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H18AHuXv4XGrfPlI4lk60j03pgjHvFrnJtcLHZLDwxOW14wI9n2I7BGjLQe8mJUN/
         WT04aed167/NiyXEvia4j7VCJCOIKOE8VqN+gk3wgWr0zth8ByKgorY+c9cdUahNFo
         QUZaaCQbi/k4vav7DciS0PQrO0y/xC1kXdnOjFcI=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: imx8mp-verdin-dev: Do not include dahlia dtsi
Date:   Wed, 18 Jan 2023 11:52:51 +0100
Message-Id: <20230118105251.6035-3-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118105251.6035-1-dev@pschenker.ch>
References: <20230118105251.6035-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Follow the change that has been done on imx8mm-verdin-dev.dtsi and
remove the include from dahlia to be consistent. Put back all nodes that
previously had been included.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

 .../boot/dts/freescale/imx8mp-verdin-dev.dtsi | 116 +++++++++++++++++-
 1 file changed, 114 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
index cefabe65b252..361426c0da0a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
@@ -3,8 +3,6 @@
  * Copyright 2022 Toradex
  */
 
-#include "imx8mp-verdin-dahlia.dtsi"
-
 / {
 	/* TODO: Audio Codec */
 
@@ -21,16 +19,99 @@ reg_eth2phy: regulator-eth2phy {
 	};
 };
 
+&backlight {
+	power-supply = <&reg_3p3v>;
+};
+
+/* Verdin SPI_1 */
+&ecspi1 {
+	status = "okay";
+};
+
+/* EEPROM on display adapter boards */
+&eeprom_display_adapter {
+	status = "okay";
+};
+
+/* EEPROM on Verdin Development board */
+&eeprom_carrier_board {
+	status = "okay";
+};
+
+&eqos {
+	status = "okay";
+};
+
 &fec {
 	phy-supply = <&reg_eth2phy>;
 	status = "okay";
 };
 
+&flexcan1 {
+	status = "okay";
+};
+
+&flexcan2 {
+	status = "okay";
+};
+
+/* Verdin QSPI_1 */
+&flexspi {
+	status = "okay";
+};
+
 &gpio_expander_21 {
 	status = "okay";
 	vcc-supply = <&reg_1p8v>;
 };
 
+/* Current measurement into module VCC */
+&hwmon {
+	status = "okay";
+};
+
+&hwmon_temp {
+	vs-supply = <&reg_1p8v>;
+	status = "okay";
+};
+
+/* Verdin I2C_2_DSI */
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+/* Verdin I2C_1 */
+&i2c4 {
+	status = "okay";
+
+	/* TODO: Audio Codec */
+};
+
+/* TODO: Verdin PCIE_1 */
+
+/* Verdin PWM_1 */
+&pwm1 {
+	status = "okay";
+};
+
+/* Verdin PWM_2 */
+&pwm2 {
+	status = "okay";
+};
+
+/* Verdin PWM_3_DSI */
+&pwm3 {
+	status = "okay";
+};
+
+&reg_usdhc2_vmmc {
+	vin-supply = <&reg_3p3v>;
+};
+
 /* TODO: Verdin I2C_1 with Audio Codec */
 
 /* Verdin UART_1, connector X50 through RS485 transceiver */
@@ -38,9 +119,40 @@ &uart1 {
 	linux,rs485-enabled-at-boot-time;
 	rs485-rts-active-low;
 	rs485-rx-during-tx;
+	status = "okay";
+};
+
+/* Verdin UART_2 */
+&uart2 {
+	status = "okay";
+};
+
+/* Verdin UART_3, used as the Linux Console */
+&uart3 {
+	status = "okay";
+};
+
+/* Verdin USB_1 */
+&usb3_0 {
+	status = "okay";
+};
+
+&usb3_phy0 {
+	status = "okay";
+};
+
+/* Verdin USB_2 */
+&usb3_1 {
+	fsl,permanently-attached;
+	status = "okay";
+};
+
+&usb3_phy1 {
+	status = "okay";
 };
 
 /* Limit frequency on dev board due to long traces and bad signal integrity */
 &usdhc2 {
 	max-frequency = <100000000>;
+	status = "okay";
 };
-- 
2.39.0

