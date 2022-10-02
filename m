Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D395F224E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 11:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJBJUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 05:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiJBJUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 05:20:18 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A982CDDE
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 02:20:11 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id g20so8962572ljg.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 02:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=MZQJRHWFuTKOjzaogLAIEqzbw/L9APiUq1nWOcqX8xA=;
        b=GJj0z5E4ojjjgQUV6BO7tifCLppVeWWTOR3R5hrvHcG+nwUp3cxaQBQxCEEAjFpodS
         lD8/8j2oYBiA8+eulmtObBAEnT2y6W2OnM4sPYZmS4DXlIveraL2ZkOAU9B7U5IusW9G
         NZlMZLHBnENlyt/MfIRG8xitWFQdTUXjvWVF7OSrxpe4TzXUeK6pu3AjSyM2F7DCV9ce
         3lBipiwplGxC7GuVtlw5i9POUPt6u437RZqaOyArCiaJR1XISjwtwaDhP3URjgYfZr/h
         PO0r1U8tviJwcwTZ18tjCXM9DocmSOupXUXEj10vJ0uzgv4JC0zI6iP1DZNjjAcfSRD2
         3Msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=MZQJRHWFuTKOjzaogLAIEqzbw/L9APiUq1nWOcqX8xA=;
        b=pwTGxH/VlyPUsMaqcNKmGzwjeLM/qfhr12EbhW7WYVtoe+glOzwu/LktJCsHVRuqDN
         vIVt0H2Z6I4qqREOH4lrp84A4VTcxSA1tAjsiP5Ta1zhf41R2felBLeq02ZZaD1lZJjE
         xnOgIh8syDBFcUoyt8EvsS7pJpkGPkWb90kGqHztUHPtMgF/EK0EQwy6I6elzWjzDEMo
         b32qlxCDMpkRPWx0npDh+Nq3WX2E3tiQABxJRJfEVyKUDqpw0W0/4eGy9zeV0QQTmylK
         WuoSDw+XLs8utzc7L7/3JAFfZUe8YZvNsOrTFN4x5+yVXjU/ghnAkXtUogyJvPv/w9JG
         EQlg==
X-Gm-Message-State: ACrzQf0WZP9l47BdG+qhMII8y7oJOjK5LZaoajYpOTz+lu/GcV/9wc0x
        NaRm61C2Oc3XhC+2PSp2TU1DQZxnlW9nKg==
X-Google-Smtp-Source: AMsMyM42zx20n9dh28U4NbA6nSMrYQzXa8PlUj3D4Z27CIh7kKCfgE6ClWK31Q8pLSDyX0ATu5v89w==
X-Received: by 2002:a2e:be9e:0:b0:26c:2d48:5c98 with SMTP id a30-20020a2ebe9e000000b0026c2d485c98mr5107579ljr.395.1664702411540;
        Sun, 02 Oct 2022 02:20:11 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b18-20020a056512305200b0048b0696d0b1sm1029956lfb.90.2022.10.02.02.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 02:20:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: ti: correct indentation
Date:   Sun,  2 Oct 2022 11:20:10 +0200
Message-Id: <20221002092010.69030-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not use spaces for indentation.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../arm/boot/dts/am335x-moxa-uc-2100-common.dtsi | 10 +++++-----
 .../arm/boot/dts/am335x-moxa-uc-8100-common.dtsi | 10 +++++-----
 arch/arm/boot/dts/am335x-pepper.dts              |  4 ++--
 arch/arm/boot/dts/am3517-evm.dts                 | 16 ++++++++--------
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi b/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
index 7b40ca9483ca..49e280b42442 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
+++ b/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
@@ -16,11 +16,11 @@ vbat: vbat-regulator {
 
 	/* Power supply provides a fixed 3.3V @3A */
 	vmmcsd_fixed: vmmcsd-regulator {
-	      compatible = "regulator-fixed";
-	      regulator-name = "vmmcsd_fixed";
-	      regulator-min-microvolt = <3300000>;
-	      regulator-max-microvolt = <3300000>;
-	      regulator-boot-on;
+		compatible = "regulator-fixed";
+		regulator-name = "vmmcsd_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
 	};
 
 	buttons: push_button {
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi b/arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi
index e0364adb8393..7d00e8b20f18 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi
+++ b/arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi
@@ -21,11 +21,11 @@ vbat: vbat-regulator {
 
 	/* Power supply provides a fixed 3.3V @3A */
 	vmmcsd_fixed: vmmcsd-regulator {
-	      compatible = "regulator-fixed";
-	      regulator-name = "vmmcsd_fixed";
-	      regulator-min-microvolt = <3300000>;
-	      regulator-max-microvolt = <3300000>;
-	      regulator-boot-on;
+		compatible = "regulator-fixed";
+		regulator-name = "vmmcsd_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
 	};
 
 	buttons: push_button {
diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
index 8691eec33b61..a4509e9e1056 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -555,11 +555,11 @@ &usb {
 };
 
 &usb0 {
-        dr_mode = "host";
+	dr_mode = "host";
 };
 
 &usb1 {
-        dr_mode = "host";
+	dr_mode = "host";
 };
 
 &am33xx_pinmux {
diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/am3517-evm.dts
index 35b653014f2b..18c85c112a3e 100644
--- a/arch/arm/boot/dts/am3517-evm.dts
+++ b/arch/arm/boot/dts/am3517-evm.dts
@@ -26,12 +26,12 @@ memory@80000000 {
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
-        vmmc_fixed: vmmc {
-                compatible = "regulator-fixed";
-                regulator-name = "vmmc_fixed";
-                regulator-min-microvolt = <3300000>;
-                regulator-max-microvolt = <3300000>;
-        };
+	vmmc_fixed: vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 
 	gpio-keys {
 		compatible = "gpio-keys-polled";
@@ -176,7 +176,7 @@ &davinci_emac {
 };
 
 &davinci_mdio {
-	     status = "okay";
+	status = "okay";
 };
 
 &dss {
@@ -227,7 +227,7 @@ &mmc1 {
 };
 
 &mmc3 {
-      status = "disabled";
+	status = "disabled";
 };
 
 &usbhshost {
-- 
2.34.1

