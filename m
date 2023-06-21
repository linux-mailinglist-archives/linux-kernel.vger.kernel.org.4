Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEF7738A4F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjFUP7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjFUP6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:58:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5446F186;
        Wed, 21 Jun 2023 08:58:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-978863fb00fso926917966b.3;
        Wed, 21 Jun 2023 08:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687363127; x=1689955127;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXp+vDAywJj5cJVg/DGBbIIG0LrSwQcuzIbyxZXKO/k=;
        b=Gb0TzHqwzv+RP62LSJ5Lt6UkdvX0M2muoGWBR0e6byr6bsn/YJ2+MRGJs3PECwO4NW
         an/fwqqeu2Q5yHmmUmFMcnzsv1i/dg03aRtHinJAle3rXcfzRDBlatfppktjkVEx8PSW
         qDKccS+VKRZ9lCt92x47XN8TwIVJ1VAWgGCOPRY6uXMFOxtCDUvfoVbXBNfn8a0ORZbr
         1T5R2ZSm7wq05lD7XwTGtJcLi0znJOfFJ1jmA88TZtgvtl1egqvKMFvcHNAqXBD8c0i1
         qDWSw4PK0jLfiHLdmdTiErNAZq5EBUdeypjEhTjD68wHbpFtY6P+E6Ap4EcKa47hWrwF
         c3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687363127; x=1689955127;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXp+vDAywJj5cJVg/DGBbIIG0LrSwQcuzIbyxZXKO/k=;
        b=CekqBatEwwXzFeiVTo3Q0ZRpHwSzbS+Pi8XohCifDYqSwTMxSUqYjjlxxqyslJu/PF
         wVzzuAWCGGX00dlFyCN4Rkl+70LAKPzuhxo7d4b13lyJWJZusi9HnNfZwaVxJy63M7N1
         kFb1SUm6FzwA+rkzSDcfnyaToQ1y/t6cc52dR0mUnahE6OKfks4b2kB09vwmohUxxfze
         o6cvgkWmzOVhuUqpCFj7fsBQ+ykj15Rwxtb8972R+OllOFWlZfQAkZdE4SWNuYgIHmHv
         hh9X23PlpGgMKaelVMmy5FVHzx520XnoACmu3Um3r0NGoZ3aUaiUn/S0QCC1kQT8GzlT
         Hk5Q==
X-Gm-Message-State: AC+VfDyCsLnENBO+47PtTQ0KKxIOlbkkUV07EGjben26isVcV+i9izmW
        j4IGt/C1y1cySqD7f0MoF81KGgzqd3l9Tw==
X-Google-Smtp-Source: ACHHUZ6iDd8OnFoFXyuyEiDuhqCz1LfwMXgR0d/91+nypJbXgHUQYPJx6t0ysho5OcIwD2jD2mWGRw==
X-Received: by 2002:a17:907:60d6:b0:973:ca90:1f18 with SMTP id hv22-20020a17090760d600b00973ca901f18mr16990926ejc.76.1687363126769;
        Wed, 21 Jun 2023 08:58:46 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709060a1400b00977eec7b7e8sm3349316ejf.68.2023.06.21.08.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:58:46 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 21 Jun 2023 17:58:32 +0200
Subject: [PATCH v3 3/3] dt-bindings: usb: Add binding for Cypress HX3 USB
 3.0 family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-hx3-v3-3-2acbc03ca949@skidata.com>
References: <20230620-hx3-v3-0-2acbc03ca949@skidata.com>
In-Reply-To: <20230620-hx3-v3-0-2acbc03ca949@skidata.com>
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

