Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6000D693A10
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 21:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBLU4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 15:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBLU4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 15:56:33 -0500
X-Greylist: delayed 313 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Feb 2023 12:56:32 PST
Received: from st43p00im-ztfb10061701.me.com (st43p00im-ztfb10061701.me.com [17.58.63.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FE0F75E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 12:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1676235082; bh=2cJAWB/7Hi9YuRLupffkQdyTGuHN5QxKkQbV6A+JkRs=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=R/gJyNSL5R5ROg8O/RHydged4LhOK1puMb85uQv2TjRqYhnkS10lfO+l0Wr7UWQWX
         ALiymgqbMGhdurogK63SLmM+I1MHDtbpEa96ziu+y0mDdiLR4Mss6uvMmGwQr+lXNR
         jLxF+4k3tZfc8ObdugHa5mRDLD7yQRcIUqD7ZocwdH/iv9tWdTavQeWlKAOQQOEyA6
         KENMlc1BrEVzCPxIiWUArAUg3gB0EboZACtILNUu6JXyHmWRzR+keckuDFjuBJ0e3q
         CO0kEZQm9wE5yCBlxMhkBNtwM1sDzRjeK5x+BQBcnLYv0Hsviyw6b8GvNgpBFYsMRs
         f/nC6LwW8H7eg==
Received: from localhost (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-ztfb10061701.me.com (Postfix) with ESMTPSA id 6DE922E0325;
        Sun, 12 Feb 2023 20:51:21 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Alain Volmat <avolmat@me.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: sti: add STi platform syscon
Date:   Sun, 12 Feb 2023 21:51:06 +0100
Message-Id: <20230212205107.8073-2-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230212205107.8073-1-avolmat@me.com>
References: <20230212205107.8073-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AQLAym5I_tnGk3-vc5eM_UNaGwNocej8
X-Proofpoint-GUID: AQLAym5I_tnGk3-vc5eM_UNaGwNocej8
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2020-02-14=5F02,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1015 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Add DT schema of STi platform syscon

Signed-off-by: Alain Volmat <avolmat@me.com>
---
v2: update wording of commit log
    reorder compatible enum
    update example within the binding file

 .../bindings/soc/sti/st,sti-syscon.yaml       | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sti/st,sti-syscon.yaml

diff --git a/Documentation/devicetree/bindings/soc/sti/st,sti-syscon.yaml b/Documentation/devicetree/bindings/soc/sti/st,sti-syscon.yaml
new file mode 100644
index 000000000000..5f97d9ff17fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/sti/st,sti-syscon.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/sti/st,sti-syscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STi platform sysconfig
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
+          - st,stih407-core-syscfg
+          - st,stih407-flash-syscfg
+          - st,stih407-front-syscfg
+          - st,stih407-lpm-syscfg
+          - st,stih407-rear-syscfg
+          - st,stih407-sbc-reg-syscfg
+          - st,stih407-sbc-syscfg
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
+    syscfg_sbc: syscon@9620000 {
+        compatible = "st,stih407-sbc-syscfg", "syscon";
+        reg = <0x9620000 0x1000>;
+    };
+
+...
-- 
2.34.1

