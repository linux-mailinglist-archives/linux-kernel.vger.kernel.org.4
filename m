Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA486FB131
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjEHNRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjEHNRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:17:18 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444261248B;
        Mon,  8 May 2023 06:17:00 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348A9WKT003068;
        Mon, 8 May 2023 09:16:56 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3qdkt9b8f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 09:16:56 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 348DGtVI020854
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 May 2023 09:16:55 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 8 May 2023
 09:16:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 8 May 2023 09:16:54 -0400
Received: from IST-LT-42339.ad.analog.com ([10.158.19.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 348DBdTL009014;
        Mon, 8 May 2023 09:16:42 -0400
From:   Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <sre@kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <Zeynep.Arslanbenzer@analog.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Nurettin Bolucu <Nurettin.Bolucu@analog.com>
Subject: [PATCH v3 2/7] dt-bindings: power: supply: max77658: Add ADI MAX77654/58/59 Charger
Date:   Mon, 8 May 2023 16:10:40 +0300
Message-ID: <20230508131045.9399-3-Zeynep.Arslanbenzer@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230508131045.9399-1-Zeynep.Arslanbenzer@analog.com>
References: <20230508131045.9399-1-Zeynep.Arslanbenzer@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: LiASkNVV2Wz-5VI9ZaH3p17dv7BtGQsc
X-Proofpoint-ORIG-GUID: LiASkNVV2Wz-5VI9ZaH3p17dv7BtGQsc
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

Add ADI MAX77654/58/59 power supply devicetree document.

Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
---
 .../power/supply/adi,max77658-charger.yaml    | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/adi,max77658-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/adi,max77658-charger.yaml b/Documentation/devicetree/bindings/power/supply/adi,max77658-charger.yaml
new file mode 100644
index 000000000000..1b487d82cdbf
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/adi,max77658-charger.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/adi,max77658-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Battery charger for MAX77658 PMICs family from ADI
+
+maintainers:
+  - Nurettin Bolucu <Nurettin.Bolucu@analog.com>
+  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
+
+description: |
+  This module is part of the MAX77658 MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/adi,max77658.yaml.
+
+  The charger is represented as a sub-node of the PMIC node on the device tree.
+
+properties:
+  compatible:
+    enum:
+      - adi,max77654-charger
+      - adi,max77658-charger
+      - adi,max77659-charger
+
+  adi,input-current-limit-microamp:
+    description: Input current limit value.
+
+  monitored-battery:
+    description: >
+      This property must be a phandle to a node using the format described
+      in battery.yaml, with the following properties being required:
+      - constant-charge-current-max-microamp
+
+allOf:
+  - $ref: power-supply.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,max77659-charger
+
+    then:
+      properties:
+        adi,input-current-limit-microamp: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+...
-- 
2.25.1

