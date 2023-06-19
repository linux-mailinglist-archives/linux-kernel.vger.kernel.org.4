Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA66734ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 06:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjFSEIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 00:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjFSEIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 00:08:06 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724C5136
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 21:08:00 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F082B2C0295;
        Mon, 19 Jun 2023 16:07:52 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1687147672;
        bh=o0ZaSm33kFbyQMhpCmYHjQNybiHK0T4PV8vcDxUJh/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x0S7Ve3PIPo0jQd/HU6E5yXDUlcthkt02R49+kQRTF5KtbPGh65rJ4TfVljUtH+nc
         Q2uJetnwmyXHEjj3z/b91cYNFdSa8OBowYJ+7oajGcAWHDMkUxobZdPI5zgFRbXyIa
         oXNoXRs8bJKjgYBrNuKr+bWEprZAF0KtEKctom++wiwT6+2+9sKnlNJKe579x6Egs+
         +i1o74/R8JeHcdF1F8tvlMG+hlUrt4Q6m6bNQiz99F8yZIfeDaOeRKaBhA5XNHBp7h
         iV4ev1gGhTMuZKFxwuf/Z3z923qn57cxEDh003GnFoEId+HDOWMJHT8Qj8dci7Ev54
         7DP1GOM7islTw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B648fd4980001>; Mon, 19 Jun 2023 16:07:52 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 6C6C313ED5B;
        Mon, 19 Jun 2023 16:07:52 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 82253283B18; Mon, 19 Jun 2023 16:07:52 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v10 1/1] dt-bindings: mtd: marvell-nand: Convert to YAML DT scheme
Date:   Mon, 19 Jun 2023 16:07:42 +1200
Message-Id: <20230619040742.1108172-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230619040742.1108172-1-chris.packham@alliedtelesis.co.nz>
References: <20230619040742.1108172-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=NPqrBHyg c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=of4jigFt-DYA:10 a=g8kJ_gb0AAAA:8 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=gEfo2CItAAAA:8 a=JfrnYn6hAAAA:8 a=svvZceJcRGB84mKnZCYA:9 a=ecSNLfPMzbq-p5zXJZOg:22 a=AjGcO6oz07-iQ99wixmX:22 a=d3PnA9EDa4IxuAV0gXij:22 a=sptkURWiP4Gy88Gu7hUp:22 a=1CNFftbPRP8L7MoqJWF3:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadym Kochan <vadym.kochan@plvision.eu>

Switch the DT binding to a YAML schema to enable the DT validation.

There was also an incorrect reference to dma-names being "rxtx" where
the driver and existing device trees actually use dma-names =3D "data" so
this is corrected in the conversion.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v10:
    - Formatting for description
    - Restrict clocks to 1 item for non-8K devices
    - Don't allow "marvell,armada-8k-nand-controller" without
      "marvell,armada370-nand-controller" (undoes a change from v8)
   =20
    Changes in v9:
    - depend on series from Miquel
      https://lore.kernel.org/linux-mtd/20230606175246.190465-1-miquel.ra=
ynal@bootlin.com/
    - enforce minimum/maximum for nand-rb
    - move required: block for controller
    - move unevaluatedProperties: for nand chip
    - remove label, partitions and nand-on-flash-bbt which are covered by
      generic schema
   =20
    Changes in v8:
    - Mark deprecated compatible values as such
    - Allow "marvell,armada-8k-nand-controller" without
      "marvell,armada370-nand-controller"
    - Make dma-names usage reflect reality
    - Update commit message
   =20
    Changes in v7:
    - Restore "label" and "partitions" properties (should be picked up vi=
a
      nand-controller.yaml but aren't)
    - Add/restore nand-on-flash-bbt and nand-ecc-mode which aren't covere=
d
      by nand-controller.yaml.
    - Use "unevalautedProperties: false"
    - Corrections for clock-names, dma-names, nand-rb and nand-ecc-streng=
th
    - Add pxa3xx-nand-controller example
   =20
    Changes in v6:
    - remove properties covered by nand-controller.yaml
    - add example using armada-8k compatible
   =20
    earlier changes:
   =20
    v5:
       1) Get back "label" and "partitions" properties but without
          ref to the "partition.yaml" which was wrongly used.
   =20
       2) Add "additionalProperties: false" for nand@ because all possibl=
