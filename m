Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6C474ACBB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjGGIU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjGGIUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:20:55 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7600B1FEF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 01:20:51 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc54cab6fso16698065e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 01:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688718049; x=1691310049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOphSGoCqT9615GltEcFI+ATbigEMUQ3m4Ic264wJ18=;
        b=Gew4k+V0z9BN5NjFkuzGK1x7pdLIB2nyR2uEd2h6l6ii86d6qE9DzAQnbJneLvL1C+
         w0fX7+Dy1N47pfNcz0nl80hin+lhpP1KqURqs74dBq/4Wp8B9bA8Qwsw9qKD3pZ5yBqZ
         wdzadJQNafUD6BRe41telXv73hytM1ZezSK/NHcUYZwCSG7H17rbmiyF0EDfSxj1gVox
         sSbUcdoodLNCa+TmahFWvvh5XAIRhL4W2hh4+A1F5A5DC78ff2x9vk4/oRonP9HV/597
         JTiQwr58yPClItu1g2C9o9+DyCNJ8tsEgiVGkaqX0aj3YImx7V1W0Q3cwEQ+rSz0meI8
         nGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688718049; x=1691310049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOphSGoCqT9615GltEcFI+ATbigEMUQ3m4Ic264wJ18=;
        b=hVCxxtGOh2S5zamfNnSyBQu92fMUkR+lKHD1D4Ln4a3i6oV5brGOBn8a1Me8usKvlN
         sFfzo37ZltJYZRZ3Mg3PzJa3XNSv9Iy4p4wB6939clqXGLo/F0Hkz4NFHNZ6ARtIdXmV
         pZ5h4l+FgkcAHzOSkgTk3VAGv8GH8z2MfpP8GBUlrdaYzKl/qVTjVJDPD2oYjEKcV6nJ
         e3wzAUHbAuZTxgy60na6GX6vYaSua9YE7bZfIndS6+COI4XIgzQJ8sCBk/i0yaaEqQiQ
         2NSC7coWM0a27fWU4mPCWzUGep/K7Mztg+nSGELvXHelQOCZng/LaQXXGups694li4Q/
         NIxw==
X-Gm-Message-State: ABy/qLZCKNjAVcV8jjXDtYq5CzjEd0lF/lARfeq1ZUev1+qmppcoACcj
        p6EFOdRHW1x8nAVXyCo+KipEWA==
X-Google-Smtp-Source: APBJJlEDsfl+FZf6AgDHLFZ3DivOlzLtLq/U56dHHA8AvdbrFyq4W5RG2DSt1dLEruLN9tNeZw1DXw==
X-Received: by 2002:a1c:7410:0:b0:3fa:984d:7e9f with SMTP id p16-20020a1c7410000000b003fa984d7e9fmr3425895wmc.6.1688718049549;
        Fri, 07 Jul 2023 01:20:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id a5-20020adffb85000000b00313e4d02be8sm3824395wrr.55.2023.07.07.01.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 01:20:49 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 07 Jul 2023 10:20:44 +0200
Subject: [PATCH v2 1/2] dt-bindings: pinctrl: amlogic,meson-pinctrl: allow
 gpio-line-names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230707-topic-amlogic-upstream-pinctrl-fix-bindings-v2-1-2160060446d7@linaro.org>
References: <20230707-topic-amlogic-upstream-pinctrl-fix-bindings-v2-0-2160060446d7@linaro.org>
In-Reply-To: <20230707-topic-amlogic-upstream-pinctrl-fix-bindings-v2-0-2160060446d7@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3911;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=8cLAB23xsx5JAWFJT8tVpclgqbE6cQYK7di1wlZX13Y=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkp8reH9NWBf+ukHsmyNlskNR0cEku39S9jIRN44L0
 WYb9QLaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZKfK3gAKCRB33NvayMhJ0RuKEA
 DJaMsgfIqACtdmvh4bGxTDGbuPyRKBO6MBJseIYkyvA9dtFpjULKm/KW/p8zVITCiuWqfIF/qbosBu
 KnYfxfwBYoeXxQtmHdkWq8TR0SsSFdktU7Mk4SUHtFA0xUVQNxG7jw2tbrDM/3oHgBghzYz3OvCW47
 7j0T/vd3PtEWYgMAv/6Pm8930oXGDeICpfFRPuVt1XoP0MTSQOvRLk+Nj/dTFyqGo9c0BcB/Ei2Ftn
 Xd/t+8l79OgUfGWpskJy17J0YlfYBbbiZMMMYRpHkuRT30FSrYYobbP0VP/Y8WGMtW/jKrdqwNH6Af
 6gGMR38+F/daLDtIRkuOxNdLEcTKdVx9jmSuyUE53WaLR3nRReDfIRu9LFDlguoOInkFLSXslrOD9h
 KnS8Dg5G/gw1YwgtDOQwjXPBPTXve+BbJcDFuCfFXFC/wAUdgkqgk66CGqYfNLiLmbEFiEFa4QZDUV
 v99z3/aSaZJVNItL9OxL3jr9+3VcW3hU3Q+Zl8k5lf+6mpHAhClLfQpQR8ahpeSKYkbbNnnJkPpHR2
 jEBF5YRxLQte8Y7lFmYFXoB8fqSoQFpRcu7Dmex/TFuGhW+cfsM3B7NvMFaGC9ulF+bSsYjrETiJyw
 D09dP9NwVYci8vgT2KbvgK5KrECFebn4BN7SbXakBBZU5kn6gPFy7y+WY9rA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow gpio-line-names property for the gpio subnodes.

