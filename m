Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EA561F13E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiKGK4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiKGK4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:56:20 -0500
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3919E1900E;
        Mon,  7 Nov 2022 02:56:19 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4N5Sp769thz9tRf;
        Mon,  7 Nov 2022 11:56:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noorman.info;
        s=MBO0001; t=1667818575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xgG1+/mqCR7NFJDaGitypAnL4fZThzOryVEVRuhQPXg=;
        b=s2EoQ75aH4ZASZilf4Xsz4UxQR0yWSifFmLb1P9BqdSPa8Fh8VRJSJrEey5G+cu5rm8jWa
        HZjV4RO4CT8WuvgVK1o/BkTnuYO3N8abfZ1FFI8I9hdg6ZYN/wtwpAmuHmzs+OS+/bp9uV
        +Ee/PnLy0ja3MIyCravsdHaifxIyzJwwqbzDd6EQzYAKNksbPaJ4cP3Kd64qezDewv6FEr
        rgZmsiyfxUSxyD6yS7hcEFOQ+4jJFm1rZ/wUIzvZEA8bYI6IAn6dX4PIsNPGkBtmJYnlDz
        rAYPmaJNT1+woG5RiFeeGtZl6C5A0KcqKRuJ1wDU8NWI1rmVA+kY97N3qebROw==
From:   Job Noorman <job@noorman.info>
To:     Job Noorman <job@noorman.info>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH RESEND v6 1/3] dt-bindings: touchscreen: add Himax hx83112b bindings
Date:   Mon,  7 Nov 2022 11:56:02 +0100
Message-Id: <20221107105604.26541-2-job@noorman.info>
In-Reply-To: <20221107105604.26541-1-job@noorman.info>
References: <20221107105604.26541-1-job@noorman.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4N5Sp769thz9tRf
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
index cf0f18502372..469ab6382906 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9162,6 +9162,12 @@ W:	http://www.highpoint-tech.com
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
2.38.1

