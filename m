Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636DE6659BF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjAKLIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjAKLGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:06:42 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1558FB492;
        Wed, 11 Jan 2023 03:06:30 -0800 (PST)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1M1ZMF-1pD5A234bT-0037hc;
 Wed, 11 Jan 2023 12:06:10 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.Li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v3 1/6] arm64: dts: freescale: imx8-ss-lsio: add support for lsio_pwm0-3
Date:   Wed, 11 Jan 2023 12:05:52 +0100
Message-Id: <20230111110558.349460-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230111110558.349460-1-marcel@ziswiler.com>
References: <20230111110558.349460-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:p3y0IoD/kv/u5zrRkogZsSYst8Pdn184AoDmgoH++h4hZTSnX5T
 gJfSzsPqJfRn9MY+IdqnURYoKGQwNknP9gTs/eTEWrf8ijByH6vOCj1+FN8+ijZS/sGUniI
 stIoMYPbCS60gxMVy2mZyGo9PBntGISbtsWwaABZJ1hh+Szuf6WkfubAs98RtPA+NxFCL82
 5lmkmL3fj0SKzPugojoZw==
UI-OutboundReport: notjunk:1;M01:P0:x26iAMs7bZY=;dzzJqx92cMzoUM/FvD62tI9sAv+
 tpzK0nLMLvt/xdTT33mo2RlqcsF/I6+qY4BwYm1Hu+U4lVfU6E+/AaJsYqkjwaD/+WNTQC6hf
 89e7JnJ2eL55BsyVdxIlsQvKrTyX/wU9I9JK0YNc+Ed6phtkLsgTBOyWv3cTF7UFc+nsOumbU
 pwyFfm0J545vTQq/wts0RKyFh+Fo3x7OFpnUz/Ie785iZiwbKOjP8C9TQCDQPYOv6XTonCi4a
 cgTWKayYd/OYS6nCaUcT2fdXaovVOzcNeKWjN5erfGYdoI3HM+pnfc0mxDJod/uXYjG3/uHoc
 mq4PfXuqegmm80ej+/ZOAexZMLqHrvd5HGlG/JGJnKMgd1hfLWAOz1C4jzNjPietVC6OVkYOG
 9bJlyvOKbCvrDOrgEMuG/FG7dmNAqIcUbzbmyswNYXuTX1mwfzzhMdkT73kZ0Kr83rpPtkBOb
 XrJ67vwKPQg3NNFxe0yhcSKmiOZWurHcteVSYUIAXy118EbvEh28EOObqbb84E7IGFFKWSehO
 mAUTT7/MQpc1BaSnw+RfUjXN5z2nyOptinyUHfaFpvNZVodajXW0WE7ZQtQill8Ru4FYyNWAC
 xH99wETviuHLcK5UktHdTz7US+bDTW8xqQZmc71y5/I8Op2IYvmDZfQWQfYXZRlSD7JRhjw8J
 KLXrCXSyD+roJmtDueY3fRD+sL9GXaij8zHyQbJPAg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

(no changes since v1)

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

