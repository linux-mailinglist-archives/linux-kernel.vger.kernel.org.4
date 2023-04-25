Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56776EDDD2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 10:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjDYIUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 04:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjDYIT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:19:57 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E85A40DF;
        Tue, 25 Apr 2023 01:19:56 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P7SiGQ010233;
        Tue, 25 Apr 2023 01:19:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=qFPVHmLhj79eFNNRMNhao3E5XytVQl0KAYfinko41M8=;
 b=QqsEMDUJ20pT8WeK9wc1Syq4aKF1PDcGjRl5iMeCyAMMrmZlPGR7+5uzdwRZWZ+84OdG
 wzpKT1I8M89fDOBSTobUSyotHSBqJujlAl8VybeEYsErjza1mlc+Zuehp+cIL9gFIB//
 V7TB0jiSgwdFK7uUXbqvDCiO3fYnbUGfokWZJ7P54uYuKYysc0b697JtjpuBWetIPxu9
 ZiD0l0JKL9iIH68vMijcHLi1xGv5tsdOtO7OiSTvUHjHk2+EGCqG4snofRrgwPzOpRoi
 jdOcogcEYNDKa301/AdiJXWYlKctIBx4NDmV7QgmgOKCO7co55CjBMhi+yVBuRgqEFVQ 5w== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3q4f3p9ak3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 01:19:34 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 25 Apr
 2023 01:19:32 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 25 Apr 2023 01:19:29 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 1/2 v3] dt-bindings: watchdog: marvell octeonTX2 GTI system watchdog driver
Date:   Tue, 25 Apr 2023 13:49:25 +0530
Message-ID: <20230425081926.9234-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: agZTlasKd6PpLPmuzVmWGwt7chIJj-gQ
X-Proofpoint-GUID: agZTlasKd6PpLPmuzVmWGwt7chIJj-gQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_03,2023-04-21_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the Marvell octeonTX2
GTI system watchdog driver.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v3:
 - Used 4 spaces for entire DTS example

 .../watchdog/marvell,octeontx2-wdt.yaml       | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/marvell,octeontx2-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/marvell,octeontx2-wdt.yaml b/Documentation/devicetree/bindings/watchdog/marvell,octeontx2-wdt.yaml
new file mode 100644
index 000000000000..eb06d78242bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/marvell,octeontx2-wdt.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/marvell,octeontx2-wdt.yaml#
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
+    const: marvell,octeontx2-wdt
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
+            compatible = "marvell,octeontx2-wdt";
+            reg = <0x00008020 0x00040000 0x00000000 0x00020000>;
+            interrupts = <0 38 IRQ_TYPE_EDGE_RISING>;
+        };
+    };
+
+...
-- 
2.17.1

