Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5020F638C79
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiKYOln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiKYOlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:41:31 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA133E092
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:41:28 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id j2so2885368ljg.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uwbaWwC3kqS29AMZlnuRnHxroFf5DqIl7JxLHxfEejI=;
        b=sCEtz5GouxyvggGUxzmRGzmfOfEzrcNmoe848X28oJuoQg76g23QaViVeqYyDHKwfG
         z5WQiPHgh9bCLn5iMmtXEhStLNDqYIGcZJbV6eeWHm9KqTVDeHBbxGLputJaWBUWOaHm
         K3HCqR3AOwBgJRkwCrLu+1pQPOn60G14EhCSA70y2fnTn/uSjwcrn1WHOatQE9W0wrs4
         8OFQq46EcbhaTcImt76VV7PBVqVZlSjWzkDoVuThtZ/5ni+GYDgvMlJnBLI0F4eHz6na
         a8f8J6mha1noKezDMhHzq3l7YqdxEZQNkvLN/XP0a1jAyqv8uPql02bSUzkzxAWxbGs5
         fy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uwbaWwC3kqS29AMZlnuRnHxroFf5DqIl7JxLHxfEejI=;
        b=f1j9sjli07PuypEZS8PP3fsIH+jxoWOGpMTX8riapETigXAk6Fn/adRXTqTRceJXKE
         JyjwSmaxdN7YzVjbe7gPYccdnIhsRW9rwdq5ddH2DOjZBvpTEfulnPGaytKyPt93MMZE
         9bfIfV6W5MS/7DuAG1m4WJRAohO8ZfYwysqP28ZrvpRHnbfT35UDuPl1fT16c+djVk0O
         ycEpqctJK9phcXmB6vD5VJtDBkPGP6MgLaU+kmDGd/PzmwKIalqX2qnoUcQhIMd99L8h
         m3p5tImW6weLy993DYZUSvhhttvJsNjRpycIYrrFeZL+/RRQtgZay8+jxuWYbT/U3gNG
         C3tA==
X-Gm-Message-State: ANoB5pnsQxU+tmwIwDPQKOVD9+tdnIqy0OuuAU1JkBBUZFBOg0fFoVN3
        YgI+FbRuRnb9iDZVoZv2PQ1GwQ==
X-Google-Smtp-Source: AA0mqf7bT8q4LgpDMLLBHWi3A7JJwmCWOQzXtt0I2J0pIE3lj7CqGwP7TgfWWgvdhIrzktTLZul44Q==
X-Received: by 2002:a2e:87ce:0:b0:277:ddf:f476 with SMTP id v14-20020a2e87ce000000b002770ddff476mr12457020ljj.432.1669387287020;
        Fri, 25 Nov 2022 06:41:27 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bt14-20020a056512260e00b004b3b2a9f506sm548687lfb.4.2022.11.25.06.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:41:26 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: dove: align LED node names with dtschema
Date:   Fri, 25 Nov 2022 15:41:25 +0100
Message-Id: <20221125144125.477032-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and DT schema expects certain pattern:

  dove-cubox.dtb: leds: 'power' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/dove-cm-a510.dtsi | 2 +-
 arch/arm/boot/dts/dove-cubox.dts    | 2 +-
 arch/arm/boot/dts/dove-d2plug.dts   | 6 +++---
 arch/arm/boot/dts/dove-d3plug.dts   | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/dove-cm-a510.dtsi b/arch/arm/boot/dts/dove-cm-a510.dtsi
index 9b9dfbe07be4..0af9e9fda7d3 100644
--- a/arch/arm/boot/dts/dove-cm-a510.dtsi
+++ b/arch/arm/boot/dts/dove-cm-a510.dtsi
@@ -101,7 +101,7 @@ leds {
 		pinctrl-0 = <&pmx_nand_gpo>;
 		pinctrl-names = "default";
 
-		system {
+		led-system {
 			label = "cm-a510:system:green";
 			gpios = <&gpio2 1 GPIO_ACTIVE_HIGH>;
 			default-state = "keep";
diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
index 2639b9fe0ab4..c0e8d6bc4083 100644
--- a/arch/arm/boot/dts/dove-cubox.dts
+++ b/arch/arm/boot/dts/dove-cubox.dts
@@ -21,7 +21,7 @@ leds {
 		pinctrl-0 = <&pmx_gpio_18>;
 		pinctrl-names = "default";
 
-		power {
+		led-power {
 			label = "Power";
 			gpios = <&gpio0 18 1>;
 			default-state = "keep";
diff --git a/arch/arm/boot/dts/dove-d2plug.dts b/arch/arm/boot/dts/dove-d2plug.dts
index a0e8996c2ffd..79ee2b32409d 100644
--- a/arch/arm/boot/dts/dove-d2plug.dts
+++ b/arch/arm/boot/dts/dove-d2plug.dts
@@ -21,17 +21,17 @@ leds {
 		pinctrl-0 = <&pmx_gpio_0 &pmx_gpio_1 &pmx_gpio_2>;
 		pinctrl-names = "default";
 
-		wlan-ap {
+		led-wlan-ap {
 			label = "wlan-ap";
 			gpios = <&gpio0 0 1>;
 		};
 
-		wlan-act {
+		led-wlan-act {
 			label = "wlan-act";
 			gpios = <&gpio0 1 1>;
 		};
 
-		bluetooth-act {
+		led-bluetooth-act {
 			label = "bt-act";
 			gpios = <&gpio0 2 1>;
 		};
diff --git a/arch/arm/boot/dts/dove-d3plug.dts b/arch/arm/boot/dts/dove-d3plug.dts
index 1e81d1b97055..5aa5d4a7d51d 100644
--- a/arch/arm/boot/dts/dove-d3plug.dts
+++ b/arch/arm/boot/dts/dove-d3plug.dts
@@ -21,17 +21,17 @@ leds {
 		pinctrl-0 = <&pmx_gpio_0 &pmx_gpio_1 &pmx_gpio_2>;
 		pinctrl-names = "default";
 
-		wlan-act {
+		led-wlan-act {
 			label = "wlan-act";
 			gpios = <&gpio0 0 1>;
 		};
 
-		wlan-ap {
+		led-wlan-ap {
 			label = "wlan-ap";
 			gpios = <&gpio0 1 1>;
 		};
 
-		status {
+		led-status {
 			label = "status";
 			gpios = <&gpio0 2 1>;
 		};
-- 
2.34.1

