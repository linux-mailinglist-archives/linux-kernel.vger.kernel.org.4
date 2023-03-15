Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34256BB974
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjCOQS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjCOQSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:18:04 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88D77DFB1;
        Wed, 15 Mar 2023 09:17:46 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FDiIOr015719;
        Wed, 15 Mar 2023 12:17:21 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3pb2bbd54v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 12:17:20 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 32FGHJw8016905
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Mar 2023 12:17:19 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 15 Mar 2023 12:17:18 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 15 Mar 2023 12:17:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 15 Mar 2023 12:17:18 -0400
Received: from IST-LT-39247.ad.analog.com (IST-LT-39247.ad.analog.com [10.25.16.17])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 32FGGj0n027526;
        Wed, 15 Mar 2023 12:17:08 -0400
From:   Ibrahim Tilki <Ibrahim.Tilki@analog.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Subject: [PATCH v4 2/2] dt-bindings: rtc: add max313xx RTCs
Date:   Wed, 15 Mar 2023 19:16:26 +0300
Message-ID: <20230315161626.247-3-Ibrahim.Tilki@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315161626.247-1-Ibrahim.Tilki@analog.com>
References: <20230315161626.247-1-Ibrahim.Tilki@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ajmBAC6NQgQI2h1XSC97ElfmHiZkUFqj
X-Proofpoint-ORIG-GUID: ajmBAC6NQgQI2h1XSC97ElfmHiZkUFqj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_08,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150137
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
 .../devicetree/bindings/rtc/adi,max313xx.yaml | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/adi,max313xx.yaml

diff --git a/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
new file mode 100644
index 000000000..bed6d0bc4
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
@@ -0,0 +1,142 @@
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
+  aux-voltage-chargeable: true
+
+  trickle-resistor-ohms:
+    description: Enables trickle charger with specified resistor value.
+    enum: [3000, 6000, 11000]
+
+  adi,trickle-diode-enable:
+    description: Charge the auxiliary voltage with a diode.
+    type: boolean
+
+additionalProperties: false
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
+required:
+  - compatible
+  - reg
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

