Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2D67234C1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 03:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjFFBrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 21:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbjFFBrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 21:47:02 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F82114;
        Mon,  5 Jun 2023 18:46:51 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355K9Jli026477;
        Tue, 6 Jun 2023 01:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=YEfPqaW0UkI1VSf95bOstxqBKMb2nqvOcPz3cdg+gBI=;
 b=ViiBKBv2CkR1XVV3V6EkidwkuoeyxQSkBnTVqEUVSXQCAtr1PMYwumSYXI7YTQ4RK/4O
 P+zTcS86Kg8ITCEPqy4NarEK/owf/D4ZeUIOgvOqwvsb1/hWOtB0aU5UiNso6E9PTIqT
 WV/g0oZepwMLUoFvLm8cs2WApbQklodtOY3C3qwuzXOwrko2y/znnFLien4TH8PNCKd7
 NgJCBvF4sWiuIWjPtEyFpp3NdXVON8E2uqQyY7sjqYhX7vIP7b7rNx3/BfGXuPgdXzyK
 K6mjfA/u9Ts76EfhmO+7sBjVrkW0BRatjHOID/Cjz5AYbazTT0G/6qxPjDR77j64fZab pw== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3r1fykn6d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 01:46:32 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 16665804DC1;
        Tue,  6 Jun 2023 01:46:31 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 5817E80A276;
        Tue,  6 Jun 2023 01:46:30 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v3 1/5] dt-bindings: gpio: Add HPE GXP GPIO
Date:   Mon,  5 Jun 2023 20:42:30 -0500
Message-Id: <20230606014234.29491-2-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230606014234.29491-1-nick.hawkins@hpe.com>
References: <20230606014234.29491-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: PMXf8UF7D2q2Z1H7lsDrwW9M6eK4lmZc
X-Proofpoint-ORIG-GUID: PMXf8UF7D2q2Z1H7lsDrwW9M6eK4lmZc
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_35,2023-06-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 bulkscore=0 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060014
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Provide access to the register regions and interrupt for GPIO. There
will be two drivers available. The first driver under the hpe,gxp-gpio
binding will provide GPIO information for the VUHC, CSM, and FN2
host interfaces. The second driver under the hpe,gxp-gpio-pl will
provide GPIO information from the CPLD interface. The main difference
and need for two separate bindings is they have different interrupt
parents. The other is hpe,gxp-gpio is a combination of physical
and virtual GPIOs where as hpe,gxp-gpio-pl are all physical
GPIOs from the CPLD.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---

v3:
 *Remove extra example in examples
 *Actually fixed indentation on example - Aligned
  GPIO line names with " above.
v2:
 *Put binding patch before the driver in the series
 *Improved patch description
 *Removed oneOf and items in compatible definition
 *Moved additionalProperties definition to correct spot in file
 *Fixed indentation on example
 *Improved description in .yaml
---
 .../bindings/gpio/hpe,gxp-gpio.yaml           | 139 ++++++++++++++++++
 1 file changed, 139 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml b/Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml
new file mode 100644
index 000000000000..72cfff4d3e26
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml
@@ -0,0 +1,139 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/hpe,gxp-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HPE GXP gpio controllers
+
+maintainers:
+  - Nick Hawkins <nick.hawkins@hpe.com>
+
+description:
+  Interruptable GPIO drivers for the HPE GXP that covers multiple interfaces
+  of both physical and virtual GPIO pins.
+
+properties:
+  compatible:
+    enum:
+      - hpe,gxp-gpio
+      - hpe,gxp-gpio-pl
+
+  reg:
+    minItems: 2
+    maxItems: 6
+
+  reg-names:
+    minItems: 2
+    maxItems: 6
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-line-names:
+    minItems: 80
+    maxItems: 300
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - gpio-controller
+  - "#gpio-cells"
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - hpe,gxp-gpio
+    then:
+      properties:
+        reg:
+          items:
+            - description: CSM GPIO interface
+            - description: fn2 virtual button GPIO
+            - description: fn2 system status GPIO
+            - description: vuhc GPIO status interface
+        reg-names:
+          items:
+            - const: csm
+            - const: fn2-vbtn
+            - const: fn2-stat
+            - const: vuhc
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - hpe,gxp-gpio-pl
+    then:
+      properties:
+        reg:
+          items:
+            - description: Programmable logic device GPIO
+            - description: Programmable logic device interrupt GPIO
+        reg-names:
+          items:
+            - const: base
+            - const: interrupt
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio@0 {
+        compatible = "hpe,gxp-gpio";
+        reg = <0x0 0x400>, <0x200046 0x1>, <0x200070 0x08>, <0x400064 0x80>;
+        reg-names = "csm", "fn2-vbtn", "fn2-stat", "vuhc";
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-parent = <&vic0>;
+        interrupts = <10>;
+        gpio-line-names = "IOP_LED1", "IOP_LED2",
+                          "IOP_LED3", "IOP_LED4",
+                          "IOP_LED5", "IOP_LED6",
+                          "IOP_LED7", "IOP_LED8",
+                          "FAN1_INST", "FAN2_INST",
+                          "FAN3_INST", "FAN4_INST",
+                          "FAN5_INST", "FAN6_INST",
+                          "FAN7_INST", "FAN8_INST",
+                          "FAN1_FAIL", "FAN2_FAIL",
+                          "FAN3_FAIL", "FAN4_FAIL",
+                          "FAN5_FAIL", "FAN6_FAIL",
+                          "FAN7_FAIL", "FAN8_FAIL",
+                          "FAN1_ID", "FAN2_ID",
+                          "FAN3_ID", "FAN4_ID",
+                          "FAN5_ID", "FAN6_ID",
+                          "FAN7_ID", "FAN8_ID",
+                          "IDENTIFY", "HEALTH_RED",
+                          "HEALTH_AMBER", "POWER_BUTTON",
+                          "UID_PRESS", "SLP",
+                          "NMI_BUTTON", "RESET_BUTTON",
+                          "SIO_S5", "SO_ON_CONTROL",
+                          "PSU1_INST", "PSU2_INST",
+                          "PSU3_INST", "PSU4_INST",
+                          "PSU5_INST", "PSU6_INST",
+                          "PSU7_INST", "PSU8_INST",
+                          "PSU1_AC", "PSU2_AC",
+                          "PSU3_AC", "PSU4_AC",
+                          "PSU5_AC", "PSU6_AC",
+                          "PSU7_AC", "PSU8_AC",
+                          "PSU1_DC", "PSU2_DC",
+                          "PSU3_DC", "PSU4_DC",
+                          "PSU5_DC", "PSU6_DC",
+                          "PSU7_DC", "PSU8_DC",
+                          "", "",
+                          "", "",
+                          "", "",
+                          "", "",
+                          "", "",
+                          "", "",
+                          "", "";
+    };
-- 
2.17.1

