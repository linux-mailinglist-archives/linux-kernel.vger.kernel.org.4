Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED81A5FFEA7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 12:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJPKga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 06:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiJPKf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 06:35:59 -0400
X-Greylist: delayed 443 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Oct 2022 03:35:55 PDT
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABA13A16A;
        Sun, 16 Oct 2022 03:35:54 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4MqxDF6vDGz9td9;
        Sun, 16 Oct 2022 12:28:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noorman.info;
        s=MBO0001; t=1665916109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uoRUF8nZ/VGGSla+ak7lM2u3E/gt9381sADOuNB9V6g=;
        b=E6uUPe0IR0tVNA4cb8bpDwqdfA5YM2scPH66L9ACE8OoHGfrUgMQYNjX3VrTQclsaBqjcs
        Uwi63dpl1GfD2rEUdsQKG30E+ClfaCxC+K7+M4zEWaQ5D4WYb+il66WVV02FsaXzI16yJD
        HBjdHfzS2bSSPzLbX6gUQzpr3c3SfB+zJzLqfS9S3prerAMzI4bL+EIZQkvYy3fCM2crWV
        5cSsHyFwXvdyvNCykt3E2MKnZE309sciHVWXxAzen9MoVBLi96dxi6vOWKFFg0/71uAqdR
        imX2/mfhOZR5MXU4J1IL682Vi1RO3rC0MP7IGmN/HyWTbVmhVvyYYBdrar2GFg==
From:   Job Noorman <job@noorman.info>
To:     Job Noorman <job@noorman.info>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: touchscreen: add Himax hx83112b bindings
Date:   Sun, 16 Oct 2022 12:27:53 +0200
Message-Id: <20221016102756.40345-2-job@noorman.info>
In-Reply-To: <20221016102756.40345-1-job@noorman.info>
References: <20221016102756.40345-1-job@noorman.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4MqxDF6vDGz9td9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device tree bindings for Himax 83112b touchscreen
devices.

Signed-off-by: Job Noorman <job@noorman.info>
---
 .../input/touchscreen/himax,hx83112b.yaml     | 63 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml b/Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml
new file mode 100644
index 000000000000..be2ba185c086
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/himax,hx83112b.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Himax hx83112b touchscreen controller bindings
+
+maintainers:
+  - Job Noorman <job@noorman.info>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    enum:
+      - himax,hx83112b
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  touchscreen-swapped-x-y: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - touchscreen-size-x
+  - touchscreen-size-y
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      touchscreen@48 {
+        compatible = "himax,hx83112b";
+        reg = <0x48>;
+        interrupt-parent = <&tlmm>;
+        interrupts = <65 IRQ_TYPE_LEVEL_LOW>;
+        touchscreen-size-x = <1080>;
+        touchscreen-size-y = <2160>;
+        reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
+      };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 9ddcc242081c..2418bffe9187 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9094,6 +9094,12 @@ W:	http://www.highpoint-tech.com
 F:	Documentation/scsi/hptiop.rst
 F:	drivers/scsi/hptiop.c
 
+HIMAX HX83112B TOUCHSCREEN SUPPORT
+M:	Job Noorman <job@noorman.info>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml
+
 HIPPI
 M:	Jes Sorensen <jes@trained-monkey.org>
 L:	linux-hippi@sunsite.dk
-- 
2.38.0

