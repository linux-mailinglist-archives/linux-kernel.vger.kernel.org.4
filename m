Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB066183D6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiKCQJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiKCQIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:08:01 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CB3186C3;
        Thu,  3 Nov 2022 09:08:00 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3G4rqr031962;
        Thu, 3 Nov 2022 16:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=LhiAKVp9m688wUxXx2M1ClnBoWdFG6OPFXaTZB32dSk=;
 b=Su64QcL/uZfaCQ5VE7mo0vmEw9KTeay7KK024q0P1dWB1RONf9IicefqwifsHl7rLrhg
 s8XyDMxTkxBUqiNjkDDmK60BUAZAHYQKBoLtvKn5K4/J2e6yyB8xImNlRsjn9M6H/raH
 RmluNUE1V1sE5XHBcDuPS0Oi2yi62T5t08voBso1OGPiKMIjwdy6efA8OHrXjHX4yCGZ
 hr4z6YkRVBmjR5gC6Z4LxMwwaZzRIsxYj+y29bUxA/ZY5rnPqAjhQaMLdCyajh5NRJvy
 66EMtCzbFxelirmW/zvtiRtFxWWHlaDaVum5yLRi7XTak/i8nXxbd5c53/bJmbUtD82c zQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kmg470c05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 16:07:35 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 21B8E804723;
        Thu,  3 Nov 2022 16:07:33 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 67AC78036BB;
        Thu,  3 Nov 2022 16:07:33 +0000 (UTC)
From:   richard.yu@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, richard.yu@hpe.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        balbi@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 2/7] dt-bindings: usb: hpe,gxp-udc: Add binding for gxp gadget
Date:   Thu,  3 Nov 2022 11:06:20 -0500
Message-Id: <20221103160625.15574-3-richard.yu@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221103160625.15574-1-richard.yu@hpe.com>
References: <20221103160625.15574-1-richard.yu@hpe.com>
X-Proofpoint-GUID: 2w5h7FawyUsJ5gpQ1DXL198IZylJJfmr
X-Proofpoint-ORIG-GUID: 2w5h7FawyUsJ5gpQ1DXL198IZylJJfmr
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=664
 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030107
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Yu <richard.yu@hpe.com>

Create documentation for the hpe,gxp-udc binding to support access to
the virtual USB device.

Signed-off-by: Richard Yu <richard.yu@hpe.com>
---
 .../devicetree/bindings/usb/hpe,gxp-udc.yaml  | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/hpe,gxp-udc.yaml

diff --git a/Documentation/devicetree/bindings/usb/hpe,gxp-udc.yaml b/Documentation/devicetree/bindings/usb/hpe,gxp-udc.yaml
new file mode 100644
index 000000000000..f1ec4df8c3d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/hpe,gxp-udc.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/hpe,gxp-udc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HPE GXP Gadget Universal Device Controller (UDC)
+
+maintainers:
+  - Richard Yu <richard.yu@hpe.com>
+  - Jean-Marie Verdun <verdun@hpe.com>
+  - Nick Hawkins <nick.hawkins@hpe.com>
+
+properties:
+  compatible:
+    const: hpe,gxp-udc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdevnum:
+    description:
+      virtual device number.
+
+  fepnum:
+    description:
+      number of the flexible end-points this device is needed.
+
+  hpe,syscon-phandle:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description:
+      Phandle to the gxp vEHCI controller access vDevice registers.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vdevnum
+  - fepnum
+  - hpe,syscon-phandle
+
+additionalProperties: false
+
+examples:
+  - |
+    udc@80401000 {
+      compatible = "hpe,gxp-udc";
+      reg = <0x80401000 0x1000>;
+      interrupts = <13>;
+      interrupt-parent = <&vic1>;
+      vdevnum = <0>;
+      fepnum = <7>;
+      hpe,syscon-phandle = <&udc_system_controller>;
+    };
-- 
2.17.1

