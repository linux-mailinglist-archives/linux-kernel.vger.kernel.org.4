Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC5E626081
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbiKKRee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbiKKReZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:34:25 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A877763CE8;
        Fri, 11 Nov 2022 09:34:21 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id y14so14081641ejd.9;
        Fri, 11 Nov 2022 09:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5GqgUQltU/UwWJVmKB9yBrhZ1yrd9RICIJ3rDIHDxU=;
        b=BYViKet/CZKXvHTS3HlQWmBj09BBq1AYiW0SCIXjYp8h4OM4k+MGKh/8MMSBZKGobi
         ZXQFXI+vEkXyeVYhJYgacvuetIi1/+nNsmH7Pr019WNsaNzUlnbns60k6b65h+HgB/BT
         QQJaqNyyXa8YvuSMbADbmW8l7wHDmWpjZQOsPcDSCLc8tP5ZlQlvEGy4olnXNYODMIIc
         iL1kPwBhZB9h4i2sJpBLLlZOB+HvoQl5n9srWG8F7v1R75MWG9bRhAcv/Qoq33beLAq0
         mYi2qoNYXnZrvdu1hH6A2msUDybDAA5EtrBpi1mlxypKok/JZzTbZ/Qdoj0/f22V7d0A
         urZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5GqgUQltU/UwWJVmKB9yBrhZ1yrd9RICIJ3rDIHDxU=;
        b=pml8jX0W8E1LjMCE1s9XXZ7DVoHqkJ/XU3Zc1aG4Xy3gZBsBtht5UzyCccbxGOV6LX
         R3gCoEinh4t6BcAUgOljnvO6nbGEn64myKp3kAPuQMTbvapi9K9cqAKCFuh76sfzrqrh
         oC5V4siwB6Kt6p8KYgXhNpn0ZVJlW1QBwnXkfD7GcjCRhGqnLt/sPkcDNGwuw3TamAHk
         ImbUZDDBkdor706xC8F3uUDbfWN1Rll0uFX/UQVxg375Ajv1Of3gET7mPn3saXDR8n32
         n2PCJiILFXceHrtqGwwdRy+pEv0iht+NlWliloZrC5mfafqtQVzk5yvFtndan9yoEprh
         zMIg==
X-Gm-Message-State: ANoB5pm8Hthg8PzyqHauZTxXo5S76sgrx1WgIdZE6ogqOjIujpn8FR4P
        hinHor5ll3uvInd13bUGhQg=
X-Google-Smtp-Source: AA0mqf6TJYdmBV4uqcojNktHAUuSrWKh+40hrVO5UjWbk/L98q28A7iRK2dih/ex8yogPUty9MNm1w==
X-Received: by 2002:a17:906:2856:b0:7a9:a59c:4be with SMTP id s22-20020a170906285600b007a9a59c04bemr2675063ejc.556.1668188060238;
        Fri, 11 Nov 2022 09:34:20 -0800 (PST)
Received: from localhost ([85.153.204.139])
        by smtp.gmail.com with UTF8SMTPSA id wl6-20020a170907310600b007add28659b0sm1098058ejb.140.2022.11.11.09.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 09:34:19 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH v3 3/4] arm64: dts: apple: t8103: Add PWM controller
Date:   Fri, 11 Nov 2022 20:33:47 +0300
Message-Id: <20221111173348.6537-4-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20221111173348.6537-1-fnkl.kernel@gmail.com>
References: <20221111173348.6537-1-fnkl.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds PWM controller and keyboard backlight bindings for M1 MacBooks

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
Acked-by: Sven Peter <sven@svenpeter.dev>
---
 arch/arm64/boot/dts/apple/t8103-j293.dts | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8103-j313.dts | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8103.dtsi     |  9 +++++++++
 3 files changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103-j293.dts b/arch/arm64/boot/dts/apple/t8103-j293.dts
index ecb10d237a05..0b4b7e8e0726 100644
--- a/arch/arm64/boot/dts/apple/t8103-j293.dts
+++ b/arch/arm64/boot/dts/apple/t8103-j293.dts
@@ -11,6 +11,7 @@
 
 #include "t8103.dtsi"
 #include "t8103-jxxx.dtsi"
+#include <dt-bindings/leds/common.h>
 
 / {
 	compatible = "apple,j293", "apple,t8103", "apple,arm-platform";
@@ -43,3 +44,22 @@ &i2c2 {
 &i2c4 {
 	status = "okay";
 };
+
+/ {
+	led-controller {
+		compatible = "pwm-leds";
+		led-0 {
+			pwms = <&fpwm1 0 40000>;
+			pwm-names = "kbd-backlight";
+			label = "kbd_backlight";
+			function = LED_FUNCTION_KBD_BACKLIGHT;
+			color = <LED_COLOR_ID_WHITE>;
+			max-brightness = <255>;
+			default-state = "keep";
+		};
+	};
+};
+
+&fpwm1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8103-j313.dts b/arch/arm64/boot/dts/apple/t8103-j313.dts
index df741737b8e6..0e0f57dee96b 100644
--- a/arch/arm64/boot/dts/apple/t8103-j313.dts
+++ b/arch/arm64/boot/dts/apple/t8103-j313.dts
@@ -11,6 +11,7 @@
 
 #include "t8103.dtsi"
 #include "t8103-jxxx.dtsi"
+#include <dt-bindings/leds/common.h>
 
 / {
 	compatible = "apple,j313", "apple,t8103", "apple,arm-platform";
@@ -35,3 +36,22 @@ &pcie0_dart_2 {
 
 /delete-node/ &port01;
 /delete-node/ &port02;
+
+/ {
+	led-controller {
+		compatible = "pwm-leds";
+		led-0 {
+			pwms = <&fpwm1 0 40000>;
+			pwm-names = "kbd-backlight";
+			label = "kbd_backlight";
+			function = LED_FUNCTION_KBD_BACKLIGHT;
+			color = <LED_COLOR_ID_WHITE>;
+			max-brightness = <255>;
+			default-state = "keep";
+		};
+	};
+};
+
+&fpwm1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 51a63b29d404..ccdb26ef6b22 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -191,6 +191,15 @@ i2c4: i2c@235020000 {
 			status = "disabled"; /* only used in J293 */
 		};
 
+		fpwm1: pwm@235044000 {
+			compatible = "apple,t8103-fpwm", "apple,s5l-fpwm";
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
-- 
2.38.1

