Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286BC5F4488
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiJDNnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJDNnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:43:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77EE6575
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 06:43:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lgo@pengutronix.de>)
        id 1ofiCE-0002GH-3s; Tue, 04 Oct 2022 15:42:54 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1ofiCE-004Zk6-M3; Tue, 04 Oct 2022 15:42:53 +0200
Received: from lgo by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1ofiCC-00DCc1-G0; Tue, 04 Oct 2022 15:42:52 +0200
From:   =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
To:     =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        kernel@pengutronix.de, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings:iio:adc: add documentation for TI LMP92064 controller
Date:   Tue,  4 Oct 2022 15:42:37 +0200
Message-Id: <20221004134238.3144326-1-l.goehrs@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: lgo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the TI LMP92064 dual channel SPI ADC.

Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
---
 .../bindings/iio/adc/ti,lmp92064.yaml         | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml b/Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml
new file mode 100644
index 0000000000000..b7b5761baa108
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,lmp92064.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments LMP92064 Precision Current and Voltage Sensor.
+
+maintainers:
+  - Leonard Göhrs <l.goehrs@pengutronix.de>
+
+description: |
+  The LMP92064 is a two channel ADC intended for combined voltage and current
+  measurements.
+
+  The device contains two ADCs to allow simultaneous sampling of voltage and
+  current and thus of instantanious power consumption.
+
+properties:
+  compatible:
+    enum:
+      - ti,lmp92064
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  shunt-resistor:
+    description: |
+      Value of the shunt resistor (in µΩ) connected between INCP and INCN,
+      across which current is measured. Used to provide correct scaling of the
+      raw adc measurement.
+
+  reset-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - shunt-resistor
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,lmp92064";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            shunt-resistor = <15000>;
+            reset-gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
+        };
+    };
+...
-- 
2.30.2

