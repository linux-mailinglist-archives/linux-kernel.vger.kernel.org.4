Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4156F7336E8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345962AbjFPQ6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345924AbjFPQ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:57:43 -0400
Received: from sonic314-26.consmr.mail.ne1.yahoo.com (sonic314-26.consmr.mail.ne1.yahoo.com [66.163.189.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22BE468B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686934557; bh=DKeEkj8ly1FqNoGt8EcMyRH/A0S4Wx+vordwNsS8AI8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=P2rO/j5QhZeH7Pbr5fYbKMwqVTW4/r5NdmM1RUA4zbkwPTe10nPrAdpEipKqwUnE32cBzi6VMSZj4n/vEq7ycFW8KgnZJ12EzuP2sb+kxv4CH+sHC09X8f2BGkM+mZ4bYRmbODsQio0zY5mdwe/adlAwnxlYqMAsOWpNhR2ooF/aTO/Utyks+FO5pbNQR1ZSmJwFaHIf542YRxFZs4rO3wFGaQAxc3KqUevFHQDmM3Qdfhdf51FLmVsfYdLezIEPd32DlGvEChJgVzfz3SzT/LZcaMiY4xfL4bhj0m0bONOOm3GnSwaCZkhPzrWv2iiDbr3mOLdsXf8SKUOKqgk9cA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686934557; bh=+dJCeVqDOZom3NyNCMpdGrNX4EJxe609uqAgJzmF/o2=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=jAmNOMBoUCH/hFreQi9RcL2OFuKrr1+Mpui6VQnD1yuDobj0loNQg3yRh5Stws1Wc+qRWY9sFX05YLvgM8f6hBqZHFWKddacvlZijuL2U1b+1BFM0VScqSmVhUNZqCxt2uboW0A5FNQof39xOek9f8ohFP3FVmVX0ujv812HQb+pbUexkEt40rpoKHEkdmUx5zTe3JeDMeL5ZgPJywyxqXtWB+/Cjkq5Cl6d0e5ebb/TximX4uPF3eiIhxPgENZzdJ5LMXJRjeEC7ZnZVU1vSi47zreCrQR0AK/GOk1GfZKhJrzJc2B48Vhn1Hg5+XfrKqh+2tx3ZjB+F/v2vQVoRg==
X-YMail-OSG: Ohs6QeAVM1lTbF8Jw0rV20k64JcLJt1skAV8uUWL8zITK6jv77KvUbUJLneybtK
 vfXm0v6vhTM9lc2qyw6aNJvwKPfMzFIJ.8CRPbOZ7T94mkKPkNLCZdHEtODjk1DjMdWNcSuzf2CW
 scLzqAij1KatRsT7LrUjPw8nCaQPlfUZKpv4LB_IXBqs4_upskPTOTmMTrFS0nU3PiwHJUsYCA9B
 pcmUNwvP62FhCsc.j3m15QUIwZElvSOb7ceV0zSRIs9SPGuVZE1HOE2WdtKU8Exxz5wr42yQCYw7
 Wa5aQMp5foCArjqqBy8palpXp5mYc6PuotMMhdbkfYnNBMV1EnDF2bmh.G7Oj.nEcdZATwsbeGRE
 _7.uUd61OMEQnGAstmnNRwQWCBEdlPw7aHnAmZ19I.p1as2dI62dx7EjgPfCG_Lg5.bbTylAKFvH
 FUL3WzHN23PASe1w1zMxHBiFWpFfMkJzrGrQ9.CxNy_9ZbPN2K8UllK8vZI5abQtBTV2b_2m61_B
 Pt9u0.12yQZpvNKWLZ0qkua7GPzi_BUfMp8UXcna0ajcqSzmitFP4SsV7rowncxfrdl3c8UEPnyY
 nvIPK12Y3R0Q18ql2YhHXcNuHNC3VcK0kSeKOxxvFBmr1E2tjCEjvgteJPMypFCC7ltGTE4jYtIP
 h5DJ0HL4TjhZZEkeiRuXvHRlJowT5Ei_jyACqiEpNQlBUcWh0LsJxFmV3mjKl2ODY59_2ZfzJkvB
 Tf78fW2TPZMbKP3itCquhLT32ceYWxuCBQK5Xgg6j8qW5E_nt9q17kgENASvo5.SuMCRsEDSNvZi
 fMjc75T7TfpRDq_aNrT4Dcta4AuWxgY3vvEIeHjOImrIVAXHOMDnNOCS9DQ_lh9w08dFiJL.pko.
 7tnXt.cL58kI0xXSNfAwY4BWClD203atlB3O.0VZhV9D.WJMzURb23Mcrkd7BbWLpQGEZ_F_mZkR
 NFJbygcDb2tTyv9AJY1pD0Kvanqztkgt55i_GzAZVGGnyJSFVQZEpZ8XhHAiZUfZEGyoo2jSvY_d
 TQ3GK9Lw8SFvZHa2pBf0LP4uGrsZnWcSbQPE3kMr.khz.Hpb4jtsHaXNfuZYpShn5INr9yhb44KM
 bVLOVBOfKKp83.062xeg4qxLRd0fWqhVkC_qKvJGMHRbQkpYCP4kLSK17OIuKxS5duHXS.w2IlA7
 175dR6H4RIqOKPExf0Y_SMJmnZ2rJ72RcRxhPBwkOY3ei.5pbjB1RghEfXWjlkGD4l.y1Y4mUnG_
 Z1WcY699Nfkxz9KXDmQZ0Q4g97b9wg9wZ885c65n78z36ALC4jr6shcGJcVKT4ttU6g.fekS2eJl
 7lSbqnYPAQUHJV3fDrBDGlNWft7CDmpXb6l9t2nqusjQAZdZhHue7SuAHnaZ7PsRG2A8HBFpCpLz
 5ujdkAn_uSh0uSSZZu6yvYxUNSNaTT.EZOvj8T5cq5x9qXc4Ed7icodGnKAfdyVjmw841aSLHKPJ
 9ma4PXQPt.FUnjhzSImpaik5wzA4h1xXQWCIu6yqGhs4D9ym1ri954A8Khex3v_SsBnACqlw3Z6k
 ig7we1qd.BVX0EPvn_L5eg4fxtlNwIhlmPU8DYy2e0McBbry9RIK0A2.Vf3dYLwPf_Q7WF9DFy2R
 C_yRFSBC3NkDnAiaS2IvK_lUjZypu88Md.nMytNApM4Qwm50cJ.GLCPN0mIiR1Sxy3PXFWaDKaDU
 Iht.2MEtpPXRr0HjMBsdVVGzAEWeqv7Mwxf3Mry1FhVdKmByt4hoWiPshd2_XUQautmpzxMA0jBg
 zRe1S6zyoGKwzFfG66JA6xll69v008dJ7M2UhKDPWfKVaDp0Gb9Gm0bywiSEVn24EMyUjIMFsVdk
 a44Yxs0VBBMbmiE26FRhT96ujcauiRa_KXExOmk9PygR_yldvMIXa1JrtqeknACOWjDFwuW734.G
 nlJUwNQPiUf02BvaKHGS4qf.lRzsueX_Z2sGUDaXGGKlj55BuVhB7TewdiDBxcqgB7N1Ud0sWb3D
 v.nT86BHKEbGoF7EJXzfYeJjousPUddghzKZVFl_arc4swf_t5Hc9ztvpmKHPMwvPg8H5CYyBlAq
 inUybHrDPhYonUmp.PDPY3bsxGICQCfvFh7sEWKAc8IqI0pE4RXiuvMFpIUACyFMYj.3cRFJakuC
 9JRVbOb4l_TfGK9baSKvZnXDLbdzkajb0vKkn7IC2FI9K.esRvsIz2XfSImGB.Z6UD64HZux2pFL
 I0fCE9Y2cVZjk7A9m0iVIUSbOFICYRyomnSFLP0693jC5mUaGTqbH_Wzr9ugYCcPAhxeSNcswrkx
 sEdbYoLF27PJTz8kbzl6vKoWAIH4-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 45070aca-a207-409e-808a-bd05ac5e6327
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Jun 2023 16:55:57 +0000
Received: by hermes--production-ne1-574d4b7954-tvjss (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8aab4ebac04292db835fd6d81244177c;
          Fri, 16 Jun 2023 16:55:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v11 11/11] LSM: selftests for Linux Security Module syscalls
Date:   Fri, 16 Jun 2023 09:50:55 -0700
Message-Id: <20230616165055.4705-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230616165055.4705-1-casey@schaufler-ca.com>
References: <20230616165055.4705-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
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
 .../selftests/lsm/lsm_get_self_attr_test.c    | 270 ++++++++++++++++++
 .../selftests/lsm/lsm_list_modules_test.c     | 153 ++++++++++
 .../selftests/lsm/lsm_set_self_attr_test.c    |  70 +++++
 6 files changed, 508 insertions(+)
 create mode 100644 tools/testing/selftests/lsm/Makefile
 create mode 100644 tools/testing/selftests/lsm/config
 create mode 100644 tools/testing/selftests/lsm/lsm_get_self_attr_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_list_modules_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_set_self_attr_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 90a62cf75008..2b91df264ada 100644
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
index 000000000000..a62524b17bf7
--- /dev/null
+++ b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
@@ -0,0 +1,270 @@
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
+	errno = 0;
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
+	errno = 0;
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
+	errno = 0;
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
+	errno = 0;
+	ASSERT_EQ(-1, syscall(__NR_lsm_get_self_attr,
+			      LSM_ATTR_CURRENT | LSM_ATTR_PREV, ctx, &size, 0));
+	ASSERT_EQ(EOPNOTSUPP, errno);
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
index 000000000000..871d516a7d7d
--- /dev/null
+++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
@@ -0,0 +1,153 @@
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
+	errno = 0;
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
+	errno = 0;
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
+	errno = 0;
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
+	errno = 0;
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
2.40.1

