Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83A2636B06
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239898AbiKWUZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbiKWUZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:25:23 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822F8E074E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669234857; bh=LSlk9lF4xLYhvPsYXu95SiO4X2rzjX8vefAC2PmXp6A=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=MFcRzS91Dlc7ZRZsvJz4WaqRe5DqwwiVxngx1PmgiNBCcPXFoy2mxvnzZX9+bzOpIPfgx+os9YFCjq7SrSnu2pwXqyVzmH2dGEZ1qpxa0fRXUYMQgFxH/PnuAMr5Yhm7BWKWfXOY4jC8zWkdWNIlXSpeRGomat2Ywa2nRJptWkpiCWO+8ccqFMoPR6HU2EySAkL7jX/Phl/YdtFN4qnY/26xCAB3zP5gzNNz2cD2uyfIV2GteGt6MG4Yj433LsGlFHJRiUNVY/m6RQqU6h8UptboDjiOEq17KWl1ft9e1hEoD3fSNLY6dkp1SxV+cswPGj7iRRIvW6wRLBCLhwT0gQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669234857; bh=izIF+VMhm9UvzanUTdoevUmzvGaIZ6f2upBCS0MGyds=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=D3ZUOMzZ2/4vFJI0Q4iZrO6XDJrYFYbj6RbaTqXwWI25/yAbgVHiz1gMNIGHh7ngopBdXVI92NWT6es2kQR7ksxlnpRNAuJkd3O/aGeIFkUTPkfhmewKrNGnwEBUrDvj+LWu5cbi7HjSHlyJEFuY5FFoZ2bfosMJOiLzxbYCR/WcdQsXUErUXRHFPM2/cJnqOjlRi8O9jPXCFE6LAcloAWcY/N+xjmJiYGfyBWYeSlGMjGddnk26KMCYyjy404zyOIMUrQjrTUPpvPluDHiAU6vJ69rcHfcyiQNwFDeBYqe3NXCEFNuNU/hC1Squ6j/RIrRARRIgECruFfwJsYG39g==
X-YMail-OSG: epC3H7YVM1nY9I6JtS5l_2._V6FpZhzhT1Sl1b3gVsArWaH7lbQp_33T0TqMbwP
 aePIpbGg7ZOGRQyiTmU7K5twkp10_G2hsKGgfuddqcokpBl52vUdn3BZb6mKjMtdNpvk4kN73RJV
 BGZDvoSSmoLChfYINkaNxMfP8UUhRb7IYZHWMtXL.4MA3.Ab3K33kjI91MOfk439PDOpH47lm1fe
 iaAMhBk7MTYKqRJKbzVo8KiMqFq9T2K2lMBUn4bYcxTIY0FuUpbj4k4g0v4QXM_J_wMgKrog3puO
 PbyQf55.b5ybOIWJcPyHfLhpU17IGf7OAzrqWVEwsqFjzx0v7mqnhOlfA8TQ1BJgQybgYujcmxxk
 S76eV2iMM3SW7CVS4Su6tO8UA6Ax6bPOXY2OSWRR3_Pri5X_IKPHpFOKaZA7D0g.WOhHK7JZQWFq
 ar0MTRYsmyBtfybKMy5LSh6Aud4MaBg9nwleI3Gkukj8oImB4fw1ZMfepFf.1rcG1S2DqjwOakW.
 TJC_roRXV9AwJkkDTfT7yubPaqOYwfXpLdPVsj.T1j480TSPWPYy0rF1hDkG1sXum9DR40qUo9a9
 GctG4Kjy2faT9WS_id7N1FL195vM7LIkR19.7L6sQHrj.wzG4z1A7oEvJA8ToBkNur79ZzOPhT6p
 5ZXavHf8DtUZoLHBvWXdBTgTLVpHIXkyMktMh4TuYDmpHJojmCTyan_2o2wKeYpwFOE4FOaZikL8
 7CbfcAd.WniWKBK1dw5SgDnvQ7R.M5aAD6z2Etdn0PcqDgRBHvwgebAxzAtnmSrGIX86CWHIhEGe
 BJGQSEfgvipLTXV1PaRPrp0xHEvj16l0oC65YjtfbOQFmT3SwL.Q7o2f5lJVchFtnxODShEnZEOc
 7IeNO1Eke9qLCEVVeZvnQ78wson9ivQgHBK3oFBSAjDf6gRL0CwnI6z2hw9XHKQKm7zho.uA83Kh
 .J2nZQRf8NuV9avITIW7nlQ2WLHPHvEvRGXvtjj80m4Uz0hAt2SUkKkrSqSVsca9VWpxrZpQzvYF
 PqY19..zZZMTbGbgFRuhkIFnQaSm_2n5dno5VMqyo_7L5Lhpw5BZc1MD57ZEIeaLFH4S2kRVtlaE
 8erM2jp5M2TsteooynH3sKpsWgWmT_bkn0QlP83u4rrabx6_EpfjnqAkwdWP43gLjZdT6d5R1b_A
 Wn6x7nEEJuXZvMEw2C02x0sJyGyqYUQrm9.MNwggtNWAd.WbDTp0TSTKxBAbEkuj5cJq0vt_uhOF
 1_HkZ_eXukPEIVoJyf2M7q0fFAtjzkHxk1BLkYCCslFUR1HbWEEwl2tgCGKOCZC7vSCLXDhDrOUV
 dEBr39MBoGBGh4zFZEdmwgt.h8Gakj41MrEZGAt54eUOPS1T9MC8EnrC75N78DkiaClbC0m6IoTj
 bOnuHEfEyQ0jqVYW7Ugf0jo8tbquGE_XCqb6wk69UvgV4cufok3vkleW55Ah2d5z6ZdfrKq..vkp
 wcYsFzxPJBOAPjZnmtNgwvPyr8KmdvnN9ZKa7X2.osLtFE4QoIsHsPikhdraL21nHEwAWE1Zq_nB
 Oc107_dyYVWQpb._2SQdCKHBGXncNnzlMWsB8lKPf4PaA3UDwO6TEShaOJtj5njA7XuKr9aIAgmD
 bwd34.bMQw6MPJxxtLHhxx7OE12mK9lI1zieEVY1ItQI8FDSJ5ZVWz8UrD.PHqmB2DgZBi1fGn2f
 nNcCOSQWm4hx7xRBrtDcCM3Ehq.UdqWFV9hwMvjPZGVGwwTnyTwaRU9dws8VNNeILLhhJizxTF9G
 PePZQ98Hyo5Gege5CHAp3BXksOpBXrBkMlT4W8qe7fap3IaNAZcCdMhYSbQIiTcgqxG78Po.2r8E
 rlZrc0vR_9o6jsgKYqPnyuA1F3Up_15x7XKPJ6BKPuZGCFK10e_KqupVusrEw3HRAfxu2cyZsDAY
 vqsJ8us9QG1AmkbencDdNXiBKaagZYjj81vNrnk_h0pptKGI0h3o5a3F_RG6RZR7C06JQXKPAqi3
 FnM0Speo0WQ05F9879s7IqO5TEeADOfCeWhiYEGV8x3.IuqUfrGbgum_91MRBYhwZbxAcT2dK1Wm
 XGmp9MvN8_99hbHC_9wu0TZ56r.NptMZWLhlOx42WlfiA5D0XUHuk.fS5peIfdhS5brNgTk947Kz
 nYBtcyETAeG6bLxJPKvyvvn15jkUsWCLV0fSiNdlx5vmvPduQmUqb0DLMDkO8y7JUrLvtvsT5ERt
 R0MMYnMa2hL6WIM8lsEHHefxGY.hoK6j5XXvpkORg0KSJcXKs
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Nov 2022 20:20:57 +0000
Received: by hermes--production-bf1-5878955b5f-xc4c6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fb1d64975d777c0bae103a551a2614c4;
          Wed, 23 Nov 2022 20:20:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v3 9/9] LSM: selftests for Linux Security Module infrastructure syscalls
