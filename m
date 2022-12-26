Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C587E656586
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 23:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiLZWlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 17:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiLZWkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 17:40:36 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771905FD6;
        Mon, 26 Dec 2022 14:39:32 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BQIkpgi020208;
        Mon, 26 Dec 2022 17:39:29 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3mny7a203j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Dec 2022 17:39:29 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 2BQMdRHW000565
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Dec 2022 17:39:27 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 26 Dec
 2022 17:39:26 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 26 Dec 2022 17:39:26 -0500
Received: from okan.localdomain ([10.158.19.61])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2BQMcuAd032340;
        Mon, 26 Dec 2022 17:39:21 -0500
From:   Okan Sahin <okan.sahin@analog.com>
To:     <okan.sahin@analog.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK" 
        <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 4/5] dt-bindings: regulator: adi,max77541-regulator.yaml Add MAX77541 Regulator bindings
Date:   Tue, 27 Dec 2022 01:38:38 +0300
Message-ID: <20221226223839.103460-5-okan.sahin@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221226223839.103460-1-okan.sahin@analog.com>
References: <20221226223839.103460-1-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: yPLnufxl-Q9_RSL2W3xGIGK7DJH9nWYl
X-Proofpoint-GUID: yPLnufxl-Q9_RSL2W3xGIGK7DJH9nWYl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-26_18,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212260192
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings for MAX77541 and MAX77540
regulator drivers.

Signed-off-by: Okan Sahin <okan.sahin@analog.com>
---
 .../regulator/adi,max77541-regulator.yaml     | 44 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/adi,max77541-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/adi,max77541-regulator.yaml b/Documentation/devicetree/bindings/regulator/adi,max77541-regulator.yaml
new file mode 100644
index 000000000000..67d48bfcb627
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/adi,max77541-regulator.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/adi,max77541-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Buck Converter for MAX77540/MAX77541
+
+maintainers:
+  - Okan Sahin <okan.sahin@analog.com>
+
+description: |
+  This is a part of device tree bindings for ADI MAX77540/MAX77541
+
+  The buck converter is represented as a sub-node of the PMIC node on the device tree.
+
+  The device has two buck regulators.
+  See also Documentation/devicetree/bindings/mfd/adi,max77541.yaml for
+  additional information and example.
+
+properties:
+  compatible:
+    enum:
+      - adi,max77540-regulator
+      - adi,max77541-regulator
+
+patternProperties:
+  "^BUCK[12]$":
+    type: object
+    $ref: regulator.yaml#
+    additionalProperties: false
+    description: |
+      Buck regulator.
+
+    properties:
+      regulator-name: true
+      regulator-always-on: true
+      regulator-boot-on: true
+      regulator-min-microvolt:
+        minimum: 300000
+      regulator-max-microvolt:
+        maximum: 5200000
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index 5704ed5afce3..8e5572b28a8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12502,6 +12502,7 @@ M:	Okan Sahin <okan.sahin@analog.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/adi,max77541.yaml
+F:	Documentation/devicetree/bindings/regulator/adi,max77541.yaml
 F:	drivers/mfd/max77541.c
 F:	drivers/regulator/max77541-regulator.c
 F:	include/linux/mfd/max77541.h
-- 
2.30.2

