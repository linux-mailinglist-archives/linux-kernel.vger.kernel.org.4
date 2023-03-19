Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EF76C02C9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 16:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjCSP31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 11:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjCSP3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 11:29:25 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08B1B447;
        Sun, 19 Mar 2023 08:29:23 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eh3so37783290edb.11;
        Sun, 19 Mar 2023 08:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679239762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hHi5+GWz44QI22N2lgNwAXCVNfgTvzls3W9uzDI9R7I=;
        b=A1K3LhmqfNVSEcgbGX/WGPLi+QBohjU8Z5DHP0patvexQ8cftYKkbJ0n6EBImk5HW6
         UG3Od9lWQz+pdUobR1WT79K1Vth47r61AMt5plC/fO7k98OkymeUkG/FFpi3yruiXLLe
         ek6/f+cxrtMdNf5pnqpcJsWYFXATIQYRAncu/xu52HpXK9FuAAQXTfnHVp1sVshk39/y
         SPzLTA2qgsb1aGWZcI4ESPkW/aT5UpUj3upvbNV4IbukUgevuZXKWukaWhAtA1KxT2sx
         +a4++/3MBnpA0HcQAhqoI8jBEeOWvRnAORLhu2VmIvl2V6VnzNEL2TjKv5Djdq5OfNfZ
         HQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679239762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHi5+GWz44QI22N2lgNwAXCVNfgTvzls3W9uzDI9R7I=;
        b=dF10iT5VJn+isCkSZUQkHmUlPuxeUByJRWlKWXSL7SL/hFDPICmaLxyH/u8gMEB7BB
         8ACiItVruyr1sF1p44YZSOeBpRIHfuqztetM2VJwk//ZfRSO/MjUax96+0FGq8owm2X0
         hRRCRRdk8hV9pOe9lXlkZ7MJ1KZn6H1fTneDOO5j6SPexDgn3pycw6xXrvp+1uogEZya
         KdEPyZwunanh1M4yVczu/i0RHZjZQ+e5pbTtby4kB67i/bSBv4buL9QLP6Ezy4dmBd0Q
         t5qcffIGzt54d3QOW5PW16MX38sfagpbQ3YGksR0fo9228uxW8jPLY+9oiek8UciJ5Qo
         b4Tw==
X-Gm-Message-State: AO0yUKX8gUc3Ae9nFUI2duLqpKg7U5nWXPkwgSDvB9nM7KSnl/8wI9r2
        PSfRFBuQaHhMfQKPAll8t54=
X-Google-Smtp-Source: AK7set/E0e+CI78tJzcFXyh5kyZx43f/wgftRrGinMc5pR7pChEra9ob+MPRBBpdNINOjJ8OqOz06g==
X-Received: by 2002:a17:906:8415:b0:930:3916:df19 with SMTP id n21-20020a170906841500b009303916df19mr5737952ejx.5.1679239762248;
        Sun, 19 Mar 2023 08:29:22 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id ia9-20020a170907a06900b00932b3e2c015sm2425429ejc.51.2023.03.19.08.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 08:29:21 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        greybus-dev@lists.linaro.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        eng.mennamahmoud.mm@gmail.com
Subject: [PATCH] staging: greybus: remove unnecessary blank line
Date:   Sun, 19 Mar 2023 17:29:09 +0200
Message-Id: <20230319152909.163598-1-eng.mennamahmoud.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Remove unnecessary blank line before struct as reported
by checkpatch:

" CHECK: Please don't use multiple blank lines "

Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
 drivers/staging/greybus/pwm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
index 3fda172239d2..26d39e08c3b6 100644
--- a/drivers/staging/greybus/pwm.c
+++ b/drivers/staging/greybus/pwm.c
@@ -24,7 +24,6 @@ struct gb_pwm_chip {
 #define pwm_chip_to_gb_pwm_chip(chip) \
 	container_of(chip, struct gb_pwm_chip, chip)
 
-
 static int gb_pwm_count_operation(struct gb_pwm_chip *pwmc)
 {
 	struct gb_pwm_count_response response;
-- 
2.34.1

