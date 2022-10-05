Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6555F55B3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJENkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiJENjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:39:48 -0400
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5738B868
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 06:39:42 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MjFzt3wTSzMqPdH;
        Wed,  5 Oct 2022 15:39:38 +0200 (CEST)
Received: from philippe-pc.toradex.int (unknown [31.10.206.125])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MjFzt1F4XzMpnPl;
        Wed,  5 Oct 2022 15:39:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1664977178;
        bh=/+EZl3/OTx8ks2x/VRpo8nCPykbG6pAZD3++K1o1qeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LVG3ES9crLXq1hnocKzZ9r9W31xqEbV48XoVBR5HjxH+QJZgjh9zyuQyG4TyYCjnm
         NsegaUtBIL8JEzRPMPyprCLG2p29i9F6XeJbKKpTOgpJxOCtMYlomUYyfDX+GGAU1i
         L5BlqD6GqHV07sgh1DqssmFzcBeWqPAwToQLOEgw=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm: dts: colibri-imx6ull: enable default peripherals
Date:   Wed,  5 Oct 2022 15:39:27 +0200
Message-Id: <20221005133929.1243443-2-dev@pschenker.ch>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005133929.1243443-1-dev@pschenker.ch>
References: <20221005133929.1243443-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

For NAND modules Toradex does not provide any device-tree overlays. But
we always had a default display output enabled on NAND modules as well
as touchscreens that are placed on displays which can easily be plugged
into those carrier boards. Do reenable these displays and touchscreen
output on all device-trees that are used on NAND modules.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm/boot/dts/imx6ull-colibri-aster.dts   | 40 +++++++++++++++++++
 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dts | 24 +++++++++++
 arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts | 40 +++++++++++++++++++
 arch/arm/boot/dts/imx6ull-colibri-iris.dts    | 22 +++++++++-
 .../boot/dts/imx6ull-colibri-wifi-aster.dts   | 40 +++++++++++++++++++
 .../boot/dts/imx6ull-colibri-wifi-eval-v3.dts | 24 +++++++++++
 .../boot/dts/imx6ull-colibri-wifi-iris-v2.dts | 24 +++++++++++
 .../boot/dts/imx6ull-colibri-wifi-iris.dts    | 20 ++++++++++
 8 files changed, 233 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ull-colibri-aster.dts b/arch/arm/boot/dts/imx6ull-colibri-aster.dts
index d3f2fb7c6c1e..3e0897c3a296 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-aster.dts
+++ b/arch/arm/boot/dts/imx6ull-colibri-aster.dts
@@ -15,6 +15,46 @@ / {
 		     "fsl,imx6ull";
 };
 
+&ad7879_ts {
+	status = "okay";
+};
+
 &atmel_mxt_ts {
 	status = "okay";
 };
