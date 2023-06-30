Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DAC7440A3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjF3RAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjF3Q7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:59:10 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5CA4497
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:58:56 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc244d386so16639265e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688144334; x=1690736334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLUKsP4vp/raKLTHtwvUFRJTqG/hdN77zosI8Yw2myw=;
        b=sVa5c1v/DkueUOCsS+MIb0EGouW76eY2gyfiQAQ4dSKuCyWJeA3bmBrQGzimmySJuV
         ZVoIoSrizM9pksB1Dl100COoWxOSVIdEUmsw3NH5eCfLyGUKi0XFhVF5U4lNd2oNuoGI
         E1NNYCk5HgtBo5I1sDgcdZ+iHACj6rVf1u6Hb18pHJv1QWD4WP1P8yFeUJ1xExTJugXL
         AUMNLcvs7hbekeaX5QrGQliSFPKvjFwhdHL0bQcwuSTxv2A7xsgHuDl2sBn8YtxqtlJv
         sySMd6ET4xfwk3ENv5SaF2DyQm0jF+J4vjCXZC9c5IxmIZQG1kr28S74KPLOlSrPp8M0
         uFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144334; x=1690736334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLUKsP4vp/raKLTHtwvUFRJTqG/hdN77zosI8Yw2myw=;
        b=cqgXcPdbo6KZM47X0k4n2RdKV5lEHZn+PTRY0sDvBx+odJJKhwwpJ8zZpRgxogulXD
         a7L06v+mj5CgBi50XfY2rVYcXbJZ7Co5vO+CGW+PHFD2ZI+Cm61BmM/rEqoBKPbZCGt8
         PTBEoQe+QegOu9Zt4gZMtLlZzk7yIIF8ATfuIGKPxRb5RX9Wig/psXAJZdfdXOAXxj7S
         H4dt5IxryVuaE91p/E/Kl6EavgAQf8zu+DoxajfKnWp4NIi/RA/PKzf/YKltpEUZ01Uo
         HUs/E10KjYIIIXzCAS425iZbuo1AuN/6GqX/5E7OXztMrvRxBOuSKWso083aW/yv2T/6
         PHxA==
X-Gm-Message-State: ABy/qLaVvU9GMl7fyWorANQa6EeIfTDmTyjG2WJaUX4DH611PGUg/rki
        B91RZfCf5vWiSRGuBr89IMLB+w==
X-Google-Smtp-Source: APBJJlEza6koXpLRSzsJiwPWlR4i5LXfO4P/D0KmtkFikXar2B9xsTCDhnNIiFf4wc1a8fdVyS8ysQ==
X-Received: by 2002:a5d:4fc4:0:b0:313:ebf3:f817 with SMTP id h4-20020a5d4fc4000000b00313ebf3f817mr2423330wrw.22.1688144334391;
        Fri, 30 Jun 2023 09:58:54 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdb8e000000b003112ab916cdsm18913772wri.73.2023.06.30.09.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:58:53 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 30 Jun 2023 18:58:36 +0200
Subject: [PATCH v2 11/15] dt-bindings: gpio: gpio_oxnas: remove obsolete
 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-topic-oxnas-upstream-remove-v2-11-fb6ab3dea87c@linaro.org>
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
In-Reply-To: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-oxnas@groups.io,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Golle <daniel@makrotopia.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2380;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Dz983lZEvCc6SwFVyqblurV6ZIa65HUG1Xc2A0bqn7M=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBknwm4wJTRSSerqNYfifwQ1Pt541qqx0tcBG6P43WV
 xd4i9FuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJ8JuAAKCRB33NvayMhJ0XPgEA
 DCjZvFC0V3ejPt1N0/o80mIHNA0zrhPM/j3UrO6bINU5AQsXNX1xP2zjlRpgKhTOC9Kry0IhDZCdD5
 WL0T2vk+BI+Va3NzwJv213/b8bECOoXLNNE6WIquR51sKxTq3iexFaN7SAKORBYZWNzJpqTfu/41Nt
 DliCF/6SErEstzu8aItxlKrfbuLYcgjaDIkLnrP9zxkcxTu21ZPLY1vD57YMLHZSxik4e/3FGMbWpp
 2Pg+BIVRh/IH00JwzMSdBgAzumU8ANPQGXe3ATTr+xDKPk+WJpNXQXOYpUhyYjLs1QNGZ3MPP7YZde
 iUEmJ9HxUiOQaiyDcISadusL+ObaqjGz3rTFmir3Jexj5wGgO2FKcNgDcCAJCoxMMGrw1WKLpTUgH2
 8HVN1jqaV/0baqMaKlTovePXtHWdHYjASjVeY/bTjirRqJT4RPeGlIvE2FsUcTduyhLiw6IxTOWLhK
 lva9N1TCBRTx3PwzlP1zZ7ufAI1cvHH9mCe9VRBdYBzijNZwC5jid2xpGyQ7npRA8Yycw1QIhlmgvM
 JsNmLwe8dqD3EaBFMKqL/dcMmG6IQDXcKoGIqtYV43O9odb5ReKfMRJM81olt8ArfGto80z6Vsp8a7
 27w7UeMv8YbkcGD1lOGEjg0PMpq1jqZEhb47IOLUWfNsGXYGW1BOJamnxHXw==
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

Due to lack of maintenance and stall of development for a few years now,
and since no new features will ever be added upstream, remove the
OX810 and OX820 gpio bindings.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/gpio/gpio_oxnas.txt        | 47 ----------------------
 1 file changed, 47 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt b/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
deleted file mode 100644
index 966514744df4..000000000000
--- a/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-* Oxford Semiconductor OXNAS SoC GPIO Controller
-
-Please refer to gpio.txt for generic information regarding GPIO bindings.
-
-Required properties:
- - compatible: "oxsemi,ox810se-gpio" or "oxsemi,ox820-gpio"
- - reg: Base address and length for the device.
- - interrupts: The port interrupt shared by all pins.
- - gpio-controller: Marks the port as GPIO controller.
- - #gpio-cells: Two. The first cell is the pin number and
-   the second cell is used to specify the gpio polarity as defined in
-   defined in <dt-bindings/gpio/gpio.h>:
-      0 = GPIO_ACTIVE_HIGH
-      1 = GPIO_ACTIVE_LOW
- - interrupt-controller: Marks the device node as an interrupt controller.
- - #interrupt-cells: Two. The first cell is the GPIO number and second cell
-   is used to specify the trigger type as defined in
-   <dt-bindings/interrupt-controller/irq.h>:
-      IRQ_TYPE_EDGE_RISING
-      IRQ_TYPE_EDGE_FALLING
-      IRQ_TYPE_EDGE_BOTH
- - gpio-ranges: Interaction with the PINCTRL subsystem, it also specifies the
-   gpio base and count, should be in the format of numeric-gpio-range as
-   specified in the gpio.txt file.
-
-Example:
-
-gpio0: gpio@0 {
-	compatible = "oxsemi,ox810se-gpio";
-	reg = <0x000000 0x100000>;
-	interrupts = <21>;
-	#gpio-cells = <2>;
-	gpio-controller;
-	interrupt-controller;
-	#interrupt-cells = <2>;
-	gpio-ranges = <&pinctrl 0 0 32>;
-};
-
-keys {
-	...
-
-	button-esc {
-		label = "ESC";
-		linux,code = <1>;
-		gpios = <&gpio0 12 0>;
-	};
-};

-- 
2.34.1

