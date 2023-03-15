Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B54E6BC030
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjCOWxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjCOWw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:52:59 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5940618BC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 15:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678920727; bh=S+X9faI1UmSQJmjfpLORvXGBJioOwUVw04kUef1iOVE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Hs3+/4+iTjb1ocn8twuJIWqoFL04kEUqVWMsHQXfY3Kf0D0fJT6tGZfWI7BYv2pE8w56yxph34kcCueUEqs7/0E0OonpEPeSe0GSBXgsSy1SrgwKqj8yDtahPSKYjo+kARqGc5FTVq/MLRumFZPvrHyspbIurT/KCW7OKHGxy1d/J5vNgkfo8OizK0D9BgnXnyNVPVUKTvE92j4f9ybYakv9JjnCpqMNnk0PG7Ry84WDQdLb8KU8yIorjmsX8IgaB0hxskPiXWfyklsagGbUAT96IxzLkjQla2fzO8eRaCmP4QLFQ05m99K9Va1Is3DzWz3zDEQQYTvvXLwRxpHE7A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678920727; bh=fFCTZbTi8jy+dGzrV07t+WMfg/f6ocTvXIVTyLJ7QLK=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=YSTMDEi1N4PcKih2QalU4DwZZYwcZxPG4PGLmAA7H83u7egHgiovj7IzP9/YSHjVQ76O1n6L+SkbTMziLnUsiVU9LXhyN/oxZr4Tu+lmDBsilQupe+uOpwmWKEtIwFsHRnsLxdyIsmczHA/qWEk6t37rsgAIX6ONsg5VhpnpW9E4Q33naukUY7drocFQbXQl5TeX9Y32o2SKqyDGSTsqFym4FNDB/9h92uTNyLFMHtBBUQmxWAy3d9K7uaBKnhlZ+6UGoVQlTF3q3qRPqcUBcxT7sMQaHGDyRY1E4Pfl+NEcWO5I6emLMhDScBv6rL/u3mqYcAhUkCLdlTx6PzhA/w==
X-YMail-OSG: CPqUl40VM1kBVXbl44.BmA53yJLNoT3EPCZFYF6qyEtnu1sKn0p2TJYvXe8vzAC
 17IeHz2RJ638ygWGGoTbdz66qwzKOAvpg5hayAV2eYaaOeyjiGFVI0pBVfHmD5iMVqRlR8p7inbV
 Xu9st1UUUjUY5AzEUYMX5JutbfRVHYf_LFXh1276S7N38KzdsCNCH7bGUEFgidv2zLrpyZ6rGuw_
 ZI.Id3qVDqkrKdVLkFkdhOeseg14H9dzY_IPRqjt3TYa8GlKnrSxCSU.B70dlaIGplcDb6tqsk_F
 PBMFeQhvbmYQc4MCJ_8MMpxS._8XLqPn_ei.qEKMbi7xgCQ7quKa8JWjXpFeZy6mOEdOeRj3fH_V
 Ey5whr3yyz1KaK98TpShz4TFbLAh3ViMLZL010Ucy_3kXiWNZA.0aAa7D2h3uhsojRRbCuq_1FFC
 .Ht1Mw4N8wKD5FaP1BYp.XfBWLadu18KO8fb0eMYTeOqWKzxlstdStGn1lh2ruZYMsTVmfJypHvF
 9OoTmcsMV53T1iQBWB12fSUzhmiPSOlOP57Df.Bc77KIKMwkW6mnfOyLkcIQ10XMl00.DIs5hEiS
 HL3Vm8jujt6KtK_KC1CK_GBa8sx8Z2h9UNawevQRRHWRcQjbQmWIiE319xZfU2OulDHxb8XRmpHv
 .fNm8eIl1UZOXiPwAvQIfIrXgkhID7yUWA8Clfc1_h7Zx8e9HmrSJw2wxuJb402aK7zR7zy_D6Wx
 RUHnhlzCaoXt37fl_N_.3.4wg15hJlgLGRB8k7Ii1DevM5hs69NgQMHAEIqdBSNoEwPk23lZkyFE
 St81X0a4UL3KPaWI7VJ0ZO_8k72ukIY.daKksGDOaazXUtN3D4sgjg6eCHGUsyIR6n.x3WAc3zuq
 4cNz5hggUsUTn9pVEf840KU_KfTZgSYQdsJ_gNmCXe8bh3V5dsj6e1fbL1t4c4kcXIlgXxG.iaO2
 .RvDI8piExyuMgUJK5Yn9mQHfSGUVsM_Q2hpY15aPJYKIb7nQIpbKqvjzGKvCPAAS7KpW3YMFyGT
 tqUM3SIkayzW_NjhlBvauJd4n5iyYyz9fRvYNSWkSb3Z7hTAOYruBuZigrbyCeNa4YLff.xiefmy
 3ZaIauBTJN2Wi63guhixS8F5LenUYopVNWFsDGCx.jju5AIx6sbXMy6phL8n.1BINmnZAm1w5JHV
 0Xg8oVSS60.oU9PSKQ.TbssJCus05oApnFAc7qNC8jkLOqwqzAtNtT.zvaBQPfsDrAyAvkReegnX
 eqBZbWjOgtVo0nxxlY7ePap8ffzmHfp57.V7uayS3MdRGAuYGhkLsmOU2TurmfSLnbfiixH4Us5T
 tlAxhOgqoz3xpHdW2oKwY2UEUkPn.xW8gShWf5jWARuOZuM7quGYtcvzejtoVmBptgpG26J_ppU7
 bft9NiWJxRyOsnYGFiSPhphu9aJjHfEyAphFZ8wlNaOhD4bIuY94_EhhPgvrKgiWqJKJ42uQUfdp
 rQzbHn6eqh0kP.Ud5dDJP4DWnYF9Ll2y6X0ii6luWoQ2BjBkEXQG9YgV_uTmLjhZ8_0tJ_XlG1Gn
 tpuPBJKSHugdBb3MpBGH77iBLKaH5jW2n1QIbYEFGOJgthptFYWLVZWcca.L3AJSdmMCGY9d5QwV
 OGEaZGJpbSGlC.IfTnzr4rKDLnHNpuKjQ6LuzNCvnpDBP_UDVskpUU.8YvgB.TDJkk1zjuK20.LK
 TOHoQnkwjhUgbTCR1EXCda1.s2_1XH00lfuQIuYfamSXkYGVpp8Kxetb.Oj9Q0XfRKgjbWymXHHp
 Pw16mhRJk0MCOof4nj4bIlOzO.w5XBP3Y36A1jJH9jlMmK3JQJ3mr6J5WJuEqlJCbIh_Zi7ccA72
 leepV0fDgTdqYxBCynDHRZYRl1MFrhZ5Aer_18zVrxiy_IH6VrKfboUSK4R41i3glx9OPD5LTbNO
 x4EPWDgJZHvMkRssyK8BaOZ7NEH7qyiVIuP4Dp8K21c0vu9iowB0NQbYEKQNnMKIKhkXavovEYDB
 OJQlSzzzou3xTEFniLDomw4771jW8E4mJdAcndu13uRqmPt5pLb6GQ.iNunHr_fJdFjLNJu8JFZ9
 TWGqSoyT2bM8oB.77XchikTy2sB6CJhIFh2zyU.dVaiatg2rXtHq2XK2Kz3NyZdYyn_DsI2oPIr8
 x.uAwA7Fuxv1Wz2nbxec6SkgJQjUq0B5D_mGS3K9HykUS1k2Oy3IqQkzXPhIC.SM0TdBurQq0Unw
 Km.zeuWCB.zjsNC7oRl.jfg99iBBun30DKZZhV2cg2gPC4dUZQyl447Ml6xUT8tHqCveudGQWew3
 Csv44YUqEfPMSLCbEGs7QjRG96LYRcQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 13f74364-41bf-4c80-87bd-467470b1a429
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 15 Mar 2023 22:52:07 +0000
Received: by hermes--production-ne1-759c9b8c64-2fnfh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3519737f64e89c1a78f5fee6524d3fd8;
          Wed, 15 Mar 2023 22:52:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v7 11/11] LSM: selftests for Linux Security Module syscalls
