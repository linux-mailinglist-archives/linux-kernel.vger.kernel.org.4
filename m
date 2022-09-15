Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DAE5B97D0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiIOJpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiIOJpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:45:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBECD98D2B;
        Thu, 15 Sep 2022 02:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663235118; x=1694771118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nOP4ZHdIWs++u3mpbKYQi7MLVPQO97aBnLJoITbfIx8=;
  b=sf/bw8kp5YojcfHj7THPjwqjwfz+GrV7QtDpCh2jCYH/giemV2HZ80cL
   NRuCMTOGaP9N0lyO0JOOQNikYo/aUYEi54N6w9WmX0gFJpitQEssWf1E7
   U0jDkVscWzC6anFzH3clMSMn6h9OxB7sjmgbV1uNQYF9r79N6fouFxzQE
   EUwJNixnniBzK6n9RkLLi/1ops98QtB49qUNQdngnjXUCMZ0MAoZMOSjh
   gxKnrn2A3LCAGp6uxt3iRMMhq/g/IkYYcLYznOvZzaKZhJDAe37tAev/8
   VfkgDPd9An2ovAfae0na8vadb5SqT/Y1l6bFlhoNfIgjTgFgKcqLr/V14
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="177279014"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2022 02:45:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 15 Sep 2022 02:45:15 -0700
Received: from kavya.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Thu, 15 Sep 2022 02:45:11 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <lee@kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v8 1/3] dt-bindings: mfd: Convert atmel-flexcom to json-schema
Date:   Thu, 15 Sep 2022 07:44:51 -0200
Message-ID: <20220915094453.1872798-2-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915094453.1872798-1-kavyasree.kotagiri@microchip.com>
References: <20220915094453.1872798-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Atmel flexcom device tree bindings to json schema.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changing reference to SPI yaml bindings is covered in below patch series:
https://lore.kernel.org/linux-arm-kernel/20220913142205.162399-6-sergiu.moga@microchip.com/
https://lore.kernel.org/linux-arm-kernel/dad37ca0-a44b-59ec-0be9-fb121de12244@linaro.org/

v7 -> v8:
 - Added back patternProperties for child nodes.

v6 -> v7:
 - Change filename to atmel,sama5d2-flexcom.yaml
 - Add #address-cells, #size-cells to flexcom node - Fixed warnings.

v5 -> v6:
 - Removed spi node from example as suggested by Rob and
   also pattern properties(spi dt-bindings conversion to yaml patch is under review).
   Once that is accepted, I will add back spi example through new patch.

v4 -> v5:
 - Fixed indentations.

v3 -> v4:
 - Corrected format of enum used for compatible string.

v2 -> v3:
 - used enum for compatible string.
 - changed irq flag to IRQ_TYPE_LEVEL_HIGH in example.
 - fixed dtschema errors.

v1 -> v2:
 - Fix title.

 .../bindings/mfd/atmel,sama5d2-flexcom.yaml   | 92 +++++++++++++++++++
 .../devicetree/bindings/mfd/atmel-flexcom.txt | 63 -------------
 2 files changed, 92 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt

diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
new file mode 100644
index 000000000000..bfa7d340a198
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/atmel,sama5d2-flexcom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel Flexcom (Flexible Serial Communication Unit)
+
+maintainers:
+  - Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
+
+description:
+  The Atmel Flexcom is just a wrapper which embeds a SPI controller,
+  an I2C controller and an USART. Only one function can be used at a
+  time and is chosen at boot time according to the device tree.
+
+properties:
+  compatible:
+    enum:
+      - atmel,sama5d2-flexcom
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges:
+    description:
+      One range for the full I/O register region. (including USART,
+      TWI and SPI registers).
+    items:
+      maxItems: 3
+
+  atmel,flexcom-mode:
+    description: |
+      Specifies the flexcom mode as follows:
+      1: USART
+      2: SPI
+      3: I2C.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 3]
+
+patternProperties:
+  "^serial@[0-9a-f]+$":
+    type: object
+    description:
+      Child node describing USART. See atmel-usart.txt for details
+      of USART bindings.
+
+  "^spi@[0-9a-f]+$":
+    type: object
+    description:
+      Child node describing SPI. See ../spi/spi_atmel.txt for details
+      of SPI bindings.
+
+  "^i2c@[0-9a-f]+$":
+    $ref: ../i2c/atmel,at91sam-i2c.yaml
+    description:
+      Child node describing I2C.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+  - atmel,flexcom-mode
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    flx0: flexcom@f8034000 {
+        compatible = "atmel,sama5d2-flexcom";
+        reg = <0xf8034000 0x200>;
+        clocks = <&flx0_clk>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0xf8034000 0x800>;
+        atmel,flexcom-mode = <2>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
deleted file mode 100644
index 9d837535637b..000000000000
--- a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
+++ /dev/null
@@ -1,63 +0,0 @@
-* Device tree bindings for Atmel Flexcom (Flexible Serial Communication Unit)
-
-The Atmel Flexcom is just a wrapper which embeds a SPI controller, an I2C
-controller and an USART. Only one function can be used at a time and is chosen
-at boot time according to the device tree.
-
-Required properties:
-- compatible:		Should be "atmel,sama5d2-flexcom"
-- reg:			Should be the offset/length value for Flexcom dedicated
-			I/O registers (without USART, TWI or SPI registers).
-- clocks:		Should be the Flexcom peripheral clock from PMC.
-- #address-cells:	Should be <1>
-- #size-cells:		Should be <1>
-- ranges:		Should be one range for the full I/O register region
-			(including USART, TWI and SPI registers).
-- atmel,flexcom-mode:	Should be one of the following values:
-			- <1> for USART
-			- <2> for SPI
-			- <3> for I2C
-
-Required child:
-A single available child device of type matching the "atmel,flexcom-mode"
-property.
-
-The phandle provided by the clocks property of the child is the same as one for
-the Flexcom parent.
-
-For other properties, please refer to the documentations of the respective
-device:
-- ../serial/atmel-usart.txt
-- ../spi/spi_atmel.txt
-- ../i2c/i2c-at91.txt
-
-Example:
-
-flexcom@f8034000 {
-	compatible = "atmel,sama5d2-flexcom";
-	reg = <0xf8034000 0x200>;
-	clocks = <&flx0_clk>;
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges = <0x0 0xf8034000 0x800>;
-	atmel,flexcom-mode = <2>;
-
-	spi@400 {
-		compatible = "atmel,at91rm9200-spi";
-		reg = <0x400 0x200>;
-		interrupts = <19 IRQ_TYPE_LEVEL_HIGH 7>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_flx0_default>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&flx0_clk>;
-		clock-names = "spi_clk";
-		atmel,fifo-size = <32>;
-
-		flash@0 {
-			compatible = "atmel,at25f512b";
-			reg = <0>;
-			spi-max-frequency = <20000000>;
-		};
-	};
-};
-- 
2.25.1

