Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACDE6E239F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjDNMsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjDNMsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:48:42 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2AC4C22;
        Fri, 14 Apr 2023 05:48:40 -0700 (PDT)
Received: from localhost ([31.220.114.184]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MlfGs-1qEQ8o3ifS-00ii4T; Fri, 14 Apr 2023 14:48:24 +0200
Date:   Fri, 14 Apr 2023 14:48:24 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] dt-bindings: iio: pressure: Support Honeywell
 mprls0025pa sensor
Message-ID: <ZDlLmCIiKSMa7Hah@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDlLPtAZfxvXMkD8@arbad>
X-Provags-ID: V03:K1:Tv4Uj43tBiLUN/+GvGnh3KM+1ohOAeIovYx/hFuC6+icGfcNEyA
 Xlpc6JXBaZm/qoOFkjLzvNzCNx3+uhR1pkd+6FOem/yzzR91G2wMM5Z/zP2FhyyfB1RfPMy
 gbd0Jlz0knQkOC5K3BtgV204ocngKwCJZa2PNKJv+aDVySFEA5YbZXV2lsL7Eb2WIro8Zui
 lLt0NngDkknxVVKMBbFYg==
UI-OutboundReport: notjunk:1;M01:P0:CHfuDGbEL0M=;eRHv0Aj5JIK39b1i5gNfq/YvBqm
 8UNdPvsZ9pLAxf1r62xiGiAFMeDGHvqreHb0NMJQb0rBPeB2DBC2K9Q6GR70ThEXUurKz0tk7
 abXolhL4rOv2BZ0RU976sSZ0pyHh37vjJWdEHRBXwmT1FLC7JwI1/yuTAVJ3zRygyFsefupQI
 aGQ4LGt2etkYHGvxwHuOWljB2gYx2zzv6ZwEn45wHdKGHksVr1e2RHD23FuH0Hv+cUlLekRN4
 JCk6P3FCTV+PzINkI9/UB5JlTVRxEgaLjapFkLIMnGugoE5UieyqXp42fYRIgyH1TPQJJDY3x
 y46RglFKKMMxIOb0PyYIvZ538Ju27htlKFMd391OXK9YwC1MLKs7rGTuNrixHL/ecb7XY1q+v
 kxOZ5t2Way06lXM1wRkXwo5wtds/c9hrWTA3DgbqaoNQqJZm63sbv5SrSuzLg8bNq3WIx9Obr
 5ut1ZZZ5wctbeENJ4FhI6xz/GY7/WGLMzaLwcxYvyY4VJRYCl4aLHHtBd7Cn9uniTkJlIR78Y
 h2K7AP7DOQk6n55KLIF6D2uCzn8pvXdMep01Ssyzix/l/4RIqE+bqqf0d1mxzho+t9F44/5WG
 BUrP1za7BzLePfZHaDMe/970lVqaRRZHX9hQvFjQ0tMIO+prv0IeDeYVvVGOdCi+rUh47nihw
 9xfzlVS8+V8syY84dfC/CDyOV/5lQikWvgfhVMQt0A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Honeywell mpr is a pressure sensor series. There are many different models with different pressure
ranges, units and transfer functions.

The range and transfer function need to be set up in the dt. Therefore new properties
honeywell,pmin-pascal, honeywell,pmax-pascal, honeywell,transfer-function are introduced.

Add dt-bindings.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../iio/pressure/honeywell,mprls0025pa.yaml   | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
new file mode 100644
index 000000000000..c0eb3c4be16f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
@@ -0,0 +1,93 @@
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
+
+required:
+  - compatible
+  - reg
+  - honeywell,pmin
+  - honeywell,pmax
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
+            honeywell,pmin = <0>;
+            honeywell,pmax = <172369>;
+            honeywell,transfer-function = <1>;
+        };
+    };
-- 
2.30.2
