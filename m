Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EC9709BEB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjESQCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjESQB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:01:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C31FFE;
        Fri, 19 May 2023 09:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684512116; x=1716048116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VqXRgbG9sAVE8Xa7fYxgTwr3Vh6RDXRnIzLEJQPzD+c=;
  b=azY5NpTzgGSPm5reSQmugU/xmEfmRa6lIEWwfd0d3vyCCf+53bVgx3D5
   IPpEmrdqPRnTJb3NkGc2eIdtWQDN3yV6TNdtpZ5+VSFpe54E1YxctwN19
   wdm+kzzYvx/Bj9C/ip282kOoMrsrcTncPgrgyFL3L4avFH9VP2ofKUzOr
   H8gUZ0j4Ao4MQVDj41zuhKsG2TWHbMFdm86vwQsYhPRVFEiu6sFlaGhXy
   B0JqKurYUk9jC8dp85vA57XeI92KJjZ4H4PIWL5y+SGSDDs+brJFM3wcW
   ZI7ExcOa7o053vpkAEhgy8nN94MBvBFYdtz3DzknwpYKXwgbxObo3b8DN
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="152988642"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2023 09:01:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 19 May 2023 09:01:55 -0700
Received: from marius-VM.mshome.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 19 May 2023 09:01:53 -0700
From:   <marius.cristea@microchip.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marius.cristea@microchip.com>
Subject: [PATCH 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Date:   Fri, 19 May 2023 19:01:44 +0300
Message-ID: <20230519160145.44208-2-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519160145.44208-1-marius.cristea@microchip.com>
References: <20230519160145.44208-1-marius.cristea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marius Cristea <marius.cristea@microchip.com>

This is the device tree schema for iio driver for
Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
Delta-Sigma ADCs with an SPI interface.

Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
 .../bindings/iio/adc/microchip,mcp3564.yaml   | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
new file mode 100644
index 000000000000..407a125e3776
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/microchip,mcp3564.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP346X and MCP356X ADC Family
+
+maintainers:
+  - Marius Cristea <marius.cristea@microchip.com>
+
+description: |
+   Bindings for the Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
+   Delta-Sigma ADCs with an SPI interface.
+
+properties:
+  compatible:
+    enum:
+      - microchip,mcp3461
+      - microchip,mcp3462
+      - microchip,mcp3464
+      - microchip,mcp3461r
+      - microchip,mcp3462r
+      - microchip,mcp3464r
+      - microchip,mcp3561
+      - microchip,mcp3562
+      - microchip,mcp3564
+      - microchip,mcp3561r
+      - microchip,mcp3562r
+      - microchip,mcp3564r
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  spi-cpha: true
+
+  spi-cpol: true
+
+  vref-supply:
+    description:
+      Some devices have a specific reference voltage supplied on a different
+      pin to the other supplies. Needed to be able to establish channel scaling
+      unless there is also an internal reference available (e.g. mcp3564r)
+
+  microchip,hw-device-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 3
+    description:
+      The address is set on a per-device basis by fuses in the factory,
+      configured on request. If not requested, the fuses are set for 0x1.
+      The device address is part of the device markings to avoid
+      potential confusion. This address is coded on two bits, so four possible
+      addresses are available when multiple devices are present on the same
+      SPI bus with only one Chip Select line for all devices.
+
+  "#io-channel-cells":
+    const: 1
+
+dependencies:
+  spi-cpol: [ spi-cpha ]
+  spi-cpha: [ spi-cpol ]
+
+required:
+  - compatible
+  - microchip,hw-device-address
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "microchip,mcp3564r";
+            reg = <0>;
+            vref-supply = <&vref_reg>;
+            spi-cpha;
+            spi-cpol;
+            spi-max-frequency = <10000000>;
+            microchip,hw-device-address = <1>;
+        };
+    };
+...
-- 
2.34.1

