Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343D869FCE9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjBVUOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjBVUN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:13:58 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE6824CB7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677096826; bh=fxR5hRSnSj4iuuOMlfoNf1rNYVWYPnTjd85lVz74gYI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=fdPPY+UfCiaNbpGgWDJbKAVKhwnqOGxnMzPSLlxvkJkyh4DsrDc2DsNg9uj2W9HzVsjjVWG0SYRzF99381wt163AvUHcviGXwWBPUOmL185ngrQWkKWjwbTdzVpvE/tSEsEbjF+kymIbm9IzHwbWLN3nq6xvYYBw7E4XRd54OW2NaQyUL71ym+Ibb60YoGFggWyhplmcpxoo7UcsE+ZISSf4ch7hY0avrW6QS3dD+XJSEv48jR/+9+aTtqzARAV3mJYv+WzEjbUYbyEyZPur/aZvyKqOcK2JnneO9EitaeiXdt8/ocegQACdsyMuUMTxOHWsy8Fwn1TMpIKQ4/cUoA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677096826; bh=ih7/x7ZQ02ZadUTwdJJ47Z/2vTw/HKr5wLkrHi/3Kmr=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ON0Xwmk/Oq3eW7yYXek9oSqMb8I1MKvzHA6zERFjqd8G1pRxnaKUoe324WHizqmm5BZ+gZ8glaLZd2aDkeGOZIlKjr1JnMnQAX9eW26s5SB7658QiR5s4BuT+DqzmftnBQ8ACcX/Z9fnjATSoTBCz6H44V7/bJEwWjB33Dfw5FGiD9oZz4RpMZkmxd4bjakAiEkP0drsFvMSbgqCVK/JO8oQA4hIHWuxIjhYkzsRgWKNnVYfChnGFi1UKXQFPjIYC7AnXKf6ejENxP+i7Rdk8om8oj5idUBmz23fXPZiOuZzsQJMt5KDW2Cn443zk6P3yg8kk0XAL9MGxZTHJgUpbA==
X-YMail-OSG: bqGU2SIVM1nBdNh6CeTBREKEenySN0HGam5EFywe.lVpbjeGuzHa9biVtN4.2r3
 xiIMjstgTWPPdsu8Bhr8_NvXZpLbkLZ4b29Qg.JlJLREEdS3E27LKEEBNNfgQZjXsCl7BbSo19fJ
 84PuyfbOxUdLiU3gGcM6ToUeX6rjlXW5W8ck6TtMZJffN32EKYjuIAUvSAGiMG9Ns.km8Hulm2NI
 wkHX51gVAFmxiUw7gLGJZWihz6PIQDMxcb2k16nxkieWfct71iH4Pu2mGtt1PIxhDUcDWVOKFRot
 8gnRORsdYqiZcWYOQ5Vee4XCM6dBynG4zQlDt4QYGw4Q2rBYzusGapuhsS1TyMEnJVh5YVXtPw6C
 Mj1iWH7LStDfUB.C1RtybnLipgLJRdUelFP_dcS9MpSfBdPfUa0TXEoh85.wOIPKq34J5FArxY9j
 F7zT9LLDp5MSsASwja3rSGVUr9z93fFg4xZNngIjPX1NBBOtNkUFwj3n0f94FifdD4Bjy8mz2DOb
 o04947KvZN4vOVTvTsgHLPq_7mVUcoTAJ9i3N2MBuahqFjdkLugVPKhaI0_KlHTh1Wtle66YAxw.
 QmueymytPR9synrmJGYOSlifG.U8kNFByd.dXKcTsbrK3VGsgYPD1X3Wt8bovdudBiOQnGawWhKA
 xeaBSLdjE68rfRbWOp5wzUGMY6N6qgGx2G2oUtU5NSkxk5.1dZWSVK57UYtutzU6FXrHoV6Cdmjt
 DvWzYxE34wQyAa5PgxzyBcLNogb7traGmefSyQp81R_fdSvNXO.KMFEGaA4Dsx2445yfZAbOetby
 TUDR0_dnefF04zLZPqpKJUWT9v8PunBFiGeN9lpTzP_C0PLv_bjXcNIkyWOPwh_ocogYEnGab7zQ
 wSuM7_DAps7XtyceesVHtEBISC.3OKhfUfOrrOcMSyURX7RQDiBYjktVH.JLrrSq3s8Z3FtWnySq
 wMrMKtblH7ZVTo7EIwkjYmC.WwNeCRS_dlM6wjj0b80ir1HXxubTKfo3nh_jj4O.RYmzauhZ0y4c
 hlAiW4eLs_5de11osUE01.mJKgji21YFETgn0XXLmH4c0RGcTRwLx0ApVhcNjwQ.aCFAocI8UxFc
 w5dhMnmAkDOP.188.TyNvkebs.LyHg2vCdA5qHqWyTMMA7uPDsb8YjGcUq1kJABFDNOjfqZg09Ss
 kp3D2ihu1N_EZAi.NcG6WTOSkXOJ4GrLV6gsfBSlZMIare41aa80cXObfECvyw5nDl4xBtiWIh3q
 4o.Mg_3O51QfwFmuLi_tYqARK_rKZAP0U0Mp_W5yq6tKGqQDk_zk6x9S4YS95amtVhKLVwh9CoN3
 jRXlzJVCZrLeUv92kCp8xA7qnXENsn2eG8YX0ICH3PX4WRLWgGR1tohNBvTNlg435IYRbx61VsL0
 37Fkovj4BUhP9PqK6YgLSW3G25iS5LvoPqr5NLnG.iL8kYPtDHeB8KmxYed9Yqec61h8y8dKsuUR
 Jcuf9f6FTUqGWcZeFVnrEJ3w_UQjQgEXaybjKWJgw.3o2Ip3IJzVUjPDwdNaouxq8CRM4Sc99TYB
 nMDiKjHXNuf58lBhIbZ067gJtPtjrDYNcYBCVO2H7j4AV78hlwgblYRgoWXk.c5za1YFoblYnpPA
 VJRzIYWZXPBOokpWW8tTR1Jz68ReWK6StQon15HFfq8d7fkxLFbNFeyfXcq_CCdBxUj2m6bRjdfm
 2Zsf6ZRI0Z0utSxSrF2bfzUdiwKVIwyVR0eGpcYnLjs01DW8LWzsFa4T6EQorF1_OgjnuWw.U9te
 qCUc5dwfH1f7EGDWZUNDQNes_8tAR0haw41NbXePZ4vsl3uf5NYVEL7dPNi4ITWD3VP.U07raWW9
 jcR2.36l5RRjgfPrzekYKY.FSFRXN5hV_yd63rHD6FylighrSh3fVgTiTNNXdq24Q4RuTEik1eJF
 pKmNXpxI6PDPpMrwU17.wwr3hNcECsejB5P5uAXzjkXc7e5n0oHAAibS0.6FFCJOCUlDQRHOO2Dz
 ELAqOk2oMK2BOSUPystvTob7dIYope3XOotU_P0dJznsPE1IsTTIbLSylzIKt4gzqLNV46TY4FeS
 SReYo9w3PekQLhcEaZJGshN.G44OicheuxkuDET_zBQxSl9XZHsP.AWa4SXd84QA9fHsQrTuLP_x
 IkBaqf3TSYxXTEuMcLngF5ZNPchwGLCOwV6kzWaIXalDip5EqQXCBIvUQYI0XCnydUhnHNrBAvmC
 psdgeAt3R4YLtBCVGFB2_jWoZ2Pe2sg_uYp0yWQRNtR9xdHamq8nm9mewDIhw1qRTzrBkJhkFq1U
 SUXsoDZXcqeWYhHDEb3X8FlzETg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 22 Feb 2023 20:13:46 +0000
