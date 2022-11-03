Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FCB6183C6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiKCQIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiKCQH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:07:57 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88EDBE23;
        Thu,  3 Nov 2022 09:07:51 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3G5qhn014486;
        Thu, 3 Nov 2022 16:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=PijJeW7nT9vvqoxeQzAjDcw+HIn5vW1PglHKsUborrQ=;
 b=CpVP+LDzngHA3hV/k/ez7Fd+36l1ghc3zxlHb2VoSbHxIF6cBMES3/d1eZGwIWsu4oY3
 ZFIk057C2X8k3vAB8yUSL736ke5J4z7GlZjYOO62a0eJffn/MztQEZpO8+RBC6m5e99M
 fiw4RLnSd0fYVZZderdYeaDetyvlMxeW6LXl3fcKPJxTbQSBR3qlBGFhLEjPeviOVTDJ
 MpVsgCl8YK9wAdb0W/h2rnFZpRkQqAqwnlf7G6Jx17t+fSV6bk5Nls/YrJokxYvpbAlj
 +ZrmMy0wrVX+Kh4MiOCNsSusgwKRTPHsN4bYv4OYtMnYtiAlCIQEpE5JRekOOqZ6EZ/f rQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3kmghb84a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 16:07:35 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 254B013961;
        Thu,  3 Nov 2022 16:07:35 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 8E4808036BB;
        Thu,  3 Nov 2022 16:07:34 +0000 (UTC)
From:   richard.yu@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, richard.yu@hpe.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        balbi@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 4/7] dt-bindings: usb: hpe,gxp-vuhc: add binding for gxp vEHCI
Date:   Thu,  3 Nov 2022 11:06:22 -0500
Message-Id: <20221103160625.15574-5-richard.yu@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221103160625.15574-1-richard.yu@hpe.com>
References: <20221103160625.15574-1-richard.yu@hpe.com>
X-Proofpoint-GUID: 52PkHq7mYRBwpWf7ph1UgTQ1cW_-sLe6
X-Proofpoint-ORIG-GUID: 52PkHq7mYRBwpWf7ph1UgTQ1cW_-sLe6
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=972 spamscore=0 adultscore=0
 bulkscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211030107
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Yu <richard.yu@hpe.com>

Create documentation for the hpe,gxp-vuhc binding to support access to
the gxp virtual EHCI controller.

Signed-off-by: Richard Yu <richard.yu@hpe.com>
---
 .../devicetree/bindings/usb/hpe,gxp-vuhc.yaml | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/hpe,gxp-vuhc.yaml

diff --git a/Documentation/devicetree/bindings/usb/hpe,gxp-vuhc.yaml b/Documentation/devicetree/bindings/usb/hpe,gxp-vuhc.yaml
new file mode 100644
index 000000000000..1411a2550092
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/hpe,gxp-vuhc.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/hpe,gxp-vuhc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HPE GXP Virtual Universal Host Controller (vUHC)
+
+maintainers:
+  - Richard Yu <richard.yu@hpe.com>
+  - Jean-Marie Verdun <verdun@hpe.com>
+  - Nick Hawkins <nick.hawkins@hpe.com>
+
+properties:
+  compatible:
+    items:
+      - const: hpe,gxp-vuhc
+      - const: syscon
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
+    vuhc@80400000 {
+      compatible = "hpe,gxp-vuhc", "syscon";
+      reg = <0x80400000 0x80>;
+    };
-- 
2.17.1

