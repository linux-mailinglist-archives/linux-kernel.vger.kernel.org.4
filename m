Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3045E65217B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiLTN0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiLTNZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:25:55 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3D71A380;
        Tue, 20 Dec 2022 05:25:37 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BKCXPpX021680;
        Tue, 20 Dec 2022 08:25:34 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3mk9nd1724-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 08:25:34 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 2BKDPX4J053494
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Dec 2022 08:25:33 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 20 Dec
 2022 08:25:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 20 Dec 2022 08:25:32 -0500
Received: from IST-LT-42339.ad.analog.com (IST-LT-42339.ad.analog.com [10.117.192.221])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2BKDNoP4010583;
        Tue, 20 Dec 2022 08:25:20 -0500
From:   Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <sre@kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <Zeynep.Arslanbenzer@analog.com>, <Nurettin.Bolucu@analog.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH 2/6] dt-bindings: mfd: add MAX77659 binding
Date:   Tue, 20 Dec 2022 16:22:46 +0300
Message-ID: <20221220132250.19383-3-Zeynep.Arslanbenzer@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221220132250.19383-1-Zeynep.Arslanbenzer@analog.com>
References: <20221220132250.19383-1-Zeynep.Arslanbenzer@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Mvh2i8pIiM1XtDPfKelflzoZK0Zg3RH7
X-Proofpoint-ORIG-GUID: Mvh2i8pIiM1XtDPfKelflzoZK0Zg3RH7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_05,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=823 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212200110
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds binding document for MAX77659 MFD driver.

Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
---
 .../devicetree/bindings/mfd/adi,max77659.yaml | 70 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/adi,max77659.yaml

diff --git a/Documentation/devicetree/bindings/mfd/adi,max77659.yaml b/Documentation/devicetree/bindings/mfd/adi,max77659.yaml
new file mode 100644
index 000000000000..6bec11607615
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/adi,max77659.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/adi,max77659.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MAX77659 SIMO PMIC from ADI.
+
+maintainers:
+  - Nurettin Bolucu <Nurettin.Bolucu@analog.com>
+  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
+
+description: |
+  MAX77659 is an PMIC providing battery charging and power
+  supply solutions for low-power applications.
+
+  For device-tree bindings of other sub-modules (regulator, power supply
+  refer to the binding documents under the respective
+  sub-system directories.
+
+properties:
+  compatible:
+    const: adi,max77659
+
+  reg:
+    description:
+      I2C device address.
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  charger:
+    $ref: ../power/supply/adi,max77659-charger.yaml
+
+  regulator:
+    $ref: ../regulator/adi,max77659-regulator.yaml
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pmic@40 {
+            compatible = "adi,max77659";
+            reg = <0x40>;
+            interrupt-parent = <&gpio>;
+            #interrupt-cells = <2>;
+            interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+            regulator {
+                compatible = "adi,max77659-regulator";
+                regulator-boot-on;
+                regulator-always-on;
+            };
+            charger {
+                compatible = "adi,max77659-charger";
+                adi,fast-charge-timer   = <5>;
+                adi,fast-charge-microamp = <15000>;
+                adi,topoff-timer  =  <30>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 45a8a471c7c0..e7a9cadf0ff2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12645,6 +12645,7 @@ M:	Nurettin Bolucu <Nurettin.Bolucu@analog.com>
 M:	Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/adi,max77659.yaml
 F:	drivers/mfd/max77659.c
 F:	include/linux/mfd/max77659.h
 
-- 
2.25.1

