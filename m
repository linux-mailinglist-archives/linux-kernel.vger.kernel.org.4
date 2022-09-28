Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61F15EDDD7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbiI1Nhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiI1NhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:37:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD508E0FE
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:37:22 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:37:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664372241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/NINyt4Uhofa1CE+aymmvyr+1iZ69Xlf+vQbmz4Zwms=;
        b=JKjA4bUxMnCr8n0SPvQWHo06b+8Q8dC5JkMo/2fD9rYHY6pMZI/W8k36SemYrW2Mn397qB
        CllFmbJ83XNNHjmlW65KZhVgbSkHXZOqQfeomzUcrt1yfFoaXMGd3lWNhPoIuSHgfysO4e
        p2UHtgxYEqq+w7xjrNZLjHKwwm0ryzklZIn7hBLS44s9OFfDWRAO8psOyWvaIpkL7i5WuL
        wsGrTLb4OhlQ8p3X7EicDwkNHODO5isvMY3opaCJXbs1+6N6HtTPQeT9Uk2nTW4bfoSWhy
        Pwjj7lUMbMDR0tpglE3FuYNJlADG23ziyZhBpNkSn4JnfW7ctBeGMPdcamIm6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664372241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/NINyt4Uhofa1CE+aymmvyr+1iZ69Xlf+vQbmz4Zwms=;
        b=4h14V5DYZ1oYiaSne70/KDyLULvhWjxpH1uOFpNuUVYwYf8fdmT5tu0tCDpvlaPUKdqqBZ
        hAX2c7zFIY2o9eDA==
From:   "irqchip-bot for Sander Vanheule" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller:
 realtek,rtl-intc: require parents
Cc:     Sander Vanheule <sander@svanheule.net>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3Cba3ae8e521ef82dd94f18a602ef53078f4a0d8d5=2E16636?=
 =?utf-8?q?17425=2Egit=2Esander=40svanheule=2Enet=3E?=
References: =?utf-8?q?=3Cba3ae8e521ef82dd94f18a602ef53078f4a0d8d5=2E166361?=
 =?utf-8?q?7425=2Egit=2Esander=40svanheule=2Enet=3E?=
MIME-Version: 1.0
Message-ID: <166437224002.401.948306580117114957.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     a3e77b70f19240f8a52bbe1c703aa8db6a8f7450
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/a3e77b70f19240f8a52bbe1c703aa8db6a8f7450
Author:        Sander Vanheule <sander@svanheule.net>
AuthorDate:    Mon, 19 Sep 2022 22:24:42 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 28 Sep 2022 14:17:10 +01:00

dt-bindings: interrupt-controller: realtek,rtl-intc: require parents

The interrupt router has 32 inputs, and up to 15 outputs connected to
the MIPS CPU's interrupts. The way these are mapped to each other is
runtime configurable. This controller can also mask individual interrupt
sources, and has a status register to indicate pending interrupts. This
means the controller is not transparent, and the use of "interrupt-map"
inappropriate. Instead, a list of parent interrupts should be specified.

Two-part compatibles are introduced to be able to require "interrupts"
for new devicetrees. For backward compatibility "interrupt-map" is still
allowed on these new compatibles, but deprecated. The old compatible,
with required "interrupt-map" and "#address-cells", is also deprecated.
The relevant descriptions are added or extended to more clearly describe
the functionality of this controller.

To prevent spurious changes to the binding when more SoCs are added,
"allOf" is used with one "if", and the compatible enum only has one
item.

The example is updated to provide a correct example for RTL8380 SoCs.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/ba3ae8e521ef82dd94f18a602ef53078f4a0d8d5.1663617425.git.sander@svanheule.net
---
 Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml | 60 +++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
index 9e76fff..13a893b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
@@ -6,6 +6,14 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Realtek RTL SoC interrupt controller devicetree bindings
 
+description:
+  Interrupt controller and router for Realtek MIPS SoCs, allowing each SoC
+  interrupt to be routed to one parent CPU (hardware) interrupt, or left
+  disconnected.
+  All connected input lines from SoC peripherals can be masked individually,
+  and an interrupt status register is present to indicate which interrupts are
+  pending.
+
 maintainers:
   - Birger Koblitz <mail@birger-koblitz.de>
   - Bert Vermeulen <bert@biot.com>
@@ -13,23 +21,33 @@ maintainers:
 
 properties:
   compatible:
-    const: realtek,rtl-intc
+    oneOf:
+      - items:
+          - enum:
+              - realtek,rtl8380-intc
+          - const: realtek,rtl-intc
+      - const: realtek,rtl-intc
+        deprecated: true
 
   "#interrupt-cells":
+    description:
+      SoC interrupt line index.
     const: 1
 
   reg:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 15
+    description:
+      List of parent interrupts, in the order that they are connected to this
+      interrupt router's outputs, starting at the first output.
 
   interrupt-controller: true
 
-  "#address-cells":
-    const: 0
-
   interrupt-map:
+    deprecated: true
     description: Describes mapping from SoC interrupts to CPU interrupts
 
 required:
@@ -37,21 +55,33 @@ required:
   - reg
   - "#interrupt-cells"
   - interrupt-controller
-  - "#address-cells"
-  - interrupt-map
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: realtek,rtl-intc
+    then:
+      properties:
+        "#address-cells":
+          const: 0
+      required:
+        - "#address-cells"
+        - interrupt-map
+    else:
+      required:
+        - interrupts
 
 additionalProperties: false
 
 examples:
   - |
-    intc: interrupt-controller@3000 {
-      compatible = "realtek,rtl-intc";
+    interrupt-controller@3000 {
+      compatible = "realtek,rtl8380-intc", "realtek,rtl-intc";
       #interrupt-cells = <1>;
       interrupt-controller;
-      reg = <0x3000 0x20>;
-      #address-cells = <0>;
-      interrupt-map =
-              <31 &cpuintc 2>,
-              <30 &cpuintc 1>,
-              <29 &cpuintc 5>;
+      reg = <0x3000 0x18>;
+
+      interrupt-parent = <&cpuintc>;
+      interrupts = <2>, <3>, <4>, <5>, <6>;
     };
