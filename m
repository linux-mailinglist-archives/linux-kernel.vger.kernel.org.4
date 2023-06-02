Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E4771FB41
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbjFBHlz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Jun 2023 03:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbjFBHlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:41:18 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15791B3;
        Fri,  2 Jun 2023 00:40:59 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id B3FAB80F3;
        Fri,  2 Jun 2023 15:40:47 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 2 Jun
 2023 15:40:47 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 2 Jun
 2023 15:40:46 +0800
From:   Keith Zhao <keith.zhao@starfivetech.com>
To:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>
CC:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        <christian.koenig@amd.com>, Bjorn Andersson <andersson@kernel.org>,
        "Heiko Stuebner" <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Keith Zhao <keith.zhao@starfivetech.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH 1/9] dt-bindings: display: Add yamls for JH7110 display subsystem
Date:   Fri, 2 Jun 2023 15:40:35 +0800
Message-ID: <20230602074043.33872-2-keith.zhao@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602074043.33872-1-keith.zhao@starfivetech.com>
References: <20230602074043.33872-1-keith.zhao@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for JH7110 display subsystem which
has a display controller verisilicon dc8200
and an HDMI interface.

Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
---
 .../display/verisilicon/starfive-hdmi.yaml    |  93 +++++++++++++++
 .../display/verisilicon/verisilicon-dc.yaml   | 110 ++++++++++++++++++
 .../display/verisilicon/verisilicon-drm.yaml  |  42 +++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 ++
 5 files changed, 254 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/verisilicon/starfive-hdmi.yaml
 create mode 100644 Documentation/devicetree/bindings/display/verisilicon/verisilicon-dc.yaml
 create mode 100644 Documentation/devicetree/bindings/display/verisilicon/verisilicon-drm.yaml

