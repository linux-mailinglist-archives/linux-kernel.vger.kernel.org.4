Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197436F83FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjEEN1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjEEN1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:27:25 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6B420767;
        Fri,  5 May 2023 06:27:21 -0700 (PDT)
Received: from localhost ([31.220.113.235]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M8hR1-1pqGgV1Qi9-004gLy; Fri, 05 May 2023 15:21:46 +0200
Date:   Fri, 5 May 2023 15:21:45 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: iio: pressure: Support Honeywell
 mprls0025pa sensor
Message-ID: <ZFUC6Tsku+aWod/+@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFUCf059+PSR+3Wb@arbad>
X-Provags-ID: V03:K1:cYa62qAIQtXMQaeBxNgRUZ2mXLjZuRGeyeLNGp6XVBbHQtwLz/T
 WQb4XaYQE+hnSIOQoUTUz47txwbOrNvHZJgwGO27ihnkb18Sytcf1FKsGQ4D8ZAp2aWkGHF
 DcwwqkCX/M4l2dFL+gPq+yPf7BQubi16nT3nLJNbcXRtxuy7q/QFCMgEd7sLRXTP7SyOBL1
 nZ3Ws8W8rp+g2ZmaDGvqQ==
UI-OutboundReport: notjunk:1;M01:P0:xCr59qoWid0=;xirPOBJiejEOLIPv2MEJwHzwnln
 kdEj1vs7vyy6lai4N2SVStOfyZMvGqUE46FHBqrxMl6a9XWsx0egKlMTtM+Hx4pbN/JBGFIHL
 fsEP/fQBKC2KLboCYyMrAoq0mjWQy6mEoE2S4UNgE3KtsQ4FT5It0IVc0IyAbpQW+QBDfS3m1
 qQdE5XyFWSw7CSe9w/n2jYpR4y9ABAZ1nPA8tc/9LgVpqJ3gMztd9eY0a0YAZ2/2FGn0xNGW/
 CpSqFnYHzaZ/KUuSCFzmkm5p9M/Op5k95YtQ3ZMjQxshqMPVJK3mLeYo6hbDesKtAH3zlyrGf
 jHlYzLGorSKOoMH9HGgm9Wq6A8+VlCNDfXFUljtKXVpG/cJ0CWv6uTAQJEmSgKmIEJ6F1bU+s
 HHffgIi6EIGdKIsgDKLaHTpDhddVc9e9E+sskGASCYLcmdB5ASm3RNO8LoK3458oe8InBfoRw
 I5qWqwpWRXUcSlHo38JSinm6ySCepMLNJll7LPyBEFkUi4knnKYGBGpwxaM2u+NvQrU9Xoaju
 r/QE31CImAsz7rWSyONpLjzOF5Jcn3PRGZ54QRXOMBDAEnFhaCfTwW+Vd7yg0Eh5IxJur21W1
 2G+EhMSUTGXb5csh0lEOfWBlkBy2EFaTwYnTCflY6e+rK4Eb3TiXm06nkdIJ0ZoqCltKX/nIf
 WTzE/PIpTCjDaL3pXme26RzDEBKOUVLLNAunrbrr1w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Honeywell mprls0025pa is a pressure sensor series. There are many
different models with different pressure ranges, units and transfer
functions.

The range and transfer function need to be set up in the dt. Therefore
new properties honeywell,pmin-pascal, honeywell,pmax-pascal,
honeywell,transfer-function are introduced.

Add dt-bindings.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../iio/pressure/honeywell,mprls0025pa.yaml   | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
new file mode 100644
index 000000000000..84a61721b597
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/honeywell,mprls0025pa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Honeywell mprls0025pa pressure sensor
+
+maintainers:
+  - Andreas Klinger <ak@it-klinger.de>
+
+description: |
+  Honeywell pressure sensor of model mprls0025pa.
+
+  This sensor has an I2C and SPI interface. Only the I2C interface is
+  implemented.
+
+  There are many models with different pressure ranges available. The vendor
+  calls them "mpr series". All of them have the identical programming model and
+  differ in the pressure range, unit and transfer function.
+
+  To support different models one need to specify the pressure range as well as
+  the transfer function. Pressure range needs to be converted from its unit to
+  pascal.
+
+  The transfer function defines the ranges of numerical values delivered by the
+  sensor. The minimal range value stands for the minimum pressure and the
+  maximum value also for the maximum pressure with linear relation inside the
+  range.
+
+  Specifications about the devices can be found at:
+    https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/
+      products/sensors/pressure-sensors/board-mount-pressure-sensors/
+      micropressure-mpr-series/documents/
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
+      Transfer function which defines the range of valid values delivered by the
+      sensor.
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
+  - honeywell,pmax-pascal
+  - honeywell,pmin-pascal
+  - honeywell,transfer-function
+  - reg
+  - vdd-supply
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
