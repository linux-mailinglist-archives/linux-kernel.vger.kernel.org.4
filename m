Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555F56C6FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjCWR6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjCWR6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:58:02 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A492122;
        Thu, 23 Mar 2023 10:58:01 -0700 (PDT)
Received: from [192.168.0.26] (2a02-8388-6582-fe80-0000-0000-0000-000c.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::c])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 2883DD2585;
        Thu, 23 Mar 2023 17:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1679594279; bh=QEe/z0x1YIt/MXdaImskhcwh5eKk1KzQFXz+kV0iHHk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=ca0T7PqAeaNhUWQDoGISbgPnO1sZJ/ZCH0GmSH63dvxL/0yjhMvGp3SlKLin2bGow
         LK2UCgIXSh6UyQZetVIOCqbJXwz4Tyi8DmBOobU2nMawBC5qRMitzwf6U6nuOrWbL1
         AKraEUU4UmWcJEeo+46muR1hxzPSfbkIFbSlz90A=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Thu, 23 Mar 2023 18:57:50 +0100
Subject: [PATCH v4 2/3] media: dt-bindings: ov2685: convert to dtschema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230129-ov2685-improvements-v4-2-e71985c5c848@z3ntu.xyz>
References: <20230129-ov2685-improvements-v4-0-e71985c5c848@z3ntu.xyz>
In-Reply-To: <20230129-ov2685-improvements-v4-0-e71985c5c848@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5191; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=QEe/z0x1YIt/MXdaImskhcwh5eKk1KzQFXz+kV0iHHk=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkHJMkIONBl9L8PQFixgBJWgg8z74ZA3pWxIji0
 4i1TyI9k2yJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZByTJAAKCRBy2EO4nU3X
 Vpx/EACJ3t8MMr4pJOMqcQA6UP1HGSBLy/oKTpZ+EA2rRzowW5fbKo3ZU8/v4RTVeJECytmpAu0
 eFiDlirCeKJPHOybyqxlMte4kx/qnptmEXqWQJiC2Sc0H3uLtb6ZmhVMFES11BwmTAFV5NJWFF9
 ZtbGkPXSbljlaE2RoLGlPTWgHIRZQ8U5jI2qMXpe5einulpm/MtpMZo0T4H+D6uk7Gu/8Kxq7JG
 LNKZvRj2D9GMA3sEI9/5FFlseRKJgGlH7AiLX32ug4esFlok2OeNNHRM72avjNhFnvHmUmgAYMm
 4gwe0hSEsOdohGcBrWSC8Bf3J+QQgFKERAlapxMfkvgc1eZJo88PNk7KdOJNiF0TCkr8CAQ8/C8
 ukHYHEz8fQsjUZrqcCUCYroYwwehDsUeun69MCk9RJHL5aymiawsf/DrBGj1cAmrk0eVpJxxvaO
 rMzI6YJgx7q6jFgCcvvblCgoKIVlfDIYbcmR6vZcwOOvkQ7WNP+o3GsYTbK0D/UVKaWEFDth9/q
 JPVtt+dL2ONY4QN+/LA6GrJH7QfG7dbOFZWSlG7zRKNh9/p/x6pcrr1IBwhTk4wPcZ2S5sAQXEL
 WoSbh+y9jal3vdZKyvf2LoAABT3WhN+vESNzJn9D0f6gYNPoPktOVW9xcw+D45Njib4tbA9rjDw
 GrHJjvO4Gu09Adg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the text-based dt-bindings to yaml.

Changes from original txt:
* Take wording for various properties from other yaml bindings, this
  removes e.g. volt amount from schema since it isn't really relevant
  and the datasheet is a better source.
* Don't make reset-gpios a required property since it can be tied to
  DOVDD instead.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../devicetree/bindings/media/i2c/ov2685.txt       |  41 ---------
 .../devicetree/bindings/media/i2c/ovti,ov2685.yaml | 101 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 3 files changed, 102 insertions(+), 41 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/ov2685.txt b/Documentation/devicetree/bindings/media/i2c/ov2685.txt
deleted file mode 100644
index 625c4a8c0d53d..0000000000000
--- a/Documentation/devicetree/bindings/media/i2c/ov2685.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-* Omnivision OV2685 MIPI CSI-2 sensor
-
-Required Properties:
-- compatible: shall be "ovti,ov2685"
-- clocks: reference to the xvclk input clock
-- clock-names: shall be "xvclk"
-- avdd-supply: Analog voltage supply, 2.8 volts
-- dovdd-supply: Digital I/O voltage supply, 1.8 volts
-- dvdd-supply: Digital core voltage supply, 1.8 volts
-- reset-gpios: Low active reset gpio
-
-The device node shall contain one 'port' child node with an
-'endpoint' subnode for its digital output video port,
-in accordance with the video interface bindings defined in
-Documentation/devicetree/bindings/media/video-interfaces.txt.
-The endpoint optional property 'data-lanes' shall be "<1>".
-
-Example:
-&i2c7 {
-	ov2685: camera-sensor@3c {
-		compatible = "ovti,ov2685";
-		reg = <0x3c>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&clk_24m_cam>;
-
-		clocks = <&cru SCLK_TESTCLKOUT1>;
-		clock-names = "xvclk";
-
-		avdd-supply = <&pp2800_cam>;
-		dovdd-supply = <&pp1800>;
-		dvdd-supply = <&pp1800>;
-		reset-gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
-
-		port {
-			ucam_out: endpoint {
-				remote-endpoint = <&mipi_in_ucam>;
-				data-lanes = <1>;
-			};
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
new file mode 100644
index 0000000000000..2ac0ca8a0413b
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/ovti,ov2685.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OmniVision OV2685 Image Sensor
+
+maintainers:
+  - Shunqian Zheng <zhengsq@rock-chips.com>
+
+properties:
+  compatible:
+    const: ovti,ov2685
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: XVCLK clock
+
+  clock-names:
+    items:
+      - const: xvclk
+
+  dvdd-supply:
+    description: Digital Domain Power Supply
+
+  avdd-supply:
+    description: Analog Domain Power Supply
+
+  dovdd-supply:
+    description: I/O Domain Power Supply
+
+  reset-gpios:
+    maxItems: 1
+    description: Reset Pin GPIO Control (active low)
+
+  port:
+    description: MIPI CSI-2 transmitter port
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    additionalProperties: false
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          data-lanes:
+            maxItems: 1
+
+        required:
+          - data-lanes
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - dvdd-supply
+  - avdd-supply
+  - dovdd-supply
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3399-cru.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ov2685: camera-sensor@3c {
+            compatible = "ovti,ov2685";
+            reg = <0x3c>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&clk_24m_cam>;
+
+            clocks = <&cru SCLK_TESTCLKOUT1>;
+            clock-names = "xvclk";
+
+            avdd-supply = <&pp2800_cam>;
+            dovdd-supply = <&pp1800>;
+            dvdd-supply = <&pp1800>;
+            reset-gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
+
+            port {
+                ucam_out: endpoint {
+                    remote-endpoint = <&mipi_in_ucam>;
+                    data-lanes = <1>;
+                };
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 8ea325040f355..5904f47756fe1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15410,6 +15410,7 @@ M:	Shunqian Zheng <zhengsq@rock-chips.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
 F:	drivers/media/i2c/ov2685.c
 
 OMNIVISION OV2740 SENSOR DRIVER

-- 
2.40.0

