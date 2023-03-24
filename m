Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16C46C8086
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjCXO53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjCXO5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:57:23 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E22C14B;
        Fri, 24 Mar 2023 07:57:22 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OD7YT7030567;
        Fri, 24 Mar 2023 07:57:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=PK+Rv7jXbC9ogJCpPAItVG+0CU9r1/yBY9eM/5NlpvQ=;
 b=DFSFKC6LNTNJTlU5AE7zYABanJ1ahXGTkrNWFIkeduuJg6pEnCkSYM+BAD4NfSgktXNX
 TcfaO8zhnvrKJhgXJwRIatsCnvbjRuDXRqamPCJ/Kqz6IaBLLmCHIiy0L1ngdGYcLxPH
 Gwjrs0TeBgcUYG4cmhaj3iN0pFlC3tqG19PcbEpQ2IEzFKMIwiU9ZdysaTs9ERI4zQWY
 EZsc+XQ5qFYsIBO1oEnQklhKyUekywXiifFJyBfOj+yqNRvxe8Soc89bP4Ev2q2aPkd9
 ws0CQICz0wMizEpozO7AClZfJGnvfB/0i+tf32GdZa7iK3BLSVcxmw8acZZTeb+Kguoq tg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3pgxmfjuk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 07:56:59 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Mar
 2023 07:56:57 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Fri, 24 Mar 2023 07:56:55 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 1/2] dt-bindings: watchdog: marvell octeonTX2 GTI watchdog driver
Date:   Fri, 24 Mar 2023 20:26:51 +0530
Message-ID: <20230324145652.19221-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: cPFjYVVAaM0Mh7ztn062RuEWeK0tBSZq
X-Proofpoint-ORIG-GUID: cPFjYVVAaM0Mh7ztn062RuEWeK0tBSZq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_08,2023-03-24_01,2023-02-09_01
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the Marvell octeonTX2
GTI watchdog driver.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 .../watchdog/marvel-octeontx2-wdt.yaml        | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/marvel-octeontx2-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/marvel-octeontx2-wdt.yaml b/Documentation/devicetree/bindings/watchdog/marvel-octeontx2-wdt.yaml
new file mode 100644
index 000000000000..586b3c1bd780
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/marvel-octeontx2-wdt.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/marvel-octeontx2-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell OcteonTX2 GTI watchdog
+
+allOf:
+  - $ref: "watchdog.yaml#"
+
+maintainers:
+  - Bharat Bhushan <bbhushan2@marvell.com>
+
+properties:
+  compatible:
+    enum:
+      - mrvl,octeontx2-gti-wdt
+
+  reg:
+    maxItems: 2
+
+  interrupts:
+    minItems: 1
+    maxItems: 36
+
+required:
+ - compatible
+ - reg
+ - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    watch-dog@802000040000 {
+      compatible = "mrvl,octeontx2-gti-wdt";
+      reg = <0x8020 0x40000 0x0 0x20000>;
+      interrupts = <0 38 1>, /* Core-0 */
+                   <0 39 1>; /* Core-1 */
+    };
+
+...
-- 
2.17.1

