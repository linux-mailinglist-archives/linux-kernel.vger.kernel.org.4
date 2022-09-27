Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926805EB82C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiI0DAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiI0C7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:59:05 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FD3A6C13;
        Mon, 26 Sep 2022 19:56:36 -0700 (PDT)
X-UUID: 8a229ba795224c1c85734df520089a45-20220927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=EnCltdT6Z6EH/J8fbqpmMgDX4Y07nMwnORWprAExDOA=;
        b=Rhnrz91+BeB+Ryi2/BhFcSSzivY+PT0t6PwKGYL3CjA0YSJH58K1A4XZbFvqHwdLddq0OJEWquXIxuOkhdezmVRDRDp3HverVEPa178lZtQuJroZm0CrVtR1hObe3/jnsQffjjGcS1lEnXntpyqs0D8UEZp/+Rhu1hq2Ke5LMuc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:17eaf7a3-543d-4ef1-8073-4e35672d9c5b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:0c612aa3-dc04-435c-b19b-71e131a5fc35,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 8a229ba795224c1c85734df520089a45-20220927
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1343028205; Tue, 27 Sep 2022 10:56:26 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 27 Sep 2022 10:56:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 27 Sep 2022 10:56:25 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>
Subject: [PATCH v3 02/11] dt-bindings: remoteproc: mediatek: Support MT8195 dual-core SCP
Date:   Tue, 27 Sep 2022 10:55:57 +0800
Message-ID: <20220927025606.26673-3-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220927025606.26673-1-tinghan.shen@mediatek.com>
References: <20220927025606.26673-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT8195 SCP is a dual-core RISC-V MCU. Extend the yaml file
to describe the 2nd core as a subnode of the boot core.

The configuration register is shared by MT8195 SCP core 0
and core 1. The core 1 can retrieve the information of configuration
registers from parent node.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 .../bindings/remoteproc/mtk,scp.yaml          | 97 ++++++++++++++++++-
 1 file changed, 92 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
index 786bed897916..c012265be4eb 100644
--- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
@@ -75,6 +75,83 @@ properties:
     required:
       - mediatek,rpmsg-name
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^scp-c[0-9]+@[a-f0-9]+$":
+    type: object
+    description:
+      The MediaTek SCP integrated to SoC might be a multi-core version.
+      The other cores are represented as child nodes of the boot core.
+      There are some integration differences for the IP like the usage of
+      address translator for translating SoC bus addresses into address space
+      for the processor.
+
+      Each SCP core has own cache memory. The SRAM and L1TCM are shared by
+      cores. The power of cache, SRAM and L1TCM power should be enabled
+      before booting SCP cores. The size of cache, SRAM, and L1TCM are varied
+      on differnt SoCs.
+
+      The SCP cores do not use an MMU, but has a set of registers to
+      control the translations between 32-bit CPU addresses into system bus
+      addresses. Cache and memory access settings are provided through a
+      Memory Protection Unit (MPU), programmable only from the SCP.
+
+    properties:
+      compatible:
+        enum:
+          - mediatek,mt8195-scp-core
+
+      reg:
+        description: The base address and size of SRAM.
+        maxItems: 1
+
+      reg-names:
+        const: sram
+
+      interrupts:
+        maxItems: 1
+
+      firmware-name:
+        $ref: /schemas/types.yaml#/definitions/string
+        description:
+          If present, name (or relative path) of the file within the
+          firmware search path containing the firmware image used when
+          initializing sub cores of multi-core SCP.
+
+      memory-region:
+        maxItems: 1
+
+      cros-ec-rpmsg:
+        type: object
+        description:
+          This subnode represents the rpmsg device. The namesof the devices
+          are not important. The properties of this node are defined by the
+          individual bindings for the rpmsg devices.
+
+        properties:
+          mediatek,rpmsg-name:
+            $ref: /schemas/types.yaml#/definitions/string-array
+            description:
+              Contains the name for the rpmsg device. Used to match
+              the subnode to rpmsg device announced by SCP.
+
+        required:
+          - mediatek,rpmsg-name
+
+    required:
+      - compatible
+      - reg
+      - reg-names
+
+    additionalProperties: false
+
 required:
   - compatible
   - reg
@@ -110,16 +187,26 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/mt8192-clk.h>
-
     scp@10500000 {
-        compatible = "mediatek,mt8192-scp";
+        compatible = "mediatek,mt8195-scp";
         reg = <0x10500000 0x80000>,
               <0x10700000 0x8000>,
               <0x10720000 0xe0000>;
         reg-names = "sram", "cfg", "l1tcm";
-        clocks = <&infracfg CLK_INFRA_SCPSYS>;
-        clock-names = "main";
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x105a0000 0x105a0000 0x20000>;
+
+        scp-c1@105a0000 {
+                compatible = "mediatek,mt8195-scp-core";
+                reg = <0x105a0000 0x20000>;
+                reg-names = "sram";
+
+                cros-ec-rpmsg {
+                    mediatek,rpmsg-name = "cros-ec-rpmsg";
+                };
+        };
 
         cros-ec-rpmsg {
             mediatek,rpmsg-name = "cros-ec-rpmsg";
-- 
2.18.0

