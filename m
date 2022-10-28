Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84BB611B75
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJ1UQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJ1UQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:16:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033F3993BB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:16:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l6so5617088pjj.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IOiu8bqPJKVSoE4Ig9MDr5gwWENVkLHvLn9UAZPUG7E=;
        b=EOLgFMdDVpH8+ppW3ySJ6QinuqZqgM1CdFpUdWlmu7AuITZGFaxfL2sxXj+o8eeNtQ
         KqdW2deenHgpiUIH9TVBc7ABJNkDB3yOxmlGMFzloHlJ1qa9BrPX4n1PwYYTJtrK8jMS
         7989loF/dRdPjl3cFs5AI6cTGAm0QEWOyjh9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOiu8bqPJKVSoE4Ig9MDr5gwWENVkLHvLn9UAZPUG7E=;
        b=QWTZgJlNFqaVriy1yXhAWh252Do1RGJafbkDXJ7QdQmNsIKHJjLa2fxKNPsSpHh2YR
         sfSgarID7DU8rbsmWVE2r4blnUVyTr3DYEoKRZI3wgPAyMfVzcBvQvog0+zb4DeVM9Gk
         aK9UNxrn1UocbdmKZtqz1ZVcNeat4P+7WphGZanPfkTyQdqgd+m4Itp5QI6SSmZwNjVo
         aeG1HMx5+S4Nu+irjuNsjqEJWIR7c+wh+zbCd1BTfJ9ULBPuAvjNodJEy5+8a3FCh9an
         c1nmuhDTSHqQZVO7ayda5rHj5+lA/29ASCwzaAkXR3PUWjQCkZLbYE3ZnIDh9dcq6sM2
         9hDg==
X-Gm-Message-State: ACrzQf11N+fzjO3lzTuy1z9wAJgppkZHucy6JZTFrT76KoAz+bqiFPdO
        MCTb8++CZKt6879617eUhcAKJA==
X-Google-Smtp-Source: AMsMyM5nADneWSGwP32fvcaNPr0CBeO4c5ie0nGX7493Qd+UOlN0iv2Y/cq8HOKycCsTlA0VVGaaGQ==
X-Received: by 2002:a17:902:900a:b0:178:77c7:aa28 with SMTP id a10-20020a170902900a00b0017877c7aa28mr708110plp.3.1666988205458;
        Fri, 28 Oct 2022 13:16:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u35-20020a632363000000b0046f6d7dcd1dsm1580328pgm.25.2022.10.28.13.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 13:16:44 -0700 (PDT)
Date:   Fri, 28 Oct 2022 13:16:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net, nd@arm.com, shuah@kernel.org
Subject: Re: [PATCH v1 2/2] kselftest: vm: add tests for
 memory-deny-write-execute
Message-ID: <202210281314.C5D3414722@keescook>
References: <20221026150457.36957-1-joey.gouly@arm.com>
 <20221026150457.36957-3-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026150457.36957-3-joey.gouly@arm.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an alternative rewritten to use kselftest_harness.h, with tests
for the prctl() flags, and the missed Makefile addition. This should be
much easier to add more variants and tests to, I hope.

-Kees

From bc442a99ebd9852bfaa7444b521bd55fdbb4d369 Mon Sep 17 00:00:00 2001
From: Kees Cook <keescook@chromium.org>
Date: Fri, 28 Oct 2022 13:10:45 -0700
Subject: [PATCH] selftests/vm: add tests for memory-deny-write-execute

Add tests for new prctl() commands, including flag values. Add tests for
new denials based on PROT_EXEC across mmap() and mprotect() with MDWE.

Co-developed-by: Joey Gouly <joey.gouly@arm.com>
Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/vm/Makefile    |   1 +
 tools/testing/selftests/vm/mdwe_test.c | 201 +++++++++++++++++++++++++
 2 files changed, 202 insertions(+)
 create mode 100644 tools/testing/selftests/vm/mdwe_test.c

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 163c2fde3cb3..8dd4d4910fa5 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -52,6 +52,7 @@ TEST_GEN_FILES += userfaultfd
 TEST_GEN_PROGS += soft-dirty
 TEST_GEN_PROGS += split_huge_page_test
 TEST_GEN_FILES += ksm_tests
+TEST_GEN_PROGS += mdwe_test
 
 ifeq ($(MACHINE),x86_64)
 CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_32bit_program.c -m32)
