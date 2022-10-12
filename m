Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263335FCBF4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJLUYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJLUYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:24:17 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C78748CC;
        Wed, 12 Oct 2022 13:24:15 -0700 (PDT)
Date:   Wed, 12 Oct 2022 20:24:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noorman.info;
        s=protonmail3; t=1665606253; x=1665865453;
        bh=6hh6wmaeEggd5Zj1RKadtc85lP4W5my/I+6R/GaehO0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=ZXNYFaQPrRHLVCX31eTmGo0oGnJeLnZ/vF2eej3kiC/bE940568Ay9NJQ+Ax1S53z
         X+plIvT9rla1yIXAjCkk+ntdFwGxnPrdrlPMFH2sNmpeBWLukoySUb+EJBvjGo9vFF
         Qmp4oLp2hVZyVA3hD+P9kBQaaCrMEMKj6F7sDvWTAeCLSJUUB3wuzWddgdFCleGFZC
         CRx4nlDDZ8a8lj6nKeG32ZS0SZSRgU7sYHgI7pLEUSzWdajMr+gfwipkORdKD2vnXI
         igodU4z+Sxpsae4ofnErRHAna9tJ1Gw3eVz/DvV5hXKQJgEugNQmFhcOdXtTeV1Aci
         r+6TNMIKgAyWQ==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
From:   Job Noorman <job@noorman.info>
Cc:     Luca Weiss <luca@z3ntu.xyz>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: touchscreen: add Himax hx83112b bindings
Message-ID: <20221012202341.295351-2-job@noorman.info>
In-Reply-To: <20221012202341.295351-1-job@noorman.info>
References: <20221012202341.295351-1-job@noorman.info>
Feedback-ID: 14439221:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device tree bindings for Himax 83112b touchscreen
devices.

Signed-off-by: Job Noorman <job@noorman.info>
---
 .../input/touchscreen/himax,hx83112b.yaml     | 61 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/him=
ax,hx83112b.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/himax,hx83=
112b.yaml b/Documentation/devicetree/bindings/input/touchscreen/himax,hx831=
12b.yaml
new file mode 100644
index 000000000000..c10c82415401
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.ya=
ml
@@ -0,0 +1,61 @@
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
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+      touchscreen@48 {
+        compatible =3D "himax,hx83112b";
+        reg =3D <0x48>;
+        interrupt-parent =3D <&tlmm>;
+        interrupts =3D <65 IRQ_TYPE_LEVEL_LOW>;
+        touchscreen-size-x =3D <1080>;
+        touchscreen-size-y =3D <2160>;
+        reset-gpios =3D <&tlmm 64 GPIO_ACTIVE_LOW>;
+      };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 9ddcc242081c..2418bffe9187 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9094,6 +9094,12 @@ W:=09http://www.highpoint-tech.com
 F:=09Documentation/scsi/hptiop.rst
 F:=09drivers/scsi/hptiop.c

+HIMAX HX83112B TOUCHSCREEN SUPPORT
+M:=09Job Noorman <job@noorman.info>
+L:=09linux-input@vger.kernel.org
+S:=09Maintained
+F:=09Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.ya=
ml
+
 HIPPI
 M:=09Jes Sorensen <jes@trained-monkey.org>
 L:=09linux-hippi@sunsite.dk
--
2.38.0


