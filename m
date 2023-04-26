Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373F66EF3DB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 13:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240712AbjDZL54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 07:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240680AbjDZL5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 07:57:53 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6901FD3;
        Wed, 26 Apr 2023 04:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1682510272;
  x=1714046272;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=UrVPi9iavO/29AvSYL2Oe59H3w4J+MhU9zUYa5TBKuQ=;
  b=OO2KIU/Gy71HxJJ8ruD8BxqyJbPQNQoPXnJSN7I6Ei8HuKL7xtfdVTpy
   zZZLbAmb3+phR9vmyl+q8yGfMQZXd1xDhgwiftlyTAOY8r+D0H1/yf695
   TyynIR+Lz5y2XF5bmQx8wTd/Ced8Pr83sQvcPZnccFdjyJGzlyCdsmCVG
   Hzca4TCj03yGAvoZ9x1t8BlpsKxPoLIgznZ5os8FCM4HedbTYfWE9rAJV
   CPc8+faZ2oiwyxbpFLSi5PAq2eBggyuovi3uxeTD9OOWP6gtbgDBRnnD6
   H3mLEN9vjJ8YiUAn0VKcEw+0IcO+m8xXJO/hcuk/hNotlxpwLiqT8qtID
   Q==;
From:   Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Date:   Wed, 26 Apr 2023 13:57:29 +0200
Subject: [PATCH v3 1/2] dt-bindings: iio: light: Document TI OPT4001 light
 sensor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230323-add-opt4001-driver-v3-1-62e121dab294@axis.com>
References: <20230323-add-opt4001-driver-v3-0-62e121dab294@axis.com>
In-Reply-To: <20230323-add-opt4001-driver-v3-0-62e121dab294@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        <kernel@axis.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for opt4001 ambient light sensor.

Signed-off-by: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
---
 .../devicetree/bindings/iio/light/ti,opt4001.yaml  | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml b/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml
new file mode 100644
index 000000000000..12b0c7ed5d72
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/ti,opt4001.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments OPT4001 Ambient Light Sensor
+
+maintainers:
+  - Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
+
+description:
+  Ambient light sensor with an i2c interface.
+  Last part of compatible is for the packaging used.
+  Picostar is a 4 pinned SMT and sot-5x3 is a 8 pinned SOT.
+  https://www.ti.com/lit/gpn/opt4001
+
+properties:
+  compatible:
+    enum:
+      - ti,opt4001-picostar
+      - ti,opt4001-sot-5x3
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,opt4001-sot-5x3
+    then:
+      properties:
+        interrupts:
+          maxItems: 1
+    else:
+      properties:
+        interrupts: false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@44 {
+            compatible = "ti,opt4001-sot-5x3";
+            reg = <0x44>;
+            vdd-supply = <&vdd_reg>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
+...

-- 
2.30.2

