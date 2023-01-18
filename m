Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91A16715B3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjARH6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjARHxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:32 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1F039CC4;
        Tue, 17 Jan 2023 23:28:32 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.137]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0M2bYp-1oPncX1ond-00sQx2; Wed, 18 Jan 2023 08:28:21 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v4 17/17] arm64: dts: freescale: apalis-imx8: enable vpu
Date:   Wed, 18 Jan 2023 08:26:55 +0100
Message-Id: <20230118072656.18845-18-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230118072656.18845-1-marcel@ziswiler.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5rAhW80Ovxy9KtsBhzm1WJlP0qfWqOKjQ/UtfptOMvek2i8I+I9
 S4rZFXHOgtAkJOomr0+F2N8tnu/A9G63As5kRrtcH7knXT8GZPqYzwIZ2KLpo9fKMI/0XTz
 ssRJj5KUPCr11ojphitOyZg8zlatnWt6gxdtdx6Qo4Ij6ZKLp0cbmpLj8XLDKgs4n7BtoYg
 WGykQxxGpioaJWSt6rVaA==
UI-OutboundReport: notjunk:1;M01:P0:KPqVSrklASc=;clesvU5X50K2jTXzZMTQUgrVhHw
 kIeRlXZJJNd4//AHkhA5okE7v8dTZJQyb+ZSn+E3vsmlcL/mgov5n8wa6aqcNHBmcBdALrXZi
 wPTzSZaD/iwCQvjJOphDttI9hkc4zq9pQykZtxbPmyHl5cUGQJhx5OtSMR1D9denNmmMA9VV2
 6jQD7k3Z5ESQO8vzC4StxDoheKF7WpS8c4VnL9dtsSVZjd2NdO3LeUuw/QlM53FbTp1fg0GRV
 GV1zSzwXJB4TAi+1UfxHj4i5JFIciwOq7xHTVXvYweTnhKAie8o7P1zlWUNk0poQ0S18LlwZf
 1Jfo/jibA06xFlyszi0BoTXUP+qqbkDQWrrytzMWazKN5rRhdIO1sI3vQDo/RMW6kuA8DfBWL
 GxsUeXTjhxWakdrBbXXi0NIKOIToRfbZQyXMWOxS5kQrsDfxCiiPPlvHAmn1ySADIETE0XBwR
 cjR+AJYO+KLKcZGtYoUnHC3/RU8VMxmzSosrIdWO+gkcwKyyEVs6isQsAvLFyl7njksVuDCzl
 s0cHn5nQwBypIQXy5tYTW41yq4ylwo+Rh5+nK6fel6/0UOY0AdfFnnABGhtaWDRZ0KcJMKryp
 TDQks+qmC7bG4NyW94XdNi2/JHWFyl96iXUIeczOgXS+79ifjytQpXzuMyQNaQENcy7qE0vvA
 AhWvXgQ8N5Ta2JXIaxllwpOzeUXGJB/dOzg36JFQnQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Enable Video Processing Unit (VPU) decoder and encoder functionality.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v4:
- New patch enabling VPU functionality.

 .../boot/dts/freescale/imx8-apalis-v1.1.dtsi  | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
index 6217e0a48f96..37c5fa20f0a4 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
@@ -781,7 +781,29 @@ &usdhc3 {
 	pinctrl-2 = <&pinctrl_usdhc3_200mhz>, <&pinctrl_sd1_cd>;
 };
 
-/* TODO: Video Processing Unit (driver upstream but device tree part missing) */
+/* Video Processing Unit */
+&vpu {
+	compatible = "nxp,imx8qm-vpu";
+	status = "okay";
+};
+
+&vpu_core0 {
+	memory-region = <&decoder_boot>, <&decoder_rpc>;
+	reg = <0x2d080000 0x10000>;
+	status = "okay";
+};
+
+&vpu_core1 {
+	memory-region = <&encoder1_boot>, <&encoder1_rpc>;
+	reg = <0x2d090000 0x10000>;
+	status = "okay";
+};
+
+&vpu_core2 {
+	memory-region = <&encoder2_boot>, <&encoder2_rpc>;
+	reg = <0x2d0a0000 0x10000>;
+	status = "okay";
+};
 
 &iomuxc {
 	pinctrl-names = "default";
-- 
2.35.1

