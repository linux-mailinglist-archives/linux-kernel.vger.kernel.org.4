Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAE263E197
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiK3UNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiK3UNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:13:05 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411C089337;
        Wed, 30 Nov 2022 12:10:58 -0800 (PST)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AUJfvNw017517;
        Wed, 30 Nov 2022 20:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=IComXg4YORi2SwWsT4UeYKBhbDSN4DaJmZGY0UO+88s=;
 b=aEdmqhLS8HI3bFhjXMQApCSp6C9ibYH8e2FJzUcNL/ZYTmdj4wUQzxeNfHvtPSnqHCLK
 EVMop7U4Y7uxY/QeJTnTUISkDEdTrCdxoDLO2wh5TM57FIgm8AnNbtdWUQnPT6JomZTf
 uZFPSCiSAN8ZWAX/lP12ZcObLnvVwxv9fakAyFPPiCacCyfbwBqUvL6f44+73e2Wn04C
 CAUIKeUvWFweNL5PsIVwT+QAyhk3Uelk0OL7U6D6MD+l1JTUDsjz6+/+/pH5tLVUw91K
 1qFseI6X4jZ7D34v1yKPB8pzjWMG5jtjfAZ1jrnwHdPQOH/+itMBAHsSq1xEwPL6CCvg nA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3m693saqyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 20:10:19 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id A7EC82FCF2;
        Wed, 30 Nov 2022 20:10:18 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 1BC6A8091E1;
        Wed, 30 Nov 2022 20:10:18 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        nick.hawkins@hpe.com, corbet@lwn.net, linux@armlinux.org.uk,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/6] dt-bindings: hwmon: Add hpe,gxp-fan-ctrl
Date:   Wed, 30 Nov 2022 14:08:43 -0600
Message-Id: <20221130200846.4226-4-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221130200846.4226-1-nick.hawkins@hpe.com>
References: <20221130200846.4226-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: YWbtdxhh4p65Cs89bUzQUQOT68g_EAht
X-Proofpoint-ORIG-GUID: YWbtdxhh4p65Cs89bUzQUQOT68g_EAht
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 spamscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211300142
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Create documentation for the binding to support control of the fans on
HPE platforms.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 .../bindings/hwmon/hpe,gxp-fan-ctrl.yaml      | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml b/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
new file mode 100644
index 000000000000..4a52aac6be72
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/hpe,gxp-fan-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HPE GXP Fan Controller
+
+maintainers:
+  - Nick Hawkins <nick.hawkins@hpe.com>
+
+description: |
+  The HPE GXP fan controller controls the fans through an external CPLD
+  device that connects to the fans.
+
+properties:
+  compatible:
+    const: hpe,gxp-fan-ctrl
+
+  reg:
+    items:
+      - description: Fan controller PWM
+      - description: Programmable logic
+      - description: Function 2
+
+  reg-names:
+    items:
+      - const: base
+      - const: pl
+      - const: fn2
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+additionalProperties: false
+
+examples:
+  - |
+    fan-controller@1000c00 {
+      compatible = "hpe,gxp-fan-ctrl";
+      reg = <0x1000c00 0x200>, <0xd1000000 0xff>, <0x80200000 0x100000>;
+      reg-names = "base", "pl", "fn2";
+    };
-- 
2.17.1