Date:   Wed, 23 Nov 2022 12:15:52 -0800
Message-Id: <20221123201552.7865-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123201552.7865-1-casey@schaufler-ca.com>
References: <20221123201552.7865-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
 tools/testing/selftests/lsm/Makefile          |  13 +
 tools/testing/selftests/lsm/config            |   2 +
 .../selftests/lsm/lsm_get_self_attr_test.c    | 268 ++++++++++++++
 .../selftests/lsm/lsm_module_list_test.c      | 149 ++++++++
 .../selftests/lsm/lsm_set_self_attr_test.c    | 328 ++++++++++++++++++
 6 files changed, 761 insertions(+)
 create mode 100644 tools/testing/selftests/lsm/Makefile
 create mode 100644 tools/testing/selftests/lsm/config
 create mode 100644 tools/testing/selftests/lsm/lsm_get_self_attr_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_module_list_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_set_self_attr_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index f07aef7c592c..ee7e93bf956d 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -36,6 +36,7 @@ TARGETS += landlock
 TARGETS += lib
 TARGETS += livepatch
 TARGETS += lkdtm
+TARGETS += lsm
 TARGETS += membarrier
 TARGETS += memfd
 TARGETS += memory-hotplug
diff --git a/tools/testing/selftests/lsm/Makefile b/tools/testing/selftests/lsm/Makefile
new file mode 100644
index 000000000000..601974fdd9b8
--- /dev/null
+++ b/tools/testing/selftests/lsm/Makefile
@@ -0,0 +1,13 @@
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
+
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
2.38.1

