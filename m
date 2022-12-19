Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1715A651271
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiLSTLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiLSTLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:11:00 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42954DFE7;
        Mon, 19 Dec 2022 11:10:57 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1322d768ba7so12737096fac.5;
        Mon, 19 Dec 2022 11:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHyNrMLw9TVdwvo9glGPtmC9whUFGDHMxj6CFCq5jcQ=;
        b=Ucs6/9s0KQnLYQPCEq3fFyKZKjRD2OrC/pFSCmkzUFsvbVFA21Zb0QY/tUw5SXiBbi
         TjR01k+21JZc8+P7v0eQf6rR+qtf+yQUwIna6Bj/+semOCq1lqxDNnLyF/PAhM6hP/AN
         b3eRWB74kGOb/DQUKa300XwieknEB2x/Llj3PUnUoDsHbL5wXQbpz3g36ROME63c3J9N
         2VPu4KSAwB1waxUkn10z1o9b16claTvbFUPUI6/C1SfnMh0CGioxEFov9M8N5VXR8z9J
         BSOLu7dpZGkcFoHuzOBts3Tsqm5SbIhzvOEY1F9z6L6lSgGzNxobQ5G7PORJzMVNXWNf
         vxjA==
X-Gm-Message-State: ANoB5pn7YXXjnEnSgle92Xp51Rm02czU8nsSOFOn/yO1NAdfAC1iWkUY
        chFpi0d5WPQcc6zaHdJBOg==
X-Google-Smtp-Source: AA0mqf4ztAfqoCZ6mZ2cdyIEJB0UEQoy+ZFvktD++nPsr/zZhNIUv1aPDTv895sfSbNoXEc2hhllRg==
X-Received: by 2002:a05:6870:c10e:b0:144:54b3:750 with SMTP id f14-20020a056870c10e00b0014454b30750mr21813961oad.12.1671477057063;
        Mon, 19 Dec 2022 11:10:57 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w11-20020a056870430b00b001447602267esm5007095oah.41.2022.12.19.11.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:10:56 -0800 (PST)
Received: (nullmailer pid 1974257 invoked by uid 1000);
        Mon, 19 Dec 2022 19:10:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        Johan Jonker <jbx6244@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: usb: rockchip,dwc3: Move RK3399 to its own schema
Date:   Mon, 19 Dec 2022 13:10:38 -0600
Message-Id: <20221219191038.1973807-2-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221219191038.1973807-1-robh@kernel.org>
References: <20221219191038.1973807-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rockchip,dwc3.yaml schema defines a single DWC3 node, but the RK3399
uses the discouraged parent wrapper node and child 'generic' DWC3 node.
The intent was to modify the RK3399 DTs to use a single node, but the DT
changes were rejected for ABI reasons. However, the schema was accepted
as-is.

To fix this, we need to move the RK3399 binding to its own schema file.
The RK3328 and RK3568 bindings are correct and use a single node.

Cc: Johan Jonker <jbx6244@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/usb/rockchip,dwc3.yaml           |  10 +-
 .../bindings/usb/rockchip,rk3399-dwc3.yaml    | 115 ++++++++++++++++++
 2 files changed, 119 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/rockchip,rk3399-dwc3.yaml

diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
index b3798d94d2fd..edb130c780e4 100644
--- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
@@ -29,7 +29,6 @@ select:
       contains:
         enum:
           - rockchip,rk3328-dwc3
-          - rockchip,rk3399-dwc3
           - rockchip,rk3568-dwc3
   required:
     - compatible
@@ -39,7 +38,6 @@ properties:
     items:
       - enum:
           - rockchip,rk3328-dwc3
-          - rockchip,rk3399-dwc3
           - rockchip,rk3568-dwc3
       - const: snps,dwc3
 
@@ -90,7 +88,7 @@ required:
 
 examples:
   - |