e
          properties are described.
   =20
    v4:
       1) Remove "label" and "partitions" properties
   =20
       2) Use 2 clocks for A7K/8K platform which is a requirement
   =20
    v3:
      1) Remove txt version from the MAINTAINERS list
   =20
      2) Use enum for some of compatible strings
   =20
      3) Drop:
            #address-cells
            #size-cells:
   =20
         as they are inherited from the nand-controller.yaml
   =20
      4) Add restriction to use 2 clocks for A8K SoC
   =20
      5) Dropped description for clock-names and extend it with
         minItems: 1
   =20
      6) Drop description for "dmas"
   =20
      7) Use "unevalautedProperties: false"
   =20
      8) Drop quites from yaml refs.
   =20
      9) Use 4-space indentation for the example section
   =20
    v2:
      1) Fixed warning by yamllint with incorrect indentation for compati=
ble list

 .../bindings/mtd/marvell,nand-controller.yaml | 226 ++++++++++++++++++
 .../devicetree/bindings/mtd/marvell-nand.txt  | 126 ----------
 MAINTAINERS                                   |   1 -
 3 files changed, 226 insertions(+), 127 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-co=
ntroller.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.tx=
t

diff --git a/Documentation/devicetree/bindings/mtd/marvell,nand-controlle=
r.yaml b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.ya=
ml
new file mode 100644
index 000000000000..a10729bb1840
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
@@ -0,0 +1,226 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/marvell,nand-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell NAND Flash Controller (NFC)
+
+maintainers:
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: marvell,armada-8k-nand-controller
+          - const: marvell,armada370-nand-controller
+      - enum:
+          - marvell,armada370-nand-controller
+          - marvell,pxa3xx-nand-controller
+      - description: legacy bindings
+        deprecated: true
+        enum:
+          - marvell,armada-8k-nand
+          - marvell,armada370-nand
+          - marvell,pxa3xx-nand
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description:
+      Shall reference the NAND controller clocks, the second one is
+      is only needed for the Armada 7K/8K SoCs
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: core
+      - const: reg
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    items:
+      - const: data
+
+  marvell,system-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Syscon node that handles NAND controller related regist=
ers
+
+patternProperties:
+  "^nand@[a-f0-9]$":
+    type: object
+    $ref: raw-nand-chip.yaml
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 3
+
+      nand-rb:
+        items:
+          - minimum: 0
+            maximum: 1
+
+      nand-ecc-step-size:
+        const: 512
+
+      nand-ecc-strength:
+        enum: [1, 4, 8, 12, 16]
+
+      nand-ecc-mode:
+        const: hw
+
+      marvell,nand-keep-config:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          Orders the driver not to take the timings from the core and
+          leaving them completely untouched. Bootloader timings will the=
n
+          be used.
+
+      marvell,nand-enable-arbiter:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          To enable the arbiter, all boards blindly used it,
+          this bit was set by the bootloader for many boards and even if
+          it is marked reserved in several datasheets, it might be neede=
d to set
+          it (otherwise it is harmless).
+        deprecated: true
+
+    required:
+      - reg
+      - nand-rb
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+allOf:
+  - $ref: nand-controller.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: marvell,pxa3xx-nand-controller
+    then:
+      required:
+        - dmas
+        - dma-names
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: marvell,armada-8k-nand-controller
+    then:
+      properties:
+        clocks:
+          minItems: 2
+
+        clock-names:
+          minItems: 2
+
+      required:
+        - marvell,system-controller
+
+    else:
+      properties:
+        clocks:
+          minItems: 1
+
+        clock-names:
+          minItems: 1
+
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    nand_controller: nand-controller@d0000 {
+        compatible =3D "marvell,armada370-nand-controller";
+        reg =3D <0xd0000 0x54>;
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+        interrupts =3D <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+        clocks =3D <&coredivclk 0>;
+
+        nand@0 {
+            reg =3D <0>;
+            label =3D "main-storage";
+            nand-rb =3D <0>;
+            nand-ecc-mode =3D "hw";
+            marvell,nand-keep-config;
+            nand-on-flash-bbt;
+            nand-ecc-strength =3D <4>;
+            nand-ecc-step-size =3D <512>;
+
+            partitions {
+                compatible =3D "fixed-partitions";
+                #address-cells =3D <1>;
+                #size-cells =3D <1>;
+
+                partition@0 {
+                    label =3D "Rootfs";
+                    reg =3D <0x00000000 0x40000000>;
+                };
+            };
+        };
+    };
+
+  - |
+    cp0_nand_controller: nand-controller@720000 {
+        compatible =3D "marvell,armada-8k-nand-controller",
+                "marvell,armada370-nand-controller";
+        reg =3D <0x720000 0x54>;
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+        interrupts =3D <115 IRQ_TYPE_LEVEL_HIGH>;
+        clock-names =3D "core", "reg";
+        clocks =3D <&cp0_clk 1 2>,
+                 <&cp0_clk 1 17>;
+        marvell,system-controller =3D <&cp0_syscon0>;
+
+        nand@0 {
+            reg =3D <0>;
+            label =3D "main-storage";
+            nand-rb =3D <0>;
+            nand-ecc-mode =3D "hw";
+            nand-ecc-strength =3D <8>;
+            nand-ecc-step-size =3D <512>;
+        };
+    };
+
+  - |
+    nand-controller@43100000 {
+        compatible =3D "marvell,pxa3xx-nand-controller";
+        reg =3D <0x43100000 90>;
+        interrupts =3D <45>;
+        clocks =3D <&clks 1>;
+        clock-names =3D "core";
+        dmas =3D <&pdma 97 3>;
+        dma-names =3D "data";
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+        nand@0 {
+            reg =3D <0>;
+            nand-rb =3D <0>;
+            nand-ecc-mode =3D "hw";
+            marvell,nand-keep-config;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/mtd/marvell-nand.txt b/Doc=
umentation/devicetree/bindings/mtd/marvell-nand.txt
deleted file mode 100644
index a2d9a0f2b683..000000000000
--- a/Documentation/devicetree/bindings/mtd/marvell-nand.txt
+++ /dev/null
@@ -1,126 +0,0 @@
-Marvell NAND Flash Controller (NFC)
-
-Required properties:
-- compatible: can be one of the following:
-    * "marvell,armada-8k-nand-controller"
-    * "marvell,armada370-nand-controller"
-    * "marvell,pxa3xx-nand-controller"
-    * "marvell,armada-8k-nand" (deprecated)
-    * "marvell,armada370-nand" (deprecated)
-    * "marvell,pxa3xx-nand" (deprecated)
-  Compatibles marked deprecated support only the old bindings described
-  at the bottom.
-- reg: NAND flash controller memory area.
-- #address-cells: shall be set to 1. Encode the NAND CS.
-- #size-cells: shall be set to 0.
-- interrupts: shall define the NAND controller interrupt.
-- clocks: shall reference the NAND controller clocks, the second one is
-  is only needed for the Armada 7K/8K SoCs
-- clock-names: mandatory if there is a second clock, in this case there
-  should be one clock named "core" and another one named "reg"
-- marvell,system-controller: Set to retrieve the syscon node that handle=
s
-  NAND controller related registers (only required with the
-  "marvell,armada-8k-nand[-controller]" compatibles).
-
-Optional properties:
-- label: see partition.txt. New platforms shall omit this property.
-- dmas: shall reference DMA channel associated to the NAND controller.
-  This property is only used with "marvell,pxa3xx-nand[-controller]"
-  compatible strings.
-- dma-names: shall be "rxtx".
-  This property is only used with "marvell,pxa3xx-nand[-controller]"
-  compatible strings.
-
-Optional children nodes:
-Children nodes represent the available NAND chips.
-
-Required properties:
-- reg: shall contain the native Chip Select ids (0-3).
-- nand-rb: see nand-controller.yaml (0-1).
-
-Optional properties:
-- marvell,nand-keep-config: orders the driver not to take the timings
-  from the core and leaving them completely untouched. Bootloader
-  timings will then be used.
-- label: MTD name.
-- nand-on-flash-bbt: see nand-controller.yaml.
-- nand-ecc-mode: see nand-controller.yaml. Will use hardware ECC if not =
specified.
-- nand-ecc-algo: see nand-controller.yaml. This property is essentially =
useful when
-  not using hardware ECC. Howerver, it may be added when using hardware
-  ECC for clarification but will be ignored by the driver because ECC
-  mode is chosen depending on the page size and the strength required by
-  the NAND chip. This value may be overwritten with nand-ecc-strength
-  property.
-- nand-ecc-strength: see nand-controller.yaml.
-- nand-ecc-step-size: see nand-controller.yaml. Marvell's NAND flash con=
troller does
-  use fixed strength (1-bit for Hamming, 16-bit for BCH), so the actual
-  step size will shrink or grow in order to fit the required strength.
-  Step sizes are not completely random for all and follow certain
-  patterns described in AN-379, "Marvell SoC NFC ECC".
-
-See Documentation/devicetree/bindings/mtd/nand-controller.yaml for more =
details on
-generic bindings.
-
-
-Example:
-nand_controller: nand-controller@d0000 {
-	compatible =3D "marvell,armada370-nand-controller";
-	reg =3D <0xd0000 0x54>;
-	#address-cells =3D <1>;
-	#size-cells =3D <0>;
-	interrupts =3D <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
-	clocks =3D <&coredivclk 0>;
-
-	nand@0 {
-		reg =3D <0>;
-		label =3D "main-storage";
-		nand-rb =3D <0>;
-		nand-ecc-mode =3D "hw";
-		marvell,nand-keep-config;
-		nand-on-flash-bbt;
-		nand-ecc-strength =3D <4>;
-		nand-ecc-step-size =3D <512>;
-
-		partitions {
-			compatible =3D "fixed-partitions";
-			#address-cells =3D <1>;
-			#size-cells =3D <1>;
-
-			partition@0 {
-				label =3D "Rootfs";
-				reg =3D <0x00000000 0x40000000>;
-			};
-		};
-	};
-};
-
-
-Note on legacy bindings: One can find, in not-updated device trees,
-bindings slightly different than described above with other properties
-described below as well as the partitions node at the root of a so
-called "nand" node (without clear controller/chip separation).
-
-Legacy properties:
-- marvell,nand-enable-arbiter: To enable the arbiter, all boards blindly
-  used it, this bit was set by the bootloader for many boards and even i=
f
-  it is marked reserved in several datasheets, it might be needed to set
-  it (otherwise it is harmless) so whether or not this property is set,
-  the bit is selected by the driver.
-- num-cs: Number of chip-select lines to use, all boards blindly set 1
-  to this and for a reason, other values would have failed. The value of
-  this property is ignored.
-
-Example:
-
-	nand0: nand@43100000 {
-		compatible =3D "marvell,pxa3xx-nand";
-		reg =3D <0x43100000 90>;
-		interrupts =3D <45>;
-		dmas =3D <&pdma 97 0>;
-		dma-names =3D "rxtx";
-		#address-cells =3D <1>;
-		marvell,nand-keep-config;
-		marvell,nand-enable-arbiter;
-		num-cs =3D <1>;
-		/* Partitions (optional) */
-       };
diff --git a/MAINTAINERS b/MAINTAINERS
index 5d463f171c90..5342798d4e4f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12448,7 +12448,6 @@ MARVELL NAND CONTROLLER DRIVER
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 L:	linux-mtd@lists.infradead.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/mtd/marvell-nand.txt
 F:	drivers/mtd/nand/raw/marvell_nand.c
=20
 MARVELL OCTEONTX2 PHYSICAL FUNCTION DRIVER
--=20
2.40.1