Fixes: 94df03a45276 ("dt-bindings: pinctrl: Convert Amlogic Meson pinctrl binding")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml         | 4 ++++
 .../devicetree/bindings/pinctrl/amlogic,meson-pinctrl-g12a-aobus.yaml | 3 +++
 .../bindings/pinctrl/amlogic,meson-pinctrl-g12a-periphs.yaml          | 3 +++
 .../devicetree/bindings/pinctrl/amlogic,meson8-pinctrl-aobus.yaml     | 4 ++++
 .../devicetree/bindings/pinctrl/amlogic,meson8-pinctrl-cbus.yaml      | 4 ++++
 5 files changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml
index 99080c9eaac3..4cee220ab652 100644
--- a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml
@@ -36,6 +36,10 @@ patternProperties:
           - const: mux
           - const: gpio
 
+      gpio-line-names:
+        minItems: 62 # A1
+        maxItems: 82 # S4
+
 unevaluatedProperties:
   type: object
   $ref: amlogic,meson-pinctrl-common.yaml#/$defs/meson-pins
diff --git a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-g12a-aobus.yaml b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-g12a-aobus.yaml
index 7c9c94ec5b7b..0942ea60c6cd 100644
--- a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-g12a-aobus.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-g12a-aobus.yaml
@@ -36,6 +36,9 @@ patternProperties:
           - const: ds
           - const: gpio
 
+      gpio-line-names:
+        maxItems: 15
+
 unevaluatedProperties:
   type: object
   $ref: amlogic,meson-pinctrl-common.yaml#/$defs/meson-pins
diff --git a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-g12a-periphs.yaml b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-g12a-periphs.yaml
index 4bcb8b60420f..e3c8bde30559 100644
--- a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-g12a-periphs.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-g12a-periphs.yaml
@@ -38,6 +38,9 @@ patternProperties:
           - const: mux
           - const: ds
 
+      gpio-line-names:
+        maxItems: 85
+
 unevaluatedProperties:
   type: object
   $ref: amlogic,meson-pinctrl-common.yaml#/$defs/meson-pins
diff --git a/Documentation/devicetree/bindings/pinctrl/amlogic,meson8-pinctrl-aobus.yaml b/Documentation/devicetree/bindings/pinctrl/amlogic,meson8-pinctrl-aobus.yaml
index 32d99c9b6afc..c1b03147e8ec 100644
--- a/Documentation/devicetree/bindings/pinctrl/amlogic,meson8-pinctrl-aobus.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/amlogic,meson8-pinctrl-aobus.yaml
@@ -44,6 +44,10 @@ patternProperties:
           - const: pull
           - const: gpio
 
+      gpio-line-names:
+        minItems: 11 # GXL
+        maxItems: 16 # Meson8
+
 unevaluatedProperties:
   type: object
   $ref: amlogic,meson-pinctrl-common.yaml#/$defs/meson-pins
diff --git a/Documentation/devicetree/bindings/pinctrl/amlogic,meson8-pinctrl-cbus.yaml b/Documentation/devicetree/bindings/pinctrl/amlogic,meson8-pinctrl-cbus.yaml
index d0441051f34a..4ec85b8248fa 100644
--- a/Documentation/devicetree/bindings/pinctrl/amlogic,meson8-pinctrl-cbus.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/amlogic,meson8-pinctrl-cbus.yaml
@@ -45,6 +45,10 @@ patternProperties:
           - const: pull-enable
           - const: gpio
 
+      gpio-line-names:
+        minItems: 86 # AXG
+        maxItems: 120 # Meson8
+
 unevaluatedProperties:
   type: object
   $ref: amlogic,meson-pinctrl-common.yaml#/$defs/meson-pins

-- 
2.34.1

