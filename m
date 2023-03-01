Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06C36A75B6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjCAU7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjCAU7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:59:05 -0500
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com [IPv6:2001:4860:4864:20::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636B651F94;
        Wed,  1 Mar 2023 12:59:01 -0800 (PST)
Received: by mail-oa1-x41.google.com with SMTP id 586e51a60fabf-17235c8dab9so15847613fac.7;
        Wed, 01 Mar 2023 12:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677704341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ogl86awpdsmdZqeffQnskO7M/1aafsTEVLhtpf3qa4Y=;
        b=NJd1oRfO+b8UXpnw2BwVoyMMir/MiR/iutmK6N+WdGcPOSjRfaGA0XsKjukfFhNBrm
         2Pj01Vy0fB81Hqp+1Ge7P7VcrEyrBkBv292Jh2iB1L3RTZ7PXe6JM7FUpXT4sOeQxeAS
         LLHj4aYDFO5n9S0WiuVe2Ro91RF3sUejuhTlXOEsyoyRneY+3OsRI7aoJ4U2QTDneYvJ
         US1jj6zz/phgGBpGEuN0ftfMPZcGQ64pG6xrpFwXIUtJrrbEYO7g4spIXQcy5gvbZG4n
         wCn+QzgRTeMFpqf74y0DJdhv9cNe5+N3I4ovoC/3Jma2j67ogKhxhofY75qC41mFCGIM
         OVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677704341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ogl86awpdsmdZqeffQnskO7M/1aafsTEVLhtpf3qa4Y=;
        b=pFmC+LoBUO4fvyUQlY9maZDW1zgUHAetrd8bvJwyGQaLS1kF8PjIQbN1a//0cnZMdv
         Db+SgWzqVOfxhXvfWlnTKbcXsFI79xb/8lbqgvvhLfVexBTdidnOkxDghga7FWFEsmd8
         OTDVjwHBt3g/QIEky6c5J6KmUrnXepYciDlCIBRNw0R2B+i8hCm0wusGPMC8nb4zApwP
         nuvJp6Nvepmhpvrg4CJB/isYv9VFEaM8mH4JRVCFxwcMfot1V9KECLJd7wQixDp9olyA
         CXlVVo18iXeKR+Klb8TDYJDoyOEN03sEwg4CN6ZewxXqeev8oSSRIjkLu2KPvDOXwAHw
         e0Bg==
X-Gm-Message-State: AO0yUKVotO7GA7ZYQaUZyXlPAzAnAMG250QMeZjLX+m7vdH2baw5gnLI
        uAxzQEt28Oo+RMs0ploVE4SHg32Ezlwn
X-Google-Smtp-Source: AK7set92szTndhxgCbSTUqxdd4hnPnCRKMVSjUspA40Jb/ri74sTXdapXzMRuIbw0TSV13+x+6YxfA==
X-Received: by 2002:a05:6870:a904:b0:16a:ad7b:b471 with SMTP id eq4-20020a056870a90400b0016aad7bb471mr4395000oab.38.1677704340842;
        Wed, 01 Mar 2023 12:59:00 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id bt55-20020a05683039f700b0068abc8e786fsm5273899otb.10.2023.03.01.12.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 12:59:00 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v13 3/3] selftest,ptrace: Add selftest for syscall user dispatch config api
Date:   Wed,  1 Mar 2023 15:58:43 -0500
Message-Id: <20230301205843.2164-4-gregory.price@memverge.com>
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

Validate that the following new ptrace requests work as expected

* PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG
  - returns the contents of task->syscall_dispatch if enabled

* PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG
  - sets the contents of task->syscall_dispatch

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 tools/testing/selftests/ptrace/.gitignore    |  1 +
 tools/testing/selftests/ptrace/Makefile      |  2 +-
 tools/testing/selftests/ptrace/get_set_sud.c | 72 ++++++++++++++++++++
 3 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/ptrace/get_set_sud.c

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
index 96ffa94afb91..1c631740a730 100644
--- a/tools/testing/selftests/ptrace/Makefile
+++ b/tools/testing/selftests/ptrace/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -std=c99 -pthread -Wall $(KHDR_INCLUDES)
 
-TEST_GEN_PROGS := get_syscall_info peeksiginfo vmaccess
+TEST_GEN_PROGS := get_syscall_info peeksiginfo vmaccess get_set_sud
 
 include ../lib.mk
diff --git a/tools/testing/selftests/ptrace/get_set_sud.c b/tools/testing/selftests/ptrace/get_set_sud.c
new file mode 100644
index 000000000000..5297b10d25c3
--- /dev/null
+++ b/tools/testing/selftests/ptrace/get_set_sud.c
@@ -0,0 +1,72 @@
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
+			 (void *)sizeof(config), &config);
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
+			 (void *)sizeof(config), &config);
+
+	ASSERT_EQ(ret, 0);
+
+	memset(&config, 1, sizeof(config));
+	ret = sys_ptrace(PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG, child,
+			 (void *)sizeof(config), &config);
+
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(config.mode, PR_SYS_DISPATCH_ON);
+	ASSERT_EQ(config.selector, 0);
+	ASSERT_EQ(config.offset, 0x400000);
+	ASSERT_EQ(config.len, 0x1000);
+
+	kill(child, SIGKILL);
+}
+
+TEST_HARNESS_MAIN
-- 
2.39.1

