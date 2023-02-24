Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E377D6A2518
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 00:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBXXbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 18:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBXXbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 18:31:50 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C01B6F40F;
        Fri, 24 Feb 2023 15:31:48 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id oe18-20020a17090b395200b00236a0d55d3aso814814pjb.3;
        Fri, 24 Feb 2023 15:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdtGqct+MwH2EWhlTBd073J94ebfBu7k+yd8Ehy7SG8=;
        b=KJUGYPJkw++2Ec8nWAcnbODOkT6CGK+Nd+kT6OGag0WIlSNZfsYMvhJIYaiUmfypc8
         dasmuiFarZF4qDESqKlasnTWt+tdzhduM3Ewm7q7oOkmlUTeETpPWiXLZ9NNgz70sHF3
         gPj/HHPPHHfzOcUmys15QUut2/GEN+otj1GJILDtIzP8k1yJF4vRnyT1Tp1kPMzNO+n+
         83kYcAI2iLzvsBPN3PFlPBpbS9z/lySijKTefnw+TOrNZxstX8YRV1iOusaJezDiFlOu
         pXEd4ig6Dr8vFNn83jq9zXmEEGow6ATxksTzcR+Z8DK6+xemriIIMfvGjNz4vWyfhnyx
         UqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdtGqct+MwH2EWhlTBd073J94ebfBu7k+yd8Ehy7SG8=;
        b=7Vp5lyws2DRkzX5o4vGhnlt1ZUa8SrTrv1MBvUN8i/El6bC3865WiXyZrjsxCsysEf
         no4F/WftwwB0b12tRTmP3k/YoCczb4locGxGdqkinxgCcm9bhTaaKcWn4qq0g6hG3E8x
         TOn8Vilm6z82+o9p7byX7ZiMVP5pkXRRCs4KQAQaWCCxVt/xDVm8JRcfAjX0VP6nBDbD
         x1JmzFE9qilI30XLwyhv/ucoZDV6uspxAVj3q2zBkBUrUwr7Rd43xXQv7Hg8lRyaC8Pt
         fgQFYvPO/cntAdQUyUKnKYaAUKtI0/aUCg9zNLxZmMQtASOxh75cGSVckaFvVApOcWIo
         caPw==
X-Gm-Message-State: AO0yUKXKZuzBcQbI5ioNjSuKe3N+6RBle4x/11pFWXpxVGBxGiZ3W4+w
        eH9rNgcJOBw5gqN3yzCGZlRLDcMp8FgL
X-Google-Smtp-Source: AK7set+wN+Fbn1LUoT7s7KSSaf/NWiADYACdCCyzrNNFE5gIGfQ/WP9rPmbnmVwna8nEWvMJBY8lYQ==
X-Received: by 2002:a17:903:707:b0:19c:eaa1:edd8 with SMTP id kk7-20020a170903070700b0019ceaa1edd8mr631103plb.12.1677281507731;
        Fri, 24 Feb 2023 15:31:47 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902868200b0019a5aa7eab0sm59680plo.54.2023.02.24.15.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 15:31:47 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v12 1/3] syscall_user_dispatch: helper function to operate on given task
Date:   Fri, 24 Feb 2023 18:31:24 -0500
Message-Id: <20230224233126.1936-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230224233126.1936-1-gregory.price@memverge.com>
References: <20230224233126.1936-1-gregory.price@memverge.com>
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

