Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4126E20A3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjDNKYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjDNKYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:24:12 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85744C0A;
        Fri, 14 Apr 2023 03:24:11 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33E90DIl011792;
        Fri, 14 Apr 2023 03:23:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=bD5Y1MPDHvXV1+72/2W7Q1ijnYncf1yOPj42QcwQtIQ=;
 b=YIXpOi2SluS2ubcANTQZmttd15PdlwZRPQZ7b/5BddELq43PgF7QcsyhTQ7CODr13doh
 /T08jOWPiK2q1PBQJXiu0CRl6D0aotsYJW2ztkn3EGr6k1GjutywhQ/8vIm5ji/r7Hqj
 K0I10tHp7pYwdKwRRmZ3XOzOMpvEMgTs6BufAn6fpXCj/++kSYVU+Iv3xzJuZWZJ3MEi
 En9t+4jd4KslEPT0Uue3xgBLOR7TXB9Eg4hwcjHIhXqIvtdOiWRxWRvjwXJ9iGb3mKEV
 KaQjT1gCwCdG2R8q1aFmG6LrDRhNmO1plJDmpkO4819WujI8VB7KUicix24BlRnkBmUU rA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3py3tk0bph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 03:23:50 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 14 Apr
 2023 03:23:48 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 14 Apr 2023 03:23:46 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 1/2] dt-bindings: watchdog: marvell octeonTX2 GTI system atchdog driver
Date:   Fri, 14 Apr 2023 15:53:41 +0530
Message-ID: <20230414102342.23696-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: ojrR47Yeiac9xXFmQ9OLXtsaSm1HYoR0
X-Proofpoint-ORIG-GUID: ojrR47Yeiac9xXFmQ9OLXtsaSm1HYoR0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_04,2023-04-14_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the Marvell octeonTX2
GTI system watchdog driver.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 .../watchdog/marvell-octeontx2-wdt.yaml       | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/marvell-octeontx2-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/marvell-octeontx2-wdt.yaml b/Documentation/devicetree/bindings/watchdog/marvell-octeontx2-wdt.yaml
new file mode 100644
index 000000000000..e509f26c61b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/marvell-octeontx2-wdt.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/marvell-octeontx2-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell OcteonTX2 GTI system watchdog
+
+allOf:
+  - $ref: watchdog.yaml#
+
+maintainers:
+  - Bharat Bhushan <bbhushan2@marvell.com>
+
+properties:
+  compatible:
+    const: marvell-octeontx2-wdt
+
+  reg:
+    maxItems: 1
+    description:
+      OcteonTX2 GTI system watchdog register space
+
+  interrupts:
+    maxItems: 1
+    description:
+      OcteonTX2 GTI system watchdog interrupt number
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
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        watchdog@802000040000 {
+          compatible = "marvell-octeontx2-wdt";
+          reg = <0x8020 0x40000 0x0 0x20000>;
+          interrupts = <0 38 1>;
+        };
+    };
+
+...
-- 
2.17.1

