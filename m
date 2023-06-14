Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA5972F933
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244086AbjFNJah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244156AbjFNJ35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:29:57 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698BC1BC5;
        Wed, 14 Jun 2023 02:29:56 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35E9T6M70025701, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35E9T6M70025701
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 14 Jun 2023 17:29:06 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 14 Jun 2023 17:29:24 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 14 Jun 2023 17:29:23 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Wed, 14 Jun 2023 17:29:23 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        "Ray Chi" <raychi@google.com>, Flavio Suligoi <f.suligoi@asem.it>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH v4 4/5] dt-bindings: phy: realtek: Add the doc about the Realtek SoC USB 2.0 PHY
Date:   Wed, 14 Jun 2023 17:28:34 +0800
Message-ID: <20230614092850.21460-4-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614092850.21460-1-stanley_chang@realtek.com>
References: <20230614092850.21460-1-stanley_chang@realtek.com>
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

Add the documentation explain the property about Realtek USB PHY driver.

Realtek DHC (digital home center) RTD SoCs support DWC3 XHCI USB
controller. Added the driver to drive the USB 2.0 PHY transceivers.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
v3 to v4 change:
    1. Remove the parameter and non hardware properties from dts.
    2. Using the compatible data included the config and parameter
       in driver.
v2 to v3 change:
    1. Broken down into two patches, one for each of USB 2 & 3.
    2. Add more description about Realtek RTD SoCs architecture.
    3. Removed parameter v1 support for simplification.
    4. Revised the compatible name for fallback compatible.
    5. Remove some properties that can be set in the driver.
v1 to v2 change:
    Add phy-cells for generic phy driver
---
 .../bindings/phy/realtek,usb2phy.yaml         | 145 ++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml b/Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml
new file mode 100644
index 000000000000..cfd77143475c
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml
@@ -0,0 +1,145 @@
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
+          - realtek,rtd1312c-usb2phy
+          - realtek,rtd1315e-usb2phy
+          - realtek,rtd1319-usb2phy
+          - realtek,rtd1319d-usb2phy
+          - realtek,rtd1395-usb2phy
+          - realtek,rtd1395-usb2phy-2port
+          - realtek,rtd1619-usb2phy
+          - realtek,rtd1619b-usb2phy
+      - const: realtek,usb2phy
+
+  reg:
+    items:
+      - description: PHY data registers
+      - description: PHY control registers
+
+  "#phy-cells":
+    const: 0
+
+  nvmem-cells:
+    maxItems: 2
+    description:
+      Phandles to nvmem cell that contains the trimming data.
+      If unspecified, default value is used.
+
+  nvmem-cell-names:
+    items:
+      - const: usb-dc-cal
+      - const: usb-dc-dis
+    description:
+      The following names, which correspond to each nvmem-cells.
+      usb-dc-cal is the driving level for each phy specified via efuse.
+      usb-dc-dis is the disconnection level for each phy specified via efuse.
+
+  realtek,inverse-hstx-sync-clock:
+    description:
+      For one of the phys of RTD1619b SoC, the synchronous clock of the
+      high-speed tx must be inverted. So this property is used to set the
+      inverted clock.
+    type: boolean
+
+  realtek,driving-level:
+    description:
+      Each board or port may have a different driving capability. This
+      will adjust the driving level value if the value is not the default.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 31
+
+  realtek,driving-compensate:
+    description:
+      For RTD1315e SoC, the driving level can be adjusted by reading the
+      efuse table. Therefore, this property provides drive compensation for
+      different boards with different drive capabilities.
+    $ref: /schemas/types.yaml#/definitions/int32
+    minimum: -8
+    maximum: 8
+
+  realtek,disconnection-compensate:
+    description:
+      This adjusts the disconnection level compensation for the different
+      boards with different disconnection level.
+    $ref: /schemas/types.yaml#/definitions/int32
+    minimum: -8
+    maximum: 8
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    usb_port0_usb2phy: usb-phy@13214 {
+        compatible = "realtek,rtd1319d-usb2phy", "realtek,usb2phy";
+        reg = <0x13214 0x4>, <0x28280 0x4>;
+        #phy-cells = <0>;
+
+        realtek,driving-level = <0xe>;
+    };
-- 
2.34.1

