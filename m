Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0984160DFFF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbiJZLuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiJZLty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:49:54 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430B954656;
        Wed, 26 Oct 2022 04:49:53 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 8A4683200920;
        Wed, 26 Oct 2022 07:49:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 26 Oct 2022 07:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666784991; x=
        1666871391; bh=x94I9aHfmLGjXqYb5dRoF5FSksxj73tYDSpz7akLDtk=; b=u
        8bjBeOEKF0NjdTyIRK5jloQAvA7PGK9D2SzNLUNxJkTs4gUkMT8jNn94vQvWMGlX
        qNVeIQVy0G7KzMbPpY1f0v/Arj5oEk8ni45bCrwO93smM2ERhv5QO2zspucSd2XM
        8vn3LMF8cEmDW9KzN/J6WwqhNg/dX8s0ZZB8yTccMrdGxs3BijLeMWqJvmKWRoWY
        +x/VHooDlOPAe9BD1NT0yIb9P3jgo3EuCsCT1FK9u07BCrKRrnYxsBJEh4PpxGnd
        f1Ed+epu9OVJ+h9DK0uL0g5YBxrqun3pgpWrRlDw35q+4x2vfymmgnwuV8DvItUo
        RdWgMuaXWzXoMl9scT2Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1666784991; x=1666871391; bh=x94I9aHfmLGjX
        qYb5dRoF5FSksxj73tYDSpz7akLDtk=; b=jPbxo/K77NBZ+i73snaMWtiOnP9Z7
        1g980tfMeZADTmsNX6UdxSJtzvqzS83gyDCfxFOfB6n6H2EMFulq0RBa0zMyDmwh
        110f5YnJZGYCLgv3O51bsbP5CnJ4iCf3JoVNr2zTKZf2yD7e/rsYm0XHjBVFrUmq
        CMeRKRzu0jdWMnd3J7yCh0nXBwJjotFzI2spGQa8n4F9vmDpeSseYpeTlqp9rdPU
        GriT7535zHBFMpNSocSQiIkmCsnPB0nu/XQLXedpwcJkq/2FA4TnkX0QizG2QB6S
        DGfskHTCQnq0dHQinJefaKiTN2sTW83Ayb7WOUFKD6sYVOvhby7UdN5rw==
X-ME-Sender: <xms:3h5ZY4TPu6SvwpTdtEPQ9CYwPGHN9on5vjY9YCEqxBYfAfopVn7jUg>
    <xme:3h5ZY1wPDu7Jg-yIvn6frxHHt3tnF0dJMP-WJWQJKHPDTxsnczF2Yvis0H8TJL0ni
    c__9TxhwbKcVvxUVtE>
X-ME-Received: <xmr:3h5ZY12K-eX58x7CDca6Ub6KL6le9YNuNcTuUNogYcVUW13uI5UOJDCAutJ6HoJhKivX8ixZgHHB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtddvgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhhishht
    rghirhcuhfhrrghntghishcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
    eqnecuggftrfgrthhtvghrnheplefgffeuheevvdekgefghfegueeuteetueekteevgedt
    ffejvefguedujeeljeevnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishht
    rghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:3h5ZY8DjLpbO0e98fSMzJGdkcG6qwmdrnahDIpCfmCxTQxSWaQrMcw>
    <xmx:3h5ZYxg92cN53XFTDKLUujKDuncVsqAfmgKymtau0_dwAYUCwM87kw>
    <xmx:3h5ZY4ovaTMj5JSmEBF9iB2vY6oJ3r9kvE5a75JM_TVgdYeQOWOwzQ>
    <xmx:3x5ZY0QPon0njBkXHG7Q7ikKVlxKHONM_3jdn5LwhczMPser9yTvMg>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Oct 2022 07:49:42 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, dmitry.torokhov@gmail.com, shawnguo@kernel.org,
        rydberg@bitmath.org, alistair23@gmail.com, s.hauer@pengutronix.de,
        andreas@kemnade.info, Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v10 2/4] dt-bindings: input: Add Cypress TT21000 touchscreen controller
Date:   Wed, 26 Oct 2022 21:49:06 +1000
Message-Id: <20221026114908.191472-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221026114908.191472-1-alistair@alistair23.me>
References: <20221026114908.191472-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 .../input/touchscreen/cypress,tt21000.yaml    | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
new file mode 100644
index 000000000000..1959ec394768
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/cypress,tt21000.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cypress TT21000 touchscreen controller
+
+description: The Cypress TT21000 series (also known as "CYTTSP5" after
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
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
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
+    $ref: ../input.yaml#
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

