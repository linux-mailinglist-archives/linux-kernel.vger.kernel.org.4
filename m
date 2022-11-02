Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1646163BF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiKBNSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiKBNSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:18:02 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50E52AC56;
        Wed,  2 Nov 2022 06:18:01 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M71P9-1pDfns39uv-00wiDa;
 Wed, 02 Nov 2022 14:12:22 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Peter Chen <peter.chen@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/6] arm64: dts: verdin-imx8mp: add usb_1 over-current detection
Date:   Wed,  2 Nov 2022 14:12:00 +0100
Message-Id: <20221102131203.35648-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221102131203.35648-1-marcel@ziswiler.com>
References: <20221102131203.35648-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VQbP8JLwp2ycgZAlAZ0to6PKhljnPQABl1FTvBfHv1rJtfSopi7
 vPe+rWbhjlwwe1A93h2mL39nKQDtaP8K5RTOdxNqkFPTrRz+u4+soxZr/RZiOK86fVpCzSC
 /3W06Yb3s1TtauANsKRV3ryZCS+bn5q3/fcNH33a+0EH93suLgrYn1MJlQdiEJOFkDAAXBM
 /mW9xtTKe3eOYAkqEw9oQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pGSKfUY51eU=:QJqQ2uMMenQDLUt5ihljxK
 t4kyeYOJxu+bqAL2A6R3ACETH43xCzcI9SXAZEtv8gKaELzPpZyuO0nc0nDdOBzeBJIf2vOv/
 kEXYNK9ajn4eEjO68FOdrc8LEc6bOUiKp4mqWQHpk+oxzIzyVryOIblOJsB4zZTXfaEv4UoDn
 l/ogNVXj7cBTlkb63nfM88zvNkW6racyx65g2lUw+0/PTHkX6jI4lDd/5rfHsNsrG9ukW11mP
 5IS/X3wV8th/3PYp4W+V2hF8qW7ytjggrUkESiqBDUQ5HWd9v6RYxtrYT0ItoNH8iIkuhIEyy
 rT16Pg7nWnMVZANer4sEH3VDEkjlOW0bWWuJABVFHD4zYbkH+NKVguSLXa4UgQ1F6CsNAYDKk
 CrR1zm2RuDeCl3HHyjt4HKJEHi1Vq64+zVPIgo/M0s++Ha3M0aq0eW535kPvO3n5uRN5474t5
 gbkSMDwTs7Wq4hc72tqBnC/LaSrlhHiUVuDrdSVk6ikO1Zgp4jlofc63/NqIObQG1mAs6kaAI
 rydeIuCm7DoGF+caQXUxLsWqRlhVYNjDCyz3CN487vJlDh351Ydbi+vTq0pXj2YkgvEIojQMq
 OBsfP77LHSBZeOOIJeq8Wo5FBcHVRw17sETSJJ0XSiUKYY2BvLbCK/8cMTTI19SIshX8PkhDr
 mbinh5U4Nqy9YKvuFpQ5YXqJGhkiekoJwuLKgmhELzoT52NOnj33OMYSbC/EaZTXVY8lc4Dvb
 pcHWSVukfWLa8Q9o7kuXB9/WntzSPWvxWFgF44yosYyVvKzFwOKn38vpPD3q3X+j09sHrjTEi
 iD4rNIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add Verdin USB_1 over-current detection functionality via Verdin
USB_1_OC# (SODIMM 157) being active-low and removing its previous
gpio_hog3 mapping.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index 57cddf1bf6b3..85af2875fb70 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -807,6 +807,12 @@ &uart4 {
 };
 
 /* Verdin USB_1 */
+&usb3_0 {
+	fsl,over-current-active-low;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_1_oc_n>;
+};
+
 &usb3_phy0 {
 	vbus-supply = <&reg_usb1_vbus>;
 };
@@ -816,7 +822,6 @@ &usb_dwc3_0 {
 	dr_mode = "otg";
 	hnp-disable;
 	maximum-speed = "high-speed";
-	over-current-active-low;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb_1_id>;
 	srp-disable;
@@ -1045,7 +1050,6 @@ pinctrl_gpio_hog2: gpiohog2grp {
 
 	pinctrl_gpio_hog3: gpiohog3grp {
 		fsl,pins =
-			<MX8MP_IOMUXC_GPIO1_IO13__GPIO1_IO13		0x1c4>,	/* SODIMM 157 */
 			/* CSI_1_MCLK */
 			<MX8MP_IOMUXC_GPIO1_IO15__GPIO1_IO15		0x1c4>;	/* SODIMM 91 */
 	};
@@ -1229,6 +1233,12 @@ pinctrl_usb_1_id: usb1idgrp {
 			<MX8MP_IOMUXC_SD1_RESET_B__GPIO2_IO10		0x1c4>;	/* SODIMM 161 */
 	};
 
+	/* USB_1_OC# */
+	pinctrl_usb_1_oc_n: usb1ocngrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_GPIO1_IO13__USB1_OTG_OC		0x1c4>;	/* SODIMM 157 */
+	};
+
 	pinctrl_usb2_vbus: usb2vbusgrp {
 		fsl,pins =
 			<MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14		0x106>;	/* SODIMM 185 */
-- 
2.36.1

