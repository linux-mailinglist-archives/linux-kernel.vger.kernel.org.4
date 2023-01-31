Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE48682E60
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjAaNts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjAaNto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:49:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F874DBEA;
        Tue, 31 Jan 2023 05:49:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CC1EB81CD8;
        Tue, 31 Jan 2023 13:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7415C433EF;
        Tue, 31 Jan 2023 13:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675172980;
        bh=7uS99guVEB4XU7LjGkPqNw0LUaTw0sbs4tjMoJ9K564=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=J7a8fZSUs+lYf7LZMmzS7MATftH5bDlUCXYiECSixOaqU0b9AvY+pxzTcMUfnKIkH
         4YY/2PBV5lSOY2Glx3xPRLFjLwz+hup2gXXRFsyrduoxqigHVuG1ltV7DB5fhX0v4B
         w6Mc6agHugLUXU/zfs6zrd/DxZwB0QDHRSe9M3TAKm8RZjdY4xsuyedZMjofzkToYx
         nvj7ww2Mv9pPF80wUDofgDQaq6OFniPGE/k9l+zZR19X6ArIuS7QLTH8SgHrCZrGjC
         AP3px/o7EIjrdapKJ29a4kw6d3+QtFiQbsBaIwCBtFj1n28uhJ9QBRvlH3qQlyaCgQ
         SKI8PQcI7fO3Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id B7E7CC636D7;
        Tue, 31 Jan 2023 13:49:40 +0000 (UTC)
From:   Niall Leonard via B4 Submission Endpoint 
        <devnull+nl250060.ncr.com@kernel.org>
Date:   Tue, 31 Jan 2023 13:49:37 +0000
Subject: [PATCH v2 1/2] dt-bindings: improve wb,mbl-gpio binding
 documentation.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230126-gpio-mmio-fix-v2-1-38397aace340@ncr.com>
References: <20230126-gpio-mmio-fix-v2-0-38397aace340@ncr.com>
In-Reply-To: <20230126-gpio-mmio-fix-v2-0-38397aace340@ncr.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Niall Leonard <nl250060@ncr.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3862; i=nl250060@ncr.com;
 h=from:subject:message-id; bh=142m7Aqg9vw0k6ow9nta9rhrZ0z5xj3jNyxgUalZmSE=; 
 =?utf-8?q?b=3DowEBbQKS/ZANAwAKAVGiIrYFD2P/AcsmYgBj2Rxz/48ADK4QFJhVsMMPjq97F?=
 =?utf-8?q?Yf9+GU+yxYhz3oB_Ru8fQjOJAjMEAAEKAB0WIQSha1EPjh6hUqdtwZNRoiK2BQ9j/?=
 =?utf-8?q?wUCY9kccwAKCRBRoiK2BQ9j/wfqD/_9MfkaSMi+fNT85L55YvriK0JaptFrIHxrzl?=
 =?utf-8?q?FJkfh1nGjioTNPmW5mT742ULSkzx0ZJjzvYh1ay8Hvo_iBV2bG3RkqCZmS8mCD7kY?=
 =?utf-8?q?6nm729bvgLoj968DNt2UQNHiFlZ9w2Ftl7eOYCOKLAVLq5THkCE3FGlu9_qVR95vc?=
 =?utf-8?q?3ZIQfWIBF6K92t8c/nigXW31IfBnNEZJAU4JflHT091gaHq0fzgsnUb+4rDXfN8fU?=
 =?utf-8?q?hBUPYU_DD8A9mGV16pxJ3UxzgtPmn/ax5FTYxMe2daeKsU0II1SiJSQgWqAd17zku?=
 =?utf-8?q?Wwnm5VtK6T5HUz0fI0R1_ojpLc6fvAAvMR/UT87sjoXPwY6KiSYUSCRzpga3Iifq5?=
 =?utf-8?q?XrxObXEWbZqjqAJ8KiuzWxSH2xkp0x/tHu_/RNTfLvOFLHFZ4N5BAzFEFSjdH1+xj?=
 =?utf-8?q?Bo7SkA/zG1GmmhwyAujGu4n2vn0zNcpGTJ/4/75YRlOx53V9_LPmTS7pvTer4Bmzx?=
 =?utf-8?q?JdW2WqV6K1JSRHwi8o9zxNyocMMkhdPxZzbbhpZt8AWMNqgrsc7/wt7r6SVkvU_tV?=
 =?utf-8?q?HtW0CRFyWF+JB+ezrD4cBLX3I5Hd5SAVbAAtplpqD+8dIjE6YzGOYImUqGMyMWBj6?=
 =?utf-8?q?Rhu8odA2r9H?=
 m7SJgWML6WQbWU8eiGZ8CHPMsT8HH7fKIDMf51D0mQsw12JF5ymFL8punxGw==
