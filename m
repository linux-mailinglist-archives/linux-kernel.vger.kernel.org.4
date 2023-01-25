Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46F067A903
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 03:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbjAYCvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 21:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbjAYCvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 21:51:45 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9078E539BD;
        Tue, 24 Jan 2023 18:51:41 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id i17so8284242ila.9;
        Tue, 24 Jan 2023 18:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVOnr9X3NZfRTxwQMKhCnEXQXYREpSkn5siHkgp3Q+8=;
        b=O139B5k8qR284vjoPwjnF+U5bBM3w6GG+l7LlqDrBkJsrCn5xxs8rjRcIQHWF4NUP8
         KJTz1Lv8kzENCOYOJLkqlwRvp2zLocpiCQKn9X5UxuwgdQS2kpYcaqNnCIfyBUiUjitY
         ugtGIIw06VPAj4o0kkOcJFQy3Ih6WiMqsl7rrTcHY6ItPPJMJDEfwk/O6ShvxKJcslpW
         Y9/Ia9t3wIMCR5Ip6AKf2MVQsjxUzzpaRcNhZ3mh6AK2Mb8NY3259PfSg4Bin/dotOZV
         VZMcMp+Qa62bD4aZZhGfCbnU94mfMrlYVkyfFYOyIEH5PVqtMXe2ISZ7jjD7XQTvts51
         Fakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVOnr9X3NZfRTxwQMKhCnEXQXYREpSkn5siHkgp3Q+8=;
        b=F4FY+BXqcv+/ZuT7ygaS+CtQdVXUjUKLMTwrrXYEamk1xTfU659Ahj49imueZ32qiM
         9dfnSBp26CXF908VhGu5D2V9DNBHTBe3O0kq1+0V3OSaeOjhv97wa1SMAQx5QoRSV4nd
         1xClwZI00qF6457irfFGbEaVSBAtT/L0CTvwJ+ePj6tEevPOh2QKDMVlhJTD9tUlrQ4H
         vhYGDATsbXk0qEGPMW8z0Yf44MTREELLGfiB7u4OHdKDqsdQEkjI6ey6LWn64UEBYa3n
         tB9W1pinVBSPdide8LjJRuLujxffrTbOSP2lpKZx10OheRJDd5SJprEs9vKOSq2+BXnY
         0ngg==
X-Gm-Message-State: AO0yUKWjVe5NfC7lrtael/2JGb3VFYuepXUqLnc5XAH0l7ozgzE1s7JX
        OL2KogcBDoRgNFQG9iwyX2DH7pswvmix
X-Google-Smtp-Source: AK7set9eyd4ZgOq0rRch2zEwPO05tvZoZD+qfbBf/C5js+MubnuOM8i+lJ5RLQH1ZbCuJgNUt0QriQ==
X-Received: by 2002:a05:6e02:20c3:b0:310:a12c:78a2 with SMTP id 3-20020a056e0220c300b00310a12c78a2mr872263ilq.6.1674615100667;
        Tue, 24 Jan 2023 18:51:40 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id v5-20020a023845000000b0038a13e116a1sm1265722jae.61.2023.01.24.18.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 18:51:40 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v6 2/2] ptrace,syscall_user_dispatch: add a getter/setter for sud configuration
Date:   Tue, 24 Jan 2023 21:51:26 -0500
Message-Id: <20230125025126.787431-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125025126.787431-1-gregory.price@memverge.com>
References: <20230125025126.787431-1-gregory.price@memverge.com>
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
implement transparent checkpoint via software like CRIU.

This is modeled after a similar interface for SECCOMP, which can have
its configuration dumped by ptrace.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 .../admin-guide/syscall-user-dispatch.rst     |  5 ++-
 include/linux/syscall_user_dispatch.h         | 19 +++++++++
 include/uapi/linux/ptrace.h                   |  9 +++++
 kernel/entry/syscall_user_dispatch.c          | 40 +++++++++++++++++++
 kernel/ptrace.c                               |  9 +++++
 5 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/syscall-user-dispatch.rst b/Documentation/admin-guide/syscall-user-dispatch.rst
