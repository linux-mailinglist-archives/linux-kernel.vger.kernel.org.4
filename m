Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152005BE1D5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiITJXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiITJW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:22:59 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5595765242;
        Tue, 20 Sep 2022 02:22:57 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MSthj-1okIME0uZB-00RuIn;
 Tue, 20 Sep 2022 11:22:39 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] arm: dts: colibri-imx6: move vbus-supply to module level device tree
Date:   Tue, 20 Sep 2022 11:22:25 +0200
Message-Id: <20220920092227.286306-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220920092227.286306-1-marcel@ziswiler.com>
References: <20220920092227.286306-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zeuJwMcicAMOPDXAbzXSFKRHTfDTyXF+Y05WFx96dshyrE7To6M
 DrHTh7cMKROC+Oe2m6hS4Vk3145SLqB4XAsiUkLZEJJGJXgImbYdxdwtoAmRhXSJCmDLSvy
 DZiX/ndI1fHtd9knbhsIkFiOWFC4RTFvDOS0cIo4UGgovZWz9aLZtaFViL0OVvBL92jkXo4
 IlAMFWigXdcN3cLF8jjqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HJzWSuUH/A4=:KiEnYYqaCwIlDn/2khyzUV
 hAfnIFYUdnFz4I2LdHQorpI2+Gb4YGy6s/qYsW34A6BL8srH8sy+7y2LbR7v+iD/530pTr9j2
 /cMlaulcBuSdwM2u5ciiWWvNbknSPKYS+OTfSw4fc0nwoAK54OokWnQ+AsNygnxR7NTgW9jJ3
 iTOJxtGdNHv8q8f+4A8YVRBCmDWyfUZRRd/nNgtHsBd+zZJJGoxfOJC7KQUZygI623xoFRk+d
 CD2UV28k2Wo5InrOe8OOWs6IthFRMPO6MqY/xi7UuZm43SU/wIPFVP6YwJzJ1hisx2MqcLCMa
 9/87dbYvnN+7LHUh027f4/EpMqsdySYY6jJbg5UUr/L21r/wCVwXs83VV0WDWv1/jBTsxXbuR
 bgCXYBnfG/OI53pS7qjHxro32L9eNsCqIU5J1RPVt7x1238JsGT1tzssirH33UGGGk3luRuEm
 typ7afNisiZq8i3bRLcCH+D4Vg+GDPgG43t1wdnuCCRM6PQ9en+Alyw0gn3+GZZhi5QLemyqZ
 z3HThMFc9QSnqgUN9ETrsSRHMD1toZhFZtaY4QrIuM8ZJzlIY7J6Kp+RtDN7gLdDRFxkZt2nu
 0TWESBfpXBHbRrizIb7arsOE3JVR9mpTeJLD8SpBnuT4DOI7KNlceDznbDFKmtLDk0zH/L/vL
 uXfH456D/ju6doVpksyqzsn5p6dTyb8njmln5CFhGqDKky1Y0CAISkhReYzkSoQphwDbXoK+F
 K9utSVKMfDc63OpJwfuetL8mC5AgQGikfjj8AbtRjd3GWj7TEHviiq2w2j+M/zHZGQwIhQabe
 hUEjX55
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Move USB VBUS supply from single carrier board to module level device
tree. This pin is as per Colibri module family standard.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx6dl-colibri-aster.dts   | 1 -
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts | 1 -
 arch/arm/boot/dts/imx6dl-colibri-iris.dts    | 1 -
 arch/arm/boot/dts/imx6qdl-colibri.dtsi       | 9 +++++++--
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-colibri-aster.dts b/arch/arm/boot/dts/imx6dl-colibri-aster.dts
index 74e8a6cd8bed..a28e083f29d5 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-aster.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-aster.dts
@@ -99,7 +99,6 @@ &uart3 {
 };
 
 &usbh1 {
-	vbus-supply = <&reg_usb_host_vbus>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
index 7272edd85a49..a02981d4a3fc 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -111,7 +111,6 @@ &uart3 {
 };
 
 &usbh1 {
-	vbus-supply = <&reg_usb_host_vbus>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6dl-colibri-iris.dts b/arch/arm/boot/dts/imx6dl-colibri-iris.dts
index cf77d894f6d7..c5797ff35b71 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-iris.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-iris.dts
@@ -138,7 +138,6 @@ &uart3 {
 };
 
 &usbh1 {
-	vbus-supply = <&reg_usb_host_vbus>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 3e98b5da0cc6..21c5049bda4e 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -112,7 +112,7 @@ reg_module_3v3_audio: regulator-module-3v3-audio {
 
 	reg_usb_host_vbus: regulator-usb-host-vbus {
 		compatible = "regulator-fixed";
-		gpio = <&gpio3 31 GPIO_ACTIVE_HIGH>; /* USBH_PEN */
+		gpio = <&gpio3 31 GPIO_ACTIVE_HIGH>; /* SODIMM 129 / USBH_PEN */
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_regulator_usbh_pwr>;
 		regulator-max-microvolt = <5000000>;
@@ -677,6 +677,11 @@ &uart3 {
 	status = "disabled";
 };
 
+/* Colibri USBH */
+&usbh1 {
+	vbus-supply = <&reg_usb_host_vbus>;
+};
+
 /* Colibri USBC */
 &usbotg {
 	disable-over-current;
@@ -995,7 +1000,7 @@ MX6QDL_PAD_SD4_DAT2__PWM4_OUT	0x1b0b1
 
 	pinctrl_regulator_usbh_pwr: gpioregusbhpwrgrp {
 		fsl,pins = <
-			/* USBH_EN */
+			/* SODIMM 129 / USBH_PEN */
 			MX6QDL_PAD_EIM_D31__GPIO3_IO31	0x0f058
 		>;
 	};
-- 
2.36.1

