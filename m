Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4C0644DD7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 22:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiLFVSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 16:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLFVSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 16:18:10 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1C31135;
        Tue,  6 Dec 2022 13:18:09 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id s186so18304602oia.5;
        Tue, 06 Dec 2022 13:18:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1fZ+Nm1ZVezN1RXPdT9/whBqlUpozCto6FF44KKkJ4U=;
        b=XGr4AAKGDu+pobKG13kXoAbaAv9gbSBSGt9JhjeN28CTb/BWWqQU/QTlGGOcRG0lGo
         wQACxjvFvNfA+M/GsusZMl7zVOeCz+2qWaLNgznhloLkT12QvzTq9SNTpNyqrHycKGj6
         NrXzb7w9HpmWfRCm4Kycrjb1UaBBAfx0/xc8qkz2kNiatLjQivvxxKJxUg9Rww/p7ay8
         bZ4yNUn+OEO+ONsE9k/9ZFIMNhJOLncph5S//DlGTphGn7GQrwIguMkZK8AUQ6Hkq1kc
         nYLp0wG/4h6LHWDzPaQv3qOcl2/2xOhQw8mxAQfYMTlaCkC5TBYOdD8OJftcwaO0OAu+
         f6Mw==
X-Gm-Message-State: ANoB5pmyxUAZUgQwwHYvtPjZf9egItUU21ybUVgS2O7iRZS/H9Kd3R1Z
        xIWqYxm0ox2WOl0Jvx27SKT3qpHZyw==
X-Google-Smtp-Source: AA0mqf7atIqgmcAEyNTqMz4+XRNR7PAGa4eH0oaBHkRZ2wsg8a4J/Infh7O0CnVxXkpR9sAsST1BwA==
X-Received: by 2002:a05:6808:655:b0:35a:2e4b:4c44 with SMTP id z21-20020a056808065500b0035a2e4b4c44mr36172114oih.263.1670361488907;
        Tue, 06 Dec 2022 13:18:08 -0800 (PST)
Received: from robh_at_kernel.org ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id ay19-20020a056808301300b00354b0850fb6sm8874803oib.33.2022.12.06.13.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 13:18:08 -0800 (PST)
Received: (nullmailer pid 94882 invoked by uid 1000);
        Tue, 06 Dec 2022 21:18:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Gene Chen <gene_chen@richtek.com>,
        Daniel Mack <zonque@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH] dt-bindings: Add missing 'unevaluatedProperties' to regulator nodes
Date:   Tue,  6 Dec 2022 15:15:55 -0600
Message-Id: <20221206211554.92005-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several regulator schemas are missing 'unevaluatedProperties' constraint
which means any extra properties are allowed. Upon adding the
constraint, there's numerous warnings from using the deprecated
'regulator-compatible' property. Remove the usage as examples shouldn't
be using long since deprecated properties.

Signed-off-by: Rob Herring <robh@kernel.org>
---
I'd suggest that Mark take this if that's okay with Lee. Or I can take 
it.

 Documentation/devicetree/bindings/mfd/max77650.yaml  |  2 --
 .../devicetree/bindings/mfd/mediatek,mt6360.yaml     |  9 ---------
 .../bindings/power/supply/mt6360_charger.yaml        |  2 +-
 .../bindings/regulator/max77650-regulator.yaml       |  1 +
 .../devicetree/bindings/regulator/max8660.yaml       |  6 +-----
 .../bindings/regulator/mt6360-regulator.yaml         | 12 +++---------
 6 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/max77650.yaml b/Documentation/devicetree/bindings/mfd/max77650.yaml
