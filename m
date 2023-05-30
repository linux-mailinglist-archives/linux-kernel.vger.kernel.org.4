Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F957157CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjE3IAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjE3IAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:00:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D27D9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:00:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-309382efe13so2604106f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685433626; x=1688025626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oi5cyxzC3+NP4WFp104cxanaFNMsvwaBhA2yhJz87ao=;
        b=FKNBr7ODLDGPyplbcdDyuqyYIbMDFMB91lgmUBE8Z8fIM1vdnWCRxK5t+4zSDAxOQe
         +GysBXe8MItNFn54hUSvIyuORrnaVllTUP7SOPmdcJUz0AbYylXIdcOWX4qR0j+bunS+
         DivOm121O8Cvb3kmjaeNcXzq1MgfL2Cm7AbasSRaO4rqhBr3+tUhWjO6ckUKBkbqynL2
         +HQjTOXJYiPJzm9Q0saSZlOlObvXdAYwp9hHnHQoEBcDLKgdIkqXJeotu2nh0MkdTiUq
         kQJKxflt0RMy21IV+jrA0l+uTuT0r8ylU+iB3IY9md8yKxjZOf9Vk0X+M9WFeS6RjJLB
         2mAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685433626; x=1688025626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oi5cyxzC3+NP4WFp104cxanaFNMsvwaBhA2yhJz87ao=;
        b=HICwZv6x0OZIn4O+KG5W2go2U+bIBskkq6QgWzi+lsRG1oCh7OodI7dVyciFT2b2jk
         za31Kv07JLzJD2mQckXmvQbgwrCUDRQ7XtAQRk7lvIa3S6Xt6cLXlgPJs9lMOFvyUQPg
         S2jGwXsjza5uxZAp208BVqsBCzivQbb8sufsaEuiErSOfx8Xty9Iq0mBxtxRQgEXmt3Q
         efBBmnO31qhQ1kAHMRu2WY9Aq5cO5TrnjTxrv/1oCO4OawWJ70SleGM1hmBghtLFiE8P
         duQ2/CFGxvw1+AHHU8ADWHXzzQC/GeOCuHTwGm4NuqJ1AlySk0GOPhNtACShkgsYrh0o
         +fjA==
X-Gm-Message-State: AC+VfDz3N1m70ICJoVT6v4KwswC1jMcpv3xxiVP+VEETqKlyVEpHfeYG
        uYxiaH05PpuLxxTYf7abIg5iWlG1u2ryrbxF6cZdKg==
X-Google-Smtp-Source: ACHHUZ4sElmQNI9IoZcrEoP6bqPGFkS1UWyATZlwF9CbxAMaju6OiXJvlndUkxmSYQZqW4deOzhaAw==
X-Received: by 2002:a5d:678f:0:b0:309:4a5b:508f with SMTP id v15-20020a5d678f000000b003094a5b508fmr826416wru.24.1685433626057;
        Tue, 30 May 2023 01:00:26 -0700 (PDT)
Received: from [127.0.1.1] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b003f6050d35c9sm16409978wmc.20.2023.05.30.01.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 01:00:25 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
Date:   Tue, 30 May 2023 10:00:00 +0200
Subject: [PATCH v4 2/2] mfd: tps65219: Add gpio cell instance
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230511-tps65219-add-gpio-support-v4-2-b5d6a764d722@baylibre.com>
References: <20230511-tps65219-add-gpio-support-v4-0-b5d6a764d722@baylibre.com>
In-Reply-To: <20230511-tps65219-add-gpio-support-v4-0-b5d6a764d722@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>
Cc:     khilman@baylibre.com, msp@baylibre.com, francesco@dolcini.it,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>,
        Jerome Neanne <jneanne@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685433622; l=1009;
 i=jneanne@baylibre.com; s=20230511; h=from:subject:message-id;
 bh=nMeCcxVhE7+un5EdrNfRU6JWVC4UNE7togljBBNu77I=;
 b=CpMbAoke2LTSOlEvyBOPwWQ/t8EJB7RkrlhYL58Ne/IDVV+v7WO9zYk1NSLbdr9YicrxGsimz
 r+eqMMZrvTbD7u+p+JvcHOis13q1EkFHBL6e9+RWoJSeiXecH2qcWjE
X-Developer-Key: i=jneanne@baylibre.com; a=ed25519;
 pk=5rvbqNoG+28jQjC9/50ToY7TgKWf9rJukuCI8b6jkUo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tps65219 PMIC GPIOs are exposed in a standard way:
gpiodetect
gpiochip0 [tps65219-gpio] (3 lines)

tps65219-gpios is incorrect cell name (plural):
Changed to tps65219-gpio (singular)

Co-developed-by: Jonathan Cormier <jcormier@criticallink.com>
Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 drivers/mfd/tps65219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
index 0e402fda206b..e1d090ba4258 100644
--- a/drivers/mfd/tps65219.c
+++ b/drivers/mfd/tps65219.c
@@ -106,7 +106,7 @@ static const struct mfd_cell tps65219_cells[] = {
 		.resources = tps65219_regulator_resources,
 		.num_resources = ARRAY_SIZE(tps65219_regulator_resources),
 	},
-	{ .name = "tps65219-gpios", },
+	{ .name = "tps65219-gpio", },
 };
 
 static const struct mfd_cell tps65219_pwrbutton_cell = {

-- 
2.34.1

