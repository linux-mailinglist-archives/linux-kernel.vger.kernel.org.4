Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8C96A251C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 00:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBXXcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 18:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBXXcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 18:32:03 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8CA6F821;
        Fri, 24 Feb 2023 15:31:55 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id i10so1080907plr.9;
        Fri, 24 Feb 2023 15:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxZBF0SmrCMO4Iwad1t9r0AlJbORhecxHnTRuEY3+uM=;
        b=OcBzGxtyAk6p2nVoKHvkpejxIqQ8sMYWvkOvAbbDVxxbGqX5onk9jVYlq6FKshBzrw
         6Rrg4NI6R/a9ErjZyONleGTE1YDflJfbjiW1F81+CTgX6TvsBrks/Fuk/W4cUCXIVB6N
         YHcMmjuRmofs1/0pY13DOVQhdAiOeM2/d/tma8JHHULl6axaD6bQ65jGGgtYpfRDEp7Z
         0UkxuozLhIyIUqOF0dXl9xSVUtcQZgcDjg1SFTKZpySxG62ITm0HXaDLm/D1qG0bVsRC
         f9cC6r7az9eHsVJ+9UapFgWnkzd+p85a6hRxTrdEFX7CgdGswV6GXh5pyVsG9MxkL+hE
         cLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxZBF0SmrCMO4Iwad1t9r0AlJbORhecxHnTRuEY3+uM=;
        b=VW3v5yvHEbC0xcpF6cKLaPDDVFjW9bTYmxcqo7anjBD0n1vc6l1iK1oe55qZnIxmMW
         PKGOj2UD1X6cvwpGiJYDQUqg7NWnAmtIF0uGyR1RktTx3lr8oWZuqpZGSdg9MPGK3WMy
         7k9+am+A+i2tOU/IzsH8UusQO85RJP+APbQoxDlc4VWEUIgSMVu0RfQP5yvsjsrDU0d5
         RifGgPh/2UIPAF+Be8f9DjEYWTPX+NLwMohFufzDoy8e2ozUZBRF5MdfJWCpMNCXl7fp
         XqY8hHkN4rF7vq5s54qLzS+lQkKFfOZledYWYwWTHJ5/ju1v9NIZiqFG7mzhJDEygBUg
         yDvg==
X-Gm-Message-State: AO0yUKVcbmWhXVf+Joh0MgKe9NYJCLZzjHeISjqcpWQ2gDt4c4O5W08G
        qXK+EoZkv7x2DdoFQldF0W5wUZnqwofh
X-Google-Smtp-Source: AK7set9GFzimTWNnGuiPv15uJYyJGXgjmVec0dPPJEaGr0pOH0XMkLoWnEsrET3FDLj3fygCWe5E4w==
X-Received: by 2002:a17:903:230f:b0:19a:96f9:f55b with SMTP id d15-20020a170903230f00b0019a96f9f55bmr23847152plh.27.1677281515144;
        Fri, 24 Feb 2023 15:31:55 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902868200b0019a5aa7eab0sm59680plo.54.2023.02.24.15.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 15:31:54 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v12 2/3] ptrace,syscall_user_dispatch: checkpoint/restore support for SUD
Date:   Fri, 24 Feb 2023 18:31:25 -0500
Message-Id: <20230224233126.1936-3-gregory.price@memverge.com>
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

Implement ptrace getter/setter interface for syscall user dispatch.

These prctl settings are presently write-only, making it impossible to
implement transparent checkpoint/restore via software like CRIU.

'on_dispatch' field is not exposed because it is a kernel-internal
only field that cannot be 'true' when returning to userland.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 .../admin-guide/syscall-user-dispatch.rst     |  4 ++
 include/linux/syscall_user_dispatch.h         | 18 ++++++++
 include/uapi/linux/ptrace.h                   | 29 +++++++++++++
 kernel/entry/syscall_user_dispatch.c          | 42 +++++++++++++++++++
 kernel/ptrace.c                               |  9 ++++
 5 files changed, 102 insertions(+)

diff --git a/Documentation/admin-guide/syscall-user-dispatch.rst b/Documentation/admin-guide/syscall-user-dispatch.rst
index 60314953c728..f7648c08297e 100644
--- a/Documentation/admin-guide/syscall-user-dispatch.rst
+++ b/Documentation/admin-guide/syscall-user-dispatch.rst
@@ -73,6 +73,10 @@ thread-wide, without the need to invoke the kernel directly.  selector
 can be set to SYSCALL_DISPATCH_FILTER_ALLOW or SYSCALL_DISPATCH_FILTER_BLOCK.
 Any other value should terminate the program with a SIGSYS.
 
+Additionally, a task's syscall user dispatch configuration can be peeked
+and poked via the PTRACE_(GET|SET)_SYSCALL_USER_DISPATCH_CONFIG ptrace
+requests. This is useful for checkpoint/restart software.
+
 Security Notes
 --------------
 
