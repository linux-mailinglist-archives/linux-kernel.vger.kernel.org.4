Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEE76F6952
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjEDKzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjEDKzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:55:03 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A879849F7;
        Thu,  4 May 2023 03:55:01 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344AFZoo012197;
        Thu, 4 May 2023 03:54:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=FicxFOXx/ZNXgdKgM/53wR2awYihyWEb1GhlZoo8sbc=;
 b=hhN6tTmtTheyjTEmhKakVTdZokvzt0VZXPPDmDadaSGfNHoAChi4HfnQWEjM48G1AHwY
 ngHwRnqLAGXM8mcKFNMGfA/MtZBcMTcHtcQIkZIwSqtGCZce2fqy+sgVeXaLkaVuUW3N
 L8bbqN+1jmEH6y/AIJo+6eDK+3eyLtpXXQOuyzCCnuFvcUf8mTQlnCsq3Au7nLyY+OSh
 0jlvv5EJR8Y53tXx5Ych6UZS+sQz0jW+USITwiTV9tTEFdiYUwoxzuej9iFtbqfSTBf3
 Akin1IWVIhi47IeNYFaOBK4dFCLFqx5i8/d1YNetxNCOAYvoe1wW7K76eBybEEkMoA+c 6A== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3qc0pqa24r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 03:54:46 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 4 May
 2023 03:54:44 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 4 May 2023 03:54:41 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 1/2 v6] dt-bindings: watchdog: marvell GTI system watchdog driver
Date:   Thu, 4 May 2023 16:24:38 +0530
Message-ID: <20230504105439.18261-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: TTpFRtokYI7-A1R225NJtltpHWESbfxw
X-Proofpoint-ORIG-GUID: TTpFRtokYI7-A1R225NJtltpHWESbfxw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_07,2023-05-04_01,2023-02-09_01
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
v6:
 - Added missed clocks/clock-name device tree property
 - wdt-timer-index changed to marvell,wdt-timer-index, added "type"
   and added more detail to discription

 .../bindings/watchdog/marvell,gti-wdt.yaml    | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/marvell,gti-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/marvell,gti-wdt.yaml b/Documentation/devicetree/bindings/watchdog/marvell,gti-wdt.yaml
new file mode 100644
index 000000000000..a89c0d377dae
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/marvell,gti-wdt.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/marvell,gti-wdt.yaml#
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
+    const: marvell,gti-wdt
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
+      Different platform have different number of GTI timers. For example
+      some platforms have total 64 timers and other have less than 64 timers.
+      This property will define GTI timer to be used for watchdog on given
+      platform.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - marvell,wdt-timer-index
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
+            compatible = "marvell,gti-wdt";
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

