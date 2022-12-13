Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888D464B117
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiLMIZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbiLMIZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:25:08 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 736DE13D0A;
        Tue, 13 Dec 2022 00:25:07 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 13 Dec 2022 17:25:04 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 87D622058B4F;
        Tue, 13 Dec 2022 17:25:04 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 13 Dec 2022 17:25:04 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 2B9F9A855F;
        Tue, 13 Dec 2022 17:25:04 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 07/17] dt-bindings: phy: Fix node descriptions in uniphier-phy example
Date:   Tue, 13 Dec 2022 17:24:39 +0900
Message-Id: <20221213082449.2721-8-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
References: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to adding dt-bindings for SoC-dependent controllers, rename the
phy nodes and their parent nodes to the generic names in the example.

And drop parent nodes of each phy as they are not directly necessary here.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../phy/socionext,uniphier-ahci-phy.yaml      | 24 ++++-------
 .../phy/socionext,uniphier-usb2-phy.yaml      | 41 ++++++++-----------
 .../phy/socionext,uniphier-usb3hs-phy.yaml    | 29 +++++--------
 .../phy/socionext,uniphier-usb3ss-phy.yaml    | 26 ++++--------
 4 files changed, 46 insertions(+), 74 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
index a3cd45acea28..de3cffc850bc 100644
--- a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
@@ -117,20 +117,12 @@ additionalProperties: false
 
 examples:
   - |
-    ahci-glue@65700000 {
-        compatible = "socionext,uniphier-pxs3-ahci-glue",
-                     "simple-mfd";
-        #address-cells = <1>;
-        #size-cells = <1>;
-        ranges = <0 0x65700000 0x100>;
-
-        ahci_phy: phy@10 {
-            compatible = "socionext,uniphier-pxs3-ahci-phy";
-            reg = <0x10 0x10>;
-            #phy-cells = <0>;
-            clock-names = "link", "phy";
-            clocks = <&sys_clk 28>, <&sys_clk 30>;
-            reset-names = "link", "phy";
-            resets = <&sys_rst 28>, <&sys_rst 30>;
-        };
+    ahci_phy: phy@10 {
+        compatible = "socionext,uniphier-pxs3-ahci-phy";
+        reg = <0x10 0x10>;
+        #phy-cells = <0>;
+        clock-names = "link", "phy";
+        clocks = <&sys_clk 28>, <&sys_clk 30>;
+        reset-names = "link", "phy";
+        resets = <&sys_rst 28>, <&sys_rst 30>;
     };
diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb2-phy.yaml
index 63dab914a48d..19522c54f448 100644
--- a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb2-phy.yaml
@@ -61,28 +61,23 @@ examples:
   - |
     // The UniPhier usb2-phy should be a subnode of a "syscon" compatible node.
 
-    soc-glue@5f800000 {
-        compatible = "socionext,uniphier-ld11-soc-glue", "simple-mfd", "syscon";
-        reg = <0x5f800000 0x2000>;
-
-        usb-controller {
-            compatible = "socionext,uniphier-ld11-usb2-phy";
-            #address-cells = <1>;
-            #size-cells = <0>;
-
-            usb_phy0: phy@0 {
-                reg = <0>;
-                #phy-cells = <0>;
-            };
-
-            usb_phy1: phy@1 {
-                reg = <1>;
-                #phy-cells = <0>;
-            };
-
-            usb_phy2: phy@2 {
-                reg = <2>;
-                #phy-cells = <0>;
-            };
+    usb-hub {
+        compatible = "socionext,uniphier-ld11-usb2-phy";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        usb_phy0: phy@0 {
+            reg = <0>;
+            #phy-cells = <0>;
+        };
+
+        usb_phy1: phy@1 {
+            reg = <1>;
+            #phy-cells = <0>;
+        };
+
+        usb_phy2: phy@2 {
+            reg = <2>;
+            #phy-cells = <0>;
         };
     };
diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
index 21e4414eea60..2107d98ace15 100644
--- a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
@@ -146,22 +146,15 @@ additionalProperties: false
 
 examples:
   - |
-    usb-glue@65b00000 {
-        compatible = "socionext,uniphier-ld20-dwc3-glue", "simple-mfd";
-        #address-cells = <1>;
-        #size-cells = <1>;
-        ranges = <0 0x65b00000 0x400>;
-
-        usb_hsphy0: hs-phy@200 {
-            compatible = "socionext,uniphier-ld20-usb3-hsphy";
-            reg = <0x200 0x10>;
-            #phy-cells = <0>;
-            clock-names = "link", "phy";
-            clocks = <&sys_clk 14>, <&sys_clk 16>;
-            reset-names = "link", "phy";
-            resets = <&sys_rst 14>, <&sys_rst 16>;
-            vbus-supply = <&usb_vbus0>;
-            nvmem-cell-names = "rterm", "sel_t", "hs_i";
-            nvmem-cells = <&usb_rterm0>, <&usb_sel_t0>, <&usb_hs_i0>;
-        };
+    usb_hsphy0: phy@200 {
+        compatible = "socionext,uniphier-ld20-usb3-hsphy";
+        reg = <0x200 0x10>;
+        #phy-cells = <0>;
+        clock-names = "link", "phy";
+        clocks = <&sys_clk 14>, <&sys_clk 16>;
+        reset-names = "link", "phy";
+        resets = <&sys_rst 14>, <&sys_rst 16>;
+        vbus-supply = <&usb_vbus0>;
+        nvmem-cell-names = "rterm", "sel_t", "hs_i";
+        nvmem-cells = <&usb_rterm0>, <&usb_sel_t0>, <&usb_hs_i0>;
     };
diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
index 4c26d2d2303d..8f5aa6238bf3 100644
--- a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
@@ -131,21 +131,13 @@ additionalProperties: false
 
 examples:
   - |
-    usb-glue@65b00000 {
-        compatible = "socionext,uniphier-ld20-dwc3-glue",
-                     "simple-mfd";
-        #address-cells = <1>;
-        #size-cells = <1>;
-        ranges = <0 0x65b00000 0x400>;
-
-        usb_ssphy0: ss-phy@300 {
-            compatible = "socionext,uniphier-ld20-usb3-ssphy";
-            reg = <0x300 0x10>;
-            #phy-cells = <0>;
-            clock-names = "link", "phy";
-            clocks = <&sys_clk 14>, <&sys_clk 16>;
-            reset-names = "link", "phy";
-            resets = <&sys_rst 14>, <&sys_rst 16>;
-            vbus-supply = <&usb_vbus0>;
-        };
+    usb_ssphy0: phy@300 {
+        compatible = "socionext,uniphier-ld20-usb3-ssphy";
+        reg = <0x300 0x10>;
+        #phy-cells = <0>;
+        clock-names = "link", "phy";
+        clocks = <&sys_clk 14>, <&sys_clk 16>;
+        reset-names = "link", "phy";
+        resets = <&sys_rst 14>, <&sys_rst 16>;
+        vbus-supply = <&usb_vbus0>;
     };
-- 
2.25.1

