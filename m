Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC585FBACE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJKS4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiJKS41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:56:27 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5738C733F8;
        Tue, 11 Oct 2022 11:56:26 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BHIMlM006125;
        Tue, 11 Oct 2022 18:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=CUchXV7WWbk3gox4sACw8f9HOZCDAJjWULs+tFEeSLg=;
 b=QouyL17v7Qg5x6X8nYrjJGsr7qkztDwgJZh0t+EhwiMuo/Be8pClmytwrHKamGYQMLWS
 seYTjXUv2jP9fxjRFaao1vhhcCaK3XS6OgGyVHcLyh8GibaMx/A5pqXxtY41ZvdfIFEr
 btx3AzgyL15xadnE7P5SiFdgkjA9TYwB357xhnQInqyqAXtCjAuDusQPjdH/bWk63XhG
 NK+y0bOTaqko0mBvLUKunAisCaKtkOZRCYzmEaUUSmIiKk6Yg3RVzffUgTo9SoyMNCn+
 vyItd6wL80Hb/Ly3QJW5dVipmj3QBm4tJUgcA6LJoqUKeRo7YT1+f44NSQRaLOv6fvX8 KA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3k5crx8s40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 18:56:02 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 6C9F0B2;
        Tue, 11 Oct 2022 18:56:01 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 0FF8180873C;
        Tue, 11 Oct 2022 18:56:01 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 2/5] dt-bindings: soc: hpe: Add hpe,gxp-plreg
Date:   Tue, 11 Oct 2022 13:55:22 -0500
Message-Id: <20221011185525.94210-3-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011185525.94210-1-nick.hawkins@hpe.com>
References: <20221011185525.94210-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: ZIzra3gGAt9qsJSEAgExtx7ttGVVC_Ge
X-Proofpoint-GUID: ZIzra3gGAt9qsJSEAgExtx7ttGVVC_Ge
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110110
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The hpe,gxp-plreg binding provides access to the board i/o through the
Programmable logic interface. The binding provides information to enable
use of the same driver across the HPE portfolio.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 .../bindings/soc/hpe/hpe,gxp-plreg.yaml       | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/hpe/hpe,gxp-plreg.yaml

diff --git a/Documentation/devicetree/bindings/soc/hpe/hpe,gxp-plreg.yaml b/Documentation/devicetree/bindings/soc/hpe/hpe,gxp-plreg.yaml
new file mode 100644
index 000000000000..cdc54e66d9a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/hpe/hpe,gxp-plreg.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/hpe/hpe,gxp-plreg.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: HPE GXP Programmable Logic Registers Controller
+
+maintainers:
+  - Nick Hawkins <nick.hawkins@hpe.com>
+
+properties:
+  compatible:
+    items:
+      - const: hpe,gxp-plreg
+      - const: simple-mfd
+      - const: syscon
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+
+additionalProperties: true
+
+examples:
+  - |
+    cpld@1e789000 {
+      compatible = "hpe,gxp-plreg", "simple-mfd", "syscon";
+      reg = <0x1e789000 0x1000>;
+      fan1 {
+        bit = <0x01>;
+        inst = <0x27>;
+        id = <0x2B>;
+      };
+      iopled1 {
+        on = <0x04 0x01>;
+      };
+      pwrbtn {
+        latch = <0xFF 0xFF 0x04>;
+      };
+    };
+
-- 
2.17.1

