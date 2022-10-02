Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A815F224A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 11:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJBJU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 05:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJBJUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 05:20:16 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D552CCB3
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 02:20:11 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g1so12764543lfu.12
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 02:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=7E34Nd0fqYO29zfuWWC6hFc4/xSVoNvpXRlv4vTai7s=;
        b=V3leLmDOyMc1CdW8p3Iv9RQqqLqDKOnJSIxxj6Gszj8mSxJ2FhPPBIo7gRAqCO5h4g
         l/QUxBGrZbMal3bffh9rXJXZYoA6p7uFULm8L589/FmRKNNMjwf0bghXeWiorJ7DQ+M7
         0JWRZIvrL/IxpGsAPX0FAoMnjNac+9VwGd2SZdnG5zzSdVzhlR6U1H+6itfWUCnRKyOY
         d60W6A7vwKj6CRXz9L+M1oy2YV++4i7zclCIwUjjnbCjYb/V4ne+E1ugemPv7YDlt+WZ
         UThRx4kZfKC71zvlYcibVDAqX7skWGo46IGk7Oq/EhC+3Jm9tT15qx7ysjCXQSATDeSq
         GlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=7E34Nd0fqYO29zfuWWC6hFc4/xSVoNvpXRlv4vTai7s=;
        b=X098EwBQ/YZefcTZJab6s5neadFxc4HiLuAOdk76+xLfmuiU1Az52gGhaPxAM1sWNG
         RCXn7c8LI1YwTeGpmnlJopJvpZPzYSzVZHzAR1Tdo0HgxQfKEzgZ+O+OzrEkyEt98ZR6
         W8oAMY3WPeItDxBjCoQNLYtWDVwEW3bkFQY2OrxlEii02/3E4VxPSGeKDVVGpxNXmiBY
         q6rpN5m0ZALKUoSnT3IwJ6AF88tPtmBLDlMATbCcpoC1LiFC4tHmuLAF4z+2Uhv5S5lB
         fv3aCG+PraKohG2mX9//lk8D3nqyraXTwNIwP6MWyiR1SO7lPN1J3Sbh4LCZ2eHjS4Hq
         3Ltw==
X-Gm-Message-State: ACrzQf3iYNjrfoo07yK2tmVExblhGehuLwe953eVmYgpAE+dPqz1DgFh
        ego8b6/FC2aQMLCIEE7vGrt5lTRjolacoA==
X-Google-Smtp-Source: AMsMyM5kd35NBeP8g1A82vU83e8BkrgbpybfvO/mbGYOK04ORIdDm0RqBYxaLxmIUWBkngyPwKo/UQ==
X-Received: by 2002:a19:7516:0:b0:4a2:2583:411c with SMTP id y22-20020a197516000000b004a22583411cmr1971251lfe.210.1664702410022;
        Sun, 02 Oct 2022 02:20:10 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id bi8-20020a0565120e8800b004a06a25df38sm1014924lfb.271.2022.10.02.02.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 02:20:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: armada: correct indentation
Date:   Sun,  2 Oct 2022 11:20:08 +0200
Message-Id: <20221002092008.69003-1-krzysztof.kozlowski@linaro.org>
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

Do not use spaces for indentation.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/armada-370-netgear-rn102.dts   | 10 +++++-----
 arch/arm/boot/dts/armada-370-netgear-rn104.dts   | 10 +++++-----
 arch/arm/boot/dts/armada-370-rd.dts              | 16 ++++++++--------
 arch/arm/boot/dts/armada-370-synology-ds213j.dts |  6 +++---
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts   | 10 +++++-----
 5 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index b0b640b7de40..079b37cf148a 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -85,11 +85,11 @@ g762: g762@3e {
 	};
 
 	clocks {
-	       g762_clk: g762-oscillator {
-			 compatible = "fixed-clock";
-			 #clock-cells = <0>;
-			 clock-frequency = <8192>;
-	       };
+		g762_clk: g762-oscillator {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <8192>;
+		};
 	};
 
 	gpio-leds {
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index 85e2e9e27a9f..d752ac1d7b58 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -94,11 +94,11 @@ pca9554: pca9554@23 {
 	};
 
 	clocks {
-	       g762_clk: g762-oscillator {
-			 compatible = "fixed-clock";
-			 #clock-cells = <0>;
-			 clock-frequency = <8192>;
-	       };
+		g762_clk: g762-oscillator {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <8192>;
+		};
 	};
 
 	gpio-leds {
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index 6ba7699b69ed..be005c9f42ef 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -61,8 +61,8 @@ ethernet@74000 {
 				status = "okay";
 				phy-mode = "rgmii-id";
 				fixed-link {
-					   speed = <1000>;
-					   full-duplex;
+					speed = <1000>;
+					full-duplex;
 				};
 			};
 
@@ -155,18 +155,18 @@ port@0 {
 			};
 
 			port@1 {
-			       reg = <1>;
-			       label = "lan1";
+				reg = <1>;
+				label = "lan1";
 			};
 
 			port@2 {
-			       reg = <2>;
-			       label = "lan2";
+				reg = <2>;
+				label = "lan2";
 			};
 
 			port@3 {
-			       reg = <3>;
-			       label = "lan3";
+				reg = <3>;
+				label = "lan3";
 			};
 
 			port@5 {
diff --git a/arch/arm/boot/dts/armada-370-synology-ds213j.dts b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
index e72b8ed4b997..f0893cc06607 100644
--- a/arch/arm/boot/dts/armada-370-synology-ds213j.dts
+++ b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
@@ -91,9 +91,9 @@ usb@51000 {
 			};
 
 			ethernet@70000 {
-			       status = "okay";
-			       phy = <&phy1>;
-			       phy-mode = "sgmii";
+				status = "okay";
+				phy = <&phy1>;
+				phy-mode = "sgmii";
 			};
 
 			sata@a0000 {
diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
index 8ea73587db81..31933f81144e 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -121,11 +121,11 @@ sata@a0000 {
 	};
 
 	clocks {
-	       g762_clk: g762-oscillator {
-			 compatible = "fixed-clock";
-			 #clock-cells = <0>;
-			 clock-frequency = <32768>;
-	       };
+		g762_clk: g762-oscillator {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
 	};
 
 	gpio-leds {
-- 
2.34.1

