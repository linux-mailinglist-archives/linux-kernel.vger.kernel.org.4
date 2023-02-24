Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5126A19F9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjBXKUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjBXKUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:20:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88436193E9;
        Fri, 24 Feb 2023 02:20:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41C86B81C22;
        Fri, 24 Feb 2023 10:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA843C4339B;
        Fri, 24 Feb 2023 10:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677234012;
        bh=o09fY9Xu8orx2KCwioNnI0LmHk4pUDMSJu6mqNTRom4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=Lh//qtL7VNScNh0aYh5oohVDCkWon/cqmgc4ps/PG5txQuNaaYUl8ez/pjPI52oAH
         0LDJhqdlXG19qulDav+0XLFQJ5onqvVyOBKJ+aYiy44Re1NtbyODxJiIC7oE2NVTud
         mG/HQgdgx9QLlLZOQWedAtUTQ2jymvyD3Wy17K6a8i0T7ejUzYKukA5H2mPsG9OFxn
         +RezGaNLO2SRCDJ7lLXSaWXSvE5d1flhmL2oVEunVffRmcctPjB3tx8u0Iexl992uj
         F9g44cuHd1LVtMtafOISQG98f32asXx6CdZ0wIHRPsLB5SYbP0TDke9AlX+HBreD9m
         q1h26pT+LfsGw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id D16A0C64ED8;
        Fri, 24 Feb 2023 10:20:11 +0000 (UTC)
From:   Sasha Finkelstein via B4 Relay 
        <devnull+fnkl.kernel.gmail.com@kernel.org>
Date:   Fri, 24 Feb 2023 11:20:06 +0100
Subject: [PATCH RFC 1/4] dt-bindings: input: touchscreen: Add Z2 controller
 bindings.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-z2-for-ml-v1-1-028f2b85dc15@gmail.com>
References: <20230223-z2-for-ml-v1-0-028f2b85dc15@gmail.com>
In-Reply-To: <20230223-z2-for-ml-v1-0-028f2b85dc15@gmail.com>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <asahi@lists.linux.dev>, Henrik Rydberg <rydberg@bitmath.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677234010; l=2766;
 i=fnkl.kernel@gmail.com; s=20230213; h=from:subject:message-id;
 bh=TIFeuBdRxzykTftxnIb6paUfaCW7E97Qi1elJFdmf7U=;
 b=c+U5qTMzGRBHyc/3ErDETUt6IQ+mC5Oe26vWKbSJ6yB7qx9I7uJB8eFYGoWMwv0y49Wz6mwi5
 /qtg+m5apLKAs8MZnNIbISBEZ2l5ghoQt4wXe5W+3gnSSPYTI81yhhL
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=7LFSAJtxIWAs9LzCIyX0sSvCZy2wQTyEIu1zch6o804=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20230213 with auth_id=28
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: <fnkl.kernel@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

Add bindings for touchscreen controllers attached using the Z2 protocol.
Those are present in most Apple devices.

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 .../input/touchscreen/apple,z2-touchscreen.yaml    | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/apple,z2-touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/apple,z2-touchscreen.yaml
new file mode 100644
index 000000000000..695594494b1e
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/apple,z2-touchscreen.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/apple,z2-touchscreen.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple touchscreens attached using the Z2 protocol.
+
+maintainers:
+  - asahi@lists.linux.dev
+  - Sasha Finkelstein <fnkl.kernel@gmail.com>
+
+description: A series of touschscreen controllers used in Apple products.
+
+allOf:
+  - $ref: touchscreen.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: apple,z2-touchscreen
+
+  reg:
+    maxItems: 1
+
+  interrupts-extended:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  cs-gpios:
+    maxItems: 1
+
+  firmware-name:
+    maxItems: 1
+
+  apple,z2-device-name:
+    description: The name to be used for the input device
+    $ref: /schemas/types.yaml#/definitions/string
+
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  spi-max-frequency: true
+
+required:
+  - compatible
+  - interrupts-extended
+  - reset-gpios
+  - cs-gpios
+  - firmware-name
+  - apple,z2-device-name
+  - touchscreen-size-x
+  - touchscreen-size-y
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            touchscreen@0 {
+                    compatible = "apple,z2-touchscreen";
+                    reg = <0>;
+                    spi-max-frequency = <11500000>;
+                    reset-gpios = <&pinctrl_ap 139 0>;
+                    cs-gpios = <&pinctrl_ap 109 0>;
+                    interrupts-extended = <&pinctrl_ap 194 IRQ_TYPE_EDGE_FALLING>;
+                    firmware-name = "apple/dfrmtfw-j293.bin";
+                    touchscreen-size-x = <23045>;
+                    touchscreen-size-y = <640>;
+                    apple,z2-device-name = "MacBookPro17,1 Touch Bar";
+            };
+    };
+
+...

-- 
Git-137.1)