index b0a0f0d3d9d4..4181174fcf58 100644
--- a/Documentation/devicetree/bindings/mfd/max77650.yaml
+++ b/Documentation/devicetree/bindings/mfd/max77650.yaml
@@ -100,14 +100,12 @@ examples:
                 compatible = "maxim,max77650-regulator";
 
                 max77650_ldo: regulator-ldo {
-                    regulator-compatible = "ldo";
                     regulator-name = "max77650-ldo";
                     regulator-min-microvolt = <1350000>;
                     regulator-max-microvolt = <2937500>;
                 };
 
                 max77650_sbb0: regulator-sbb0 {
-                    regulator-compatible = "sbb0";
                     regulator-name = "max77650-sbb0";
                     regulator-min-microvolt = <800000>;
                     regulator-max-microvolt = <1587500>;
diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6360.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6360.yaml
index 28eee02441ee..fb65abf30d57 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6360.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6360.yaml
@@ -83,7 +83,6 @@ examples:
                 richtek,vinovp-microvolt = <14500000>;
 
                 otg_vbus_regulator: usb-otg-vbus-regulator {
-                    regulator-compatible = "usb-otg-vbus";
                     regulator-name = "usb-otg-vbus";
                     regulator-min-microvolt = <4425000>;
                     regulator-max-microvolt = <5825000>;
@@ -145,7 +144,6 @@ examples:
                 compatible = "mediatek,mt6360-regulator";
                 LDO_VIN3-supply = <&BUCK2>;
                 buck1 {
-                    regulator-compatible = "BUCK1";
                     regulator-name = "mt6360,buck1";
                     regulator-min-microvolt = <300000>;
                     regulator-max-microvolt = <1300000>;
@@ -154,7 +152,6 @@ examples:
                          MT6360_OPMODE_ULP>;
                 };
                 BUCK2: buck2 {
-                    regulator-compatible = "BUCK2";
                     regulator-name = "mt6360,buck2";
                     regulator-min-microvolt = <300000>;
                     regulator-max-microvolt = <1300000>;
@@ -163,7 +160,6 @@ examples:
                          MT6360_OPMODE_ULP>;
                 };
                 ldo6 {
-                    regulator-compatible = "LDO6";
                     regulator-name = "mt6360,ldo6";
                     regulator-min-microvolt = <500000>;
                     regulator-max-microvolt = <2100000>;
@@ -171,7 +167,6 @@ examples:
                          MT6360_OPMODE_LP>;
                 };
                 ldo7 {
-                    regulator-compatible = "LDO7";
                     regulator-name = "mt6360,ldo7";
                     regulator-min-microvolt = <500000>;
                     regulator-max-microvolt = <2100000>;
@@ -179,7 +174,6 @@ examples:
                          MT6360_OPMODE_LP>;
                 };
                 ldo1 {
-                    regulator-compatible = "LDO1";
                     regulator-name = "mt6360,ldo1";
                     regulator-min-microvolt = <1200000>;
                     regulator-max-microvolt = <3600000>;
@@ -187,7 +181,6 @@ examples:
                          MT6360_OPMODE_LP>;
                 };
                 ldo2 {
-                    regulator-compatible = "LDO2";
                     regulator-name = "mt6360,ldo2";
                     regulator-min-microvolt = <1200000>;
                     regulator-max-microvolt = <3600000>;
@@ -195,7 +188,6 @@ examples:
                          MT6360_OPMODE_LP>;
                 };
                 ldo3 {
-                    regulator-compatible = "LDO3";
                     regulator-name = "mt6360,ldo3";
                     regulator-min-microvolt = <1200000>;
                     regulator-max-microvolt = <3600000>;
@@ -203,7 +195,6 @@ examples:
                          MT6360_OPMODE_LP>;
                 };
                 ldo5 {
-                    regulator-compatible = "LDO5";
                     regulator-name = "mt6360,ldo5";
                     regulator-min-microvolt = <2700000>;
                     regulator-max-microvolt = <3600000>;
diff --git a/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml b/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml
index b89b15a5bfa4..4c74cc78729e 100644
--- a/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml
@@ -26,6 +26,7 @@ properties:
     type: object
     description: OTG boost regulator.
     $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
 
 required:
   - compatible
@@ -39,7 +40,6 @@ examples:
       richtek,vinovp-microvolt = <14500000>;
 
       otg_vbus_regulator: usb-otg-vbus-regulator {
-        regulator-compatible = "usb-otg-vbus";
         regulator-name = "usb-otg-vbus";
         regulator-min-microvolt = <4425000>;
         regulator-max-microvolt = <5825000>;
diff --git a/Documentation/devicetree/bindings/regulator/max77650-regulator.yaml b/Documentation/devicetree/bindings/regulator/max77650-regulator.yaml
index ce0a4021ae7f..01b9775a92d1 100644
--- a/Documentation/devicetree/bindings/regulator/max77650-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/max77650-regulator.yaml
@@ -26,6 +26,7 @@ properties:
 patternProperties:
   "^regulator-(ldo|sbb[0-2])$":
     $ref: "regulator.yaml#"
+    unevaluatedProperties: false
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/regulator/max8660.yaml b/Documentation/devicetree/bindings/regulator/max8660.yaml
index 4d550ca396eb..35792a927b03 100644
--- a/Documentation/devicetree/bindings/regulator/max8660.yaml
+++ b/Documentation/devicetree/bindings/regulator/max8660.yaml
@@ -26,6 +26,7 @@ properties:
     patternProperties:
       "^regulator-.+$":
         $ref: "regulator.yaml#"
+        unevaluatedProperties: false
 
     additionalProperties: false
 
@@ -43,31 +44,26 @@ examples:
 
         regulators {
           regulator-V3 {
-            regulator-compatible= "V3(DCDC)";
             regulator-min-microvolt = <725000>;
             regulator-max-microvolt = <1800000>;
           };
 
           regulator-V4 {
-            regulator-compatible= "V4(DCDC)";
             regulator-min-microvolt = <725000>;
             regulator-max-microvolt = <1800000>;
           };
 
           regulator-V5 {
-            regulator-compatible= "V5(LDO)";
             regulator-min-microvolt = <1700000>;
             regulator-max-microvolt = <2000000>;
           };
 
           regulator-V6 {
-            regulator-compatible= "V6(LDO)";
             regulator-min-microvolt = <1800000>;
             regulator-max-microvolt = <3300000>;
           };
 
           regulator-V7 {
-            regulator-compatible= "V7(LDO)";
             regulator-min-microvolt = <1800000>;
             regulator-max-microvolt = <3300000>;
           };
diff --git a/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml b/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml
index a462d99a25cc..8a0931dc2f30 100644
--- a/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml
@@ -27,9 +27,11 @@ properties:
 patternProperties:
   "^buck[12]$":
     $ref: "regulator.yaml#"
+    unevaluatedProperties: false
 
   "^ldo[123567]$":
     $ref: "regulator.yaml#"
+    unevaluatedProperties: false
 
 required:
   - compatible
@@ -44,7 +46,6 @@ examples:
       compatible = "mediatek,mt6360-regulator";
       LDO_VIN3-supply = <&BUCK2>;
       buck1 {
-        regulator-compatible = "BUCK1";
         regulator-name = "mt6360,buck1";
         regulator-min-microvolt = <300000>;
         regulator-max-microvolt = <1300000>;
@@ -53,7 +54,6 @@ examples:
              MT6360_OPMODE_ULP>;
       };
       BUCK2: buck2 {
-        regulator-compatible = "BUCK2";
         regulator-name = "mt6360,buck2";
         regulator-min-microvolt = <300000>;
         regulator-max-microvolt = <1300000>;
@@ -62,7 +62,6 @@ examples:
              MT6360_OPMODE_ULP>;
       };
       ldo6 {
-        regulator-compatible = "LDO6";
         regulator-name = "mt6360,ldo6";
         regulator-min-microvolt = <500000>;
         regulator-max-microvolt = <2100000>;
@@ -70,7 +69,6 @@ examples:
              MT6360_OPMODE_LP>;
       };
       ldo7 {
-        regulator-compatible = "LDO7";
         regulator-name = "mt6360,ldo7";
         regulator-min-microvolt = <500000>;
         regulator-max-microvolt = <2100000>;
@@ -78,15 +76,13 @@ examples:
              MT6360_OPMODE_LP>;
       };
       ldo1 {
-        regulator-compatible = "LDO1";
         regulator-name = "mt6360,ldo1";
         regulator-min-microvolt = <1200000>;
         regulator-max-microvolt = <3600000>;
         regulator-allowed-modes = <MT6360_OPMODE_NORMAL
              MT6360_OPMODE_LP>;
       };
-        ldo2 {
-        regulator-compatible = "LDO2";
+      ldo2 {
         regulator-name = "mt6360,ldo2";
         regulator-min-microvolt = <1200000>;
         regulator-max-microvolt = <3600000>;
@@ -94,7 +90,6 @@ examples:
              MT6360_OPMODE_LP>;
       };
       ldo3 {
-        regulator-compatible = "LDO3";
         regulator-name = "mt6360,ldo3";
         regulator-min-microvolt = <1200000>;
         regulator-max-microvolt = <3600000>;
@@ -102,7 +97,6 @@ examples:
              MT6360_OPMODE_LP>;
       };
       ldo5 {
-        regulator-compatible = "LDO5";
         regulator-name = "mt6360,ldo5";
         regulator-min-microvolt = <2700000>;
         regulator-max-microvolt = <3600000>;
-- 
2.35.1

