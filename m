Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275895ED63E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbiI1HgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiI1HfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:35:25 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C3E100ABA;
        Wed, 28 Sep 2022 00:35:13 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LaEeW-1p6PwX2lfK-00m0Cw;
 Wed, 28 Sep 2022 09:33:52 +0200
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
Subject: [PATCH v2 2/5] arm: dts: colibri-imx6: move vbus-supply to module level device tree
Date:   Wed, 28 Sep 2022 09:33:33 +0200
Message-Id: <20220928073336.63881-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220928073336.63881-1-marcel@ziswiler.com>
References: <20220928073336.63881-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YYgeO2Gqz7zvBi5GyqCHTn+NZy5Nxr3/7DF7fy2w/Whp5pOrkvT
 0tCY1fXuOzGg1y3+0ISslaS1rrIOAYgYoi5r4JzIdDePOi065NBp3iNEy9Kj6lDtLBSvGOT
 9wftjF6CMqbjmA+5jt+ExMaHVCJlsKHdgJwx8v852XTzHRMVosTiClnrGev3pr3ZaZq0tzz
 EGjCBOkyXXPPtbkDvCrHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lRVIgiyO3qk=:0RTQrr0nD4xN7XdWc1hD6F
 BLawpUKcTM9+WpuqG/TjEIIttMSbNltopGn9i67Vh9TtxZG9iiL9MR/d7LGmPHVPYrGmZEqoz
 bsewwe1sGNAJGIjfskSpTZtr06HEhgDAmhWbolt9jINqciMQy8JfCGwEClW71lWsGAqOSBlDj
 NZ+HW04I3n/W5Wg7yPrVWRlGRgZiTWsfl/n8qc1vNKhCbyXZeGMxLYzfYOSzfX8FUM9PIMvuy
 F7P1NW70f8z6TXetyaVRnGbegiYAp1BYxg3zZkoUVBy6Ph32W32hkajal3geZoy0zRLe0n1/x
 sG5DXlejCafpYf3YEAkjCWAAxoUHh5Eihxi04T33/6JCHOB08KcaEW/995Gaz75KjyBQmmlm5
 j/nyvClMXeGL38tkxAWwiSv4C7t9GBsRxtB94yxovTyPA+rNXcVDH5lF/fVqdowU7cLbw/PCY
 zEruL+9HWG2imaNlBZF9NZu0ain13AUXTw2pSSm1o5xJncOR3JH6gM9BZ7I7rmY9V9+zTAQPw
 5/Bbzu0AMzGLbFLNYg2/sQZioeXTtwmLKQbdCRZmGQs3FjSCumZoyepBPVVBW+3RUU3iVMTEh
 LeoKTpSQdbSVyVtHiEnqPNRz+TxTcHBT3hkEzrUNDBGIm/JX3H1HAVDpA+EZTkP5kW3Bn1vu/
 Kb74OlOfy8qLCThXNbs/SPNpjJmpYJfCRpCvwJ2ifJne9Mad/Zityi4dkaW55xBLKld7dwsDV
 /7phmgjWyMZE1ndJTV8cwv2wIZdFhKv/Xu2HiK0izG0Zg+/OvCud0CGJ9qfRs4IF1xmvUmY4i
 IwuS0hk
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

(no changes since v1)

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

