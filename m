Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC807690DEB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjBIQGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjBIQGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:06:07 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E63865EF9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 08:05:44 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id ki19-20020a17090ae91300b00232cba666bbso3163278pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 08:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sf2l9AGiK/XTzlXl4XjI0+S7/VkPLyFDxWXaWXs07cs=;
        b=ap9mGPZvoYruczna13BftwI0vtEG6rqrkcF3LueRlZJK0myK6E+p9xuBd7QZQdsSqw
         GMRbEgkRwAe8CFvo9y+AMmfgyXmDBWWzaL2YwBTmaMu3Sw4q5zjx2tRW4HHnYqpRFdlz
         Vp9bXXzNnU/zTTCyFoG9nuN7bfGit91IJxUoAoI7itOcryA5yfNv8VETkWcQqyFyF7cY
         MvrQ10MD+1x2K8ojw5Xfvw+RnOsg8T9jdBMULo/PscGE6kDmCGS+IuwmqQWGCHvvSbqi
         psdcPatFzoBuhkDqM5VvVD4A+xEnKx2vltnL/mzAOutsjbi9FpLz51e4o/WbcYIWIFxA
         WFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sf2l9AGiK/XTzlXl4XjI0+S7/VkPLyFDxWXaWXs07cs=;
        b=J9SN8kVm2TLovh3j1AKXtE1byQTdGsiJ8MR0z7K85jKHN3RhQ1NCxF9+soy35+e1nm
         FAXSfjOvAiWAsqww/eOJMuYccuAOlkSr577OfjoKZs8xIAN8KRro50vSEY8CZ9CR2xpV
         TCUQKyaV5A1P+8Wrue4G5rWfQLihMR7uLGmoXaI0Qi4i9MfxZ+Mji0HSM5FkEcxUoxnP
         gv3Nf6+RPZjMdYhJ08ibcUzj7BG9olE3Ap9B2UIk1SWudnW5rBBGNatuYQ810QIgAZhN
         lEaIYp2bctduXnY5S+fN0vlzyt/BjWPy4825R5wxECMx/8XG9taMn/FWmfxxNRXEToCm
         rOSg==
X-Gm-Message-State: AO0yUKXAI0trTFEuIvw1jguZyni5JDGiMNl3bnwRn/I6Ea0AFbyP1FAP
        4j1SKjJHerdzm7kwUGbqM+A=
X-Google-Smtp-Source: AK7set/4u7jPzC5Cd4Ek/0le3WT3Tpe2/hGKa0iVWneq4F3cmrIO4qbd77bCEEd1/a5+oH3tyBGjag==
X-Received: by 2002:a17:90a:ae0e:b0:232:cdb6:c4ad with SMTP id t14-20020a17090aae0e00b00232cdb6c4admr2940951pjq.0.1675958743585;
        Thu, 09 Feb 2023 08:05:43 -0800 (PST)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id p22-20020a17090a0e5600b001fde655225fsm7080135pja.2.2023.02.09.08.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 08:05:43 -0800 (PST)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     dhowells@redhat.com, dwmw2@infradead.org
Cc:     linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH 3/4] sign-file: fix few checkpatch issues
Date:   Thu,  9 Feb 2023 21:35:22 +0530
Message-Id: <20230209160523.858502-3-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209160523.858502-1-sshedi@vmware.com>
References: <20230209160523.858502-1-sshedi@vmware.com>
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

Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
---
 sign-file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sign-file.c b/sign-file.c
index b2619db..2faf302 100644
--- a/sign-file.c
+++ b/sign-file.c
@@ -73,7 +73,7 @@ struct module_signature {
 
 #define PKEY_ID_PKCS7 2
 
-static char magic_number[] = "~Module signature appended~\n";
+static const char magic_number[] = "~Module signature appended~\n";
 
 static __attribute__((noreturn))
 void format(void)
@@ -118,7 +118,7 @@ static void drain_openssl_errors(void)
 		if (__cond) {				\
 			errx(1, fmt, ## __VA_ARGS__);	\
 		}					\
-	} while(0)
+	} while (0)
 
 static const char *key_pass;
 
-- 
2.39.0

