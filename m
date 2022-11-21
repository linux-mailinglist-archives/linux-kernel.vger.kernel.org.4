Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72978632B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiKURpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiKURpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:45:17 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390CF4D5F9;
        Mon, 21 Nov 2022 09:45:16 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id l11so17306858edb.4;
        Mon, 21 Nov 2022 09:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5GqgUQltU/UwWJVmKB9yBrhZ1yrd9RICIJ3rDIHDxU=;
        b=EEQfpiS80XVVx5sLX7hxmEe6Nc+y9aFvjbVDbccbOjamDOnaEeSuuTP9cyjVQmHaEq
         RAeC5m7UPE16AP/Qe1/9HOJUWGg48B62MMSa8VOrWdNX66bj6g+SyDJbDSnMjQuoXD7o
         ZoeMcpvr7kFG+oX9fW4DuJFATYerf1o+IbwZQN4Lo9hNq0MLbLXOaNQ5PgG9YaU9EsAe
         XyGRYc+8xGtXbYyj9W6bOm8Lix67z9ectnuHhnU3WrEhyrcKQb5maUCdqLLyVFgG8dt1
         tYqdX+qgQrC9JGANOEjoWFa40ck27oAmDOFhNPEe6q5tHXEVj43J+JZztCxi7f5vyjgQ
         ALTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5GqgUQltU/UwWJVmKB9yBrhZ1yrd9RICIJ3rDIHDxU=;
        b=GbgsHsjcJzbBFxtn7R6071MgGmdiE5w+14AEf9JXOCjANYLFZGnRr95bjFr1nx3Iuw
         iWOOPzKgNIxUJgeK4YZWywFvvXbvF/Czy8JAhtHIISWq8NfeuD8Pata5hl+1dQ5rmEs8
         uOXFZos7OQ78MjVD8yNeOts17JrFj+Xm/D3XKOc8Jm3yrsyHTJr2bAGzEs3WD1A6nG3d
         dp+PwWG6l8YWia+NAWsjP9jhwvinS33Y/fOP6ersKcvIw1DHL++l4cCvVc5ZG8RXccUI
         jzf5yrn/7z82l41DWOW/JjsEvOOt3gzik5ZyK2NFT7QI5AqU3Iq4CFKfjMv9UOJoOER0
         SBmw==
X-Gm-Message-State: ANoB5pl6c8dIurBvSe6iqN5RAnXsc5FhvkCOd5adzHh988SAT9V9iwjl
        t+Htwa8Io0QllyEeoQ7AXwA=
X-Google-Smtp-Source: AA0mqf6LYJRmuao1b8/FmHyF8hM9rGcOvUl8k9MzKzg4AB1fNO2tR3YxlSSFoYQG1Y4rrMZVM+c70A==
X-Received: by 2002:a05:6402:2929:b0:469:b603:ca21 with SMTP id ee41-20020a056402292900b00469b603ca21mr1615945edb.350.1669052714455;
        Mon, 21 Nov 2022 09:45:14 -0800 (PST)
Received: from localhost ([217.131.81.52])
        by smtp.gmail.com with UTF8SMTPSA id d7-20020a170906304700b007b29d292852sm2418180ejd.148.2022.11.21.09.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 09:45:13 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH RESEND v3 3/4] arm64: dts: apple: t8103: Add PWM controller
Date:   Mon, 21 Nov 2022 20:42:27 +0300
Message-Id: <20221121174228.93670-4-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121174228.93670-1-fnkl.kernel@gmail.com>
References: <20221121174228.93670-1-fnkl.kernel@gmail.com>
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

