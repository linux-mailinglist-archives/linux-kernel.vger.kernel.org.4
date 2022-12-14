Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E5664C3BD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 07:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbiLNGT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 01:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiLNGTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 01:19:53 -0500
X-Greylist: delayed 319 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Dec 2022 22:19:52 PST
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73823167ED;
        Tue, 13 Dec 2022 22:19:52 -0800 (PST)
Received: from toolbox.int.toradex.com ([106.185.144.150]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0Lij1v-1oUtgB2izd-00d05e; Wed, 14 Dec 2022 07:14:07 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: verdin-imx8mp: add pcie support
Date:   Wed, 14 Dec 2022 07:13:54 +0100
Message-Id: <20221214061354.174072-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EXCyTQnANcnHc8rJV9g/dT94JKpnbGsF8DjKVs4wrRHVYuBxaTH
 VB6tSKl9MXJYQJSxQRNFBjVCuw9CYsXquRLH8ho4LUJ3Rc5BNat80Xs9uyaNLMIImIpLLCA
 oXMxXyEzIobYD36Szw//5GAo8KImH/7gBSw/LY3ta9esI1jfb9cJfvRD+iRmorF8sZT4fSv
 xSyFCM1qWjid1Pvp4ewHA==
UI-OutboundReport: notjunk:1;M01:P0:V0WoA2c6Flc=;1zRVYEZLAmTJT0ax99Feg9lQusQ
 oxWNIRZUCiRvb8sEbU0Q+BkkQjzzN2saZzUG4HlJ+E69gMseEttMr8cuBUybkHpFN2oCuBb79
 +HolxGbAaOJr1RVnjpNbBAnikb5J19DE7KsGi3mYPolkInYOP+Q+tT7iTgZN5y6c1OvIBxCL6
 MtSsfL960aWBVJ7hb/fIDj4ruG6wZWKF8X5L/tQDjJeyRKQcBmkolW2xG1+DMl2Vd+nCMpn8l
 ERd71JOrqSfjLdGXHOdn8ABL3pgvkTNfLbkTZUzGaxF+ZhXmgGgLimnI6IwQfq33OBMSqa5Tr
 oC0aj70aB9WOPsLs6sjUNUUUTwdwGOodIzEwv+D8TK59nN1Mf08Yz9CUDQVLXhQi285C0YjvQ
 0iiSaH5HgV1q544v4mtL1VpXc0czoLJPrH2rEOJWzJSsVMszGJCGL4P5lbJR4PcwOgQ5cbt+Y
 GjAUC4x0XOdhgs5yYEevkRx15vGFjttqLI1Ai/PzRQmD4hpqNvgRMG/ehYFGIMUJxyCCH/MFu
 ti3iEMgXtUgQBFI+3UvihfGzTq4JKMSBr/W0BALxAy3iCQXpkW1CRw2kFot6L278k1vGEAs6J
 9m4th1tfTQOx+iyw6p5TZ3c6EaqhEB+e7YCF1l8seSQH11h9iwWOLNrAEzjzWdnkYRdtO+34v
 15olD8oMNwCaIRpHlWvt9xNXYQLX11UOlTlipjrgCg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add PCIe support on the Verdin iMX8M Plus.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---
This has successfully been tested with Lucas' imx8mp-hsio-blk-ctrl high
performance PLL clock exposure patch set [1] a later version thereof
hopefully may land together with my humble patch. Thanks!

[1] https://lore.kernel.org/all/20221213160112.1900410-1-l.stach@pengutronix.de/

 .../dts/freescale/imx8mp-verdin-dahlia.dtsi   |  9 +++++++-
 .../boot/dts/freescale/imx8mp-verdin.dtsi     | 22 ++++++++++++++++++-
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
index 80db1ad7c230..56b0e4b865c9 100644
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
index 6a1890a4b5d8..f3a46f4caf49 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -749,7 +749,27 @@ eeprom_carrier_board: eeprom@57 {
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
+	clocks = <&hsio_blk_ctrl>;
+	clock-names = "ref";
+	fsl,clkreq-unsupported;
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_OUTPUT>;
+};
 
 /* Verdin PWM_1 */
 &pwm1 {
-- 
2.36.1

