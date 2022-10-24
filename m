Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B84D609FDE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiJXLLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiJXLLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:11:03 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C183845999;
        Mon, 24 Oct 2022 04:11:00 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 4737E3200919;
        Mon, 24 Oct 2022 07:10:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 24 Oct 2022 07:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666609858; x=
        1666696258; bh=QE/t9z9CMyL9UR78guoOLnyMowBUbgZ3WsCHLUVTT94=; b=v
        5cnVG/LxeZ1GExr93cvVTDPL/mAqjnVWHHLVELFd7JgBeddYkNf39egBrtvbLS/v
        GstPDllllcsUMmhki1NdAQDvppsROUysi/N4DhiGUAPjtY/WPkNBn5MlCGIzDF19
        DGe4CN92OMBGsmYbn4vY1fiZkQt0JvKmedSellZd2QsqPxlxRLZSJcinnBpyNZ26
        KSEZ2clbznRjUDgJWyj/GP9I6Tl7cLr+WcXxPfCWEEgnyO8Qc28wvQ68wNVI270R
        rKHwvMwzE7tfH4YOQuUONve9mRYkNsqgmsybfs5msCywNvCuHS1zUqOGy03CuEof
        1jCIo5hsk5o+54IVIg6ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1666609858; x=1666696258; bh=QE/t9z9CMyL9U
        R78guoOLnyMowBUbgZ3WsCHLUVTT94=; b=eZnwJsff4b0i0ZpG3AcFS2lj5FWaz
        bulPOPQn5VIVPMcOzKWbue1qcfe6oZjnh9+FvHIsAduMaXQ83osLjfaSf50IGH+v
        gf4p5vB6anR3OsIlUrQT/cifABKJKMcdQPHYTS7o1ub3o9KVSakG+4g2mZ0chJL/
        ZGjioIRvhT2KZGR8F19mv+0Cgs0qoiwcHHgW80AyofIQhpavj9Pfk6NdTG9C3hLC
        HU9OpJ/FOzpoO3NKW3ZwNo53LCpYGA1akvBfJgT3QYkGz1z8JQKwbAnpTz+YaqLB
        R+58Y/ji5m+Ha0dCqXPNhXAqLnF84/tK8Lhs4ZgIMDtMUVP1p7o6j9DrA==
X-ME-Sender: <xms:wnJWY0_64v9aOlBnrjbQa56DiBxjGVSLokHL_-A183TK2xQz1QTDTA>
    <xme:wnJWY8upUWsqi749V0ydHLaffTBqFbZWVd92CqG8hLDD5D0njIsPWLgfpTipVxtV8
    Bhf4CUGaFE3PQfSDx4>
X-ME-Received: <xmr:wnJWY6AF1pgg-zaR17nE41aAs5gkcAABaI9hFnr7xONHpYmCJDGl5VrkZtMwYrf-76YEvlKwE8XI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtgedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhs
    thgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmh
    gvqeenucggtffrrghtthgvrhhnpeelgfffueehvedvkeeggffhgeeuueetteeukeetveeg
    tdffjeevgfeuudejleejveenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhs
    thgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:wnJWY0eRkZBaWF61TbRB3tfCetd5FS5rRxbdagac82SnYINwsvmM3w>
    <xmx:wnJWY5NpOBLmUPvmXg00-A-NRB_TbI88mWGAv1vdnf0duFzt149MXQ>
    <xmx:wnJWY-mhSb-4cf9bg-VhUW_kzIKKDSF0p1MQcf2YbYYDTlYc-spWQw>
    <xmx:wnJWY_tZmg_edbOkXhepZQyfQudh-b2Ob7fUDZwG8CDJOVbvXtYY-g>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Oct 2022 07:10:49 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linus.walleij@linaro.org, s.hauer@pengutronix.de,
        robh+dt@kernel.org, andreas@kemnade.info,
        krzysztof.kozlowski+dt@linaro.org, alistair23@gmail.com,
        dmitry.torokhov@gmail.com, rydberg@bitmath.org,
        shawnguo@kernel.org, Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v9 2/4] dt-bindings: input: Add Cypress TT2100 touchscreen controller
Date:   Mon, 24 Oct 2022 21:10:15 +1000
Message-Id: <20221024111017.43859-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024111017.43859-1-alistair@alistair23.me>
References: <20221024111017.43859-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Cypress TrueTouch Generation 5 touchscreen device tree bindings
documentation. It can use I2C or SPI bus.
This touchscreen can handle some defined zone that are designed and
sent as button. To be able to customize the keycode sent, the
"linux,code" property in a "button" sub-node can be used.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../input/touchscreen/cypress,tt21000.yaml    | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
new file mode 100644
index 000000000000..0913b585af5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/cypress,tt21000.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cypress TT2100 touchscreen controller
+
+description: The Cypress TT2100 series (also known as "CYTTSP5" after
+  the marketing name Cypress TrueTouch Standard Product series 5).
+
+maintainers:
+  - Alistair Francis <alistair@alistair23.me>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    const: cypress,tt21000
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator for voltage.
+
+  reset-gpios:
+    maxItems: 1
+
+  linux,keycodes:
+    description: EV_ABS specific event code generated by the axis.
+
+patternProperties:
+  "^button@[0-9]+$":
+    type: object
+    $ref: input.yaml#
+    properties:
+      reg:
+        maxItems: 1
+      linux,keycodes:
+        description: Keycode to emit
+
+    required:
+      - reg
+      - linux,keycodes
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vdd-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/input/linux-event-codes.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@24 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            compatible = "cypress,tt21000";
+            reg = <0x24>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&tp_reset_ds203>;
+            interrupt-parent = <&pio>;
+            interrupts = <1 5 IRQ_TYPE_LEVEL_LOW>;
+            reset-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&reg_touch>;
+
+            button@0 {
+                reg = <0>;
+                linux,keycodes = <KEY_HOMEPAGE>;
+            };
+
+            button@1 {
+                reg = <1>;
+                linux,keycodes = <KEY_MENU>;
+            };
+
+            button@2 {
+                reg = <2>;
+                linux,keycodes = <KEY_BACK>;
+            };
+        };
+    };
+...
-- 
2.37.3

