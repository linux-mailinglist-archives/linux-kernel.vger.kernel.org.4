Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2822B6C1EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCTSEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjCTSD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:03:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306B930B3E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:58:07 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u5so13335440plq.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679335064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orHz49MEtEREu43pkNm/tKqUuGAbP6UFRUzWf1lMbKM=;
        b=FhdJ0ZFVBv0Sebwh7TLYpaPc17zHFZ0o75duazPr/0dqB6mGmBJzZIEOATlu8CXzMC
         WudrAnfEpmfJScIAo59rhQxViKS+lQvIAhy0tMvOxE/dneW/PqHG8DB2rfEkOrPocV+t
         YwY0L//Pt7tW1lMkGxl+T72zxD9yWy85gEkIgkXFIjt82cwm34mCt5A1Yrrc6Lekg7u0
         tRXtXQVmS/ufPYomkvoSsnnzqvG+W40vXsb5U1j5x3Izoko3Gdfe6SW1u9d2a5+dvssb
         CLbHHyHNinZQcK6wgp13eg+puVNqTGzEkW9R3ttjgxM3jwDopI/ih+qSu8mE9+oievKs
         TH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679335064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orHz49MEtEREu43pkNm/tKqUuGAbP6UFRUzWf1lMbKM=;
        b=NeQ9INw2q+r+ASWc7lkiOwpSuHV2/GXwVkGfJFEYJkod4QtvYMYkUyll8xH5f/XZ4P
         UtLxBrmJMnNsnUkaXsy8Awy69TawXg6I06yPA5AUAh56gcpsK4Viq/EMF7jlrjt3oPp5
         CGDK2QhCnbtyla0OQ3jPJ5t0FkBpK2JMq9MN0zTKqQgfOyDn5XqBoj7wbJhDHeP1Gcz7
         tRc/99uEp7jrh3Mu6Q1PELUGAT8qahLiG0SJMHrjjk88nfeeR1ocKv7goFDKuW2h+B1F
         m8vFdSBpmbOG5nHy2AFvnARHKtxawM/ypXEIOwAoOet2a5M6mgxXCmv+InwrlPLEqXhH
         zt3A==
X-Gm-Message-State: AO0yUKWXmwwVUPNoiOH0yvzXwJ5GVUG9FMv/DIbybR3+Pi0dIV6b43b7
        +JpPdvmARdjcQPfMymeLEvI=
X-Google-Smtp-Source: AK7set863uk61gVrpFI/j5SSOpo+N1LHneIKsImfVSJa9CtuNFB0iOj9lm/KO0GnjRAm8+Obt7r5rA==
X-Received: by 2002:a17:902:c451:b0:19c:ff5d:1fd2 with SMTP id m17-20020a170902c45100b0019cff5d1fd2mr270466plm.8.1679335064773;
        Mon, 20 Mar 2023 10:57:44 -0700 (PDT)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id q2-20020a170902edc200b001a1a18a678csm7040042plk.148.2023.03.20.10.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 10:57:44 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     gregkh@linuxfoundation.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [PATCH v5 7/7] sign-file: fix do while styling issue
Date:   Mon, 20 Mar 2023 23:27:31 +0530
Message-Id: <20230320175731.79709-7-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320175731.79709-1-sshedi@vmware.com>
References: <20230320175731.79709-1-sshedi@vmware.com>
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

From: Shreenidhi Shedi <yesshedi@gmail.com>

Reported by checkpatch.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index e8dfbdd3eea3..0c95275c4564 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -147,7 +147,7 @@ static void drain_openssl_errors(void)
 		if (__cond) {				\
 			errx(1, fmt, ## __VA_ARGS__);	\
 		}					\
-	} while(0)
+	} while (0)
 
 static const char *key_pass;
 
-- 
2.39.2
