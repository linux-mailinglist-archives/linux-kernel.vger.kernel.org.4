Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2FE669803
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjAMNGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241262AbjAMNGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:06:19 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DF0777F1;
        Fri, 13 Jan 2023 04:53:35 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DCWnIT026966;
        Fri, 13 Jan 2023 04:53:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=sHS+MWVt42zp5n6cGpK596g9AMg9qy3GV/dfe0+81Bk=;
 b=SO7f7P7PVcEHz4u7T6txd7eW+0KcFS21UOANH6IRYTfjjEpZKf1Zukp4QnwFuLBA3Uvu
 ZbLtA0pNOSApLNdHdNjQjH8ZCAkc94syetD1hl/dLuZle+K/dc5tZE57e4CSVglrp2ph
 BjT1RH7mMUa3iAzS825ThuYVi7siwO4qCTNdb+1/zBpWiKR9ocTD4Z4kfTYzc9HE4itD
 A4StFYDhGGb+lcRv2657XL2b9viUw8FlsD/npqjFgwGKG21jsznlyzENmjrh0WZY7WHF
 an/cCZ1UIf0p0Imk3C/8GqWg9Ud2wZR6oA8r0yYM7hcNHWyu+F9Qi/7z+ANhnJCA4Oxl Fg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3n1k574xh4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 04:53:31 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 13 Jan
 2023 04:53:29 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Fri, 13 Jan 2023 04:53:29 -0800
Received: from localhost.localdomain (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id 8E9363F7063;
        Fri, 13 Jan 2023 04:53:29 -0800 (PST)
From:   Wojciech Zmuda <wzmuda@marvell.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <sgoutham@marvell.com>,
        <devicetree@vger.kernel.org>, Wojciech Zmuda <wzmuda@marvell.com>
Subject: [PATCH v3 2/2] dt-bindings: mailbox: add Marvell MHU
Date:   Fri, 13 Jan 2023 04:53:23 -0800
Message-ID: <20230113125323.3744-3-wzmuda@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230113125323.3744-1-wzmuda@marvell.com>
References: <20230113125323.3744-1-wzmuda@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DPbyGrH68TFaFiJFllOGKJMUBjf-emeD
X-Proofpoint-GUID: DPbyGrH68TFaFiJFllOGKJMUBjf-emeD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_05,2023-01-13_01,2022-06-22_01
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
 .../bindings/mailbox/marvell,mhu.yml          | 59 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/marvell,mhu.yml

diff --git a/Documentation/devicetree/bindings/mailbox/marvell,mhu.yml b/Documentation/devicetree/bindings/mailbox/marvell,mhu.yml
new file mode 100644
index 000000000000..3fe8238eefe7
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/marvell,mhu.yml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/marvell,mhu.yml#
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
+        - enum:
+          - marvell,octeontx-mhu
+          - marvell,octeontx2-mhu
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
+    / {
+        mailbox: mailbox {
+            compatible = "marvell,octeontx2-mhu";
+            reg = <0xe000 0 0 0 0>; /* DEVFN = 0xe0 (1c:0) */
+            #mbox-cells = <1>;
+    };
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 57db5055cdd6..685bdb2c1735 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11328,6 +11328,7 @@ M:	Sunil Goutham <sgoutham@marvell.com>
 M:	Wojciech Bartczak <wbartczak@marvell.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/mailbox/marvell,mhu.yml
 F:	drivers/mailbox/marvell_mhu.c
 
 MATROX FRAMEBUFFER DRIVER
-- 
2.17.1

