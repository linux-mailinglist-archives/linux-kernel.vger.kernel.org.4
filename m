Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED93F662E75
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbjAISOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237594AbjAISN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:13:26 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E3371899
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673287847; bh=/CPQwIiVPG+O07TrKdR4dko7mVUFYRMPu2SUKw/z1i4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Yizy/+qZBk4xwdPahU+oUY+7mxnQTg6/aqoddKxB7d8KcKmojoN8gnk+msBF+8cOSyIRoZo58yyvKEaPZ3ZQZYKAHwFS3oFkki/yTnd74WUc/W6bVfLQK63FloHXquuKmwJukrYjTvEbze1/F2tYAkGAgIieh6D2zaRlmvRP8qZrcIEB+/TvtcUJWTzWKOZuuNqVvIq+8hpvQrL3ZB7cRbJRRFncev27MNghNpTBj2QbslfwH8pc9cqZW5g291fvAH8Pkz98mIVb1njQnR/Bqudz7gzCuT9EvHsWAuQdk83jW2Y/KQmLi4FtLXu2vERVXvraK/gp/0R1Y5qZqkgqYg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673287847; bh=B8SuZRB2x0AMSJ9EomN71A3gBMTTjA+HEEGhooHeTw3=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=doihuBPw/+f2RFnp+HC2E7SG4ZSIYqEcZSd6NlnNn3IBTuqJs0flWJuQbIiKpmZh0bfrXWFYQFDCWiiWoMsjnnyEVVGJVYMywze9UBaRU+2+arYdOExUfKqminXgfZQdRcif/PN+01nIeW7VuRiuCbEEtZzXiY1IUrmVleH0z2/lvST9iw70MajsQn3fZVBTSgNaqBuo4wYtWZbT9a5JAdVRQjJoOdA0ktjfrLpfi++b8ksuzSAEp0lmNdzodQ7hZxHHQcYiZH9RWPNcmdQTKwtUzDZxwKE/m5/R4bs8MXy+ApdJTFIyeVk+Ngc00iEd1grIsdn4hOEj5vcsip4Mxw==
X-YMail-OSG: LfU4ykcVM1l9b4dzjvGWQnvXNC5JPdC.B210A_aul.BRusogdn4TTX0ZSPSnfRW
 n3MzRvRM7MvsrZi4LzGq4.GE0L2muVDQrCP_CLhOUBsepm8EfRz1UVUNiBHpywSeLsEyqhZ6KOtd
 cETziSk3BGYJ5lA1v1GLCkUwfbEulN5beM1prvpEmQvNnflGdOP0j2GKtPMdjQnRhL3CdF5D6L1z
 kDJmvnvqfrqnOV.dcWsPZUs0009u82I1wimHniFZZdSkijuHubcwB0mghwFoWAZ.IYt9kvFKpMVi
 AdYTOIfcz_1RlqdLAzz0jmj67ReZY8YFJt0clnnPgPsYl86yAU6_UbpPrqIyFN4hv.7ap4nPurjP
 0nM7lrrtUANeSteIDvgVQBl5Lyg7NaGKveMH.Qy5iRwWzmV3StdSEfUK3VIT_CdogY0jnwQZDED.
 xSDhbgB1QK22hsUKKLQ6rI2t5fManko.pyV_5IKhaqy9NOJCb0heyb4hdupAfGJWrxWCaYcQ5u7h
 sjo.slRyrbvLzw4qjjS2owhSZU80w7ZD6734FuNvPCtrRMQW2w9aSVQd2sxJkDflMh0AcYO0_aqZ
 f3rqSsBejcLqqhCvTsQN9woxO97FRSwy.JrhKeWQa8af29gnOC3jaRApP0iI3k5iHDoRDDR71_EP
 nxtgfStUQ4xWmtTsvBxMuUEtrVyMOsqiW1wmndNEFOBZC2cPREAJRx1Q8PJKngTZz19LW7jA.quG
 gb5z3dGttggfyfKYgb75EtkzUXNuA2DelKO_.OWwfVndjWjeooLGesMzS1o1es0g8aIpP_I47YLN
 VxQ.FDk1rteqDEoLyzc7gieMIt7mbUAGctW64XmFb3_Azi6oVCU.A1ZdTrJD_kUQt7ffkvZ6Yfto
 pn1W73HU8F9g9Vu3n9MQZEAUEIsZN_GC3mn3SC0P9J1XHq2NVYo4CNv9f.d1iOeYYyozY8482ahJ
 I0gi0Qt.Nz523D1tG1IBmNhQuVkO_c6lEGFS1KCPffyrxr0vsHAKD1SUNMqL6EiMQvOTNHcGfwNB
 Ducbf.AgAmtg3Cea5q6HMfndtYjIWDgY2OwJV4R0FIwbsL09TrDXBYHflTf6RuB32GvKhP9SY0XT
 upwQz..M3lmZhZyvcXpdg2.zcxlS.Hv5_bOke9ZTiWsDZ2es2Z9R7zhWb7UqA7z9qOFdC0IIataN
 QTXZPD3B4ofNsCAv95sp9GeMf1RZkiXPmgtm4_kRDfmZ6A3B9ZdGZX90eFZQ4Nh.jwioib6TVqpN
 iNMZTJQxFWEwXtCxBTDMRnS35_dvnWfjlr6FMXj_d5.JDdL8HTXXTerIWYvXj2r03DYXSWeWXjMm
 _nYRolFhEMCUIgeySFO7Gi3PBOBgIkoobPE4cL4ej2ZckRfVZkVENnEsX.hjVBOU1aDIolrieA_O
 1_7InO5QHTHcFSXQkzWaJenD0srQLNE5QrxO4pbHKfp_SfKi9efIsNX_Zxi_HBzp745e0FFHlNnE
 fxgHWpBBDmtBS.XBCKzYLID5JruBetG_iyuFTxbHjnwS9zgzzfESKJxUp3R1ud8rWL7bUNL5xRTE
 G_NwT0xlTMRdf7OhJMP9J_XjYUPxB6xff9HiFUOAvHgegKC2fytf0G3SQMCEXYyJ4XPAj7mVIqXz
 gdgkKLSA9BAbYj_GrQLKjNSJO3FPZkZAg.18BJ9iiHSjo2NvO3g0thst8gUOgfkNIhNcClVw8PP4
 C6kImHMkLqOoOmNccIdr1Ak_uZIvfmoo7_NOd6OCQBE5cOJ1aOrW1fdKd2UWZW.ZzywCu923SDuE
 dTWTruE.AMnpRfOjiXnPRgMeFBX5upvuLHZKHcxTD5MADmtZ3RqtnpXt0ta6NqWhRWzC68PZwNHQ
 pBxchguQ4rkdeP1aiO_0BDRvTqWgRZOxQz8DUA2Broq47mPvSVjgO4sAUIO0VDal691oo46YRk1b
 l3ZKy3nAMaY14tnukjqxKkvAG1z9jCPekfhKnNIhQzLHhAYekyYOuiBG7VwomwdxC4zwh5Sforek
 4Pae3g4_GmedRGEn1uRVylI2Di0z7W0sIbwF54U4dtoeN8LmM__P6xDf5CXq4FD6e8a4GP122UXj
 284jAoTwtrMiGRxjuvk59Lh9CqLsekjOx_wR_5utc8.d__xcfhGl3C4RI4dOMrWXc0mXX_XXEBIC
 I22P28b39YOljKpHY.k0kDn3ez_HB9hUul12P7vVejdq2zTnZbxxxNI54KiMKEzTwEdQQUn7WXHz
 0.lsiKZo89thJ3skQ5Hnfk1Y9ffBTybA7Ze4XDJrUz.4-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 9 Jan 2023 18:10:47 +0000
