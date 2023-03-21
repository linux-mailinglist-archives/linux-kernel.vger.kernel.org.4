Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BB66C3906
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjCUSRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjCUSRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:17:38 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312A2521D1;
        Tue, 21 Mar 2023 11:17:37 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eh3so63203930edb.11;
        Tue, 21 Mar 2023 11:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679422655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2XHYm6132cfvGuV3ZRuw0Q1fBdGTBcOSwhXcyenDK4Q=;
        b=aNWqkqIv8UByTrLWplFKR85w538weWxpIILjqopAdJvWe0VIpkxfVr0udzl3iCOVvf
         aHPGs0b8kmWFd9u27OrkzdD8tfsoEn8F0ifHFo5eBsprVl5AGL/LDViiEWDn2lrzfZpA
         Y3+Luc2w1Y76Nq5CJ7pfxuXUtXPbupL9s1R8QnpVwnYfc+8NL9IQfrZbWP9xClEHvQMK
         4PPpgolG7lnsn2WFz/wKFQGtejhT5TPzfh+TZ/kA1naexzuzOBbQ5e/DVGNs4HUkkuw6
         0GS14XA74cSHFkbjzSVUNIl7KunBveHB6tE86caDqhtECFcCCkDSWPN57+IC/eYUC3M+
         ibww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679422655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2XHYm6132cfvGuV3ZRuw0Q1fBdGTBcOSwhXcyenDK4Q=;
        b=AosTQvJdwo0Vu9QAfEZQ8tgX9yQSKVTjGmc/EK1Wq0X7MQnihc9Ge/2CEOP0WYJT1j
         WX7fkuWl+6SJMEYNj6gQookyvybw7f4krT7f9WgG1ARWcgxtxRzFZ7tSYaR+sS2jD72v
         y5TC6k+8X7ta1JcMbajVFE98uQwGusrneCMnjSgjQr359AFYVLwqvEaqoLe3oKZgZg7D
         1vhJiExcqKkaRCvkWisq/lWZM2b7wGNpxdypfFtVBnTyIJ1Jfyt8kTMDFu8vF+1e8tTA
         38MiCOV8c4eGX5sL1YKPW4aEKPz6M615K/fEGYSDtieShqAHNyNJ6oANlbOW7C3kiZzS
         lcQg==
X-Gm-Message-State: AO0yUKUwJWANs1Rp4/WxRpgRphreSltwUMOTaUy42oFolCXmVu8utd0D
        sEW5KVsoZZzZ42cMzxSsXeQ=
X-Google-Smtp-Source: AK7set8irkZ/caMVldGalTdZB3+euMiXpFwKTTyChrRAC4smAA1fxCXMD/1zrzRADUKnlz606QkTZg==
X-Received: by 2002:a17:906:228b:b0:932:6601:4910 with SMTP id p11-20020a170906228b00b0093266014910mr4031726eja.54.1679422655754;
        Tue, 21 Mar 2023 11:17:35 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709063c1900b008e8e975e185sm6079198ejg.32.2023.03.21.11.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:17:35 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        vireshk@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-pwm@vger.kernel.org, eng.mennamahmoud.mm@gmail.com
Subject: [PATCH v2 1/2] staging: greybus: remove unnecessary blank line
Date:   Tue, 21 Mar 2023 20:17:25 +0200
Message-Id: <20230321181725.8691-1-eng.mennamahmoud.mm@gmail.com>
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
change in v2:
	add patches that have same edit in sigle patch.
---
 drivers/staging/greybus/greybus_authentication.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/greybus/greybus_authentication.h b/drivers/staging/greybus/greybus_authentication.h
index 7edc7295b7ab..48b4a9794d3c 100644
--- a/drivers/staging/greybus/greybus_authentication.h
+++ b/drivers/staging/greybus/greybus_authentication.h
@@ -41,7 +41,6 @@
 #define CAP_AUTH_RESULT_CR_NO_KEY	0x03
 #define CAP_AUTH_RESULT_CR_SIG_FAIL	0x04
 
-
 /* IOCTL support */
 struct cap_ioc_get_endpoint_uid {
 	__u8			uid[8];
-- 
2.34.1


From 6f56ebcda89f91cdfe6e64c0707dc476ebc1e819 Mon Sep 17 00:00:00 2001
From: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
Date: Tue, 21 Mar 2023 00:03:32 +0200
Subject: [PATCH v2 2/2] staging: greybus: remove unnecessary blank line

Remove unnecessary blank line before struct as reported
by checkpatch:

" CHECK: Please don't use multiple blank lines "

Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
change in v2:
        add patches that have same edit in sigle patch.
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

