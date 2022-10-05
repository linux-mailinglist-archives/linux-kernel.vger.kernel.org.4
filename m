Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CD15F55B4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiJENkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJENjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:39:49 -0400
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [IPv6:2001:1600:3:17::190b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2496170
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 06:39:40 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MjFzt0tCWzMpnRs;
        Wed,  5 Oct 2022 15:39:38 +0200 (CEST)
Received: from philippe-pc.toradex.int (unknown [31.10.206.125])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MjFzq6jXRzMpnPg;
        Wed,  5 Oct 2022 15:39:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1664977178;
        bh=QMQX0DS3WXjc8rDGJOqWledK9ARkl+Fl6HYi6388JDg=;
        h=From:To:Cc:Subject:Date:From;
        b=UR1DmoFV0iZWJkSJz0DWIS3k+3ROZ0HG7fwjxPzF6DOHXf8DHw6oEKUlvGxF9b6Gn
         /ixjLGqB8t5mLEaxy0fJIHTbxpNhbXByQkvQNzoBWL7Pfjj95GDAij6QC9AgDWOSKf
         O3J09AfXG2p7aqh5TAR7o82YyHDxuxHkVbbwDn2I=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm: dts: colibri-imx6ull: keep peripherals disabled
Date:   Wed,  5 Oct 2022 15:39:26 +0200
Message-Id: <20221005133929.1243443-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Toradex does provide device-tree overlays to enable certain evaluation
hardware. Keep the buses disabled by default to be enabled again with
overlays.

For customers including this device-tree this has also the advantage
that the hardware we want by default running does not automatically
enable signals on their end.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 577a424b0e1d..a4429ba1f2ae 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -21,7 +21,7 @@ backlight: backlight {
 		pinctrl-0 = <&pinctrl_gpio_bl_on>;
 		power-supply = <&reg_3v3>;
 		pwms = <&pwm4 0 5000000 1>;
-		status = "okay";
+		status = "disabled";
 	};
 
 	gpio-keys {
@@ -42,7 +42,7 @@ panel_dpi: panel-dpi {
 		compatible = "edt,et057090dhu";
 		backlight = <&backlight>;
 		power-supply = <&reg_3v3>;
-		status = "okay";
+		status = "disabled";
 
 		port {
 			lcd_panel_in: endpoint {
@@ -159,7 +159,7 @@ &i2c1 {
 	pinctrl-1 = <&pinctrl_i2c1_gpio>;
 	sda-gpios = <&gpio1 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	scl-gpios = <&gpio1 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	status = "okay";
+	status = "disabled";
 
 	/* Atmel maxtouch controller */
 	atmel_mxt_ts: touchscreen@4a {
@@ -202,6 +202,7 @@ ad7879_ts: touchscreen@2c {
 		adi,median-filter-size = /bits/ 8 <2>;
 		adi,averaging = /bits/ 8 <1>;
 		adi,conversion-interval = /bits/ 8 <255>;
+		status = "disabled";
 	};
 };
 
@@ -209,6 +210,7 @@ &lcdif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcdif_dat
 		     &pinctrl_lcdif_ctrl>;
+	status = "disabled";
 
 	port {
 		lcdif_out: endpoint {
-- 
2.37.3

