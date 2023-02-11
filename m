Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6405E6933CE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 21:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjBKUwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 15:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBKUwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 15:52:02 -0500
Received: from mr85p00im-ztdg06021201.me.com (mr85p00im-ztdg06021201.me.com [17.58.23.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F286BBDE7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 12:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1676148721; bh=4I8Yle2oyOrw9Vfx0gosmiF1K8lDOa8NfsKfHXnwqtA=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=w3pj+6bTrn67HJ8kDM/EWC1BZ9ektNwBn5GDlsGhjscr+mPVIraNgezzEX0mLsTMS
         HQg1RgUvAAFfBVbkXIcI/Fwzt0VgdUhHDd00YrvGhKtGsTYTNLJdym8WcEhxYgAXC/
         2YLe0fGs1I+d5ORQCm9V2Xy6eYcUoyl3wvUQC6MltwaPt0xVz3y5rVxOE5gvQ18uMO
         fasj5GhWlaSW6IiEPLKiRd7YiXmb329c2GU0gYKaue2tvlSaVMkxJHa0aXcIXeGTfx
         aVjB6VXYkdT516ABct29sJX8WP7uIxQbBabrv3Gr7lgO1ylYUwmk9acAYk3wspLqVL
         DbHHIUJ8w1RaQ==
Received: from localhost (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-ztdg06021201.me.com (Postfix) with ESMTPSA id 1D2B73207DA;
        Sat, 11 Feb 2023 20:52:00 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Alain Volmat <avolmat@me.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: mailbox: sti: convert sti-mailbox to DT schema
Date:   Sat, 11 Feb 2023 21:51:01 +0100
Message-Id: <20230211205102.9218-1-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6Aem3_uCrOrTTMEduRHRLl-YTWLmIAKG
X-Proofpoint-ORIG-GUID: 6Aem3_uCrOrTTMEduRHRLl-YTWLmIAKG
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1011
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2302110195
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the sti-mailbox.txt dt-bindings into dt-schema YAML.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 .../bindings/mailbox/st,sti-mailbox.yaml      | 54 +++++++++++++++++++
 .../bindings/mailbox/sti-mailbox.txt          | 51 ------------------
 2 files changed, 54 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/st,sti-mailbox.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/sti-mailbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/st,sti-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/st,sti-mailbox.yaml
new file mode 100644
index 000000000000..527c88147397
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/st,sti-mailbox.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/mailbox/st,sti-mailbox.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: STMicroelectronics Mailbox Driver
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
+    description: name of the mailbox
+    maxItems: 1
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
+  - mbox-name
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mailbox0: mailbox@8f00000  {
+        compatible = "st,stih407-mailbox";
+        reg = <0x08f00000 0x1000>;
+        interrupts = <GIC_SPI 1 IRQ_TYPE_NONE>;
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

