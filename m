Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90CF6933ED
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 22:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBKVID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 16:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBKVIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 16:08:02 -0500
Received: from mr85p00im-zteg06022001.me.com (mr85p00im-zteg06022001.me.com [17.58.23.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D85113DD3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 13:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1676149680; bh=9x3CgbNoPA8aqfgz5tPm3lX+iFzbdCA3ovOiWwCxmhw=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=a7hhW8rbGThq5bVUwQbly0r9/NhX5yb72Y4LCRPrHEU3yT+DX3Ijyfq65qmg6hXDZ
         vBSrCxt0CSIP303ksCZgt4UJhY2qiB3X1JZK3XkVbv4b3pvx8OOPcg1VrvA6rxA6zN
         PBI1FZb20Pgsw9+RDU+jZ7MOl+8SoUZ/y5MMMpa8sBBUTiytPaOnVManCdbLOTi1iy
         pn9dEcjtoeVDYDNO3MxmlsUPiZp8eBkYILn4CVPkY4ow6zjbtKNZKQVgAT3YGMFJMB
         Hmd8++PmNDDQoYVD4wzTCKsESmiEfQzoeyyiaBvFCXekP8l2Ppvvo9hvaiyyEtfAis
         QpqUnqhFNiZpQ==
Received: from localhost (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-zteg06022001.me.com (Postfix) with ESMTPSA id 26DB08006B5;
        Sat, 11 Feb 2023 21:08:00 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Alain Volmat <avolmat@me.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: sti: addition of STi platform syscon
Date:   Sat, 11 Feb 2023 22:04:58 +0100
Message-Id: <20230211210500.9919-1-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: EWEM7v_9xGo6ASDPDSahk_gQN2sYBIF8
X-Proofpoint-GUID: EWEM7v_9xGo6ASDPDSahk_gQN2sYBIF8
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.816,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-18=5F01:2022-01-14=5F01,2022-01-18=5F01,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2302110197
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addition of the various STi platform syscon node description.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 .../bindings/arm/sti/st,sti-syscon.yaml       | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sti/st,sti-syscon.yaml

diff --git a/Documentation/devicetree/bindings/arm/sti/st,sti-syscon.yaml b/Documentation/devicetree/bindings/arm/sti/st,sti-syscon.yaml
new file mode 100644
index 000000000000..e4bbc90694b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sti/st,sti-syscon.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/sti/st,sti-syscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STi platform sysconfig entries
+
+maintainers:
+  - Patrice Chotard <patrice.chotard@foss.st.com>
+
+description: |
+  Binding for the various sysconfig nodes used within the STi
+  platform device-tree to point to some common configuration
+  registers used by other nodes.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - st,stih407-sbc-syscfg
+          - st,stih407-front-syscfg
+          - st,stih407-rear-syscfg
+          - st,stih407-flash-syscfg
+          - st,stih407-sbc-reg-syscfg
+          - st,stih407-core-syscfg
+          - st,stih407-lpm-syscfg
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
+    syscfg_sbc: sbc-syscfg@9620000 {
+        compatible = "st,stih407-sbc-syscfg", "syscon";
+        reg = <0x9620000 0x1000>;
+    };
+
+...
-- 
2.34.1

