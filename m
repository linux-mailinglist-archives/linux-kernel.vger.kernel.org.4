Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B13710776
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240031AbjEYIcT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 May 2023 04:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239269AbjEYIcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:32:13 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C807F186;
        Thu, 25 May 2023 01:32:05 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9AF2F24E206;
        Thu, 25 May 2023 16:32:04 +0800 (CST)
Received: from EXMBX173.cuchost.com (172.16.6.93) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 25 May
 2023 16:32:04 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX173.cuchost.com
 (172.16.6.93) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 25 May
 2023 16:32:03 +0800
From:   Jack Zhu <jack.zhu@starfivetech.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        <bryan.odonoghue@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jack.zhu@starfivetech.com>,
        <changhuang.liang@starfivetech.com>
Subject: [PATCH v6 1/6] media: dt-bindings: Add JH7110 Camera Subsystem
Date:   Thu, 25 May 2023 16:31:57 +0800
Message-ID: <20230525083202.67933-2-jack.zhu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525083202.67933-1-jack.zhu@starfivetech.com>
References: <20230525083202.67933-1-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX173.cuchost.com
 (172.16.6.93)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the bindings documentation for Starfive JH7110 Camera Subsystem
which is used for handing image sensor data.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
---
 .../bindings/media/starfive,jh7110-camss.yaml | 180 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 187 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml

diff --git a/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
new file mode 100644
index 000000000000..c66586d90fa2
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
@@ -0,0 +1,180 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/starfive,jh7110-camss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Starfive SoC CAMSS ISP
+
+maintainers:
+  - Jack Zhu <jack.zhu@starfivetech.com>
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+description:
+  The Starfive CAMSS ISP is a Camera interface for Starfive JH7110 SoC. It
+  consists of a VIN controller (Video In Controller, a top-level control unit)
+  and an ISP.
+
+properties:
+  compatible:
+    const: starfive,jh7110-camss
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: syscon
+      - const: isp
+
+  clocks:
+    maxItems: 7
+
+  clock-names:
+    items:
+      - const: apb_func
+      - const: wrapper_clk_c
+      - const: dvp_inv
+      - const: axiwr
+      - const: mipi_rx0_pxl
+      - const: ispcore_2x
+      - const: isp_axi
+
+  resets:
+    maxItems: 6
+
+  reset-names:
+    items:
+      - const: wrapper_p
+      - const: wrapper_c
+      - const: axird
+      - const: axiwr
+      - const: isp_top_n
+      - const: isp_top_axi
+
+  power-domains:
+    items:
+      - description: JH7110 ISP Power Domain Switch Controller.
+
+  interrupts:
+    maxItems: 4
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: Input port for receiving DVP data.
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              bus-type:
+                enum: [5, 6]
+
+              bus-width:
+                enum: [8, 10, 12]
+
+              data-shift:
+                enum: [0, 2]
+                default: 0
+
+              hsync-active:
+                enum: [0, 1]
+                default: 1
+
+              vsync-active:
+                enum: [0, 1]
+                default: 1
+
+            required:
+              - bus-type
+              - bus-width
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Input port for receiving CSI data.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - power-domains
+  - interrupts
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    isp@19840000 {
+        compatible = "starfive,jh7110-camss";
+        reg = <0x19840000 0x10000>,
+              <0x19870000 0x30000>;
+        reg-names = "syscon", "isp";
+        clocks = <&ispcrg 0>,
+                 <&ispcrg 13>,
+                 <&ispcrg 2>,
+                 <&ispcrg 12>,
+                 <&ispcrg 1>,
+                 <&syscrg 51>,
+                 <&syscrg 52>;
+        clock-names = "apb_func",
+                      "wrapper_clk_c",
+                      "dvp_inv",
+                      "axiwr",
+                      "mipi_rx0_pxl",
+                      "ispcore_2x",
+                      "isp_axi";
+        resets = <&ispcrg 0>,
+                 <&ispcrg 1>,
+                 <&ispcrg 10>,
+                 <&ispcrg 11>,
+                 <&syscrg 41>,
+                 <&syscrg 42>;
+        reset-names = "wrapper_p",
+                      "wrapper_c",
+                      "axird",
+                      "axiwr",
+                      "isp_top_n",
+                      "isp_top_axi";
+        power-domains = <&pwrc 5>;
+        interrupts = <92>, <87>, <88>, <90>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            port@0 {
+                reg = <0>;
+                vin_from_sc2235: endpoint {
+                    remote-endpoint = <&sc2235_to_vin>;
+                    bus-type = <5>;
+                    bus-width = <8>;
+                    data-shift = <2>;
+                    hsync-active = <1>;
+                    vsync-active = <0>;
+                    pclk-sample = <1>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                vin_from_csi2rx: endpoint {
+                    remote-endpoint = <&csi2rx_to_vin>;
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 869e1c7fc869..9ef5d0e5dff0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20070,6 +20070,13 @@ M:	Ion Badulescu <ionut@badula.org>
 S:	Odd Fixes
 F:	drivers/net/ethernet/adaptec/starfire*
 
+STARFIVE CAMERA SUBSYSTEM DRIVER
+M:	Jack Zhu <jack.zhu@starfivetech.com>
+M:	Changhuang Liang <changhuang.liang@starfivetech.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
+
 STARFIVE DEVICETREES
 M:	Emil Renner Berthing <kernel@esmil.dk>
 S:	Maintained
-- 
2.34.1

