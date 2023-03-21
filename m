Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F4E6C38E2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjCUSFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCUSFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:05:02 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9835B28E64;
        Tue, 21 Mar 2023 11:04:36 -0700 (PDT)
Received: from [192.168.0.26] (2a02-8388-6582-fe80-0000-0000-0000-000c.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::c])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id C1CCAD2527;
        Tue, 21 Mar 2023 18:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1679421843; bh=5u5RK79Jrz0TBa1bTYB32sizDkDbXxklAK67+f4BZ34=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=dujKG9pTEZv9CncCoa4UTKFYmS81sXmsgDVTRmJWmAPSFdeSdqQHOf0psqRTR+AJp
         X6CMBMQ2iOEEkkg4yAl0e2jGR9IJJQQd76MWO0cWIKNncxIiGeNBZVSlCgW/uTO0Aj
         ouG669uOHbusr7lm5OY0hWmeFBe+DBhGJ4Wyuw2c=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 21 Mar 2023 19:03:56 +0100
Subject: [PATCH v3 2/3] media: dt-bindings: ov2685: convert to dtschema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230129-ov2685-improvements-v3-2-d9737d0707f6@z3ntu.xyz>
References: <20230129-ov2685-improvements-v3-0-d9737d0707f6@z3ntu.xyz>
In-Reply-To: <20230129-ov2685-improvements-v3-0-d9737d0707f6@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5125; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=5u5RK79Jrz0TBa1bTYB32sizDkDbXxklAK67+f4BZ34=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkGfGPGp8DcHqi37+69gOQ7MUJboxTIdu+MerR0
 wuzV5jey2aJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZBnxjwAKCRBy2EO4nU3X
 Vu11D/0W0PRwBlB2MF5OuNRkTQiM4V2NIrBcHbqlJeBeeg9uxtuwkx2TT7gqLmFQbEclTewvCwJ
 rkVqe2t5QVRs8kLWti8hANPFjg978NJqk2/dk4EckKIjsPAvA1C643ahnRffXG3BdaVddTT4hcj
 Ej2J4sqyS4xQw4Mhfas0G13iDnjqwY94F2oGY/c7bvcADkFoZsiIC12QNH9O5DDspwZ7gcyqdSy
 XB2tf+vGQlmg7q2Xdia+ugVfBAAE1vGUzWXHlBPhLTdNRsYwYGvZTKvydlXVDBjM2tI0itanGHu
 8p33JuhQUBuOTM+oNjb4AED33qmFTAlC7Vp5/+LmUOeZshme51inlx9ph4K1WDl3KA9g5mVgdHY
 zbsT9O+EOCZwJ6QuS4Wkqr763jXwyiwmwRD4CSf9+dE4/91FdBqajrOixwj21Dx79i6Cl2h9V3t
 nSKwhVnE4tUkAz7RF6oGPbDFx97sE1hHwvG/icrbCk2P0AUNPH0PGbOzHq43GM5eyZQFOzbGFhU
 Y40dlIg3gauiuhCDMy/6NhsqiIdBbB2911Xmvymqk36d0CwJq00wkSSf/1YlgkMZo+cztv6SBna
 YkRi9YmHA9Oo4wKal9SqrfRBqmRZHTAservvRr4/jrfjuzjFRWNAZIfliOA3XM8M6h5xVed5KnD
 67tpHConqDaeFSQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 0000000000000..c53bee4a1025e
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
+    i2c7 {
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

