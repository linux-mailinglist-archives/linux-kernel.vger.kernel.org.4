Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73BA6C2564
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjCTXFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCTXE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:04:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6495E311DC;
        Mon, 20 Mar 2023 16:04:56 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b20so20086826edd.1;
        Mon, 20 Mar 2023 16:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679353496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHi5+GWz44QI22N2lgNwAXCVNfgTvzls3W9uzDI9R7I=;
        b=KHry5cV/WmYVdWszvx3gMaRricrhKOL/lzXv+ovvM9LdfGIZgyTz5TzaEbBYmrHe+B
         d6QZ6jCGQWNRv0XTqPoMbbR8LQY7UlBHpPrmWOasvI3x8kdub0KpMZN05I14Wkbg49z6
         65WH61JSSg2xleRRoJoySE9nau0xIsxA0xM5siTeJsU7z+U/z1rPNfuoDKuGdzzjD0B0
         SVhXx+xnP29qwhgvzh9eTCpHRwtQeMXlRv/Je+70jYIjN8QWj8znIoxds7MXCJDDRQGz
         838MLVA7qu2ivpJ0P7b8s1YmRxU4C4L7PrhgtaVnnxN3jPAwyljEwdQsLF9miUVyLK52
         pgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679353496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHi5+GWz44QI22N2lgNwAXCVNfgTvzls3W9uzDI9R7I=;
        b=7yXtflMxJ0SHbqF4LCWacK5u3rSwT8849RobuG1arLlWVaKnUSi07cB2KUSOfSjNQ7
         S+NO+MhAXN8rpYgVKtrfxgglF2jqIO3wq58cUVWCtpEo2+MKZpo5Xq/dx+ObXnIe7pv5
         VQzUJJS144D2w7cfzwmemVPdc7SERICHOV+tX/g+AZc5C/f6kc621FYB9o08Po7dw9Gl
         pygr7/bco+ItTq/WoOKqVtW4wPRi44sFYc4RBjH+08vewT0kjI1lLesv/RR8MGJVl/GM
         +rppp631K1ckeptlcKyl2gPVUqeqT76pdwudkJgx0Pf6zoGUZlA7OA9nrUZyLpHyNj2A
         Tthg==
X-Gm-Message-State: AO0yUKUFFL261d9mXgKIVTODCgzonrhSPHPTggaYPZm5X8OjctBIhkKH
        JkR6JOrL/RegFXsMSjw2hpA=
X-Google-Smtp-Source: AK7set9oGrCiLwaTVVHNqARv9f/FYWeTuzzJVPjy0U7DAdWmYUUoV1H/27zWIC19MKSsWI6kfTIlNg==
X-Received: by 2002:a17:906:f6d9:b0:930:1391:da7c with SMTP id jo25-20020a170906f6d900b009301391da7cmr637301ejb.60.1679353495859;
        Mon, 20 Mar 2023 16:04:55 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id v5-20020a17090690c500b0093188e8d478sm4956403ejw.103.2023.03.20.16.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 16:04:55 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        vireshk@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-pwm@vger.kernel.org, eng.mennamahmoud.mm@gmail.com
Subject: [PATCH 3/3] staging: greybus: remove unnecessary blank line
Date:   Tue, 21 Mar 2023 01:04:34 +0200
Message-Id: <f71528cf8bcdc2815ca8a1a1e1ed4e2fd6096d1a.1679352669.git.eng.mennamahmoud.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1679352669.git.eng.mennamahmoud.mm@gmail.com>
References: <cover.1679352669.git.eng.mennamahmoud.mm@gmail.com>
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

