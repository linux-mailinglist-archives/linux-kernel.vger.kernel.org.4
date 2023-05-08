Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AE26FB143
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbjEHNS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjEHNSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:18:12 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC08D37C5A;
        Mon,  8 May 2023 06:17:57 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348D7gfQ003273;
        Mon, 8 May 2023 09:17:54 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3qdkt9b8gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 09:17:53 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 348DHqHu020954
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 May 2023 09:17:52 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 8 May 2023 09:17:51 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 8 May 2023 09:17:51 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 8 May 2023 09:17:51 -0400
Received: from IST-LT-42339.ad.analog.com ([10.158.19.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 348DBdTP009014;
        Mon, 8 May 2023 09:17:42 -0400
From:   Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <sre@kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <Zeynep.Arslanbenzer@analog.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Nurettin Bolucu <Nurettin.Bolucu@analog.com>
Subject: [PATCH v3 6/7] dt-bindings: mfd: max77658: Add ADI MAX77658
Date:   Mon, 8 May 2023 16:10:44 +0300
Message-ID: <20230508131045.9399-7-Zeynep.Arslanbenzer@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230508131045.9399-1-Zeynep.Arslanbenzer@analog.com>
References: <20230508131045.9399-1-Zeynep.Arslanbenzer@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: gHDDIHAC7h25mEwbONxIzD9oF9Q9bD9J
X-Proofpoint-ORIG-GUID: gHDDIHAC7h25mEwbONxIzD9oF9Q9bD9J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_09,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2305080089
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ADI MAX77658 devicetree document.

Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
---
 .../devicetree/bindings/mfd/adi,max77658.yaml | 160 ++++++++++++++++++
 1 file changed, 160 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/adi,max77658.yaml

diff --git a/Documentation/devicetree/bindings/mfd/adi,max77658.yaml b/Documentation/devicetree/bindings/mfd/adi,max77658.yaml
new file mode 100644
index 000000000000..4d6d87cd4b52
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/adi,max77658.yaml
@@ -0,0 +1,160 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/adi,max77658.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MAX77643/54/58/59 PMIC from ADI
+
+maintainers:
+  - Nurettin Bolucu <Nurettin.Bolucu@analog.com>
+  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
+
+description: |
+  MAX77643, MAX77654, MAX77658 and MAX77659 devices are a family of ADI PMICs
+  providing battery charging and power supply solutions for
+  low-power applications.
+
+  MAX77643 is a Power Management IC with 1 LDO regulator.
+
+  MAX77654 is a Power Management IC with 2 LDO regulators and 1 charger.
+
+  MAX77658 is a Power Management IC with 2 LDO regulators, 1 charger
+  and 1 fuel gauge.
+
+  MAX77659 is a Power Management IC with 1 LDO regulator and 1 charger.
+
+properties:
+  compatible:
+    enum:
+      - adi,max77643
+      - adi,max77654
+      - adi,max77658
+      - adi,max77659
+
+  reg:
+    items:
+      - enum: [0x40, 0x48]
+
+  interrupts:
+    maxItems: 1
+
+  charger:
+    $ref: /schemas/power/supply/adi,max77658-charger.yaml
+
+  fuel-gauge:
+    $ref: /schemas/power/supply/adi,max77658-battery.yaml
+
+  regulators:
+    type: object
+
+    description:
+      The regulators is represented as a sub-node of the PMIC node on the device tree.
+
+    patternProperties:
+      "^LDO[01]$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml
+        additionalProperties: false
+        description:
+          LDO regulator
+
+        properties:
+          regulator-always-on: true
+          regulator-boot-on: true
+
+    additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,max77643
+              - adi,max77654
+              - adi,max77658
+
+    then:
+      properties:
+        reg:
+          items:
+            - const: 0x48
+
+    else:
+      properties:
+        reg:
+          items:
+            - const: 0x40
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
+    battery: battery-cell {
+      compatible = "simple-battery";
+      alert-celsius = <0 100>;
+      constant-charge-current-max-microamp = <15000>;
+    };
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      pmic@48 {
+        compatible = "adi,max77658";
+        reg = <0x48>;
+        interrupt-parent = <&gpio>;
+        interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+        charger {
+          compatible = "adi,max77658-charger";
+          monitored-battery = <&battery>;
+          adi,input-current-limit-microamp = <475000>;
+        };
+        regulators {
+          LDO0 {
+            regulator-boot-on;
+            regulator-always-on;
+          };
+          LDO1 {
+            regulator-boot-on;
+            regulator-always-on;
+          };
+        };
+        fuel-gauge {
+          compatible = "adi,max77658-battery";
+          monitored-battery = <&battery>;
+          adi,valrt-min-microvolt = <0>;
+          adi,valrt-max-microvolt = <5100000>;
+          adi,ialrt-min-microamp = <(-5000)>;
+          adi,ialrt-max-microamp = <5000>;
+        };
+      };
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      pmic@40 {
+        compatible = "adi,max77659";
+        reg = <0x40>;
+        interrupt-parent = <&gpio>;
+        interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+        charger {
+          compatible = "adi,max77659-charger";
+          monitored-battery = <&battery>;
+        };
+        regulators {
+          LDO0 {
+            regulator-boot-on;
+            regulator-always-on;
+          };
+        };
+      };
+    };
-- 
2.25.1

