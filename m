Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04FF704C64
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjEPLce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjEPLcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:32:32 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BBD18E;
        Tue, 16 May 2023 04:32:31 -0700 (PDT)
Received: from localhost ([31.220.116.19]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M3D3N-1q1u790aZ3-003hzl; Tue, 16 May 2023 13:32:14 +0200
Date:   Tue, 16 May 2023 13:32:13 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] dt-bindings: iio: pressure: Support Honeywell
 mprls0025pa sensor
Message-ID: <ZGNpve4ux5KJ3BNQ@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGNpZM137jF5yzie@arbad>
X-Provags-ID: V03:K1:Vffq3MgGOTKI+sFsILoLHDUpq9prObFOT0t+R8yOKq5742j+KHO
 EIkiZUpSIvrsjHV2t0fC2XYNTD2p1mFd1KL0Nl0hAB2fbulRJIOYGAVdMMcCK2wBiklvcfT
 4ASWPPj+XWiDyjEOaI2YeMO6ReGGS14IDYS1MdtjqUGtbmG6ohpT126S2hCsp7mTS015+pu
 zD6xbvwz408IAHfh51BxQ==
UI-OutboundReport: notjunk:1;M01:P0:4XDL6aAvKGc=;mzMEevf4c7Z2YKmN6nQ7iH4T1ec
 KO7GyrZvVweVQUvrqDSSsYgRO64OPgMmybEJ7Ne31k73uzetcBWZBn8jpKpsIePqBVhyUDjuG
 Y1S7SXkMmymI15HDhRFbhjOVHKModLUGHQ9eCg0bdHvGy/H9A3AF+ODgMLavwvJz1YMKQmm5/
 srCmWYxdiKlKj6aGtPAcaUbu8oPuertkz4Nbm87dFqdbLJaB0GL9SGdoNB17rZUvq00YLiss+
 jmYbnODO6BNOnhP/UR86912PQaAUV9loyy7j/HHL0PXc6WkszDD9SPvCXIsmYmT8//w6ikScK
 jQIPTF0k+S6AltqYLC2tYDCEtMNJzLoYDuzDli+Dys68zREOVc20IOOK9UfBnA0EmRkPjjtLy
 6fIrxbFUXA9Ej23of7mYgm9E7WcQ66OVsRCgR9KPuXDlFAMvatF9pnxvKpy4mWiH5Mwjg/DES
 5pVmEpQxUIbNKrjNQ7Y8MdFRnaDDq8RvWbcisRUwmCUDPSLPk5m4ZoJ0oPnh88BLYMJwO38zh
 qLLiEAgwxSD9tcDTvFDDuTgSQBX/2lDgK3zVJn9vd/jMU5dF9Zv/DQ5Imnc/gtHkWL/JpeLk4
 1ZOgmmOCyLdIzv9JJtbBM831abRui39MNxOY+aF1LpyFLFCGxeVDpjB9wLm7PxdKJM3xahRxE
 vG/mQ88yFJerizl0F2mVsL201u1QeNargBf7jwJlVA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../iio/pressure/honeywell,mprls0025pa.yaml   | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
new file mode 100644
index 000000000000..c0a923febf13
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
+    description: |
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
+  - reg
+  - honeywell,pmin-pascal
+  - honeywell,pmax-pascal
+  - honeywell,transfer-function
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


-- 
Andreas Klinger
Grabenreith 27
84508 Burgkirchen
+49 8623 919966
ak@it-klinger.de
www.it-klinger.de
www.grabenreith.de
