Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A975B80FE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiINFbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiINFbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:31:23 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1236F55A;
        Tue, 13 Sep 2022 22:31:09 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 337475C00C1;
        Wed, 14 Sep 2022 01:31:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 14 Sep 2022 01:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1663133469; x=
        1663219869; bh=/oX6YkFh6Fla3S1U+ImlVkebmSqE9u/RwHU2MLtNHWQ=; b=C
        9bnyTooKuyM32PqzvT8E+Q+R6UXLJN4qB+tcwohBtpItPakS7KPZiqTZoc1chdrD
        F6/YXlZx2TdiGg+CvawWW1BktGN3KWEA9PJMpnZKTE85UO+hRUzLHp5MhBo9Arx6
        RyxKv+S/BZoKbSOdrbkzofPYnfryJnMzWnzk8j2td3TzCcwdjq91Y7ss56iwx89d
        hk1zR6oc63zEAEBHlWUBDNJVjBzWxW5kSqu+T3SZGxaClA6rBcO3c4Z3BJn5G+qg
        uR61DJ7MuG09a+ilTzLbVQSD3Lo1glbH8pCcBrhG4Cf16TNVjNP5SJzIdiUvcbE+
        z3rFgfx9sfybRqyukFd2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1663133469; x=1663219869; bh=/oX6YkFh6Fla3
        S1U+ImlVkebmSqE9u/RwHU2MLtNHWQ=; b=PQ23vNMLYtMjUtCbWM2LAaLWvjRgW
        cuwgDJLWnKIvNKa+leeadIiL/mjufNuv5dsh8cnbLcH+H4jCgDui41VFVR5j6bNA
        pZR8j1o+vdB0oB7jyRNgi+w8o7OHmddI08iHCiqIu7fXHEz21F0Bq+SjN1816JkY
        aE066j6TFg7m4r85h0w/6ftsXIQKFKs9LUf1MCEJcU4v4XhDMFsvwSWJJhQ2htvN
        FnVTtvJGx6uU6yo181Ed/SxLOdRzGs8St5yAiup4eTXDn0ylu2q57K7QENipf3kb
        g14RGbwZ7e03YkCPa4Qr0aPdCpOYJSfQIozc1ZL7JyZ3dJjlERBNQBOgQ==
X-ME-Sender: <xms:HWchY7a8gFRPosjCvhC15pt64eMYDsDYxk0m_t7HXw1bE15PAlkdCg>
    <xme:HWchY6b5GbjIBulYbMQCm85Xqd2EfB5roHH6gFzgQcNBRPlKcXw4TRt2pADjnl-Wx
    ArO7_r9wmhGiU9xDbE>
X-ME-Received: <xmr:HWchY9_HwsnUOzvxB8mSQgQhZDEuQiQjI7mbkz84K3tP1DRp3hNSQEQpU0s2bciziytpTRC7KwBRKiAjm94CP8pmP_2rzmM8LUyf7AX_iCvgecmh4kIP23gUd8_qMIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeduhedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeforghthhgvficuofgtuehrihguvgcuoehmrghtthesthhr
    rghvvghrshgvrdgtohhmrdgruheqnecuggftrfgrthhtvghrnheptdetueejffeikeelve
    ehvdekkefgfeevjeeiffeutdfffeejhfegteehgeefuddvnecuffhomhgrihhnpeguvghv
    ihgtvghtrhgvvgdrohhrghdpmhhitghrohgthhhiphdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghtthesthhrrghvvghrshgv
    rdgtohhmrdgruh
X-ME-Proxy: <xmx:HWchYxrg-M8N-2Hhy6r0LDGBK7ykMMCS1NNN6tHBfct-ep__Kj4wLw>
    <xmx:HWchY2qLioZ4-w-pe2_JKzshf3YKoMdajpuOjy5YhJJGWU-pldzT7g>
    <xmx:HWchY3Q03bSkQktozdbU6sJaHAvFnoxtef8-aZCXcTc93C7dhQbtCw>
    <xmx:HWchYydmvyiWEr2FI2IjfhZ4rW9y0LIHaBXEX6vgl2zTrrg8a_jrQQ>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Sep 2022 01:31:06 -0400 (EDT)
From:   Mathew McBride <matt@traverse.com.au>
To:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mathew McBride <matt@traverse.com.au>
Subject: [PATCH 2/3] dt-bindings: add binding for Microchip EMC230X fan controller family
Date:   Wed, 14 Sep 2022 05:30:29 +0000
Message-Id: <20220914053030.8929-3-matt@traverse.com.au>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20220914053030.8929-1-matt@traverse.com.au>
References: <20220914053030.8929-1-matt@traverse.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the Microchip EMC230X fan controller family,
which is supported by the new "emc230x" hwmon driver.

Signed-off-by: Mathew McBride <matt@traverse.com.au>
---
 .../bindings/hwmon/microchip,emc2301.yaml     | 83 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,emc2301.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/microchip,emc2301.yaml b/Documentation/devicetree/bindings/hwmon/microchip,emc2301.yaml
new file mode 100644
index 000000000000..1e5c7072caee
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/microchip,emc2301.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/microchip,emc2301.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip EMC230X family RPM fan controller
+
+maintainers:
+  - Mathew McBride <matt@traverse.com.au>
+
+description: |
+  The Microchip EMC230X family (formerly produced by SMSC) is a family
+  of fan controllers which can drive via a set PWM period or
+  to a target RPM speed. They are available in variants from 1 to 5
+  independent channels.
+
+  Product information:
+  https://www.microchip.com/en-us/product/EMC2301
+  https://www.microchip.com/en-us/product/EMC2302
+  https://www.microchip.com/en-us/product/EMC2303
+  https://www.microchip.com/en-us/product/EMC2305
+
+
+properties:
+  compatible:
+    enum:
+      - microchip,emc2301
+      - microchip,emc2302
+      - microchip,emc2303
+      - microchip,emc2305
+  reg:
+    maxItems: 1
+
+  "#address-cells": true
+
+  "#size-cells": true
+
+required:
+  - compatible
+  - reg
+
+patternProperties:
+  "fan@[0-9]+$":
+    type: object
+    description: Fan channel properties for use as a thermal cooling device
+
+    properties:
+      min-rpm:
+        description: Minimum fan RPM when used as a cooling device
+        maxItems: 1
+      max-rpm:
+        description: Maximum fan RPM when used as a cooling device
+        maxItems: 1
+      reg:
+        description: Channel number on EMC230X device the fan is attached to
+        maxItems: 1
+      "#cooling-cells":
+        const: 2
+    required:
+      - reg
+      - min-rpm
+      - max-rpm
+      - "#cooling-cells"
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        fanctrl@2f {
+            compatible = "microchip,emc2301";
+            reg = <0x2f>;
+
+            fan@0 {
+              min-rpm = /bits/ 16 <3500>;
+              max-rpm = /bits/ 16 <5000>;
+              reg = <0>;
+            }
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index bf3c6c3c0492..5938780abe20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8046,6 +8046,7 @@ MICROCHIP EMC230X PWM-FAN CONTROLLER DRIVERS
 M:	Mathew McBride <matt@traverse.com.au>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/hwmon/microchip,emc2301.yaml
 F:	drivers/hwmon/emc230x.c
 
 MICROCHIP POLARFIRE FPGA DRIVERS
-- 
2.30.1

