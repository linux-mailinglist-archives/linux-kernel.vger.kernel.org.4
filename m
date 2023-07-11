Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBD574F52C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjGKQ2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjGKQ2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:28:41 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE4410D5;
        Tue, 11 Jul 2023 09:28:39 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BFOFRf027386;
        Tue, 11 Jul 2023 12:28:34 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3rq4q6kcdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 12:28:34 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 36BGSXIf062722
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jul 2023 12:28:33 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 11 Jul
 2023 12:28:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 11 Jul 2023 12:28:32 -0400
Received: from okan.localdomain ([10.158.19.61])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 36BGS1ST025938;
        Tue, 11 Jul 2023 12:28:23 -0400
From:   Okan Sahin <okan.sahin@analog.com>
To:     <okan.sahin@analog.com>
CC:     Rob Herring <robh@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: regulator: max77857: Add ADI MAX77857/59/MAX77831 Regulator
Date:   Tue, 11 Jul 2023 19:27:47 +0300
Message-ID: <20230711162751.7094-2-okan.sahin@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230711162751.7094-1-okan.sahin@analog.com>
References: <20230711162751.7094-1-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 8Y9cHGhEQrtAmMMcJ_S8n0dpqTuVtvyv
X-Proofpoint-ORIG-GUID: 8Y9cHGhEQrtAmMMcJ_S8n0dpqTuVtvyv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_08,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110148
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ADI MAX77857/59 and MAX77831 Regulator device tree document.

Signed-off-by: Okan Sahin <okan.sahin@analog.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/regulator/adi,max77857.yaml      | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/adi,max77857.yaml

diff --git a/Documentation/devicetree/bindings/regulator/adi,max77857.yaml b/Documentation/devicetree/bindings/regulator/adi,max77857.yaml
new file mode 100644
index 000000000000..4b6d0d794ba9
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/adi,max77857.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2022 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/adi,max77857.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX77857 Buck-Boost Converter
+
+maintainers:
+  - Ibrahim Tilki <Ibrahim.Tilki@analog.com>
+
+description: Analog Devices MAX77857 Buck-Boost Converter
+
+properties:
+  compatible:
+    enum:
+      - adi,max77831
+      - adi,max77857
+      - adi,max77859
+      - adi,max77859a
+
+  reg:
+    description: I2C address of the device
+    items:
+      - enum: [0x66, 0x67, 0x6E, 0x6F]
+
+  interrupts:
+    maxItems: 1
+
+  adi,switch-frequency-hz:
+    description: Switching frequency of the Buck-Boost converter in Hz.
+    items:
+      - enum: [1200000, 1500000, 1800000, 2100000]
+
+  adi,rtop-ohms:
+    description: Top feedback resistor value in ohms for external feedback.
+    minimum: 150000
+    maximum: 330000
+
+  adi,rbot-ohms:
+    description: Bottom feedback resistor value in ohms for external feedback.
+
+dependencies:
+  adi,rtop-ohms: [ 'adi,rbot-ohms' ]
+  adi,rbot-ohms: [ 'adi,rtop-ohms' ]
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: regulator.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,max77831
+
+    then:
+      properties:
+        adi,switch-frequency-hz:
+          items:
+            enum: [1200000, 1500000, 1800000]
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@66 {
+            reg = <0x66>;
+            compatible = "adi,max77857";
+            interrupt-parent = <&gpio>;
+            interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+
+            adi,rtop-ohms = <312000>;
+            adi,rbot-ohms = <12000>;
+        };
+    };
-- 
2.30.2

