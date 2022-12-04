Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AFB641C60
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 11:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiLDKne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 05:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiLDKnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 05:43:32 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01627E086
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 02:43:31 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f21so13435942lfm.9
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 02:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mkpnkgS661CL81tREqROjXb5VEYTJXJHdLfxFTagbbs=;
        b=eyNqK8ehsyoOUvVJLufQ4cBhyIoGEL8itAxijDj/69skdhojwUO9aEX6194hgAbilG
         JtUv8ryuYSlmJf79TOm7u+qaJxs4aRRX/zxOfIy3yYhYEokxgv0dLcRA5q75bFrs0NKi
         cMocSXaPOcjITs7K0srq4EJDfFi9snUEy7IPTe0V2cyuO4LagEwmpiiCOpKBffdCJeDU
         ObmRoXmP6xF5bA8iGaDaQK83wR9udl5gDBtquqoYSznoz6xMSJmTTWunRtp+/xx/K8ow
         MceG8sv0IlTallBvAADkCN/Je74E4AZgHL+QFRtcZ33T0UnYUxdR2BnUvjpdv2v+P9eD
         Jq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mkpnkgS661CL81tREqROjXb5VEYTJXJHdLfxFTagbbs=;
        b=Db2isWN/RYMYslm7bqlyjnOFTnWbthHbyV1w0UOO6TgEzPmLWWBqXeVYUEhL78QSea
         xTDgOw2BYTAd7HrcfE6K3pc5HUVIoXueZXnHNLT+/VPBggQZ6L+aiAj+lqRHenwf5iDo
         kicboKH+lyNcNDo3CA5bZBGmW781+d+3l+F+DfwBwRjll5keb5sjU/eXs+VapfLkU5ww
         ArIYnMg+DYP1/T39e7nFDLaRNwD4NGVW1r64/OO4DsZpLCBn9pZdEFg+mAIezbW/ODOm
         Cu7VlDZb/APV19CfdLDVVTxvBxUyic5xvjylJ9KzuYOYd0plB8MSBZUv6BhGJP1lAtxY
         /XTA==
X-Gm-Message-State: ANoB5pkLa8cSmDTEEAa2XN7A1Qo9U6yEZup9uvU/WvfJltIbwONtHBvA
        t7t7uf2Tu4DMoqUXRnSm58+nBg==
X-Google-Smtp-Source: AA0mqf6aMt0hHEGgulKA17NECqV5/ZqIGJZyzP3de5FpTiPlOrSIXDIMVOxunD7VvSXotiN0a3eqxQ==
X-Received: by 2002:ac2:5979:0:b0:4b5:7607:3191 with SMTP id h25-20020ac25979000000b004b576073191mr11601lfp.93.1670150609232;
        Sun, 04 Dec 2022 02:43:29 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w13-20020a05651c118d00b0026c42f67eb8sm893318ljo.7.2022.12.04.02.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 02:43:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Young <sean@mess.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] dt-bindings: leds: irled: gpio-ir-tx: convert to DT schema
Date:   Sun,  4 Dec 2022 11:43:21 +0100
Message-Id: <20221204104323.117974-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the GPIO IR LED bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/leds/irled/gpio-ir-tx.txt        | 14 --------
 .../bindings/leds/irled/gpio-ir-tx.yaml       | 36 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 37 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/irled/gpio-ir-tx.txt
 create mode 100644 Documentation/devicetree/bindings/leds/irled/gpio-ir-tx.yaml

diff --git a/Documentation/devicetree/bindings/leds/irled/gpio-ir-tx.txt b/Documentation/devicetree/bindings/leds/irled/gpio-ir-tx.txt
deleted file mode 100644
index cbe8dfd29715..000000000000
--- a/Documentation/devicetree/bindings/leds/irled/gpio-ir-tx.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-Device tree bindings for IR LED connected through gpio pin which is used as
-remote controller transmitter.
-
-Required properties:
-	- compatible: should be "gpio-ir-tx".
-	- gpios :  Should specify the IR LED GPIO, see "gpios property" in
-	  Documentation/devicetree/bindings/gpio/gpio.txt.  Active low LEDs
-	  should be indicated using flags in the GPIO specifier.
-
-Example:
-	irled@0 {
-		compatible = "gpio-ir-tx";
-		gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
-	};
diff --git a/Documentation/devicetree/bindings/leds/irled/gpio-ir-tx.yaml b/Documentation/devicetree/bindings/leds/irled/gpio-ir-tx.yaml
new file mode 100644
index 000000000000..5839d00c7089
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/irled/gpio-ir-tx.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/irled/gpio-ir-tx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IR LED connected through GPIO pin
+
+maintainers:
+  - Sean Young <sean@mess.org>
+
+description:
+  IR LED connected through GPIO pin which is used as remote controller
+  transmitter.
+
+properties:
+  compatible:
+    const: gpio-ir-tx
+
+  gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    irled {
+        compatible = "gpio-ir-tx";
+        gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index be71999cea73..25b7fbf09e7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8839,6 +8839,7 @@ GPIO IR Transmitter
 M:	Sean Young <sean@mess.org>
 L:	linux-media@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/leds/irled/gpio-ir-tx.yaml
 F:	drivers/media/rc/gpio-ir-tx.c
 
 GPIO MOCKUP DRIVER
-- 
2.34.1

