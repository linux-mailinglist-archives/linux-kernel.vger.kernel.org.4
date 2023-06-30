Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F3C743B69
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjF3ME0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjF3MEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:04:22 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2642C1FCC
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 05:04:21 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U2CEJI013689;
        Fri, 30 Jun 2023 05:04:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=AouykxsHJQ6G801BqoEOg/S/d76AYcbTjVSAsV8G8KM=;
 b=FTv9Kh3FB2B0lgixISOT8FVmVZhwtiR6V4sDxVnRBLJPHUsEg2hsmdjDaUB1dhCKOyW7
 qZQpM9rMM6uK9kp12pxQaLfG6E2c/ZIDLKx+jLm8At3cEtdZHX4KT7NSHaROEhQeiNYf
 QUPZDWse+x14PSjV+EzntLGPDKToMqoB+BsxwRgoDOZS/D8gkWLym4w1zoWRproNwK4X
 U5Hz1+qURbdut4/h1BunIyn64HbBxsii+1KyC+Sju0/Gqlpl7PZCs2rCPb2qugAWDjCY
 m8021hNTNe4QEuJYBDioK94jPL7z/bYGDHZpYjx2/UAC55IjW/zWTQvgp0VW8oDdXQtk AA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rhp2ehnm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 05:04:07 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 30 Jun
 2023 05:04:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 30 Jun 2023 05:04:05 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
        by maili.marvell.com (Postfix) with ESMTP id 0F00E5B6926;
        Fri, 30 Jun 2023 05:04:02 -0700 (PDT)
From:   Gowthami Thiagarajan <gthiagarajan@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <bbhushan2@marvell.com>,
        <gcherian@marvell.com>, <lcherian@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH 2/6] dt-bindings: perf: marvell: Add YAML schemas for Marvell PEM pmu
Date:   Fri, 30 Jun 2023 17:33:47 +0530
Message-ID: <20230630120351.1143773-3-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630120351.1143773-1-gthiagarajan@marvell.com>
References: <20230630120351.1143773-1-gthiagarajan@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6pph-w79iTQO9SxQ4LFYKH_-HRgJlkFD
X-Proofpoint-GUID: 6pph-w79iTQO9SxQ4LFYKH_-HRgJlkFD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for Marvell PEM performance monitor unit

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
 .../bindings/perf/marvell-odyssey-pem.yaml    | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-odyssey-pem.yaml

diff --git a/Documentation/devicetree/bindings/perf/marvell-odyssey-pem.yaml b/Documentation/devicetree/bindings/perf/marvell-odyssey-pem.yaml
new file mode 100644
index 000000000000..6af201fbccd8
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/marvell-odyssey-pem.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/marvell-odyssey-pem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Odyssey PCIe interface performance monitor
+
+maintainers:
+  - Linu Cherian <lcherian@marvell.com>
+  - Gowthami Thiagarajan <gthiagarajan@marvell.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - marvell,pem-pmu
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
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pmu@8e0000005000 {
+            compatible = "marvell,pem-pmu";
+            reg = <0x8E00 0x00005000 0x0 0x3000>;
+        };
+    };
-- 
2.25.1

