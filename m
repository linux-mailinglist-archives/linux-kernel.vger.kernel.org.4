Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC03E663824
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 05:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjAJE0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 23:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjAJEZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 23:25:59 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8CDCE00;
        Mon,  9 Jan 2023 20:25:59 -0800 (PST)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A420Qa001958;
        Tue, 10 Jan 2023 04:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=oq9Spv30hm8SaUzTPPi5vI+uunS5acQ6Opz1SF1gujU=;
 b=mtJhO8ZP67njkDfjhw0e33YhZqIaVZF+RC4Xi2XJGYpBFSih8HGHqmYAaRU1b1371UWG
 T+urH2FmLws7ZCz3cp8+zw+M9STNgee5dXUp+427n+qlcvuatzD6H4gv+NnYK7fVc8Ma
 6DdBZoyt2kg55CBPQBEMhzZvQlSnSnuOhzwLRzUcnR32IVX4C+oXpzqpfbZJZ3Kco3cm
 ikfCKs+83v74usILCHHmfZYUMsuwxrLAD8uw36Lw0Ve626lxrXBkclJcp2z9UXAwtCNm
 LSZlFILGCGhN4Ovr4AvaC/PE3w7OZbXg58+JiaCL1qxV6tOfQtbZ4FLn5/mZ7ehuGJ4C Kw== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3n0vynsfnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 04:25:50 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 603088085F8;
        Tue, 10 Jan 2023 04:25:49 +0000 (UTC)
Received: from openbmc-dev.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id BAD71800BB1;
        Tue, 10 Jan 2023 04:25:45 +0000 (UTC)
From:   clayc@hpe.com
To:     linux-kernel@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        verdun@hpe.com, nick.hawkins@hpe.com, arnd@arndb.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux@armlinux.org.uk, olof@lixom.net
Cc:     Clay Chang <clayc@hpe.com>
Subject: [PATCH 2/5] dt-bindings: soc: hpe: hpe,gxp-srom.yaml
Date:   Tue, 10 Jan 2023 12:25:30 +0800
Message-Id: <20230110042533.12894-3-clayc@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230110042533.12894-1-clayc@hpe.com>
References: <20230110042533.12894-1-clayc@hpe.com>
X-Proofpoint-GUID: G61yJjXjjmDKDYSUP-AaQHnd-F-X-MD8
X-Proofpoint-ORIG-GUID: G61yJjXjjmDKDYSUP-AaQHnd-F-X-MD8
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_01,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100026
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clay Chang <clayc@hpe.com>

Document binding to support SROM driver in GXP.

Signed-off-by: Clay Chang <clayc@hpe.com>
---
 .../bindings/soc/hpe/hpe,gxp-srom.yaml        | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/hpe/hpe,gxp-srom.yaml

diff --git a/Documentation/devicetree/bindings/soc/hpe/hpe,gxp-srom.yaml b/Documentation/devicetree/bindings/soc/hpe/hpe,gxp-srom.yaml
new file mode 100644
index 000000000000..14ad97d595c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/hpe/hpe,gxp-srom.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/hpe/hpe,gxp-srom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HPE GXP SoC SROM Control Register
+
+maintainers:
+  - Clay Chang <clayc@hpe.com>
+
+description: |+
+  The SROM control register can be used to configure LPC related legacy
+  I/O registers.
+
+properties:
+  compatible:
+    items:
+      - const: hpe,gxp-srom
+
+  reg:
+    items:
+      - description: SROM LPC Configuration Registers
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    srom: srom@80fc0000 {
+      compatible = "hpe,gxp-srom";
+      reg = <0x80fc0000 0x100>;
+    };
-- 
2.17.1

