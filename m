Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB946715AB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjARH50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjARHxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:31 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C093938B4C;
        Tue, 17 Jan 2023 23:28:24 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.137]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MbODK-1ozPYM1cNY-00Ip5J; Wed, 18 Jan 2023 08:28:11 +0100
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
Subject: [PATCH v4 14/17] arm64: dts: freescale: apalis-imx8: add flexcan functionality
Date:   Wed, 18 Jan 2023 08:26:52 +0100
Message-Id: <20230118072656.18845-15-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230118072656.18845-1-marcel@ziswiler.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OhorGmlO61nFJqXepEKWLE5RlSaaZhhBH8ez/s2yDzPBvP4oZXt
 ZsEBMDuOPdcCTEc+5zo8+R89pU+oJd2WBGg/rCXzV4i5cR5bUafrgo90b2SLPsiKxIR9qXR
 d8X+qMFKEGqwKwQjsdPvMUydoYjnXi3Oqy/7hLOhqza/HsOZiQvCDCNWSLvYgF7PC2nmMca
 f0T3qC07hRdPFjD+v/bLQ==
UI-OutboundReport: notjunk:1;M01:P0:sfv1mYb4Y0k=;EOqfLmYSmsbZRph7Kvkj8pSqb9n
 /bCIuXc0jyytvYt1aUcn1b9JXKDCWEnUNy0XZ+oLYbakgSwPAxc1pOlFbuen/ErfIrgrsZN8Z
 227sV5Z4Eat3oh7Gm+4rnZR8I6UL8I00RikVgtD9YTVzYKvIf9DChpNLPcxlhHHrbhHgvDaIt
 bU3B7JSTZ1yj9/kvB28Z7QbWzkoQ5IeKwf91YVUN96PGLbzaSKNCFCII55jGb2sdLEQ2JuQRi
 1FCyn1IM4Hi2+hlPfpWYfW9u1O6IXPjDif7uAdQXEFhbI3KYq3rlEUsty+ZW9wJUah8VcrF85
 qOcaA/bO+HCNxQR0T/SRNVGjRNTr6Mi6eP8bvNNM3ESZWBD5tJSPq7GqfjGDIZSlfwcGGBCMn
 FSdKD8uDrlMt7eseWr/12BrClhrX3AwfRZqN5+YKg3/clcF1+/4gd4dWlvd3KkW4vatA8HYOz
 4ux1V3coclYoCtGygEGYg8WxVRrictLKlq/CFAXPSqwScnSNflSkmBGGiQB6MJp1zOTb56umD
 qnkOwaVFNXumrdxExIbrw1cTuXXZsi2kwW7nuY95CYWdAPASoyc8yQhI0YzpqrfVn8Surygs4
 sjqnCgzyCPu1XW5UzOyF1b2fgdB06gc5MUDJgNmI6pErp1wDjCiBoWTwtJ1Fy0NqNKBBE/SzM
 XAAtCXC5/9CfXh796fITRiCalLM8rANvn8y+RhhuRR8LFShDup7V8LGrwZ1V/3w=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add Apalis CAN1, CAN2 and optional CAN3 functionality.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

Changes in v4:
- New patch adding flexcan functionality.

 .../boot/dts/freescale/imx8-apalis-eval.dtsi   | 10 +++++++++-
 .../dts/freescale/imx8-apalis-ixora-v1.1.dtsi  | 10 +++++++++-
 .../dts/freescale/imx8-apalis-ixora-v1.2.dtsi  | 12 +++++++++++-
 .../boot/dts/freescale/imx8-apalis-v1.1.dtsi   | 18 +++++++++++++++---
 4 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
index 003bc5377ce7..3212877773e3 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
@@ -35,7 +35,15 @@ &fec1 {
 	status = "okay";
 };
 
-/* TODO: CAN */
+/* Apalis CAN1 */
+&flexcan1 {
+	status = "okay";
+};
+
+/* Apalis CAN2 */
+&flexcan2 {
+	status = "okay";
+};
 
 /* TODO: GPU */
 
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
index 97a7db1f875b..6e248d05992f 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
@@ -75,7 +75,15 @@ &fec1 {
 	status = "okay";
 };
 
-/* TODO: CAN */
+/* Apalis CAN1 */
+&flexcan1 {
+	status = "okay";
+};
+
+/* Apalis CAN2 */
+&flexcan2 {
+	status = "okay";
+};
 
 /* TODO: GPU */
 
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
index 4186c6c9d5ec..d221f3aee241 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
@@ -105,7 +105,17 @@ &fec1 {
 	status = "okay";
 };
 
-/* TODO: CAN */
+/* Apalis CAN1 */
+&flexcan1 {
+	xceiver-supply = <&reg_can1_supply>;
+	status = "okay";
+};
+
+/* Apalis CAN2 */
+&flexcan2 {
+	xceiver-supply = <&reg_can2_supply>;
+	status = "okay";
+};
 
 /* TODO: GPU */
 
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
index 5508f0daf579..545618799852 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
@@ -268,11 +268,23 @@ ethphy0: ethernet-phy@7 {
 	};
 };
 
-/* TODO: Apalis CAN1 (driver upstream but device tree part missing) */
+/* Apalis CAN1 */
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+};
 
-/* TODO: Apalis CAN2 (driver upstream but device tree part missing) */
+/* Apalis CAN2 */
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+};
 
-/* TODO: Apalis CAN3 (optional, driver upstream but device tree part missing) */
+/* Apalis CAN3 (optional) */
+&flexcan3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan3>;
+};
 
 /* TODO: Apalis HDMI1 */
 
-- 
2.35.1

