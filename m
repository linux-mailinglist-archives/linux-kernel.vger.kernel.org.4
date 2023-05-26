Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213A4711FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 08:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242191AbjEZG11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 02:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242120AbjEZG1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 02:27:18 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574CFE52;
        Thu, 25 May 2023 23:27:10 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q5JvWl010602;
        Thu, 25 May 2023 23:26:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=9UW+ZnkHmP8dUcTogw3ahWZ4RFUlooQUoG3ikr5H4nE=;
 b=d2e2hernKg2vho0lOcHMRPcfWExb1duXSmrrg2Tg8coTz9u5Q1azMBhy6UEcfu0RSDLN
 xnrdF2XWEq1ZDYfeXges5RuNShQ76uHGrp1EW/++ZNhbX1qkyj1nEB7gw79EBGmMCE24
 577oaVodcSik+FHPLIcmtS0e+OGTDxnLu7Bc4PNbH7rhNXHPn57UgaDcTA8rz0lqQk83
 oluWgE7NDimRw0YIM2xX2XAuLvnVbMafUvG9RkteAWHJ05HT9m/EGWraLxJ8kmfYjxHQ
 ifgd9GMGWPzAJq/+/qntRpf/4pSkGrs5HYRlaTbMAUymUySQ7RfALnMmYElA00jyONr9 mw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3qsspt5tt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 23:26:47 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 25 May
 2023 23:26:45 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 25 May 2023 23:26:28 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 1/2 v8] dt-bindings: watchdog: marvell GTI system watchdog driver
Date:   Fri, 26 May 2023 11:56:25 +0530
Message-ID: <20230526062626.1180-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: oxCbWKImkbwYb-x4g_QRmwbYl0gOLdeV
X-Proofpoint-ORIG-GUID: oxCbWKImkbwYb-x4g_QRmwbYl0gOLdeV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the Marvell GTI system
watchdog driver.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v8:
  - Compatible name as per soc name

 .../watchdog/marvell,octeontx2-wdt.yaml       | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/marvell,octeontx2-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/marvell,octeontx2-wdt.yaml b/Documentation/devicetree/bindings/watchdog/marvell,octeontx2-wdt.yaml
new file mode 100644
index 000000000000..3c642359d960
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/marvell,octeontx2-wdt.yaml
@@ -0,0 +1,73 @@
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
+    enum:
+      - marvell,cn9670-wdt
+      - marvell,cn9880-wdt
+      - marvell,cnf9535-wdt
+      - marvell,cn10624-wdt
+      - marvell,cn10308-wdt
+      - marvell,cnf10518-wdt
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
+            compatible = "marvell,cn9670-wdt";
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

