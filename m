Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12683619DBB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiKDQtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiKDQru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:47:50 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DD04AF18;
        Fri,  4 Nov 2022 09:47:40 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 34C0C40012;
        Fri,  4 Nov 2022 16:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667580459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=18t/7qSaRnk2gS9dcNFVNFqLhCWEty8oMGunULJHDD4=;
        b=XTi+tbo+jHaN75MxBIfHEQmVt8fYho5DQToDolW2Qa5bdHDjQOZg/KBPXkeuQiFePkC88l
        GbZozM56F3Mcw2HxQ+2N96mM8aJ9r2bQJ7uUYSMMs0aO3GVsp8WSlAf87RpK4UpGHeb8fh
        GRYKeg1VLi7GgqebJaI6pi2/V9g6oSMtx2Mh2hZIT36zULStpcZe5CHFRjGA1waXwE5zal
        /CPjxPlfstWdYoPjjTOLcF4e7uQfgSAkkGVZD8Ji1QNp/8QtEs+EIn898lyXYcE5ESqqA0
        F3RG19CuQ67LOhc/UIkTfTpTCNSUb6x9GbkGyo9ymOpt++3g8auK6aWCG0G6dg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 17/17] dt-bindings: mtd: Standardize the style in the examples
Date:   Fri,  4 Nov 2022 17:47:18 +0100
Message-Id: <20221104164718.1290859-18-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104164718.1290859-1-miquel.raynal@bootlin.com>
References: <20221104164718.1290859-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As recently requested by the binding maintaines, let's use 4 spaces in
the examples.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../bindings/mtd/arm,pl353-nand-r2p1.yaml     |  30 ++---
 .../bindings/mtd/brcm,brcmnand.yaml           |  80 ++++++------
 .../devicetree/bindings/mtd/denali,nand.yaml  |   2 +-
 .../devicetree/bindings/mtd/ingenic,nand.yaml | 114 +++++++++---------
 .../bindings/mtd/intel,lgm-ebunand.yaml       |  36 +++---
 .../bindings/mtd/microchip,mchp48l640.yaml    |  14 +--
 .../mtd/partitions/qcom,smem-part.yaml        |  28 ++---
 .../devicetree/bindings/mtd/qcom,nandc.yaml   | 114 +++++++++---------
 .../bindings/mtd/st,stm32-fmc2-nand.yaml      |  47 ++++----
 .../bindings/mtd/ti,am654-hbmc.yaml           |  36 +++---
 10 files changed, 251 insertions(+), 250 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml b/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
index 023f3ef0fa13..e552875040e2 100644
--- a/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
+++ b/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
@@ -34,20 +34,20 @@ unevaluatedProperties: false
 examples:
   - |
     smcc: memory-controller@e000e000 {
-      compatible = "arm,pl353-smc-r2p1", "arm,primecell";
-      reg = <0xe000e000 0x0001000>;
-      clock-names = "memclk", "apb_pclk";
-      clocks = <&clkc 11>, <&clkc 44>;
-      ranges = <0x0 0x0 0xe1000000 0x1000000 /* Nand CS region */
-                0x1 0x0 0xe2000000 0x2000000 /* SRAM/NOR CS0 region */
-                0x2 0x0 0xe4000000 0x2000000>; /* SRAM/NOR CS1 region */
-      #address-cells = <2>;
-      #size-cells = <1>;
+        compatible = "arm,pl353-smc-r2p1", "arm,primecell";
+        reg = <0xe000e000 0x0001000>;
+        clock-names = "memclk", "apb_pclk";
+        clocks = <&clkc 11>, <&clkc 44>;
+        ranges = <0x0 0x0 0xe1000000 0x1000000 /* Nand CS region */
+                  0x1 0x0 0xe2000000 0x2000000 /* SRAM/NOR CS0 region */
+                  0x2 0x0 0xe4000000 0x2000000>; /* SRAM/NOR CS1 region */
+        #address-cells = <2>;
+        #size-cells = <1>;
 
-      nfc0: nand-controller@0,0 {
-        compatible = "arm,pl353-nand-r2p1";
-        reg = <0 0 0x1000000>;
-        #address-cells = <1>;
-        #size-cells = <0>;
-      };
+        nfc0: nand-controller@0,0 {
+            compatible = "arm,pl353-nand-r2p1";
+            reg = <0 0 0x1000000>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+        };
     };
diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
index dd5a64969e37..f9518d39fbbd 100644
--- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
+++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
@@ -184,51 +184,51 @@ required:
 examples:
   - |
     nand-controller@f0442800 {
-            compatible = "brcm,brcmnand-v7.0", "brcm,brcmnand";
-            reg = <0xf0442800 0x600>,
-                  <0xf0443000 0x100>;
-            reg-names = "nand", "flash-dma";
-            interrupt-parent = <&hif_intr2_intc>;
-            interrupts = <24>, <4>;
+        compatible = "brcm,brcmnand-v7.0", "brcm,brcmnand";
+        reg = <0xf0442800 0x600>,
+              <0xf0443000 0x100>;
+        reg-names = "nand", "flash-dma";
+        interrupt-parent = <&hif_intr2_intc>;
+        interrupts = <24>, <4>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        nand@1 {
+            compatible = "brcm,nandcs";
+            reg = <1>; // Chip select 1
+            nand-on-flash-bbt;
+            nand-ecc-strength = <12>;
+            nand-ecc-step-size = <512>;
 
             #address-cells = <1>;
-            #size-cells = <0>;
-
-            nand@1 {
-                    compatible = "brcm,nandcs";
-                    reg = <1>; // Chip select 1
-                    nand-on-flash-bbt;
-                    nand-ecc-strength = <12>;
-                    nand-ecc-step-size = <512>;
-
-                    #address-cells = <1>;
-                    #size-cells = <1>;
-            };
+            #size-cells = <1>;
+        };
     };
   - |
     nand-controller@10000200 {
-            compatible = "brcm,nand-bcm63168", "brcm,nand-bcm6368",
-                         "brcm,brcmnand-v4.0", "brcm,brcmnand";
-            reg = <0x10000200 0x180>,
-                  <0x100000b0 0x10>,
-                  <0x10000600 0x200>;
-            reg-names = "nand", "nand-int-base", "nand-cache";
-            interrupt-parent = <&periph_intc>;
-            interrupts = <50>;
-            clocks = <&periph_clk 20>;
-            clock-names = "nand";
+        compatible = "brcm,nand-bcm63168", "brcm,nand-bcm6368",
+                     "brcm,brcmnand-v4.0", "brcm,brcmnand";
+        reg = <0x10000200 0x180>,
+              <0x100000b0 0x10>,
+              <0x10000600 0x200>;
+        reg-names = "nand", "nand-int-base", "nand-cache";
+        interrupt-parent = <&periph_intc>;
+        interrupts = <50>;
+        clocks = <&periph_clk 20>;
+        clock-names = "nand";
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        nand@0 {
+            compatible = "brcm,nandcs";
+            reg = <0>;
+            nand-on-flash-bbt;
+            nand-ecc-strength = <1>;
+            nand-ecc-step-size = <512>;
 
             #address-cells = <1>;
-            #size-cells = <0>;
-
-            nand@0 {
-                    compatible = "brcm,nandcs";
-                    reg = <0>;
-                    nand-on-flash-bbt;
-                    nand-ecc-strength = <1>;
-                    nand-ecc-step-size = <512>;
-
-                    #address-cells = <1>;
-                    #size-cells = <1>;
-            };
+            #size-cells = <1>;
+        };
     };
diff --git a/Documentation/devicetree/bindings/mtd/denali,nand.yaml b/Documentation/devicetree/bindings/mtd/denali,nand.yaml
index 1307ed7e7fc6..0be83ad42970 100644
--- a/Documentation/devicetree/bindings/mtd/denali,nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/denali,nand.yaml
@@ -145,6 +145,6 @@ examples:
         #size-cells = <0>;
 
         nand@0 {
-                reg = <0>;
+            reg = <0>;
         };
     };
