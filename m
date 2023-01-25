Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A0A67C035
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 23:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbjAYWyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 17:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbjAYWyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:54:40 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7185146D6B;
        Wed, 25 Jan 2023 14:54:39 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PMq4Um009177;
        Wed, 25 Jan 2023 22:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=JGXQ6ZIgY9+wq8n00lHSkg0g8qdUPMuE2aJ0GSV82oE=;
 b=Da9MX4ISNVH+aRd6OaAaeHRdBWxd44iMGdCLft64jtdsrV+r9iqAfoRdNsIh/tnxtOMa
 BnooW/k0xrG6uS4DyhnUigiNwjQn9IsR403o5jStsL/oe9NaRzaHZ10ueuP5vwTePhCf
 pY3kojHwijBAbnGEgfkM7DUFvhfCHOb3Al5KcBOuurjAweoJpkImomJFDLJisFhMZ8Ru
 WnJ9Y+hMeLFBFcuNW7KeBgZOUIkYA3gQWSNOptbXaenH25b8+sFnI8DQ1myIFAcms0xK
 Q23gkgfJqj8QoqaPTOLVwbF0L0cRmicBr0nGfCmRj93jupsN5MA9crXZy/qRFniUI4NM BA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbdke02px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 22:54:24 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PJqIJp019885;
        Wed, 25 Jan 2023 22:54:22 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3n87p7gvwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 22:54:22 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PMsLCn6357746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 22:54:21 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B0D958065;
        Wed, 25 Jan 2023 22:54:21 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64CF35804B;
        Wed, 25 Jan 2023 22:54:19 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.77.150.21])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 22:54:19 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, rostedt@goodmis.org, alistair@popple.id.au,
        joel@jms.id.au, jk@ozlabs.org, andrew@aj.id.au,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, eajames@linux.ibm.com
Subject: [PATCH v2 1/2] dt-bindings: fsi: Document the IBM I2C Responder virtual FSI master
Date:   Wed, 25 Jan 2023 16:54:15 -0600
Message-Id: <20230125225416.4074040-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230125225416.4074040-1-eajames@linux.ibm.com>
References: <20230125225416.4074040-1-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kSOOYgWDy8O8nncf1lF0VFBXtiL_klMa
X-Proofpoint-ORIG-GUID: kSOOYgWDy8O8nncf1lF0VFBXtiL_klMa
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301250200
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2C Responder translates I2C commands to CFAM or SCOM operations,
effectively implementing an FSI master.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../bindings/fsi/ibm,i2cr-fsi-master.yaml     | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml

diff --git a/Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml b/Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml
new file mode 100644
index 000000000000..fa768e773adc
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fsi/ibm,i2cr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IBM I2C Responder virtual FSI master
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+description: |
+  The I2C Responder (I2CR) is a an I2C device that's connected to an FSI CFAM
+  (see fsi.txt). The I2CR translates I2C bus operations to FSI CFAM reads and
+  writes or SCOM operations, thereby acting as an FSI master.
+
+properties:
+  compatible:
+    enum:
+      - ibm,i2cr-fsi-master
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+ - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      i2cr@20 {
+        compatible = "ibm,i2cr-fsi-master";
+        reg = <0x20>;
+      };
+    };
-- 
2.31.1

