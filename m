Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED6A74A68A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 00:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjGFWEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 18:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjGFWEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:04:02 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4621BF3;
        Thu,  6 Jul 2023 15:04:01 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366K2sIF015802;
        Thu, 6 Jul 2023 22:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=zVII/PXG3Y6NdKx0fn+21TgXx8mLHkE7tiHfaKhWlt8=;
 b=TvrNtjbA4y3NX9xniqOAh5dVYM8YaXvNTC8pGRQHuUw2M3lSrQ6c6jf+E/gCsd8X+gpK
 91ZNmTYDpnemNrVbGke8DqdlvrLCGyMdtHfMdnWrZXmH+1DVW3LKEhFcEZwlKrMPDIrx
 1W4Xd0RYYUgSa7ji6gkVcp/l3Rp5BZX7Qngcygu6RFNtMjNpq/el52OdC8AzEdeyjJ/U
 Wgr9gssmQ8fk+Bgoc/2pk4NteB43Wdxgk3ZDECcq4L/GgDK7AmolUwRNwRnu9IeowHEB
 Kx2Yd12mvZW+W/AdbMGjmIpB0V9p5PMwGPJym/gQcPcY/M4SzfWSujDhDzE+tiopxy7o jA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3rnx95bs9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 22:03:50 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id DBF90804DF6;
        Thu,  6 Jul 2023 22:03:49 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 5FEF5806B42;
        Thu,  6 Jul 2023 22:03:49 +0000 (UTC)
From:   richard.yu@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, richard.yu@hpe.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: usb: Add HPE GXP UDCG Controller
Date:   Thu,  6 Jul 2023 16:59:08 -0500
Message-Id: <20230706215910.78772-2-richard.yu@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230706215910.78772-1-richard.yu@hpe.com>
References: <20230706215910.78772-1-richard.yu@hpe.com>
X-Proofpoint-GUID: LOc4MqMbkCEn3KzxJ2lbIqqz13eDBRYM
X-Proofpoint-ORIG-GUID: LOc4MqMbkCEn3KzxJ2lbIqqz13eDBRYM
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_15,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 phishscore=0 mlxlogscore=813 adultscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060193
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Yu <richard.yu@hpe.com>

Provide access to the two register regions for GXP Virtual EHCI
controller through the hpe,gxp-udcg binding.

Signed-off-by: Richard Yu <richard.yu@hpe.com>
---
 .../devicetree/bindings/usb/hpe,gxp-udcg.yaml | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/hpe,gxp-udcg.yaml

diff --git a/Documentation/devicetree/bindings/usb/hpe,gxp-udcg.yaml b/Documentation/devicetree/bindings/usb/hpe,gxp-udcg.yaml
new file mode 100644
index 000000000000..e6746374f97d
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/hpe,gxp-udcg.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/hpe,gxp-udcg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HPE GXP USB Virtual EHCI controller
+
+maintainers:
+  - Nick Hawkins <nick.hawkins@hpe.com>
+  - Richard Yu <richard.yu@hpe.com>
+
+description: |+
+  The HPE GXP USB Virtual EHCI Controller implements 1 set of USB EHCI
+  register and several sets of device and endpoint registers to support
+  the virtual EHCI's downstream USB devices.
+
+properties:
+  compatible:
+    enum:
+      - hpe,gxp-udcg
+
+  reg:
+    items:
+      - description: UDC Global (UDCG) config controller
+      - description: UDC Invidual config/interrupt controllers
+
+  reg-names:
+    items:
+      - const: udcg
+      - const: udc
+
+  interrupts:
+    maxItems: 1
+
+  hpe,vehci-downstream-ports:
+    description: Number of downstream ports supported by the GXP
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 4
+    minimum: 1
+    maximum: 8
+
+  hpe,vehci-generic-endpoints:
+    description: Number of generic endpoints supported by the GXP
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 16
+    minimum: 1
+    maximum: 16
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - hpe,vehci-downstream-ports
+  - hpe,vehci-generic-endpoints
+
+additionalProperties: false
+
+examples:
+  - |
+    udcg@80400800 {
+        compatible = "hpe,gxp-udcg";
+        reg = <0x80400800 0x0200>, <0x80401000 0x8000>;
+        reg-names = "udcg", "udc";
+        interrupts = <13>;
+        interrupt-parent = <&vic1>;
+        hpe,vehci-downstream-ports = <4>;
+        hpe,vehci-generic-endpoints = <16>;
+    };
-- 
2.17.1

