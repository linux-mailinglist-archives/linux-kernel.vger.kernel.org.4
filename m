Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A7D600BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiJQKFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiJQKE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:04:58 -0400
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95AB18E34;
        Mon, 17 Oct 2022 03:04:45 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4MrXfK0C5xz9tbR;
        Mon, 17 Oct 2022 12:04:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noorman.info;
        s=MBO0001; t=1666001081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l9BHDLmttWeYOs5g2PuG083SJb6QiJ8j+IRVJjZHwNo=;
        b=SIIOPSR/xAYC6BS3oDeG++iEq7vnakFf2A0PRKUG7f9OqLJO8gpndRzt9enjLVv0VQubXK
        96EJF+16eS9Y1FJHKK4+F+aZK6anBtjw3WvPg/ukZ/A86O7RqeVmDlqRLlEc9hbecIBGPe
        Dvfb7R2OLCPpvUKojGXB0mRnuOYcdmb/h45uTRLSiYMTHBxd9gACrjsPYCpdJbrxEecxyi
        T0cKdr6hpmDuYHtZU5fnIk+xCz2/5ytCKBFyU3i8bYwJDN8IFTxJLCampm70Y59rDnxUce
        iLw7Wx4CIALSNiP6h743lSbQYbJUQxNJTk7e1gOroXhN1DwVSMjKvWsbWYmhuA==
From:   Job Noorman <job@noorman.info>
To:     Job Noorman <job@noorman.info>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, Rob Herring <robh@kernel.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: touchscreen: add Himax hx83112b bindings
Date:   Mon, 17 Oct 2022 12:04:06 +0200
Message-Id: <20221017100409.189293-2-job@noorman.info>
In-Reply-To: <20221017100409.189293-1-job@noorman.info>
References: <20221017100409.189293-1-job@noorman.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4MrXfK0C5xz9tbR
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

