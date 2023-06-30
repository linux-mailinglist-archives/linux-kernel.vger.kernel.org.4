Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67F574408B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjF3Q71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjF3Q6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:58:50 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF393593
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:58:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fa8cd4a113so22096805e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688144326; x=1690736326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YODS5EdidiMqfLgv+cP+/rbRFBcpTpOT0mtC9T2xjaQ=;
        b=dA2yCv2NZ72e+wHH9SORhU04cJvJPzsV6as6SCcKplgrM/qbmCh0lwzaHw9dUXaL6b
         mcGptOvELZ+aB8LWxO+IVF6U3kvxAWhsltw/B1PHXOVWpWLMcChUcBLLlhX5ljIP/duB
         cUe3X89BZMnACgmde0D+xGTgdf4AgI+VX5eRY5lyG7AsR3BbJ+YHGSqpG4UX3tGEEmc3
         PcTRBxHt9h40rEpd4f2UJi7bOF8MIHnl/X+u31AivrVCBh9urFQ7+UaQrZY07I8rFs9s
         DuNjry4zxdY0x6eZNraAjT3GQqP6XTAoJ6rnCOHRWPhC3rRsCMZerfuBQlGKgmOViVP7
         zGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144326; x=1690736326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YODS5EdidiMqfLgv+cP+/rbRFBcpTpOT0mtC9T2xjaQ=;
        b=GTSQyRydXbhzxqdxpl8fFS6L80ROsrNiizX+HfUHJQllel0RcU/ILqioHo3cQ3+bGv
         YsDl7q5Iwiv7WZZOG8MeZNw0aB/wQJX5Tv/Yg3ftFNgA/AFcCrlMbgxkQ5qzqRy1qXuN
         ddf44TzFpusj1zyt8duoftOGj/UQYcyTXKL1Su/70qT3yiUDiDr02Z27cvP8A/PTNANe
         OJM+B7HOMCxvtbrzCdxUw4JrinCp3EIDeWujyZy7iMFyYcsIji3m1/kz4bsYXGaCQxqn
         fMz3vYVrnd5K8NM/TzXwdbvYCEUG4FUglb4YXU3aH/TD0XfYgCe2d2OLn4S/EU+tOBOv
         3iXg==
X-Gm-Message-State: AC+VfDwxJlGIhBFwQOfmkgPwWhO0EknDxTYdPYboy6eJfP0xSc1pSsoA
        /STW56Cc7C4fqvKy8y3KVKFBoA==
X-Google-Smtp-Source: ACHHUZ7LMrMA78ocv3Tff31XW7n3ukSVcuxlhHrPo8yNKeKKvHDiMykie0NMER5g/1Kygz1grYs10w==
X-Received: by 2002:a05:600c:2243:b0:3fa:9d0f:f1e1 with SMTP id a3-20020a05600c224300b003fa9d0ff1e1mr2902423wmm.35.1688144326214;
        Fri, 30 Jun 2023 09:58:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdb8e000000b003112ab916cdsm18913772wri.73.2023.06.30.09.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:58:45 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 30 Jun 2023 18:58:31 +0200
Subject: [PATCH v2 06/15] dt-bindings: mtd: oxnas-nand: remove obsolete
 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-topic-oxnas-upstream-remove-v2-6-fb6ab3dea87c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=38rvOQ5JzytmoL2e8XQMRnUMzYw1/Raq4YBpYNRm4dw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBknwm2BW8UwSX3d9Pq718ni0310vOQ0HNcYv2IvLHm
 CF9ZdzKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJ8JtgAKCRB33NvayMhJ0Z6yEA
 DQB8ET5EMV67bFiwvw6CHMW/yDZltqA2FQRkT6U0VMXkLspqXbvM5YCSVAJhE0aCOEuSp86cn+sn6B
 fWYyhHNqZR/5Y90GsYVlPN/uNgiwV7djdZJcv8Hr7dPiSDl9hpicmk/oMOjbbFk2/KsZEk4/D8hL52
 m4IUWBoCJlfxhDkSxtZFzKva3EJAGRdSXqKgBs6YFkjMklmRCCde69vPew6/N3svQGqbofvbgY1pcx
 qEn3jwLXNAv/R3f8+pMwEnhekYBxCSGhJZ0QKi2x1b4NC2YUnXjuF96hUl5KnjeNbekLihkL+Zixgl
 qNIiEuLWuFXKNCqbzpVgy3DM+VAkjyQ42Hc3PG31OYbYWTnLSrdi9m4LOcuBUEcETWUuBEIdKz8qgn
 uIIfwD/QwhkEqppN4NSnquwiHhfE/O0qsSOVji2MLteguNXuK2nFacu8zRElULaoSvez4BkfP3E0Hx
 6Qk6g08mNZi9io9R1ZtfGcNJ59QnSZPgbu/iCZpDuGGufzmA0BMF7Hv9Y/aDSO51z947Gg9kG8gxD6
 5/7/Li9DDTGcigSq41lgglOTJqSnGHn/8GoZIqTpQyxBSiJa/VRJv0Fp6XxxEee8EmIUwV12YGJgmk
 xB17WN5EDw0VCkcayM+CD9hpDPnRn8ZJCsjJ3wabBHR4HQ8BcT8pvuxHAm5A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to lack of maintenance and stall of development for a few years now,
and since no new features will ever be added upstream, remove the
for OX810 and OX820 nand bindings.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/mtd/oxnas-nand.txt         | 41 ----------------------
 1 file changed, 41 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/oxnas-nand.txt b/Documentation/devicetree/bindings/mtd/oxnas-nand.txt
deleted file mode 100644
index 2ba07fc8b79c..000000000000
--- a/Documentation/devicetree/bindings/mtd/oxnas-nand.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-* Oxford Semiconductor OXNAS NAND Controller
-
-Please refer to nand-controller.yaml for generic information regarding MTD NAND bindings.
-
-Required properties:
- - compatible: "oxsemi,ox820-nand"
- - reg: Base address and length for NAND mapped memory.
-
-Optional Properties:
- - clocks: phandle to the NAND gate clock if needed.
- - resets: phandle to the NAND reset control if needed.
-
-Example:
-
-nandc: nand-controller@41000000 {
-	compatible = "oxsemi,ox820-nand";
-	reg = <0x41000000 0x100000>;
-	clocks = <&stdclk CLK_820_NAND>;
-	resets = <&reset RESET_NAND>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	nand@0 {
-		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		nand-ecc-mode = "soft";
-		nand-ecc-algo = "hamming";
-
-		partition@0 {
-			label = "boot";
-			reg = <0x00000000 0x00e00000>;
-			read-only;
-		};
-
-		partition@e00000 {
-			label = "ubi";
-			reg = <0x00e00000 0x07200000>;
-		};
-	};
-};

-- 
2.34.1

