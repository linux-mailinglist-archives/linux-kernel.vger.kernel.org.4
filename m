Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3422D6164C7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiKBORk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiKBORa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:17:30 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F6227CC6;
        Wed,  2 Nov 2022 07:17:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kt23so45620406ejc.7;
        Wed, 02 Nov 2022 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0n4mZvFvck3T3rrfQ9rSgkc96Wcu4vbjw0wqQZmCTT8=;
        b=buxhVMqCdIEJlX44xa53eEaCR2cbl9OSqVZRxuS7pD4aeF0CWccB2ltiOBS0cNgMX4
         DisAdaH4fQPyuswXY8mVrNu/7euYRzRDdNtKNtsN51lGD+99PKgbDALVFhoBMN+cmot9
         fn7yeb9EjsaqOyZwK013AISF1cpQRA+Yp39a27gl3aT2p2h5Hn28d0wx6qx2pn1VrPKT
         NTxouVy7rM/l4nOEJ5Acou5ZCHUT832R7egaqXzyvXlozybZFJcfDHe1TuWDs9tbASBh
         FPtX9F+vYjwOZP1PLOlMe/fcS/0+qrhgg/0Nzg139fODDkrB6HmPAbgrGrIS+48geAws
         DoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0n4mZvFvck3T3rrfQ9rSgkc96Wcu4vbjw0wqQZmCTT8=;
        b=eCKavCxSMC9NVu7STGnlh59FtUU6hRmGeorg6s5DnPaHgLrsvNMiP6USv4r0VZ/Nyo
         kZupYGkCT7U8qf9CYIHSG7jN9FIn9CZj+p8kzwWNkbV9bs4I+4Bo5F08NIMWLaSgBD9C
         f5DZLfzpxxhpg+3CqeNtkhMoNpcSBBvhYscNARJTPDd+Mcm6eocAIHFCdU+J7eOdlwPO
         FWaEcGXMNfdu9Dijtb1waJK4s9jh7SnuauENXEr3kW3zC0kG37ml20Exbt6UdVezVNrx
         4gIz+V7w3ba6NuFgZ/X8IogppR6h0hi3HTu1SaULvRKVLx8baXvUbDydZ4bUs5XSG7tv
         in5A==
X-Gm-Message-State: ACrzQf3t0yXVvUjPXSAfM6nq0+iaw+bA62isnSmki/qabR+J2YdZyIU3
        DUZpDJlaKXekADIJaubzBFW9mtwYyfA=
X-Google-Smtp-Source: AMsMyM4UO4LPIkeJUPkXOsfooljJbLt0HcMi9N88XdOTQPepALYXqc7eYSiyc0/cuRaRL24dJu/mLw==
X-Received: by 2002:a17:907:6d9b:b0:78d:f24b:e358 with SMTP id sb27-20020a1709076d9b00b0078df24be358mr23291374ejc.714.1667398641424;
        Wed, 02 Nov 2022 07:17:21 -0700 (PDT)
Received: from localhost ([88.227.60.86])
        by smtp.gmail.com with UTF8SMTPSA id r16-20020a170906365000b007ad9c826d75sm5465266ejb.61.2022.11.02.07.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 07:17:21 -0700 (PDT)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH v2 3/4] arm64: dts: apple: t8103: Add PWM controller
Date:   Wed,  2 Nov 2022 17:15:12 +0300
Message-Id: <20221102141513.49289-4-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20221102141513.49289-1-fnkl.kernel@gmail.com>
References: <20221102141513.49289-1-fnkl.kernel@gmail.com>
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
2.37.3

