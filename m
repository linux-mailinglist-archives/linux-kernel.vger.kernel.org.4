Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC5A6230B8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiKIQzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiKIQzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:55:05 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5832982C;
        Wed,  9 Nov 2022 08:53:59 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9EDNjb027347;
        Wed, 9 Nov 2022 10:53:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=420u/HEI3tHbzNq5I478ikRYO0zF6aKkT5Y5X4qFOYU=;
 b=JNzbdB0bA239WwHJ1g82qd89rfnQUcUE03rVXDxU+AK0TtLOD1IygZU5mHjZU2+B4oPU
 dubZeatH0NeoqUNFoZkmh3iMuDdJoQY+BdJGavFTUElDdLH/y9fCX/J4lGP69N/PyJTP
 YOWLAk9lELtqkoRrku1fPVvD64gZVryC0U4p9J9O0IWQ6N7Z8C9uiGE+5aHVG7xBIPKh
 n9G+WLSUpQXMGiW5Mt4KCKdFVbimT8pBY2rgJK5/0tP8WUbhLOrgRWJg50YnzVv9sevw
 zyedOPsp8BGnCehpxtUQ082SNTwfjTnp6c7OCjH3kynS8XST3gAwm4ktAruZ7ovNiUZW NA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3knm8pde7v-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 10:53:42 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Wed, 9 Nov
 2022 10:53:38 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.15 via Frontend
 Transport; Wed, 9 Nov 2022 10:53:38 -0600
Received: from debianA11184.ad.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.92])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AFD9B478;
        Wed,  9 Nov 2022 16:53:37 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <broonie@kernel.org>, <tglx@linutronix.de>, <maz@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 11/12] dt-bindings: sound: Add Cirrus Logic CS48L31/32/33 codecs
Date:   Wed, 9 Nov 2022 16:53:30 +0000
Message-ID: <20221109165331.29332-12-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221109165331.29332-1-rf@opensource.cirrus.com>
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FGTbUh0PSuxbtYxLMg3cAsBS8B1BY4j-
X-Proofpoint-GUID: FGTbUh0PSuxbtYxLMg3cAsBS8B1BY4j-
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Codecs in this family have multiple digital and analog audio I/O that
support a variety of external hardware connections and configurations.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 .../bindings/sound/cirrus,cs48l32.yaml        | 96 +++++++++++++++++++
 include/dt-bindings/sound/cs48l32.h           | 25 +++++
 2 files changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs48l32.yaml
 create mode 100644 include/dt-bindings/sound/cs48l32.h

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs48l32.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs48l32.yaml
new file mode 100644
index 000000000000..70fb294c6dc1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs48l32.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/cirrus,cs48l32.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic CS48L31/32/33 audio CODECs
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+description: |
+  This describes audio configuration bindings for these codecs.
+
+  See also the core bindings for the parent MFD driver:
+
+    Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml
+
+  and defines for values used in these bindings:
+
+    include/dt-bindings/sound/cs48l32.h
+
+  The properties are all contained in the parent MFD node.
+
+properties:
+  '#sound-dai-cells':
+    const: 1
+
+  cirrus,in-type:
+    description:
+      A list of input type settings for each input. A maximum of 8 cells,
+      with four cells per input in the order INnL_1, INnR_1 INnL_2 INnR_2.
+      (where _1 and _2 are the alternative mux selections for that INn).
+      If the array is shorter than the number of inputs the unspecified
+      inputs default to CS48L32_IN_TYPE_DIFF.
+    $ref: "/schemas/types.yaml#/definitions/uint32-matrix"
+    minItems: 1
+    maxItems: 8
+    items:
+      items:
+        - description:
+            The first cell is INnL_1 input type. One of the CS48L32_IN_TYPE_xxx.
+            For non-muxed inputs this sets the type of INnL.
+            minimum: 0
+            maximum: 1
+        - description:
+            The second cell is INnR_1 input type. One of the CS48L32_IN_TYPE_xxx.
+            For non-muxed inputs this sets the type of INnR.
+            minimum: 0
+            maximum: 1
+        - description:
+            The third cell is INnL_2 input type. One of the CS48L32_IN_TYPE_xxx.
+            For non-muxed inputs this cell must be 0.
+            minimum: 0
+            maximum: 1
+        - description:
+            The fourth cell is INnR_2 input type. One of the CS48L32_IN_TYPE_xxx.
+            For non-muxed inputs this cell must be 0.
+            minimum: 0
+            maximum: 1
+
+  cirrus,max-channels-clocked:
+    description:
+      Maximum number of channels that clocks will be generated for. When using
+      multiple data lines, every sample slot can transfer multiple channels
+      (one per data line). This pdata sets the maximum number of slots.
+      One cell for each ASP, use a value of zero for ASPs that should be
+      handled normally.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 4
+    items:
+      default: 0
+
+  cirrus,pdm-sup:
+    description:
+      Indicates how the MICBIAS pins have been externally connected to DMICs
+      on each input. One cell per input (IN1, IN2, ...). One of the
+      CS48L32_MICBIAS_xxx values.
+      See the INn_PDM_SUP field in the datasheet for a description.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 4
+
+examples:
+  - |
+        cs48l32@0 {
+                compatible = "cirrus,cs48l32";
+
+                cirrus,in-type = <
+                        CS48L32_IN_TYPE_DIFF CS48L32_IN_TYPE_DIFF /* IN1[LR]_1 differential */
+                        CS48L32_IN_TYPE_SE   CS48L32_IN_TYPE_SE   /* IN1[LR]_2 single-ended */
+                        CS48L32_IN_TYPE_DIFF CS48L32_IN_TYPE_DIFF /* IN2[LR]_1 differential */
+                >;
+                cirrus,max-channels-clocked = <2 0 0>;
+        };
diff --git a/include/dt-bindings/sound/cs48l32.h b/include/dt-bindings/sound/cs48l32.h
new file mode 100644
index 000000000000..0b774da0a6c8
--- /dev/null
+++ b/include/dt-bindings/sound/cs48l32.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Device Tree defines for CS48L32 codec.
+ *
+ * Copyright (C) 2016-2018, 2022 Cirrus Logic, Inc. and
+ *               Cirrus Logic International Semiconductor Ltd.
+ */
+
+#ifndef DT_BINDINGS_SOUND_CS48L32_H
+#define DT_BINDINGS_SOUND_CS48L32_H
+
+#define CS48L32_IN_TYPE_DIFF		0
+#define CS48L32_IN_TYPE_SE		1
+
+#define CS48L32_PDM_SUP_VOUT_MIC	0
+#define CS48L32_PDM_SUP_MICBIAS1	1
+#define CS48L32_PDM_SUP_MICBIAS2	2
+#define CS48L32_PDM_SUP_MICBIAS3	3
+
+#define CS48L32_PDM_FMT_MODE_A_LSB_FIRST	0x0000
+#define CS48L32_PDM_FMT_MODE_B_LSB_FIRST	0x4000
+#define CS48L32_PDM_FMT_MODE_A_MSB_FIRST	0x8000
+#define CS48L32_PDM_FMT_MODE_B_MSB_FIRST	0xc000
+
+#endif
-- 
2.30.2

