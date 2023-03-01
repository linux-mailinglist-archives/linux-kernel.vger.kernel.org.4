Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86CE6A75AD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjCAU65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCAU6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:58:54 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A054DE3F;
        Wed,  1 Mar 2023 12:58:53 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id cc12-20020a05683061cc00b00693daa9016fso8360459otb.2;
        Wed, 01 Mar 2023 12:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677704333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdtGqct+MwH2EWhlTBd073J94ebfBu7k+yd8Ehy7SG8=;
        b=IPLMtaSO4optaEwUy0SdNfGqb/Tmst+FwE69yKgtFJNNflymrIkknlamomWDk8Dn4r
         UNMyZUyb/CVC+Y7W5fvn9vo84Q1+waeShm1ey1SwuDuADKsVLbJUfApqvSrvl3PdhFfx
         j3p2N2mpEDiFa71kSJ5TWMNbgVywlGgTNrym+oW0AHIQUSq6tWuzuvRh3vCb9Hr6zoFs
         WIA68DAzJTvSU98n28O3Q0Y74pBXe+SQpZ24gBmMKeYYFEem0S/6MkKd4ZhpAuZhtFMR
         Xhgv3NIIbzymEjx8auUp7iw4vCgA0l0TZ+DlPkz+JJ8P3zKbWpUvvtZJMwHrx0WKIA9i
         i2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677704333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdtGqct+MwH2EWhlTBd073J94ebfBu7k+yd8Ehy7SG8=;
        b=Vye75BaWbYIZdnLXQraQayp9btrPrnJhW6O0YFk1ZoP2xDM44RJn03mvixwDN7NXIF
         OolGy3SmTuxEZadSBJpujSHQIuEtpFWqjfTpUsJRCi8AJBkgxIUpKXt1iZgao+imeSdv
         vhOjLyZOqdAAY6X6EmYlOZ6rGDJkFgPzdiDDbtUvHRQz+fdXDrGZtTeDuERwSfxyC6OQ
         XHWf24H3+KjC42n+H5EtyKq2fyVWVptatq2eb/nzA2OjTCRO8i2JU+lLIXKXwKFNIAZI
         /3KPzXapwPbBBv+j/yuUtZjnddK1YNnftVXyGYoDwRvAm3piLBb3wcPf/lUfRm9Jz8rV
         lbrA==
X-Gm-Message-State: AO0yUKWZXP+DYs8uXH2ipZ8MIBm4OghW4ulVXJs1VI4VNfXgA/bWScUe
        veMCsXZSSKo2gIN5kJ3CzEd6hB14QxZo
X-Google-Smtp-Source: AK7set/lmRi5GSmTmOgb8SvwW6VRsffYsjxJ2lOXKH1n3w2Q2d2vUY1i/AhCrvBOnQawAeNGc6Un3A==
X-Received: by 2002:a05:6830:314a:b0:693:d998:f52f with SMTP id c10-20020a056830314a00b00693d998f52fmr4690232ots.35.1677704332923;
        Wed, 01 Mar 2023 12:58:52 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id bt55-20020a05683039f700b0068abc8e786fsm5273899otb.10.2023.03.01.12.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 12:58:52 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v13 1/3] syscall_user_dispatch: helper function to operate on given task
Date:   Wed,  1 Mar 2023 15:58:41 -0500
Message-Id: <20230301205843.2164-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230301205843.2164-1-gregory.price@memverge.com>
References: <20230301205843.2164-1-gregory.price@memverge.com>
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

Preparatory patch ahead of set/get interfaces which will allow a
ptrace to get/set the syscall user dispatch configuration of a task.

This will simplify the set interface and consolidates error paths.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 kernel/entry/syscall_user_dispatch.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 0b6379adff6b..22396b234854 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -68,8 +68,9 @@ bool syscall_user_dispatch(struct pt_regs *regs)
 	return true;
 }
 
-int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
-			      unsigned long len, char __user *selector)
+static int task_set_syscall_user_dispatch(struct task_struct *task, unsigned long mode,
+					  unsigned long offset, unsigned long len,
+					  char __user *selector)
 {
 	switch (mode) {
 	case PR_SYS_DISPATCH_OFF:
@@ -94,15 +95,21 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 		return -EINVAL;
 	}
 
-	current->syscall_dispatch.selector = selector;
-	current->syscall_dispatch.offset = offset;
-	current->syscall_dispatch.len = len;
-	current->syscall_dispatch.on_dispatch = false;
+	task->syscall_dispatch.selector = selector;
+	task->syscall_dispatch.offset = offset;
+	task->syscall_dispatch.len = len;
+	task->syscall_dispatch.on_dispatch = false;
 
 	if (mode == PR_SYS_DISPATCH_ON)
-		set_syscall_work(SYSCALL_USER_DISPATCH);
+		set_task_syscall_work(task, SYSCALL_USER_DISPATCH);
 	else
-		clear_syscall_work(SYSCALL_USER_DISPATCH);
+		clear_task_syscall_work(task, SYSCALL_USER_DISPATCH);
 
 	return 0;
 }
+
+int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
+			      unsigned long len, char __user *selector)
+{
+	return task_set_syscall_user_dispatch(current, mode, offset, len, selector);
+}
-- 
2.39.1

