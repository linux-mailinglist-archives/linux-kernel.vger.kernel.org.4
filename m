Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CACE5F7884
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiJGNAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJGNAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:00:04 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D883B96E;
        Fri,  7 Oct 2022 05:59:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b7so7184403wrq.9;
        Fri, 07 Oct 2022 05:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1F79IzwZ0dMUZFmXlU+IVgVaLT58myI+Xc67kDLiY10=;
        b=A2Xi2NTEpbov6ZIgp+ERPzG9qWa15tijCWRiH7Wfh9oKVDTKOp0xTJvWoAp/jUg6Yt
         pKJkLks/8c0RqZPB06qFmsBeD1gmkp88pm+nJK7v7vV2su7KOj60HvBa8ypWMoH+uIX/
         VQh86hDXJRIwRh9rWi8J1MrCJ7BJFs3narIghlApzg9XMu13SGx//jsu8GPfYBqF47r9
         Mka7TYkyIpyF0eL0QfmYpc7qAoH74Vg3ro/8ORL3T5JrPHgWYfGUnGPcpFg7FGIQahn2
         0xNDQ394JoIlEHU3UKOGR53XyCqh+CL2osmcZ1ATiH9n7uZcrgH+ovacQQRIWxbFRfGn
         QqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1F79IzwZ0dMUZFmXlU+IVgVaLT58myI+Xc67kDLiY10=;
        b=HupR0w1JRNHhR/Ubg7wPgH0p1GCR0OnE0kkY/sn/9nlxV0FpHoMYoBFllC6bROZo0b
         p4KGJ9osMY0ggHrByg7QY4fhmPcgnsPM88ej+IxL1w6ffcL1vKx7LmpWJOnrkCjb8vwc
         AqW/nTjUrYRYKeXIKEn9K9ny+4LvVifwLPun9sotLiGRfeyDHNWNfvLKhpVpy7rBDji1
         51XsdCia89dDByODyW0gsJFy6hIJlUJjcdmY295kTqE7IjI56Je0JWqz2YDb6/Oz+Ycq
         2QkhdfEGIArqheImIVlbklJUY6CU6pzcpXCMUURh0IFrUhDz4c0BGPlRkeutLBQqidrU
         0DZg==
X-Gm-Message-State: ACrzQf1esFreGl5nL2vq9gKSuVocOdEHgSrZ10RpQj1POf4NNtyXKWal
        twC4VrguHOfW6KpMpJcForM0I2oGUsf84g==
X-Google-Smtp-Source: AMsMyM7GbVQ5uWE91PfjMJq48KJe96DTnrSw1mHq8WiQ7dgsi6oeCBQRUCLBNzx+Cg5gVVxfANHK6w==
X-Received: by 2002:adf:fe0f:0:b0:22e:482b:b63a with SMTP id n15-20020adffe0f000000b0022e482bb63amr3077205wrr.586.1665147591145;
        Fri, 07 Oct 2022 05:59:51 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id i15-20020adffdcf000000b00223b8168b15sm2008243wrs.66.2022.10.07.05.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 05:59:50 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 09/10] dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Document MT6735 pin controller
Date:   Fri,  7 Oct 2022 15:59:03 +0300
Message-Id: <20221007125904.55371-10-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221007125904.55371-1-y.oudjana@protonmail.com>
References: <20221007125904.55371-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add bindings for the pin controller found on MediaTek MT6735 and
MT6735M SoCs, including describing a method to manually specify
a pin and function in the pinmux property making defining bindings
for each pin/function combination unnecessary. The pin controllers
on those SoCs are generally identical, with the only difference
being the lack of MSDC2 pins (198-203) on MT6735M.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 46 ++++++++++++++++++-
 MAINTAINERS                                   |  6 +++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index 71a9aae2cc8c..7b120803a1a5 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
@@ -10,6 +10,7 @@ maintainers:
   - Andy Teng <andy.teng@mediatek.com>
   - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
   - Sean Wang <sean.wang@kernel.org>
+  - Yassine Oudjana <y.oudjana@protonmail.com>
 
 description:
   The MediaTek pin controller on MT6779 is used to control pin
@@ -18,6 +19,8 @@ description:
 properties:
   compatible:
     enum:
+      - mediatek,mt6735-pinctrl
+      - mediatek,mt6735m-pinctrl
       - mediatek,mt6765-pinctrl
       - mediatek,mt6779-pinctrl
       - mediatek,mt6795-pinctrl
@@ -63,6 +66,33 @@ required:
 
 allOf:
   - $ref: "pinctrl.yaml#"
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt6735-pinctrl
+              - mediatek,mt6735m-pinctrl
+    then:
+      properties:
+        reg:
+          minItems: 8
+          maxItems: 8
+
+        reg-names:
+          items:
+            - const: gpio
+            - const: iocfg0
+            - const: iocfg1
+            - const: iocfg2
+            - const: iocfg3
+            - const: iocfg4
+            - const: iocfg5
+            - const: eint
+
+        interrupts:
+          items:
+            - description: EINT interrupt
   - if:
       properties:
         compatible:
@@ -312,18 +342,32 @@ examples:
             };
 
             /* GPIO0 set as multifunction GPIO0 */
-            gpio-pins {
+            gpio0-pins {
                 pins {
                     pinmux = <PINMUX_GPIO0__FUNC_GPIO0>;
                 };
             };
 
+            /* GPIO1 set to function 0 (GPIO) */
+            gpio1-pins {
+                pins {
+                    pinmux = <(MTK_PIN_NO(1) | 0)>;
+                };
+            };
+
             /* GPIO52 set as multifunction SDA0 */
             i2c0-pins {
                 pins {
                   pinmux = <PINMUX_GPIO52__FUNC_SDA0>;
                 };
             };
+
+            /* GPIO62 set to function 1 (primary function) */
+            i2c1-pins {
+                pins {
+                    pinmux = <(MTK_PIN_NO(62) | 1)>;
+                };
+            };
         };
 
         mmc0 {
diff --git a/MAINTAINERS b/MAINTAINERS
index 184519342e45..edcb30842ddf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16287,6 +16287,12 @@ F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
 F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
 F:	drivers/pinctrl/mediatek/
 
+PIN CONTROLLER - MEDIATEK MT6735
+M:	Yassine Oudjana <y.oudjana@protonmail.com>
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+
 PIN CONTROLLER - MICROCHIP AT91
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.38.0

