Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8136D6F0206
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 09:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243152AbjD0HqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 03:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243159AbjD0Hpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:45:34 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D5A2718;
        Thu, 27 Apr 2023 00:45:31 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33R753WT006730;
        Thu, 27 Apr 2023 00:14:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=toQ9a0YCNHyB5z4VppPWxShMMQwv8KOiv6BDbEN7628=;
 b=WqDNCvowkDGyLJPfbUKOdayl+rmHA47GvUeFCWlWXpyToPMqxqe4Qema8Au+BrJ4jMHH
 H0Oz4paIzA/3kogGNjqzetWASCwMvhYynwGsoaUGtoXu9PD7mGE/Nq125J4zgus6ARYc
 Fvgz08p7fjOszOGbqksXug02Yxk7y0TVWYmZy40/aC6SMCg699066jri32YRmdqnQg3P
 s0k0p7mDk5CK0mX6WF1YQMuOQyZ9u5lj41+jD1zEHnC1IrGXSNqlGUTe6Ogs8XTLT5At
 SeWLRtYLa/aj0dzPPn2Iu4kWsks3Zls9O36wGbr3CpU+Ic3Q9Uovan1q8yz7qx4IQBLF dw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3q7apa2c4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 00:14:15 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 27 Apr
 2023 00:14:14 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 27 Apr 2023 00:14:11 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 1/2 v4] dt-bindings: watchdog: marvell GTI system watchdog driver
Date:   Thu, 27 Apr 2023 12:44:07 +0530
Message-ID: <20230427071408.8493-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7OdkCBuycamZjWh1fEmGhYWZVj_s4oq_
X-Proofpoint-GUID: 7OdkCBuycamZjWh1fEmGhYWZVj_s4oq_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_05,2023-04-26_03,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the Marvell GTI system
watchdog driver.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v4:
 - Use generic name "GTI (Global Timer)" and removed OcteonTX2 as this driver
   is applicable for other marvell devices as well. There are no logical changes
 - Added Reviewed-by: Rob Herring <robh@kernel.org>

 .../bindings/watchdog/marvell,gti-wdt.yaml    | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/marvell,gti-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/marvell,gti-wdt.yaml b/Documentation/devicetree/bindings/watchdog/marvell,gti-wdt.yaml
new file mode 100644
index 000000000000..4d34e9635ac1
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/marvell,gti-wdt.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/marvell,gti-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell GTI system watchdog
+
+allOf:
+  - $ref: watchdog.yaml#
+
+maintainers:
+  - Bharat Bhushan <bbhushan2@marvell.com>
+
+properties:
+  compatible:
+    const: marvell,gti-wdt
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        watchdog@802000040000 {
+            compatible = "marvell,gti-wdt";
+            reg = <0x00008020 0x00040000 0x00000000 0x00020000>;
+            interrupts = <0 38 IRQ_TYPE_EDGE_RISING>;
+        };
+    };
+
+...
-- 
2.17.1

