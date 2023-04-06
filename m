Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BE36DA5AF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjDFWU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjDFWU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:20:26 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D178CB7;
        Thu,  6 Apr 2023 15:20:24 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336ELPfU025565;
        Thu, 6 Apr 2023 17:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=LAZYYn6LQbqCkIbcPih7UrJPEovcL14E2ocGUEtKXJo=;
 b=BPh9I+7meyR69avxecV27H6uBIqFM78sPNT9ENfi5FGUiLkHiBZNlr+vLthHIo71ry0X
 1+L6SaKIe4A9xXSPT2YDyKkC0LdYdO405+BZZc62lErV0s78udLVVBV+0Gu0PoyjPC9Z
 xtrMC5A1OLoxWj0EhP1WgLsQWWEWQb77f5gh9niSOmf74mYMfx+3ItmMb8QzPYsXqCz3
 E8f0TNWPBCWqAq+r/TJ40a7IsfWTEErVQvrODvwhFn035Uib9fmbov+LgnFk8OY7Xpz6
 lSRMNxB4+nai8FIJWce4YQvlQNKFzoTydMRLF0tHsifU1FLifkOJJid/MmSSSGgkS0kQ LQ== 
Received: from ausex01.ad.cirrus.com ([141.131.3.19])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pph1r9v9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 17:20:20 -0500
Received: from ausex02.ad.cirrus.com (141.131.37.96) by ausex01.ad.cirrus.com
 (141.131.37.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 6 Apr
 2023 17:20:20 -0500
Received: from ftrev.crystal.cirrus.com (141.131.38.212) by
 anon-ausex02.ad.cirrus.com (141.131.37.96) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 6 Apr 2023 17:20:20 -0500
From:   Fred Treven <fred.treven@cirrus.com>
To:     <ben.bright@cirrus.com>, <james.ogletree@cirrus.com>,
        <dmitry.torokhov@gmail.com>, <robh+dt@kernel.org>,
        <krzystztof.kozlowski+dt@linaro.org>,
        <patches@opensource.cirrus.com>, <linux-input@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Fred Treven <fred.treven@cirrus.com>
Subject: [PATCH 2/2] dt-bindings: input: cirrus,cs40l26: Add bindings
Date:   Thu, 6 Apr 2023 17:20:13 -0500
Message-ID: <1680819613-29256-1-git-send-email-fred.treven@cirrus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <Add devicetree bindings for CS40L26 driver>
References: <Add devicetree bindings for CS40L26 driver>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: IBdmHK_zs5ET-5jl22vSb-bY6JDIHBhR
X-Proofpoint-GUID: IBdmHK_zs5ET-5jl22vSb-bY6JDIHBhR
X-Proofpoint-Spam-Reason: orgsafe
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for CS40L26 driver.

Signed-off-by: Fred Treven <fred.treven@cirrus.com>
---
 .../devicetree/bindings/input/cs40l26.yaml         | 92 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cs40l26.yaml

diff --git a/Documentation/devicetree/bindings/input/cs40l26.yaml b/Documentation/devicetree/bindings/input/cs40l26.yaml
new file mode 100644
index 000000000000..1036a374baa0
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/cs40l26.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/cs40l26.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic CS40L26 Boosted Haptic Amplifier
+
+maintainers:
+  - Fred Treven <fred.treven@cirrus.com>
+
+description:
+  CS40L26 is a Boosted Haptic Driver with Integrated DSP and Waveform Memory
+  with Advanced Closed Loop Algorithms and LRA protection
+
+properties:
+  compatible:
+    enum:
+      - cirrus,cs40l26a
+      - cirrus,cs40l26b
+      - cirrus,cs40l27a
+      - cirrus,cs40l27b
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description:
+      Property describing the interrupt line the devices /ALERT pin is connected to.
+      The device only has one interrupt source.
+
+  VA-supply:
+    description: Regulator for VA analog voltage
+
+  VP-supply:
+    description: Regulator for VP peak voltage
+
+  cirrus,bst-ipk-microamp:
+    description:
+      Maximum amount of current that can be drawn by the device's boost
+      converter in uA. Accepted values are between 1600000 uA and 4800000 uA in
+      50000 uA increments.
+    minimum: 1600000
+    maximum: 4800000
+    default: 4500000
+
+  cirrus,bst-ctl-microvolt:
+    description:
+      Maximum target voltage to which the class H algorithm may increase the
+      VBST supply, expressed in uV. Valid values range from 2550000 to 11000000
+      (inclusive) in steps of 50000. If this value is specified as zero or VP
+      rises above this value, VBST is bypassed to VP. If this value is omitted,
+      the maximum target voltage remains at 11 V.
+    minimum: 2550000
+    maximum: 11000000
+    default: 11000000
+
+  cirrus,bst-exploratory-mode-disable:
+    description:
+      Disable boost exploratory mode if this boolean is present in the
+      devicetree. Boost exploratory mode allows the device to overshoot
+      the set peak current limit. This has potential to damage the boost
+      inductor. Disabling this mode will prevent this from happening; it will
+      also prevent the device from detecting boost inductor short errors.
+      (Default) Enabled
+    type: boolean
+
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      cs40l26: cs40l26@58 {
+        compatible = "cirrus,cs40l26a";
+        reg = <0x58>;
+        interrupt-parent = <&gpio0>;
+        interrupts = <57 8>;
+        reset-gpios = <&gpio0 54 0>;
+        VA-supply = <&dummy_vreg>;
+        VP-supply = <&dummy_vreg>;
+        cirrus,bst-ctl-microvolt = <2600000>; // Max boost voltage = 2.6V
+        cirrus,bst-ipk-microamp = <1650000>; // Max boost current = 1.65A
+        cirrus,bst-exploratory-mode-disabled; // Disable exploratory mode
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 7051386d5a13..3cd9f0c8e38d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4934,6 +4934,7 @@ L:	patches@opensource.cirrus.com
 S:	Supported
 W:	https://github.com/CirrusLogic/linux-drivers/wiki
 T:	git https://github.com/CirrusLogic/linux-drivers.git
+F:	Documentation/devicetree/bindings/input/cs40l26.yaml
 F:	drivers/input/misc/cs40l*
 F:	include/linux/input/cs40l*
 
-- 
2.7.4

