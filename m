Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A8560B88E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbiJXTur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiJXTtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:49:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CAD168E63;
        Mon, 24 Oct 2022 11:15:50 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-096-059-109.ewe-ip-backbone.de [91.96.59.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 86827660283F;
        Mon, 24 Oct 2022 17:55:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666630558;
        bh=4ZJL66e4uW0ZMfoXxSwlQ168x6AE5qji5g/hEVVVtNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U+ts7lMAMaWbjGgf47Fa/x8M9r74NDlhkJ23lZoQTUPGZwiHwGaAQaybJZy8O2Hur
         jffcrKCymXnnLhjBFBC9fFbniFal2QGpkWaFogWxTtyPldygP1pM3geMIGwXJGlJLG
         DlnFI6gUL7q7BF6Mr6b8QiLDTwGB7y7q7mRcASHcmcFlMH7xEwv2+EvE3JA5EMsUFe
         q/1sD+RcxAV0WnNumJaVxQno+zl6KgZ3outsIoCgoJ5wBFwXOaqGa3yvPC50gMVaKi
         PLVJs2F35RXXDuDFlNEftBEqtbDJQIJoo1oUFuRhZ+y0/QREx9L/ruy5bTJMDNLBy4
         Hz07fHHRzs9fg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 099CF480AF2; Mon, 24 Oct 2022 18:55:54 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 6/6] dt-bindings: rtc: convert hym8563 bindings to json-schema
Date:   Mon, 24 Oct 2022 18:55:49 +0200
Message-Id: <20221024165549.74574-7-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221024165549.74574-1-sebastian.reichel@collabora.com>
References: <20221024165549.74574-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert RTC binding for Haoyu Microelectronics HYM8563 to Device Tree
Schema format.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/rtc/haoyu,hym8563.txt | 30 ----------
 .../bindings/rtc/haoyu,hym8563.yaml           | 56 +++++++++++++++++++
 2 files changed, 56 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml

diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
deleted file mode 100644
index a8934fe2ab4c..000000000000
--- a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Haoyu Microelectronics HYM8563 Real Time Clock
-
-The HYM8563 provides basic rtc and alarm functionality
-as well as a clock output of up to 32kHz.
-
-Required properties:
-- compatible: should be: "haoyu,hym8563"
-- reg: i2c address
-- #clock-cells: the value should be 0
-
-Optional properties:
-- clock-output-names: From common clock binding
-- interrupts: rtc alarm/event interrupt
-
-Example:
-
-hym8563: hym8563@51 {
-	compatible = "haoyu,hym8563";
-	reg = <0x51>;
-
-	interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
-
-	#clock-cells = <0>;
-};
-
-device {
-...
-	clocks = <&hym8563>;
-...
-};
diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
new file mode 100644
index 000000000000..0b9f39ef0edc
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/haoyu,hym8563.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Haoyu Microelectronics HYM8563 RTC
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+
+properties:
+  compatible:
+    const: haoyu,hym8563
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 0
+
+  clock-output-names:
+    description: From common clock binding to override the default output clock name.
+    maxItems: 1
+
+  wakeup-source:
+    description: Enables wake up of host system on alarm.
+
+allOf:
+  - $ref: rtc.yaml
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@51 {
+            compatible = "haoyu,hym8563";
+            reg = <0x51>;
+            interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+            #clock-cells = <0>;
+        };
+    };
-- 
2.35.1