Received: by hermes--production-bf1-57c96c66f6-7l94f (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 79c399884146b9399d6b4aa8aeb66e6a;
          Wed, 22 Feb 2023 20:13:44 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v6 11/11] LSM: selftests for Linux Security Module syscalls
Date:   Wed, 22 Feb 2023 12:08:38 -0800
Message-Id: <20230222200838.8149-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230222200838.8149-1-casey@schaufler-ca.com>
References: <20230222200838.8149-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
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
 .../selftests/lsm/lsm_get_self_attr_test.c    | 267 ++++++++++++++++++
 .../selftests/lsm/lsm_module_list_test.c      | 149 ++++++++++
 .../selftests/lsm/lsm_set_self_attr_test.c    |  69 +++++
 6 files changed, 500 insertions(+)
 create mode 100644 tools/testing/selftests/lsm/Makefile
 create mode 100644 tools/testing/selftests/lsm/config
 create mode 100644 tools/testing/selftests/lsm/lsm_get_self_attr_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_module_list_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_set_self_attr_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 41b649452560..ea58c5018529 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -37,6 +37,7 @@ TARGETS += landlock
 TARGETS += lib
 TARGETS += livepatch
 TARGETS += lkdtm
+TARGETS += lsm
 TARGETS += membarrier
 TARGETS += memfd
 TARGETS += memory-hotplug
