Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9244B640820
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbiLBOEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiLBOED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:04:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A294CCFF0;
        Fri,  2 Dec 2022 06:04:02 -0800 (PST)
Date:   Fri, 02 Dec 2022 14:03:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669989841;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5rlHz8XlHt/XX0ZCvLXfAi7Gf1XyWML+bixzqO6UKZI=;
        b=0VbE4Kf84dWpASqDL85we6j7kF8UWPh8skDDCiKSwi1HNJO9EFUCnl0fLAKMcUQm+DXdIR
        MVY/NxmTJwZSEro4/GxE42x5CnXuAb5XkiTjCcx0a4z9UBxnY4wOH6tiCtkULxLhEpqFgH
        EZVs23w/ZohUpCZaGCSMv0NyDiClCpNv68+YsbdsAL9Q5VChUzVRloV3rcFdss5As3m8EB
        kG5QvC3jLuTcunK/BvD96D1pn8Ar0sLpCXkcXCTu5wgidZpHv0pudOrbBUcSDfdimmyGaN
        hXro2PER3D6cec37l4QXU2HExJ3AnrEG9ru1QYnEyLVKGTgDdNEtL5cLpiBunw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669989841;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5rlHz8XlHt/XX0ZCvLXfAi7Gf1XyWML+bixzqO6UKZI=;
        b=g3V6xq1m0v6OI/7hd0eVIiqG9JQ8A1kEgtGL5KvSgXTAa3QK4PNIStMIuCfEJjB54ITW9q
        cIOqBNHmoByfKRCg==
From:   "tip-bot2 for Rahul Tanwar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] dt-bindings: x86: apic: Introduce new optional bool
 property for lapic
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124084143.21841-3-rtanwar@maxlinear.com>
References: <20221124084143.21841-3-rtanwar@maxlinear.com>
MIME-Version: 1.0
Message-ID: <166998983993.4906.3074674764241043132.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     b3a9801cccefda304263b4e84e9dfe49057f3c29
Gitweb:        https://git.kernel.org/tip/b3a9801cccefda304263b4e84e9dfe49057f3c29
Author:        Rahul Tanwar <rtanwar@maxlinear.com>
AuthorDate:    Thu, 24 Nov 2022 16:41:41 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Dec 2022 14:57:14 +01:00

dt-bindings: x86: apic: Introduce new optional bool property for lapic

X86 defines a few possible interrupt delivery modes. With respect to
boot/init time, mainly two interrupt delivery modes are possible.

 - PIC Mode: Legacy external 8259 compliant PIC interrupt controller
 - Virtual Wire Mode: Use lapic as virtual wire interrupt delivery mode

ACPI and MPS spec compliant systems provide this information, but for OF
based systems, it is by default set to PIC mode.

In fact it is hardcoded to legacy PIC mode for OF based x86 systems with no
option to choose the configuration between PIC mode & virtual wire mode.

For this purpose, introduce a new boolean property for the lapic interrupt
controller node which allows to configure it for virtual wire mode as well.

Property name: 'intel,virtual-wire-mode'
Type: Boolean

If not present/not defined, interrupt delivery mode defaults to legacy PIC
mode. If present/defined, interrupt delivery mode is set to virtual wire
mode.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20221124084143.21841-3-rtanwar@maxlinear.com

---
 Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml
index 55184cb..d2d0145 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml
@@ -39,6 +39,19 @@ properties:
   '#interrupt-cells':
     const: 2
 
+  intel,virtual-wire-mode:
+    description: Intel defines a few possible interrupt delivery
+      modes. With respect to boot/init time, mainly two interrupt
+      delivery modes are possible.
+      PIC Mode - Legacy external 8259 compliant PIC interrupt controller.
+      Virtual Wire Mode - use lapic as virtual wire interrupt delivery mode.
+      For ACPI or MPS spec compliant systems, it is figured out by some read
+      only bit field/s available in their respective defined data structures.
+      For OF based systems, it is by default set to PIC mode.
+      But if this optional boolean property is set, then the interrupt delivery
+      mode is configured to virtual wire compatibility mode.
+    type: boolean
+
 required:
   - compatible
   - reg
@@ -54,4 +67,5 @@ examples:
         reg = <0xfee00000 0x1000>;
         interrupt-controller;
         #interrupt-cells = <2>;
+        intel,virtual-wire-mode;
     };
