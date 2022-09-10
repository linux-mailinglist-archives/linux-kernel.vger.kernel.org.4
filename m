Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA3F5B46F4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 16:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiIJOll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 10:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiIJOlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 10:41:31 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475883C8CC;
        Sat, 10 Sep 2022 07:41:21 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28ACu4iN026809;
        Sat, 10 Sep 2022 16:40:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=3hVkctFAOge+LlhitcC8Y0LYOzkX8AHV0NXbXop5Ojw=;
 b=Hh/BKTBeb/oOaOS/K/rBAJCr9EtJCY0nzoiD3rLaeimTF0jxSBojLQKs7pZlkVsqG9Ib
 GDFC8gRQxbEOMBQtyFVw2RSUR/GUZKSacO9OKPpj+f8ErSdREEknknjCbY2QsZsRSWD6
 KdceSRIYEzsgNPk4tXl5BE2z04taHgvh6JrND7s+9XdViRm4uUz/0l9C15D0hLcpnrEv
 tv8yhwNSruBT2afHUOJivt8ONSTgK9DZAGQfCowTky734p5WsuutLlNFLdLjKi3m8b8S
 CM3Bz5srtEd0tL0X5JDr0e/ev4GIw0jkJoyoM8ZZpnLLypWN0uAKloyWwJ9j94hbPlxz Og== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jgjtt1uuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Sep 2022 16:40:18 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 315BD100038;
        Sat, 10 Sep 2022 16:40:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2C18922D164;
        Sat, 10 Sep 2022 16:40:18 +0200 (CEST)
Received: from localhost (10.75.127.49) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Sat, 10 Sep
 2022 16:40:17 +0200
From:   Hugues Fruchet <hugues.fruchet@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Philippe CORNU <philippe.cornu@foss.st.com>
Subject: [PATCH v1 1/5] dt-bindings: media: add bindings for dcmipp driver
Date:   Sat, 10 Sep 2022 16:40:06 +0200
Message-ID: <20220910144010.34272-2-hugues.fruchet@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220910144010.34272-1-hugues.fruchet@foss.st.com>
References: <20220910144010.34272-1-hugues.fruchet@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-10_06,2022-09-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alain Volmat <alain.volmat@foss.st.com>

Add the yaml binding for the DCMIPP driver.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 .../bindings/media/st,stm32-dcmipp.yaml       | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/st,stm32-dcmipp.yaml

diff --git a/Documentation/devicetree/bindings/media/st,stm32-dcmipp.yaml b/Documentation/devicetree/bindings/media/st,stm32-dcmipp.yaml
new file mode 100644
index 000000000000..70631046017d
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/st,stm32-dcmipp.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/st,stm32-dcmipp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 DCMIPP Digital Camera Memory Interface Pixel Processor binding
+
+maintainers:
+  - Hugues Fruchet <hugues.fruchet@foss.st.com>
+  - Alain Volmat <alain.volmat@foss.st.com>
+
+properties:
+  compatible:
+    const: st,stm32mp13-dcmipp
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: kclk
+
+  resets:
+    maxItems: 1
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    unevaluatedProperties: false
+    description:
+      DCMIPP supports a single port node with parallel bus.
+
+    properties:
+      endpoint:
+        $ref: video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          bus-type:
+            enum: [5, 6]
+            default: 5
+
+          bus-width:
+            enum: [8, 10, 12, 14]
+            default: 8
+
+          pclk-sample: true
+          hsync-active: true
+          vsync-active: true
+
+        required:
+          - pclk-sample
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/stm32mp13-clks.h>
+    #include <dt-bindings/reset/stm32mp13-resets.h>
+    dcmipp: dcmipp@5a000000 {
+        compatible = "st,stm32mp13-dcmipp";
+        reg = <0x5a000000 0x400>;
+        interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+        resets = <&rcc DCMIPP_R>;
+        clocks = <&rcc DCMIPP_K>;
+        clock-names = "kclk";
+
+        port {
+             dcmipp_0: endpoint {
+                   remote-endpoint = <&mipid02_2>;
+                   bus-width = <8>;
+                   hsync-active = <0>;
+                   vsync-active = <0>;
+                   pclk-sample = <0>;
+                   pclk-max-frequency = <120000000>;
+             };
+        };
+    };
+
+...
-- 
2.25.1

