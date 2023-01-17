Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF76B66E4B1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjAQRTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbjAQRSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:18:34 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E624901D;
        Tue, 17 Jan 2023 09:17:15 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HGSMfO009003;
        Tue, 17 Jan 2023 09:17:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=S7eM6ZdUHUHrOeIHjmRGBtrAjSNvT/4/d0ZQoOjK83M=;
 b=SG6l67dkn0HirVpG/lo2r4t3knBbuuvlJzpi6Ibj8vKhBRxGe86LAmyz0EhA5uZypQzZ
 DS5PB67D/cEvb4+AOtaV2aFssXKmLBVG1rMLLyXbqHfjWBUTtnURPFfTc4t5qruzKNHI
 DgDQu8IowiOgUX6eyZXb0+FqwK0n7YFh7U5KiYJCOpWuiopDS420MLBqBhrCEvZCjXJs
 lIMN34Q/oRZCsQLmDvWWxe3yslD8/2eI5PvBHBXxMKgIi6PGl2Fwz56jPVekybWBttXR
 3rak0H1PhuN99oapxGXI904JORNRTb4i2N976vPkiZ/fynrVXsVuj+qZC/EizImA79Rd Ig== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3n3vstbjhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 09:17:06 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 17 Jan
 2023 09:17:04 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Tue, 17 Jan 2023 09:17:04 -0800
Received: from localhost.localdomain (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id E78613F7098;
        Tue, 17 Jan 2023 09:17:03 -0800 (PST)
From:   Wojciech Zmuda <wzmuda@marvell.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <sgoutham@marvell.com>,
        <devicetree@vger.kernel.org>, Wojciech Zmuda <wzmuda@marvell.com>
Subject: [PATCH v4 2/2] dt-bindings: mailbox: add Marvell MHU
Date:   Tue, 17 Jan 2023 09:16:35 -0800
Message-ID: <20230117171635.16739-3-wzmuda@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230117171635.16739-1-wzmuda@marvell.com>
References: <20230117171635.16739-1-wzmuda@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UIujAHoLC7g2i6JsZRS7yiGwvlMRhX1C
X-Proofpoint-GUID: UIujAHoLC7g2i6JsZRS7yiGwvlMRhX1C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_08,2023-01-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marvell Message Handling Unit is a mailbox controller present in
Marvell OcteonTx and OcteonTX2 SoC family.

Signed-off-by: Wojciech Zmuda <wzmuda@marvell.com>
---
 .../bindings/mailbox/marvell,mhu.yaml         | 62 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/marvell,mhu.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/marvell,mhu.yaml b/Documentation/devicetree/bindings/mailbox/marvell,mhu.yaml
new file mode 100644
index 000000000000..ace32a437af6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/marvell,mhu.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/marvell,mhu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Message Handling Unit
+
+maintainers:
+  - Sujeet Baranwal <sbaranwal@marvell.com>
+  - Sunil Goutham <sgoutham@marvell.com>
+  - Wojciech Bartczak <wbartczak@marvell.com>
+
+description:
+  The Control-Processors Cluster (CPC) provides Arm-platform specification
+  entities for managing the system. One of the CPC processors is the System
+  Control Processor (SCP). The SCP is responsible, among others, for booting
+  the chip, clock and power initialization, controlling power consumption
+  through DVFS, monitoring temperature sensors and controlling AVS. The SCP,
+  as each XCP, contains mailboxes for software-to-software communications.
+  Mailbox writes cause an interrupt to the local XCP core or to the AP.
+  This driver exposes AP-SCP Message Handling Unit to the system, providing
+  the mailbox communication mechanism to the system, with the intention
+  of plugging into the SCMI framework. It is designed to work with Marvell
+  OcteonTX and OcteonTX2-based platforms.
+  Mailbox has no other usage than SCMI communication. In case of
+  configurations running without SCMI support it should be disabled.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - marvell,octeontx-mhu
+              - marvell,octeontx2-mhu
+
+  reg:
+    maxItems: 1
+
+  "#mbox-cells":
+    description: Index of the channel
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#mbox-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    ecam {
+        #address-cells = <3>;
+        #size-cells = <2>;
+            mailbox: mailbox@1c,0 {
+                compatible = "marvell,octeontx2-mhu";
+                reg = <0xe000 0x0 0x0 0 0>;
+                #mbox-cells = <1>;
+            };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 650a198cce24..e53f001a15c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11328,6 +11328,7 @@ M:	Sunil Goutham <sgoutham@marvell.com>
 M:	Wojciech Bartczak <wbartczak@marvell.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/mailbox/marvell,mvl-mhu.yml
 F:	drivers/mailbox/mvl_mhu.c
 
 MATROX FRAMEBUFFER DRIVER
-- 
2.17.1

