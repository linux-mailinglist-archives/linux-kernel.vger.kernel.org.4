Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26986E9CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 22:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjDTUAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 16:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjDTUAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 16:00:37 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF62B2;
        Thu, 20 Apr 2023 13:00:35 -0700 (PDT)
Received: from localhost ([185.104.138.31]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MRmsG-1pjdMX0aeg-00TGVo; Thu, 20 Apr 2023 22:00:19 +0200
Date:   Thu, 20 Apr 2023 22:00:17 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: iio: pressure: Support Honeywell
 mprls0025pa sensor
Message-ID: <ZEGZ0Us/I40jLuB8@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEGZYiS0znC2/fZC@arbad>
X-Provags-ID: V03:K1:od/S/StQW+8naEwmfBOCIwpBDfScwCUIsHP4PLUJJEaQSGJ7H8/
 Cttp36xJbkyxxFZBYJHor4WXWjQybtbOTe4FxRm9ohTsAE2x5eflJbszBcxYTLLtQn7JdSW
 wteQpnHmjPZeK06RPZAqkjTKYFlIeqJu1hP1odAQ7gk1F+0Rt7HmBXHq4QAqlIK3vTlde8j
 v8F5PBy+95/ubL+dnfyTA==
UI-OutboundReport: notjunk:1;M01:P0:O5Rc7B6rpVs=;ARxTpB4DrOKaVaWha4T1ZYXbFnI
 01maoF46ilnextzqry2sP1+yMfwQn0ry8BxsArZfAvbdsxiBgVEn60ZapagdFScheNnyROYA1
 GvurYrxKICQ7Q03uCy4B+y+4QgaaqFvDdifUwfmc7LjGrA0XOHG9Wg1JeKCh18T9MGyZI1fd/
 I6Z/euLuxxDCVOvIivxR9EXVcNLu4ZylJsrTf28cGLwhqhE2wXCdGyya/p7sZsZNmdeCNynOv
 LouHARcZpkYRroqx0UuM3CS1sH1mLoMHTUuGP/wCqdcJ+zFmo/JMgqfuD6XccykseJI0nN7QI
 +7WJAHCbN47y5uza1BHo16IfaFsmGTQNki6yBrZ46+TJTmzdrlj3u8P9k1uHHnoNc1bkIqD8b
 VMGGkPkVeqpsY4I2tE+QtAFTPUUOUhvzeWrEULxTE++m+h4hUTY2vYo4JempN4MWDCN9niHVW
 hl6bJL3cRcjnaSVivGQxgo3czfDSafIpQHY+882zCGDD/JwIVJGfwMf1kgdHxpRCUGA1Rkxo7
 jPupVpn0Vn8doTnQk3XEq+pIAUOWoU0w9C5UH+ar7EMqoBdD08qP5rlhOmH49/X8fekVpw9sK
 ybFd3OvZiWU9piD81oHZaCg7OgzocHC7Spgq+rs7On9yCG9y7vgFz4pR/gpkJ0BDz5zTINMkg
 R8xmKd344F8cJ18ozuhMOOjPK/ZedXZwd6YQFLOXaQ==
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Honeywell mpr is a pressure sensor series. There are many different models
with different pressure ranges, units and transfer functions.

The range and transfer function need to be set up in the dt. Therefore new
properties honeywell,pmin-pascal, honeywell,pmax-pascal,
honeywell,transfer-function are introduced.

Add dt-bindings.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../iio/pressure/honeywell,mprls0025pa.yaml   | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
new file mode 100644
index 000000000000..80ab1beac7f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/honeywell,mprls0025pa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Honeywell mpr series pressure sensor
+
+maintainers:
+  - Andreas Klinger <ak@it-klinger.de>
+
+description: |
+  Honeywell pressure sensor of model mprls0025pa.
+
+  This sensor has an I2C and SPI interface. Only the I2C interface is implemented.
+
+  There are many models with different pressure ranges available. The vendor calls them "mpr
+  series". All of them have the identical programming model and differ in the pressure range, unit
+  and transfer function.
+
+  To support different models one need to specify the pressure range as well as the transfer
+  function. Pressure range needs to be converted from its unit to pascal.
+
+  The transfer function defines the ranges of numerical values delivered by the sensor. The minimal
+  range value stands for the minimum pressure and the maximum value also for the maximum pressure
+  with linear relation inside the range.
+
+  Specifications about the devices can be found at:
+    https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/
+      pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/
+      sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
+
+properties:
+  compatible:
+    const: honeywell,mprls0025pa
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      Optional GPIO for resetting the device.
+      If not present the device is not resetted during the probe.
+    maxItems: 1
+
+  honeywell,pmin-pascal:
+    description:
+      Minimum pressure value the sensor can measure in pascal.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  honeywell,pmax-pascal:
+    description:
+      Maximum pressure value the sensor can measure in pascal.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  honeywell,transfer-function:
+    description:
+      Transfer function which defines the range of valid values delivered by the sensor.
+      1 - A, 10% to 90% of 2^24 (1677722 .. 15099494)
+      2 - B, 2.5% to 22.5% of 2^24 (419430 .. 3774874)
+      3 - C, 20% to 80% of 2^24 (3355443 .. 13421773)
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  vdd-supply:
+    description: provide VDD power to the sensor.
+
+required:
+  - compatible
+  - reg
+  - honeywell,pmin-pascal
+  - honeywell,pmax-pascal
+  - honeywell,transfer-function
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pressure@18 {
+            compatible = "honeywell,mprls0025pa";
+            reg = <0x18>;
+            reset-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
+            interrupt-parent = <&gpio3>;
+            interrupts = <21 IRQ_TYPE_EDGE_FALLING>;
+            honeywell,pmin-pascal = <0>;
+            honeywell,pmax-pascal = <172369>;
+            honeywell,transfer-function = <1>;
+            vdd-supply = <&vcc_3v3>;
+        };
+    };
-- 
2.30.2
