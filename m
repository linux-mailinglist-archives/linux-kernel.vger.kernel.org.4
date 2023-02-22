Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A01269FC06
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjBVTYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjBVTYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:24:34 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C333B3BDAA;
        Wed, 22 Feb 2023 11:24:17 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MJ5LBD019799;
        Wed, 22 Feb 2023 19:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=kX3Vl11fgpbcRT2Yp+QxdfAbvT5CTTbsQ0eGJvC1rnw=;
 b=VuzspzssKRrdsJRz0fM8qiJDlkAqnQEpxKB7LtRRJUDj2xcH/A9NPDShUXmpAmvs5THo
 iPZT/8H7iMycBC8rUxPoqFZlqUlDsWVVy5ZprYwvgseeLS9MrVqc6LNTradltvljFkrx
 T8jHxjgPyBaIT7xsHYH7u1Vv9+K3zkES658gNDtE/4oBZcA4rgAzUYJALyZyQGMJsJTA
 PdAGLEhm4oTWxaMgPWCdoOutj0OkszyQ0KgwQru/LWIdqMp3zitTFjcQLaQnaG5EYSd6
 YzgZIWXUnPNlqG0ievP/DgiZGhITxvoEd/kn0JW2vgDQXGsxEJifICKBhUAQJWlnIU6N 9g== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwrwa0xk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 19:24:01 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31MGeTOJ014152;
        Wed, 22 Feb 2023 19:24:01 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3ntpa79vyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 19:24:01 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31MJNxIP39584332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 19:24:00 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7F6C5805A;
        Wed, 22 Feb 2023 19:23:59 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3ECBC58051;
        Wed, 22 Feb 2023 19:23:58 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.56.187])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Feb 2023 19:23:58 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, eajames@linux.ibm.com
Subject: [PATCH v6 2/6] dt-bindings: fsi: Document the IBM I2C Responder virtual FSI master
Date:   Wed, 22 Feb 2023 13:23:50 -0600
Message-Id: <20230222192354.4055034-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230222192354.4055034-1-eajames@linux.ibm.com>
References: <20230222192354.4055034-1-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: M2gcZhKDjxjVBYBuxgCXMC5sYtV90veA
X-Proofpoint-GUID: M2gcZhKDjxjVBYBuxgCXMC5sYtV90veA
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_07,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220164
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2C Responder translates I2C commands to CFAM or SCOM operations,
effectively implementing an FSI master.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/fsi/ibm,i2cr-fsi-master.yaml     | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml

diff --git a/Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml b/Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml
new file mode 100644
index 000000000000..442cecdc57cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fsi/ibm,i2cr-fsi-master.yaml#
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
+  - |
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

