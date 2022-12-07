Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CC6645624
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiLGJLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiLGJLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:11:24 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565446258;
        Wed,  7 Dec 2022 01:11:23 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B77xjVZ003958;
        Wed, 7 Dec 2022 04:11:01 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3m816bfjtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 04:11:01 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 2B79B04A010034
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Dec 2022 04:11:00 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 7 Dec 2022 04:10:59 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 7 Dec 2022 04:10:59 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 7 Dec 2022 04:10:59 -0500
Received: from okan.localdomain ([10.158.19.61])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2B799G9W029801;
        Wed, 7 Dec 2022 04:10:42 -0500
From:   Okan Sahin <okan.sahin@analog.com>
To:     <outreachy@lists.linux.dev>
CC:     Okan Sahin <okan.sahin@analog.com>, Lee Jones <lee@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Manish Narani <manish.narani@xilinx.com>,
        "Marcelo Schmitt" <marcelo.schmitt1@gmail.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH 2/5] staging: dt-bindings: mfd: adi,max77541.yaml Add MAX77541 bindings
Date:   Wed, 7 Dec 2022 12:08:41 +0300
Message-ID: <20221207090906.5896-3-okan.sahin@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221207090906.5896-1-okan.sahin@analog.com>
References: <20221207090906.5896-1-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: jqkVibCxSabldY4RyF_93y7ETJ56xcOT
X-Proofpoint-ORIG-GUID: jqkVibCxSabldY4RyF_93y7ETJ56xcOT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_04,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070076
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds document the bindings for MAX77541 MFD driver. It also
includes MAX77540 driver whose regmap is covered by MAX77541.

Signed-off-by: Okan Sahin <okan.sahin@analog.com>
---
 .../devicetree/bindings/mfd/adi,max77541.yaml | 134 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/adi,max77541.yaml

diff --git a/Documentation/devicetree/bindings/mfd/adi,max77541.yaml b/Documentation/devicetree/bindings/mfd/adi,max77541.yaml
new file mode 100644
index 000000000000..205953e6dd15
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/adi,max77541.yaml
@@ -0,0 +1,134 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/adi,max77541.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MAX77540/MAX77541 PMIC from ADI.
+
+maintainers:
+  - Okan Sahin <okan.sahin@analog.com>
+
+description: |
+  MAX77540 is a Power Management IC with 2 buck regulators.
+
+  MAX77541 is a Power Management IC with 2 buck regulators and 1 ADC.
+
+properties:
+  compatible:
+    enum:
+      - adi,max77540
+      - adi,max77541
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  regulators:
+    $ref: /schemas/regulator/adi,max77541.yaml#
+
+  adc:
+    type: object
+    additionalProperties: false
+    properties:
+      compatible:
+        const: adi,max77541-adc
+    required:
+      -compatible
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,max77540
+    then:
+      properties:
+        regulator:
+          properties:
+            compatible:
+              const: adi,max77540-regulator
+    else:
+      properties:
+        regulator:
+          properties:
+            compatible:
+              const: adi,max77541-regulator
+        adc:
+          properties:
+            compatible:
+              const: adi,max77541-adc
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@69 {
+            compatible = "adi,max77540";
+            reg = <0x69>;
+            interrupt-parent = <&gpio>;
+            interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+
+            regulators {
+                buck1 {
+                    regulator-min-microvolt = <500000>;
+                    regulator-max-microvolt = <5200000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+                buck2 {
+                    regulator-min-microvolt = <500000>;
+                    regulator-max-microvolt = <5200000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+            };
+        };
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@69 {
+            compatible = "adi,max77541";
+            reg = <0x63>;
+            interrupt-parent = <&gpio>;
+            interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+
+            regulators {
+                buck1 {
+                    regulator-min-microvolt = <500000>;
+                    regulator-max-microvolt = <5200000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+                buck2 {
+                    regulator-min-microvolt = <500000>;
+                    regulator-max-microvolt = <5200000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+            };
+
+            adc {
+                compatible = "adi,max77541-adc";
+            }
+        };
+    };
\ No newline at end of file
diff --git a/MAINTAINERS b/MAINTAINERS
index af94d06bb9f0..22f5a9c490e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12501,6 +12501,7 @@ MAXIM MAX77541 PMIC MFD DRIVER
 M:	Okan Sahin <okan.sahin@analog.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/adi,max77541.yaml
 F:	drivers/mfd/max77541.c
 F:	include/linux/mfd/max77541.h
 
-- 
2.30.2

