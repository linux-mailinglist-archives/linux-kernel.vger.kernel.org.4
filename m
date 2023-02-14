Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3939695D96
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjBNIwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjBNIw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:52:27 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F1017CDF;
        Tue, 14 Feb 2023 00:52:26 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id d16so5528724ioz.12;
        Tue, 14 Feb 2023 00:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdtGqct+MwH2EWhlTBd073J94ebfBu7k+yd8Ehy7SG8=;
        b=QO2nc9hP52oaOnxcJwqbRlmqtiIBKAPdIlLkAPcQDMGPqZ5m1ve4sFicQBDHQM0QeS
         0OQ24uA/XKYBmEpYzbrNyhPizOjEcCpmBz3a/c+b7MCNymtXsKXJOfOSYAerqVDNtRsL
         dO/kAg46yzGa7+VrB/sNUYm1rSv+UEg1o7QtbL2DN/FVZwRuSOi/ng5/Ze8tjcg7oj35
         +Xe+ZLvx4HAzfewkzzRZLNAzoQRlZ8wEVuvrVMRa6Ae2jBd9/qPl2sIGas77r8dw87iR
         rxvJF81EVIdJZeg2tnhaWZu6Y+HpDSsqapYtqvA8IuKSVLMbzDUrXexTN4MDY4DF8sNx
         0G9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdtGqct+MwH2EWhlTBd073J94ebfBu7k+yd8Ehy7SG8=;
        b=2TCEJNyZe/oFvv+FWlE45JQlxTdSkBQcaqAZj+YVkRR5Q2ul5nWAp+Fm421MacjSbQ
         EDRePOQLw9uvBwt4717/r8atpEYoIQs0cVEIqP/HQZCt68MC8R5xeWKzgTpYl8NnEaaS
         aWdpG+Vsa63JXx0jHCDs+3GbVCdfWnbHmeuaiZMkjTR8biRA4UBjfUP+/mAsduABPNO4
         4R/VTb8OFKMCIOKXVOOMYKLTirn61qk7o+5+7eSqu1sMwzcXzoYPwYyx1FmGESM/0RpC
         zhr4AhTlUBWHAA/SrK17cUo9GskcEbg48einAJ3xPwqy8nZe2xRkQ26+iKHERSR9OQHt
         D2aw==
X-Gm-Message-State: AO0yUKWKt1/cQoAcePd/HKLolKsSmk1BLv66+1ISbOh/H0POx5ZOVcqe
        l+Mbo3l+2J/edZ+B49ck2TKS7JDVbuAaUHk=
X-Google-Smtp-Source: AK7set9Fl4E5Tuu7e0BGy1S8K3JreABDOpOpLe+Oh813XvcRI2seVuPGaSSqFSKD0Nl3S1+86KTBwA==
X-Received: by 2002:a5d:968b:0:b0:729:63de:4546 with SMTP id m11-20020a5d968b000000b0072963de4546mr925469ion.3.1676364745446;
        Tue, 14 Feb 2023 00:52:25 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id j11-20020a056e02014b00b0031406a0e1c0sm903434ilr.57.2023.02.14.00.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 00:52:25 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 1/2] syscall_user_dispatch: helper function to operate on given task
Date:   Tue, 14 Feb 2023 03:52:14 -0500
Message-Id: <20230214085215.106708-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214085215.106708-1-gregory.price@memverge.com>
References: <20230214085215.106708-1-gregory.price@memverge.com>
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

