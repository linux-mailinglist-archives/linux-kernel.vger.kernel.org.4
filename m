Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A09D674044
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjASRrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjASRri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:47:38 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835CE7EC9;
        Thu, 19 Jan 2023 09:47:36 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JHg8hq030400;
        Thu, 19 Jan 2023 17:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=pICDYX54VCEgJSugsPl6E3o1CDpdaCfGGQde7pquyb4=;
 b=jjd8Xp9Afw4Vnd7EttnPMkUqQCiojQuDvP6CnLLnC75o74yNRs0eD482clVCszneK2et
 4JOG9BncTtXpnRxosSU2wbWMMPVgAUefioXBwJ668eTNwU3ovYxOWq3N2s7FcJLCv+WQ
 2mzVqe9UqC4CdgrfAl9gdjt0/PBHkCikxVWltYmbH9YXgnlhlAk9mQDsvakzGrtZLFLq
 Kn/CKiEwLyoF3nDXjPKSnwtJxQin/zwntD72YI9gvSqXUePKfeZuMDpu36foO6QbW7if
 yDqbaqpTB+DZ2NKe7Wl3Bt1EYRd7jDEhLwjtalewmhE0TehLnjc2N6hlkXPAf3YyIoM6 RQ== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n7afx84jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 17:47:24 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30JGvFWq009728;
        Thu, 19 Jan 2023 17:47:23 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3n3m186utk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 17:47:23 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30JHlLci61342136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 17:47:22 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0ABE5805A;
        Thu, 19 Jan 2023 17:47:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97D2F58056;
        Thu, 19 Jan 2023 17:47:20 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.43.39])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 19 Jan 2023 17:47:20 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 1/2] dt-bindings: fsi: Document the IBM I2C Responder virtual FSI master
Date:   Thu, 19 Jan 2023 11:47:13 -0600
Message-Id: <20230119174714.1486042-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230119174714.1486042-1-eajames@linux.ibm.com>
References: <20230119174714.1486042-1-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XNkVfpn2bwYIVhMNIm9Yf28LxvqOwBsk
X-Proofpoint-GUID: XNkVfpn2bwYIVhMNIm9Yf28LxvqOwBsk
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_11,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301190144
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
 .../devicetree/bindings/fsi/ibm,i2cr.yaml     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,i2cr.yaml

diff --git a/Documentation/devicetree/bindings/fsi/ibm,i2cr.yaml b/Documentation/devicetree/bindings/fsi/ibm,i2cr.yaml
new file mode 100644
index 000000000000..929ca10988f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/ibm,i2cr.yaml
@@ -0,0 +1,42 @@
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
+  This binding describes an I2C device called the I2C Responder (I2CR). The
+  I2CR translates commands sent over I2C bus to FSI CFAM reads and writes or
+  SCOM operations. The CFAM access means that the I2CR can act as an FSI
+  master.
+
+properties:
+  compatible:
+    enum:
+      - ibm,i2cr
+
+   reg:
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
+        compatible = "ibm,i2cr";
+        reg = <0x20>;
+      };
+    };
-- 
2.31.1

