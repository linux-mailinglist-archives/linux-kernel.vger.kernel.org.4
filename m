Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5396A721D45
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 07:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjFEFAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 01:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjFEFAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 01:00:17 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DC7B1;
        Sun,  4 Jun 2023 22:00:16 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3551cJYW025863;
        Sun, 4 Jun 2023 21:59:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=t8IR/PBgm/TtVxBaYzcJPaQ8CTjiQq7/WOcLc4dJyJs=;
 b=b0WOlqBHeKlpZIDzYmA/a/P9aQqOBWlW0xUuekIgSasnX8/2HCCeCl93RtFy5uxrRDTz
 VO6Pv+Xen5C7/RyH9UEpxuNQmuaT0fETjHOv1tghOn8wT/r97XI1qr7gofpg8h7DtPaL
 fmpjO7FjqutEFnI9oqNl2ReAhzoEN/gueVw+TZ54NsRop3xTpTRu9RFiVlCg9N4X+h/P
 C+Kv3OFzFLLqkBrlbe1has/FqngENM4zPiDd3L8+hKP9lM7cP5NfdG/3cOVc724ENA20
 3mn+YHQiTi7bOr3rT0cmbJqoKUVYrffaYda4OOXvhc+35P3tGFv9y94UxBSrmVd4gmow /w== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3r051k3uac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 04 Jun 2023 21:59:52 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 4 Jun
 2023 21:59:50 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 4 Jun 2023 21:59:47 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 1/2 v9] dt-bindings: watchdog: marvell GTI system watchdog driver
Date:   Mon, 5 Jun 2023 10:29:44 +0530
Message-ID: <20230605045945.26262-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: ILvTsXDj84QXdJ-n3B__ySQetkt7E3zU
X-Proofpoint-ORIG-GUID: ILvTsXDj84QXdJ-n3B__ySQetkt7E3zU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
v9:
 - Rename binding file name from marvell,octeontx2-wdt.yaml to
   marvell,cn10624-wdt.yaml
 - "allOf: - $ref: watchdog.yaml#" moved after maintainers
 - clocks have maxItems rather than minItems
 - Added "clock-names" name defination
 - Added Fallback to compatible

v8:
  - Compatible name as per soc name

 .../watchdog/marvell,cn10624-wdt.yaml         | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/marvell,cn10624-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/marvell,cn10624-wdt.yaml b/Documentation/devicetree/bindings/watchdog/marvell,cn10624-wdt.yaml
new file mode 100644
index 000000000000..1b583f232e53
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/marvell,cn10624-wdt.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/marvell,cn10624-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Global Timer (GTI) system watchdog
+
+maintainers:
+  - Bharat Bhushan <bbhushan2@marvell.com>
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - marvell,cn9670-wdt
+          - marvell,cn10624-wdt
+
+      - items:
+          - enum:
+              - marvell,cn9880-wdt
+              - marvell,cnf9535-wdt
+          - const: marvell,cn9670-wdt
+
+      - items:
+          - enum:
+              - marvell,cn10308-wdt
+              - marvell,cnf10518-wdt
+          - const: marvell,cn10624-wdt
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
+      - const: refclk
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
+            compatible = "marvell,cn9670-wdt";
+            reg = <0x00008020 0x00040000 0x00000000 0x00020000>;
+            interrupts = <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>;
+            clocks = <&sclk>;
+            clock-names = "refclk";
+            marvell,wdt-timer-index = <63>;
+        };
+    };
+
+...
-- 
2.17.1

