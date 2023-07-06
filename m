Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0153749522
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 07:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbjGFFwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 01:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjGFFwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 01:52:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D050A1732
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 22:52:45 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3144098df56so238204f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 22:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688622764; x=1691214764;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QmghjAxIZETM80Y4eowuI0+E6FG3YgixB48nOwNbm9o=;
        b=fijStf/B9+AaMmivN5Y7sR0r3hGVdHsGhuNl+G+aRAtLdP3jH3ZPz7/vkKqUWhe6Bk
         BP9VQUm/JxQBF2bob8wpUcm7qduGQNN/nKCXdc8azilpt5LbSK/PthyyqM6bGmUS1VQu
         x4nM4WX0jK3YD6uvsxZLAbAmTP0fBmfSTzYSqwcVkXBfJd5710+M3qUgX28cY4gtxKdH
         qGe5JAl1KOfNr5J2j7DrpN0RfoDG2gyihrYgIWTgLU5O7axu0UW3e8/tfUhwq+IcQz5n
         p1x956FfC5vuAWCcQrNq3/DEThZQWG9sU2z3dyS+MZJicozt8Amk+wpDUQozbnX/u+fc
         YAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688622764; x=1691214764;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QmghjAxIZETM80Y4eowuI0+E6FG3YgixB48nOwNbm9o=;
        b=SBj9ildATE+LlU8LXm394syPGbPxHaFy2lHNJ+scETNcCtg8tpOEpS8+etLYTvwVkP
         B2neZ892Pp0/+dhMmZmY5fIqkX/MImmS8OV+SV8TLj2X0BZletaTYKQdc+GUyblSB8D+
         c7WwtKTXBahrdn8EUB6NXLIRZ/0k4ZgOnC5qlQjR2A51UhuTxgxxKt1G/hvkA2pX2OqK
         YCrgQMFIEoLgBwDjh2zg4sZeHtewXdEGXXhfWIj3F0au2wqoNV4PAHo6innwFZTJXHCT
         M9YSXl88fQi93XE01wZ6FAUxEbT/LdDIgEQi6oSoMWSVJjTJWKfvWviv434ZeitVLWzT
         7/Uw==
X-Gm-Message-State: ABy/qLZOkJVJQOVbvoZVhJDpXac7PA+um/L7x7yyUZWQsbZWsJXyaKXw
        Il7iSEOfOpmiYrt4KBzcazO6rQ==
X-Google-Smtp-Source: APBJJlHnPFczuKzdfSvVB/cmZ/mpGY1gDA4k27AnPCEwZ0jE72NwRJSOh2Sd/E4gFlWZsi51jSA4KA==
X-Received: by 2002:adf:e28a:0:b0:314:521:ce0a with SMTP id v10-20020adfe28a000000b003140521ce0amr636808wri.40.1688622764323;
        Wed, 05 Jul 2023 22:52:44 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z8-20020adfdf88000000b003143bb5ecd5sm855993wrl.69.2023.07.05.22.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 22:52:43 -0700 (PDT)
Date:   Thu, 6 Jul 2023 08:52:39 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] smackfs: Prevent underflow in smk_set_cipso()
Message-ID: <5070f3eb-55e2-44db-a97d-41f9b9878c6d@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a upper bound to "catlen" but no lower bound to prevent
negatives.  I don't see that this necessarily causes a problem but we
may as well be safe.

Fixes: e114e473771c ("Smack: Simplified Mandatory Access Control Kernel")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 security/smack/smackfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 5590eaad241b..25f67d1b5c73 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -896,7 +896,7 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 	}
 
 	ret = sscanf(rule, "%d", &catlen);
-	if (ret != 1 || catlen > SMACK_CIPSO_MAXCATNUM)
+	if (ret != 1 || catlen < 0 || catlen > SMACK_CIPSO_MAXCATNUM)
 		goto out;
 
 	if (format == SMK_FIXED24_FMT &&
-- 
2.39.2