Received: by hermes--production-ne1-7b69748c4d-drrwg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d39a5b2fbd300476a1ee2f5b9fcd175a;
          Mon, 09 Jan 2023 18:10:41 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v5 8/8] LSM: selftests for Linux Security Module syscalls
Date:   Mon,  9 Jan 2023 10:07:17 -0800
Message-Id: <20230109180717.58855-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109180717.58855-1-casey@schaufler-ca.com>
References: <20230109180717.58855-1-casey@schaufler-ca.com>
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
 .../selftests/lsm/lsm_get_self_attr_test.c    | 268 ++++++++++++++
 .../selftests/lsm/lsm_module_list_test.c      | 149 ++++++++
 .../selftests/lsm/lsm_set_self_attr_test.c    | 328 ++++++++++++++++++
 6 files changed, 760 insertions(+)
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
index 000000000000..6f7f72c25cda
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
+	FILE *fp;
+	int len;
+	char *path;
+
+	len = strlen(PROCATTR) + strlen(attr) + 1;
+	path = calloc(len, 1);
+	if (path == NULL)
+		return -1;
+	sprintf(path, "%s%s", PROCATTR, attr);
+
+	fp = fopen(path, "r");
+	free(path);
+
+	if (fp == NULL)
+		return -1;
+	if (fread(value, 1, size, fp) <= 0)
+		return -1;
+	fclose(fp);
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
+	ASSERT_EQ(EFAULT, errno);
+
+	free(ctx);
+}
+
+TEST(ctx_null_lsm_get_self_attr)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	__kernel_size_t size = page_size;
+
+	ASSERT_EQ(-1, syscall(__NR_lsm_get_self_attr, NULL, &size,
+			      LSM_ATTR_CURRENT));
+	ASSERT_EQ(EFAULT, errno);
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
+	ASSERT_EQ(ERANGE, errno);
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
+	ASSERT_EQ(EINVAL, errno);
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
+	__u32 *syscall_lsms = calloc(page_size, 1);
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
+			ASSERT_EQ(0, read_proc_attr("exec", attr, page_size));
+			ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
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
+			ASSERT_EQ(0, read_proc_attr("fscreate", attr,
+						    page_size));
+			ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
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
+			ASSERT_EQ(0, read_proc_attr("keycreate", attr,
+						    page_size));
+			ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
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
+			ASSERT_EQ(0, read_proc_attr("sockcreate", attr,
+						    page_size));
+			ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
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
index 000000000000..c5675598b2a4
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
+	__u32 *syscall_lsms = calloc(page_size, 1);
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
index 000000000000..86f8a5952471
--- /dev/null
+++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
@@ -0,0 +1,328 @@
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
+static struct lsm_ctx *next_ctx(struct lsm_ctx *tctx)
+{
+	void *vp;
+
+	vp = (void *)tctx + sizeof(*tctx) + tctx->ctx_len;
+	return (struct lsm_ctx *)vp;
+}
+
+TEST(ctx_null_lsm_set_self_attr)
+{
+	ASSERT_EQ(-1, syscall(__NR_lsm_set_self_attr, NULL, _SC_PAGESIZE,
+			      LSM_ATTR_CURRENT));
+	ASSERT_EQ(EFAULT, errno);
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
+	ASSERT_EQ(EINVAL, errno);
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
+	ASSERT_EQ(EINVAL, errno);
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
+	ASSERT_EQ(EINVAL, errno);
+
+	free(ctx);
+}
+
+TEST(basic_lsm_set_self_attr)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	__kernel_size_t size = page_size;
+	struct lsm_ctx *ctx = calloc(page_size, 1);
+	struct lsm_ctx *tctx;
+	__u32 *syscall_lsms = calloc(page_size, 1);
+	char *attr = calloc(page_size, 1);
+	bool active_apparmor = false;
+	bool active_selinux = false;
+	bool active_smack = false;
+	int cnt_current = 0;
+	int cnt_exec = 0;
+	int cnt_fscreate = 0;
+	int cnt_keycreate = 0;
+	int cnt_prev = 0;
+	int cnt_sockcreate = 0;
+	int lsmcount;
+	int count;
+	int rc;
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
+			active_selinux = true;
+			cnt_current++;
+			cnt_exec++;
+			cnt_fscreate++;
+			cnt_keycreate++;
+			cnt_prev++;
+			cnt_sockcreate++;
+			break;
+		case LSM_ID_SMACK:
+			active_smack = true;
+			cnt_current++;
+			break;
+		case LSM_ID_APPARMOR:
+			active_apparmor = true;
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
+
+		for (i = 0; i < count; i++) {
+			switch (tctx->id) {
+			case LSM_ID_SELINUX:
+				ASSERT_EQ(active_selinux, true);
+				rc = syscall(__NR_lsm_set_self_attr, tctx, size,
+					     LSM_ATTR_CURRENT);
+				ASSERT_EQ(0, rc);
+				tctx->ctx[0] = 'X';
+				rc = syscall(__NR_lsm_set_self_attr, tctx, size,
+					     LSM_ATTR_CURRENT);
+				ASSERT_EQ(-1, rc);
+				ASSERT_EQ(EINVAL, errno);
+				break;
+			case LSM_ID_SMACK:
+				ASSERT_EQ(active_smack, true);
+				rc = syscall(__NR_lsm_set_self_attr, tctx, size,
+					     LSM_ATTR_CURRENT);
+				ASSERT_EQ(-1, rc);
+				ASSERT_EQ(EPERM, errno);
+				break;
+			case LSM_ID_APPARMOR:
+				ASSERT_EQ(active_apparmor, true);
+				rc = syscall(__NR_lsm_set_self_attr, tctx, size,
+					     LSM_ATTR_CURRENT);
+				ASSERT_EQ(-1, rc);
+				ASSERT_EQ(EINVAL, errno);
+				break;
+			default:
+			}
+			tctx = next_ctx(tctx);
+		}
+	}
+	if (cnt_exec) {
+		size = page_size;
+		count = syscall(__NR_lsm_get_self_attr, ctx, &size,
+				LSM_ATTR_EXEC);
+		ASSERT_GE(cnt_exec, count);
+		tctx = ctx;
+
+		for (i = 0; i < count; i++) {
+			switch (tctx->id) {
+			case LSM_ID_SELINUX:
+				ASSERT_EQ(active_selinux, true);
+				rc = syscall(__NR_lsm_set_self_attr, tctx, size,
+					     LSM_ATTR_EXEC);
+				ASSERT_EQ(0, rc);
+				tctx->ctx[0] = 'X';
+				rc = syscall(__NR_lsm_set_self_attr, tctx, size,
+					     LSM_ATTR_EXEC);
+				ASSERT_EQ(-1, rc);
+				ASSERT_EQ(EINVAL, errno);
+				break;
+			case LSM_ID_APPARMOR:
+				ASSERT_EQ(active_apparmor, true);
+				rc = syscall(__NR_lsm_set_self_attr, tctx, size,
+					     LSM_ATTR_EXEC);
+				ASSERT_EQ(-1, rc);
+				ASSERT_EQ(EPERM, errno);
+				break;
+			default:
+				break;
+			}
+			tctx = next_ctx(tctx);
+		}
+	}
+	if (cnt_prev) {
+		size = page_size;
+		count = syscall(__NR_lsm_get_self_attr, ctx, &size,
+				LSM_ATTR_PREV);
+		ASSERT_GE(cnt_prev, count);
+		tctx = ctx;
+
+		for (i = 0; i < count; i++) {
+			switch (tctx->id) {
+			case LSM_ID_SELINUX:
+				ASSERT_EQ(active_selinux, true);
+				rc = syscall(__NR_lsm_set_self_attr, tctx, size,
+					     LSM_ATTR_PREV);
+				ASSERT_EQ(-1, rc);
+				ASSERT_EQ(EINVAL, errno);
+				tctx->ctx[0] = 'X';
+				rc = syscall(__NR_lsm_set_self_attr, tctx, size,
+					     LSM_ATTR_PREV);
+				ASSERT_EQ(-1, rc);
+				ASSERT_EQ(EINVAL, errno);
+				break;
+			case LSM_ID_APPARMOR:
+				ASSERT_EQ(active_apparmor, true);
+				rc = syscall(__NR_lsm_set_self_attr, tctx, size,
+					     LSM_ATTR_PREV);
+				ASSERT_EQ(-1, rc);
+				ASSERT_EQ(EPERM, errno);
+				break;
+			default:
+				break;
+			}
+			tctx = next_ctx(tctx);
+		}
+	}
+	if (cnt_fscreate) {
+		size = page_size;
+		count = syscall(__NR_lsm_get_self_attr, ctx, &size,
+				LSM_ATTR_FSCREATE);
+		ASSERT_GE(cnt_fscreate, count);
+		tctx = ctx;
+
+		for (i = 0; i < count; i++) {
+			switch (tctx->id) {
+			case LSM_ID_SELINUX:
+				ASSERT_EQ(active_selinux, true);
+				rc = syscall(__NR_lsm_set_self_attr, tctx, size,
+					     LSM_ATTR_FSCREATE);
+				ASSERT_EQ(-1, rc);
+				ASSERT_EQ(EINVAL, errno);
+				tctx->ctx[0] = 'X';
+				rc = syscall(__NR_lsm_set_self_attr, tctx, size,
+					     LSM_ATTR_FSCREATE);
+				ASSERT_EQ(-1, rc);
+				ASSERT_EQ(EINVAL, errno);
+				break;
+			default:
+				break;
+			}
+			tctx = next_ctx(tctx);
+		}
+	}
+	if (cnt_keycreate) {
+		size = page_size;
+		count = syscall(__NR_lsm_get_self_attr, ctx, &size,
+				LSM_ATTR_KEYCREATE);
+		ASSERT_GE(cnt_keycreate, count);
+		tctx = ctx;
+
+		for (i = 0; i < count; i++) {
+			switch (tctx->id) {
+			case LSM_ID_SELINUX:
+				ASSERT_EQ(active_selinux, true);
+				rc = syscall(__NR_lsm_set_self_attr, tctx, size,
+					     LSM_ATTR_KEYCREATE);
+				ASSERT_EQ(-1, rc);
+				ASSERT_EQ(EINVAL, errno);
+				tctx->ctx[0] = 'X';
+				rc = syscall(__NR_lsm_set_self_attr, tctx, size,
+					     LSM_ATTR_KEYCREATE);
+				ASSERT_EQ(-1, rc);
+				ASSERT_EQ(EINVAL, errno);
+				break;
+			default:
+				break;
+			}
+			tctx = next_ctx(tctx);
+		}
+	}
+	if (cnt_sockcreate) {
+		size = page_size;
+		count = syscall(__NR_lsm_get_self_attr, ctx, &size,
+				LSM_ATTR_SOCKCREATE);
+		ASSERT_GE(cnt_sockcreate, count);
+		tctx = ctx;
+
+		for (i = 0; i < count; i++) {
+			switch (tctx->id) {
+			case LSM_ID_SELINUX:
+				ASSERT_EQ(active_selinux, true);
+				rc = syscall(__NR_lsm_set_self_attr, tctx, size,
+					     LSM_ATTR_SOCKCREATE);
+				ASSERT_EQ(-1, rc);
+				ASSERT_EQ(EINVAL, errno);
+				tctx->ctx[0] = 'X';
+				rc = syscall(__NR_lsm_set_self_attr, tctx, size,
+					     LSM_ATTR_SOCKCREATE);
+				ASSERT_EQ(-1, rc);
+				ASSERT_EQ(EINVAL, errno);
+				break;
+			default:
+				break;
+			}
+			tctx = next_ctx(tctx);
+		}
+	}
+
+	free(ctx);
+	free(attr);
+	free(syscall_lsms);
+}
+
+TEST_HARNESS_MAIN
-- 
2.39.0

