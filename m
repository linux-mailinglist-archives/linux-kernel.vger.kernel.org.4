Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B30169E8F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjBUUS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjBUUSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:18:54 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5CB28213;
        Tue, 21 Feb 2023 12:18:49 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id v3so5650317wrp.2;
        Tue, 21 Feb 2023 12:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jz1OiOnSviBpi5QoeSlUTSo6h0fbDqBjwSqhSAL1yLs=;
        b=XrB+7dycaA5jvXzKjAP4lOxDK/IScE1hXVJG434cSqHT/cZUiS1hKLlKOZ4b7hUhIT
         B7MIkLBmUZopAdWXbczLQntCUj/wUc8YRrz6CHQjBm5r6joc5HnLo0CmA++s7jJxd2zG
         pIaq4jdakJ0LblcTgGxdtwT0fMa38ZLy5qQKSG7duxqfWEvkBhj/xKAEv+p6ZacXWv3Y
         oXP2RBePQE+PDg47eWDgidGYUhnS4HtwGBJNEBWQ2a5laFQ+xOfoD0HfdZLFxZJQDs4P
         vYbg7jeE9T7cQcJJmwn+ZbnW8VusM48q0Kc6i+cWDc4UbNfjvTISbYKHStpQXRd0T/r/
         yCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jz1OiOnSviBpi5QoeSlUTSo6h0fbDqBjwSqhSAL1yLs=;
        b=DuIFs27+4IoUiPi+ogO77KosREraGVd3H5lSrayYG9W2AmRi7ZB+h//EfxsQ9DUffI
         0BjawDA2MtLtubYb5QeqM9/lceXt/RYDaa/sWynLGA7qj9fxGq0JziPm2aWGw5mbOZ6R
         yz3LnScau+nJNRcGo7ZRWA/YTWcwxAH8oeFaYRPsStujCtJpP9alCF09HEnevZMPrRDc
         TRLjLAIhVq4KKseZiyBfr47cYzAZjtD2/E4CQFTSVMLfRLJoVceUhSqhLkVQgPuBpCMb
         3boTZL+pHXbfI7gc0Wi2IJ5V5MicsgEQn8Ft13mRhRW//3Uq+JiZt+CblEyUBuWY0vpA
         41YQ==
X-Gm-Message-State: AO0yUKUsOCGDp9/LE1uyKQ4QT6dfwbQelAK9TTYOEURhHkFFQWTiEMUs
        WIsg+Frs8BFMJ8nJ15erHmY7d6piksLW
X-Google-Smtp-Source: AK7set92y7FypgHIfBanMGkx+LSuS2u6D4nqPQaJOze4RBZ3LRFwpXx3JNffPk66rOLD99HhOtd+dQ==
X-Received: by 2002:a5d:4208:0:b0:2c5:4c8f:7c0 with SMTP id n8-20020a5d4208000000b002c54c8f07c0mr4224464wrq.63.1677010727677;
        Tue, 21 Feb 2023 12:18:47 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id u14-20020a5d434e000000b002c5a1bd527dsm4656080wrr.96.2023.02.21.12.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:18:47 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v11 2/2] ptrace,syscall_user_dispatch: checkpoint/restore support for SUD
Date:   Tue, 21 Feb 2023 15:17:44 -0500
Message-Id: <20230221201740.2236-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230221201740.2236-1-gregory.price@memverge.com>
References: <20230221201740.2236-1-gregory.price@memverge.com>
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
 include/linux/syscall_user_dispatch.h         | 18 +++++
 include/uapi/linux/ptrace.h                   | 30 ++++++++
 kernel/entry/syscall_user_dispatch.c          | 40 ++++++++++
 kernel/ptrace.c                               |  9 +++
 tools/testing/selftests/ptrace/.gitignore     |  1 +
 tools/testing/selftests/ptrace/Makefile       |  2 +-
 tools/testing/selftests/ptrace/get_set_sud.c  | 77 +++++++++++++++++++
 8 files changed, 180 insertions(+), 1 deletion(-)
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
index 195ae64a8c87..033f4db75c60 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -112,6 +112,36 @@ struct ptrace_rseq_configuration {
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
+	__u8  mode;
+	__u8  pad[7];
+	__u64 selector;
+	__u64 offset;
+	__u64 len;
+};
+
 /*
  * These values are stored in task->ptrace_message
  * by ptrace_stop to describe the current syscall-stop.
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 22396b234854..08e8b377557f 100644
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
@@ -113,3 +114,42 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 {
 	return task_set_syscall_user_dispatch(current, mode, offset, len, selector);
 }
+
+int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
+		                     void __user *data)
+{
+	struct syscall_user_dispatch *sd = &task->syscall_dispatch;
+	struct ptrace_sud_config config;
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
+	config.selector = (__u64)sd->selector;
+
+	if (copy_to_user(data, &config, sizeof(config))) {
+		return -EFAULT;
+	}
+	return 0;
+}
+
+int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
+		                     void __user *data)
+{
+	int rc;
+	struct ptrace_sud_config cfg;
+	if (size != sizeof(struct ptrace_sud_config))
+		return -EINVAL;
+
+	if (copy_from_user(&cfg, data, sizeof(cfg))) {
+		return -EFAULT;
+	}
+	rc = task_set_syscall_user_dispatch(task, cfg.mode, cfg.offset,
+					    cfg.len, (void __user*)cfg.selector);
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
index 000000000000..c4e7b87cab03
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
+	ASSERT_EQ(config.selector, 0);
+	ASSERT_EQ(config.offset, 0);
+	ASSERT_EQ(config.len, 0);
+
+	config.mode = PR_SYS_DISPATCH_ON;
+	config.selector = 0;
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
+	ASSERT_EQ(config.selector, 0);
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

