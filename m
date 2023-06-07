Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB25725417
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbjFGG0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjFGG03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:26:29 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427641725;
        Tue,  6 Jun 2023 23:26:25 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3576PJQ20024705, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3576PJQ20024705
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 7 Jun 2023 14:25:19 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 7 Jun 2023 14:25:34 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 7 Jun 2023 14:25:33 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Wed, 7 Jun 2023 14:25:33 +0800
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
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH v3 4/5] dt-bindings: phy: realtek: Add the doc about the Realtek SoC USB 2.0 PHY
Date:   Wed, 7 Jun 2023 14:24:40 +0800
Message-ID: <20230607062500.24669-4-stanley_chang@realtek.com>
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
controller. Added the driver to drive the USB 2.0 PHY transceivers.

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
 .../bindings/phy/realtek,usb2phy.yaml         | 213 ++++++++++++++++++
 1 file changed, 213 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml b/Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml
new file mode 100644
index 000000000000..69911e20a561
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml
@@ -0,0 +1,213 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Realtek Semiconductor Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/realtek,usb2phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek DHC SoCs USB 2.0 PHY
+
+maintainers:
+  - Stanley Chang <stanley_chang@realtek.com>
+
+description:
+  Realtek USB 2.0 PHY support the digital home center (DHC) RTD series SoCs.
+  The USB 2.0 PHY driver is designed to support the XHCI controller. The SoCs
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
+          - realtek,rtd1295-usb2phy
+          - realtek,rtd1395-usb2phy
+          - realtek,rtd1619-usb2phy
+          - realtek,rtd1319-usb2phy
+          - realtek,rtd1619b-usb2phy
+          - realtek,rtd1312c-usb2phy
+          - realtek,rtd1319d-usb2phy
+          - realtek,rtd1315e-usb2phy
+      - const: realtek,usb2phy
+
+  reg:
+    items:
+      - description: PHY data registers
+      - description: PHY control registers
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
+  realtek,usb-ctrl:
+    description: The phandle of syscon used to control USB PHY power domain.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+patternProperties:
+  "^phy@[0-3]+$":
+    type: object
+    description:
+      Each sub-node is a PHY device for one XHCI controller.
+      For most Relatek SoCs, one XHCI controller only support one the USB 2.0
+      phy. For RTD1395 SoC, the one XHCI controller has two USB 2.0 PHYs.
+    properties:
+      realtek,page0-param:
+        description: PHY parameter at page 0. The data are the pair of the
+          offset and value.
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+
+      realtek,page1-param:
+        description: PHY parameter at page 1. The data are the pair of the
+          offset and value.
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+
+      realtek,page2-param:
+        description: PHY parameter at page 2. The data are the pair of the
+          offset and value. If the PHY support the page 2 parameter.
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+
+      realtek,support-page2-param:
+        description: Set this flag if PHY support page 2 parameter.
+        type: boolean
+
+      realtek,do-toggle:
+        description: Set this flag to enable PHY parameter toggle when port
+          status change.
+        type: boolean
+
+      realtek,do-toggle-driving:
+        description: Set this flag to enable PHY parameter toggle for adjust
+          the driving when port status change.
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
+      realtek,is-double-sensitivity-mode:
+        description: Set this flag to enable double sensitivity mode.
+        type: boolean
+
+      realtek,ldo-force-enable:
+        description: Set this flag to force enable ldo mode.
+        type: boolean
+
+      realtek,ldo-driving-compensate:
+        description: Set the value for adjust the PHY driving for ldo mode.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      realtek,driving-compensate:
+        description: Set the value for adjust the PHY driving for efuse
+          table v2.
+        $ref: /schemas/types.yaml#/definitions/uint32
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
+    usb_port0_usb2phy: usb-phy@13214 {
+        compatible = "realtek,rtd1319d-usb2phy", "realtek,usb2phy";
+        reg = <0x13214 0x4>, <0x28280 0x4>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #phy-cells = <0>;
+        realtek,usb-ctrl = <&usb_ctrl>;
+
+        phy@0 {
+            reg = <0>;
+            realtek,page0-param =
+                    <0xe0 0xa3>, <0xe4 0xb2>, <0xe5 0x4e>, <0xe6 0x42>;
+            realtek,page1-param = <0xe3 0x64>;
+            realtek,page2-param = <0xe7 0x45>;
+            realtek,support-page2-param;
+            realtek,do-toggle;
+            realtek.do-toggle-driving;
+            realtek,check-efuse;
+            realtek,is-double-sensitivity-mode;
+            realtek,ldo-force-enable;
+        };
+    };
+
+  - |
+    usb_port1_usb2phy: usb-phy@13c14 {
+        compatible = "realtek,rtd1395-usb2phy", "realtek,usb2phy";
+        reg = <0x132c4 0x4>, <0x31280 0x8>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #phy-cells = <0>;
+        realtek,usb-ctrl = <&usb_ctrl>;
+
+        phy@0 {
+            reg = <0>;
+            realtek,page0-param =
+                    <0xe0 0xa3>, <0xe4 0xb2>, <0xe5 0x4e>, <0xe6 0x42>;
+            realtek,page1-param = <0xe3 0x00>;
+            realtek,do-toggle;
+            realtek,check-efuse;
+        };
+        phy@1 {
+            reg = <1>;
+            realtek,page0-param =
+                    <0xe0 0xe0>, <0xe4 0xb2>, <0xe5 0x4e>, <0xe6 0x42>;
+            realtek,page1-param = <0xe3 0x00>;
+            realtek,do-toggle;
+            realtek,check-efuse;
+        };
+    };
-- 
2.34.1

