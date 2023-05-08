Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A0A6FB11A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbjEHNPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjEHNPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:15:46 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE75E1FF3;
        Mon,  8 May 2023 06:15:44 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348ALCbL005046;
        Mon, 8 May 2023 06:15:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=4Zlo/L0M62JZxczZsEpVPWY4qR2dG1EXifRG3pfRiO8=;
 b=fZ/lnyoeaXWP1ugXnQThbg+PmP32ifA1oQe4d0es0+Kq+Vqn5s9UEjG8cDCX7eHgp3Wl
 986ckGit9jwAn/ILYupxzlxjF9l/FoZ5uOWURMdmCBZCRXCB5bnXuf8DZgcNbrtrI3+o
 ynfFe5rL8FHMJnN3V2rqGBiP88jEBUsLXluiJZAi+6RL3U44z7L8c9ho+dXpjDFFNDF7
 fT7FC7d52j0l98PBjZ6FqWrAB+8RWo27IH97+uwlJVpEMnFwMLjtDd2ABV/BCIvcea/d
 TLHEsJdWqim956zyV345evS9q1XFRmWCJLUtGmAQmfICBSMeNGhkCvENn/PPilr36q18 zw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3qeuyxh93t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 06:15:22 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 8 May
 2023 06:15:21 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 8 May 2023 06:15:18 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 1/2 v7] dt-bindings: watchdog: marvell GTI system watchdog driver
Date:   Mon, 8 May 2023 18:45:14 +0530
Message-ID: <20230508131515.19403-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: EUg2N4_W8YYNpjapsfpR4tTE2uGueT1a
X-Proofpoint-ORIG-GUID: EUg2N4_W8YYNpjapsfpR4tTE2uGueT1a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_09,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the Marvell GTI system
watchdog driver.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v7:
 - Corrected compatible to have soc name
 - Converted marvell,wdt-timer-index to optional

 .../watchdog/marvell,octeontx2-wdt.yaml       | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/marvell,octeontx2-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/marvell,octeontx2-wdt.yaml b/Documentation/devicetree/bindings/watchdog/marvell,octeontx2-wdt.yaml
new file mode 100644
index 000000000000..72951b10f1f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/marvell,octeontx2-wdt.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/marvell,octeontx2-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Global Timer (GTI) system watchdog
+
+allOf:
+  - $ref: watchdog.yaml#
+
+maintainers:
+  - Bharat Bhushan <bbhushan2@marvell.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: marvell,octeontx2-wdt
+      - items:
+          - enum:
+              - marvell,octeontx2-95xx-wdt
+              - marvell,octeontx2-96xx-wdt
+              - marvell,octeontx2-98xx-wdt
+          - const: marvell,octeontx2-wdt
+      - const: marvell,cn10k-wdt
+      - items:
+          - enum:
+              - marvell,cn10kx-wdt
+              - marvell,cnf10kx-wdt
+          - const: marvell,cn10k-wdt
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+
+  clock-names:
+    minItems: 1
+
+  marvell,wdt-timer-index:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 63
+    description:
+      An SoC have many timers (up to 64), firmware can reserve one or more timer
+      for some other use case and configures one of the global timer as watchdog
+      timer. Firmware will update this field with the timer number configured
+      as watchdog timer.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        watchdog@802000040000 {
+            compatible = "marvell,octeontx2-wdt";
+            reg = <0x00008020 0x00040000 0x00000000 0x00020000>;
+            interrupts = <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>;
+            clocks = <&sclk>;
+            clock-names = "ref_clk";
+            marvell,wdt-timer-index = <63>;
+        };
+    };
+
+...
-- 
2.17.1

