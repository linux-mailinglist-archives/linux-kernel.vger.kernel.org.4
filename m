Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21A3725420
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbjFGG0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbjFGG0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:26:31 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDAB1721;
        Tue,  6 Jun 2023 23:26:28 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3576PThD4024925, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3576PThD4024925
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 7 Jun 2023 14:25:29 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 7 Jun 2023 14:25:44 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 7 Jun 2023 14:25:44 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Wed, 7 Jun 2023 14:25:44 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ray Chi <raychi@google.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        "Michael Grzeschik" <m.grzeschik@pengutronix.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH v3 5/5] dt-bindings: phy: realtek: Add the doc about the Realtek SoC USB 3.0 PHY
Date:   Wed, 7 Jun 2023 14:24:41 +0800
Message-ID: <20230607062500.24669-5-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607062500.24669-1-stanley_chang@realtek.com>
References: <20230607062500.24669-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the documentation explain the property about Realtek USB PHY driver.

Realtek DHC (digital home center) RTD SoCs support DWC3 XHCI USB
controller. Added the driver to drive the  USB 3.0 PHY transceivers.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
v2 to v3 change:
    1. Broken down into two patches, one for each of USB 2 & 3.
    2. Add more description about Realtek RTD SoCs architecture.
    3. Removed parameter v1 support for simplification.
    4. Revised the compatible name for fallback compatible.
    5. Remove some properties that can be set in the driver.
v1 to v2 change:
    Add phy-cells for generic phy driver
---
 .../bindings/phy/realtek,usb3phy.yaml         | 156 ++++++++++++++++++
 1 file changed, 156 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml b/Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml
new file mode 100644
index 000000000000..b45c398bba5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml
@@ -0,0 +1,156 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Realtek Semiconductor Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/realtek,usb3phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek DHC SoCs USB 3.0 PHY
+
+maintainers:
+  - Stanley Chang <stanley_chang@realtek.com>
+
+description:
+  Realtek USB 3.0 PHY support the digital home center (DHC) RTD series SoCs.
+  The USB 3.0 PHY driver is designed to support the XHCI controller. The SoCs
+  support multiple XHCI controllers. One PHY device node maps to one XHCI
+  controller.
+
+  RTD1295/RTD1619 SoCs USB
+  The USB architecture includes three XHCI controllers.
+  Each XHCI maps to one USB 2.0 PHY and map one USB 3.0 PHY on some
+  controllers.
+  XHCI controller#0 -- usb2phy -- phy#0
+                    |- usb3phy -- phy#0
+  XHCI controller#1 -- usb2phy -- phy#0
+  XHCI controller#2 -- usb2phy -- phy#0
+                    |- usb3phy -- phy#0
+
+  RTD1395 SoCs USB
+  The USB architecture includes two XHCI controllers.
+  The controller#0 has one USB 2.0 PHY. The controller#1 includes two USB 2.0
+  PHY.
+  XHCI controller#0 -- usb2phy -- phy#0
+  XHCI controller#1 -- usb2phy -- phy#0
+                               |- phy#1
+
+  RTD1319/RTD1619b SoCs USB
+  The USB architecture includes three XHCI controllers.
+  Each XHCI maps to one USB 2.0 PHY and map one USB 3.0 PHY on controllers#2.
+  XHCI controller#0 -- usb2phy -- phy#0
+  XHCI controller#1 -- usb2phy -- phy#0
+  XHCI controller#2 -- usb2phy -- phy#0
+                    |- usb3phy -- phy#0
+
+  RTD1319d SoCs USB
+  The USB architecture includes three XHCI controllers.
+  Each xhci maps to one USB 2.0 PHY and map one USB 3.0 PHY on controllers#0.
+  XHCI controller#0 -- usb2phy -- phy#0
+                    |- usb3phy -- phy#0
+  XHCI controller#1 -- usb2phy -- phy#0
+  XHCI controller#2 -- usb2phy -- phy#0
+
+  RTD1312c/RTD1315e SoCs USB
+  The USB architecture includes three XHCI controllers.
+  Each XHCI maps to one USB 2.0 PHY.
+  XHCI controller#0 -- usb2phy -- phy#0
+  XHCI controller#1 -- usb2phy -- phy#0
+  XHCI controller#2 -- usb2phy -- phy#0
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - realtek,rtd1295-usb3phy
+          - realtek,rtd1619-usb3phy
+          - realtek,rtd1319-usb3phy
+          - realtek,rtd1619b-usb3phy
+          - realtek,rtd1319d-usb3phy
+      - const: realtek,usb3phy
+
+  reg:
+    description: PHY data registers
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  "#phy-cells":
+    const: 0
+
+patternProperties:
+  "^phy@[0-3]+$":
+    description: Each sub-node is a PHY device for one XHCI controller.
+    type: object
+    properties:
+      realtek,param:
+        description: The data of PHY parameter are the pair of the
+          offset and value.
+        $ref: /schemas/types.yaml#/definitions/uint8-array
+
+      realtek,do-toggle:
+        description: Set this flag to enable the PHY parameter toggle
+          when port status change.
+        type: boolean
+
+      realtek,do-toggle-once:
+        description: Set this flag to do PHY parameter toggle only on
+          PHY init.
+        type: boolean
+
+      realtek,check-efuse:
+        description: Enable to update PHY parameter from reading otp table.
+        type: boolean
+
+      realtek,use-default-parameter:
+        description: Don't set parameter and use default value in hardware.
+        type: boolean
+
+      realtek,check-rx-front-end-offset:
+        description: Enable to check rx front end offset.
+        type: boolean
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    usb_port2_usb3phy: usb-phy@13e10 {
+        compatible = "realtek,rtd1319d-usb3phy", "realtek,usb3phy";
+        reg = <0x13e10 0x4>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #phy-cells = <0>;
+
+        phy@0 {
+            reg = <0>;
+            realtek,param =
+                    <0x01 0xac8c>,
+                    <0x06 0x0017>,
+                    <0x09 0x724c>,
+                    <0x0B 0xb90d>,
+                    <0x0A 0xb610>,
+                    <0x0D 0xef2a>,
+                    <0x0F 0x9050>,
+                    <0x10 0x000c>,
+                    <0x20 0x70ff>,
+                    <0x21 0xcfaa>,
+                    <0x22 0x0013>,
+                    <0x23 0xdb66>,
+                    <0x26 0x8609>,
+                    <0x29 0xff13>,
+                    <0x2A 0x3070>;
+            realtek,do-toggle-once;
+            realtek,check-efuse;
+        };
+    };
+
-- 
2.34.1

