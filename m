Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB9B68E8AB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjBHHDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjBHHCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:02:31 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA648458BB;
        Tue,  7 Feb 2023 23:00:45 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.227.109]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1Mad3m-1osEcb4AEU-00c94t; Wed, 08 Feb 2023 07:59:56 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: verdin-imx8mp: add pcie support
Date:   Wed,  8 Feb 2023 07:59:46 +0100
Message-Id: <20230208065947.24195-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HJigRWDL2OS5MAv6RAlF+oEowXGoLwgkfFXYavZTyph8su2JqwK
 a7QJNjn/eObSGCwKxShLC9KHPg0Q7LNnVZHkMKsNigpwo7rAp+iRSoaZL4RHCo7t6Vh3qlE
 /zu6fO+9ooPcskXgUvKSYHZctuhrpkAmappCLoA9ro4ae74CFTxfKT53DYu+unDUKey6RhR
 5X4Yn2Scaczv5Utnb923Q==
UI-OutboundReport: notjunk:1;M01:P0:6CCdWPGsTms=;mPw0iu8rapF/2UmIKZoUd8qsOTJ
 IGLiGOjsPPioVWhzEDfav0E0NPttYelGYbbJRMmBHOqFfdNsT9brP5kx6ZDaxhcQ26tQpqlKF
 rkujUFicO1dyons6DOPkCPEWD69b84JNezzEUg/PZglALDjjH2N9UN4X7Iu/GMRAWCHba8tix
 2CsYaTfgjIUIt2kD/dvbav/sEHsEZQMplGjlIrOP01Kahj4JNgMvabu3NR7AqOCr1/TcIv+JH
 b6riLFr/s4HytIQRnIUv9xJGEsECXpozGynKCLpAt7yKv3PrlSVgV0UF4pQLS2ZqxpBzNiyb2
 VQeZslPmCdHUNltT7IjKDNt+H3VGH5ILt2zBx9e82NUqBHNp/9ctPE4jMDajiiVDHD1ANlfVA
 /3izNX4oHlNWBjgAqV/18cwD31/5Ht0UcFN6szfNcL5+MRnZkkHdJ7+35nMouCtYsRy/5oAzM
 9E9uhCAaf5WePxc/dlwEIKVoGu/89y9zDhN3hVTwbbi7bfKcJ6BLg5k4+PgGNpt9S4rzePdqd
 ija6rZjPkD0fiGCg3/BIlmM4aTQyHhvsx1urDkOl185l78lrKgnwcvE7Z3XuUxmgVJVnxqAsb
 D7aPJBsIdyKH06vUoYfxg0saVBF3xLm+Xemi+B+YjW+p8/tpqN2JFOJXoTB69KkXJXOCbqTjL
 pZ5r49FX6y9ZwULDBonaAyadXf05/Db2asXwVTMu5brvySRX2siwFiyrM2eO/9U=
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
This has successfully been tested with Lucas' imx8mp-hsio-blk-ctrl high
performance PLL clock exposure patch set which meanwhile has landet in
-next. Thanks!

Changes in v2:
- Removed clocks which thanks to Lucas are now in the SoC dtsi.
- Follow recent change to not include dahlia dtsi requiring PCIe nodes
  in dev board dts as well.

 .../boot/dts/freescale/imx8mp-verdin-dahlia.dtsi  |  9 ++++++++-
 .../boot/dts/freescale/imx8mp-verdin-dev.dtsi     |  9 ++++++++-
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi  | 15 ++++++++++++++-
 3 files changed, 30 insertions(+), 3 deletions(-)

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
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
index 361426c0da0a..096a6f2300f9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
@@ -91,7 +91,14 @@ &i2c4 {
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
index 6a1890a4b5d8..f0e5838665b2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -749,7 +749,20 @@ eeprom_carrier_board: eeprom@57 {
 	};
 };
 
-/* TODO: Verdin PCIE_1 */
+/* Verdin PCIE_1 */
+&pcie {
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

