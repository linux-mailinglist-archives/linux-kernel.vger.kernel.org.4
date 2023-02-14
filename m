Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECAF696EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 21:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjBNUuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 15:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBNUuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 15:50:08 -0500
Received: from mr85p00im-hyfv06011401.me.com (mr85p00im-hyfv06011401.me.com [17.58.23.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB44823859
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 12:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1676407806; bh=lu3iz8boaJE5hBM4PrvJdMVuK1QqN72tUsmqt9Hu/rY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=H3cr8FVBF3lJbW3/8sQ88eAyp+QmM3qSZ4VkCu3WCFMy0g3wSyoVFR2FvzwftLFza
         fcQfAZfy1NZjBXTHHlDr2j6P9xPAaLZ00Vni9skpON+fgFTEEbCyD5SKahenyq5E3K
         yFEW4ZrQCmq7gA/xh0eFwtweOAJsHJHX3lHglKVSvzfu5GuVAuqQOAAZqHa9E8ViUT
         Ill/cZ7GL2U1gNHVPIYod7XDRmEEV7XAkL+cedlB012tIOD/ezYDd063JUi8U2parF
         ELyQbwORxh1uqmyZ1I1W6XzaArQt3aBijlnArCu34mFZXh6MleMPWgvruApPDh/MZ3
         IgHcpq0w3NS7g==
Received: from localhost (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-hyfv06011401.me.com (Postfix) with ESMTPSA id E038C357D231;
        Tue, 14 Feb 2023 20:50:05 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Alain Volmat <avolmat@me.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3] dt-bindings: mailbox: sti-mailbox: convert to DT schema
Date:   Tue, 14 Feb 2023 21:49:44 +0100
Message-Id: <20230214204945.4215-1-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -_KukQB_Mf3ClW8_I2YgINTJ_jkX0ZaC
X-Proofpoint-ORIG-GUID: -_KukQB_Mf3ClW8_I2YgINTJ_jkX0ZaC
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2302140180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the sti-mailbox.txt file into st,sti-mailbox.yaml

Signed-off-by: Alain Volmat <avolmat@me.com>
---
v3: remove quotes around $ref
v2: update commit log
    remove quotes around urls
    add mbox-name $ref
    remove mbox-name from required properties since not mandatory in the driver
    fix IRQ type in example

 .../bindings/mailbox/st,sti-mailbox.yaml      | 53 +++++++++++++++++++
 .../bindings/mailbox/sti-mailbox.txt          | 51 ------------------
 2 files changed, 53 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/st,sti-mailbox.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/sti-mailbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/st,sti-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/st,sti-mailbox.yaml
new file mode 100644
index 000000000000..a023c28dff49
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/st,sti-mailbox.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/st,sti-mailbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics Mailbox Driver for STi platform
+
+description:
+  Each ST Mailbox IP currently consists of 4 instances of 32 channels.
+  Messages are passed between Application and Remote processors using
+  shared memory.
+
+maintainers:
+  - Patrice Chotard <patrice.chotard@foss.st.com>
+
+properties:
+  compatible:
+    const: st,stih407-mailbox
+
+  reg:
+    maxItems: 1
+
+  mbox-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: name of the mailbox IP
+
+  interrupts:
+    description: the irq line for the RX mailbox
+    maxItems: 1
+
+  "#mbox-cells":
+    const: 2
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
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mailbox0: mailbox@8f00000  {
+        compatible = "st,stih407-mailbox";
+        reg = <0x8f00000 0x1000>;
+        interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+        #mbox-cells = <2>;
+        mbox-name = "a9";
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt b/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
deleted file mode 100644
index 351f612673fc..000000000000
--- a/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
+++ /dev/null
@@ -1,51 +0,0 @@
-ST Microelectronics Mailbox Driver
-
-Each ST Mailbox IP currently consists of 4 instances of 32 channels.  Messages
-are passed between Application and Remote processors using shared memory.
-
-Controller
-----------
-
-Required properties:
-- compatible		: Should be "st,stih407-mailbox"
-- reg			: Offset and length of the device's register set
-- mbox-name		: Name of the mailbox
-- #mbox-cells:		: Must be 2
-			  <&phandle instance channel direction>
-			    phandle   : Label name of controller
-			    instance  : Instance number
-			    channel   : Channel number
-
-Optional properties
-- interrupts		: Contains the IRQ line for a Rx mailbox
-
-Example:
-
-mailbox0: mailbox@0  {
-	compatible	= "st,stih407-mailbox";
-	reg		= <0x08f00000 0x1000>;
-	interrupts	= <GIC_SPI 1 IRQ_TYPE_NONE>;
-	#mbox-cells	= <2>;
-	mbox-name	= "a9";
-};
-
-Client
-------
-
-Required properties:
-- compatible		: Many (See the client docs)
-- reg			: Shared (between Application and Remote) memory address
-- mboxes		: Standard property to specify a Mailbox (See ./mailbox.txt)
-			  Cells must match 'mbox-cells' (See Controller docs above)
-
-Optional properties
-- mbox-names		: Name given to channels seen in the 'mboxes' property.
-
-Example:
-
-mailbox_test {
-	compatible	= "mailbox-test";
-	reg		= <0x[shared_memory_address], [shared_memory_size]>;
-	mboxes		= <&mailbox2 0 1>, <&mailbox0 2 1>;
-	mbox-names	= "tx",	"rx";
-};
-- 
2.34.1

