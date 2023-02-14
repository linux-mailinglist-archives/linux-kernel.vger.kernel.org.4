Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416F7695D99
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjBNIwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjBNIwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:52:31 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D5C21A02;
        Tue, 14 Feb 2023 00:52:29 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id n2so6055906ili.11;
        Tue, 14 Feb 2023 00:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wdgmr9FCTHr6FfCJC4qU7bda95BgVELZmiq8p+iD/s=;
        b=orUU6prFnfCFsuIVcXcAzgGHGlHgGq9BPSsEPg2F0h8qSVIcr3NLY6u2xArKmWbVQV
         KDzRAOGkm3JQXcQHa7y6WDHV85f/jazDQhhwYNVpqob2GioTbG1sMfnPtnAdFYXF7Mu4
         hu0kkzuyAASSmFrdc7A8AH/r3XRMA0lfnPhDt3pEwnyq5k7oBF+dm3S5tThsPh0JnGsX
         vBrQrRF9rv6i08LPqf0ZrpHj7o7C3glwNG8sOz8UCGNhDhVPULMY6tvcTdRr1dAmRRfe
         FuJ3DQ+yhdD/J5vmTJH8c8wVpNdDLINkZTB1m9Rv1qm0+m2xLqno97SgnKJkckvSX9hs
         9DiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wdgmr9FCTHr6FfCJC4qU7bda95BgVELZmiq8p+iD/s=;
        b=o6m6ZaznVXYoJbjRM+PcNPjYObrXgOV5eSvpW6OLfCbHHsQfO28bOk+P8mzUxC2O8v
         JEYwxVv5ZFDsZEPpPNDjk2lNAYl2YFGqiFjbJ14YIdECJBt77qkRwsi6dQjtpvLoZvnb
         g5Kxl7GM79wk+Fe9AlChfxkkukUejMuP/Y+D7b0cB9IKlo+yMa654Idrhp2KHjbZ1GVU
         3BuvG0nJr0iZ6YWk7vXlReuvXMJg9k7zBcWmxqo1usHHlVAlw6YU05GljmFiS8DzCTwM
         APn73gUNy98Iurmvk9tpd1ocRsLWIzqQ++b57h9zbSTczwj1wPDUNPLzYRbCiuHLLE9K
         INFg==
X-Gm-Message-State: AO0yUKUbfWpHrzTSkEjc56qzI5W04+75Bg+nM0gW3O5Y2R+Rq/kr7bEA
        kqxh95GLx9k7V6DCdFtMpD9d/xawgHOoL2g=
X-Google-Smtp-Source: AK7set+0Tqm25tLKR9bF6ywDLy2YRYFujTf0KHoA/bjAbffj6YnzrIDpRNxCuJXNo2BdpZZLdm2vCA==
X-Received: by 2002:a92:1a50:0:b0:315:4548:fc8e with SMTP id z16-20020a921a50000000b003154548fc8emr1451952ill.4.1676364748988;
        Tue, 14 Feb 2023 00:52:28 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id j11-20020a056e02014b00b0031406a0e1c0sm903434ilr.57.2023.02.14.00.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 00:52:28 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 2/2] ptrace,syscall_user_dispatch: checkpoint/restore support for SUD
Date:   Tue, 14 Feb 2023 03:52:15 -0500
Message-Id: <20230214085215.106708-3-gregory.price@memverge.com>
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

Implement ptrace getter/setter interface for syscall user dispatch.

These prctl settings are presently write-only, making it impossible to
implement transparent checkpoint/restore via software like CRIU.

