Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE52F683187
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjAaPa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjAaPaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:30:55 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A55F15574;
        Tue, 31 Jan 2023 07:30:53 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id k12so1592149ilv.10;
        Tue, 31 Jan 2023 07:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96om8t2sidbzcWJI83hHCTkanS4Z8I9qkmW3e+ASsa4=;
        b=UztB9v+TO8Vbd8rQ/zHU52XiIpEVCaoD4M0wCBfMNGLlXHkx2Rg/vn6Sm7KbwNPB7c
         ksWuawoKuvNV0jh0F07FE8DYbofjnUUAIt1KDw5xxJKrtaJWM7SywUDOUmoVMBHBbj6u
         K2ioyXN3cPWyUabwW2d/ow0jXBGc7lbFfW9s9GNekfJqWGVX5uT+Tms8cSa+Qq3wyJu6
         9jM6SMepaQrHs4lLMnocrZgZ4P1/Oql6Vzl/i9lQ2m3qcdkVC0FPoU1lA8tIwmE1CCDM
         zCoTtwbqzUMlT3iq5Ejs9qQ2OyrHccT59EFmd0wYwsXiTHimP/pvljsLJplpkzQUa1Iq
         TeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96om8t2sidbzcWJI83hHCTkanS4Z8I9qkmW3e+ASsa4=;
        b=Z+oi4gGBn02U1CCRbvaVsKssCA+SUwyj4ibVWeDFN/fx+ma9in+Q+SrujjZaGLamJz
         xa9fTJeSSBD450KLdJDO+WIf3q7wzCzeFsMpu02WDP1hAckJTRcrrGBQVs6R1gfD19WT
         kQ11uUAcUrRfo9utAZMH6ZKqESYEnXP9b3ochIevF+4QFMC4vmPRREJhOga8tlpPMUnq
         +JlN9KJGj6h3+qmgHrTvFn2m6dOWAPnS6JJr6Qw56Nr4/VH8ReI2C1+xDKW/LDpD+CXa
         H7jgBupr4eUi4xvKfbq6TbU8TQczWrzwzqdThGTOfnpQvuI2rG80wW2XneE5e/CTQCsu
         +Jew==
X-Gm-Message-State: AO0yUKUvTdqDejDJ+P706kDoDUNujdIvrdaIkEf2qmEp3NXhHdEos0CI
        MEiKoEH5/c+A2ulFCGtC2ov0VHtGJV71
X-Google-Smtp-Source: AK7set+CbRUJVZ2oScP/acmnuuLmIiorQHtl2vLl0D3MGFAQlCLy24ZSeaieHRqwQyjdE5khdAJ6Lw==
X-Received: by 2002:a05:6e02:178d:b0:311:10b7:c3c3 with SMTP id y13-20020a056e02178d00b0031110b7c3c3mr1817102ilu.16.1675179052672;
        Tue, 31 Jan 2023 07:30:52 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id eb10-20020a05620a480a00b0071323d3e37fsm9968963qkb.133.2023.01.31.07.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 07:30:52 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v8 1/1] ptrace,syscall_user_dispatch: checkpoint/restore support for SUD
Date:   Tue, 31 Jan 2023 09:44:58 -0500
Message-Id: <20230131144458.1980891-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230131144458.1980891-1-gregory.price@memverge.com>
References: <20230131144458.1980891-1-gregory.price@memverge.com>
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
 .../admin-guide/syscall-user-dispatch.rst     |  5 ++-
 include/linux/syscall_user_dispatch.h         | 18 +++++++++
 include/uapi/linux/ptrace.h                   |  9 +++++
 kernel/entry/syscall_user_dispatch.c          | 40 +++++++++++++++++++
 kernel/ptrace.c                               |  9 +++++
 5 files changed, 80 insertions(+), 1 deletion(-)

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
index a0ae443fb7df..5de2d64ace19 100644
--- a/include/linux/syscall_user_dispatch.h
+++ b/include/linux/syscall_user_dispatch.h
@@ -22,6 +22,12 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 #define clear_syscall_work_syscall_user_dispatch(tsk) \
 	clear_task_syscall_work(tsk, SYSCALL_USER_DISPATCH)
 
+int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
+	void __user *data);
+
+int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
+	void __user *data);
+
 #else
 struct syscall_user_dispatch {};
 
@@ -35,6 +41,18 @@ static inline void clear_syscall_work_syscall_user_dispatch(struct task_struct *
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
index 195ae64a8c87..6d2f3b86f932 100644
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
index 0b6379adff6b..05d4053a771e 100644
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
@@ -106,3 +107,42 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 
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
-- 
2.39.0

