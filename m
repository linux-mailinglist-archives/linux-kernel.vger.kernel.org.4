Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD96C5F594E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiJERpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJERov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:44:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C58413D;
        Wed,  5 Oct 2022 10:44:33 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id iv17so11240794wmb.4;
        Wed, 05 Oct 2022 10:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=lscRy0kqbRlW0b48THWW28owt26qTsMSihJ3fUIxZUY=;
        b=dm+FXTm1drjKBIiUiGynmy74M31d22PsWkd+Eu83ZoPu8ZyT/zo1s7uwX3m53cN6/T
         h4pmgjD8zha3UMqYnP2xMHsgap7DxXXKFitSNnMkZbb84+8wyBg+j4PiKKGKU8uzMx/d
         ZJN2luqYskmFZF5Y6qukVlddLUedg5iXfUu5w/WZbsxofJtPRl37EN4aytjN7zfThdsq
         yiVgzZPbqUZvJfqoerKpXDZ/yIwxvGx5Cd1qqYYO61P4d5jGpA0gqLY3m9YYvZ1vvqH+
         3x0wzDgpsmPnGFS/LwJ/Zo5XzMSp+hD6H4Wsn75m99d3ckIUHItMuDPYBSkQpXXRnnL+
         qZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lscRy0kqbRlW0b48THWW28owt26qTsMSihJ3fUIxZUY=;
        b=VEeV6jihy9H/NJY4EVlSG8swYuQtCWxq7edSjD7wD00CiTP7+0Ren6ujrZNSwcZJPU
         7B6pXaNDjdbT2rcJNzesS5EatDzvnD3p0dMvjr7MorOSKaJkp2NUbxUFvdptXaH31glp
         50Pn7bAe/iNbc8ZKX6O2FqTCzO9TvOJW1LmKA8mEjcxWOZ14msx5yh+qQFpyCr6ML3Wg
         hgDM9AiDHjMX+g3bBLkuY4RZYotTDK26UY3/4VMxwnbcM02z3tdBLixdY3Lt8K8ccDIf
         6c6IUrDTMdOtECP9gV94kagxy0eT5aR1N8vlnfpvsXbBuJ1CRNcRjlfe9Oi3S0+xoiJb
         RUSQ==
X-Gm-Message-State: ACrzQf1qbWzLd8r2rI+diBgWbEubMGUaWpaWExqfvoLq51lQVbwF7gJ2
        XoBKyVAYafJPfX77RBTLA7EvZuoudI0hZA==
X-Google-Smtp-Source: AMsMyM7gMSPRnGGLPn0s0Ie3NRI7zqPoUfmcoYLowNb9nsGA6Qb53YMUMBxB53k30LSRftmcFD4BJA==
X-Received: by 2002:a05:600c:3d13:b0:3b4:be25:9236 with SMTP id bh19-20020a05600c3d1300b003b4be259236mr452110wmb.65.1664991871613;
        Wed, 05 Oct 2022 10:44:31 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id c6-20020a5d4146000000b0022a403954c3sm16075491wrq.42.2022.10.05.10.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 10:44:31 -0700 (PDT)
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
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/10] dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Document MT6735 pin controller bindings
Date:   Wed,  5 Oct 2022 20:43:42 +0300
Message-Id: <20221005174343.24240-10-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221005174343.24240-1-y.oudjana@protonmail.com>
References: <20221005174343.24240-1-y.oudjana@protonmail.com>
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
---
 .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index f10d1d5543cb..66a0178caa8e 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
@@ -18,6 +18,8 @@ description:
 properties:
   compatible:
     enum:
+      - mediatek,mt6735-pinctrl
+      - mediatek,mt6735m-pinctrl
       - mediatek,mt6765-pinctrl
       - mediatek,mt6779-pinctrl
       - mediatek,mt6795-pinctrl
@@ -61,6 +63,29 @@ required:
 
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
   - if:
       properties:
         compatible:
@@ -185,6 +210,22 @@ patternProperties:
               }
             };
           };
+          The MTK_PIN_NO macro can also be used to select a pin and specify
+          a function index:
+          pincontroller {
+            /* Pin 19 set to function 0 (multifunction GPIO) */
+            gpio-pins {
+              pins {
+                pinmux = <(MTK_PIN_NO(19) | 0)>;
+              };
+            };
+            /* Pin 172 set to function 1 (primary function) */
+            msdc1-pins {
+              pins-cmd {
+                pinmux = <(MTK_PIN_NO(172) | 1)>;
+              };
+            };
+          };
         $ref: "pinmux-node.yaml"
 
         properties:
-- 
2.38.0

