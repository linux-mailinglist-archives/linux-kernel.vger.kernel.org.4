Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA58D6C4741
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCVKJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjCVKJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:09:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4DA5AB48;
        Wed, 22 Mar 2023 03:09:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ew6so7559871edb.7;
        Wed, 22 Mar 2023 03:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679479772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yru+/DJoW0l+gdfnZqzMPZHjYgVuqgrRcLKs3lSPmHE=;
        b=M6Mosss+BmvxqIkNxh0I9sIkanHXhjuavvFe9xCQtfjpYhR8vRfnbUIfB1WiWGLor0
         c/+8Fl/ZUbGEUi31LFq6Ju9M/muyfxJUhii3za1e9HG2JZ0NSUuByjdB1tSuPhtGxY8Y
         Nf+RN5G/XyQYWYi4f2/cdUJNdNAApdiYlS/cIOpbKQI9Q9G++5fMHxHGqGiEylQFB8Fk
         ps+IrR54AQBnzTytnt1FqW09dLlpJtXn3+jaLBkUxVqNpoIm6DLoIJJlN16lEszwD0Ue
         epbtZmchK/ZNepS15LuUh/nccrwlGmn/p81tA6SvbT0Z3028m/NtqUrGtWsq5AmZ7Qmc
         2s2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679479772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yru+/DJoW0l+gdfnZqzMPZHjYgVuqgrRcLKs3lSPmHE=;
        b=FFlS/12vw4JU5OMUtUSm8VJAyJ1fdpUvkH7TAtMkZLskDnxWimPJ9EZKOXMQTmSkQH
         +oRFyFY6uUquYMLW/AkW1ji/gxnxc0uKzhjkLgqPX4DGkpJix/7r26gbFuOpClm+SmW9
         qSow4MxL3/OlIKp/ZXbukJXJG26HEjvB2IctgMS6J/HVI7GkugilGtNvHC9bfuUdlxo1
         jqhYurgacJJPgv1iNZOTtP0VwfWrQU1ww25XsHToHcXGfqHN9ziGAEcB7mFSqnqxJgbB
         9vziihnLRZ4LtNhKB4skdmURghICBqGNey3n8GASPH2sVhwZY8f+zgt+ZHiVKTVshhKr
         ebWQ==
X-Gm-Message-State: AO0yUKVEHmc6S+/pi5vO16cD1FDmO6x7712DQ121OhG0WLCv57P9Tdf8
        00WD1y6XtIgtyHT/z38hHlo=
X-Google-Smtp-Source: AK7set/6uoHR69K90iGRKvBwbgrmpRQ1hfAMzKw4nU5pgrpBEBX/HIBu1pABx8tb83QbDHB/Qtz4nQ==
X-Received: by 2002:a17:906:1853:b0:92f:fc08:bb0a with SMTP id w19-20020a170906185300b0092ffc08bb0amr5888741eje.37.1679479772557;
        Wed, 22 Mar 2023 03:09:32 -0700 (PDT)
Received: from alaa-emad.. ([41.233.203.65])
        by smtp.gmail.com with ESMTPSA id s9-20020a170906454900b008f89953b761sm6954993ejq.3.2023.03.22.03.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 03:09:32 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        vireshk@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-pwm@vger.kernel.org, eng.mennamahmoud.mm@gmail.com
Subject: [PATCH] staging: greybus: remove unnecessary blank line
Date:   Wed, 22 Mar 2023 12:09:27 +0200
Message-Id: <20230322100927.28351-1-eng.mennamahmoud.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/staging/greybus/greybus_authentication.h | 1 -
 drivers/staging/greybus/pwm.c                    | 1 -
 2 files changed, 2 deletions(-)

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

