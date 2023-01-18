Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1CA6715BC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjARH71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjARHxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:30 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A3F35262;
        Tue, 17 Jan 2023 23:27:53 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.137]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MRnRf-1pBGP61vIn-00Sy6a; Wed, 18 Jan 2023 08:27:34 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Liu Ying <victor.liu@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>
Subject: [PATCH v4 05/17] arm64: dts: imx8qm: add pwm_lvds0/1 support
Date:   Wed, 18 Jan 2023 08:26:43 +0100
Message-Id: <20230118072656.18845-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230118072656.18845-1-marcel@ziswiler.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Z2wBgtJmTiYl9K51i06uYAss4G6FkWyJj2br3H/VeO09cIhtJnk
 +hLDIpFPNY7zjZ761w3vsr28zlvel976oktb90h18j1RAifPyiGQpVShbScIJxz/U4RUq/W
 Kc/n/HDRZ/U/CCxi/V3/aq4D83pIyJNY0ogDJnjkn4rhczrPxuo5E75+9PhzEZXvaWxnJlc
 7uF8+GetclDP1lD+yvDXw==
UI-OutboundReport: notjunk:1;M01:P0:QpDf5Lx0bIk=;mqARhiyGE5H/fFjEUTYALlq5IAa
 fyzAHNsxAxFC2lKf8a/i0FmsrlLTen+vlVBNJLsc/g+A9IqWK7mgO03/ZjDkbU+vskbxi3U80
 kr6wLvFw0R/p27Fj4CUYp9SfaTgLIuuGWt7DuNRJ01oAJUVsxEhtzm/Iff2a8UeJgcNKq/TKI
 svTLmlSUP5vUR3CqW/aoDslWmrfiOe8lOzf2cV5cpDu2ZBCU0nSi4VJJfw6EpA6EIFoN+uwbd
 RY7p78mKz7YFSrOUnu+xFIeqkLxqQj1skB754K+tFziqvm9gz9c2qUf8UdduRQCtJoQtK0qP8
 aJ2f1XU4xopE5wBduyszvPVE7Rl+IyZr0pmcn20IYpwPwpU80tiCf5wPCAwEEQ1LCCUqXqjod
 cCGVK99X9i71XA/QO+iHPd1F3F0TZgvB66txZyciyE7lMN/I2VqUZnhmMK5LEUqvdqmLVRdYm
 3RjBVM9HUgVXVgCfH0oh/ozbkfejCHaQgog+BXq1kuTO+00nkkXsuV9Asv+enfbYy6bHklqm6
 PPI4ZqBT1bOyCB8SfKYhE/0/5UX6/pNHkhSnfKRELK85U+bbaeXx+fI7OJd2SvR5vqgp2/1v7
 gHuDrXGz3E+PnIvvyqPQxUIrcK80bNNlLMRSO4wI20CAxdNEN7Tvml7kAn9oJDkvYTqfjvKZV
 woaw8q5j5aNXRdaBSeNVsHPAv+cQVxRFLpFUKDEvsw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Ying <victor.liu@nxp.com>

This patch adds pwm_lvds0/1 support together with a
i.MX 8QM LVDS subsystem device tree.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v4:
- New patch combining the following downstream patches limitted to LVDS
  PWM functionality for now:
  commit 036c6b28a186 ("arm64: imx8qm.dtsi: Add LVDS0/1 subsystems support")
  commit c3d29611d9d4 ("arm64: imx8qm-ss-lvds.dtsi: Add pwm_lvds0/1 support")
  commit baf1b0f22f8a ("LF-882-1 arm64: imx8qm-ss-lvds.dtsi: Separate ipg clock for lvds0/1 subsystems")

 .../boot/dts/freescale/imx8qm-ss-lvds.dtsi    | 83 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi     |  1 +
 2 files changed, 84 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
new file mode 100644
index 000000000000..4b940fc3c890
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023 NXP
+ */
+
+/ {
+	lvds1_subsys: bus@56240000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x56240000 0x0 0x56240000 0x10000>;
+
+		lvds0_ipg_clk: clock-lvds-ipg {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <24000000>;
+			clock-output-names = "lvds0_ipg_clk";
+		};
+
+		lvds0_pwm_lpcg: clock-controller@5624300c {
+			compatible = "fsl,imx8qm-lpcg";
+			reg = <0x5624300c 0x4>;
+			#clock-cells = <1>;
+			clocks = <&clk IMX_SC_R_LVDS_0_PWM_0 IMX_SC_PM_CLK_PER>,
+				 <&lvds0_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+			clock-output-names = "lvds0_pwm_lpcg_clk",
+					     "lvds0_pwm_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_LVDS_0_PWM_0>;
+		};
+
+		pwm_lvds0: pwm@56244000 {
+			compatible = "fsl,imx27-pwm";
+			reg = <0x56244000 0x1000>;
+			clocks = <&lvds0_pwm_lpcg 0>,
+				 <&lvds0_pwm_lpcg 1>;
+			clock-names = "per", "ipg";
+			assigned-clocks = <&clk IMX_SC_R_LVDS_0_PWM_0 IMX_SC_PM_CLK_PER>;
+			assigned-clock-rates = <24000000>;
+			#pwm-cells = <2>;
+			power-domains = <&pd IMX_SC_R_LVDS_0_PWM_0>;
+			status = "disabled";
+		};
+	};
+
+	lvds2_subsys: bus@57240000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x57240000 0x0 0x57240000 0x10000>;
+
+		lvds1_ipg_clk: clock-lvds-ipg {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <24000000>;
+			clock-output-names = "lvds1_ipg_clk";
+		};
+
+		lvds1_pwm_lpcg: clock-controller@5724300c {
+			compatible = "fsl,imx8qm-lpcg";
+			reg = <0x5724300c 0x4>;
+			#clock-cells = <1>;
+			clocks = <&clk IMX_SC_R_LVDS_1_PWM_0 IMX_SC_PM_CLK_PER>,
+				 <&lvds1_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+			clock-output-names = "lvds1_pwm_lpcg_clk",
+					     "lvds1_pwm_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_LVDS_1_PWM_0>;
+		};
+
+		pwm_lvds1: pwm@57244000 {
+			compatible = "fsl,imx27-pwm";
+			reg = <0x57244000 0x1000>;
+			clock-names = "ipg", "per";
+			clocks = <&lvds1_pwm_lpcg 4>,
+				 <&lvds1_pwm_lpcg 1>;
+			assigned-clocks = <&clk IMX_SC_R_LVDS_1_PWM_0 IMX_SC_PM_CLK_PER>;
+			assigned-clock-rates = <24000000>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 41ce8336f29e..422edd2f20fa 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -222,3 +222,4 @@ rtc: rtc {
 #include "imx8qm-ss-dma.dtsi"
 #include "imx8qm-ss-conn.dtsi"
 #include "imx8qm-ss-lsio.dtsi"
+#include "imx8qm-ss-lvds.dtsi"
-- 
2.35.1

