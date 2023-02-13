Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0241694FCC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjBMSu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjBMSuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:50:44 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E42C1E295
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:50:30 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id be8so14472723plb.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=li57XINCk5Jam2xxQUuYh3i4dQfBktaGCm083Sd9cl4=;
        b=dgUjtmvaTGk2bflTpUWN0BYL7gAeMmGZpdPZVW/3TPu4/eQPth77LHcMkw5YWIkSmc
         Rl2HaIAmywqqL2ZsqCDa9/vdjK6p/MHvMWwtjOA/2+cQiAeqAe6wLf/kLL/maQfR1LWD
         42vwIZyu8bEMTyL/r7rbf5XZr8GTlkUn2eKYGXke0V4H0MNK9vDwaur/ARsKhfuWn6Wf
         Rnkd5XZLkk0Q7mxTesq2e3579c0FOOQWvDKLaqYxtYRMmJuFL5NYOdUXefxevN1WT56K
         uHYqA7W83dD6m84ks6ha9pgA149gCE1b3UMiq4tgQPpItjFw6E3iUnseMOwiCaewir94
         Ll/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=li57XINCk5Jam2xxQUuYh3i4dQfBktaGCm083Sd9cl4=;
        b=ofbHhXczn+MNpoLHT5E8u0qW1QDYWluavl6pALrhlF9cbOKLOtPCrbZaYxu2YrqeZE
         emR8xikiKUJPg0NFGMR+NPGg5eNntAK3YWYsTwOPAorHO7SKxvBxKeNPAaZzo0aBik7V
         fGUwTcpagbWoBbNoHPIcVFOvXHtg7KjtcnsGu/qUMMHUHZmEXkNHo12wSZchNpkrSzRM
         qBmzoL8yKP77yUBFZboX/GjB/EMJwos+boIQ9ct+jTuIkdN2IBeF+XsZOfA8A92GbsLb
         GyaKPatlzM/SE5TJWbfHAEKUbWfAsU0qsOeoxcsePaJJ5xNbJveFBA/e/g1l18iX4WMF
         4fwQ==
X-Gm-Message-State: AO0yUKXJ4BZj5BPv638vHexEo/w+FnUYtofPLVWavtMwQwcTZU5UEjJ4
        J+1kSJ0i1Jc9kA3alCpoqEM=
X-Google-Smtp-Source: AK7set8fL4fyWWxQ2Vw1RAZy2KP7/5oza0/EjWaT2OqAoR5UWlie5GHxDKgdJEvRB2PQajQLOPg6TQ==
X-Received: by 2002:a17:902:d04a:b0:19a:a798:51b6 with SMTP id l10-20020a170902d04a00b0019aa79851b6mr2063101pll.49.1676314229669;
        Mon, 13 Feb 2023 10:50:29 -0800 (PST)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id p14-20020a170902a40e00b00198f256a192sm8535036plq.171.2023.02.13.10.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 10:50:29 -0800 (PST)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH v2 v25/6] sign-file: fix few checkpatch issues
Date:   Tue, 14 Feb 2023 00:20:17 +0530
Message-Id: <20230213185019.56902-5-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213185019.56902-1-sshedi@vmware.com>
References: <20230213185019.56902-1-sshedi@vmware.com>
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
 scripts/sign-file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index b48832d54f45..0729d8df5660 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -71,7 +71,7 @@ struct module_signature {
 
 #define PKEY_ID_PKCS7 2
 
-static char magic_number[] = "~Module signature appended~\n";
+static const char magic_number[] = "~Module signature appended~\n";
 
 static __attribute__((noreturn))
 void format(void)
@@ -116,7 +116,7 @@ static void drain_openssl_errors(void)
 		if (__cond) {				\
 			errx(1, fmt, ## __VA_ARGS__);	\
 		}					\
-	} while(0)
+	} while (0)
 
 static const char *key_pass;
 
-- 
2.39.1

