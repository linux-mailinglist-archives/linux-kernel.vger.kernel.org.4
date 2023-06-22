Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861E873A306
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjFVO3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjFVO3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:29:08 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDB71BC5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:29:06 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fa7512e599so5925105e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687444145; x=1690036145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31dDSPmTEwAk2xBEYscYsgGP3NvqtS1pbeFP7C1NdB4=;
        b=ZfBxKr/K0XhiCys9ocI6g4skVBpIoKmlEntkhuD+e9zbWmVGt+D9va4WTqbjneCw7Y
         C8q7r5rPDJslox7JIo9vOl1PnzN96vCT+yFx0EXvGjuUUxnr9gUTWPNjxLSVdwo6fNoC
         6iEkopWUtuyhvIeHj5JWJDoZz3k+qLkiXO32GDb//m5gNv56ZOoW09Qwhhr3pqd0FsPD
         c4PVKAk//A0X6kSs1dPpNu2XqnT27aXnV9LlOY59Jr9bJxM5AJbtgmEZzUSQkgooTJiy
         YAzs22wXJy9+vsIlLP/LjEcxpyJvbjHQz+XWBe0leePnsYQCz8wS2zZfhufzP+QGYq6V
         mqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687444145; x=1690036145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31dDSPmTEwAk2xBEYscYsgGP3NvqtS1pbeFP7C1NdB4=;
        b=T/+2muqng3f9DaL5YSppsLL1OTt5Moyujv5Fskvh6jvSqL76fyKbCfwZdWIvfUAg5f
         5Oeyllz677PfMaYlFJ7tfQCWliG9CLTimYecpufYXNko4JSpO8dKBcIaqHKcvoR9ITPG
         XQ82ehJyM/YGPLV4T39vK2R38cKCclhMP9V5B2hNYnL2PndOsVF0VVBH8noJK+KJ4179
         dMfJIwuNIlW9E7siOVR666jVmq7hBtmgx0lE+9CAxgbeJDzmYnuHm8JSaFFVRFc2tw7B
         IgWRD5zAYpFZXK+vEB7aCM9mx1WyQQJBkGtmYsMZ5P6YWDpJ1PQXulFu3XTJzQoPh/gz
         6ksA==
X-Gm-Message-State: AC+VfDzpJTIa9EMRvcPHkf5ukk+3RjXMzXB9PxGVfAkCrDKKaGicND6B
        UDvjLTixw79PqKmcgc11apsbuA==
X-Google-Smtp-Source: ACHHUZ78m2M5tE5jpv+rwYG3SAlrmdD+zDGd/jaO1XR7cT0JZ0zTL6vv1jqQmba7Zz/VDSb2F5e/nA==
X-Received: by 2002:adf:e40f:0:b0:30f:fec1:ac0a with SMTP id g15-20020adfe40f000000b0030ffec1ac0amr18644032wrm.39.1687444144884;
        Thu, 22 Jun 2023 07:29:04 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id w18-20020a5d6812000000b0030ae69920c9sm7168361wru.53.2023.06.22.07.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:29:04 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 22 Jun 2023 16:28:59 +0200
Subject: [PATCH v3 1/4] dt-bindings: input: document Goodix Berlin
 Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230606-topic-goodix-berlin-upstream-initial-v3-1-f0577cead709@linaro.org>
References: <20230606-topic-goodix-berlin-upstream-initial-v3-0-f0577cead709@linaro.org>
In-Reply-To: <20230606-topic-goodix-berlin-upstream-initial-v3-0-f0577cead709@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>
Cc:     linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3093;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=sfk9uxvNPIwk9f8d5iBn9m2N4nTZgMQFpRmAil1gnVU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBklFqtTUjH9+wzYqPrZYY1Vs3xhhH0RphBGNEZnQI0
 /05NwSeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJRarQAKCRB33NvayMhJ0ROcD/
 0Y88hwPf9TpHRCrZ/XEZLaK9rGrB9dyzx/mI/DyQmjsjCk9jeC2BTZGmHEWhhmJIAvKEmr54l3dKWG
 GvZWT0mx3xpdvDFB4+yXVaPO1hX8pc38/pan8ipWgUoYaVqaUqu3DbGEdGjmfSBBBwyG+3Zq1Am1M6
 g6qRV6JjhdJMNyYaTc4MLqljqVKCwJUsAmssWATW9hWZmLz+mHueqPvPoGYbT6h2xJXhsqSFv0Ux2m
 VCPLyxYMCHS+XgS3jz/4B8MlCahRPpKTyLWNuohEncNDfXPl9ix4CrYRpOHjMLNO3kfWOyU20Ezjuo
 Ki6GLe1IDdg9PVdBjQb5mE7K+umxfwUsXKzuuSKBkUcB2DPOqplnOL9yF9Ku+glG2uyUaYaG8JZnLu
 VNI9WxQubHFqJ5RTwvgrYxjtfvcp9x2Aqywc4Fk83ogeQZn6kb+uhi6Sb1W7KfMHs0f9YEPbop0B/T
 nTSV2tQEoqVyDz/ACM2ASTWILiMkwpkn/geNDM7AkvL5dYcNKns8nu66cYXOlp+iq4gowrjgG1XnwO
 2tPLcoXNjLKDKOyhRuhQdIetwnQwnJOnJFR/8CZ8nKeygVSwiRCR0FFKptKphcH7naTKvjolh2m6WA
 /KU11rULHywEHf5jgl/7QQH/ljEkrYG24LHVKoZkDDd8rSskZZQcCzH0eAcA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Goodix GT9916 wich is part of the "Berlin" serie
of Touchscreen controllers IC from Goodix.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/input/touchscreen/goodix,gt9916.yaml  | 95 ++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix,gt9916.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix,gt9916.yaml
new file mode 100644
index 000000000000..d90f045ac06c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix,gt9916.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/goodix,gt9916.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Goodix Berlin series touchscreen controller
+
+description: The Goodix Berlin series of touchscreen controllers
+  be connected to either I2C or SPI buses.
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+allOf:
+  - $ref: touchscreen.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - goodix,gt9916
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
+  avdd-supply:
+    description: Analog power supply regulator on AVDD pin
+
+  vddio-supply:
+    description: power supply regulator on VDDIO pin
+
+  spi-max-frequency: true
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
+  - avdd-supply
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
+      touchscreen@5d {
+        compatible = "goodix,gt9916";
+        reg = <0x5d>;
+        interrupt-parent = <&gpio>;
+        interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+        reset-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+        avdd-supply = <&ts_avdd>;
+        touchscreen-size-x = <1024>;
+        touchscreen-size-y = <768>;
+      };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      num-cs = <1>;
+      cs-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
+      touchscreen@0 {
+        compatible = "goodix,gt9916";
+        reg = <0>;
+        interrupt-parent = <&gpio>;
+        interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+        reset-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+        avdd-supply = <&ts_avdd>;
+        spi-max-frequency = <1000000>;
+        touchscreen-size-x = <1024>;
+        touchscreen-size-y = <768>;
+      };
+    };
+
+...

-- 
2.34.1

