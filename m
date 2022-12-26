Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A83656062
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 07:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiLZG3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 01:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiLZG3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 01:29:00 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407572717;
        Sun, 25 Dec 2022 22:28:59 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.224.88]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LuOAL-1okpm2377n-011inR;
 Mon, 26 Dec 2022 07:28:42 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.Li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] arm64: dts: freescale: imx8-ss-lsio: add support for lsio_pwm0-3
Date:   Mon, 26 Dec 2022 07:28:19 +0100
Message-Id: <20221226062824.53113-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221226062824.53113-1-marcel@ziswiler.com>
References: <20221226062824.53113-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:P91+qYFwfHs5E9F5IPNupBa1DowRFZ+tdLaKynRFGJQl0CSwQA5
 HeRgLojoMwvQ0uQ6CosN4D1WpFVPVj33/KK7otjZvZY4UrrcFTcnsRrEfu3J1hVgikHPvK9
 CjRtIKr2pKESQQw6qqRbF/SdKO/slAzszlHlikO+gSr6gFdF/wEYAxjdzAyi7zbHImJvTJ5
 z0yLoWQZAa36gYCGZDWRw==
UI-OutboundReport: notjunk:1;M01:P0:rd0Du2NqQck=;QrGmQwqhBGd9tb4oDE7YS42tE8R
 fOaqyBSm207HQtB1r1Y1VRlEWkXJ3EBiHfaAc2MLv2nkH+CHW+NlUe4KpqRB7GTtYOVD1A8Mt
 v3SFZREX9jqaYHspPZrZftv1doDpoFF2j2LM76JQixrHDNjcmoXmTR8cpNAAg5WCYtJ580SJm
 YxsD6xRcXlguq6ip23w8A/8ppQE6ugO0qkHUErSdBDZV7qmjGv/M5OdD964jKsLoSDut0r5Um
 z5ll9vaaG9yGkjKSTmuYcgQ8F6FZDJe2h8p/ELijI6nV1hEPDfoLKYyNXiCtdObdyv8hye/vo
 HNH77wpM0EAcpzNFnlpIdYIPlHVj93fuvID/KhSS7M9aO6w6SshpRnrN23wFrkwmVf48tzcjt
 Id90KyzuM0WD1c2oiKOfnSVxlehLZH61yFPIXgXGZYA2Q2F+qU5Y7eL/V0tnsvXrnXA3QPpTz
 WNAdCirckp5MFuCgWPzK+63uZRoUxiQW2SWBbrw0vVhmVNRM5/snvCNRyqb8r3V0ouTEMz9Zs
 CGsqXd2kM6mcJDv/nubvpbf19FvFHcl/CMLQr/ifklcADTz5h8GHlsmpYuqQScfr7MqesP7ml
 vAK/7GBCnUyabtrVcsnKpHHV/UhFIwojkoNegsSA7XWBq3IxPPzrdGvbqOuN4zoo6fBuPZwkM
 F79vKZ8Mq1AKXaP5lrg90revlAxKShcjuJeF8b8y4g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Add support for lsio_pwm0-3.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 .../boot/dts/freescale/imx8-ss-lsio.dtsi      | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
index 1f3d225e64ec..62b7f7a3e1bc 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
@@ -28,6 +28,54 @@ lsio_bus_clk: clock-lsio-bus {
 		clock-output-names = "lsio_bus_clk";
 	};
 
+	lsio_pwm0: pwm@5d000000 {
+		compatible = "fsl,imx27-pwm";
+		reg = <0x5d000000 0x10000>;
+		clock-names = "ipg", "per";
+		clocks = <&pwm0_lpcg 4>,
+			 <&pwm0_lpcg 1>;
+		assigned-clocks = <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <2>;
+		status = "disabled";
+	};
+
+	lsio_pwm1: pwm@5d010000 {
+		compatible = "fsl,imx27-pwm";
+		reg = <0x5d010000 0x10000>;
+		clock-names = "ipg", "per";
+		clocks = <&pwm1_lpcg 4>,
+			 <&pwm1_lpcg 1>;
+		assigned-clocks = <&clk IMX_SC_R_PWM_1 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <2>;
+		status = "disabled";
+	};
+
+	lsio_pwm2: pwm@5d020000 {
+		compatible = "fsl,imx27-pwm";
+		reg = <0x5d020000 0x10000>;
+		clock-names = "ipg", "per";
+		clocks = <&pwm2_lpcg 4>,
+			 <&pwm2_lpcg 1>;
+		assigned-clocks = <&clk IMX_SC_R_PWM_2 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <2>;
+		status = "disabled";
+	};
+
+	lsio_pwm3: pwm@5d030000 {
+		compatible = "fsl,imx27-pwm";
+		reg = <0x5d030000 0x10000>;
+		clock-names = "ipg", "per";
+		clocks = <&pwm3_lpcg 4>,
+			 <&pwm3_lpcg 1>;
+		assigned-clocks = <&clk IMX_SC_R_PWM_3 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <2>;
+		status = "disabled";
+	};
+
 	lsio_gpio0: gpio@5d080000 {
 		reg = <0x5d080000 0x10000>;
 		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.35.1

