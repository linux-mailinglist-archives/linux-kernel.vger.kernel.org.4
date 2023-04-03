Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7E56D4C4B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjDCPpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjDCPpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:45:08 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1232530F1;
        Mon,  3 Apr 2023 08:45:04 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333D9TNr029235;
        Mon, 3 Apr 2023 11:44:43 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3pphh8abm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 11:44:42 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 333Fif5R052647
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Apr 2023 11:44:41 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 3 Apr 2023
 11:44:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 3 Apr 2023 11:44:40 -0400
Received: from IST-LT-39247.ad.analog.com (IST-LT-39247.ad.analog.com [10.25.16.17])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 333Fi2OR024018;
        Mon, 3 Apr 2023 11:44:29 -0400
From:   Ibrahim Tilki <Ibrahim.Tilki@analog.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Subject: [PATCH v5 2/2] dt-bindings: rtc: add max313xx RTCs
Date:   Mon, 3 Apr 2023 18:43:42 +0300
Message-ID: <20230403154342.3108-3-Ibrahim.Tilki@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
References: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: cyUH7xeTZJIQvvu5oxSTGldr_3hVtBt-
X-Proofpoint-ORIG-GUID: cyUH7xeTZJIQvvu5oxSTGldr_3hVtBt-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_12,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030114
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devicetree binding documentation for Analog Devices MAX313XX RTCs

Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
---
 .../devicetree/bindings/rtc/adi,max313xx.yaml | 144 ++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/adi,max313xx.yaml

diff --git a/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
new file mode 100644
index 000000000..0c17a395e
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
@@ -0,0 +1,144 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2022 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/adi,max313xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX313XX series I2C RTCs
+
+maintainers:
+  - Ibrahim Tilki <Ibrahim.Tilki@analog.com>
+  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
+
+description: Analog Devices MAX313XX series I2C RTCs.
+
+properties:
+  compatible:
+    enum:
+      - adi,max31328
+      - adi,max31329
+      - adi,max31331
+      - adi,max31334
+      - adi,max31341
+      - adi,max31342
+      - adi,max31343
+
+  reg:
+    description: I2C address of the RTC
+    items:
+      - enum: [0x68, 0x69]
+
+  interrupts:
+    description: |
+      Alarm1 interrupt line of the RTC. Some of the RTCs have two interrupt
+      lines and alarm1 interrupt muxing depends on the clockin/clockout
+      configuration.
+    maxItems: 1
+
+  "#clock-cells":
+    description: |
+      RTC can be used as a clock source through its clock output pin when
+      supplied.
+    const: 0
+
+  clocks:
+    description: |
+      RTC uses this clock for clock input when supplied. Clock has to provide
+      one of these four frequencies: 1Hz, 50Hz, 60Hz or 32.768kHz.
+    maxItems: 1
+
+  aux-voltage-chargeable:
+    enum: [0, 1, 2]
+    description: |
+      Enables trickle charger.
+      0: Charger is disabled (default)
+      1: Charger is enabled
+      2: Charger is enabled with a diode
+
+  trickle-resistor-ohms:
+    description: Selected resistor for trickle charger.
+    enum: [3000, 6000, 11000]
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: rtc.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,max31328
+              - adi,max31342
+
+    then:
+      properties:
+        aux-voltage-chargeable: false
+        trickle-resistor-ohms: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,max31328
+              - adi,max31331
+              - adi,max31334
+              - adi,max31343
+
+    then:
+      properties:
+        clocks: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,max31341
+              - adi,max31342
+
+    then:
+      properties:
+        reg:
+          items:
+            - const: 0x69
+
+    else:
+      properties:
+        reg:
+          items:
+            - const: 0x68
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
+        rtc@68 {
+            reg = <0x68>;
+            compatible = "adi,max31329";
+            clocks = <&clkin>;
+            interrupt-parent = <&gpio>;
+            interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@68 {
+            reg = <0x68>;
+            compatible = "adi,max31331";
+            #clock-cells = <0>;
+        };
+    };
-- 
2.25.1

