Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5A566B2C0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 18:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjAORGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 12:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjAORGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 12:06:40 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4FC10413;
        Sun, 15 Jan 2023 09:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=W6+yCBLLMVgz4FbrS35e81eiB5ss3bZSZeySW1g652E=; b=crd8CJEUiXpIgKuijkuePFF18K
        ldL2fpWHqpS3m3chp+pzXBumYIpsiBfLvhz8Osp7YAPyF3u6Wlc/sM9wDiV7mCcIYACD6dMkfVWEU
        QXMVhDZr93oVTrW8q0zAFEs+2oaRre9nty2ohSbxTK7zNawrjmU2H0+EYhY3IVMwNjjY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41198 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pH6Sl-0008Cy-LM; Sun, 15 Jan 2023 12:06:32 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     hvilleneuve@dimonoff.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com
Date:   Sun, 15 Jan 2023 12:06:23 -0500
Message-Id: <20230115170623.3680647-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230115170623.3680647-1-hugo@hugovil.com>
References: <20230115170623.3680647-1-hugo@hugovil.com>
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
Subject: [PATCH v4 2/2] dt-bindings: iio: adc: add Texas Instruments ADS7924
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
 .../bindings/iio/adc/ti,ads7924.yaml          | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
new file mode 100644
index 000000000000..0d8d06afed8b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
@@ -0,0 +1,110 @@
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
+  reg:
+    maxItems: 1
+
+  vref-supply:
+    description:
+      The regulator supply for the ADC reference voltage (AVDD)
+
+  reset-gpios:
+    maxItems: 1
+
+  interrupts:
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
+patternProperties:
+  "^channel@[0-3]+$":
+    $ref: adc.yaml
+
+    description: |
+      Represents the external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        description: |
+          The channel number. It can have up to 4 channels numbered from 0 to 3.
+        items:
+          - minimum: 0
+            maximum: 3
+
+      label: true
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+  - "#address-cells"
+  - "#size-cells"
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@48 {
+            compatible = "ti,ads7924";
+            reg = <0x48>;
+            vref-supply = <&ads7924_reg>;
+            reset-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
+            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            channel@0 {
+                reg = <0>;
+                label = "CH0";
+            };
+            channel@1 {
+                reg = <1>;
+                label = "CH1";
+            };
+            channel@2 {
+                reg = <2>;
+                label = "CH2";
+            };
+            channel@3 {
+                reg = <3>;
+                label = "CH3";
+            };
+        };
+    };
+...
-- 
2.30.2

