Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10F75BE1CD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiITJXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiITJW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:22:56 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802F9647F5;
        Tue, 20 Sep 2022 02:22:55 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MHIph-1oWUrX2G8J-00E4PL;
 Tue, 20 Sep 2022 11:22:37 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] arm: dts: colibri-imx6: usb dual-role switching
Date:   Tue, 20 Sep 2022 11:22:24 +0200
Message-Id: <20220920092227.286306-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220920092227.286306-1-marcel@ziswiler.com>
References: <20220920092227.286306-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Kp2c5nuRc74u27ldKLPobTX69ut281IMllkiUvRyo72q3S7TWr5
 P6obXMjNL0k/4uNysYTxwSuZsH31pxl5bjYnDjgMs4Y+Dmkuqg6v01K10jNnajJhNRwQ3+w
 qccH4VWjw6EskbvzmnG3G9XQ8mYky0QgKnt5hfGlL3LefjrAAjM/c6u9CZ+NrPemd0S9tuC
 6ch7iTGPgSYtzU9Y0OnOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AMJJ+i6j+xo=:IP4HEipEfbuKdsDL9/EgHL
 31UpGEurkhyqdLSaEShfzqWCRCTwrKddYhrn+dnfLTnKxoTyZ33bKLchnMXDwDBNeHcMjaBTh
 RSBOPg1czTHUJPzAOfFdpkWLckvVZatZAZiEeRR/9e4NI7z5D6SQJowRq03YGOAIbKLqXGfo1
 kWlSbWh/cMdwtJZ3ssbZSRp4D1t80obtw2rKq0xIc3Zm3D6fTs4zQzfptxOYe+VBv3JoubS0x
 d9S9AMqv1hXZg1WaXqZKq5aaNVjp4J0YirHmxrYntTn/knTbGPogSNS0ycU3TtsUB1cmrRhVB
 Fawi0qQLVOSDGac4JMMGcejB6yhEnkCjNL15Gq+7QjBNwM3P/9mnVqMWNQOXvOfUoGZ+4g/nE
 NEmQ5xUtsVLHBSjSvofFCV7+Bsn5TdDwa84ldBDTZeB6ZjR24uAcyeRG2DvDfrxeSFHcExdZ1
 2VtjBMV/HzF2LiOzC1H4bICepK2PPcCHENE9a4ge5vcGSBjGt/WChFEWKw6awk7BzoY6ocrNW
 HRpZ7e5oxCY9UXNqur2fgyKArpmtFVhkEfBb68THGWRJ8LgJOZ66wUpqiONYjRZjknG4lWK/P
 TwdUF/C12juqDZUIcf9hZ7yNqxsY9lROr41CCC69nfkA6uD+X6HLQv5gmxs9to9IfJfY9zsy6
 /1Hskqd3dZZ2ALLvl+xVchWhx3xcC2sl94IlSvYXgePmhQi7uEar9aUaA1OAA91CaVBJRIFer
 s/a/l23HHvjhwqJubyorZx/kcGzrlIgK77Wdb0x0rhePfivQxPu0Qx/vtsKAeE/4gNYkrHFzv
 e75MUjl
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Introduce USBC_DET GPIO based USB dual-role aka device/host switching.

While at it re-work pinmux comment adding SODIMM number to the USBC_DET
entry.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 023e76215064..3e98b5da0cc6 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -24,6 +24,13 @@ backlight: backlight {
 		status = "disabled";
 	};
 
+	extcon_usbc_det: usbc-det {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>; /* SODIMM 137 / USBC_DET */
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbc_det>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -670,9 +677,11 @@ &uart3 {
 	status = "disabled";
 };
 
+/* Colibri USBC */
 &usbotg {
 	disable-over-current;
-	dr_mode = "peripheral";
+	dr_mode = "otg";
+	extcon = <0>, <&extcon_usbc_det>;
 	status = "disabled";
 };
 
@@ -1055,7 +1064,7 @@ MX6QDL_PAD_SD4_CMD__UART3_RX_DATA	0x1b0b1
 
 	pinctrl_usbc_det: usbcdetgrp {
 		fsl,pins = <
-			/* USBC_DET */
+			/* SODIMM 137 / USBC_DET */
 			MX6QDL_PAD_GPIO_17__GPIO7_IO12		0x1b0b0
 			/* USBC_DET_OVERWRITE */
 			MX6QDL_PAD_RGMII_RXC__GPIO6_IO30	0x0f058
-- 
2.36.1

