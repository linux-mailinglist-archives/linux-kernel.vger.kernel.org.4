Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E636D2F32
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 11:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjDAJKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 05:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDAJJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 05:09:59 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263631DF90;
        Sat,  1 Apr 2023 02:09:57 -0700 (PDT)
Received: from localhost ([31.220.113.145]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MnaTt-1q7NoG36yT-00jdqu; Sat, 01 Apr 2023 11:09:41 +0200
Date:   Sat, 1 Apr 2023 11:09:41 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: iio: pressure: Support Honeywell mpr sensors
Message-ID: <ZCf01btsJRXcIOce@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:jrxISjp/WYn3xx6h+1xLRW4H/q2L0sxDbQqI++IekSgJN0IQlEQ
 dgo53v3qqLRxGBvZHhuU2afeYi/gV1YNbJ8Hvfws4pwlMyUjFUi1FhO/NdGY3IRBaT0Zyin
 CK9usGtGtznGGWrTi7RynRHOxqa9TpHR5F2fLzT3gjaXRarcz29L6r7389nxu4hSKLryuuw
 ulsr9BwNkG/gsPdXPtr1A==
UI-OutboundReport: notjunk:1;M01:P0:cxwXQHVARjI=;d8r767XrWUpo0BuosYYvTc4eEVZ
 1MqIekCah1m6bKUd9Gdsqb6RP69r5DFVO6HwDYLog4wTaWiTLs9gqcspyxoru6BcHCVYoIbHD
 F05yvBDqcNRYQxuZSrnSwNdgstoqJJR02oib8N9a0n32sO0+qtrbphjQ0OMlmKQcmL07v+sMv
 e0h6mosg9C0Mp7dTZt2/sCHwLS7YQnmfH0m3vr8AmFZx/3OAb4Yat13EwenOMJy5vg0zScPlr
 fepTAzCSEFKZvSqvh34nHQ5ATa9mznqxGN8Lhd1Pg2gtY/JYFbjA2HUIyZ07fMllSHXNG8Rhg
 VgVpda2J8wK/Ys6ZLmbW4NmnKq9RUiKSwVV1NGxDMgKDEYnXW0taz9gYFL1yCXxccL/+HKZYt
 mMsdwfvYIYZeMe7i8zsWv8FSA5a/APVzZV0lbVaZXewijOyBhlNiK4d2hBYRijNDaXdo1HEzb
 gYiw9ostufwuy1FC57xVl33gsUmujv5Hn7ZCwUVVkSbiPQY5B+iNh0xxWb0iwPBrXcUIB7eMg
 BUmGpExfDzLsjcbC0TXyYGw2BzYetzaRacbK6AmC6Nk4+CT3dRwEINDLHJ+zDvyAQEEyLOPCV
 mr5nVGQ0Xeif9L3BtwVqtfFNRQEAWK7/F9mvxWJtVA3yJrkQAoIP+KYd6ivGc3Ek62ytO1/oe
 yQInh//sAehramM7VSqJCOlyiQju/jkyZfI+ituwwA==
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Honeywell mpr is a pressure sensor family. There are many different
types with different pressure ranges. The range needs to be set up in
the dt. Therefore new properties honeywell,pmin and honeywell,pmax are
introduced.

Add dt-bindings.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../bindings/iio/pressure/honeywell,mpr.yaml  | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml
new file mode 100644
index 000000000000..d6fad6f841cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/honeywell,mpr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Honeywell mpr pressure sensor
+
+maintainers:
+  - Andreas Klinger <ak@it-klinger.de>
+
+description: |
+  Honeywell pressure sensor of type mpr. This sensor has an I2C and SPI interface. Only the I2C
+  interface is implemented.
+
+  There are many subtypes with different pressure ranges available. Therefore the minimum and
+  maximum pressure values of the specific sensor needs to be specified in Pascal.
+
+  Specifications about the devices can be found at:
+    https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/  \
+      pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/          \
+      sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
+
+properties:
+  compatible:
+    const: honeywell,mpr
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      Optional GPIO for resetting the device. If not present the device is not resetted.
+    maxItems: 1
+
+  honeywell,pmin:
+    description:
+      Minimum pressure value the sensor can measure in pascal.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  honeywell,pmax:
+    description:
+      Maximum pressure value the sensor can measure in pascal.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - honeywell,pmin
+  - honeywell,pmax
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
+            compatible = "honeywell,mpr";
+            reg = <0x18>;
+            reset-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
+            interrupt-parent = <&gpio3>;
+            interrupts = <21 IRQ_TYPE_EDGE_FALLING>;
+            honeywell,pmin = <0>;
+            honeywell,pmax = <172369>;
+        };
+    };
-- 
2.30.2
