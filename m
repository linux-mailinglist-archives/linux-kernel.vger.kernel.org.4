Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C89708F14
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 07:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjESFAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 01:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjESFAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 01:00:14 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E20186;
        Thu, 18 May 2023 22:00:09 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34J4wh6bB010986, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34J4wh6bB010986
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 19 May 2023 12:58:43 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 19 May 2023 12:58:53 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 19 May 2023 12:58:52 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Fri, 19 May 2023 12:58:52 +0800
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
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        "Paul Cercueil" <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH v1 3/3] dt-bindings: phy: realtek: Add the doc about the Realtek SoC USB 2.0/3.0 PHY
Date:   Fri, 19 May 2023 12:58:03 +0800
Message-ID: <20230519045825.28369-3-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519045825.28369-1-stanley_chang@realtek.com>
References: <20230519045825.28369-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
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

From: stanley_chang <stanley_chang@realtek.com>

Two documentations explain the property about realtek USB PHY drivers.

Realtek DHC (digital home center) RTD SoCs support DWC3 XHCI USB 2.0/3.0
controller. Added two drivers to drive the  USB 2.0/3.0 PHY transceivers.
For USB 3.0 transceivers, a driver phy-rtk-usb3 is provided.
The driver phy-rtk-usb2 is used to support USB 2.0 transceivers.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
 .../bindings/phy/realtek,usb2phy.yaml         | 249 ++++++++++++++++++
 .../bindings/phy/realtek,usb3phy.yaml         | 195 ++++++++++++++
 2 files changed, 444 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml b/Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml
