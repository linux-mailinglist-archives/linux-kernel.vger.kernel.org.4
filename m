Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D1970D8AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbjEWJPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbjEWJPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:15:09 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFC3185;
        Tue, 23 May 2023 02:14:40 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N93S0K031499;
        Tue, 23 May 2023 11:14:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=21YBn0N8+x8QGAqVLFfwgztlVeH2AvX3vZpEDO9WkLw=;
 b=Z72laeQROTpJ76DnrGB34vNSkf+8rWa9KRXO4awbG7MspeOZlgenGAe1CSHuJZ1Zj6Kj
 I1mmC7RSljAyJzTgsbGbewcOXwm4BfDXAt/9I5Hdeuw7LjvMU7wF2T1Z1Arv9AH3Qp2N
 x9shXiAszaZy35LIzi+YRgzK2PGqh8rbLlfF329+A1fHbEZ2TQq5ZHJbvVFCdZbP88LA
 7knI6lbDq+s8VZVhtcZd9kOaH1ubyML/seu2xozacRXLXpiiokHlcVGB3CORQ3Rr+YBH
 kHpUZMfq3KtwOpKr5sdzFh4IeoupivuTy16eixqgYJ0IA3dfiN9GZkAtv0dpq/LXcMAm FA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qrtgur5jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 11:14:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F390A100034;
        Tue, 23 May 2023 11:14:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ED43F222CB8;
        Tue, 23 May 2023 11:14:18 +0200 (CEST)
Received: from localhost (10.252.31.43) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 23 May
 2023 11:14:16 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: [RFC PATCH 3/4] dt-bindings: remoteproc: add compatibility for TEE support
Date:   Tue, 23 May 2023 11:13:49 +0200
Message-ID: <20230523091350.292221-4-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230523091350.292221-1-arnaud.pouliquen@foss.st.com>
References: <20230523091350.292221-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.31.43]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_06,2023-05-22_03,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework compatibility description according to the support of
the authenticated firmware relying on OP-TEE authentication.

The expected behavior is:
- with legacy compatible "st,stm32mp1-m4" the Linux kernel loads a
  non-signed (ELF) firmware image,
- with compatible "st,stm32mp1-m4-tee" the Linux kernel load a signed
  firmware image. In this case it calls TEE services to manage the firmware
  loading and the remoteproc life-cycle.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 .../bindings/remoteproc/st,stm32-rproc.yaml   | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
index 959a56f1b6c7..1671a90d5974 100644
--- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
@@ -16,7 +16,12 @@ maintainers:
 
 properties:
   compatible:
-    const: st,stm32mp1-m4
+    enum:
+      - st,stm32mp1-m4
+      - st,stm32mp1-m4-tee
+    description:
+      Use "st,stm32mp1-m4" for the Cortex-M4 coprocessor management by Linux
+      Use "st,stm32mp1-m4-tee" for the Cortex-M4 coprocessor management by OPTEE
 
   reg:
     description:
@@ -135,8 +140,28 @@ required:
   - compatible
   - reg
   - resets
-  - st,syscfg-holdboot
-  - st,syscfg-tz
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - st,stm32mp1-m4
+    then:
+      required:
+        - memory-region
+        - st,syscfg-holdboot
+        - st,syscfg-tz
+        - resets
+  - if:
+      properties:
+        compatible:
+          enum:
+            - st,stm32mp1-m4-tee
+    then:
+      required:
+        - memory-region
+
 
 additionalProperties: false
 
@@ -148,6 +173,8 @@ examples:
       reg = <0x10000000 0x40000>,
             <0x30000000 0x40000>,
             <0x38000000 0x10000>;
+      memory-region = <&retram>, <&mcuram>, <&mcuram2>, <&vdev0vring0>,
+                      <&m_ipc_shm>, <&vdev0vring1>, <&vdev0buffer>;
       resets = <&rcc MCU_R>;
       st,syscfg-holdboot = <&rcc 0x10C 0x1>;
       st,syscfg-tz = <&rcc 0x000 0x1>;
-- 
2.25.1

