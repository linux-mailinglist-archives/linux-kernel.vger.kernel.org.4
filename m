Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1E35F55B5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiJENk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJENkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:40:06 -0400
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [IPv6:2001:1600:3:17::1909])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7AFEE2E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 06:39:49 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MjFzt6glYzMqPd3;
        Wed,  5 Oct 2022 15:39:38 +0200 (CEST)
Received: from philippe-pc.toradex.int (unknown [31.10.206.125])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MjFzt4Qq1zMpnPl;
        Wed,  5 Oct 2022 15:39:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1664977178;
        bh=6zUwdKLzRxtYDq/hGVP9cXox20ACTudefkYhW9W1meg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AYc1UvyxewTxvuOVJlG9k0PdAnnv6BDZEcFf7vE+p9UjMRObCAtuP4J6T0K4zSkXJ
         YJkhLoIB0fwZ3nhiQWUqEA5f2VAa0pwX6pGQT2IYRKA8GWiwV2ncUzKlA10FPFwY3X
         VnTOEZRJMkg9Qf4/brM1cOPknfPdyAY9LhoMnlas=
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
Subject: [PATCH 3/4] arm: dts: colibri-imx6ull: add -hog to gpio hogs
Date:   Wed,  5 Oct 2022 15:39:28 +0200
Message-Id: <20221005133929.1243443-3-dev@pschenker.ch>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005133929.1243443-1-dev@pschenker.ch>
References: <20221005133929.1243443-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Since it seems to be a naming-convention to add -hog for gpio hogs do
this.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts      | 8 ++++----
 arch/arm/boot/dts/imx6ull-colibri-iris.dtsi        | 4 ++--
 arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dts | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts b/arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts
index fac7428685b4..f6b31118be17 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts
+++ b/arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts
@@ -29,7 +29,7 @@ &backlight {
 
 &gpio1 {
 	/* This turns the LVDS transceiver on */
-	lvds-power-on {
+	lvds-power-on-hog {
 		gpio-hog;
 		gpios = <14 GPIO_ACTIVE_HIGH>; /* SODIMM 99 */
 		line-name = "LVDS_POWER_ON";
@@ -42,7 +42,7 @@ &gpio2 {
 	 * This switches the LVDS transceiver to the single-channel
 	 * output mode.
 	 */
-	lvds-ch-mode {
+	lvds-ch-mode-hog {
 		gpio-hog;
 		gpios = <0 GPIO_ACTIVE_HIGH>; /* SODIMM 55 */
 		line-name = "LVDS_CH_MODE";
@@ -52,7 +52,7 @@ lvds-ch-mode {
 	/*
 	 * This switches the LVDS transceiver to the 24-bit RGB mode.
 	 */
-	lvds-rgb-mode {
+	lvds-rgb-mode-hog {
 		gpio-hog;
 		gpios = <1 GPIO_ACTIVE_HIGH>; /* SODIMM 63 */
 		line-name = "LVDS_RGB_MODE";
@@ -64,7 +64,7 @@ &gpio5 {
 	/*
 	 * This switches the LVDS transceiver to VESA color mapping mode.
 	 */
-	lvds-color-map {
+	lvds-color-map-hog {
 		gpio-hog;
 		gpios = <3 GPIO_ACTIVE_HIGH>; /* SODIMM 95 */
 		line-name = "LVDS_COLOR_MAP";
diff --git a/arch/arm/boot/dts/imx6ull-colibri-iris.dtsi b/arch/arm/boot/dts/imx6ull-colibri-iris.dtsi
index 7f3b37baba88..166a0aefc869 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-iris.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-iris.dtsi
@@ -59,7 +59,7 @@ &gpio1 {
 	 * in userspace.
 	 * The same applies to uart1_tx_on.
 	 */
-	uart25_tx_on {
+	uart25_tx_on-hog {
 		gpio-hog;
 		gpios = <15 0>;
 		output-high;
@@ -67,7 +67,7 @@ uart25_tx_on {
 };
 
 &gpio2 {
-	uart1_tx_on {
+	uart1_tx_on-hog {
 		gpio-hog;
 		gpios = <7 0>;
 		output-high;
diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dts b/arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dts
index ed89d07beae5..488da6df56fa 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dts
+++ b/arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dts
@@ -29,7 +29,7 @@ &backlight {
 
 &gpio1 {
 	/* This turns the LVDS transceiver on */
-	lvds-power-on {
+	lvds-power-on-hog {
 		gpio-hog;
 		gpios = <14 GPIO_ACTIVE_HIGH>; /* SODIMM 99 */
 		line-name = "LVDS_POWER_ON";
@@ -42,7 +42,7 @@ &gpio2 {
 	 * This switches the LVDS transceiver to the single-channel
 	 * output mode.
 	 */
-	lvds-ch-mode {
+	lvds-ch-mode-hog {
 		gpio-hog;
 		gpios = <0 GPIO_ACTIVE_HIGH>; /* SODIMM 55 */
 		line-name = "LVDS_CH_MODE";
@@ -52,7 +52,7 @@ lvds-ch-mode {
 	/*
 	 * This switches the LVDS transceiver to the 24-bit RGB mode.
 	 */
-	lvds-rgb-mode {
+	lvds-rgb-mode-hog {
 		gpio-hog;
 		gpios = <1 GPIO_ACTIVE_HIGH>; /* SODIMM 63 */
 		line-name = "LVDS_RGB_MODE";
@@ -64,7 +64,7 @@ &gpio5 {
 	/*
 	 * This switches the LVDS transceiver to VESA color mapping mode.
 	 */
-	lvds-color-map {
+	lvds-color-map-hog {
 		gpio-hog;
 		gpios = <3 GPIO_ACTIVE_HIGH>; /* SODIMM 95 */
 		line-name = "LVDS_COLOR_MAP";
-- 
2.37.3

