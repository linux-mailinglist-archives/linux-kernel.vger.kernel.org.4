Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351016BF3F9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjCQVbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjCQVau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:30:50 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903A1E20C1;
        Fri, 17 Mar 2023 14:30:35 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eg48so25308637edb.13;
        Fri, 17 Mar 2023 14:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imSdKESnCC1MBR2YzRMTFgBDDXfRknOlbZyCB5yh06c=;
        b=JpHfGble1mO+xcp/MJMztTDj9xhTtiLor+bYEdLI2j+CbiKfj6pQZajunr6s9uU9ud
         424aZrWQEiuUogLWsrw5kil7ZmeNWSuElQDYEFMwguMZs3/3auF6REcyjMSklXet3NHl
         bU4o8xEQCn3uXkOBxVLjSek+90M2CfqE7CWQZ8zuieX2lcrpU0mqWpB3IPR0et2ch0TW
         L55HOaHsPn+R8lQoEFI64bua6fYLJEk6jYpASKKQ19H/1WbEATMffqTal+IQDxMn1Ql9
         NHdskLK+huMK8f/opAunI1XLOsEGXXpGSGgSvea4UunYov3kOEAkgWL7Vy6Uan8zOxxM
         UO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imSdKESnCC1MBR2YzRMTFgBDDXfRknOlbZyCB5yh06c=;
        b=41Oi9GIjry+p/FjUaBfMn6Nrd8O7oQW8RBSZEAxQemtQm2gNKUeOp1iWmPTzSuKN4g
         2jYWLNgxKYZOGEgu9IjM8eBHYF09RN3HgV5iAMaXn2OjkusmxLEIZVbLuaNbMnTomjuG
         KWEwNvycTQvNLU+p0uER4Cxqyho8MhogskQku9PejJ8h15jvxePrXCOgjA7c6MR+YIZC
         CbuE4qxSeUlIvYG3Q2CIkSRFUYMYxyWGUo67RvlHVKr/kgiFJxOIOb4ZDII0yyY6dKar
         SbanFk/2mVGhhAe5h5l0hr20kMgJwDzQ5USTKnThVkJvovWSsb4MqMNBBWU7IWWMAXfy
         MJvg==
X-Gm-Message-State: AO0yUKUmB3KePcXubodi9INV8Xk3bK40N71xWXQtRAiezpnLWuyVRVcN
        R/kNqCvAKG9B3/qc/TN1t90=
X-Google-Smtp-Source: AK7set82qp1rlYyl24drBNGiPpp0eT3ew+aSiuh+pteB/kV4CuKFvgRKtmCOw/3Y7DBorEs2QKSR+Q==
X-Received: by 2002:a17:906:4704:b0:84d:4e4f:1f85 with SMTP id y4-20020a170906470400b0084d4e4f1f85mr638914ejq.59.1679088634214;
        Fri, 17 Mar 2023 14:30:34 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090651d300b0092b86d41dbasm1404683ejk.114.2023.03.17.14.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:30:33 -0700 (PDT)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Rob Herring <robh@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Subject: [PATCH v3 07/21] dt-bindings: pinctrl: ralink: drop quotes from referred schemas
Date:   Sat, 18 Mar 2023 00:29:57 +0300
Message-Id: <20230317213011.13656-8-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230317213011.13656-1-arinc.unal@arinc9.com>
References: <20230317213011.13656-1-arinc.unal@arinc9.com>
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

Drop the quotes from the referred schemas.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml      | 2 +-
 .../devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml      | 2 +-
 .../devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml      | 2 +-
 .../devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml      | 2 +-
 .../devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml      | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
index b25e0db77cb3..cde6de77e228 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
@@ -636,7 +636,7 @@ patternProperties:
                   enum: [i2c, spi cs1, uart0]
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
index 60f6273930f5..fb8c5459ea93 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
@@ -240,7 +240,7 @@ patternProperties:
                   enum: [wdt]
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
index 4f3e0af7d18f..e51667316b2e 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
@@ -120,7 +120,7 @@ patternProperties:
                   enum: [pci]
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
index 9e45d851def6..8b1256af09c3 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
@@ -253,7 +253,7 @@ patternProperties:
                   enum: [spi_cs1]
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
index 4bea19d4ad7b..adc4f42a175d 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
@@ -240,7 +240,7 @@ patternProperties:
                   enum: [uartlite]
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
-- 
2.37.2

