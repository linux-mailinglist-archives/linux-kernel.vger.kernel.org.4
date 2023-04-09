Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146BF6DBF57
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 11:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjDIJSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 05:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDIJSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 05:18:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887764EC9;
        Sun,  9 Apr 2023 02:18:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21E8360DF8;
        Sun,  9 Apr 2023 09:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D133C433EF;
        Sun,  9 Apr 2023 09:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681031928;
        bh=c2I0yJTyQr3Uyst/ro4wytwPfIU+WGszhyD9VTJ7OqU=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=iQ678+S5SD4L2NIJKyc6o7UoG6nKCLzPMuC57jnBRsYv/BddCSFczRmsPavRk7Pxk
         tbgp9cxLBM1czMMRRk4ReElYd3rKH8pVyuJBP5RlPR9SQewtORy7DcFwtVXkYhgJIe
         //dQULHyFtYoL6X+ER4JcGz//BZ6t7Sx/SjNf0pxsTSyvhGWl35/kWqBSuIHmrl5qE
         KKfdxeapb9GUOIpvmTlXZoGM9yA+UdDgSZuL9KwZ9PwbRK2AWdgkJAJid025BF9h18
         gqYo8Fz8SF6ul23EakKCq5U7nkdCnBj7fLKeox5aF0+fWnZ8vMyrDpEkPeV9xPrMK+
         JeyfUUwkafSwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9C6C77B70;
        Sun,  9 Apr 2023 09:18:48 +0000 (UTC)
From:   Sasha Finkelstein via B4 Relay 
        <devnull+fnkl.kernel.gmail.com@kernel.org>
Date:   Sun, 09 Apr 2023 11:18:46 +0200
Subject: [PATCH] arm64: dts: apple: t8112: Add PWM controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230409-t8112-fpwm-v1-1-feffa5f8b99b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPaCMmQC/x2NywrCMBAAf6Xs2cW8lOqvFA/bZGv2YFqyRYXSf
 zf1OAzDbKBchRXu3QaV36Iylwb21EHMVJ6MkhqDM86bYG649tY6nJbPC82Vgw8x+kufoAUjKeN
 YqcR8JKSUBXWO57Qeeqk8yff/Gh77/gOATlWmewAAAA==
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681031927; l=3074;
 i=fnkl.kernel@gmail.com; s=20230213; h=from:subject:message-id;
 bh=oZH+o0OuBKtAeL1N+AILko2fVUAecOJUeYZVbst1W5o=;
 b=C18AutLzDFanW7c9JjMjZfk0eZAnVX7s7KUp5iGQQ+Xga9D+G1Fwk2ky0g2IDzDC1+b6xsTgs
 6muF/T8FkQ9AAYwfsTeW9Q/xO9EOCGv3VJO3ck8bLAS5cJohh33NURk
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=7LFSAJtxIWAs9LzCIyX0sSvCZy2wQTyEIu1zch6o804=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20230213 with auth_id=28
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: <fnkl.kernel@gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

This patch adds the device tree entries for the PWM controller
present on M2 macbooks that is connected to the keyboard backlight.

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 arch/arm64/boot/dts/apple/t8112-j413.dts | 17 +++++++++++++++++
 arch/arm64/boot/dts/apple/t8112-j493.dts | 17 +++++++++++++++++
 arch/arm64/boot/dts/apple/t8112.dtsi     |  9 +++++++++
 3 files changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8112-j413.dts b/arch/arm64/boot/dts/apple/t8112-j413.dts
index 9e758edeaa82..6f69658623bf 100644
--- a/arch/arm64/boot/dts/apple/t8112-j413.dts
+++ b/arch/arm64/boot/dts/apple/t8112-j413.dts
@@ -11,6 +11,7 @@
 
 #include "t8112.dtsi"
 #include "t8112-jxxx.dtsi"
+#include <dt-bindings/leds/common.h>
 
 / {
 	compatible = "apple,j413", "apple,t8112", "apple,arm-platform";
@@ -20,6 +21,18 @@ aliases {
 		bluetooth0 = &bluetooth0;
 		wifi0 = &wifi0;
 	};
+
+	led-controller {
+		compatible = "pwm-leds";
+		led-0 {
+			pwms = <&fpwm1 0 40000>;
+			label = "kbd_backlight";
+			function = LED_FUNCTION_KBD_BACKLIGHT;
+			color = <LED_COLOR_ID_WHITE>;
+			max-brightness = <255>;
+			default-state = "keep";
+		};
+	};
 };
 
 /*
@@ -61,3 +74,7 @@ hpm5: usb-pd@3a {
 &i2c4 {
 	status = "okay";
 };
+
+&fpwm1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8112-j493.dts b/arch/arm64/boot/dts/apple/t8112-j493.dts
index 8552c15be265..0ad908349f55 100644
--- a/arch/arm64/boot/dts/apple/t8112-j493.dts
+++ b/arch/arm64/boot/dts/apple/t8112-j493.dts
@@ -11,6 +11,7 @@
 
 #include "t8112.dtsi"
 #include "t8112-jxxx.dtsi"
+#include <dt-bindings/leds/common.h>
 
 / {
 	compatible = "apple,j493", "apple,t8112", "apple,arm-platform";
@@ -20,6 +21,18 @@ aliases {
 		bluetooth0 = &bluetooth0;
 		wifi0 = &wifi0;
 	};
+
+	led-controller {
+		compatible = "pwm-leds";
+		led-0 {
+			pwms = <&fpwm1 0 40000>;
+			label = "kbd_backlight";
+			function = LED_FUNCTION_KBD_BACKLIGHT;
+			color = <LED_COLOR_ID_WHITE>;
+			max-brightness = <255>;
+			default-state = "keep";
+		};
+	};
 };
 
 /*
@@ -50,3 +63,7 @@ bluetooth0: bluetooth@0,1 {
 &i2c4 {
 	status = "okay";
 };
+
+&fpwm1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8112.dtsi b/arch/arm64/boot/dts/apple/t8112.dtsi
index 698a436e7dac..1666e6ab250b 100644
--- a/arch/arm64/boot/dts/apple/t8112.dtsi
+++ b/arch/arm64/boot/dts/apple/t8112.dtsi
@@ -458,6 +458,15 @@ i2c4: i2c@235020000 {
 			status = "disabled";
 		};
 
+		fpwm1: pwm@235044000 {
+			compatible = "apple,t8112-fpwm", "apple,s5l-fpwm";
+			reg = <0x2 0x35044000 0x0 0x4000>;
+			power-domains = <&ps_fpwm1>;
+			clocks = <&clkref>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
 		serial0: serial@235200000 {
 			compatible = "apple,s5l-uart";
 			reg = <0x2 0x35200000 0x0 0x1000>;

---
base-commit: 8d59efc33fdaa2c82072b4d3ba5f67d7dd9270d0
change-id: 20230409-t8112-fpwm-06e434cc358d

Best regards,
-- 
Sasha Finkelstein <fnkl.kernel@gmail.com>