Date:   Wed, 15 Mar 2023 15:47:04 -0700
Message-Id: <20230315224704.2672-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315224704.2672-1-casey@schaufler-ca.com>
References: <20230315224704.2672-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add selftests for the three system calls supporting the LSM
infrastructure.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/lsm/Makefile          |  12 +
 tools/testing/selftests/lsm/config            |   2 +
 .../selftests/lsm/lsm_get_self_attr_test.c    | 268 ++++++++++++++++++
 .../selftests/lsm/lsm_list_modules_test.c     | 149 ++++++++++
 .../selftests/lsm/lsm_set_self_attr_test.c    |  70 +++++
 6 files changed, 502 insertions(+)
 create mode 100644 tools/testing/selftests/lsm/Makefile
 create mode 100644 tools/testing/selftests/lsm/config
 create mode 100644 tools/testing/selftests/lsm/lsm_get_self_attr_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_list_modules_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_set_self_attr_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 13a6837a0c6b..b18d133a1141 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -38,6 +38,7 @@ TARGETS += landlock
 TARGETS += lib
 TARGETS += livepatch
 TARGETS += lkdtm
+TARGETS += lsm
 TARGETS += membarrier
 TARGETS += memfd
 TARGETS += memory-hotplug
diff --git a/tools/testing/selftests/lsm/Makefile b/tools/testing/selftests/lsm/Makefile
new file mode 100644
index 000000000000..f39a75212b78
--- /dev/null
+++ b/tools/testing/selftests/lsm/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# First run: make -C ../../../.. headers_install
+
+CFLAGS += -Wall -O2 $(KHDR_INCLUDES)
+
+TEST_GEN_PROGS := lsm_get_self_attr_test lsm_list_modules_test \
+		  lsm_set_self_attr_test
+
+include ../lib.mk
+
+$(TEST_GEN_PROGS):
diff --git a/tools/testing/selftests/lsm/config b/tools/testing/selftests/lsm/config
new file mode 100644
index 000000000000..afb887715f64
--- /dev/null
+++ b/tools/testing/selftests/lsm/config
@@ -0,0 +1,2 @@
+CONFIG_SYSFS=y
+CONFIG_SECURITY=y
diff --git a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
new file mode 100644
index 000000000000..2c61a1411c54
--- /dev/null
+++ b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Linux Security Module infrastructure tests
+ * Tests for the lsm_get_self_attr system call
+ *
+ * Copyright © 2022 Casey Schaufler <casey@schaufler-ca.com>
+ * Copyright © 2022 Intel Corporation
+ */
+
+#define _GNU_SOURCE
+#include <linux/lsm.h>
+#include <fcntl.h>
+#include <string.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include "../kselftest_harness.h"
+
+#define PROCATTR	"/proc/self/attr/"
+
+static int read_proc_attr(const char *attr, char *value, __kernel_size_t size)
+{
+	int fd;
+	int len;
+	char *path;
+
+	len = strlen(PROCATTR) + strlen(attr) + 1;
+	path = calloc(len, 1);
+	if (path == NULL)
+		return -1;
+	sprintf(path, "%s%s", PROCATTR, attr);
+
+	fd = open(path, O_RDONLY);
+	free(path);
+
+	if (fd < 0)
+		return -1;
+	len = read(fd, value, size);
+	if (len <= 0)
+		return -1;
+fprintf(stderr, "len=%d\n", len);
+	close(fd);
+
+	path = strchr(value, '\n');
+	if (path)
+		*path = '\0';
+
+	return 0;
+}
+
+static struct lsm_ctx *next_ctx(struct lsm_ctx *ctxp)
+{
+	void *vp;
+
+	vp = (void *)ctxp + sizeof(*ctxp) + ctxp->ctx_len;
+	return (struct lsm_ctx *)vp;
+}
+
+TEST(size_null_lsm_get_self_attr)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	char *ctx = calloc(page_size, 1);
+
+	ASSERT_NE(NULL, ctx);
+	ASSERT_EQ(-1, syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, ctx,
+			      NULL, 0));
+	ASSERT_EQ(EINVAL, errno);
+
+	free(ctx);
+}
+
+TEST(ctx_null_lsm_get_self_attr)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	__kernel_size_t size = page_size;
+
+	ASSERT_NE(-1, syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, NULL,
+			      &size, 0));
+	ASSERT_NE(1, size);
+}
+
+TEST(size_too_small_lsm_get_self_attr)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	char *ctx = calloc(page_size, 1);
+	__kernel_size_t size = 1;
+
+	ASSERT_NE(NULL, ctx);
+	ASSERT_EQ(-1, syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, ctx,
+			      &size, 0));
+	ASSERT_EQ(E2BIG, errno);
+	ASSERT_NE(1, size);
+
+	free(ctx);
+}
+
+TEST(flags_zero_lsm_get_self_attr)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	char *ctx = calloc(page_size, 1);
+	__kernel_size_t size = page_size;
+
+	ASSERT_NE(NULL, ctx);
+	ASSERT_EQ(-1, syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, ctx,
+			      &size, 1));
+	ASSERT_EQ(EINVAL, errno);
+	ASSERT_EQ(page_size, size);
+
+	free(ctx);
+}
+
+TEST(flags_overset_lsm_get_self_attr)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	char *ctx = calloc(page_size, 1);
+	__kernel_size_t size = page_size;
+
+	ASSERT_NE(NULL, ctx);
+	ASSERT_EQ(-1, syscall(__NR_lsm_get_self_attr,
+			      LSM_ATTR_CURRENT | LSM_ATTR_PREV, ctx, &size, 0));
+	ASSERT_EQ(EOPNOTSUPP, errno);
+	ASSERT_EQ(page_size, size);
+
+	free(ctx);
+}
+
+TEST(basic_lsm_get_self_attr)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	__kernel_size_t size = page_size;
+	struct lsm_ctx *ctx = calloc(page_size, 1);
+	struct lsm_ctx *tctx = NULL;
+	__u64 *syscall_lsms = calloc(page_size, 1);
+	char *attr = calloc(page_size, 1);
+	int cnt_current = 0;
+	int cnt_exec = 0;
+	int cnt_fscreate = 0;
+	int cnt_keycreate = 0;
+	int cnt_prev = 0;
+	int cnt_sockcreate = 0;
+	int lsmcount;
+	int count;
+	int i;
+
+	ASSERT_NE(NULL, ctx);
+	ASSERT_NE(NULL, syscall_lsms);
+
+	lsmcount = syscall(__NR_lsm_list_modules, syscall_lsms, &size, 0);
+	ASSERT_LE(1, lsmcount);
+
+	for (i = 0; i < lsmcount; i++) {
+		switch (syscall_lsms[i]) {
+		case LSM_ID_SELINUX:
+			cnt_current++;
+			cnt_exec++;
+			cnt_fscreate++;
+			cnt_keycreate++;
+			cnt_prev++;
+			cnt_sockcreate++;
+			break;
+		case LSM_ID_SMACK:
+			cnt_current++;
+			break;
+		case LSM_ID_APPARMOR:
+			cnt_current++;
+			cnt_exec++;
+			cnt_prev++;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (cnt_current) {
+		size = page_size;
+		count = syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, ctx,
+				&size, 0);
+		ASSERT_EQ(cnt_current, count);
+		tctx = ctx;
+		ASSERT_EQ(0, read_proc_attr("current", attr, page_size));
+		ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
+		for (i = 1; i < count; i++) {
+			tctx = next_ctx(tctx);
+			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
+		}
+	}
+	if (cnt_exec) {
+		size = page_size;
+		count = syscall(__NR_lsm_get_self_attr, LSM_ATTR_EXEC, ctx,
+				&size, 0);
+		ASSERT_GE(cnt_exec, count);
+		if (count > 0) {
+			tctx = ctx;
+			if (read_proc_attr("exec", attr, page_size) == 0)
+				ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
+		}
+		for (i = 1; i < count; i++) {
+			tctx = next_ctx(tctx);
+			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
+		}
+	}
+	if (cnt_fscreate) {
+		size = page_size;
+		count = syscall(__NR_lsm_get_self_attr, LSM_ATTR_FSCREATE, ctx,
+				&size, 0);
+		ASSERT_GE(cnt_fscreate, count);
+		if (count > 0) {
+			tctx = ctx;
+			if (read_proc_attr("fscreate", attr, page_size) == 0)
+				ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
+		}
+		for (i = 1; i < count; i++) {
+			tctx = next_ctx(tctx);
+			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
+		}
+	}
+	if (cnt_keycreate) {
+		size = page_size;
+		count = syscall(__NR_lsm_get_self_attr, LSM_ATTR_KEYCREATE, ctx,
+				&size, 0);
+		ASSERT_GE(cnt_keycreate, count);
+		if (count > 0) {
+			tctx = ctx;
+			if (read_proc_attr("keycreate", attr, page_size) == 0)
+				ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
+		}
+		for (i = 1; i < count; i++) {
+			tctx = next_ctx(tctx);
+			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
+		}
+	}
+	if (cnt_prev) {
+		size = page_size;
+		count = syscall(__NR_lsm_get_self_attr, LSM_ATTR_PREV, ctx,
+				&size, 0);
+		ASSERT_GE(cnt_prev, count);
+		if (count > 0) {
+			tctx = ctx;
+			ASSERT_EQ(0, read_proc_attr("prev", attr, page_size));
+			ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
+			for (i = 1; i < count; i++) {
+				tctx = next_ctx(tctx);
+				ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
+			}
+		}
+	}
+	if (cnt_sockcreate) {
+		size = page_size;
+		count = syscall(__NR_lsm_get_self_attr, LSM_ATTR_SOCKCREATE,
+				ctx, &size, 0);
+		ASSERT_GE(cnt_sockcreate, count);
+		if (count > 0) {
+			tctx = ctx;
+			if (read_proc_attr("sockcreate", attr, page_size) == 0)
+				ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
+		}
+		for (i = 1; i < count; i++) {
+			tctx = next_ctx(tctx);
+			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
+		}
+	}
+
+	free(ctx);
+	free(attr);
+	free(syscall_lsms);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/testing/selftests/lsm/lsm_list_modules_test.c
new file mode 100644
index 000000000000..3ec814002710
--- /dev/null
+++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Linux Security Module infrastructure tests
+ * Tests for the lsm_list_modules system call
+ *
+ * Copyright © 2022 Casey Schaufler <casey@schaufler-ca.com>
+ * Copyright © 2022 Intel Corporation
+ */
+
+#define _GNU_SOURCE
+#include <linux/lsm.h>
+#include <string.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include "../kselftest_harness.h"
+
+static int read_sysfs_lsms(char *lsms, __kernel_size_t size)
+{
+	FILE *fp;
+
+	fp = fopen("/sys/kernel/security/lsm", "r");
+	if (fp == NULL)
+		return -1;
+	if (fread(lsms, 1, size, fp) <= 0)
+		return -1;
+	fclose(fp);
+	return 0;
+}
+
+TEST(size_null_lsm_list_modules)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	char *syscall_lsms = calloc(page_size, 1);
+
+	ASSERT_NE(NULL, syscall_lsms);
+	ASSERT_EQ(-1, syscall(__NR_lsm_list_modules, syscall_lsms, NULL, 0));
+	ASSERT_EQ(EFAULT, errno);
+
+	free(syscall_lsms);
+}
+
+TEST(ids_null_lsm_list_modules)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	__kernel_size_t size = page_size;
+
+	ASSERT_EQ(-1, syscall(__NR_lsm_list_modules, NULL, &size, 0));
+	ASSERT_EQ(EFAULT, errno);
+	ASSERT_NE(1, size);
+}
+
+TEST(size_too_small_lsm_list_modules)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	char *syscall_lsms = calloc(page_size, 1);
+	__kernel_size_t size = 1;
+
+	ASSERT_NE(NULL, syscall_lsms);
+	ASSERT_EQ(-1, syscall(__NR_lsm_list_modules, syscall_lsms, &size, 0));
+	ASSERT_EQ(E2BIG, errno);
+	ASSERT_NE(1, size);
+
+	free(syscall_lsms);
+}
+
+TEST(flags_set_lsm_list_modules)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	char *syscall_lsms = calloc(page_size, 1);
+	__kernel_size_t size = page_size;
+
+	ASSERT_NE(NULL, syscall_lsms);
+	ASSERT_EQ(-1, syscall(__NR_lsm_list_modules, syscall_lsms, &size, 7));
+	ASSERT_EQ(EINVAL, errno);
+	ASSERT_EQ(page_size, size);
+
+	free(syscall_lsms);
+}
+
+TEST(correct_lsm_list_modules)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	__kernel_size_t size = page_size;
+	__u64 *syscall_lsms = calloc(page_size, 1);
+	char *sysfs_lsms = calloc(page_size, 1);
+	char *name;
+	char *cp;
+	int count;
+	int i;
+
+	ASSERT_NE(NULL, sysfs_lsms);
+	ASSERT_NE(NULL, syscall_lsms);
+	ASSERT_EQ(0, read_sysfs_lsms(sysfs_lsms, page_size));
+
+	count = syscall(__NR_lsm_list_modules, syscall_lsms, &size, 0);
+	ASSERT_LE(1, count);
+	cp = sysfs_lsms;
+	for (i = 0; i < count; i++) {
+		switch (syscall_lsms[i]) {
+		case LSM_ID_CAPABILITY:
+			name = "capability";
+			break;
+		case LSM_ID_SELINUX:
+			name = "selinux";
+			break;
+		case LSM_ID_SMACK:
+			name = "smack";
+			break;
+		case LSM_ID_TOMOYO:
+			name = "tomoyo";
+			break;
+		case LSM_ID_IMA:
+			name = "ima";
+			break;
+		case LSM_ID_APPARMOR:
+			name = "apparmor";
+			break;
+		case LSM_ID_YAMA:
+			name = "yama";
+			break;
+		case LSM_ID_LOADPIN:
+			name = "loadpin";
+			break;
+		case LSM_ID_SAFESETID:
+			name = "safesetid";
+			break;
+		case LSM_ID_LOCKDOWN:
+			name = "lockdown";
+			break;
+		case LSM_ID_BPF:
+			name = "bpf";
+			break;
+		case LSM_ID_LANDLOCK:
+			name = "landlock";
+			break;
+		default:
+			name = "INVALID";
+			break;
+		}
+		ASSERT_EQ(0, strncmp(cp, name, strlen(name)));
+		cp += strlen(name) + 1;
+	}
+
+	free(sysfs_lsms);
+	free(syscall_lsms);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
new file mode 100644
index 000000000000..ca538a703168
--- /dev/null
+++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Linux Security Module infrastructure tests
+ * Tests for the lsm_set_self_attr system call
+ *
+ * Copyright © 2022 Casey Schaufler <casey@schaufler-ca.com>
+ * Copyright © 2022 Intel Corporation
+ */
+
+#define _GNU_SOURCE
+#include <linux/lsm.h>
+#include <string.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include "../kselftest_harness.h"
+
+TEST(ctx_null_lsm_set_self_attr)
+{
+	ASSERT_EQ(-1, syscall(__NR_lsm_set_self_attr, LSM_ATTR_CURRENT, NULL,
+			      sizeof(struct lsm_ctx), 0));
+}
+
+TEST(size_too_small_lsm_set_self_attr)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	struct lsm_ctx *ctx = calloc(page_size, 1);
+	__kernel_size_t size = page_size;
+
+	ASSERT_NE(NULL, ctx);
+	ASSERT_GE(1, syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, ctx,
+			     &size, 0));
+	ASSERT_EQ(-1, syscall(__NR_lsm_set_self_attr, LSM_ATTR_CURRENT, ctx, 1,
+			      0));
+
+	free(ctx);
+}
+
+TEST(flags_zero_lsm_set_self_attr)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	char *ctx = calloc(page_size, 1);
+	__kernel_size_t size = page_size;
+
+	ASSERT_NE(NULL, ctx);
+	ASSERT_GE(1, syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, ctx,
+			     &size, 0));
+	ASSERT_EQ(-1, syscall(__NR_lsm_set_self_attr, LSM_ATTR_CURRENT, ctx,
+			      size, 1));
+
+	free(ctx);
+}
+
+TEST(flags_overset_lsm_set_self_attr)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	char *ctx = calloc(page_size, 1);
+	__kernel_size_t size = page_size;
+	struct lsm_ctx *tctx = (struct lsm_ctx *)ctx;
+
+	ASSERT_NE(NULL, ctx);
+	ASSERT_GE(1, syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, tctx,
+			     &size, 0));
+	ASSERT_EQ(-1, syscall(__NR_lsm_set_self_attr,
+			      LSM_ATTR_CURRENT | LSM_ATTR_PREV, tctx, size, 0));
+
+	free(ctx);
+}
+
+TEST_HARNESS_MAIN
-- 
2.39.2

