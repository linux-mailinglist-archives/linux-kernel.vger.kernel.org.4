Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF876A8DFF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCCAan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjCCAah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:30:37 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF2259E70;
        Thu,  2 Mar 2023 16:30:12 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id h9so776813ljq.2;
        Thu, 02 Mar 2023 16:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677803411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ct2y6EoMrN+HJxQD2RfUFZp0XRCxO4iCVehUYgYijVs=;
        b=FwM7QY25lZengJrJwyQSjL5E6EosTaG/+eugSo4UGZwRYY8gKfpS9IxSeMotKhKENz
         biglUWtHjccGIf9oq0UngdlPPqw1v/YPEobXNbQ+ZgSjR0EzCtHX3pkszkI+g5JKCm0R
         yJWwrt0BmYv9MBtO1HPmDRBY5Qi1EjFNSSAYUbCnfmpUN87UC3QSwWkTpRYmWhsQ7HTo
         hdg8QBpC9f3W+dZ5Q3q9x9tcGaI02jQW8LxIzA7n/QhHDJpZB7RGt+KR+sw5MkXN1ycr
         m377JWoET6qxAf4D+0mrGk2Z91C8B0BUWMh6FMnyPgBXBf3KErnTXdBx0fQIGyn8NGEj
         Gr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677803411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ct2y6EoMrN+HJxQD2RfUFZp0XRCxO4iCVehUYgYijVs=;
        b=vtid0BHQuEdf/cUkihyUt025qqvFj/AK0QKx1BmXP49rx3J3Mqj7Yy6rjzvvTnrBWv
         L8inydqxYJQFNJnWzYaTh8XRlbf3FINqaMk/Ay8j/yDFlNOBkDuJIJMX7cV0eR1krM++
         5AYcLmz/kokgAtHhyARqKckYAelMRwn+UMuinyQCcv0AGM/+S2Uotobroc20d/rJjns9
         +LWGaCUPryfMocqebPFIOzimZ8fgC3FK4lRt3HiDrrPbFmS/XwuZXOFO/qgnLecz13u1
         r5tf2j0a+o0Yb8E5RD3pzZwoUytcg9yBAZbKMHUD0ZdzASYD7hsYy4kLzZvKaM/iP/TP
         SBFQ==
X-Gm-Message-State: AO0yUKUqUUE15y8MlChVVKCU4Vztzzi9TtobtxZjGTX0wBkdQeeXibYf
        GdzSLlgJZ8rUq7nAwMtfw0E=
X-Google-Smtp-Source: AK7set+7dqKolQq1dLdyJinry05b+SRKAJDd4GYsDcYXoX757fWcDh/aP+KdZ3FWHQIOUWKVHYhvDw==
X-Received: by 2002:a2e:7810:0:b0:295:94f4:c22c with SMTP id t16-20020a2e7810000000b0029594f4c22cmr3635070ljc.49.1677803411429;
        Thu, 02 Mar 2023 16:30:11 -0800 (PST)
Received: from arinc9-PC.lan ([212.68.60.226])
        by smtp.gmail.com with ESMTPSA id v19-20020a2e9f53000000b002932b817990sm64901ljk.31.2023.03.02.16.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 16:30:11 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Subject: [PATCH 08/20] dt-bindings: pinctrl: ralink: add new compatible strings
Date:   Fri,  3 Mar 2023 03:28:37 +0300
Message-Id: <20230303002850.51858-9-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230303002850.51858-1-arinc.unal@arinc9.com>
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Add the new mediatek compatible strings. Change the compatible string on
the examples with the mediatek compatible strings.

Add the new compatible strings for mt7620, mt76x8, and rt305x to be able to
properly document the pin muxing information of each SoC, or SoCs that use
the same pinmux data.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml | 7 +++++--
 .../devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml | 6 ++++--
 .../devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml | 5 ++++-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
index cde6de77e228..a94d2e7a5f37 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
@@ -17,7 +17,10 @@ description:
 
 properties:
   compatible:
-    const: ralink,mt7620-pinctrl
+    enum:
+      - mediatek,mt7620-pinctrl
+      - mediatek,mt76x8-pinctrl
+      - ralink,mt7620-pinctrl
 
 patternProperties:
   '-pins$':
@@ -646,7 +649,7 @@ additionalProperties: false
 examples:
   - |
     pinctrl {
-      compatible = "ralink,mt7620-pinctrl";
+      compatible = "mediatek,mt7620-pinctrl";
 
       i2c_pins: i2c0-pins {
         pinmux {
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
index fb8c5459ea93..eb0746cfc6d6 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
@@ -17,7 +17,9 @@ description:
 
 properties:
   compatible:
-    const: ralink,mt7621-pinctrl
+    enum:
+      - mediatek,mt7621-pinctrl
+      - ralink,mt7621-pinctrl
 
 patternProperties:
   '-pins$':
@@ -250,7 +252,7 @@ additionalProperties: false
 examples:
   - |
     pinctrl {
-      compatible = "ralink,mt7621-pinctrl";
+      compatible = "mediatek,mt7621-pinctrl";
 
       i2c_pins: i2c0-pins {
         pinmux {
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
index 8b1256af09c3..23fb82f9959c 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
@@ -18,7 +18,10 @@ description:
 
 properties:
   compatible:
-    const: ralink,rt305x-pinctrl
+    enum:
+      - ralink,rt305x-pinctrl
+      - ralink,rt3352-pinctrl
+      - ralink,rt5350-pinctrl
 
 patternProperties:
   '-pins$':
-- 
2.37.2

