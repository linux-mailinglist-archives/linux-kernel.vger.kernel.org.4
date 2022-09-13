Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2B55B6B95
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiIMK03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiIMKZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:25:58 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED335C377
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:25:57 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id b11-20020a170902d50b00b0017828988079so5104210plg.21
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=oQ9VKh7lKBpZzXj2SDeGJNjqxKiaiW5G7hAjfWWdBTU=;
        b=ilkl91q2khqrM3k6yYYhdoXWllgFVjk+BgNjetxjvxzPRTIgHR+e1BH5du9ZjCT5Gg
         /Rp4txgH4Xld1+h9SuxGB+lChOxQaox28ihex1kPfKOnOXW/9sYFoBcyqhMwf/GDY399
         1fvGa8XUDGMUpI2shvEAIo9bnobtIA9uDkUtTeTTdky/mos6Gav7XOhceAa39YP9bCkd
         bretutUYIfD+ivU4LgLuwoWuD01AE79HdShW3Vd3hLh7gm6P82vDnuEvyDYgV0mvsw9q
         loK4+nLST/kSXDPpVYcydTfYe94VUTFfZ34R87l6VQlA0cokTPGKdy3dy1leMCSZSv7d
         r3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=oQ9VKh7lKBpZzXj2SDeGJNjqxKiaiW5G7hAjfWWdBTU=;
        b=z8eLOTMXd7rvhdfzPHu1y4wSG1ILAl01cRQ8ec6Sv2iS8mXGTZxLokIrixxFiQArSF
         6VEno/oyWAscLGsfGGcs/fVTrSTBgcPhKkFKRh6+GT/2G6Ypu4vrZVUpbeq1tvbRa5UK
         UXChdL833s3acuIH52Hv47Scp0zXr/gtmoluqAbe4QaxhmcetoCAktUEYCerO+BSP4OH
         HfbwouQBvyLtQgY+UG+6aNDz1u6gHX/EDPf7s4EWCXtat6loBLqRnr2wAcjKxy4zyKjm
         uhFtyhVPF9sgqh1Nyl5idE5e+GfVnMhtry7rEqOZZb2Ii6hoiAtE+4wJV1Lok8SiB2QH
         hWKg==
X-Gm-Message-State: ACgBeo0dMQrz1aTKUyQiCl2SjPmHHuH8SO8UDYyGBac8+f9ykyTAHC0n
        lDNcE1g0Z3OHgpwCak0qZdjbOWeVl+o=
X-Google-Smtp-Source: AA6agR53NFC+FFC/wR5mAUlraCx09UxbNHyp1072SP0dv97lm+UTTmNdIVY7aC86t7sP/EZ9RqsOpL6xm/E=
X-Received: from avagin.kir.corp.google.com ([2620:15c:29:204:d94b:8d9d:2b23:6608])
 (user=avagin job=sendgmr) by 2002:a17:90b:4f44:b0:1f5:1310:9e7f with SMTP id
 pj4-20020a17090b4f4400b001f513109e7fmr3219470pjb.235.1663064756794; Tue, 13
 Sep 2022 03:25:56 -0700 (PDT)
Date:   Tue, 13 Sep 2022 03:25:50 -0700
In-Reply-To: <20220913102551.1121611-1-avagin@google.com>
Mime-Version: 1.0
References: <20220913102551.1121611-1-avagin@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220913102551.1121611-2-avagin@google.com>
Subject: [PATCH 1/2] Revert "selftests/timens: add a test for vfork+exit"
From:   Andrei Vagin <avagin@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>,
        Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next patch reverts the code that this test verified.

This reverts commit 6342140db6609a0c7d34f68c52b2947468e0e630.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 tools/testing/selftests/timens/Makefile     |  2 +-
 tools/testing/selftests/timens/vfork_exec.c | 90 ---------------------
 2 files changed, 1 insertion(+), 91 deletions(-)
 delete mode 100644 tools/testing/selftests/timens/vfork_exec.c

diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index f0d51d4d2c87..3a5936cc10ab 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,4 @@
-TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs exec futex vfork_exec
+TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs exec futex
 TEST_GEN_PROGS_EXTENDED := gettime_perf
 
 CFLAGS := -Wall -Werror -pthread
diff --git a/tools/testing/selftests/timens/vfork_exec.c b/tools/testing/selftests/timens/vfork_exec.c
deleted file mode 100644
index e6ccd900f30a..000000000000
--- a/tools/testing/selftests/timens/vfork_exec.c
+++ /dev/null
@@ -1,90 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-#include <errno.h>
-#include <fcntl.h>
-#include <sched.h>
-#include <stdio.h>
-#include <stdbool.h>
-#include <sys/stat.h>
-#include <sys/syscall.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <time.h>
-#include <unistd.h>
-#include <string.h>
-
-#include "log.h"
-#include "timens.h"
-
-#define OFFSET (36000)
-
-int main(int argc, char *argv[])
-{
-	struct timespec now, tst;
-	int status, i;
-	pid_t pid;
-
-	if (argc > 1) {
-		if (sscanf(argv[1], "%ld", &now.tv_sec) != 1)
-			return pr_perror("sscanf");
-
-		for (i = 0; i < 2; i++) {
-			_gettime(CLOCK_MONOTONIC, &tst, i);
-			if (abs(tst.tv_sec - now.tv_sec) > 5)
-				return pr_fail("%ld %ld\n", now.tv_sec, tst.tv_sec);
-		}
-		return 0;
-	}
-
-	nscheck();
-
-	ksft_set_plan(1);
-
-	clock_gettime(CLOCK_MONOTONIC, &now);
-
-	if (unshare_timens())
-		return 1;
-
-	if (_settime(CLOCK_MONOTONIC, OFFSET))
-		return 1;
-
-	for (i = 0; i < 2; i++) {
-		_gettime(CLOCK_MONOTONIC, &tst, i);
-		if (abs(tst.tv_sec - now.tv_sec) > 5)
-			return pr_fail("%ld %ld\n",
-					now.tv_sec, tst.tv_sec);
-	}
-
-	pid = vfork();
-	if (pid < 0)
-		return pr_perror("fork");
-
-	if (pid == 0) {
-		char now_str[64];
-		char *cargv[] = {"exec", now_str, NULL};
-		char *cenv[] = {NULL};
-
-		// Check that we are still in the source timens.
-		for (i = 0; i < 2; i++) {
-			_gettime(CLOCK_MONOTONIC, &tst, i);
-			if (abs(tst.tv_sec - now.tv_sec) > 5)
-				return pr_fail("%ld %ld\n",
-						now.tv_sec, tst.tv_sec);
-		}
-
-		/* Check for proper vvar offsets after execve. */
-		snprintf(now_str, sizeof(now_str), "%ld", now.tv_sec + OFFSET);
-		execve("/proc/self/exe", cargv, cenv);
-		return pr_perror("execve");
-	}
-
-	if (waitpid(pid, &status, 0) != pid)
-		return pr_perror("waitpid");
-
-	if (status)
-		ksft_exit_fail();
-
-	ksft_test_result_pass("exec\n");
-	ksft_exit_pass();
-	return 0;
-}
-- 
2.37.2.789.g6183377224-goog

