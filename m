Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80FB6AC93A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjCFRGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjCFRE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:04:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3612311E87;
        Mon,  6 Mar 2023 09:04:28 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326EnIID033571;
        Mon, 6 Mar 2023 16:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=kX3Vl11fgpbcRT2Yp+QxdfAbvT5CTTbsQ0eGJvC1rnw=;
 b=PXjgH1WFDfIXChS/16nUtkMTB/EPU2ugQyozjnkeTt8Su5pUrupHvXedF8/619FYq9EI
 7wbchx6yj6dukTaNhNuu5QeifHlDaCGVejMiLVEdq1RZ0sQH2iJwGPIznkMBCNwutqGU
 o8n1PVgxqco0KsTx3Lae+s6wjo/b4kbdWPBlw002hbFf62oA5q12iFlIsPEISE22Kbe8
 UPzHXmymwtkU9L1owt7D/HroFt6DDQCdNoWjhOX9ED21dB/xkuQbYoqnuLQmuepQLc02
 qD9440jdBl07uy181tkYOZUer8Hd/Loqbnqoh/VegHXHvnNsQrkTL7gv6A0C8c3HyTv8 7g== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4uaen8s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:11:08 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 326G5VvF028682;
        Mon, 6 Mar 2023 16:11:06 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3p419v62wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:11:06 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326GB55k26214786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 16:11:05 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8E0E5805B;
        Mon,  6 Mar 2023 16:11:05 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D659358059;
        Mon,  6 Mar 2023 16:11:03 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.108.29])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 16:11:03 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, eajames@linux.ibm.com
Subject: [PATCH v8 3/8] dt-bindings: fsi: Document the IBM I2C Responder virtual FSI master
Date:   Mon,  6 Mar 2023 10:10:51 -0600
Message-Id: <20230306161057.44017-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230306161057.44017-1-eajames@linux.ibm.com>
References: <20230306161057.44017-1-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xJ0syAcowyawIz15vC5s6ijXnxe2CwxZ
X-Proofpoint-ORIG-GUID: xJ0syAcowyawIz15vC5s6ijXnxe2CwxZ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_09,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060142
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

