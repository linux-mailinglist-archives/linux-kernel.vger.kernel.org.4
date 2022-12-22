Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8465865474B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbiLVUh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLVUhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:37:02 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C65621894;
        Thu, 22 Dec 2022 12:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ej6LVKbQpk0o5LdJOZQe5gi65ihCvncWUljJQhBVUHc=; b=bqiqldOE74teJr5S0e9HAb6m0q
        7lRBBHvwsgJbkXm2ingFWa8ga4xyj2BBQMLWcmgZI/VggoGiuYSi2SLNoNbJufRsYjdkODyXFHkae
        o23rNqG6yGjImSXo3C6wIX/FYPcMW/CotJM+5s6BvYjYalEb1oVfcfujb0q192rekKnw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48920 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1p8SJC-000070-Cz; Thu, 22 Dec 2022 15:36:54 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     hvilleneuve@dimonoff.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com
Date:   Thu, 22 Dec 2022 15:36:10 -0500
Message-Id: <20221222203610.2571287-4-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221222203610.2571287-1-hugo@hugovil.com>
References: <20221222203610.2571287-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v1 3/3] dt-bindings: iio: adc: add ADS7924
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add device tree bindings document for the Texas Instruments ADS7924
ADC.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 .../bindings/iio/adc/ti,ads7924.yaml          | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
new file mode 100644
index 000000000000..5408ec95e417
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads7924.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI ADS7924 4 channels 12 bits I2C analog to digital converter
+
+maintainers:
+  - Hugo Villeneuve <hvilleneuve@dimonoff.com>
+
+description: |
+  Texas Instruments ADS7924 4 channels 12 bits I2C analog to digital converter
+
+  Specifications:
+    https://www.ti.com/lit/gpn/ads7924
+
+properties:
+  compatible:
+    const: ti,ads7924
+
+  vref-supply:
+    description:
+      The regulator supply for the ADC reference voltage (AVDD)
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      GPIO used for controlling the reset pin
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+patternProperties:
+  "^channel@[0-3]+$":
+    type: object
+    description:
+      Child nodes needed for each channel that the platform uses.
+
+    properties:
+      reg:
+        description: |
+          0: Voltage over AIN0 and GND.
+          1: Voltage over AIN1 and GND.
+          2: Voltage over AIN2 and GND.
+          3: Voltage over AIN3 and GND.
+        items:
+          - minimum: 0
+            maximum: 3
+
+    required:
+      - reg
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@48 {
+            compatible = "ti,ads7924";
+            reg = <0x48>;
+            vref-supply = <&ads7924_reg>;
+            reset-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            channel@0 {
+              reg = <0>;
+              label = "CH0";
+            };
+            channel@1 {
+              reg = <1>;
+              label = "CH1";
+            };
+            channel@2 {
+              reg = <2>;
+              label = "CH2";
+            };
+            channel@3 {
+              reg = <3>;
+              label = "CH3";
+            };
+        };
+    };
+...
-- 
2.30.2