X-Developer-Key: i=nl250060@ncr.com; a=openpgp;
 fpr=A16B510F8E1EA152A76DC19351A222B6050F63FF
X-Endpoint-Received: by B4 Submission Endpoint for nl250060@ncr.com/default with auth_id=26
X-Original-From: Niall Leonard <nl250060@ncr.com>
Reply-To: <nl250060@ncr.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niall Leonard <nl250060@ncr.com>

Convert existing wd,mbl-gpio binding documentation to YAML and add
new optional propery "no-input".

Signed-off-by: Niall Leonard <nl250060@ncr.com>
---
 .../devicetree/bindings/gpio/wd,mbl-gpio.txt       | 38 -----------
 .../devicetree/bindings/gpio/wd,mbl-gpio.yaml      | 78 ++++++++++++++++++++++
 2 files changed, 78 insertions(+), 38 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt b/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
deleted file mode 100644
index 038c3a6a1f4d..000000000000
--- a/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-Bindings for the Western Digital's MyBook Live memory-mapped GPIO controllers.
-
-The Western Digital MyBook Live has two memory-mapped GPIO controllers.
-Both GPIO controller only have a single 8-bit data register, where GPIO
-state can be read and/or written.
-
-Required properties:
-	- compatible: should be "wd,mbl-gpio"
-	- reg-names: must contain
-		"dat" - data register
-	- reg: address + size pairs describing the GPIO register sets;
-		order must correspond with the order of entries in reg-names
-	- #gpio-cells: must be set to 2. The first cell is the pin number and
-			the second cell is used to specify the gpio polarity:
-			0 = active high
-			1 = active low
-	- gpio-controller: Marks the device node as a gpio controller.
-
-Optional properties:
-	- no-output: GPIOs are read-only.
-
-Examples:
-	gpio0: gpio0@e0000000 {
-		compatible = "wd,mbl-gpio";
-		reg-names = "dat";
-		reg = <0xe0000000 0x1>;
-		#gpio-cells = <2>;
-		gpio-controller;
-	};
-
-	gpio1: gpio1@e0100000 {
-		compatible = "wd,mbl-gpio";
-		reg-names = "dat";
-		reg = <0xe0100000 0x1>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		no-output;
-	};
diff --git a/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.yaml b/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.yaml
new file mode 100644
index 000000000000..d1c72a42c5bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/wd,mbl-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Western Digital's MyBook Live memory-mapped GPIO controllers.
+
+maintainers:
+  - Niall Leonard <nl250060@ncr.com>
+
+description: |+
+  Bindings for the Western Digital's MyBook Live memory-mapped GPIO controllers.
+
+  The Western Digital MyBook Live has two memory-mapped GPIO controllers.
+  Both GPIO controller only have a single 8-bit data register, where GPIO
+  state can be read and/or written.
+
+properties:
+  compatible:
+    enum:
+      - wd,mbl-gpio
+
+  reg-names:
+    items:
+      - const: dat
+
+  reg:
+    maxItems: 1
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-controller: true
+
+  no-output:
+    description: GPIOs are read-only.
+
+  no-input:
+    description: GPIOs are write-only.
+
+required:
+  - compatible
+  - reg-names
+  - reg
+  - '#gpio-cells'
+  - gpio-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio0: gpio0@e0000000 {
+        compatible = "wd,mbl-gpio";
+        reg-names = "dat";
+        reg = <0xe0000000 0x1>;
+        #gpio-cells = <2>;
+        gpio-controller;
+    };
+
+    gpio1: gpio1@e0100000 {
+        compatible = "wd,mbl-gpio";
+        reg-names = "dat";
+        reg = <0xe0100000 0x1>;
+        #gpio-cells = <2>;
+        gpio-controller;
+        no-output;
+    };
+
+    gpio2: gpio1@e0200000 {
+        compatible = "wd,mbl-gpio";
+        reg-names = "dat";
+        reg = <0xe0200000 0x1>;
+        #gpio-cells = <2>;
+        gpio-controller;
+        no-input;
+    };
+

-- 
2.34.1