diff --git a/Documentation/devicetree/bindings/display/verisilicon/starfive-hdmi.yaml b/Documentation/devicetree/bindings/display/verisilicon/starfive-hdmi.yaml
new file mode 100644
index 000000000000..c30b7954a355
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/verisilicon/starfive-hdmi.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/verisilicon/starfive-hdmi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive HDMI transmiter
+
+description:
+  The StarFive SoC uses the HDMI signal transmiter based on innosilicon IP
+  to generate HDMI signal from its input and transmit the signal to the screen.
+
+maintainers:
+  - Keith Zhao <keith.zhao@starfivetech.com>
+  - ShengYang Chen <shengyang.chen@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,hdmi
+
+  reg:
+    minItems: 1
+
+  interrupts:
+    items:
+      - description: The HDMI hot plug detection interrupt.
+
+  clocks:
+    items:
+      - description: System clock of HDMI module.
+      - description: Mclk clock of HDMI audio.
+      - description: Bclk clock of HDMI audio.
+      - description: Pixel clock generated by HDMI module.
+
+  clock-names:
+    items:
+      - const: sysclk
+      - const: mclk
+      - const: bclk
+      - const: pclk
+
+  resets:
+    items:
+      - description: Reset for HDMI module.
+
+  reset-names:
+    items:
+      - const: hdmi_tx
+
+  '#sound-dai-cells':
+    const: 0
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      Port node with one endpoint connected to a display connector node.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - '#sound-dai-cells'
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    hdmi: hdmi@29590000 {
+      compatible = "starfive,hdmi";
+      reg = <0x29590000 0x4000>;
+      interrupts = <99>;
+      clocks = <&voutcrg 17>,
+               <&voutcrg 15>,
+               <&voutcrg 16>,
+               <&hdmitx0_pixelclk>;
+      clock-names = "sysclk", "mclk","bclk","pclk";
+      resets = <&voutcrg 9>;
+      reset-names = "hdmi_tx";
+      #sound-dai-cells = <0>;
+      hdmi_in: port {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          hdmi_input: endpoint@0 {
+            reg = <0>;
+            remote-endpoint = <&dc_out_dpi0>;
+          };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/display/verisilicon/verisilicon-dc.yaml b/Documentation/devicetree/bindings/display/verisilicon/verisilicon-dc.yaml
new file mode 100644
index 000000000000..1322502c4cde
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/verisilicon/verisilicon-dc.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/verisilicon/verisilicon-dc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive display controller
+
+description:
+  The StarFive SoC uses the display controller based on Verisilicon IP
+  to transfer the image data from a video memory
+  buffer to an external LCD interface.
+
+maintainers:
+  - Keith Zhao <keith.zhao@starfivetech.com>
+  - ShengYang Chen <shengyang.chen@starfivetech.com>
+
+properties:
+  compatible:
+    const: verisilicon,dc8200
+
+  reg:
+    maxItems: 3
+
+  interrupts:
+    items:
+      - description: The interrupt will be generated when DC finish one frame
+
+  clocks:
+    items:
+      - description: Clock for display system noc bus.
+      - description: Pixel clock for display channel 0.
+      - description: Pixel clock for display channel 1.
+      - description: Clock for axi interface of display controller.
+      - description: Core clock for display controller.
+      - description: Clock for ahb interface of display controller.
+      - description: External HDMI pixel clock.
+      - description: Parent clock for pixel clock
+
+  clock-names:
+    items:
+      - const: clk_vout_noc_disp
+      - const: clk_vout_pix0
+      - const: clk_vout_pix1
+      - const: clk_vout_axi
+      - const: clk_vout_core
+      - const: clk_vout_vout_ahb
+      - const: hdmitx0_pixel
+      - const: clk_vout_dc8200
+
+  resets:
+    items:
+      - description: Reset for axi interface of display controller.
+      - description: Reset for ahb interface of display controller.
+      - description: Core reset of display controller.
+
+  reset-names:
+    items:
+      - const: rst_vout_axi
+      - const: rst_vout_ahb
+      - const: rst_vout_core
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      Port node with one endpoint connected to a hdmi node.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    dc8200: dc8200@29400000 {
+      compatible = "verisilicon,dc8200";
+      reg = <0x29400000 0x100>,
+            <0x29400800 0x2000>,
+            <0x295B0000 0x90>;
+      interrupts = <95>;
+      clocks = <&syscrg 60>,
+               <&voutcrg 7>,
+               <&voutcrg 8>,
+               <&voutcrg 4>,
+               <&voutcrg 5>,
+               <&voutcrg 6>,
+               <&hdmitx0_pixelclk>,
+               <&voutcrg 1>;
+      clock-names = "clk_vout_noc_disp", "clk_vout_pix0", "clk_vout_pix1", "clk_vout_axi",
+                    "clk_vout_core", "clk_vout_vout_ahb", "hdmitx0_pixel","clk_vout_dc8200";
+      resets = <&voutcrg 0>,
+               <&voutcrg 1>,
+               <&voutcrg 2>;
+      reset-names = "rst_vout_axi","rst_vout_ahb","rst_vout_core";
+      dc_out: port {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          dc_out_dpi0: endpoint@0 {
+              reg = <0>;
+              remote-endpoint = <&hdmi_input>;
+          };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/display/verisilicon/verisilicon-drm.yaml b/Documentation/devicetree/bindings/display/verisilicon/verisilicon-drm.yaml
new file mode 100644
index 000000000000..aed8d4af2c55
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/verisilicon/verisilicon-drm.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/verisilicon/verisilicon-drm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Verisilicon DRM master device
+
+maintainers:
+  - Keith Zhao <keith.zhao@starfivetech.com>
+  - ShengYang Chen <shengyang.chen@starfivetech.com>
+
+description: |
+  The Verisilicon DRM master device is a virtual device needed to list all
+  display controller or other display interface nodes that comprise the
+  graphics subsystem.
+
+properties:
+  compatible:
+    const: verisilicon,display-subsystem
+
+  ports:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      maxItems: 1
+    description: |
+      Should contain a list of phandles pointing to display interface ports
+      of display controller devices. Display controller definitions as defined in
+      Documentation/devicetree/bindings/display/verisilicon/verisilicon-dc.yaml
+
+required:
+  - compatible
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    display-subsystem {
+        compatible = "verisilicon,display-subsystem";
+        ports = <&dc_out>;
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 82d39ab0231b..52c04fd098be 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1436,6 +1436,8 @@ patternProperties:
     description: Variscite Ltd.
   "^vdl,.*":
     description: Van der Laan b.v.
+  "^verisilicon,.*":
+    description: Verisilicon Technologies, Inc.
   "^vertexcom,.*":
     description: Vertexcom Technologies, Inc.
   "^via,.*":
diff --git a/MAINTAINERS b/MAINTAINERS
index 2a0496448b7f..293aa13d484c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7049,6 +7049,13 @@ F:	Documentation/devicetree/bindings/display/brcm,bcm2835-*.yaml
 F:	drivers/gpu/drm/vc4/
 F:	include/uapi/drm/vc4_drm.h
 
+DRM DRIVERS FOR VERISILICON
+M:	Keith Zhao <keith.zhao@starfivetech.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	Documentation/devicetree/bindings/display/verisilicon/
+
 DRM DRIVERS FOR VIVANTE GPU IP
 M:	Lucas Stach <l.stach@pengutronix.de>
 R:	Russell King <linux+etnaviv@armlinux.org.uk>
-- 
2.34.1