new file mode 100644
index 000000000000..47ffdf308f27
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml
@@ -0,0 +1,249 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Realtek Semiconductor Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/realtek,usb2phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek DHC SoCs USB2 PHY
+
+maintainers:
+  - Stanley Chang <stanley_chang@realtek.com>
+
+description: |
+  Realtek USB 2.0 PHY support the digital home center (DHC) RTD series SoCs.
+
+properties:
+  compatible:
+    enum:
+      - realtek,usb2phy
+      - realtek,rtd-usb2phy
+      - realtek,rtd1295-usb2phy
+      - realtek,rtd1395-usb2phy
+      - realtek,rtd1619-usb2phy
+      - realtek,rtd1319-usb2phy
+      - realtek,rtd1619b-usb2phy
+      - realtek,rtd1312c-usb2phy
+      - realtek,rtd1319d-usb2phy
+      - realtek,rtd1315e-usb2phy
+
+  reg:
+    items:
+      - description: PHY data registers
+      - description: PHY control registers
+
+  realtek,usb:
+    description: The phandler of realtek dwc3 node
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  realtek,mac:
+    description: The phandler of dwc3 node
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  realtek,usb_ctrl:
+    description: The phandler of usb power control node
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  realtek,port-index:
+    description: The index of USB 2.0 PHY
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  realtek,phyN:
+    description: The total amount of USB 2.0 PHY
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  phy0:
+    description: The child node of PHY for the parameter v1.
+    type: object
+    properties:
+      realtek,phy-data-page0-size:
+        description: PHY data page 0 size
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      realtek,phy-data-page0-addr:
+        description: PHY data page 0 address
+        $ref: /schemas/types.yaml#/definitions/uint8-array
+
+      realtek,phy-data-page0-A00:
+        description: PHY data page 0 value
+        $ref: /schemas/types.yaml#/definitions/uint8-array
+
+      realtek,phy-data-page1-size:
+        description: PHY data page 1 size
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      realtek,phy-data-page1-addr:
+        description: PHY data page 1 address
+        $ref: /schemas/types.yaml#/definitions/uint8-array
+
+      realtek,phy-data-page1-A00:
+        description: PHY data page 1 value
+        $ref: /schemas/types.yaml#/definitions/uint8-array
+
+      realtek,phy-data-page2-size:
+        description: PHY data page 2 size
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      realtek,phy-data-page2-addr:
+        description: PHY data page 2 address
+        $ref: /schemas/types.yaml#/definitions/uint8-array
+
+      realtek,phy-data-page2-A00:
+        description: PHY data page 2 value
+        $ref: /schemas/types.yaml#/definitions/uint8-array
+
+      realtek,do-toggle:
+        description: Do PHY parameter toggle when port status change
+        type: boolean
+
+      realtek,check-efuse:
+        description: Enable to fix PHY parameter from reading otp table
+        type: boolean
+
+      realtek,use-default-parameter:
+        description: Don't set parameter and use default value
+        type: boolean
+
+      realtek,is-double-sensitivity-mode:
+        description: Enable double sensitivity mode
+        type: boolean
+
+      realtek,ldo-page0-e4-compensate:
+        description: Adjust the PHY parameter for page 0 0xE4 for ldo mode
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      realtek,page0-e4-compensate:
+        description: Adjust the PHY parameter for page 0 0xE4
+          for efuse table v2
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+  phy0_data:
+    description: The child node of PHY for parameter v2.
+    type: object
+    properties:
+      realtek,page0-size:
+        description: PHY data page 0 size
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      realtek,page0-data-A00:
+        description: PHY data page 0 address and value
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+
+      realtek,page1-size:
+        description: PHY data page 1 size
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      realtek,page1-data-A00:
+        description: PHY data page 1 address and value
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+
+      realtek,page2-size:
+        description: PHY data page 2 size
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      realtek,page2-data-A00:
+        description: PHY data page 2 address and value
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+
+      realtek,do-toggle:
+        description: Do PHY parameter toggle when port status change
+        type: boolean
+
+      realtek,do-toggle-driving:
+        description: Do PHY parameter toggle for driving when port
+          status change
+        type: boolean
+
+      realtek,check-efuse:
+        description: Enable to fix PHY parameter from reading otp table
+        type: boolean
+
+      realtek,use-default-parameter:
+        description: Don't set parameter and use default value
+        type: boolean
+
+      realtek,is-double-sensitivity-mode:
+        description: Enable double sensitivity mode
+        type: boolean
+
+      realtek,ldo-force-enable:
+        description: Force enable ldo mode
+        type: boolean
+
+      realtek,ldo-page0-e4-compensate:
+        description: Adjust the PHY parameter for page0 0xE4 for ldo mode
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      realtek,page0-e4-compensate:
+        description: Adjust the PHY parameter for page0 0xE4
+          for efuse table v2
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    dwc3_u3drd_usb2phy: dwc3_u3drd_usb2phy@98013e14 {
+        compatible = "realtek,usb2phy";
+        reg = <0x98013e14 0x4>, <0x98058280 0x4>;
+        status = "okay";
+        realtek,phyN = <1>;
+
+        phy0 {
+            realtek,phy-data-page0-size = <16>;
+            realtek,phy-data-page0-addr = /bits/ 8
+                <0xE0 0xE1 0xE2 0xE3 0xE4 0xE5 0xE6 0xE7 0xF0 0xF1
+                0xF2 0xF3 0xF4 0xF5 0xF6 0xF7>;
+            realtek,phy-data-page0-A00 = /bits/ 8
+                <0xE0 0x30 0x79 0x8D 0x6A 0x65 0x01 0x71 0xFC 0x8C
+                0x00 0x11 0x9B 0x00 0x00 0x0A>;
+            realtek,phy-data-page0-B00 = /bits/ 8
+                <0x18 0x30 0x79 0x8D 0x6A 0x65 0x01 0x71 0xFC 0x8C
+                0x00 0x11 0x9B 0x00 0x00 0x32>;
+            realtek,phy-data-page1-size = <8>;
+            realtek,phy-data-page1-addr = /bits/ 8
+                <0xE0 0xE1 0xE2 0xE3 0xE4 0xE5 0xE6 0xE7>;
+            realtek,phy-data-page1-A00 = /bits/ 8
+                <0x25 0xEF 0x60 0x44 0x00 0x0F 0x18 0xE3>;
+            realtek,phy-data-page2-size = <1>;
+            realtek,phy-data-page2-addr = /bits/ 8
+                <0xE0>;
+            realtek,phy-data-page2-A00 = /bits/ 8
+                <0x01>;
+            realtek,do-toggle;
+            realtek,check-efuse;
+            realtek,is-double-sensitivity-mode;
+            realtek,ldo-page0-e4-compensate = <(-2)>;
+        };
+    };
+
+  - |
+    usb_port0_usb2phy: usb_port0_usb2phy@13214 {
+        compatible = "realtek,usb2phy";
+        reg = <0x13214 0x4>, <0x28280 0x4>;
+        realtek,usb = <&usb_port0>;
+        realtek,mac = <&port0_dwc3>;
+        realtek,usb_ctrl = <&usb_ctrl>;
+
+        realtek,port-index = <0>;
+        realtek,phyN = <1>;
+        phy0_data {
+            realtek,page0-size = <16>;
+            realtek,page0-data-A00 = /* < addr data > */
+                    <0xE0 0xA3>, <0xE4 0xB2>, <0xE5 0x4F>, <0xE6 0x42>;
+            realtek,page1-size = <8>;
+            realtek,page1-data-A00 = <0xE3 0x64>;
+            realtek,page2-size = <8>;
+            realtek,page2-data-A00 = <0xE7 0x45>;
+            realtek,do-toggle;
+            realtek.do-toggle-driving;
+            realtek,disconnect-driving-updated = <0x8>;
+            realtek,check-efuse;
+            realtek,is-double-sensitivity-mode;
+            realtek,ldo-force-enable;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml b/Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml
new file mode 100644
index 000000000000..b4e9e0f061b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml
@@ -0,0 +1,195 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Realtek Semiconductor Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/realtek,usb3phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek DHC SoCs USB3 PHY
+
+maintainers:
+  - Stanley Chang <stanley_chang@realtek.com>
+
+description: |
+  Realtek USB 3.0 PHY support the digital home center (DHC) RTD series SoCs.
+
+properties:
+  compatible:
+    enum:
+      - realtek,usb3phy
+      - realtek,rtd-usb3phy
+      - realtek,rtd1295-usb3phy
+      - realtek,rtd1619-usb3phy
+      - realtek,rtd1319-usb3phy
+      - realtek,rtd1619b-usb3phy
+      - realtek,rtd1319d-usb3phy
+
+  reg:
+    maxItems: 1
+
+  realtek,usb:
+    description: The phandler of realtek dwc3 node
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  realtek,mac:
+    description: The phandler of dwc3 node
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  realtek,usb_ctrl:
+    description: The phandler of usb power control node
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  realtek,port-index:
+    description: The index of USB 3.0 PHY
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  realtek,phyN:
+    description: The total amount of USB 3.0 PHY
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  phy0:
+    description: The child node of PHY for parameter v1.
+    type: object
+    properties:
+      realtek,phy-data-size:
+        description: PHY data size
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      realtek,phy-data-addr:
+        description: PHY data address
+        $ref: /schemas/types.yaml#/definitions/uint8-array
+
+      realtek,phy-data-A00:
+        description: PHY data value
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+
+      realtek,do-toggle:
+        description: Do PHY parameter toggle when port status change
+        type: boolean
+
+      realtek,do-toggle-once:
+        description: Do PHY parameter toggle only on PHY init
+        type: boolean
+
+      realtek,check-efuse:
+        description: Enable to fix PHY parameter from reading otp table
+        type: boolean
+
+      realtek,use-default-parameter:
+        description: Don't set parameter and use default value
+        type: boolean
+
+      realtek,check-rx-front-end-offset:
+        description: Enable to check rx front end offset
+        type: boolean
+
+  phy0_data:
+    description: The child node of PHY for parameter v2.
+    type: object
+    properties:
+      realtek,phy-data-size:
+        description: PHY data size
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      realtek,phy-data-A00:
+        description: PHY data address and value
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+
+      realtek,do-toggle:
+        description: Do PHY parameter toggle when port status change
+        type: boolean
+
+      realtek,do-toggle-once:
+        description: Do PHY parameter toggle only on phy init
+        type: boolean
+
+      realtek,check-efuse:
+        description: Enable to fix PHY parameter from reading otp table
+        type: boolean
+
+      realtek,use-default-parameter:
+        description: Don't set parameter and use default value
+        type: boolean
+
+      realtek,check-rx-front-end-offset:
+        description: Enable to check rx front end offset
+        type: boolean
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    dwc3_u3drd_usb3phy: dwc3_u3drd_usb3phy@98013e10 {
+        compatible = "realtek,usb3phy";
+        reg = <0x98013e10 0x4>;
+        status = "okay";
+        realtek,port-index = <0>; /* index in u3 port */
+        realtek,phyN = <1>;
+
+        phy0 {
+            realtek,phy-data-size = <0x30>;
+            realtek,phy-data-addr = /bits/ 8
+                <0x00 0x01 0x02 0x03 0x04 0x05 0x06
+                0x07 0x08 0x09 0x0A 0x0B 0x0C 0x0D
+                0x0E 0x0F 0x10 0x11 0x12 0x13 0x14
+                0x15 0x16 0x17 0x18 0x19 0x1A 0x1B
+                0x1C 0x1D 0x1E 0x1F 0x20 0x21 0x22
+                0x23 0x24 0x25 0x26 0x27 0x28 0x29
+                0x2A 0x2B 0x2C 0x2D 0x2E 0x2F>;
+            realtek,phy-data-A00 = /bits/ 16
+                <0x400C 0xAC86 0x6042 0x2771 0x72F5 0x2AD3 0x0003
+                    0x2E00 0x3591 0x925C 0xA608 0xA905 0xC000 0xEF1E
+                    0x2010 0x8D50 0x000C 0x4C10 0xFC00 0x0C81 0xDE01
+                    0x0000 0x0000 0x0000 0x0000 0x6000 0x0085 0x2014
+                    0xC900 0xA03F 0xC2E0 0x7E00 0x705A 0xF645 0x0013
+                    0xCB66 0x4770 0x126C 0x840A 0x01D6 0xF802 0xff04
+                    0x3040 0x8028 0xFFFF 0xFFFF 0x0000 0x8600>;
+            realtek,phy-data-B00 = /bits/ 16
+                <0x400C 0xAC86 0x6042 0x2771 0x72F5 0x2AD3 0x0003
+                    0x2E00 0x3591 0x924C 0xA608 0xB905 0xC000 0xEF1E
+                    0x2010 0x8D50 0x000C 0x4C10 0xFC00 0x0C81 0xDE01
+                    0x0000 0x0000 0x0000 0x0000 0x6000 0x0085 0x2014
+                    0xC900 0xA03F 0xC2E0 0x7E00 0x705A 0xF645 0x0013
+                    0xCB66 0x4770 0x126C 0x840A 0x01D6 0xF802 0xff04
+                    0x3040 0x8028 0xFFFF 0xFFFF 0x0000 0x8600>;
+            realtek,do-toggle;
+        };
+    };
+
+  - |
+    usb_port2_usb3phy: usb_port2_usb3phy@13e10 {
+        compatible = "realtek,usb3phy";
+        reg = <0x13e10 0x4>;
+        realtek,usb = <&usb_port2>;
+        realtek,mac = <&port2_dwc3>;
+        realtek,usb_ctrl = <&usb_ctrl>;
+
+        realtek,port-index = <0>; /* index in u3 port */
+        realtek,phyN = <1>;
+        phy0_data {
+            realtek,phy-data-size = <0x30>;
+            realtek,phy-data-A00 = /* <addr  data> */
+                    <0x01 0xAC8C>,
+                    <0x06 0x0017>,
+                    <0x09 0x724C>,
+                    <0x0B 0xB90D>,
+                    <0x0A 0xB610>,
+                    <0x0D 0xEF2A>,
+                    <0x0F 0x9050>,
+                    <0x10 0x000C>,
+                    <0x20 0x70FF>,
+                    <0x21 0xCFAA>,
+                    <0x22 0x0013>,
+                    <0x23 0xDB66>,
+                    <0x26 0x8609>,
+                    <0x29 0xFF13>,
+                    <0x2A 0x3070>;
+            realtek,do-toggle-once;
+            realtek,check_efuse;
+        };
+    };
+
-- 
2.34.1

