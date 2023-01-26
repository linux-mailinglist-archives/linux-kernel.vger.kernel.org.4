Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5320C67D7BD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjAZVbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjAZVbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:31:47 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689C2D520;
        Thu, 26 Jan 2023 13:31:46 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QLMTWv031328;
        Thu, 26 Jan 2023 21:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=1H1+b8FWI14SN/GJs2wObEIevnbBa8C9WpCufC2z/GM=;
 b=MZo9rKQN0Dmyx2SGCbjVofk/txouBAmYqUTAszNfA9T8/9EeOYm3vH9Tk11cbbPhIXvr
 YVahzdbNFLxr5qd1GjaTQaFergWGaYgrAW+3+JGaFH3sWwJ6NrzTgfwPMLJ8jekxJ+wZ
 hksYPxSnFR9+uX4M068KAWtvH7n7lnIngU2LT0G4UBFikMBOEKCfsqiEovhnJzwuLdaV
 CVXGU1+FYFsTQ695Zumv2fpN68dubCaQ5M0FsxUfEAsTbnLKxI7a9HRH3wiKiCUW2pqO
 7+7ArAwUr1UwPypxeKFxU43Dfe9BW5z+6ENhai34DXApCPKK2Kx4KiphZj99RxcS81s3 VQ== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nc1cm05sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 21:31:28 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QJq32A006849;
        Thu, 26 Jan 2023 21:31:27 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3n87p7qbjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 21:31:27 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QLVQa430671280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 21:31:26 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89DC558043;
        Thu, 26 Jan 2023 21:31:26 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 304F058059;
        Thu, 26 Jan 2023 21:31:25 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.3.213])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jan 2023 21:31:25 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        rostedt@goodmis.org, eajames@linux.ibm.com, alistair@popple.id.au,
        joel@jms.id.au, jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v3 1/2] dt-bindings: fsi: Document the IBM I2C Responder virtual FSI master
Date:   Thu, 26 Jan 2023 15:31:22 -0600
Message-Id: <20230126213123.884125-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230126213123.884125-1-eajames@linux.ibm.com>
References: <20230126213123.884125-1-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HMBziLVKuzpB70olzR9J-3dHiRj6PBWs
X-Proofpoint-GUID: HMBziLVKuzpB70olzR9J-3dHiRj6PBWs
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260198
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