-    #include <dt-bindings/clock/rk3399-cru.h>
+    #include <dt-bindings/clock/rk3328-cru.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     bus {
@@ -98,11 +96,11 @@ examples:
       #size-cells = <2>;
 
       usbdrd3_0: usb@fe800000 {
-        compatible = "rockchip,rk3399-dwc3", "snps,dwc3";
+        compatible = "rockchip,rk3328-dwc3", "snps,dwc3";
         reg = <0x0 0xfe800000 0x0 0x100000>;
         interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
-        clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
-                 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_GRF>;
+        clocks = <&cru SCLK_USB3OTG_REF>, <&cru SCLK_USB3OTG_SUSPEND>,
+                <&cru ACLK_USB3OTG>;
         clock-names = "ref_clk", "suspend_clk",
                       "bus_clk", "grf_clk";
         dr_mode = "otg";
diff --git a/Documentation/devicetree/bindings/usb/rockchip,rk3399-dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,rk3399-dwc3.yaml
new file mode 100644
index 000000000000..e39a8a3a7ab3
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/rockchip,rk3399-dwc3.yaml
@@ -0,0 +1,115 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/rockchip,rk3399-dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip RK3399 SuperSpeed DWC3 USB SoC controller
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    const: rockchip,rk3399-dwc3
+
+  '#address-cells':
+    const: 2
+
+  '#size-cells':
+    const: 2
+
+  ranges: true
+
+  clocks:
+    items:
+      - description:
+          Controller reference clock, must to be 24 MHz
+      - description:
+          Controller suspend clock, must to be 24 MHz or 32 KHz
+      - description:
+          Master/Core clock, must to be >= 62.5 MHz for SS
+          operation and >= 30MHz for HS operation
+      - description:
+          USB3 aclk peri
+      - description:
+          USB3 aclk
+      - description:
+          Controller grf clock
+
+  clock-names:
+    items:
+      - const: ref_clk
+      - const: suspend_clk
+      - const: bus_clk
+      - const: aclk_usb3_rksoc_axi_perf
+      - const: aclk_usb3
+      - const: grf_clk
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: usb3-otg
+
+patternProperties:
+  '^usb@':
+    $ref: snps,dwc3.yaml#
+
+additionalProperties: false
+
+required:
+  - compatible
+  - '#address-cells'
+  - '#size-cells'
+  - ranges
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3399-cru.h>
+    #include <dt-bindings/power/rk3399-power.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        usb {
+            compatible = "rockchip,rk3399-dwc3";
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges;
+            clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
+              <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_RKSOC_AXI_PERF>,
+              <&cru ACLK_USB3>, <&cru ACLK_USB3_GRF>;
+            clock-names = "ref_clk", "suspend_clk",
+                    "bus_clk", "aclk_usb3_rksoc_axi_perf",
+                    "aclk_usb3", "grf_clk";
+            resets = <&cru SRST_A_USB3_OTG0>;
+            reset-names = "usb3-otg";
+
+            usb@fe800000 {
+                compatible = "snps,dwc3";
+                reg = <0x0 0xfe800000 0x0 0x100000>;
+                interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH 0>;
+                clocks = <&cru SCLK_USB3OTG0_REF>, <&cru ACLK_USB3OTG0>,
+                  <&cru SCLK_USB3OTG0_SUSPEND>;
+                clock-names = "ref", "bus_early", "suspend";
+                dr_mode = "otg";
+                phys = <&u2phy0_otg>, <&tcphy0_usb3>;
+                phy-names = "usb2-phy", "usb3-phy";
+                phy_type = "utmi_wide";
+                snps,dis_enblslpm_quirk;
+                snps,dis-u2-freeclk-exists-quirk;
+                snps,dis_u2_susphy_quirk;
+                snps,dis-del-phy-power-chg-quirk;
+                snps,dis-tx-ipgap-linecheck-quirk;
+                power-domains = <&power RK3399_PD_USB3>;
+            };
+        };
+    };
+...
-- 
2.35.1