diff --git a/tools/testing/selftests/vm/mdwe_test.c b/tools/testing/selftests/vm/mdwe_test.c
new file mode 100644
index 000000000000..d6f6b751bcd6
--- /dev/null
+++ b/tools/testing/selftests/vm/mdwe_test.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifdef __aarch64__
+#include <asm/hwcap.h>
+#endif
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/auxv.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <linux/prctl.h>
+
+#include "../kselftest_harness.h"
+
+#define PR_SET_MDWE                     65
+# define PR_MDWE_FLAG_MMAP              1
+
+#define PR_GET_MDWE                     66
+
+#ifdef __aarch64__
+# define PROT_BTI	0x10            /* BTI guarded page */
+#else
+# define PROT_BTI	0
+#endif
+
+TEST(prctl_flags)
+{
+	EXPECT_LT(prctl(PR_SET_MDWE, 7, 0, 0, 0), 0);
+	EXPECT_LT(prctl(PR_SET_MDWE, 0, 7, 0, 0), 0);
+	EXPECT_LT(prctl(PR_SET_MDWE, 0, 0, 7, 0), 0);
+	EXPECT_LT(prctl(PR_SET_MDWE, 0, 0, 0, 7), 0);
+
+	EXPECT_LT(prctl(PR_GET_MDWE, 7, 0, 0, 0), 0);
+	EXPECT_LT(prctl(PR_GET_MDWE, 0, 7, 0, 0), 0);
+	EXPECT_LT(prctl(PR_GET_MDWE, 0, 0, 7, 0), 0);
+	EXPECT_LT(prctl(PR_GET_MDWE, 0, 0, 0, 7), 0);
+}
+
+FIXTURE(mdwe)
+{
+	void *p;
+	int flags;
+        size_t size;
+	pid_t pid;
+};
+
+FIXTURE_VARIANT(mdwe)
+{
+	bool enabled;
+	bool forked;
+};
+
+FIXTURE_VARIANT_ADD(mdwe, stock)
+{
+        .enabled = false,
+	.forked = false,
+};
+
+FIXTURE_VARIANT_ADD(mdwe, enabled)
+{
+        .enabled = true,
+	.forked = false,
+};
+
+FIXTURE_VARIANT_ADD(mdwe, forked)
+{
+        .enabled = true,
+	.forked = true,
+};
+
+FIXTURE_SETUP(mdwe)
+{
+	int ret, status;
+
+	self->p = NULL;
+	self->flags = MAP_SHARED | MAP_ANONYMOUS;
+	self->size = getpagesize();
+
+	if (!variant->enabled)
+		return;
+
+	ret = prctl(PR_SET_MDWE, PR_MDWE_FLAG_MMAP, 0, 0, 0);
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("PR_SET_MDWE failed or unsupported");
+	}
+
+	ret = prctl(PR_GET_MDWE, 0, 0, 0, 0);
+	ASSERT_EQ(ret, 1);
+
+	if (variant->forked) {
+		self->pid = fork();
+		ASSERT_GE(self->pid, 0) {
+			TH_LOG("fork failed\n");
+		}
+
+		if (self->pid > 0) {
+			ret = waitpid(self->pid, &status, 0);
+			ASSERT_TRUE(WIFEXITED(status));
+			exit(WEXITSTATUS(status));
+		}
+	}
+}
+
+FIXTURE_TEARDOWN(mdwe)
+{
+	if (self->p && self->p != MAP_FAILED)
+		munmap(self->p, self->size);
+}
+
+TEST_F(mdwe, mmap_READ_EXEC)
+{
+	self->p = mmap(NULL, self->size, PROT_READ | PROT_EXEC, self->flags, 0, 0);
+	EXPECT_NE(self->p, MAP_FAILED);
+}
+
+TEST_F(mdwe, mmap_WRITE_EXEC)
+{
+	self->p = mmap(NULL, self->size, PROT_WRITE | PROT_EXEC, self->flags, 0, 0);
+	if (variant->enabled) {
+		EXPECT_EQ(self->p, MAP_FAILED);
+	} else {
+		EXPECT_NE(self->p, MAP_FAILED);
+	}
+}
+
+TEST_F(mdwe, mprotect_stay_EXEC)
+{
+	int ret;
+
+	self->p = mmap(NULL, self->size, PROT_READ | PROT_EXEC, self->flags, 0, 0);
+	ASSERT_NE(self->p, MAP_FAILED);
+
+	ret = mprotect(self->p, self->size, PROT_READ | PROT_EXEC);
+	EXPECT_EQ(ret, 0);
+}
+
+TEST_F(mdwe, mprotect_add_EXEC)
+{
+	int ret;
+
+	self->p = mmap(NULL, self->size, PROT_READ, self->flags, 0, 0);
+	ASSERT_NE(self->p, MAP_FAILED);
+
+	ret = mprotect(self->p, self->size, PROT_READ | PROT_EXEC);
+	if (variant->enabled) {
+		EXPECT_LT(ret, 0);
+	} else {
+		EXPECT_EQ(ret, 0);
+	}
+}
+
+TEST_F(mdwe, mprotect_WRITE_EXEC)
+{
+	int ret;
+
+	self->p = mmap(NULL, self->size, PROT_WRITE, self->flags, 0, 0);
+	ASSERT_NE(self->p, MAP_FAILED);
+
+	ret = mprotect(self->p, self->size, PROT_WRITE | PROT_EXEC);
+	if (variant->enabled) {
+		EXPECT_LT(ret, 0);
+	} else {
+		EXPECT_EQ(ret, 0);
+	}
+}
+
+TEST_F(mdwe, mmap_FIXED)
+{
+	void *p;
+
+	self->p = mmap(NULL, self->size, PROT_READ, self->flags, 0, 0);
+	ASSERT_NE(self->p, MAP_FAILED);
+
+	p = mmap(self->p, self->size, PROT_READ | PROT_EXEC,
+		 self->flags | MAP_FIXED, 0, 0);
+	if (variant->enabled) {
+		EXPECT_EQ(p, MAP_FAILED);
+	} else {
+		EXPECT_EQ(p, self->p);
+	}
+}
+
+TEST_F(mdwe, arm64_BTI)
+{
+	int ret;
+
+#ifdef __aarch64__
+	if (!(getauxval(AT_HWCAP2) & HWCAP2_BTI))
+#endif
+		SKIP(return, "HWCAP2_BTI not supported");
+
+	self->p = mmap(NULL, self->size, PROT_EXEC, self->flags, 0, 0);
+	ASSERT_NE(self->p, MAP_FAILED);
+
+	ret = mprotect(self->p, self->size, PROT_EXEC | PROT_BTI);
+	EXPECT_EQ(ret, 0);
+}
+
+TEST_HARNESS_MAIN
-- 
2.34.1


-- 
Kees Cook
