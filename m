Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BDB693A14
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 21:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBLU6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 15:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBLU6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 15:58:07 -0500
Received: from st43p00im-zteg10062001.me.com (st43p00im-zteg10062001.me.com [17.58.63.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE0AEB60
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 12:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1676235084; bh=iXPcVESiYpddzMqQnxfdfMRMU7vmmNrIn9723DUGq8A=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Vy9WVgzunfB0tOLJBAwzisUOV4YPs4KQY90BgTdURkPntZywp56SDdR8WCFEMfwTU
         +Pcj1Mmt+TLA9iWf+KFnRfwH1wCqsZlAMChukn44G3Lq+3dRYZjuFyAhFLMV1D+XQp
         C1bLqRRr3n1ST0OvWSF5NdVMraGGZ8dvRTBV58vItQSnDnZbGNLiMh7H1AMXxpN8j7
         oT1x4R/GWHXkPIpGcunu1Eh3Lxau39I5cH5CIw5D2PWTiMQOR2sAtGOEE6gTrZ+rqR
         lFFEhrd6CsfUYasGz9qNIeml8+IxfFuiIiTbnwTZCXI3urR9gjX8ltR3LKhZFPu767
         KVYOxSRkcb0tw==
Received: from localhost (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-zteg10062001.me.com (Postfix) with ESMTPSA id 0514A8006C7;
        Sun, 12 Feb 2023 20:51:23 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Alain Volmat <avolmat@me.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: arm: sti: add sti boards and remove stih415/stih416
Date:   Sun, 12 Feb 2023 21:51:07 +0100
Message-Id: <20230212205107.8073-3-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230212205107.8073-1-avolmat@me.com>
References: <20230212205107.8073-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dPMAEenNzL_QBXhyqmDAMoAzQ-2KAPFY
X-Proofpoint-ORIG-GUID: dPMAEenNzL_QBXhyqmDAMoAzQ-2KAPFY
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.816,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-17=5F04:2022-01-14=5F01,2022-01-17=5F04,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=975 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2302120192
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for STi platform boards and remove stih415/stih416 items.
This commit also moves the sti.yaml binding file into soc/sti folder

Signed-off-by: Alain Volmat <avolmat@me.com>
---
v2: update licensing
    move file into soc/sti folder

 .../devicetree/bindings/arm/sti.yaml          | 26 ---------------
 .../devicetree/bindings/soc/sti/sti.yaml      | 33 +++++++++++++++++++
 2 files changed, 33 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/sti.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/sti/sti.yaml

diff --git a/Documentation/devicetree/bindings/arm/sti.yaml b/Documentation/devicetree/bindings/arm/sti.yaml
deleted file mode 100644
index 3ca054c64377..000000000000
--- a/Documentation/devicetree/bindings/arm/sti.yaml
+++ /dev/null
@@ -1,26 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/arm/sti.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: ST STi Platforms
-
-maintainers:
-  - Patrice Chotard <patrice.chotard@foss.st.com>
-
-properties:
-  $nodename:
-    const: '/'
-  compatible:
-    items:
-      - enum:
-          - st,stih415
-          - st,stih416
-          - st,stih407
-          - st,stih410
-          - st,stih418
-
-additionalProperties: true
-
-...
diff --git a/Documentation/devicetree/bindings/soc/sti/sti.yaml b/Documentation/devicetree/bindings/soc/sti/sti.yaml
new file mode 100644
index 000000000000..f32770867142
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/sti/sti.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/sti/sti.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST STi Platforms
+
+maintainers:
+  - Patrice Chotard <patrice.chotard@foss.st.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - const: st,stih407-b2120
+          - const: st,stih407
+      - items:
+          - enum:
+              - st,stih410-b2120
+              - st,stih410-b2260
+          - const: st,stih410
+      - items:
+          - enum:
+              - st,stih418-b2199
+              - st,stih418-b2264
+          - const: st,stih418
+
+additionalProperties: true
+
+...
-- 
2.34.1

