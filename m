Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF5B5E6871
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiIVQad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiIVQaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:30:15 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0024C634;
        Thu, 22 Sep 2022 09:30:10 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MOAS5-1ovYPA28kb-00OWZr;
 Thu, 22 Sep 2022 18:29:54 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
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
Subject: [PATCH v1 6/8] arm64: dts: verdin-imx8mp: add pcie support
Date:   Thu, 22 Sep 2022 18:29:23 +0200
Message-Id: <20220922162925.2368577-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220922162925.2368577-1-marcel@ziswiler.com>
References: <20220922162925.2368577-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oAz+yO7r1efwhQ3Qw7tjDAGQ4zx6X1UU5BSQx2fhlNXBN7gDTVb
 KesvjOs3pVp3e51SLTaTVkn5zbmHTuRv20RT8exkcxfzQ+N/3txL+isWfLMBTQc50v/C4F+
 bufLVQAsqj9veA2VJ4T09YxOx7xDmtTJgEx+vANt/cJ2tUjHJYi4hVa4/6M2ehBry6ieNs9
 KrOihc2/90SOS8gvvzgkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tJcySQrtmOE=:/4YHs9F/6kK2ODFpF3nvEw
 AfBeTRET+AjMRVDsh5dkM0eQcG1jFIf3d3R00OjiyL4GR0pNC8lOjMl5A0sY7R4FhekQa4BmD
 nWxyFIxo/hoEgjfw8w4xCDItyHwO2kfFgCH1hCbXMNqMCMPRDAOZIKrGcMOLRm0BZgiNg1+Tt
 JTcLutxflsIe/XmOTKhFrgutZC2O5L+Ui0o0BCgd5EvdCdJKk1EVSTuO/AawMPmR/OefiSjWV
 qmmue3WAXVweUQzDAROQsI4Ar2URH9IgqsYnWh7foTOM5GFljW4GBldKhcgt0eLPP4Vlzl/sa
 ca/LZRa8m1j9Xn+HXgex6GMaTaq9KgWI9ZZQb/tLoHikszjuROvWmd4nJZ+X+en1FM5ERl3vx
 /3n56UnR+JFPMbcxdUD9a9K+DcU19oM44F/vuPlGScVrOWi5ujlkXpohBQqOsnQFMuwnl1UMt
 fB5KCE97TUyc+JWGRk8e4Y9nzK5zcYMmSZyWzoIwP0gQn2eQsq8amUsdJGi3sGxl1Gj+WKqwN
 beZluhJJWPwglZUYtSJVhracZerjOPIkXOWOsI/q0jM73cfI6MVcs/K20wHRw8uMhhfJ+pxk3
 FiRpzb2itWGRw60og/qEWzxb4icu5GOwjxTCp6KwxZYygdx7uuLdKVtDvAHQAywWWYNuRBWKg
 Om8Xo2JDkC6oqn23KcKyhbISyFpCZda7dZqMBf20EWccGY1l5So/PHgNtsrfADp7r4kvgnd6V
 mwsuwzy+n1WDgad/W84QDH4OUtNWhyOHw46trdtZMDkAtbR3m9aeavKLzbzTzJfQt/rT8Pp1J
 Wlkg/Bm
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add PCIe support on the Verdin iMX8M Plus.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---
This still relies on the PHY part landing [1] and the internal SYSPLL
mode getting sorted [2].

[1] https://lore.kernel.org/all/1663659498-5180-1-git-send-email-hongxing.zhu@nxp.com/
[2] https://lore.kernel.org/all/AS8PR04MB867657D03C61774096A5A1628C4C9@AS8PR04MB8676.eurprd04.prod.outlook.com/

 .../dts/freescale/imx8mp-verdin-dahlia.dtsi   |  9 +++++++-
 .../boot/dts/freescale/imx8mp-verdin.dtsi     | 22 ++++++++++++++++++-
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
index 4b8f86f63081..60f9dc4847db 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
@@ -67,7 +67,14 @@ &i2c4 {
 	/* TODO: Audio Codec */
 };
 
-/* TODO: Verdin PCIE_1 */
+/* Verdin PCIE_1 */
+&pcie {
+	status = "okay";
+};
+
+&pcie_phy {
+	status = "okay";
+};
 
 /* Verdin PWM_1 */
 &pwm1 {
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index 7be7e922927b..160bb32cb5f7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -734,7 +734,27 @@ eeprom_carrier_board: eeprom@57 {
 	};
 };
 
-/* TODO: Verdin PCIE_1 */
+/* Verdin PCIE_1 */
+&pcie {
+	assigned-clocks = <&clk IMX8MP_CLK_PCIE_AUX>;
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_50M>;
+	assigned-clock-rates = <10000000>;
+	clocks = <&clk IMX8MP_CLK_HSIO_ROOT>,
+		 <&clk IMX8MP_CLK_PCIE_ROOT>,
+		 <&clk IMX8MP_CLK_HSIO_AXI>;
+	clock-names = "pcie", "pcie_aux", "pcie_bus";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	/* PCIE_1_RESET# (SODIMM 244) */
+	reset-gpio = <&gpio4 19 GPIO_ACTIVE_LOW>;
+};
+
+&pcie_phy {
+	clocks = <&clk IMX8MP_CLK_HSIO_ROOT>;
+	clock-names = "ref";
+	fsl,clkreq-unsupported;
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_OUTPUT>;
+};
 
 /* Verdin PWM_1 */
 &pwm1 {
-- 
2.36.1