diff --git a/tools/testing/selftests/lsm/Makefile b/tools/testing/selftests/lsm/Makefile
new file mode 100644
index 000000000000..d567ea9756ea
--- /dev/null
+++ b/tools/testing/selftests/lsm/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# First run: make -C ../../../.. headers_install
+
+CFLAGS += -Wall -O2 $(KHDR_INCLUDES)
+
+TEST_GEN_PROGS := lsm_get_self_attr_test lsm_module_list_test \
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
index 000000000000..72f02a210fa6
--- /dev/null
+++ b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
@@ -0,0 +1,267 @@
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
+	ASSERT_EQ(-1, syscall(__NR_lsm_get_self_attr, ctx, NULL,
+			      LSM_ATTR_CURRENT));
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
+	ASSERT_NE(-1, syscall(__NR_lsm_get_self_attr, NULL, &size,
+			      LSM_ATTR_CURRENT));
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
+	ASSERT_EQ(-1, syscall(__NR_lsm_get_self_attr, ctx, &size,
+			      LSM_ATTR_CURRENT));
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
+	ASSERT_EQ(-1, syscall(__NR_lsm_get_self_attr, ctx, &size, 0));
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
+	ASSERT_EQ(-1, syscall(__NR_lsm_get_self_attr, ctx, &size,
+			      LSM_ATTR_CURRENT | LSM_ATTR_PREV));
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
+	lsmcount = syscall(__NR_lsm_module_list, syscall_lsms, &size, 0);
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
+		count = syscall(__NR_lsm_get_self_attr, ctx, &size,
+				LSM_ATTR_CURRENT);
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
+		count = syscall(__NR_lsm_get_self_attr, ctx, &size,
+				LSM_ATTR_EXEC);
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
+		count = syscall(__NR_lsm_get_self_attr, ctx, &size,
+				LSM_ATTR_FSCREATE);
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
+		count = syscall(__NR_lsm_get_self_attr, ctx, &size,
+				LSM_ATTR_KEYCREATE);
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
+		count = syscall(__NR_lsm_get_self_attr, ctx, &size,
+				LSM_ATTR_PREV);
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
+		count = syscall(__NR_lsm_get_self_attr, ctx, &size,
+				LSM_ATTR_SOCKCREATE);
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
diff --git a/tools/testing/selftests/lsm/lsm_module_list_test.c b/tools/testing/selftests/lsm/lsm_module_list_test.c
new file mode 100644
index 000000000000..96120b0aed18
--- /dev/null
+++ b/tools/testing/selftests/lsm/lsm_module_list_test.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Linux Security Module infrastructure tests
+ * Tests for the lsm_module_list system call
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
+TEST(size_null_lsm_module_list)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	char *syscall_lsms = calloc(page_size, 1);
+
+	ASSERT_NE(NULL, syscall_lsms);
+	ASSERT_EQ(-1, syscall(__NR_lsm_module_list, syscall_lsms, NULL, 0));
+	ASSERT_EQ(EFAULT, errno);
+
+	free(syscall_lsms);
+}
+
+TEST(ids_null_lsm_module_list)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	__kernel_size_t size = page_size;
+
+	ASSERT_EQ(-1, syscall(__NR_lsm_module_list, NULL, &size, 0));
+	ASSERT_EQ(EFAULT, errno);
+	ASSERT_NE(1, size);
+}
+
+TEST(size_too_small_lsm_module_list)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	char *syscall_lsms = calloc(page_size, 1);
+	__kernel_size_t size = 1;
+
+	ASSERT_NE(NULL, syscall_lsms);
+	ASSERT_EQ(-1, syscall(__NR_lsm_module_list, syscall_lsms, &size, 0));
+	ASSERT_EQ(E2BIG, errno);
+	ASSERT_NE(1, size);
+
+	free(syscall_lsms);
+}
+
+TEST(flags_set_lsm_module_list)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	char *syscall_lsms = calloc(page_size, 1);
+	__kernel_size_t size = page_size;
+
+	ASSERT_NE(NULL, syscall_lsms);
+	ASSERT_EQ(-1, syscall(__NR_lsm_module_list, syscall_lsms, &size, 7));
+	ASSERT_EQ(EINVAL, errno);
+	ASSERT_EQ(page_size, size);
+
+	free(syscall_lsms);
+}
+
+TEST(correct_lsm_module_list)
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
+	count = syscall(__NR_lsm_module_list, syscall_lsms, &size, 0);
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
index 000000000000..22f5c8664c5f
--- /dev/null
+++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
@@ -0,0 +1,69 @@
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
+	ASSERT_EQ(-1, syscall(__NR_lsm_set_self_attr, NULL,
+			      sizeof(struct lsm_ctx), LSM_ATTR_CURRENT));
+}
+
+TEST(size_too_small_lsm_set_self_attr)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	struct lsm_ctx *ctx = calloc(page_size, 1);
+	__kernel_size_t size = page_size;
+
+	ASSERT_NE(NULL, ctx);
+	ASSERT_GE(1, syscall(__NR_lsm_get_self_attr, ctx, &size,
+			     LSM_ATTR_CURRENT));
+	ASSERT_EQ(-1, syscall(__NR_lsm_set_self_attr, ctx, 1,
+			      LSM_ATTR_CURRENT));
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
+	ASSERT_GE(1, syscall(__NR_lsm_get_self_attr, ctx, &size,
+			     LSM_ATTR_CURRENT));
+	ASSERT_EQ(-1, syscall(__NR_lsm_set_self_attr, ctx, size, 0));
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
+	ASSERT_GE(1, syscall(__NR_lsm_get_self_attr, tctx, &size,
+			     LSM_ATTR_CURRENT));
+	ASSERT_EQ(-1, syscall(__NR_lsm_set_self_attr, tctx, size,
+			      LSM_ATTR_CURRENT | LSM_ATTR_PREV));
+
+	free(ctx);
+}
+
+TEST_HARNESS_MAIN
-- 
2.39.0

