Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363217440B2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjF3RAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjF3RAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:00:04 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D48A4691
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:59:03 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-313e12db357so2526303f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688144341; x=1690736341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Eyaf/JArFBnOJmUxcF7DoGLYY7fHW+Lur/i45+1eYA=;
        b=cRsI+Jc0zlEoiUnzMwgGVMTkMYll1xolMO9sNUYMp0FooJsUY4ea3qKTvrBPV3W1xS
         PdZIteGitEx9EYSLfRJOYktkFaGNgrjM1fFkOgOEvg9QpZfmPTHRP0w9/N2IQbu4+vs0
         nb54cBQE/s37T2C5zG7nCIR1V1emFvCiO2dgZn0Pz5F2ONkZj2tZtARRUTJGEin0ve2S
         TMKzcm5hDnbkJdr2TIU0CbpiH29R/WxZLmENSPUSj9byP3++sCzxuhKXEZ1zIb6Wn2I2
         cYCa21dnclLHYM4KbKNbtJpA/o/MUiaWI16RbEycKNxYjhX7e3isSa7OfeVEqG9msFcB
         UCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144341; x=1690736341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Eyaf/JArFBnOJmUxcF7DoGLYY7fHW+Lur/i45+1eYA=;
        b=gYCxbBnZkvh4suS5ijzIZcSbsehJGOldPKtKPSCr0dHIg3IFas0PShzdMyhrdy4lEO
         dVuLzfHWnGJU6w9WseNi8YPPQFb0EGMf+xh8s2SUk/hHF13nVCge8kWzSNWXrHdKTOd2
         CVtxruBiFb8sHcd0ObEJkMdFvpm20YOAsCrk1Ta0207XNEKKpi47tQZuw73nEhEqw5Y7
         yCMNRBa7gwPQwvSUaDlF/zpOgz5+D6kjqIpOLmkPNgkg3g0VcOjn18zjFxZpHxIU+F57
         UcyAAzlVrSD+9fr5MJZZqaxscrKWoExmCTV5vxCztsO4s07Yy1hp5VTuJWSmsshOrr94
         4mRQ==
X-Gm-Message-State: ABy/qLa7wsH3iwgaLnMUEqsZ8WszVOBjAquiD7STBcdHqMHzOEVfjKZH
        mu9uoxgL8Rt/Q7e68/KaffDwfw==
X-Google-Smtp-Source: APBJJlHFfj2oZl0xVr1nB2zXh05figvBAqXp7tIH/wIQJvw0txyZj53M9A0+P0VhEGIP+1a6UuKwCw==
X-Received: by 2002:a5d:49d1:0:b0:314:172b:a75a with SMTP id t17-20020a5d49d1000000b00314172ba75amr3025280wrs.26.1688144340838;
        Fri, 30 Jun 2023 09:59:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdb8e000000b003112ab916cdsm18913772wri.73.2023.06.30.09.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:59:00 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 30 Jun 2023 18:58:40 +0200
Subject: [PATCH v2 15/15] MAINTAINERS: remove OXNAS entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-topic-oxnas-upstream-remove-v2-15-fb6ab3dea87c@linaro.org>
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
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Golle <daniel@makrotopia.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=/Lhm4rki32xogr5e1680FrjcVLCt+j7sMVgTOqF2+4g=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBknwm6aoHZMmN8vUbEzTBcIOV7ONJvx2yeNn0kZRnx
 LgLt0iSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJ8JugAKCRB33NvayMhJ0aMOD/
 4o1u07bP99PyNkyrdoo5HuA/tEA4HRTOWRFwUBK2Fr4hLcuccLKZbqEoot/K06rPOpWlmBA0xJibYq
 9sx1cEJc+h2Z6AM6bLv21ZYqK5qXiv45NFZpA+avGwHQ3eQR49KMC8+J9Fb92MOTESddkVzr1uu4WE
 e9aJ1LI/ccd/i2cJ1q6JYWT4B5L5cIQbiI/ZtSRz8pqJ4w6w0RKypV0T7VJm80k0Jv8SmEp0Dlp+vG
 2WQAMcwB/wTd8fh2LKmHED0shMiW2MEQuAkLKiPoDPvybnsLhvaPHGkWmSMXRhTZl6DoGzOsvrTeGt
 aTFim1T/5SP8kSCH5IyYKe7HfsE8Yt9gBcyRyqu0NC2ehuN5DgDWJ25XQwf3CLLfN8xEj42a7f9Exr
 zWAe21b8vupE/IPlBZdtLAl4pizrS9O5UPCdYcEh7XVCBa8AMrQci3cdYVfnZjmMz9oQqhg9nYhA0V
 JGXiIp5zNtWsKoFqxPzpq30E48YAl7SC9jsUWLsXeqRm5FyrRsX8HmFPcHSNlOHUHID+XL5ltvxMy9
 5gbGOWZlwiRjX+X7+KZrzjzudA7BX8jOe+INgytdS3AgKSHSOiXc8Sx/ja2xf/Z/Hwp1CQeFZO2eQN
 2DfMAaMQrsOrzJs9Ps4BqxlAh6NcIKGU989Dmfjl521a7QN3/cdOvxA/sGbw==
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
and since no new features will ever be added upstream, remove MAINTAINERS
entry for OXNAS files.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 MAINTAINERS | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4545d4287305..cfe1bc884005 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2565,16 +2565,6 @@ S:	Maintained
 W:	http://www.digriz.org.uk/ts78xx/kernel
 F:	arch/arm/mach-orion5x/ts78xx-*
 
-ARM/OXNAS platform support
-M:	Neil Armstrong <neil.armstrong@linaro.org>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-L:	linux-oxnas@groups.io (moderated for non-subscribers)
-S:	Maintained
-F:	arch/arm/boot/dts/ox8*.dts*
-F:	arch/arm/mach-oxnas/
-F:	drivers/power/reset/oxnas-restart.c
-N:	oxnas
-
 ARM/QUALCOMM CHROMEBOOK SUPPORT
 R:	cros-qcom-dts-watchers@chromium.org
 F:	arch/arm64/boot/dts/qcom/sc7180*

-- 
2.34.1

