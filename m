Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBFC6B5C8A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 14:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjCKN7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 08:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCKN72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 08:59:28 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822B5AB8A6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 05:59:27 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id f11so7504437wrv.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 05:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678543166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LJRQANhCEGiforjUF4Wz2oYn+hKUyKWCbODGuMeniSQ=;
        b=JIiZNE3piZTJCsdED37IIm8XMSp9EX72kmtzwU+J7mdYahgbVAMXowLQYViHJ7h9us
         98UEpwBDucgBmIApBqTPNHqtZm4vCsrtJQeGmKZUZ+v+aE2QpS0XMG+TEaXvZfPgrChj
         G888iVy92TQEqtYbGEZAv3suMTzOaLMl+YYCh4qSBOdMCfUkfmJbUAI53MFtCHTYHP7t
         9BgSpNHefw8483mdbzuReU2/fOupzw4AlnJxaNf5ZY/h3o6U3KgWUL5drplcszGqsCWU
         9yLw7G+Ew7BZn5C79OHCJsSB2ooeC8oynkEAqt2gMZluxQ2gVoB3obLIhjApQSQKrA//
         cZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678543166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJRQANhCEGiforjUF4Wz2oYn+hKUyKWCbODGuMeniSQ=;
        b=KtyxfFuBNkD/6L12hWBijtm5LbC3LCQkwm7q+AvcNLCMBmxPDIRCZvFCcezn8Li416
         jUvEmV6Fz1lhO4t/y9l65fXxNjFyrLALbOL0RuOd8LU3TgzKRS/AXVATbJSDMeVJfXdK
         4KQySfmysMZcHDFkUnlFsQZwp1rXEmaVLKpTsCV7GhmdsDokfGPQtz1H9v2xHgkAGMHV
         sNaZLYTIO7qhIkJvdIC/2cu16BhdXQuYbD0ILOPaqA7OmDruhnXoro8y4EulANX0+Gn5
         gS0o+/v/wNfmUYVqVFlVo0/BOYKPphQeXwtLwr9X+U1/2g8gK8sKhqd6wSTS7G1hKX27
         MjPw==
X-Gm-Message-State: AO0yUKU3PRRj5dCR7X50fl75+VksjWN7qkHC5aWXghUARHvr8VxgHwQq
        IR+51E4SnmoD6GQmirF2odZJYhyBgUVesw==
X-Google-Smtp-Source: AK7set+flWmWv1HNs5ZSs/7+QBbG9EVcruCl00JPP/7DWKMEE8Tg5+ucOu2vofksMgs5muQs2jBs2g==
X-Received: by 2002:a5d:4b04:0:b0:2c5:3cfa:f7dc with SMTP id v4-20020a5d4b04000000b002c53cfaf7dcmr20930026wrq.7.1678543165955;
        Sat, 11 Mar 2023 05:59:25 -0800 (PST)
Received: from alaa-emad.. ([41.42.191.171])
        by smtp.gmail.com with ESMTPSA id s9-20020a5d5109000000b002cea8e3bd54sm245257wrt.53.2023.03.11.05.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 05:59:25 -0800 (PST)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        eng.mennamahmoud.mm@gmail.com
Subject: [PATCH] staging: greybus: eclose macro in a do - while loop
Date:   Sat, 11 Mar 2023 15:59:19 +0200
Message-Id: <20230311135919.9129-1-eng.mennamahmoud.mm@gmail.com>
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

" ERROR: Macros with multiple statements should be enclosed in a do -
while loop"

Reported by checkpath.

do loop with the conditional expression set to a constant
value of zero (0).This creates a loop that
will execute exactly one time.This is a coding idiom that
allows a multi-line macro to be used anywhere
that a single statement can be used.

So, enclose `gb_loopback_stats_attrs` macro in do - while (0) to
fix checkpath error

Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
 drivers/staging/greybus/loopback.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
index 1a61fce98056..e86d50638cb5 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -162,10 +162,12 @@ static ssize_t name##_avg_show(struct device *dev,		\
 }									\
 static DEVICE_ATTR_RO(name##_avg)
 
-#define gb_loopback_stats_attrs(field)				\
-	gb_loopback_ro_stats_attr(field, min, u);		\
-	gb_loopback_ro_stats_attr(field, max, u);		\
-	gb_loopback_ro_avg_attr(field)
+#define gb_loopback_stats_attrs(field)					\
+	do { \
+		gb_loopback_ro_stats_attr(field, min, u);		\
+		gb_loopback_ro_stats_attr(field, max, u);		\
+		gb_loopback_ro_avg_attr(field);				\
+	} while (0)
 
 #define gb_loopback_attr(field, type)					\
 static ssize_t field##_show(struct device *dev,				\
-- 
2.34.1

