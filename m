Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E4A68C795
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjBFUXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjBFUXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:23:33 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9534917CFF;
        Mon,  6 Feb 2023 12:23:32 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id E4978CD5E5;
        Mon,  6 Feb 2023 20:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1675715011; bh=y9+LNvytHx45ZXahQcbCuN9gP03/f6UYg1OC+YD/nWo=;
        h=From:Date:Subject:To:Cc;
        b=x7Dk5i5TGfQhCYi0Anj3N9ZZnbKcJTlnRVS8XP3e9POLw6cxBDYVrqIwiA2CX3xPZ
         qLe+TT98rml8EkfBx1fWnrO7S+ujoVM/EqREm5VJw5kJEAZmiRy4CBQ/6D/7GaLeC5
         ezzGxA2tZ2nG3AEqPxft0oNSP9iaBSjT3cO3Ii9E=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Mon, 06 Feb 2023 21:23:16 +0100
Subject: [PATCH] media: dt-bindings: ov2685: convert to dtschema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230206-ov2685-dtschema-v1-1-9e4da3474c10@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIALNh4WMC/x2NQQ6CMBAAv0L27JJSSkW/Yjws29X20CKtIRrC3
 y0eJ5nJbFAkBylwbTbIsoYS5lShOzXAntJTMLjKoJXulVYW51XbcUD3LuwlErqeDWl2huwAtZq
 oCE6ZEvujW3iOGEscL2eDtu3aLzJFyaQP+ZXlET7//e2+7z/UqpIXjgAAAA==
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5267; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=y9+LNvytHx45ZXahQcbCuN9gP03/f6UYg1OC+YD/nWo=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBj4WHBOThzVFER8dVB+XZ5hbF84+Q+UR9522PcO
 ky41GWtPkOJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY+FhwQAKCRBy2EO4nU3X
 VpN7EADD5U6Wmq1auJAFvNa6mmjmc4YyNQOsfExSNwteHmVjipfHIEUyAkAPJ98tEvpARCqgXxU
 T5t3vWu/SmumqrXH1lduv27ZQsUXmwJyB/1y1IdxQaCU1lzJ7xv3T9j9s7k71+R2g4WkojA+aGC
 GOBzzo4M5Yl9JlH8rXBqzVX/f5G04c0+5sHcXiS4K3N3VykyZamvKcQhM7kTN/Lo0bcDLRJ6KfE
 vGBvdWgYnRnVq6HV2Cc5AyS890rfXT8aEwsU3IXNEgrARhr53t2KcGEz8RarQxWkEK6RlClkqfG
 YnFxegNumh0oab6mCTDau/Bd+HmtTz82TsQUoL8V3LTj4GbS03b020wbZKWHZiODSpTXwPZEQ0m
 QwxhPhxxLLNmatbtQWS4ut3MTsdMfHru9QCQ7cYMQid1cbkFbNgDrE8ooTK8oFAk5AnKl1rPp92
 vdZwjf2i/8cB+7MtN4F5KE/E3uxzOapo1LNG3tt7/IlRe81TUNY56TPsyDBch2r3Ap9ZiHNErGT
 lTq2GxHxRU8Awbh45HI6ktBKs7y4BA7z6YsWyGnTKvwi/2UdTePOYS4C/528CkoREdqQ8vZTQNG
 lZugR/bHIHBH0aKfZo9/SP7IimGP0i3f5AUg9E6A9x87THf+Mz25hs9WSFxKHe0GuRbp+AYlfBw
 AbXSiVZsa+QBH1Q==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 625c4a8c0d53..000000000000
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
index 000000000000..c53bee4a1025
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
index f76ca2808474..e660a4e1f74c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15327,6 +15327,7 @@ M:	Shunqian Zheng <zhengsq@rock-chips.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
 F:	drivers/media/i2c/ov2685.c
 
 OMNIVISION OV2740 SENSOR DRIVER

---
base-commit: 129af770823407ee115a56c69a04b440fd2fbe61
change-id: 20230206-ov2685-dtschema-d3c4a2cd4a65

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

