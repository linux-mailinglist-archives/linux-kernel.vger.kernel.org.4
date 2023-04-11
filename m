Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BEC6DE072
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjDKQFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjDKQE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:04:57 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FCC5FDB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681229064; bh=S+X9faI1UmSQJmjfpLORvXGBJioOwUVw04kUef1iOVE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Clr3bXUMgPtCcgCISClthbDbeoMF9RjQA98XJ5NtmbfQwR3GjdyQHZyTX+W4YBDFImNK/siTMfjfhQQvqmik8bwNH0HWeZ32NJrK5xTVkpRDFb4HLUQcz52eprD24zIG+2883LioyoLGtm/dPAq6cl6ttXKHas6lhhGPaPjKM4ikJsaZ96NwjRXmyCJAiRw5WxBbvVWYOvFnuIrxxUJ20N7jO9SuX70rwtCANjNfW2LHUKtj6L/RM3DqfccnTWr6WlTnJ/cOPgcNCbozygJqgdcxi2ePwhhQ2rTjY89o5QVc5w+4L5jHOrpAoLoBhi6s1uLUlYY64p06ZoTRbT9G0A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681229064; bh=Xp30FmuN2TS3I5nRjpF2UhHrTuNE/vJoxZk24JNBs/R=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FFTpk0YRBbqCr0jkWZmuNsST/7lrKUPrZ1fHopghJz+JPvO3t5iuREx3TDjmTqxfW2kEt0nSNEpV7WzhNzb3un4zooLy8FT/b+qXF3iwppbmLAp8hitGWBbaKBJyE14OvFD4ineDyqSv8KNM2MnShFyuKcILKGfcCGL+N3FP+GWzFoxbV9/pcccP5eyPOmwW33U508hQPc4VMjthkmYLA+2DqW3rqbZjY4MmAnEdzJ7EXJdcFcGlqQjWa6PnkW72r43YDCkjb2fKjX3l25ysZxAn8iwlvYIp/AZWNi89CEC7FhIruAvSQcyjNyYpCyhKS0ANzj/TGjS6IkU8tb14bQ==
X-YMail-OSG: 2lruQdUVM1l.BzUoqL4aGvJY9oYSI61._hm.xI66vwT_fq1GOzdf3vywORnPfgg
 Mx.Ag03xkFHT4JnfG4.Xk58Uuej_2gP9fC01T1cdrcJ0fNPN2UmQvjQD8v1aezrbN8gPvVPFf4Pr
 MDxZusAtfMTiU14FCB3Jw2wT.3o7.9o4pDb5vWkVxMOQlBwa2_OSBnynk59Xs.8aAlyn3Ikc3oZC
 vxL3QStsNdKC60qLD_jvJvaeIueJUN8WVuxNy_l4b5kbd.uRFKAJW0mTCDINGdwz8hePz4JXlo3l
 8VRVz.y7qS37cH5e.HLEMDY6JDrdYM3BSrYHvaOdAvNO5D.1MJsXPaUju.4JrAgNivzVgdMXYIa2
 AoFYhnQpenIVlBeIyI5WYQ1JAFeXh9fGSQfigvbAS_5Yt83PhW_htDU6CmQd2_s_M.NlBOEK3QBo
 yzo0etq2F_rOnU1T7ORCe1QgMHv.gicGA5DorN0OJ49cxvQ.v4HC3nyjFIqMkAdm5XLIWKdC8nLH
 U1EfSqhB3CFrPWCKEL.myhypnyylRW6qgyMCqB6Zps4Tvrq4vUrcUDh9CyHx_RVypgw0xf3LKLEh
 XzA6zGDn.bgiTQkgV9BkI8ioifkOQuCSTpW0w4sfd0TbfrS997sShhAi0kxHZ2WWO_GK21naIR_z
 XbXMb49qi9ziqxNasQBrjKjj7wh_mLjx_JDGKRyyWp2Xkxa7gs29crwUtzfCV5KAiQZfbsdsQfpx
 yeuCw4ZJ1QXpoNiMGXUDrOof5Hwgqt9Zy.0iKrIM4JLt0uje.nF4X2U9lX9GZcB66gBudBaendmN
 viSqadUFSCSQinm9QWXfzvuslcguNGGBV94d7h92132fAmfaL95.3Qw6BwGFy9ullSh.61ezDbgL
 yp_2yozhEWP8RXM_72JhYFRgjilXCGo4ubF1sli.iXxEnxnwGYvfezFGfCum2deEzP4MdbbTsJTD
 Gk.dLEQLMTIBGhB1xNZhGAvys6HPVZ2NDpzejSDPjv9gfjzYZ_gmdjUlPCciZUwLLJxEtISJ9z7R
 ojLWwxrAw_vfbF.iDjHXWgW_ILH8bJNeTzbDPunpmiqIaWjkT4RAkWOYCw.lXcaw8Xp.UPGCYM8W
 qgVAPEOjupPgHYbBsWlkVOGkaL756sjMfnNzK3Pq0bKRmLeYRpkmwJFrKPkGLzLfnk90M_vnXv.3
 FVVAtaSyWwlH0OFLcsvkC3IWx9q1uhbcWPFqyTz2xQ72QuT_aVmsru5OxPgE.O9RXGGwV2mdchVC
 Qv7lY34tFNHN0.4Zos_nWtc4r3Ap_Fq2JIwFgOxHs0uQPWZqWTy0Fbl2kYveTMXz.MHHXC1U6BXe
 9h7CQ.6OALGb.mkxlBb36IKfsztTYl3ySWTW_xg3LYeHMNgV1jDqNbfK1d.l3aetsHCPzplQWaYk
 TzNAtxrp642vLso7AccT2c6SBZqmscLG4cn7XYBEc49KltD2wQ3W3.Qn__ZWsSpe36qEt471HWjp
 1MgF2ThbcDzrxOuPt8IfPOBrng.Ef5SS6_TxMYs6blAwtiJvCJI.wpfYFDws.zrjGG48ib0J48np
 NCasfcMyT8rO6kAKHbhYthVsloCLnRmt3t.KcO0_hWoq7rqaIoJ5_wxP3eXs7qP_t_Q45VlRMXEs
 35jheAPLpAeXKbQuQhLidr6Qbbemu4yYxiaPUnyMwvGpdp1.I_5LQtdYvv2OIVdK8Kw9a7BQV6wX
 ECWY72RZFYjjUV3TQeRBl59C43dYpQ18fjVJ9oUOENk9bcncB7lGjd9CY69ZZ0YQX16mKZmQjStD
 wqvNqv0VcHiEBWLIOC4Xh4D_Qzt_jCpclb9wTJcKLTZatTsM1oLckWwtDlFqECFrmLEgJe4AR3KT
 NkfdEmnToEtrWF2BG9v2FNtMb6v1RER9SGwUuwQVAFOB1PU.xPI6Zs1Pi0UyqGml_Es7cHk8qveM
 YKQvJzHhiYW4NqwqiykY9Yfq_Dwr6FxIYZzFkiwcNJ3mBPR.bxGz6eTgf06HfcW3Y9GF1C7Vb0dA
 HqUxQU8dNM5REFpMNq4YXji6259OiKUr98x.x7PfG9hG6d0Zq8egW9HHEdD8YeoRNRYWQCc1qq9L
 z2gov32RmuODuDwgVNaXc3.YoqSusLbV7QlZqOAUgeJ8M_AWQm2.hDm1QXqhT_Xr3JsiMx_.m67g
 bTGNI7b2Zm2q910x16qcL3hcHa9rU6JUuPXeiMYD.9CchZzhakeIoF0jHre1uSovDVmGyXCFbRT.
 wiREyH6QCJENQ42Hmnem7B_7VjbbJ2YPgoBTjQ5PRdBnPTXrkh3FzfX8mZoxV.LH2ahHLlsYGe__
 iOygY7kTx49mApcRUN7871qrhc0lmBqk-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b3828b3c-fca7-4fff-8706-39836bcb4b00
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Apr 2023 16:04:24 +0000
Received: by hermes--production-ne1-7dbd98dd99-vd22t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8ad5be559bf25ba1172230271ff09c70;
          Tue, 11 Apr 2023 16:04:21 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v8 11/11] LSM: selftests for Linux Security Module syscalls
Date:   Tue, 11 Apr 2023 08:59:21 -0700
Message-Id: <20230411155921.14716-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411155921.14716-1-casey@schaufler-ca.com>
References: <20230411155921.14716-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

