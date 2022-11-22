Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72BD6340C1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiKVQCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbiKVQCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:02:11 -0500
X-Greylist: delayed 438 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Nov 2022 08:02:07 PST
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AB87212A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:02:07 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NGpjg0CWWzMpvPh;
        Tue, 22 Nov 2022 16:54:47 +0100 (CET)
Received: from philippe-pc.toradex.int (unknown [31.10.206.125])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4NGpjf3s9vzMpqZ7;
        Tue, 22 Nov 2022 16:54:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1669132486;
        bh=g1sWAsx/ups0L9XURgH3gof3ttJAXGBAdslzRhtWUKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mQkoIYy5AhDCgQdD+aZCSrIJqpHRzhKSo/8WzvYWVOklGbFG/WyjFYQyzBPZnUaBJ
         dwv/kpVvYF7XWQvt3z4u85hf26ilAvdLgrGlbiatLQAIm7tgnnEqioHp6rzg6LHkFN
         8c3URCJnljnIefmujP4MBpiCWCNkZb7izXJza44A=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] ARM: dts: colibri-imx7: Disable usb over-current
Date:   Tue, 22 Nov 2022 16:54:37 +0100
Message-Id: <20221122155439.456142-5-dev@pschenker.ch>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122155439.456142-1-dev@pschenker.ch>
References: <20221122155439.456142-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Disable usb over-current of the chipidea driver on all Carrier-Boards
used by Toradex. Do this as we don't want to use this functionality on
our Carrier Boards and to leave it open to someone who includes our
module-level device-trees.

This will prevent the warning "No over current polarity defined" from
being printed on boot.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm/boot/dts/imx7-colibri-aster.dtsi        | 1 +
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi      | 1 +
 arch/arm/boot/dts/imx7-colibri-iris-v2.dtsi      | 1 +
 arch/arm/boot/dts/imx7-colibri-iris.dtsi         | 1 +
 arch/arm/boot/dts/imx7d-colibri-aster.dts        | 1 +
 arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts   | 1 +
 arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts | 1 +
 arch/arm/boot/dts/imx7d-colibri-emmc-iris-v2.dts | 1 +
 arch/arm/boot/dts/imx7d-colibri-emmc-iris.dts    | 1 +
 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi        | 1 +
 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts      | 1 +
 arch/arm/boot/dts/imx7d-colibri-iris-v2.dts      | 1 +
 arch/arm/boot/dts/imx7d-colibri-iris.dts         | 1 +
 13 files changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx7-colibri-aster.dtsi b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
index fa488a6de0d4..01612741f792 100644
--- a/arch/arm/boot/dts/imx7-colibri-aster.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
@@ -70,6 +70,7 @@ &uart3 {
 
 /* Colibri USBC */
 &usbotg1 {
+	disable-over-current;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index 826f13da5b81..326440f2b4f4 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -101,6 +101,7 @@ &uart3 {
 
 /* Colibri USBC */
 &usbotg1 {
+	disable-over-current;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx7-colibri-iris-v2.dtsi b/arch/arm/boot/dts/imx7-colibri-iris-v2.dtsi
index 6e199613583c..b687727f956a 100644
--- a/arch/arm/boot/dts/imx7-colibri-iris-v2.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-iris-v2.dtsi
@@ -99,6 +99,7 @@ &uart3 {
 
 /* Colibri USBC */
 &usbotg1 {
+	disable-over-current;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx7-colibri-iris.dtsi b/arch/arm/boot/dts/imx7-colibri-iris.dtsi
index 175c5d478d2e..6a9e5ab59691 100644
--- a/arch/arm/boot/dts/imx7-colibri-iris.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-iris.dtsi
@@ -99,6 +99,7 @@ &uart3 {
 
 /* Colibri USBC */
 &usbotg1 {
+	disable-over-current;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx7d-colibri-aster.dts b/arch/arm/boot/dts/imx7d-colibri-aster.dts
index 90aaeddfb4f6..00ab92e56da4 100644
--- a/arch/arm/boot/dts/imx7d-colibri-aster.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-aster.dts
@@ -36,5 +36,6 @@ &panel_dpi {
 
 /* Colibri USBH */
 &usbotg2 {
+	disable-over-current;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts b/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
index 3ec9ef6baaa4..d9c7045a55ba 100644
--- a/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
@@ -18,5 +18,6 @@ / {
 
 /* Colibri USBH */
 &usbotg2 {
+	disable-over-current;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts b/arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts
index 6d505cb02aad..96b599439dde 100644
--- a/arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts
@@ -17,5 +17,6 @@ / {
 
 /* Colibri USBH */
 &usbotg2 {
+	disable-over-current;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc-iris-v2.dts b/arch/arm/boot/dts/imx7d-colibri-emmc-iris-v2.dts
index 7347659557f3..5eccb837b158 100644
--- a/arch/arm/boot/dts/imx7d-colibri-emmc-iris-v2.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc-iris-v2.dts
@@ -17,5 +17,6 @@ / {
 
 /* Colibri USBH */
 &usbotg2 {
+	disable-over-current;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc-iris.dts b/arch/arm/boot/dts/imx7d-colibri-emmc-iris.dts
index 5324c92e368d..ae10e8a66ff1 100644
--- a/arch/arm/boot/dts/imx7d-colibri-emmc-iris.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc-iris.dts
@@ -17,5 +17,6 @@ / {
 
 /* Colibri USBH */
 &usbotg2 {
+	disable-over-current;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
index 2fb4d2133a1b..3740e34ef99f 100644
--- a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
@@ -51,6 +51,7 @@ &gpio6 {
 
 /* Colibri USBH */
 &usbotg2 {
+	disable-over-current;
 	dr_mode = "host";
 	vbus-supply = <&reg_usbh_vbus>;
 };
diff --git a/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts b/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
index c7a8b5aa2408..33d787617db0 100644
--- a/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
@@ -52,5 +52,6 @@ &pwm3 {
 
 /* Colibri USBH */
 &usbotg2 {
+	disable-over-current;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7d-colibri-iris-v2.dts b/arch/arm/boot/dts/imx7d-colibri-iris-v2.dts
index 5762f51d5f0f..afdb1d06c7f6 100644
--- a/arch/arm/boot/dts/imx7d-colibri-iris-v2.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-iris-v2.dts
@@ -79,5 +79,6 @@ &panel_dpi {
 
 /* Colibri USBH */
 &usbotg2 {
+	disable-over-current;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7d-colibri-iris.dts b/arch/arm/boot/dts/imx7d-colibri-iris.dts
index 9c63cb9d9a64..531b0b99bd5a 100644
--- a/arch/arm/boot/dts/imx7d-colibri-iris.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-iris.dts
@@ -52,5 +52,6 @@ &pwm3 {
 
 /* Colibri USBH */
 &usbotg2 {
+	disable-over-current;
 	status = "okay";
 };
-- 
2.38.1

