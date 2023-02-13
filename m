Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B602F695005
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjBMS5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBMS5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:57:10 -0500
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C531EBFB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1676314627; bh=UOvzHsi4N9M3MnVYyLztZqY513qpdpdlMZJ3Ic0lKVY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=zvTPB0peu2K83NjGGwA1qD8vCmc+Vb1n2EF8+YYLF4w4BI2UDEXFzaI+RLCPCvmZX
         UdObGjatheIGHWXy82ux2WSP8CpfmNYnc5BnBedHydlaqFAFsjqkSjVyo5vsfJhM4k
         KESn7ayehJBDUGpwV/G3ndN2xgo6+cj8oOKZ2XYBhhwpN8mQtrS+9wR/UWZcAMGYES
         ttPSyBLQvEY+6Gl3b9ceaVtr+NA/ZNNl4AhSDDFzwiFm2hwBo69A7EB1BKA80gUnDY
         O1zbjzKhZ4Pm6oewtonoCepPHsCMLoev03s4i0Tuy3IqSxMazHeyznWbbLp2huvsbb
         RJdPyMiudxYrg==
Received: from localhost (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 6875FA078F;
        Mon, 13 Feb 2023 18:57:06 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Alain Volmat <avolmat@me.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: soc: sti: add STi platform syscon
Date:   Mon, 13 Feb 2023 19:56:30 +0100
Message-Id: <20230213185633.15187-2-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230213185633.15187-1-avolmat@me.com>
References: <20230213185633.15187-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wLSgDYnYGT9fJ-ZokXxxoRyvLDmVo37V
X-Proofpoint-GUID: wLSgDYnYGT9fJ-ZokXxxoRyvLDmVo37V
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1015
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2302130166
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT schema of STi platform syscon

Signed-off-by: Alain Volmat <avolmat@me.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v3: correct subject line arm -> soc

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