'on_dispatch' field is not exposed because it is a kernel-internal
only field that cannot be 'true' when returning to userland.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 .../admin-guide/syscall-user-dispatch.rst     |  4 +
 include/linux/compat.h                        |  7 ++
 include/linux/syscall_user_dispatch.h         | 18 ++++
 include/uapi/linux/ptrace.h                   | 29 +++++++
 kernel/entry/syscall_user_dispatch.c          | 83 +++++++++++++++++++
 kernel/ptrace.c                               |  9 ++
 tools/testing/selftests/ptrace/.gitignore     |  1 +
 tools/testing/selftests/ptrace/Makefile       |  2 +-
 tools/testing/selftests/ptrace/get_set_sud.c  | 77 +++++++++++++++++
 9 files changed, 229 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/ptrace/get_set_sud.c

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
 
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 44b1736c95b5..56f06a0184e0 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -252,6 +252,13 @@ typedef struct compat_siginfo {
 	} _sifields;
 } compat_siginfo_t;
 
+struct compat_ptrace_sud_config {
+        compat_ulong_t mode;
+        compat_uptr_t selector;
+        compat_ulong_t offset;
+        compat_ulong_t len;
+};
+
 struct compat_rlimit {
 	compat_ulong_t	rlim_cur;
 	compat_ulong_t	rlim_max;
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
index 195ae64a8c87..49cbb165a219 100644
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
+	unsigned long mode;
+	__s8 *selector;
+	unsigned long offset;
+	unsigned long len;
+};
+
 /*
  * These values are stored in task->ptrace_message
  * by ptrace_stop to describe the current syscall-stop.
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 22396b234854..a47795b8d6f0 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -4,10 +4,12 @@
  */
 #include <linux/sched.h>
 #include <linux/prctl.h>
+#include <linux/ptrace.h>
 #include <linux/syscall_user_dispatch.h>
 #include <linux/uaccess.h>
 #include <linux/signal.h>
 #include <linux/elf.h>
+#include <linux/compat.h>
 
 #include <linux/sched/signal.h>
 #include <linux/sched/task_stack.h>
@@ -113,3 +115,84 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 {
 	return task_set_syscall_user_dispatch(current, mode, offset, len, selector);
 }
+
+int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
+		                     void __user *data)
+{
+	struct syscall_user_dispatch *sd = &task->syscall_dispatch;
+#ifdef CONFIG_COMPAT
+	if (unlikely(in_compat_syscall())) {
+		struct compat_ptrace_sud_config cfg32;
+
+		if (size != sizeof(struct compat_ptrace_sud_config))
+			return -EINVAL;
+
+		if (test_task_syscall_work(task, SYSCALL_USER_DISPATCH))
+			cfg32.mode = PR_SYS_DISPATCH_ON;
+		else
+			cfg32.mode = PR_SYS_DISPATCH_OFF;
+
+		cfg32.selector = ptr_to_compat(sd->selector);
+		cfg32.offset = (__u32)sd->offset;
+		cfg32.len = (__u32)sd->len;
+
+		if (copy_to_user(data, &cfg32, sizeof(cfg32))) {
+			return -EFAULT;
+		}
+	} else
+#endif
+	{
+		struct ptrace_sud_config config;
+		if (size != sizeof(struct ptrace_sud_config))
+			return -EINVAL;
+
+		if (test_task_syscall_work(task, SYSCALL_USER_DISPATCH))
+			config.mode = PR_SYS_DISPATCH_ON;
+		else
+			config.mode = PR_SYS_DISPATCH_OFF;
+
+		config.offset = sd->offset;
+		config.len = sd->len;
+		config.selector = sd->selector;
+
+		if (copy_to_user(data, &config, sizeof(config))) {
+			return -EFAULT;
+		}
+	}
+	return 0;
+}
+
+int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
+		                     void __user *data)
+{
+	int rc;
+#ifdef CONFIG_COMPAT
+	if (unlikely(in_compat_syscall())) {
+		struct compat_ptrace_sud_config cfg32;
+		char __user *selector;
+
+		if (size != sizeof(struct compat_ptrace_sud_config))
+			return -EINVAL;
+
+		if (copy_from_user(&cfg32, data, sizeof(cfg32))) {
+			return -EFAULT;
+		}
+
+		selector = compat_ptr(cfg32.selector);
+		rc = task_set_syscall_user_dispatch(task, cfg32.mode, cfg32.offset,
+						    cfg32.len, selector);
+	} else
+#endif
+	{
+		struct ptrace_sud_config cfg;
+		if (size != sizeof(struct ptrace_sud_config))
+			return -EINVAL;
+
+		if (copy_from_user(&cfg, data, sizeof(cfg))) {
+			return -EFAULT;
+		}
+		rc = task_set_syscall_user_dispatch(task, cfg.mode, cfg.offset,
+						    cfg.len, cfg.selector);
+	}
+	return rc;
+}
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 54482193e1ed..d99376532b56 100644
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
diff --git a/tools/testing/selftests/ptrace/.gitignore b/tools/testing/selftests/ptrace/.gitignore
index 792318aaa30c..b7dde152e75a 100644
--- a/tools/testing/selftests/ptrace/.gitignore
+++ b/tools/testing/selftests/ptrace/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 get_syscall_info
+get_set_sud
 peeksiginfo
 vmaccess
