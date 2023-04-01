Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3F06D3349
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 20:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjDAS7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 14:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjDAS6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 14:58:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F7B3592
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 11:58:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id s13so14777700wmr.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 11:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680375531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0EbqnaKdSiijP5AMHVuBOUgkUfHYyGlvbGYlKLav6c=;
        b=D2Wv96vcb3yoPTQYqJj798MQvDM69mQmUSiTRwNmVtEAwcfI87/2bHbmxjvIMsH5bU
         7qzxxO+oLaCioavYqdZ/qtnSkw8gSFx3un7zY715c3CqaHkdGZb7wH/7s4VN+TJKKWmk
         2oSSJUSuMdPdUqyBmoGnVDIAMy0BDFyPeLbWL37VlVBehJeKFJWAlVri4BjKjxzvt1EO
         TNfS6ROQ0sY+qNjtRtf2HZeDYgoA/+/m9UvKq8VhJGve7NjQEfb12e7qjNy/M/PfuJF0
         w3YMd5rJCMd61kvS3MSba+/EXwQxcGNpmwdQwbeOiWgUGCH9tfqv1vPL0uHU84xyJH0h
         An4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680375531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0EbqnaKdSiijP5AMHVuBOUgkUfHYyGlvbGYlKLav6c=;
        b=EkPlMswVs3qnHwm8UTB/JsKthyXOzNUeJIHSpQ/zOlJ9L4g5mFBNi7bP9dI0dlTKqk
         m8M6SVUQLVe3H0pM85qcBlRXkoIxHWHIzD4oKGGTAC8Ic6gaYalserkTqC8PSek8k1Dh
         44wYJnvO1McKz/2lR1E7a9nzOPvoSRXHur9tSGs6WECpoB648y11r4sVAMNY5AQkHxCq
         pRdDQrejRAlrrDkZDNTElrrRDgxAqLQtR/YBWrp28hGmRR5lipxEhGFEJNcUkB0mdAIX
         y09egtBk/q6ANWfWGyq666JtdooeqtHr3fStRR0ZvajC86uRRsVQukPTWHL3hXEQdoX4
         KQeA==
X-Gm-Message-State: AO0yUKXGN+L8VzSa0xWyTJpRwauS1VtgMjsQ0HAb/82WeKoKZVHNRU0F
        fZK/jWJ7dSIC47T/ZeB0jkE=
X-Google-Smtp-Source: AK7set8080+qC+D5SOfY8YZLaERU3d+h6AONLNLXHZfn/ByUituNzOF37sbRbEOrdrg6k6rThnYMoA==
X-Received: by 2002:a05:600c:22d4:b0:3ed:b56c:9496 with SMTP id 20-20020a05600c22d400b003edb56c9496mr22974761wmg.31.1680375531269;
        Sat, 01 Apr 2023 11:58:51 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id s17-20020a05600c45d100b003ed51cdb94csm14017463wmo.26.2023.04.01.11.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 11:58:51 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] staging: rtl8192e: fix alignment to match open parenthesis
Date:   Sat,  1 Apr 2023 23:58:41 +0500
Message-Id: <76814f7a2a026ef195334b0c42ecd2aeb8e8ea40.1680375200.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1680375200.git.kamrankhadijadj@gmail.com>
References: <cover.1680375200.git.kamrankhadijadj@gmail.com>
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

Fix alignemnt to match opening parenthesis as suggested by Linux kernel
coding-style. This issue is reported by checkpatch.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
index eb7b6deb2ca7..8d3067a6ccca 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
@@ -332,7 +332,7 @@ static int rtllib_ccmp_set_key(void *key, int len, u8 *seq, void *priv)
 			data->rx_pn[5] = seq[0];
 		}
 		if (crypto_aead_setauthsize(data->tfm, CCMP_MIC_LEN) ||
-			crypto_aead_setkey(data->tfm, data->key, CCMP_TK_LEN))
+		    crypto_aead_setkey(data->tfm, data->key, CCMP_TK_LEN))
 			return -1;
 	} else if (len == 0) {
 		data->key_set = 0;
-- 
2.34.1

