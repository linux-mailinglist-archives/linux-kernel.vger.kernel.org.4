Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AA465C36A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbjACP5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjACP4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:56:43 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDE4386;
        Tue,  3 Jan 2023 07:56:43 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303FS4Bt022669;
        Tue, 3 Jan 2023 07:56:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=50ZZaOLwnf4n3mzLa2/GkS0zShwrKJ9SXeUjrdRCPbM=;
 b=fPpPFvgqpSCF0ir1rCPdiMb+Fq6CzHQdAYTMT7eTB3gBsxvWlLhkWC8TKj3Tvg51LZct
 b43+KkaqFsW0X5EQB4IkolKOIGo7opwoJZOf6x5c6hhMjEV4gTojbSgtr+S5868CT3fz
 a79bXcoG1ru+w+qNaW4glXnUGJZC0TFHr3p1V1JtTWnKq4LFUKIw78reqcgsCpsu+SRB
 3xUxoT85PXxCKTeKvoW92AUbTaGSGft/4DIh351mlDWe2rbg1XOE+zH5mdmlNw97HhOK
 gJOXHYOrUYbN5xDDAtP43xCHS1FbMaJv2T8IHeVSDrvf/FZQJ1puhUIgjwDrfXgKUoL+ IA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3mtkauwayx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 07:56:39 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 3 Jan
 2023 07:56:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Tue, 3 Jan 2023 07:56:38 -0800
Received: from localhost.localdomain (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id D2E1D3F7068;
        Tue,  3 Jan 2023 07:56:37 -0800 (PST)
From:   Wojciech Zmuda <wzmuda@marvell.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <sgoutham@marvell.com>,
        <devicetree@vger.kernel.org>,
        Wojciech Bartczak <wbartczak@marvell.com>,
        Wojciech Zmuda <wzmuda@marvell.com>
Subject: [PATCH v2 2/2] Documentation: add Marvell MHU driver bindings
Date:   Tue, 3 Jan 2023 07:56:12 -0800
Message-ID: <20230103155612.6217-3-wzmuda@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230103155612.6217-1-wzmuda@marvell.com>
References: <20230103155612.6217-1-wzmuda@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Q_h8Wywq1zqiT1iROStxzYQfhjHpmBsQ
X-Proofpoint-ORIG-GUID: Q_h8Wywq1zqiT1iROStxzYQfhjHpmBsQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_05,2023-01-03_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wojciech Bartczak <wbartczak@marvell.com>

Marvell Message Handling Unit is a mailbox controller present in
Marvell OcteonTx and OcteonTX2 SoC family.

Signed-off-by: Wojciech Bartczak <wbartczak@marvell.com>
Signed-off-by: Wojciech Zmuda <wzmuda@marvell.com>
---
 .../bindings/mailbox/marvell,mvl-mhu.yml      | 67 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/marvell,mvl-mhu.yml

diff --git a/Documentation/devicetree/bindings/mailbox/marvell,mvl-mhu.yml b/Documentation/devicetree/bindings/mailbox/marvell,mvl-mhu.yml
new file mode 100644
index 000000000000..e06a17eab0f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/marvell,mvl-mhu.yml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/marvell,mvl-mhu.yml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Message Handling Unit driver
+
+maintainers:
+  - Sujeet Baranwal <sbaranwal@marvell.com>
+  - Sunil Goutham <sgoutham@marvell.com>
+  - Wojciech Bartczak <wbartczak@marvell.com>
+
+description:
+  The Control-Processors Cluster (CPC) provides Arm-platform specification
+  entities for managing the system. On of the CPC processors is the System
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
+    items:
+      - const: marvell,mbox
+
+  reg:
+    maxItems: 1
+
+  "#mbox-cells":
+    description: Index of the channel
+    const: 1
+
+required:
+  - "#mbox-cells"
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+		/ {
+			mailbox: mailbox@28,0 {
+				compatible = "marvell,mbox";
+				#mbox-cells = <1>;
+				reg = <0xE000 0 0 0 0>;/*  DEVFN = 0xE0 (1C:0) */
+			};
+
+			/* ... */
+
+			firmware {
+				scmi {
+					compatible = "arm,scmi";
+					mboxes = <&mailbox 0>;
+					mbox-names = "scp_ap";
+					/* ... */
+				};
+			};
+		};
+
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

