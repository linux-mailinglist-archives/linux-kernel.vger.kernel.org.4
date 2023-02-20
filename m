Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A0E69CB17
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjBTMd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjBTMdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:33:23 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC20F18AA0;
        Mon, 20 Feb 2023 04:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676896395; x=1708432395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2BIAQ53336CCXN9OBVQo/sD5j8P7KTcQ7EfjU99FKxU=;
  b=heUUJgecAsXGPrGGZIvoc4Uv2Zc0VDuABCPK0VDj9x3ORO1iQwcYY++q
   H/5hgMok6CNX+2v0bYMwi4LGS9IJSqyoZP6ZpycVeDbuhHoPeBrlbwY/E
   Z+Z+hOH0JNle01ax+dNxXTCe4naZFPzaIEZlrxQRrpITlqmjcPsl2hOVA
   RD//YvkfT3jZ6R6SsPWq4nWy+sJtuAZ7IQw5iKY9tKyQKynKr9brjwVq+
   boyj6N0Gjxff9R8aM3JQbtRx6z3z35Rb7NhcmU+1V87LlOvA8/W6yCtqs
   zUEDFhG2hMKZ1tyJNqFfWtSeNj3q8fD3NGzOV/VrAbcJPOAScca9F6lnO
   g==;
X-IronPort-AV: E=Sophos;i="5.97,312,1669100400"; 
   d="scan'208";a="201722511"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Feb 2023 05:33:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 05:32:56 -0700
Received: from marius-VM.mshome.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 20 Feb 2023 05:32:54 -0700
From:   <marius.cristea@microchip.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marius.cristea@microchip.com>
Subject: [PATCH v1 1/2] dt-bindings: iio: adc: adding dt-bindings for PAC193X
Date:   Mon, 20 Feb 2023 14:32:31 +0200
Message-ID: <20230220123232.413029-2-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220123232.413029-1-marius.cristea@microchip.com>
References: <20230220123232.413029-1-marius.cristea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marius Cristea <marius.cristea@microchip.com>

This is the device tree schema for iio driver for
Microchip PAC193X series of Power Monitors with Accumulator.

Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
 .../bindings/iio/adc/microchip,pac193x.yaml   | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac193x.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac193x.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac193x.yaml
new file mode 100644
index 000000000000..e4ea560991e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac193x.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/microchip,pac193x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PAC193X Power Monitors with Accumulator
+
+maintainers:
+  - Marius Cristea <marius.cristea@microchip.com>
+
+properties:
+  compatible:
+    enum:
+      - microchip,pac1934
+      - microchip,pac1933
+      - microchip,pac1932
+      - microchip,pac1931
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  microchip,samp-rate:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Sampling rate for all device's channels.
+    enum: [8, 64, 256, 1024]
+    default: 1024
+
+required:
+  - compatible
+  - reg
+  - microchip,samp-rate
+  - "#address-cells"
+  - "#size-cells"
+
+patternProperties:
+  "^channel([1-4])@[1-4]+$":
+    $ref: "adc.yaml"
+    type: object
+    description: Represents the external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        description: The channel number.
+          It can have up to 4 channels, numbered from 1 to 4.
+        items:
+          - minimum: 1
+            maximum: 4
+
+      microchip,uohms-shunt-res:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          Value in micro Ohms of the shunt resistor connected between
+          the SENSE+ and SENSE- inputs, across which the current is measured. Value
+          is needed to compute the scaling of the measured current.
+
+      microchip,rail-name:
+        $ref: /schemas/types.yaml#/definitions/string
+        description: Name of the monitored power rail.
+
+      microchip,bi-directional:
+        description: Whether the channel is bi-directional.
+        type: boolean
+
+    required:
+      - reg
+      - microchip,uohms-shunt-res
+      - microchip,rail-name
+
+    additionalProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pac193x: pac193x@10 {
+            compatible = "microchip,pac1934";
+            reg = <0x10>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+            microchip,samp-rate = <64>;
+
+            channel1@1 {
+                reg = <0x1>;
+                microchip,uohms-shunt-res = <24900000>;
+                microchip,rail-name = "CPU";
+            };
+
+            channel2@2 {
+                reg = <0x2>;
+                microchip,uohms-shunt-res = <49900000>;
+                microchip,rail-name = "GPU";
+            };
+
+            channel3@3 {
+                reg = <0x3>;
+                microchip,uohms-shunt-res = <75000000>;
+                microchip,rail-name = "MEM";
+                microchip,bi-directional;
+            };
+
+            channel4@4 {
+                reg = <0x4>;
+                microchip,uohms-shunt-res = <100000000>;
+                microchip,rail-name = "NET";
+                microchip,bi-directional;
+            };
+        };
+    };
+
+...
-- 
2.34.1

