Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903D372D002
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbjFLT6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237662AbjFLT5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:57:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E412E71;
        Mon, 12 Jun 2023 12:57:20 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CJpnfB007238;
        Mon, 12 Jun 2023 19:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=kX3Vl11fgpbcRT2Yp+QxdfAbvT5CTTbsQ0eGJvC1rnw=;
 b=G/NAXAS+C4LISWIgGIlBbe59q+KWRgy5IgqTeggjVK6+OSz9E+OjkaA1ORAA50ovEqMV
 3Y2QlaDfra8Hox0cDT1v27TPg/stG6PhSXTN55uFhK/7SAypDgCK183eGH4xyANKPt8R
 WVmEdKXgMK2qwvDD1Xc1ZwldLUipUFMtAl+x1f7jnjCyAkBz2KjZWxfudFLtTxudm0w5
 Xdf+feFW5DiWW8CEM+cMqZKH7dCSCSutJRzUov8/GWWAiIZOz7lnIZpqBwm6ZL3q57nm
 ULTSc2NfAPHvTtXGT0D/9OnMwreeGSrBJLmN/FtY3AfCA4qfATmJWIgJjnlr9TOTUljz 2g== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r69w4829f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 19:57:04 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35CJ8oAw011879;
        Mon, 12 Jun 2023 19:57:03 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3r4gt5krsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 19:57:03 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35CJv2bY57737694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 19:57:02 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13C1658043;
        Mon, 12 Jun 2023 19:57:02 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC4E05805D;
        Mon, 12 Jun 2023 19:57:01 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.148.226])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 12 Jun 2023 19:57:01 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 12/14] dt-bindings: fsi: Document the IBM I2C Responder virtual FSI master
Date:   Mon, 12 Jun 2023 14:56:55 -0500
Message-Id: <20230612195657.245125-13-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230612195657.245125-1-eajames@linux.ibm.com>
References: <20230612195657.245125-1-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: COxFuP2MtRtDASz-AOQA4VmmM1MihyHp
X-Proofpoint-GUID: COxFuP2MtRtDASz-AOQA4VmmM1MihyHp
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_14,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120169
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

