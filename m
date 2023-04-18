Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7DD6E6831
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjDRPcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjDRPcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:32:09 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB17B125AD;
        Tue, 18 Apr 2023 08:32:06 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I7rAQr028406;
        Tue, 18 Apr 2023 15:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=BLhWr7KA05LWTtyvACxcjFLqx/2vJ08FWT4M67w7BaQ=;
 b=VSMs/Kb6RtsDSJfpluG2R5QhgjO3aonnYWhkBvQgH2VT4qOhRVcxkppVjnfz0sXNpXVs
 jNdyQnDIcpe6GciiTNpsC/p/kJffO2fV5v5oDg7oV6ueJsQWgL3Pod+74vhXzlKYLZC4
 rV2qBCpHxZF+ZsKrFghfvmIT4MHjRRapI3+8k0DIEdgoRaVkf4VRx7UYBtsd3jSMGxOs
 sZTQVZHiQhzw2nZ457K15IRJ2WxKCgDHEXGdwyyOuUvqs99SEDMrzI+a4o2V4gRFVNy5
 h5x3JZPCb6eDPES9oRJCCL+3zP8Jj0bMPqrge7awdAUqypPbQChKCfA68148HLZKoEDx SQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3q1ca1045s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 15:31:39 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 80D9F805E92;
        Tue, 18 Apr 2023 15:31:38 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id D6D7481733A;
        Tue, 18 Apr 2023 15:31:37 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, linux@armlinux.org.uk,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 5/9] dt-bindings: gpio: Add HPE GXP GPIO
Date:   Tue, 18 Apr 2023 10:28:20 -0500
Message-Id: <20230418152824.110823-6-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230418152824.110823-1-nick.hawkins@hpe.com>
References: <20230418152824.110823-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: gwlaID5TfhXmNWG6DHkXrFURaNaViBqw
X-Proofpoint-ORIG-GUID: gwlaID5TfhXmNWG6DHkXrFURaNaViBqw
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_11,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180132
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Provide access to the registers and interrupts for GPIO. The GPIO
will have two driver instances: One for host, the other for CPLD.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 .../bindings/gpio/hpe,gxp-gpio.yaml           | 137 ++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml b/Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml
new file mode 100644
index 000000000000..1cf4cff26d5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml
@@ -0,0 +1,137 @@
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
+  Interruptable GPIO drivers for the HPE GXP that covers multiple interfaces.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - hpe,gxp-gpio
+              - hpe,gxp-gpio-pl
+
+  reg:
+    minItems: 3
+    maxItems: 6
+
+  reg-names:
+    minItems: 3
+    maxItems: 6
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  gpio-line-names:
+    minItems: 1
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
+additionalProperties: false
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
+            - description: CSM
+            - description: fn2 virtual button
+            - description: fn2 system status
+            - description: vuhc status
+            - description: external virtual button
+        reg-names:
+          items:
+            - const: csm
+            - const: fn2-vbtn
+            - const: fn2-stat
+            - const: vuhc
+            - const: vbtn
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
+            - description: Programmable logic led
+            - description: Programmable logic health led
+            - description: Programmable logic interrupt interface
+        reg-names:
+          items:
+            - const: pl-led
+            - const: pl-health
+            - const: pl-int
+
+examples:
+  - |
+        gpio@0 {
+          compatible = "hpe,gxp-gpio";
+          reg = <0x0 0x400>, <0x200046 0x1>, <0x200070 0x08>, <0x400064 0x80>, <0x5100030f 0x1>;
+          reg-names = "csm", "fn2-vbtn", "fn2-stat", "vuhc", "vbtn";
+          gpio-controller;
+          #gpio-cells = <2>;
+          interrupt-parent = <&vic0>;
+          interrupts = <10>;
+          gpio-line-names =
+          "IOP_LED1", "IOP_LED2", "IOP_LED3", "IOP_LED4", "IOP_LED5", "IOP_LED6", "IOP_LED7", "IOP_LED8",
+          "FAN1_INST", "FAN2_INST", "FAN3_INST", "FAN4_INST", "FAN5_INST", "FAN6_INST", "FAN7_INST",
+          "FAN8_INST", "FAN1_FAIL", "FAN2_FAIL", "FAN3_FAIL", "FAN4_FAIL", "FAN5_FAIL", "FAN6_FAIL",
+          "FAN7_FAIL", "FAN8_FAIL", "FAN1_ID", "FAN2_ID", "FAN3_ID", "FAN4_ID", "FAN5_ID", "FAN6_ID",
+          "FAN7_ID", "FAN8_ID", "IDENTIFY", "HEALTH_RED", "HEALTH_AMBER", "POWER_BUTTON", "UID_PRESS",
+          "SLP", "NMI_BUTTON", "RESET_BUTTON", "SIO_S5", "SO_ON_CONTROL", "PSU1_INST", "PSU2_INST",
+          "PSU3_INST", "PSU4_INST", "PSU5_INST", "PSU6_INST", "PSU7_INST", "PSU8_INST", "PSU1_AC",
+          "PSU2_AC", "PSU3_AC", "PSU4_AC", "PSU5_AC", "PSU6_AC", "PSU7_AC", "PSU8_AC", "PSU1_DC",
+          "PSU2_DC", "PSU3_DC", "PSU4_DC", "PSU5_DC", "PSU6_DC", "PSU7_DC", "PSU8_DC", "", "", "", "",
+          "", "", "", "", "", "", "", "", "", "";
+        };
+
+  - |
+        gpio@51000304 {
+          compatible = "hpe,gxp-gpio-pl";
+          reg = <0x51000304 0x2>, <0x5100030d 0x01>, <0x51000380 0x7f>;
+          reg-names = "pl-led", "pl-health", "pl-int";
+          gpio-controller;
+          #gpio-cells = <2>;
+          interrupt-parent = <&vic0>;
+          interrupts = <24>;
+          gpio-line-names =
+          "IOP_LED1", "IOP_LED2", "IOP_LED3", "IOP_LED4", "IOP_LED5", "IOP_LED6", "IOP_LED7", "IOP_LED8",
+          "FAN1_INST", "FAN2_INST", "FAN3_INST", "FAN4_INST", "FAN5_INST", "FAN6_INST", "FAN7_INST",
+          "FAN8_INST", "FAN1_FAIL", "FAN2_FAIL", "FAN3_FAIL", "FAN4_FAIL", "FAN5_FAIL", "FAN6_FAIL",
+          "FAN7_FAIL", "FAN8_FAIL", "FAN1_ID", "FAN2_ID", "FAN3_ID", "FAN4_ID", "FAN5_ID", "FAN6_ID",
+          "FAN7_ID", "FAN8_ID", "IDENTIFY", "HEALTH_RED", "HEALTH_AMBER", "POWER_BUTTON", "UID_PRESS",
+          "SLP", "NMI_BUTTON", "RESET_BUTTON", "SIO_S5", "SO_ON_CONTROL", "PSU1_INST", "PSU2_INST",
+          "PSU3_INST", "PSU4_INST", "PSU5_INST", "PSU6_INST", "PSU7_INST", "PSU8_INST", "PSU1_AC",
+          "PSU2_AC", "PSU3_AC", "PSU4_AC", "PSU5_AC", "PSU6_AC", "PSU7_AC", "PSU8_AC", "PSU1_DC",
+          "PSU2_DC", "PSU3_DC", "PSU4_DC", "PSU5_DC", "PSU6_DC", "PSU7_DC", "PSU8_DC", "", "", "", "",
+          "", "", "", "", "", "", "", "", "", "";
+        };
-- 
2.17.1

