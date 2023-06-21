Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0743B7386F8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjFUO1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjFUO1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:27:15 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0716610D5;
        Wed, 21 Jun 2023 07:26:44 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b4745834f3so54991031fa.2;
        Wed, 21 Jun 2023 07:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687357602; x=1689949602;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXp+vDAywJj5cJVg/DGBbIIG0LrSwQcuzIbyxZXKO/k=;
        b=UP3OyWN+5ecr1xlIb7pHYBadTYZQly/kIMPmuS9kujYlNimputz+zZOzKhPlZmJBuF
         aG1lwHGq6a2UZc4oRSj0chrcqOv2F5UzWHFfOhfLEdOHa5Knynk5rKni1va7viwNhzkP
         tdlNVksai/R6T1u9cUsT7fyRR2Rg/ebjSzJTAq68how2dfz+PipYdYaNWIZ/6ZGcmtqS
         /GZOhk5sQ58FhqzmeDOd8GomVZNTt0ZYjhXhfnEyADpJD8U05nXZjYqGjbEdYMbjQ+kA
         SGJveeESLeQJ7ACg/4N6bHWXDxbdMOhq0V/fUtpBc267r6SH3T04VRmCNUPCk1EJoiy4
         W0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687357602; x=1689949602;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXp+vDAywJj5cJVg/DGBbIIG0LrSwQcuzIbyxZXKO/k=;
        b=lpTmzDglVJhIVgPGyPUwcIZ+vcwZNmBnhk3F+5Ig/MgjspKu5OGmxE4kR4h0wRWOS9
         5siO3wwVfgG1JvDgWJWMUZzckKGYobgwdL9/mPOiChrJTc5L4G3KRYbZwZHwXy4Oh7K7
         vqoTlE2/sWP8XWvmG5xBM9m9eatdoLFm/ZddZDjXQb7DaL6EKdSAmjlTB3qT88q4C3C1
         2rslhtXe/cDAG1T0ruEeTzvmoBf0JgF5c5mosrPBddZHwkQS+K83dP5JAYj29GefJDAl
         TI1+U2/5ILUo1NTFMVjP9AhQMGB+YQgl683+6nFL5vOMwUx96xktUFg+7W7RSCfbrm9L
         RqFA==
X-Gm-Message-State: AC+VfDwApdcYKv+BzzHCWbYCH6DkL2q9Wl3Um7o/+TiRgMpvSWNlJQ7D
        M1Jg4y/oZKobm9mZxUFYLto=
X-Google-Smtp-Source: ACHHUZ41bK7GbPj4Q4/ms1CfUJQsjI2LU88qpxC0XJoGOKFGgJiDpf8tUoe6KWqbHNCdOEkRJxqEKA==
X-Received: by 2002:a2e:6e07:0:b0:2b4:4a68:a95 with SMTP id j7-20020a2e6e07000000b002b44a680a95mr10759042ljc.8.1687357601846;
        Wed, 21 Jun 2023 07:26:41 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id l11-20020a170906644b00b00988956f244csm3266156ejn.6.2023.06.21.07.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 07:26:41 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 21 Jun 2023 16:26:29 +0200
Subject: [PATCH v2 3/3] dt-bindings: usb: Add binding for Cypress HX3 USB
 3.0 family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-hx3-v2-3-76a53434c713@skidata.com>
References: <20230620-hx3-v2-0-76a53434c713@skidata.com>
In-Reply-To: <20230620-hx3-v2-0-76a53434c713@skidata.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

The HX3 family comes in different variants (up to 4 USB 3.0 ports;
multi-TT), e.g. CYUSB330x/CYUSB331x/CYUSB332x/CYUSB230x.

This initial version of the binding only describes USB related aspects
of the HX3 family, it does not cover the option of connecting the
controller as an i2c slave.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 .../devicetree/bindings/usb/cypress,hx3.yaml       | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/cypress,hx3.yaml b/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
new file mode 100644
index 000000000000..47add0d85fb8
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/cypress,hx3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cypress HX3 USB 3.0 hub controller family
+
+maintainers:
+  - Benjamin Bara <benjamin.bara@skidata.com>
+
+allOf:
+  - $ref: usb-device.yaml#
+
+properties:
+  compatible:
+    enum:
+      - usb4b4,6504
+      - usb4b4,6506
+
+  reg: true
+
+  reset-gpios:
+    items:
+      - description: GPIO specifier for RESETN pin.
+
+  vdd-supply:
+    description:
+      1V2 power supply (VDD_EFUSE, AVDD12, DVDD12).
+
+  vdd2-supply:
+    description:
+      3V3 power supply (AVDD33, VDD_IO).
+
+  peer-hub:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to the peer hub on the controller.
+
+required:
+  - compatible
+  - reg
+  - peer-hub
+  - vdd-supply
+  - vdd2-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    usb {
+        dr_mode = "host";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* 2.0 hub on port 1 */
+        hub_2_0: hub@1 {
+          compatible = "usb4b4,6504";
+          reg = <1>;
+          peer-hub = <&hub_3_0>;
+          reset-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+          vdd-supply = <&reg_1v2_usb>;
+          vdd2-supply = <&reg_3v3_usb>;
+        };
+
+        /* 3.0 hub on port 2 */
+        hub_3_0: hub@2 {
+          compatible = "usb4b4,6506";
+          reg = <2>;
+          peer-hub = <&hub_2_0>;
+          reset-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+          vdd-supply = <&reg_1v2_usb>;
+          vdd2-supply = <&reg_3v3_usb>;
+        };
+    };

-- 
2.34.1

