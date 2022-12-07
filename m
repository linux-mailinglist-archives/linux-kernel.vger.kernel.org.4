Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4646453AD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiLGFyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiLGFye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:54:34 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE27C58BDE;
        Tue,  6 Dec 2022 21:54:32 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 07 Dec 2022 14:54:31 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 4D3652059054;
        Wed,  7 Dec 2022 14:54:31 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 7 Dec 2022 14:54:31 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id B9C371DA5;
        Wed,  7 Dec 2022 14:54:30 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 06/16] dt-bindings: phy: Fix node descriptions in uniphier-phy example
Date:   Wed,  7 Dec 2022 14:53:55 +0900
Message-Id: <20221207055405.30940-7-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
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

And also add missing reg property for the parent nodes.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml | 1 +
 .../devicetree/bindings/phy/socionext,uniphier-usb2-phy.yaml | 4 ++--
 .../bindings/phy/socionext,uniphier-usb3hs-phy.yaml          | 5 +++--
 .../bindings/phy/socionext,uniphier-usb3ss-phy.yaml          | 5 +++--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
index a3cd45acea28..b3928c519b08 100644
--- a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
@@ -120,6 +120,7 @@ examples:
     ahci-glue@65700000 {
         compatible = "socionext,uniphier-pxs3-ahci-glue",
                      "simple-mfd";
+        reg = <0x65700000 0x100>;
         #address-cells = <1>;
         #size-cells = <1>;
         ranges = <0 0x65700000 0x100>;
diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb2-phy.yaml
index 63dab914a48d..5d93feb2758d 100644
--- a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb2-phy.yaml
@@ -61,11 +61,11 @@ examples:
   - |
     // The UniPhier usb2-phy should be a subnode of a "syscon" compatible node.
 
-    soc-glue@5f800000 {
+    syscon@5f800000 {
         compatible = "socionext,uniphier-ld11-soc-glue", "simple-mfd", "syscon";
         reg = <0x5f800000 0x2000>;
 
-        usb-controller {
+        usb-hub {
             compatible = "socionext,uniphier-ld11-usb2-phy";
             #address-cells = <1>;
             #size-cells = <0>;
diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
index 21e4414eea60..2dbdc14a03d9 100644
--- a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
@@ -146,13 +146,14 @@ additionalProperties: false
 
 examples:
   - |
-    usb-glue@65b00000 {
+    usb@65b00000 {
         compatible = "socionext,uniphier-ld20-dwc3-glue", "simple-mfd";
+        reg = <0x65b00000 0x400>;
         #address-cells = <1>;
         #size-cells = <1>;
         ranges = <0 0x65b00000 0x400>;
 
-        usb_hsphy0: hs-phy@200 {
+        usb_hsphy0: phy@200 {
             compatible = "socionext,uniphier-ld20-usb3-hsphy";
             reg = <0x200 0x10>;
             #phy-cells = <0>;
diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
index 4c26d2d2303d..f52dc5289dec 100644
--- a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
@@ -131,14 +131,15 @@ additionalProperties: false
 
 examples:
   - |
-    usb-glue@65b00000 {
+    usb@65b00000 {
         compatible = "socionext,uniphier-ld20-dwc3-glue",
                      "simple-mfd";
+        reg = <0x65b00000 0x400>;
         #address-cells = <1>;
         #size-cells = <1>;
         ranges = <0 0x65b00000 0x400>;
 
-        usb_ssphy0: ss-phy@300 {
+        usb_ssphy0: phy@300 {
             compatible = "socionext,uniphier-ld20-usb3-ssphy";
             reg = <0x300 0x10>;
             #phy-cells = <0>;
-- 
2.25.1