diff --git a/tools/testing/selftests/ptrace/Makefile b/tools/testing/selftests/ptrace/Makefile
index 2f1f532c39db..33a36b73bcb9 100644
--- a/tools/testing/selftests/ptrace/Makefile
+++ b/tools/testing/selftests/ptrace/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -std=c99 -pthread -iquote../../../../include/uapi -Wall
 
-TEST_GEN_PROGS := get_syscall_info peeksiginfo vmaccess
+TEST_GEN_PROGS := get_syscall_info peeksiginfo vmaccess get_set_sud
 
 include ../lib.mk
diff --git a/tools/testing/selftests/ptrace/get_set_sud.c b/tools/testing/selftests/ptrace/get_set_sud.c
new file mode 100644
index 000000000000..0dca681e6f1e
--- /dev/null
+++ b/tools/testing/selftests/ptrace/get_set_sud.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include "../kselftest_harness.h"
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/wait.h>
+#include <sys/syscall.h>
+#include <sys/prctl.h>
+
+#include "linux/ptrace.h"
+
+static int sys_ptrace(int request, pid_t pid, void *addr, void *data)
+{
+	return syscall(SYS_ptrace, request, pid, addr, data);
+}
+
+TEST(get_set_sud)
+{
+	struct ptrace_sud_config config;
+	pid_t child;
+	int ret = 0;
+	int status;
+
+	child = fork();
+	ASSERT_GE(child, 0);
+	if (child == 0) {
+		ASSERT_EQ(0, sys_ptrace(PTRACE_TRACEME, 0, 0, 0)) {
+			TH_LOG("PTRACE_TRACEME: %m");
+		}
+		kill(getpid(), SIGSTOP);
+		_exit(1);
+	}
+
+	waitpid(child, &status, 0);
+
+	memset(&config, 0xff, sizeof(config));
+	config.mode = PR_SYS_DISPATCH_ON;
+
+	ret = sys_ptrace(PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG, child,
+			 (void*)sizeof(config), &config);
+	if (ret < 0) {
+		ASSERT_EQ(errno, EIO);
+		goto leave;
+	}
+
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(config.mode, PR_SYS_DISPATCH_OFF);
+	ASSERT_EQ(config.selector, (void*)NULL);
+	ASSERT_EQ(config.offset, 0);
+	ASSERT_EQ(config.len, 0);
+
+	config.mode = PR_SYS_DISPATCH_ON;
+	config.selector = (void*)NULL;
+	config.offset = 0x400000;
+	config.len = 0x1000;
+
+	ret = sys_ptrace(PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG, child,
+			 (void*)sizeof(config), &config);
+
+	ASSERT_EQ(ret, 0);
+
+	memset(&config, 1, sizeof(config));
+	ret = sys_ptrace(PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG, child,
+			 (void*)sizeof(config), &config);
+
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(config.mode, PR_SYS_DISPATCH_ON);
+	ASSERT_EQ(config.selector, (void*)NULL);
+	ASSERT_EQ(config.offset, 0x400000);
+	ASSERT_EQ(config.len, 0x1000);
+
+leave:
+	kill(child, SIGKILL);
+}
+
+TEST_HARNESS_MAIN
-- 
2.39.1