diff --git a/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml b/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
index 90dbc5eba1e7..a811a512ecc5 100644
--- a/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
@@ -58,78 +58,78 @@ examples:
   - |
     #include <dt-bindings/clock/ingenic,jz4780-cgu.h>
     memory-controller@13410000 {
-      compatible = "ingenic,jz4780-nemc";
-      reg = <0x13410000 0x10000>;
-      #address-cells = <2>;
-      #size-cells = <1>;
-      ranges = <1 0 0x1b000000 0x1000000>,
-         <2 0 0x1a000000 0x1000000>,
-         <3 0 0x19000000 0x1000000>,
-         <4 0 0x18000000 0x1000000>,
-         <5 0 0x17000000 0x1000000>,
-         <6 0 0x16000000 0x1000000>;
+        compatible = "ingenic,jz4780-nemc";
+        reg = <0x13410000 0x10000>;
+        #address-cells = <2>;
+        #size-cells = <1>;
+        ranges = <1 0 0x1b000000 0x1000000>,
+                 <2 0 0x1a000000 0x1000000>,
+                 <3 0 0x19000000 0x1000000>,
+                 <4 0 0x18000000 0x1000000>,
+                 <5 0 0x17000000 0x1000000>,
+                 <6 0 0x16000000 0x1000000>;
 
-      clocks = <&cgu JZ4780_CLK_NEMC>;
+        clocks = <&cgu JZ4780_CLK_NEMC>;
 
-      nand-controller@1 {
-        compatible = "ingenic,jz4780-nand";
-        reg = <1 0 0x1000000>;
+        nand-controller@1 {
+            compatible = "ingenic,jz4780-nand";
+            reg = <1 0 0x1000000>;
 
-        #address-cells = <1>;
-        #size-cells = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
 
-        ecc-engine = <&bch>;
+            ecc-engine = <&bch>;
 
-        ingenic,nemc-tAS = <10>;
-        ingenic,nemc-tAH = <5>;
-        ingenic,nemc-tBP = <10>;
-        ingenic,nemc-tAW = <15>;
-        ingenic,nemc-tSTRV = <100>;
+            ingenic,nemc-tAS = <10>;
+            ingenic,nemc-tAH = <5>;
+            ingenic,nemc-tBP = <10>;
+            ingenic,nemc-tAW = <15>;
+            ingenic,nemc-tSTRV = <100>;
 
-        pinctrl-names = "default";
-        pinctrl-0 = <&pins_nemc>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&pins_nemc>;
 
-        nand@1 {
-          reg = <1>;
+            nand@1 {
+                reg = <1>;
 
-          nand-ecc-step-size = <1024>;
-          nand-ecc-strength = <24>;
-          nand-ecc-mode = "hw";
-          nand-on-flash-bbt;
+                nand-ecc-step-size = <1024>;
+                nand-ecc-strength = <24>;
+                nand-ecc-mode = "hw";
+                nand-on-flash-bbt;
 
-          pinctrl-names = "default";
-          pinctrl-0 = <&pins_nemc_cs1>;
+                pinctrl-names = "default";
+                pinctrl-0 = <&pins_nemc_cs1>;
 
-          partitions {
-            compatible = "fixed-partitions";
-            #address-cells = <2>;
-            #size-cells = <2>;
+                partitions {
+                    compatible = "fixed-partitions";
+                    #address-cells = <2>;
+                    #size-cells = <2>;
 
-            partition@0 {
-              label = "u-boot-spl";
-              reg = <0x0 0x0 0x0 0x800000>;
-            };
+                    partition@0 {
+                        label = "u-boot-spl";
+                        reg = <0x0 0x0 0x0 0x800000>;
+                    };
 
-            partition@800000 {
-              label = "u-boot";
-              reg = <0x0 0x800000 0x0 0x200000>;
-            };
+                    partition@800000 {
+                        label = "u-boot";
+                        reg = <0x0 0x800000 0x0 0x200000>;
+                    };
 
-            partition@a00000 {
-              label = "u-boot-env";
-              reg = <0x0 0xa00000 0x0 0x200000>;
-            };
+                    partition@a00000 {
+                        label = "u-boot-env";
+                        reg = <0x0 0xa00000 0x0 0x200000>;
+                    };
 
-            partition@c00000 {
-              label = "boot";
-              reg = <0x0 0xc00000 0x0 0x4000000>;
-            };
+                    partition@c00000 {
+                        label = "boot";
+                        reg = <0x0 0xc00000 0x0 0x4000000>;
+                    };
 
-            partition@4c00000 {
-              label = "system";
-              reg = <0x0 0x4c00000 0x1 0xfb400000>;
+                    partition@4c00000 {
+                        label = "system";
+                        reg = <0x0 0x4c00000 0x1 0xfb400000>;
+                    };
+                };
             };
-          };
         };
-      };
     };
diff --git a/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml b/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml
index d455b75a0b0b..8c62c7d3d0cd 100644
--- a/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml
+++ b/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml
@@ -67,25 +67,25 @@ unevaluatedProperties: false
 examples:
   - |
     nand-controller@e0f00000 {
-      compatible = "intel,lgm-ebunand";
-      reg = <0xe0f00000 0x100>,
-            <0xe1000000 0x300>,
-            <0xe1400000 0x8000>,
-            <0xe1c00000 0x1000>,
-            <0x17400000 0x4>,
-            <0x17c00000 0x4>;
-      reg-names = "ebunand", "hsnand", "nand_cs0", "nand_cs1",
-        "addr_sel0", "addr_sel1";
-      clocks = <&cgu0 125>;
-      dmas = <&dma0 8>, <&dma0 9>;
-      dma-names = "tx", "rx";
-      #address-cells = <1>;
-      #size-cells = <0>;
+        compatible = "intel,lgm-ebunand";
+        reg = <0xe0f00000 0x100>,
+              <0xe1000000 0x300>,
+              <0xe1400000 0x8000>,
+              <0xe1c00000 0x1000>,
+              <0x17400000 0x4>,
+              <0x17c00000 0x4>;
+        reg-names = "ebunand", "hsnand", "nand_cs0", "nand_cs1",
+                    "addr_sel0", "addr_sel1";
+        clocks = <&cgu0 125>;
+        dmas = <&dma0 8>, <&dma0 9>;
+        dma-names = "tx", "rx";
+        #address-cells = <1>;
+        #size-cells = <0>;
 
-      nand@0 {
-        reg = <0>;
-        nand-ecc-mode = "hw";
-      };
+        nand@0 {
+            reg = <0>;
+            nand-ecc-mode = "hw";
+        };
     };
 
 ...
diff --git a/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml b/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
index 8cc2a7ceb5fb..ea9450fe7c9f 100644
--- a/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
+++ b/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
@@ -34,13 +34,13 @@ unevaluatedProperties: false
 examples:
   - |
     spi {
-      #address-cells = <1>;
-      #size-cells = <0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
 
-      eeram@0 {
-        compatible = "microchip,48l640";
-        reg = <0>;
-        spi-max-frequency = <20000000>;
-      };
+        eeram@0 {
+            compatible = "microchip,48l640";
+            reg = <0>;
+            spi-max-frequency = <20000000>;
+        };
     };
 ...
diff --git a/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml b/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
index 681a51f5257c..61d12bda356e 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
@@ -41,22 +41,22 @@ examples:
   - |
     /* Example declaring dynamic partition */
     flash {
-      partitions {
-        compatible = "qcom,smem-part";
+        partitions {
+            compatible = "qcom,smem-part";
 
-        partition-art {
-          compatible = "nvmem-cells";
-          #address-cells = <1>;
-          #size-cells = <1>;
-          label = "0:art";
+            partition-art {
+                compatible = "nvmem-cells";
+                #address-cells = <1>;
+                #size-cells = <1>;
+                label = "0:art";
 
-          macaddr_art_0: macaddr@0 {
-            reg = <0x0 0x6>;
-          };
+                macaddr_art_0: macaddr@0 {
+                    reg = <0x0 0x6>;
+                };
 
-          macaddr_art_6: macaddr@6 {
-            reg = <0x6 0x6>;
-          };
+                macaddr_art_6: macaddr@6 {
+                    reg = <0x6 0x6>;
+                };
+            };
         };
-      };
     };
diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
index 3cc90c64e974..07024ee45951 100644
--- a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
+++ b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
@@ -136,85 +136,85 @@ examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
     nand-controller@1ac00000 {
-      compatible = "qcom,ipq806x-nand";
-      reg = <0x1ac00000 0x800>;
+        compatible = "qcom,ipq806x-nand";
+        reg = <0x1ac00000 0x800>;
 
-      clocks = <&gcc EBI2_CLK>,
-               <&gcc EBI2_AON_CLK>;
-      clock-names = "core", "aon";
+        clocks = <&gcc EBI2_CLK>,
+                 <&gcc EBI2_AON_CLK>;
+        clock-names = "core", "aon";
 
-      dmas = <&adm_dma 3>;
-      dma-names = "rxtx";
-      qcom,cmd-crci = <15>;
-      qcom,data-crci = <3>;
+        dmas = <&adm_dma 3>;
+        dma-names = "rxtx";
+        qcom,cmd-crci = <15>;
+        qcom,data-crci = <3>;
 
-      #address-cells = <1>;
-      #size-cells = <0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
 
-      nand@0 {
-        reg = <0>;
+        nand@0 {
+            reg = <0>;
 
-        nand-ecc-strength = <4>;
-        nand-bus-width = <8>;
+            nand-ecc-strength = <4>;
+            nand-bus-width = <8>;
 
-        qcom,boot-partitions = <0x0 0x58a0000>;
+            qcom,boot-partitions = <0x0 0x58a0000>;
 
-        partitions {
-          compatible = "fixed-partitions";
-          #address-cells = <1>;
-          #size-cells = <1>;
+            partitions {
+                compatible = "fixed-partitions";
+                #address-cells = <1>;
+                #size-cells = <1>;
 
-          partition@0 {
-            label = "boot-nand";
-            reg = <0 0x58a0000>;
-          };
+                partition@0 {
+                    label = "boot-nand";
+                    reg = <0 0x58a0000>;
+                };
 
-          partition@58a0000 {
-            label = "fs-nand";
-            reg = <0x58a0000 0x4000000>;
-          };
+                partition@58a0000 {
+                    label = "fs-nand";
+                    reg = <0x58a0000 0x4000000>;
+                };
+            };
         };
-      };
     };
 
     #include <dt-bindings/clock/qcom,gcc-ipq4019.h>
     nand-controller@79b0000 {
-      compatible = "qcom,ipq4019-nand";
-      reg = <0x79b0000 0x1000>;
+        compatible = "qcom,ipq4019-nand";
+        reg = <0x79b0000 0x1000>;
 
-      clocks = <&gcc GCC_QPIC_CLK>,
-               <&gcc GCC_QPIC_AHB_CLK>;
-      clock-names = "core", "aon";
+        clocks = <&gcc GCC_QPIC_CLK>,
+                 <&gcc GCC_QPIC_AHB_CLK>;
+        clock-names = "core", "aon";
 
-      dmas = <&qpicbam 0>,
-             <&qpicbam 1>,
-             <&qpicbam 2>;
-      dma-names = "tx", "rx", "cmd";
+        dmas = <&qpicbam 0>,
+               <&qpicbam 1>,
+               <&qpicbam 2>;
+        dma-names = "tx", "rx", "cmd";
 
-      #address-cells = <1>;
-      #size-cells = <0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
 
-      nand@0 {
-        reg = <0>;
-        nand-ecc-strength = <4>;
-        nand-bus-width = <8>;
+        nand@0 {
+            reg = <0>;
+            nand-ecc-strength = <4>;
+            nand-bus-width = <8>;
 
-        partitions {
-          compatible = "fixed-partitions";
-          #address-cells = <1>;
-          #size-cells = <1>;
+            partitions {
+                compatible = "fixed-partitions";
+                #address-cells = <1>;
+                #size-cells = <1>;
 
-          partition@0 {
-            label = "boot-nand";
-            reg = <0 0x58a0000>;
-          };
+                partition@0 {
+                    label = "boot-nand";
+                    reg = <0 0x58a0000>;
+                };
 
-          partition@58a0000 {
-            label = "fs-nand";
-            reg = <0x58a0000 0x4000000>;
-          };
+                partition@58a0000 {
+                    label = "fs-nand";
+                    reg = <0x58a0000 0x4000000>;
+                };
+            };
         };
-      };
     };
 
 ...
diff --git a/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml b/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
index eab8ea3da1fa..8cbfa1504a0f 100644
--- a/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
@@ -101,31 +101,32 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/clock/stm32mp1-clks.h>
     #include <dt-bindings/reset/stm32mp1-resets.h>
+
     nand-controller@58002000 {
-      compatible = "st,stm32mp15-fmc2";
-      reg = <0x58002000 0x1000>,
-            <0x80000000 0x1000>,
-            <0x88010000 0x1000>,
-            <0x88020000 0x1000>,
-            <0x81000000 0x1000>,
-            <0x89010000 0x1000>,
-            <0x89020000 0x1000>;
-      interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-      dmas = <&mdma1 20 0x2 0x12000a02 0x0 0x0>,
-             <&mdma1 20 0x2 0x12000a08 0x0 0x0>,
-             <&mdma1 21 0x2 0x12000a0a 0x0 0x0>;
-      dma-names = "tx", "rx", "ecc";
-      clocks = <&rcc FMC_K>;
-      resets = <&rcc FMC_R>;
-      #address-cells = <1>;
-      #size-cells = <0>;
-
-      nand@0 {
-        reg = <0>;
-        nand-on-flash-bbt;
+        compatible = "st,stm32mp15-fmc2";
+        reg = <0x58002000 0x1000>,
+              <0x80000000 0x1000>,
+              <0x88010000 0x1000>,
+              <0x88020000 0x1000>,
+              <0x81000000 0x1000>,
+              <0x89010000 0x1000>,
+              <0x89020000 0x1000>;
+        interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&mdma1 20 0x2 0x12000a02 0x0 0x0>,
+               <&mdma1 20 0x2 0x12000a08 0x0 0x0>,
+               <&mdma1 21 0x2 0x12000a0a 0x0 0x0>;
+        dma-names = "tx", "rx", "ecc";
+        clocks = <&rcc FMC_K>;
+        resets = <&rcc FMC_R>;
         #address-cells = <1>;
-        #size-cells = <1>;
-      };
+        #size-cells = <0>;
+
+        nand@0 {
+            reg = <0>;
+            nand-on-flash-bbt;
+            #address-cells = <1>;
+            #size-cells = <1>;
+        };
     };
 
 ...
diff --git a/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.yaml b/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.yaml
index 30b458c41cac..4774c92e7fc4 100644
--- a/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.yaml
+++ b/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.yaml
@@ -44,26 +44,26 @@ additionalProperties: false
 examples:
   - |
     bus {
-      #address-cells = <2>;
-      #size-cells = <2>;
-
-      hbmc: memory-controller@47034000 {
-        compatible = "ti,am654-hbmc";
-        reg = <0x0 0x47034000 0x0 0x100>,
-              <0x5 0x00000000 0x1 0x0000000>;
-        ranges = <0x0 0x0 0x5 0x00000000 0x4000000>, /* CS0 - 64MB */
-                 <0x1 0x0 0x5 0x04000000 0x4000000>; /* CS1 - 64MB */
-        clocks = <&k3_clks 102 0>;
         #address-cells = <2>;
-        #size-cells = <1>;
-        power-domains = <&k3_pds 55>;
-        mux-controls = <&hbmc_mux 0>;
+        #size-cells = <2>;
 
-        flash@0,0 {
-            compatible = "cypress,hyperflash", "cfi-flash";
-            reg = <0x0 0x0 0x4000000>;
-            #address-cells = <1>;
+        hbmc: memory-controller@47034000 {
+            compatible = "ti,am654-hbmc";
+            reg = <0x0 0x47034000 0x0 0x100>,
+                  <0x5 0x00000000 0x1 0x0000000>;
+            ranges = <0x0 0x0 0x5 0x00000000 0x4000000>, /* CS0 - 64MB */
+                     <0x1 0x0 0x5 0x04000000 0x4000000>; /* CS1 - 64MB */
+            clocks = <&k3_clks 102 0>;
+            #address-cells = <2>;
             #size-cells = <1>;
+            power-domains = <&k3_pds 55>;
+            mux-controls = <&hbmc_mux 0>;
+
+            flash@0,0 {
+                compatible = "cypress,hyperflash", "cfi-flash";
+                reg = <0x0 0x0 0x4000000>;
+                #address-cells = <1>;
+                #size-cells = <1>;
+            };
         };
-      };
     };
-- 
2.34.1