index 60314953c728..a23ae21a1d5b 100644
--- a/Documentation/admin-guide/syscall-user-dispatch.rst
+++ b/Documentation/admin-guide/syscall-user-dispatch.rst
@@ -43,7 +43,10 @@ doesn't rely on any of the syscall ABI to make the filtering.  It uses
 only the syscall dispatcher address and the userspace key.
 
 As the ABI of these intercepted syscalls is unknown to Linux, these
-syscalls are not instrumentable via ptrace or the syscall tracepoints.
+syscalls are not instrumentable via ptrace or the syscall tracepoints,
+however an interfaces to suspend, checkpoint, and restore syscall user
+dispatch configuration has been added to ptrace to assist userland
+checkpoint/restart software.
 
 Interface
 ---------
diff --git a/include/linux/syscall_user_dispatch.h b/include/linux/syscall_user_dispatch.h
index a0ae443fb7df..9e1bd0d87c1e 100644
--- a/include/linux/syscall_user_dispatch.h
+++ b/include/linux/syscall_user_dispatch.h
@@ -22,6 +22,13 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 #define clear_syscall_work_syscall_user_dispatch(tsk) \
 	clear_task_syscall_work(tsk, SYSCALL_USER_DISPATCH)
 
+int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
+	void __user *data);
+
+int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
+	void __user *data);
+
+
 #else
 struct syscall_user_dispatch {};
 
@@ -35,6 +42,18 @@ static inline void clear_syscall_work_syscall_user_dispatch(struct task_struct *
 {
 }
 
+static inline int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
+	void __user *data)
+{
+	return -EINVAL;
+}
+
+static inline int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
+	void __user *data)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_GENERIC_ENTRY */
 
 #endif /* _SYSCALL_USER_DISPATCH_H */
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index ba9e3f19a22c..53ef59134dcb 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -112,6 +112,15 @@ struct ptrace_rseq_configuration {
 	__u32 pad;
 };
 
+#define PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG 0x4210
+#define PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG 0x4211
+struct syscall_user_dispatch_config {
+	__u64 mode;
+	__s8 *selector;
+	__u64 offset;
+	__u64 len;
+};
+
 /*
  * These values are stored in task->ptrace_message
  * by ptrace_stop to describe the current syscall-stop.
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index b5ec75164805..ee02ce21f75e 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -111,3 +111,43 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 
 	return 0;
 }
+
+int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
+		void __user *data)
+{
+	struct syscall_user_dispatch *sd = &task->syscall_dispatch;
+	struct syscall_user_dispatch_config config;
+
+	if (size != sizeof(struct syscall_user_dispatch_config))
+		return -EINVAL;
+
+	if (test_syscall_work(SYSCALL_USER_DISPATCH))
+		config.mode = PR_SYS_DISPATCH_ON;
+	else
+		config.mode = PR_SYS_DISPATCH_OFF;
+
+	config.offset = sd->offset;
+	config.len = sd->len;
+	config.selector = sd->selector;
+
+	if (copy_to_user(data, &config, sizeof(config)))
+		return -EFAULT;
+
+	return 0;
+}
+
+int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
+		void __user *data)
+{
+	struct syscall_user_dispatch_config config;
+	int ret;
+
+	if (size != sizeof(struct syscall_user_dispatch_config))
+		return -EINVAL;
+
+	if (copy_from_user(&config, data, sizeof(config)))
+		return -EFAULT;
+
+	return set_syscall_user_dispatch(config.mode, config.offset, config.len,
+			config.selector);
+}
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index a348b68d07a2..76de46e080e2 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -32,6 +32,7 @@
 #include <linux/compat.h>
 #include <linux/sched/signal.h>
 #include <linux/minmax.h>
+#include <linux/syscall_user_dispatch.h>
 
 #include <asm/syscall.h>	/* for syscall_get_* */
 
@@ -1263,6 +1264,14 @@ int ptrace_request(struct task_struct *child, long request,
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
2.39.0