diff --git a/include/linux/syscall_user_dispatch.h b/include/linux/syscall_user_dispatch.h
index a0ae443fb7df..641ca8880995 100644
--- a/include/linux/syscall_user_dispatch.h
+++ b/include/linux/syscall_user_dispatch.h
@@ -22,6 +22,12 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 #define clear_syscall_work_syscall_user_dispatch(tsk) \
 	clear_task_syscall_work(tsk, SYSCALL_USER_DISPATCH)
 
+int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
+				     void __user *data);
+
+int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
+				     void __user *data);
+
 #else
 struct syscall_user_dispatch {};
 
@@ -35,6 +41,18 @@ static inline void clear_syscall_work_syscall_user_dispatch(struct task_struct *
 {
 }
 
+static inline int syscall_user_dispatch_get_config(struct task_struct *task,
+						   unsigned long size, void __user *data)
+{
+	return -EINVAL;
+}
+
+static inline int syscall_user_dispatch_set_config(struct task_struct *task,
+						   unsigned long size, void __user *data)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_GENERIC_ENTRY */
 
 #endif /* _SYSCALL_USER_DISPATCH_H */
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index 195ae64a8c87..1e77b02344c3 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -112,6 +112,35 @@ struct ptrace_rseq_configuration {
 	__u32 pad;
 };
 
+#define PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG 0x4210
+#define PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG 0x4211
+
+/*
+ * struct ptrace_sud_config - Per-task configuration for SUD
+ * @mode:	One of PR_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF
+ * @selector:	Tracee's user virtual address of SUD selector
+ * @offset:	SUD exclusion area (virtual address)
+ * @len:	Length of SUD exclusion area
+ *
+ * Used to get/set the syscall user dispatch configuration for tracee.
+ * process.  Selector is optional (may be NULL), and if invalid will produce
+ * a SIGSEGV in the tracee upon first access.
+ *
+ * If mode is PR_SYS_DISPATCH_ON, syscall dispatch will be enabled. If
+ * PR_SYS_DISPATCH_OFF, syscall dispatch will be disabled and all other
+ * parameters must be 0.  The value in *selector (if not null), also determines
+ * whether syscall dispatch will occur.
+ *
+ * The SUD Exclusion area described by offset/len is the virtual address space
+ * from which syscalls will not produce a user dispatch.
+ */
+struct ptrace_sud_config {
+	__u64 mode;
+	__u64 selector;
+	__u64 offset;
+	__u64 len;
+};
+
 /*
  * These values are stored in task->ptrace_message
  * by ptrace_stop to describe the current syscall-stop.
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 22396b234854..95b7218be71d 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -4,6 +4,7 @@
  */
 #include <linux/sched.h>
 #include <linux/prctl.h>
+#include <linux/ptrace.h>
 #include <linux/syscall_user_dispatch.h>
 #include <linux/uaccess.h>
 #include <linux/signal.h>
@@ -113,3 +114,44 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 {
 	return task_set_syscall_user_dispatch(current, mode, offset, len, selector);
 }
+
+int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
+				     void __user *data)
+{
+	struct syscall_user_dispatch *sd = &task->syscall_dispatch;
+	struct ptrace_sud_config config;
+
+	if (size != sizeof(struct ptrace_sud_config))
+		return -EINVAL;
+
+	if (test_task_syscall_work(task, SYSCALL_USER_DISPATCH))
+		config.mode = PR_SYS_DISPATCH_ON;
+	else
+		config.mode = PR_SYS_DISPATCH_OFF;
+
+	config.offset = sd->offset;
+	config.len = sd->len;
+	config.selector = (__u64)(uintptr_t)sd->selector;
+
+	if (copy_to_user(data, &config, sizeof(config)))
+		return -EFAULT;
+
+	return 0;
+}
+
+int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
+				     void __user *data)
+{
+	int rc;
+	struct ptrace_sud_config cfg;
+
+	if (size != sizeof(struct ptrace_sud_config))
+		return -EINVAL;
+
+	if (copy_from_user(&cfg, data, sizeof(struct ptrace_sud_config)))
+		return -EFAULT;
+
+	rc = task_set_syscall_user_dispatch(task, cfg.mode, cfg.offset,
+					    cfg.len, (char __user *)(uintptr_t)cfg.selector);
+	return rc;
+}
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 0786450074c1..443057bee87c 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -32,6 +32,7 @@
 #include <linux/compat.h>
 #include <linux/sched/signal.h>
 #include <linux/minmax.h>
+#include <linux/syscall_user_dispatch.h>
 
 #include <asm/syscall.h>	/* for syscall_get_* */
 
@@ -1259,6 +1260,14 @@ int ptrace_request(struct task_struct *child, long request,
 		break;
 #endif
 
+	case PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG:
+		ret = syscall_user_dispatch_set_config(child, addr, datavp);
+		break;
+
+	case PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG:
+		ret = syscall_user_dispatch_get_config(child, addr, datavp);
+		break;
+
 	default:
 		break;
 	}
-- 
2.39.1

