Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FFF680906
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbjA3J0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236070AbjA3JZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:25:16 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD12A2FCE3;
        Mon, 30 Jan 2023 01:24:17 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q10so10386411wrm.4;
        Mon, 30 Jan 2023 01:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vfICYlOuLoOFLmSVCsv7Ez+Wg1iIfXBt/b5H/P4TiEQ=;
        b=fAr+gRUQ7tl3KvPS7+xNmBeEAU0Yuce94GDMBv2SkZ7oKen6ZHC2e4T3ix7t3Xzj3d
         kW5kAA34cUt2REzQ4bDyJwRm6VxuW2uazTE7Yf5mx+BehyY0MEpWwM4759kcl9x3bbg+
         wKCE07oAsTri8cQ8GN9H7Cbk5mPciyjI12xKAN5dxSr56uGsYhXUDFTVV8bTVR5caF/C
         gng9jNGVpnXtqgjCzDDcMJvY9duVyY5E/f0YPM2sxABhW+ULHFWTdbbjvWjyRL6QKLNC
         49OmfCY2ZyOMQVhUhL1eWlPgXdciB9KYaqO4JYv6wCwwWnmrfwtnaMKTdWZmi3efdi8U
         Zwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfICYlOuLoOFLmSVCsv7Ez+Wg1iIfXBt/b5H/P4TiEQ=;
        b=XKo9i7E0+P2s0O2qgNzvWkjLXPydFg0WHelsYd6PrDvlhV0TPMAKUKSfgmgrwOU4x9
         F5r6ATQoeJ+ValC078zNKoEg1OxppBd1nBwbJTeJMluN0xsoO+owQ2kmAyziWAYVFMm6
         MwulukIT8NlfqqV0+APEqZMhIxpCoLFrhV1sdWZ5I+FP9vFc5UT0SSLXGMhr6ZZeGkWI
         gyszf8ghUZ/6DUFVAvzKfGTwxZ8dWnVvYluDgXvpv7VKrQWX+G6uAqFWeLLGCicPusAZ
         /NYnP4bbbbnP9OwnB5a6DnOIgIoCgKm2ECCTbQdXhBY76uptgOZgvRl8IuYEr2Bt/7pj
         jMxQ==
X-Gm-Message-State: AO0yUKXC6fjgkllt0Mkfc8plgYGpF9Yq37zTdvIQ+r8+pKIACe7KI3yG
        DYMnynfHfFESWlp9oRuCH28=
X-Google-Smtp-Source: AK7set+2myVLd06Pu5edYxOwUfsZKmitHbZAGtWszR3c1HZ2HD+vVEMkpKY6OnedR68lQkQl+PpjpA==
X-Received: by 2002:a05:6000:1448:b0:2bf:decb:ecac with SMTP id v8-20020a056000144800b002bfdecbecacmr8700884wrx.11.1675070638360;
        Mon, 30 Jan 2023 01:23:58 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d6b47000000b002bbed1388a5sm11348862wrw.15.2023.01.30.01.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 01:23:57 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ksmbd: Fix spelling mistake "excceed" -> "exceeded"
Date:   Mon, 30 Jan 2023 09:23:57 +0000
Message-Id: <20230130092357.36730-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in an error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ksmbd/connection.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index 56be077e5d8a..0f7eab5aa04c 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -312,7 +312,7 @@ int ksmbd_conn_handler_loop(void *p)
 			max_allowed_pdu_size = SMB3_MAX_MSGSIZE;
 
 		if (pdu_size > max_allowed_pdu_size) {
-			pr_err_ratelimited("PDU length(%u) excceed maximum allowed pdu size(%u) on connection(%d)\n",
+			pr_err_ratelimited("PDU length(%u) exceeded maximum allowed pdu size(%u) on connection(%d)\n",
 					pdu_size, max_allowed_pdu_size,
 					conn->status);
 			break;
-- 
2.30.2

