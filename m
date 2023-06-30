Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5399743B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjF3MEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjF3MEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:04:25 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51D01FFD
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 05:04:23 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U79wCv011195;
        Fri, 30 Jun 2023 05:04:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=u4Z40xhGawqWRi7aPeii+Iq8sOO7ofMi4Sa4WpeOOMo=;
 b=J9+zi74eUNSClEECTkc5VR/tP7fHzIRvUUqRVL4AH+riCYXJB9pgezqoURv1r/6xsdaG
 gZOhx+/kapzJYCjnua6ksc9ucEF1KP2CUCaImasIRwHQb3fPuUvtL9apNpgNFQ8Hj2+H
 UW0hxVzewp288LuATxHbKpP1wd5wzov+rSVvAgBLGKgTnxFl/JUwLtxuKE0kfjxaRWBg
 VfBy/iaNdfSLLYtTydcJffnWEWAQ73vYkDE1KXJR803OE4aBOGw4VqRUnkAezHz+y3Bx
 rgBHjtG6gEUJ3otGgjD9kByrpZhEm01cjvmDBWPaFP3+GaVMoEo7u8XDmEYo9/Uja7X0 yA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3rgvpc63bp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 05:04:16 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 30 Jun
 2023 05:04:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 30 Jun 2023 05:04:13 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
        by maili.marvell.com (Postfix) with ESMTP id E204A3F7059;
        Fri, 30 Jun 2023 05:04:10 -0700 (PDT)
From:   Gowthami Thiagarajan <gthiagarajan@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <bbhushan2@marvell.com>,
        <gcherian@marvell.com>, <lcherian@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH 4/6] dt-bindings: perf: marvell: Add YAML schemas for Marvell Odyssey LLC-TAD pmu
Date:   Fri, 30 Jun 2023 17:33:49 +0530
Message-ID: <20230630120351.1143773-5-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630120351.1143773-1-gthiagarajan@marvell.com>
References: <20230630120351.1143773-1-gthiagarajan@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: o4n1dmVrwuakqI0kXO-mv5yUYGgsmjsb
X-Proofpoint-ORIG-GUID: o4n1dmVrwuakqI0kXO-mv5yUYGgsmjsb
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

Add device tree bindings for Marvell Odyssey LLC-TAD performance
monitor unit

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---
 .../bindings/perf/marvell-odyssey-tad.yaml    | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-odyssey-tad.yaml

diff --git a/Documentation/devicetree/bindings/perf/marvell-odyssey-tad.yaml b/Documentation/devicetree/bindings/perf/marvell-odyssey-tad.yaml
new file mode 100644
index 000000000000..139567166f77
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/marvell-odyssey-tad.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/marvell-odyssey-tad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Odyssey LLC-TAD performance monitor
+
+maintainers:
+  - Gowthami Thiagarajan <gthiagarajan@marvell.com>
+
+description: |
+  The Tag-and-Data units (TADs) maintain coherence and contain CN10K
+  shared on-chip last level cache (LLC). The tad pmu measures the
+  performance of last-level cache. Each tad pmu supports up to eight
+  counters.
+
+  The DT setup comprises of number of tad blocks, the sizes of pmu
+  regions, tad blocks and overall base address of the HW.
+
+properties:
+  compatible:
+    const: marvell,odyssey-tad-pmu
+
+  reg:
+    maxItems: 1
+
+  marvell,tad-cnt:
+    description: specifies the number of tads on the soc
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  marvell,tad-page-size:
+    description: specifies the size of each tad page
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  marvell,tad-pmu-page-size:
+    description: specifies the size of page that the pmu uses
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - marvell,tad-cnt
+  - marvell,tad-page-size
+  - marvell,tad-pmu-page-size
+
+additionalProperties: false
+
+examples:
+  - |
+
+    tad {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        tad_pmu@80000000 {
+            compatible = "marvell,odyssey-tad-pmu";
+            reg = <0x87E2 0x2B030000 0x0 0x1000>;
+            marvell,tad-cnt = <1>;
+            marvell,tad-page-size = <0x1000>;
+            marvell,tad-pmu-page-size = <0x1000>;
+        };
+    };
-- 
2.25.1

