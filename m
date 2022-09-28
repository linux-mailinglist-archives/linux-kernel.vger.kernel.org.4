Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167215ED636
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbiI1Hfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbiI1HfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:35:24 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11A0FF3CB;
        Wed, 28 Sep 2022 00:35:12 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MAxNa-1oViLh1lMS-009vZI;
 Wed, 28 Sep 2022 09:33:49 +0200
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
Subject: [PATCH v2 1/5] arm: dts: colibri-imx6: usb dual-role switching
Date:   Wed, 28 Sep 2022 09:33:32 +0200
Message-Id: <20220928073336.63881-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220928073336.63881-1-marcel@ziswiler.com>
References: <20220928073336.63881-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0eBsTL8vCLAjiORrC4CrRjsmc2I5ZFyYc3tHkLu6E+3c+T/KU9b
 Lz4X6yeKX75xdZ6kWVlPMaoJQYzB90f9A9IO6LtnwJVYjEYQDlOw4eHFahhYDmOtkq+WQt7
 lWpuNiekrwK6SIrcB1Q6uAACamd4yAdzqOgAVIBq3z7q13HXX69KYYrUewItkLHmjU1Wyd1
 No4BesXnNbKqzlnDO/j9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pYH1lRUSjWU=:fBFYNpd+9Ym0bOgxX99hjB
 Lsk5CH0S9Sl/WGT2e/OkQYSMMUPJtXw4jT3p9wLCzhs3e2DMuTWaoNR9+wpVwVBSVAGfS+5Ej
 RCLWnaR3NV1i7dLFaKPgu4YlwCgdFIzCoXwf/SOtBE/PhQuYTwCzVIXXidlvtFaxh7o+w9vfZ
 gL7S8IPJdPcR49V4w+oRtNNmYeoLw9FfhYJH3AE0H5M/8aQw8u0tBJ63vlCFkYqtIfW+U7s+Q
 Hk8TFJwQTccJ3Hur1h0XbU9qSdwlxcbIYbg94rHtHIw4vjTfJuTc6RqjiZQ75Zi9V0i3KbGXg
 sGHb4vFu4OuJra5syymy+WOC1heZdpMYrc6H6qBmVh/Bq/HMNNChGkZ2p9QEZKg1uHriKGZ3W
 9HL8a2CLuzSu3ySDzHA0jU62Qp/y1/uPwIEmB8NC0bT+1K3NxuWYW97WsriOTJt8JPOeo26ld
 mc0myOm6z5nuM3462rHZmeRD3LKucfsA8xD2AR4dBDJhpQ/FDFvwCWCOayRTQ2IqLMSm041cl
 X15A8l8UJKWT9cBl9+x4wRy5N40Buv2Kodvpz/SlG8xjj9HsfgT5IDg+PmYDIIJdlGSYzMSvb
 GWvxtdJoOFEsJT/Rtz0RHbwE2lNI/8SluJ0Cp6keHNwuBB2KyzYMs7L8WytRcY4njLQbpjTBf
 tLWDIcwxbQ+9bKr8rStWy5Y/rPRF6Loujl3vZMwFOSv7heN2mDjjQ1gq77RnEDzjqGMRdSind
 RJ6lG+LLIfeqGthnOuPwwtUaWfXUHphHtdJQTQWFUXM+SnnZrenkRW/zDFGIw0LngMyrxF8ml
 2XHG9eQ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

(no changes since v1)

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

