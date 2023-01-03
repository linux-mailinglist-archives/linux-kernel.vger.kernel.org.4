Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571DA65C83C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjACUjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbjACUj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:39:28 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECB213D5F;
        Tue,  3 Jan 2023 12:39:27 -0800 (PST)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303K26o3022980;
        Tue, 3 Jan 2023 20:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=1tzg1w7uAhaaL/yFyWff1B6GmIGuz332mkdGeVWvSA8=;
 b=D/IbkQXi1Ny2XBBxwPdz69oljA+Yq9K2wjN8abfoOjp4gNe9uYkxuxZRMFLbXdtJqhWJ
 MYoRYb0AKz71FJG5AZveMXv6j8K0GCIDa0QhcZ9U7uoIpgZEi6T3Q5f0xXLTfQ9vSI90
 D16dI9DkfnumBumU1Nqq/0zFJbPYOEMKVeQB8cEWzM6CD68fXNHxaVIPvmR3y5E3oLgf
 wSuCsxKqsdl0H5Nwq4/SRYCgFalwJNUlUOX8ePAyV77NAT9mb0aDR5FDXEZEJXZXBgJo
 Oymt3tpXty/+geVRRq4R6lw/pPdS0od7v+PlRch7+1qPbZZwz2oeIctsnKK+qcLyfmeY Ug== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3mvswdrhfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 20:38:51 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id C262F80998C;
        Tue,  3 Jan 2023 20:38:50 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 3D74480B777;
        Tue,  3 Jan 2023 20:38:50 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net,
        linux@armlinux.org.uk, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/5] dt-bindings: hwmon: Add hpe,gxp-fan-ctrl
Date:   Tue,  3 Jan 2023 14:36:51 -0600
Message-Id: <20230103203654.59322-3-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230103203654.59322-1-nick.hawkins@hpe.com>
References: <20230103203654.59322-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: LFPNURXYhEwH2JJF-H2QiI47LbXoYNm0
X-Proofpoint-GUID: LFPNURXYhEwH2JJF-H2QiI47LbXoYNm0
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_07,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030174
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
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>

---
v4:
 *No change
v3:
 *No change
v2:
 *Changed plreg to pl
 *Changed fn2reg to reg
 *Edited descriptions for all registers
 *Changed fanctrl to fan-controller
 *Changed commit description
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

