Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A636C4272
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCVF5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCVF5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:57:43 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21565328D;
        Tue, 21 Mar 2023 22:57:40 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M0uCFN006512;
        Wed, 22 Mar 2023 01:57:37 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3pekwxv64h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 01:57:37 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 32M5vZgI012631
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Mar 2023 01:57:35 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 22 Mar 2023 01:57:35 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 22 Mar 2023 01:57:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 22 Mar 2023 01:57:34 -0400
Received: from IST-LT-42339.ad.analog.com (IST-LT-42339.ad.analog.com [10.117.192.221] (may be forged))
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 32M5ueXG016875;
        Wed, 22 Mar 2023 01:57:21 -0400
From:   Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <sre@kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <Zeynep.Arslanbenzer@analog.com>, <Nurettin.Bolucu@analog.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v2 1/8] dt-bindings: regulator: max77658: Add ADI MAX77643/54/58/59 Regulator
Date:   Wed, 22 Mar 2023 08:56:21 +0300
Message-ID: <20230322055628.4441-2-Zeynep.Arslanbenzer@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
References: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: LMAevWjPbC0V0bav2sElU7VtQls71uxx
X-Proofpoint-GUID: LMAevWjPbC0V0bav2sElU7VtQls71uxx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220042
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ADI MAX77643/MAX77654/MAX77658/MAX77659 Regulator devicetree document.

Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
---
 .../regulator/adi,max77658-regulator.yaml     | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/adi,max77658-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/adi,max77658-regulator.yaml b/Documentation/devicetree/bindings/regulator/adi,max77658-regulator.yaml
new file mode 100644
index 000000000000..1d097eddcd98
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/adi,max77658-regulator.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/adi,max77658-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Regulator for MAX77658 PMICs family from ADI
+
+maintainers:
+  - Nurettin Bolucu <Nurettin.Bolucu@analog.com>
+  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
+
+description: |
+  This is part of the MAX77658 MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/adi,max77658.yaml.
+
+  The regulators is represented as a sub-node of the PMIC node on the device tree.
+
+patternProperties:
+  "^LDO[01]$":
+    type: object
+    $ref: regulator.yaml#
+    additionalProperties: false
+    description: |
+      LDO regulator.
+
+    properties:
+      regulator-always-on: true
+      regulator-boot-on: true
+
+additionalProperties: false
+...
-- 
2.25.1

