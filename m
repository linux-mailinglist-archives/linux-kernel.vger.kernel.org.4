Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60A56933EF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 22:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBKVIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 16:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjBKVIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 16:08:21 -0500
Received: from mr85p00im-hyfv06021301.me.com (mr85p00im-hyfv06021301.me.com [17.58.23.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0546B14E84
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 13:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1676149695; bh=ANaeM9xES9AEOXol9pUlamK7auhn8OeqFAnfHrbeVsI=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=TJ7il2f/6xF5raV0WQOtkYjo47Mtb0baiRJYK58awae8y9HGUTxLM3Nt1EZBkoBKd
         hGB5bRQJ+Hm6+Z3RbMhBO221DAhXc8iSwUonx4EAne7Rlj7cDtj8ouOcwz/2CdkLKh
         toGJEF9xHlT7dkbovkOrAUdqlipllGIZ2mt7TngOU8U8EEkdEh7X15pnXG2chsRiPU
         KBz6dE8vZ98XRqVuBWbMrbxt9tIKbh9Lmqyvgk1YVbMgnKcaPibs4hIVo6ILk0oej0
         7EyqEb2ngujdWTvLwBvxzg8b4X9+6NqJvRTojM3wd6nhB5jXEHFj/tsi+N+ClSudJx
         4g5QkznoKi52A==
Received: from localhost (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-hyfv06021301.me.com (Postfix) with ESMTPSA id 168472150ED2;
        Sat, 11 Feb 2023 21:08:14 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Alain Volmat <avolmat@me.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: arm: sti: add sti boards and remove stih415/stih416
Date:   Sat, 11 Feb 2023 22:04:59 +0100
Message-Id: <20230211210500.9919-2-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230211210500.9919-1-avolmat@me.com>
References: <20230211210500.9919-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qJVLtNsSOAhLxVFksJgP53dWBzrYWedI
X-Proofpoint-GUID: qJVLtNsSOAhLxVFksJgP53dWBzrYWedI
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2302110198
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for STi platform boards and remove stih415/stih416 items.
This commit also moves the sti.yaml binding file within the arm/sti/
folder instead of arm/

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 .../devicetree/bindings/arm/sti.yaml          | 26 ---------------
 .../devicetree/bindings/arm/sti/sti.yaml      | 33 +++++++++++++++++++
 2 files changed, 33 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/sti.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/sti/sti.yaml

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
diff --git a/Documentation/devicetree/bindings/arm/sti/sti.yaml b/Documentation/devicetree/bindings/arm/sti/sti.yaml
new file mode 100644
index 000000000000..aefa1919207c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sti/sti.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/sti/sti.yaml#
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

