Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFD67381C9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjFUKjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjFUKiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:38:54 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F6310C1;
        Wed, 21 Jun 2023 03:38:13 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9875c2d949eso725249666b.0;
        Wed, 21 Jun 2023 03:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687343892; x=1689935892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXp+vDAywJj5cJVg/DGBbIIG0LrSwQcuzIbyxZXKO/k=;
        b=XRdFpyRFNawHmE6+XHOzNI1+RJEKkIVB9igaP0jor/BXQ+humXxmn7E/bNKb6bNmpv
         TfuE2GT4ON0jwxwCS6XOeO0jFxso7h5zwECCcDeT+zLvxag92DEDr4TBNeAgKMEdFq3C
         VvLRgln65978WjcoY4vOKV1hwAJEnCR2zmux1p60bvrivPHeht2sNCEeJZr/kN9Jt9l6
         N4/41jvW1veFCM/h3/KA1WbaSKdlKI5Uvy84nxHypH9I5naxWZC3NM5xh60S/WCdLEPW
         9jqo5HA8mU4EFq/Vo7gBMQDY5+TW7f/JXb5QON4kE+mXgKOOBFhRiZaFGxjGh9FP9xoA
         5wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343892; x=1689935892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXp+vDAywJj5cJVg/DGBbIIG0LrSwQcuzIbyxZXKO/k=;
        b=GdiHFakYE6e3NOxX1G3GRAreYfEAJyKIkMDA0muawXF+Fin0e9fGQlQ5yrWsiLNfZj
         56WcZHOXcrP7M5f6IKd/xS/7kQvqd6CFwi82t6uAaCG1QHV9kNB0kVV1urMTZVZSLBHa
         CaWxUv/HpAaoUB0/YJuQEcd8/9e+aVDWaXaDC710CzGBiRG25Uh3+EsK+mrL+Et0Xrre
         DMHIFCVyKyT48t1D/zs0uxPos/RRVopJNivfgLw/SfGL2XU2C3oxj7GROZWIvs0GWrwH
         BlRRcGeR5aZh97oUEJsB3RG+ChA0X/Q2M1etfqMNra7+VcDdwGwDrLiUZ8wsj6H0oSge
         quow==
X-Gm-Message-State: AC+VfDzBzKtNHY9hpiuMoE0+H/IW//zsrtNrdSHmf3gd+aPQ8n9NgWL7
        832KWDr8pzlAV6ZXyuSVO3cLbqWdVGl9YA==
X-Google-Smtp-Source: ACHHUZ4ys2Ncl+mKEluiLymbYZKnhC9ZGxuInnYodJzyFUCW7Lfs5MrVIqmH0FjF6nK7S8EmpcVHnQ==
X-Received: by 2002:a17:906:f898:b0:984:8225:27c2 with SMTP id lg24-20020a170906f89800b00984822527c2mr10565463ejb.32.1687343892104;
        Wed, 21 Jun 2023 03:38:12 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709063a4600b00987e76827b2sm2873055ejf.53.2023.06.21.03.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:38:11 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 21 Jun 2023 12:38:03 +0200
Subject: [PATCH 4/4] dt-bindings: usb: Add binding for Cypress HX3 USB 3.0
 family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-hx3-v1-4-3a649b34c85b@skidata.com>
References: <20230620-hx3-v1-0-3a649b34c85b@skidata.com>
In-Reply-To: <20230620-hx3-v1-0-3a649b34c85b@skidata.com>
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

