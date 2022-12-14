Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E398E64CC3B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238736AbiLNO1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238663AbiLNO1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:27:23 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0410A27CE7;
        Wed, 14 Dec 2022 06:27:16 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEB5WdP007022;
        Wed, 14 Dec 2022 09:26:58 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3mf6rn2tqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 09:26:58 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 2BEEQvM1028773
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Dec 2022 09:26:57 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 14 Dec 2022 09:26:56 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 14 Dec 2022 09:26:55 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 14 Dec 2022 09:26:55 -0500
Received: from IST-LT-40003.ad.analog.com (IST-LT-40003.ad.analog.com [10.25.36.26])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2BEEQLNE022112;
        Wed, 14 Dec 2022 09:26:48 -0500
From:   Sinan Divarci <Sinan.Divarci@analog.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sinan Divarci <Sinan.Divarci@analog.com>
Subject: [PATCH v2 3/3] dt-bindings: hwmon: Add bindings for max31732
Date:   Wed, 14 Dec 2022 17:22:06 +0300
Message-ID: <20221214142206.13288-4-Sinan.Divarci@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221214142206.13288-1-Sinan.Divarci@analog.com>
References: <20221214142206.13288-1-Sinan.Divarci@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: S0M_byp6vi9rnmlHYWIjD3JipbMr1Q7U
X-Proofpoint-ORIG-GUID: S0M_byp6vi9rnmlHYWIjD3JipbMr1Q7U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_06,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxlogscore=637 impostorscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212140114
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding bindings for max31732 quad remote temperature sensor

Signed-off-by: Sinan Divarci <Sinan.Divarci@analog.com>
---
 .../bindings/hwmon/adi,max31732.yaml          | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,max31732.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/adi,max31732.yaml b/Documentation/devicetree/bindings/hwmon/adi,max31732.yaml
new file mode 100644
index 000000000..c701cda95
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adi,max31732.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2022 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/adi,max31732.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX31732 Temperature Sensor Device Driver
+
+maintainers:
+  - Sinan Divarci <Sinan.Divarci@analog.com>
+
+description: Bindings for the Analog Devices MAX31732 Temperature Sensor Device.
+
+properties:
+  compatible:
+    enum:
+      - adi,max31732
+
+  reg:
+    description: I2C address of the Temperature Sensor Device.
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    description: Name of the interrupt pin of max31732 used for IRQ.
+    minItems: 1
+    items:
+      - enum: [ALARM1, ALARM2]
+      - enum: [ALARM1, ALARM2]
+
+  adi,alarm1-interrupt-mode:
+    description: |
+      Enables the ALARM1 output to function in interrupt mode.
+      Default ALARM1 output function is comparator mode.
+    type: boolean
+
+  adi,alarm2-interrupt-mode:
+    description: |
+      Enables the ALARM2 output to function in interrupt mode.
+      Default ALARM2 output function is comparator mode.
+    type: boolean
+
+  adi,alarm1-fault-queue:
+    description: The number of consecutive faults required to assert ALARM1.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 6]
+    default: 1
+
+  adi,alarm2-fault-queue:
+    description: The number of consecutive faults required to assert ALARM2.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 6]
+    default: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        sensor@1c {
+            compatible = "adi,max31732";
+            reg = <0x1c>;
+            interrupt-parent = <&gpio>;
+            interrupts = <17 IRQ_TYPE_EDGE_BOTH>, <27 IRQ_TYPE_EDGE_BOTH>;
+            interrupt-names = "ALARM1", "ALARM2";
+            adi,alarm1-fault-queue = <4>;
+            adi,alarm2-fault-queue = <2>;
+            adi,alarm2-interrupt-mode;
+      };
+    };
-- 
2.25.1

