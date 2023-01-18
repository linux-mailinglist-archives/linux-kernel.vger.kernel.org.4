Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5797B6715BB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjARH7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjARHxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:30 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492DA38B49;
        Tue, 17 Jan 2023 23:28:22 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.137]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MStu7-1p7y8h4BYT-00Rrds; Wed, 18 Jan 2023 08:28:07 +0100
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
Subject: [PATCH v4 13/17] arm64: dts: freescale: apalis-imx8: add bkl1_pwm functionality
Date:   Wed, 18 Jan 2023 08:26:51 +0100
Message-Id: <20230118072656.18845-14-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230118072656.18845-1-marcel@ziswiler.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XPfPxjgcJ4c9YMwmnfVzwRE9rjbrVlToLd7OpFT8+yt+S2ZAZ++
 XsWm04PSs/8GWEO1DuLWSJUcNDlnfpcKOlhCfqtLxndRyQuKhr6Y9hBJ6AJ9eFfg08BOtEx
 zSkL9VYv7exGPlsyRGAeZ7lbbw4QFUQZKwwUsiCsy3e3tgUz+RD0MNtzQWRLLWPnydkPzjZ
 YBUbKingi91r6uE0nqAFg==
UI-OutboundReport: notjunk:1;M01:P0:KxClaBHLYUg=;tkUyzOBxosW9CbSOLe4xIU31wks
 M8etEV2BZwqGX5VR8mSBY9l2QzlRm4Pm9qvB9dH46f6uUX64+sWb2mw72cSaNCvkrOCzGfDSJ
 ZQcgmVjrE/NaIG673sqSexkYriviYLNWHFSrJ1x22JaeaNpTGJ5g/NUcl0XueV2fy7qkB8RPx
 tfoZFZw8YkpxYUc9Szkq/PouvkypbubAgD2C2Tc0mZ+8zH7TRMlJvH7nalfLICooutmVKkPDf
 Sz5h8SpEYJ5Ql36///qD2D5jJ8pL5yy6PioFhu301mDMWtp2qOvy9lHe/Uj6zIZFfhZw7y6cQ
 k1/1u2Rzmc0L+l2qRDMo8jtwl1IUE2fp5d2b4vwt4/FGfFmai7EUnB+h7YWL4ikJXBANmIi87
 Va152OEPKa7YdeFpiE9oT5r7XU7xtsIS5rmhaitWUwO3xlgGWk80lzGZlHnsc2OsgUim/AXTv
 j1Q3giAQiuPppNaaP2SfWQTlckXLJ8WQcXGTLmJoGNZGx6Wxp4ZKTwLuk4iG7ATXmrQvSHIHG
 b/b5A6KxQ1DhYHZsBMHNaRs7+mXixO/6xD7aVScprZiy+8Eb6f3y/3BEYs8Ugx/+/VDu2VyZD
 u9phrIsGYvsi52EQDrMioLGa4yrkly7AS4l4DNh7nqHf4pp9QJY56EUszibqNLZ39kpjogAK/
 +3GnLgtsb9wo1o2iFXs9NCNtQjbjhWV/qBk8dtUEQA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add Apalis BKL1_PWM functionality.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

Changes in v4:
- New patch adding Apalis BKL1_PWM functionality.

 arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi      | 7 ++++++-
 .../arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi | 7 ++++++-
 .../arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi | 7 ++++++-
 arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi      | 9 +++++++--
 4 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
index 060454f25c98..003bc5377ce7 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
@@ -106,7 +106,12 @@ &lsio_pwm3 {
 
 /* TODO: Apalis PCIE1 */
 
-/* TODO: Apalis BKL1_PWM */
+/* Apalis BKL1_PWM */
+&pwm_lvds1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm_bkl>;
+	status = "okay";
+};
 
 /* TODO: Apalis DAP1 */
 
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
index caaafc9900a6..97a7db1f875b 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
@@ -182,7 +182,12 @@ &lsio_pwm3 {
 
 /* TODO: Apalis PCIE1 */
 
-/* TODO: Apalis BKL1_PWM */
+/* Apalis BKL1_PWM */
+&pwm_lvds1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm_bkl>;
+	status = "okay";
+};
 
 /* TODO: Apalis DAP1 */
 
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
index 5bc55a58db97..4186c6c9d5ec 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
@@ -227,7 +227,12 @@ &lsio_pwm3 {
 
 /* TODO: Apalis PCIE1 */
 
-/* TODO: Apalis BKL1_PWM */
+/* Apalis BKL1_PWM */
+&pwm_lvds1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm_bkl>;
+	status = "okay";
+};
 
 /* TODO: Apalis DAP1 */
 
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
index 4c88678e2bc7..5508f0daf579 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
@@ -18,7 +18,7 @@ backlight: backlight {
 		enable-gpios = <&lsio_gpio1 4 GPIO_ACTIVE_HIGH>; /* Apalis BKL1_ON */
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_bkl_on>;
-		/* TODO: hook-up to Apalis BKL1_PWM */
+		pwms = <&pwm_lvds1 0 6666667 PWM_POLARITY_INVERTED>;
 		status = "disabled";
 	};
 
@@ -678,7 +678,12 @@ &lsio_pwm3 {
 
 /* TODO: On-module Wi-Fi */
 
-/* TODO: Apalis BKL1_PWM */
+/* Apalis BKL1_PWM */
+&pwm_lvds1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm_bkl>;
+	#pwm-cells = <3>;
+};
 
 /* TODO: Apalis DAP1 */
 
-- 
2.35.1

