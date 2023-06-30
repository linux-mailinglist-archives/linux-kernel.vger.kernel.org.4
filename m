Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73462744088
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjF3Q7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjF3Q6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:58:47 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ED03AAF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:58:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc54caad5so12815465e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688144322; x=1690736322;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JVDS79vqXqLudHPBY/MpaILvHVSubmD2fEfcAB2sjFc=;
        b=UPVU3ZPQcXq/iTFVtsqWkRJ3qlCP1Lr3DcXI43nP7MUvB1rY0+diEUK+9euMC4QSh8
         O4AN+hJ1KIRu7Gz/umY8jjhvU8idPbRIpPZlfibHkjhjTms9fOyO6yPTgnK9ZUpOS1aC
         t7eAtUy06jebzeWnvF+vsPC55nJa0N7ZXhnaNm+Drho98P1t46mKYj34tuelVSQuMhoM
         q28sZ9lxhhEe7WoMnKEQuEc94LDf9kD+sCUk0L/W47eDBZXx4wmlDF4moltjF7haHuES
         KUncKbbV0xSika3wPQuZ2OdoU9Fx/twBy2UkxDqXwvuoUyCreVCCmP42eUGqj6kYwzOP
         iMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144322; x=1690736322;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVDS79vqXqLudHPBY/MpaILvHVSubmD2fEfcAB2sjFc=;
        b=SwPhP/aHDtjfdTZupnbL+X/i0f58Fxtij6O9bWE/1BZvAyb9Byj09sSE+gp6ebGbYz
         ZlMH8ZjjAV2gMYS0XW7VlMGzBCx3+CYQ48BEQ1Fd1Bvh62eXPZYYjte6fS/FcAeqUgL1
         IaZ8VV144vrOGLfUwKeoKvT9a8u+Z1WHP6vaI+CB7QB1w7aYQUwXdhxdPASmhp1ZUaxf
         znUN/+6vznJCyqea0gk/4ZOXU5j8DjBtTCENEGghknGPgPfGLFhen9ZeWuV+esxkidA+
         fXkVtHnlfRu/Bo9cwghKKyAFRhp+CYP9iQDOVotB1IANU+/a7eDY/YBGzETFp0XppneL
         mBNw==
X-Gm-Message-State: AC+VfDwdEtWabfsu8f+wdb3TmrM+XHboCLKVA18PYZ/tuSLToVe2gHym
        oiPyLTroic78q/HzNRTiISBHdQ==
X-Google-Smtp-Source: ACHHUZ4kb1V3frCsFczRLlLgyifNBy0GBwdYjOu0RRm8Jn7X375HH7LEfgN4UjwZK03/hf8LXBRCLQ==
X-Received: by 2002:a1c:4b0d:0:b0:3fb:b3aa:1c89 with SMTP id y13-20020a1c4b0d000000b003fbb3aa1c89mr2480542wma.19.1688144322719;
        Fri, 30 Jun 2023 09:58:42 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdb8e000000b003112ab916cdsm18913772wri.73.2023.06.30.09.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:58:42 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 30 Jun 2023 18:58:29 +0200
Subject: [PATCH v2 04/15] dt-bindings: timer: oxsemi,rps-timer: remove
 obsolete bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-topic-oxnas-upstream-remove-v2-4-fb6ab3dea87c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1412;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=qERiig5wSYeUoOI63YnahZ6nGdl82BedWKVtaXlIxWs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBknwm16A/yr4DilaWEdtzFgOEAGl/phXffqIwaLSmt
 sPsOlVaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJ8JtQAKCRB33NvayMhJ0VDKD/
 47nyBKDAl2AY31ET35jQBTsmpGScqftSs8OcPuDPcN3VCsaWRv6UtgqcnEPJQnrzelrje0S3YGxPwF
 QcW3X6EWl3afDg0NhSDkHRIoXrVRFWxVUBXS0N3S8LKjVAWZKVkF62qgsGKTGCqhnIXvrtFwkJ1lXm
 MraxYWnOzHeiIf8ys9fhtGURRlCdkPn5qq1x/ZNCCQ5AwjWVRPg/8aqcvWGK4YVS7fTZcmsG+swmUD
 /AxQrAUMrJITN3Fsd8amhU2ujq9+quGZY2ch+5l7277ZFDC8kxuuh9szLemh9V31xMCCVd3J3IGJwH
 4cckGQPOijSnOTxHF7HwSAWxmnbMCQJqW/S3I79dtFD1/LL5lRZkHCDplu6cDNkNtX3WMwQN7FZdA1
 lZOacGLxkVnteC9JDXnxkGKG/NUWe8OPTD7SFm6dlXikbL+qcw3E65Aq2GILG2yK2w7wYTCz88WKT6
 Ca9MJTRkvLSpUGvWTVfkDnH3r2oZMZ/c7iyrrHrWcCt96/g4XvyDU81HEg2K69hTCjV6GFQbIcdEHA
 N35J/1Fc1TMzOTitNRKzN+cyw1K1gnbIDzLODWsLwLk89HSh+6vSzrYp0mDv05ZvqR0WTFMPfWT7FT
 zwf7ysaGzArnbrJ4b2hsre8VHA6zxuXtL8gxaGy79xMpYSwfDEy55y669tWw==
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
OX810 and OX820 timer bindings.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/timer/oxsemi,rps-timer.txt      | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/oxsemi,rps-timer.txt b/Documentation/devicetree/bindings/timer/oxsemi,rps-timer.txt
deleted file mode 100644
index d191612539e8..000000000000
--- a/Documentation/devicetree/bindings/timer/oxsemi,rps-timer.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Oxford Semiconductor OXNAS SoCs Family RPS Timer
-================================================
-
-Required properties:
-- compatible: Should be "oxsemi,ox810se-rps-timer" or "oxsemi,ox820-rps-timer"
-- reg : Specifies base physical address and size of the registers.
-- interrupts : The interrupts of the two timers
-- clocks : The phandle of the timer clock source
-
-example:
-
-timer0: timer@200 {
-	compatible = "oxsemi,ox810se-rps-timer";
-	reg = <0x200 0x40>;
-	clocks = <&rpsclk>;
-	interrupts = <4 5>;
-};

-- 
2.34.1

