Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F367A63B594
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 00:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbiK1XEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 18:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbiK1XEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:04:25 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6492BB31;
        Mon, 28 Nov 2022 15:04:25 -0800 (PST)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASMgedY021876;
        Mon, 28 Nov 2022 23:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=t31IEjcYchjEXWmt9ra1gXCpjlVEs+O+5Rxh/UM/zC4=;
 b=TqYixPXOg8tQOJbNmZI5LaMF1lIeLqJ3j67TY8KWEugA/8hXO8Vn2LOslCE/dO1L1kGR
 r6BAIpMBopqSjEn2Cve+FsYCsvjI8Wgcb1zN8JRjbtvTxownXLSZZdLToxWkFOOk5LKC
 e0c6iKaPyDfj3BPSiVxg/8f8TAMNtSTXEltfKdWFQL2IMyE5IDDAtXbC//NPxJ6svxuw
 TfyCcVrKoXC4tQw0T5IXnobOxQTRAysPTPn48rb/bdjok4/BQIf+qFbyV3lGy86i/eFJ
 Oe/ukFdUofTxe3OhZJxOFZ27ksSfwDJ0VwutWgrWSsiWgxd7E4KgaGqnyotIzq2ljXNF UQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3m50q92jsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 23:03:50 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 77EDA2FB04;
        Mon, 28 Nov 2022 23:03:49 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id E2BF98084C7;
        Mon, 28 Nov 2022 23:03:48 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        nick.hawkins@hpe.com, corbet@lwn.net, linux@armlinux.org.uk,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/6] dt-bindings: hwmon: Add hpe,gxp-fan-ctrl
Date:   Mon, 28 Nov 2022 17:02:16 -0600
Message-Id: <20221128230219.39537-4-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221128230219.39537-1-nick.hawkins@hpe.com>
References: <20221128230219.39537-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: A-Qb7R9fw52arUGo_SndxabU11Yzowe6
X-Proofpoint-GUID: A-Qb7R9fw52arUGo_SndxabU11Yzowe6
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_17,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211280166
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

v2:
 *Changed plreg to pl
 *Changed fn2reg to reg
 *Edited descriptions for all registers
 *Changed fanctrl to fan-controller
 *Changed commit description
---
 .../bindings/hwmon/hpe,gxp-fan-ctrl.yaml      | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml b/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
new file mode 100644
index 000000000000..b4eb7460e277
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
@@ -0,0 +1,41 @@
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

