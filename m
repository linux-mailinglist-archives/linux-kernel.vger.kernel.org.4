Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B207640823
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbiLBOEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbiLBOEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:04:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD6FDB0D4;
        Fri,  2 Dec 2022 06:04:03 -0800 (PST)
Date:   Fri, 02 Dec 2022 14:04:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669989842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OleVYyYSdQrxftbsACgnFpgQoQycL2+GNpbF6ZQYJrI=;
        b=BKZNh8ZQlwJvPl73s8bMT7PK0+0ye7x6fWVRqZtbpcCnnoWsySZZCTt8J/BsVK9LnO37Bb
        0h5h2OMbazmkA/dh0924eALKJMO6p3IJR++XWpXPDsJZ74ntro1VZS952rxtXcimpja9sL
        h8Ni/kILAUxXJKB4VlZeRlv/F3ezULMD1ECRFQzWMpFASbxbs9Vkhxq0YJc36mQg0QVfCg
        w/yVseP652LXDZUSg9Gm6yHFrA8KOxG9C/qfyql7addQsllr1tlvINNMXPLEOpHIEwqN15
        tI2TnWO9d/C20rcfFeD4bXVcQ0kXeN5xdxVo+E0Yo9A5rm6O2sIovJ802D/Xrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669989842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OleVYyYSdQrxftbsACgnFpgQoQycL2+GNpbF6ZQYJrI=;
        b=QZDw597VQd+pJ7fOdrBMA8proigShsAde646+0LLWi7b2xV18sQt+EddUHkVvMlAopO3+g
        Evt52/gD+Gbo14CA==
From:   "tip-bot2 for Rahul Tanwar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] dt-bindings: x86: apic: Convert Intel's APIC bindings
 to YAML schema
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124084143.21841-2-rtanwar@maxlinear.com>
References: <20221124084143.21841-2-rtanwar@maxlinear.com>
MIME-Version: 1.0
Message-ID: <166998984109.4906.13787701827607564768.tip-bot2@tip-bot2>
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

Commit-ID:     2b822f474621bb2f4f21dd6dae6900e2ccca7e95
Gitweb:        https://git.kernel.org/tip/2b822f474621bb2f4f21dd6dae6900e2ccca7e95
Author:        Rahul Tanwar <rtanwar@maxlinear.com>
AuthorDate:    Thu, 24 Nov 2022 16:41:40 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Dec 2022 14:57:13 +01:00

dt-bindings: x86: apic: Convert Intel's APIC bindings to YAML schema

The DT bindings for X86 local APIC (lapic) and I/O APIC (ioapic) are
outdated. Rework them:

   - Convert the bindings for lapic and ioapic from text to YAML schema.
   - Separate lapic & ioapic schemas.
   - Add missing but required standard properties
   - Add missing descriptions

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20221124084143.21841-2-rtanwar@maxlinear.com

---
 Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.txt  | 26 --------------------------
 Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.yaml | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml  | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.txt b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.txt
deleted file mode 100644
index 7d19f49..0000000
--- a/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Interrupt chips
----------------
-
-* Intel I/O Advanced Programmable Interrupt Controller (IO APIC)
-
-  Required properties:
-  --------------------
-     compatible = "intel,ce4100-ioapic";
-     #interrupt-cells = <2>;
-
-  Device's interrupt property:
-
-     interrupts = <P S>;
-
-  The first number (P) represents the interrupt pin which is wired to the
-  IO APIC. The second number (S) represents the sense of interrupt which
-  should be configured and can be one of:
-    0 - Edge Rising
-    1 - Level Low
-    2 - Level High
-    3 - Edge Falling
-
-* Local APIC
-  Required property:
-
-     compatible = "intel,ce4100-lapic";
diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.yaml b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.yaml
new file mode 100644
index 0000000..39ab8cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/interrupt-controller/intel,ce4100-ioapic.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel I/O Advanced Programmable Interrupt Controller (IO APIC)
+
+maintainers:
+  - Rahul Tanwar <rtanwar@maxlinear.com>
+
+description: |
+  Intel's Advanced Programmable Interrupt Controller (APIC) is a
+  family of interrupt controllers. The APIC is a split
+  architecture design, with a local component (LAPIC) integrated
+  into the processor itself and an external I/O APIC. Local APIC
+  (lapic) receives interrupts from the processor's interrupt pins,
+  from internal sources and from an external I/O APIC (ioapic).
+  And it sends these to the processor core for handling.
+  See [1] Chapter 8 for more details.
+
+  Many of the Intel's generic devices like hpet, ioapic, lapic have
+  the ce4100 name in their compatible property names because they
+  first appeared in CE4100 SoC.
+
+  This schema defines bindings for I/O APIC interrupt controller.
+
+  [1] https://pdos.csail.mit.edu/6.828/2008/readings/ia32/IA32-3A.pdf
+
+properties:
+  compatible:
+    const: intel,ce4100-ioapic
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    ioapic1: interrupt-controller@fec00000 {
+        compatible = "intel,ce4100-ioapic";
+        reg = <0xfec00000 0x1000>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+    };
diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml
new file mode 100644
index 0000000..55184cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/interrupt-controller/intel,ce4100-lapic.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel Local Advanced Programmable Interrupt Controller (LAPIC)
+
+maintainers:
+  - Rahul Tanwar <rtanwar@maxlinear.com>
+
+description: |
+  Intel's Advanced Programmable Interrupt Controller (APIC) is a
+  family of interrupt controllers. The APIC is a split
+  architecture design, with a local component (LAPIC) integrated
+  into the processor itself and an external I/O APIC. Local APIC
+  (lapic) receives interrupts from the processor's interrupt pins,
+  from internal sources and from an external I/O APIC (ioapic).
+  And it sends these to the processor core for handling.
+  See [1] Chapter 8 for more details.
+
+  Many of the Intel's generic devices like hpet, ioapic, lapic have
+  the ce4100 name in their compatible property names because they
+  first appeared in CE4100 SoC.
+
+  This schema defines bindings for local APIC interrupt controller.
+
+  [1] https://pdos.csail.mit.edu/6.828/2008/readings/ia32/IA32-3A.pdf
+
+properties:
+  compatible:
+    const: intel,ce4100-lapic
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    lapic0: interrupt-controller@fee00000 {
+        compatible = "intel,ce4100-lapic";
+        reg = <0xfee00000 0x1000>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+    };
