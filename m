Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EDE748E4F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbjGETuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbjGETuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:50:13 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D79B1988;
        Wed,  5 Jul 2023 12:50:12 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365Gs6SR025924;
        Wed, 5 Jul 2023 19:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=aGYJS90h8fRFRzOi9MHpAud7Cymuch3rZ8+F5GiJGfo=;
 b=QJ+RdLbu9uSk/MrFecLLwFJiE9U2WmOQz5vvuEio6yupYV3zC/xlmo29787z4oEkjaOt
 oTtj74co6YCbO9uYvVWykeyxA3i8wfVwbGbjw+yqz/VsoOFuTdg5hnvcTYWa16tvnxEe
 HvfzJDAQlDSVDV6pjMtk+ShkqZz4DurSndtVnKV/cFi4SQl4LYBhTBlcxBWmfIJckhWi
 ExRQlWCLUajt2z6s+fkVET8h5N0b1b3/W4W9vSXJtfKjvd0Yd10EY+coGzeXNx6YKtR6
 s9RVD8a1iyZphhDMBsKc5i26ndb5hP6AM1WryfHoLMTJuW4sWdDoBMC1o0deYAiKer9t 0Q== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3rn65h49y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 19:49:44 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 31736804DED;
        Wed,  5 Jul 2023 19:49:44 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 99C8D808D9C;
        Wed,  5 Jul 2023 19:49:43 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v5 1/5] dt-bindings: gpio: Add HPE GXP GPIO
Date:   Wed,  5 Jul 2023 14:45:40 -0500
Message-Id: <20230705194544.100370-2-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230705194544.100370-1-nick.hawkins@hpe.com>
References: <20230705194544.100370-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: dtCtYME4XMneRTiXkJl3mt55IUZVRAb1
X-Proofpoint-ORIG-GUID: dtCtYME4XMneRTiXkJl3mt55IUZVRAb1
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=945 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050180
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

Provide access to the register regions and interrupt for GPIO. The
driver under the hpe,gxp-gpio-pl will provide GPIO information from the
CPLD interface. The CPLD interface represents all physical GPIOs. The
GPIO interface with the CPLD allows use of interrupts.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---

v5:
 *Removed use of gpio-gxp in favor of just supporting
  hpe,gxp-gpio-pl for now as the full gpio-gxp will
  require a much larger patchset
 *Modified commit description to reflect removal of
  hpe,gxp-gpio
v4:
 *Fix min and max values for regs
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
 .../bindings/gpio/hpe,gxp-gpio.yaml           | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml b/Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml
new file mode 100644
index 000000000000..799643c1a0c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml
@@ -0,0 +1,71 @@
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
+    const: hpe,gxp-gpio-pl
+
+  reg:
+    items:
+      - description: pl base gpio
+      - description: pl interrupt gpio
+
+  reg-names:
+    items:
+      - const: base
+      - const: interrupt
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-line-names:
+    maxItems: 80
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
+examples:
+  - |
+        gpio@51000300 {
+          compatible = "hpe,gxp-gpio-pl";
+          reg = <0x51000300 0x7f>, <0x51000380 0x20>;
+          reg-names = "base", "interrupt";
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