+
+&backlight {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&panel_dpi {
+	status = "okay";
+};
+
+&pwm4 {
+	status = "okay";
+};
+
+/* PWM <B> */
+&pwm5 {
+	/* Pin already used by atmel_mxt_ts touchscreen */
+	status = "disabled";
+};
+
+/* PWM <C> */
+&pwm6 {
+	/* Pin already used by atmel_mxt_ts touchscreen */
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dts
index 9bf7111d7b00..d6da984e518d 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dts
@@ -12,3 +12,27 @@ / {
 	model = "Toradex Colibri iMX6ULL 256/512MB on Colibri Evaluation Board V3";
 	compatible = "toradex,colibri-imx6ull-eval", "fsl,imx6ull";
 };
+
+&ad7879_ts {
+	status = "okay";
+};
+
+&backlight {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&panel_dpi {
+	status = "okay";
+};
+
+&pwm4 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts b/arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts
index afc1e0119783..fac7428685b4 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts
+++ b/arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts
@@ -15,10 +15,18 @@ / {
 		     "fsl,imx6ull";
 };
 
+&ad7879_ts {
+	status = "okay";
+};
+
 &atmel_mxt_ts {
 	status = "okay";
 };
 
+&backlight {
+	status = "okay";
+};
+
 &gpio1 {
 	/* This turns the LVDS transceiver on */
 	lvds-power-on {
@@ -63,3 +71,35 @@ lvds-color-map {
 		output-low;
 	};
 };
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&panel_dpi {
+	status = "okay";
+};
+
+&pwm4 {
+	status = "okay";
+};
+
+/* PWM <B> */
+&pwm5 {
+	/* Pin already used by atmel_mxt_ts touchscreen */
+	status = "disabled";
+};
+
+/* PWM <C> */
+&pwm6 {
+	/* Pin already used by atmel_mxt_ts touchscreen */
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/imx6ull-colibri-iris.dts b/arch/arm/boot/dts/imx6ull-colibri-iris.dts
index 4fb97b0fe30b..2a0d0fc3b9d6 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-iris.dts
+++ b/arch/arm/boot/dts/imx6ull-colibri-iris.dts
@@ -15,6 +15,26 @@ / {
 		     "fsl,imx6ull";
 };
 
-&atmel_mxt_ts {
+&ad7879_ts {
+	status = "okay";
+};
+
+&backlight {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&panel_dpi {
+	status = "okay";
+};
+
+&pwm4 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi-aster.dts b/arch/arm/boot/dts/imx6ull-colibri-wifi-aster.dts
index b4f65e8c5857..c7da5b41966f 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-wifi-aster.dts
+++ b/arch/arm/boot/dts/imx6ull-colibri-wifi-aster.dts
@@ -15,6 +15,46 @@ / {
 		     "fsl,imx6ull";
 };
 
+&ad7879_ts {
+	status = "okay";
+};
+
 &atmel_mxt_ts {
 	status = "okay";
 };
+
+&backlight {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&panel_dpi {
+	status = "okay";
+};
+
+&pwm4 {
+	status = "okay";
+};
+
+/* PWM <B> */
+&pwm5 {
+	/* Pin already used by atmel_mxt_ts touchscreen */
+	status = "disabled";
+};
+
+/* PWM <C> */
+&pwm6 {
+	/* Pin already used by atmel_mxt_ts touchscreen */
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dts b/arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dts
index 1d64d1a5d8a7..917f5dbe64ba 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dts
@@ -12,3 +12,27 @@ / {
 	model = "Toradex Colibri iMX6ULL 512MB on Colibri Evaluation Board V3";
 	compatible = "toradex,colibri-imx6ull-wifi-eval", "fsl,imx6ull";
 };
+
+&ad7879_ts {
+	status = "okay";
+};
+
+&backlight {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&panel_dpi {
+	status = "okay";
+};
+
+&pwm4 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dts b/arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dts
index ce02f8a9ddd3..ed89d07beae5 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dts
+++ b/arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dts
@@ -15,10 +15,18 @@ / {
 		     "fsl,imx6ull";
 };
 
+&ad7879_ts {
+	status = "okay";
+};
+
 &atmel_mxt_ts {
 	status = "okay";
 };
 
+&backlight {
+	status = "okay";
+};
+
 &gpio1 {
 	/* This turns the LVDS transceiver on */
 	lvds-power-on {
@@ -63,3 +71,19 @@ lvds-color-map {
 		output-low;
 	};
 };
+
+&i2c2 {
+	status = "okay";
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&panel_dpi {
+	status = "okay";
+};
+
+&pwm4 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi-iris.dts b/arch/arm/boot/dts/imx6ull-colibri-wifi-iris.dts
index 5ac1aa298ce7..e63253254754 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-wifi-iris.dts
+++ b/arch/arm/boot/dts/imx6ull-colibri-wifi-iris.dts
@@ -15,6 +15,26 @@ / {
 		     "fsl,imx6ull";
 };
 
+&ad7879_ts {
+	status = "okay";
+};
+
 &atmel_mxt_ts {
 	status = "okay";
 };
+
+&backlight {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&panel_dpi {
+	status = "okay";
+};
-- 
2.37.3

