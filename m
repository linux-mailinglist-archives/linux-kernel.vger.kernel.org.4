Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FD861A13E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiKDTjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiKDTiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:38:55 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464D32DE9;
        Fri,  4 Nov 2022 12:38:50 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4InxvY032476;
        Fri, 4 Nov 2022 19:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=cSNwqUzZCdX5UiVEc3vVaX+MjONfSqVjR+Hh8eM/+2I=;
 b=QKIINRNGAz/l91wFvlbDiwcbBo2W9O69e3laM4GZW5KGGmPdTVjXl7Uxbgt1mULfk3MU
 EfkM/OpMUoHVmJWQkyxeCzttNTp9WeqTLGQvl5LIrvD2M5RAlaPKO/kK5YZRaI+M14Nq
 /LuCPVZxPOyZ1R520RdMO6GCVA2mAjYUvp279sNAT1N2kXCnp2voLQONoWp8Jwy/m4N3
 oYOdK3KiToar7BM3oZn3khTCUx0vfCrLX58/qtNmrUHt2V67f1mGmXUKTeAJo/FTivIB
 7j+IFXWmoPEIdO5r4I3usSvFecUAF1lhpsTKn0uaQsAHaI5PCApAONjdeVwqj0hcx33V XQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kn8bv08t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 19:38:11 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id E503E8040DA;
        Fri,  4 Nov 2022 19:38:10 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 5BFF6808166;
        Fri,  4 Nov 2022 19:38:10 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        nick.hawkins@hpe.com, corbet@lwn.net, linux@armlinux.org.uk,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 3/6] dt-bindings: hwmon: Add hpe,gxp-fan-ctrl
Date:   Fri,  4 Nov 2022 14:36:54 -0500
Message-Id: <20221104193657.105130-4-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221104193657.105130-1-nick.hawkins@hpe.com>
References: <20221104193657.105130-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: yUwB621IbEXMwiJsGvtmecnb0dReeota
X-Proofpoint-GUID: yUwB621IbEXMwiJsGvtmecnb0dReeota
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_11,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 impostorscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040122
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

This provides the base registers address, programmable logic registers
address, and the function 2 registers to allow control access of the HPE
fans on the GXP SoC.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 .../bindings/hwmon/hpe,gxp-fan-ctrl.yaml      | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml b/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
new file mode 100644
index 000000000000..40a5d9cd0a30
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/hpe,gxp-fan-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GXP Fan Controller
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
+      - description: Fan controller base register
+      - description: Programmable logic registers base
+      - description: Function 2 registers base
+
+  reg-names:
+    items:
+      - const: base
+      - const: plreg
+      - const: fn2reg
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
+    fanctrl@1000c00 {
+      compatible = "hpe,gxp-fan-ctrl";
+      reg = <0x1000c00 0x200>, <0xd1000000 0xff>, <0x80200000 0x100000>;
+      reg-names = "base", "plreg", "fn2reg";
+    };
-- 
2.17.1

