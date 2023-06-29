Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21308742E27
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjF2UBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjF2UAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:00:46 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B6F30D1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688068839; bh=DKeEkj8ly1FqNoGt8EcMyRH/A0S4Wx+vordwNsS8AI8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=OpLJNFKeMrk4FtOwzj07hFndorz6L4PyEXVH0nKNQaapvKt6acOTfe7lMmfxNdiQkT2VsVDc6AHWz+7jSqz68iQy7Ven07fXjbPrT4xdhKwBy2rLEwqtlZziprYXYhxuw6RTuxe/xbS4foGjNn6Cv/uIbrhye2nL7NjfbrqTijydesPLsWCY+u6iRERHt7Jt5KKgnxB/hZbcmrMNwiVD5fhQ3S6Fn79h2mnFTk9DkKiTWsyStrPkzF8b/r5h7VSBMLsRuaXV8aaS+S4KPI7UICXaXSnx0N5j9ikjS8Cet3o+y7c+qSzYoRzn8C1aFEHprafNP+hqAnOGzYDAg19YKA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688068839; bh=iotjg8uy680CCTiYi9vcSAn9fLlOEP37xJ7QcN3JyV5=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=gfeO6sbZt1wQ6MixYOsxJDJ9m9cg8ffBABEhsIlbAVjtZUQzZfypARvyJDHbEMwBozKuzw/yQJuCMRoAHF8ilJZvfbHo/U/o0SgWailU/FVNkCxCEPmRP9kbWoxOCEb4RowI0C3LOl+RzUagTNbrd6qBJEgdOiTyqf3oagH/z43PtT8WWlKHQtxkciZEYFIlwf+5t8b5YYuyxpkVY7szjghEKRKgQq/PbnXFR6SUJzJ4fD7a+kwc6A9Gjx7c7AifDOOlaY7vqVb816tZx/IMZfxOByUUt9IheeTYJ/egCN11RsgsJ0p1h1Br7Xb9LWmT1Ptu2YccGGOKKV0R45/4/w==
X-YMail-OSG: TVXKOb0VM1mT1_tdk7PTH_dkWhF7qrsSGp.Hhz5CXdcGLCt.MYH8DtWnWnbq9Qa
 gA1Tlr7fvEEG4IolC2oVKGKETtftweFfx6EuShavyfvUfCNOngzTXmWOQJzEUnqXmwJ6Pjhe0gxH
 Ob4ISaIEBIOFbFDHITHgDGP45is9Cgzh9dxBlxyvm9lM5uaWt9yPoAmgxFvxHHSZX6IMDWp9SECd
 nLuRMAehYG_U9KOHpgFSlKxJ78yZz069A4qxoOmRwmNsZr5jChVtYjPEYolDKYmARXgdbsJYcXwp
 KK9b7ppMUO8_gtXtuzKuMWCkmxduXtsuSseH1QRa9CHWGa0SWx3x93iTNWXROIaLUz1PrztaMm67
 .S2gt4G1oplmVFADUM5ZWDtyZ31b3AKR1wlz.Y6B.igmdSM2Yri04HKOmnI8Rf.SfKs58ktPuuG9
 alx0p1040GKWggzkrJgPShinWW6ujUdAJ0gL8ZK9TO_iKR2P.EdN9Hi6PhTvfVB.9xhgGN01AC50
 1Cxa0f_Byli.6qgQt2wcErdtPm4SipgC7JDoozt015.EEjrJOORubigXmrsf22wNKyFfwrvwN6kG
 AMgYSYEJlY3_B6_IoJDmibhV0VwYQjoBWqq74CWhbFru01xYD85tpIeagu7p_BckPmm0XebD0wrw
 oGSaYlhjvpXj6FEfiYSH3Y6ScZbUWB8fFpKZmTLpO_87gy4cksJKOeKOO4W46l5mEBGhDAkMZ5.M
 aiR.NAsJrUckKxBzwCCSgXMQx8_vfSxZ_20nZdsKC2yiWCwYwktDfN1_.iwHXG8G0V8i4RtVV.aP
 KRBtAiaaBRESWZf2.SzzxBXbHlkTXqBA9bYD.zywi3xASNiQneGM5KXp8JxBRqNWQJI1vy9a2zmx
 x_J3dZSa.ghh_vRKdA.LC6CfQs2VlzS3VaClHr2aCMoXGJA.jd_8XxYIaicmEdOcQBtylLXzyOSY
 L.fsUhNRV42lfbDtumqjG34WhjO12Xl86UAS1I4nFo2GKh_BXiwG6BEQUp9qEP4hX0uTSuIgPWe.
 AaU8AQAu_P.0aWPxed2RPp8ymVLhHD3l1SM7IEgm_d4yZRhyW4j_gxUkEwOG5Aaer5MsLj.4x_1y
 cFL3x4DwTGYOgBEWqiPEmvSncyapalIWZWBHovs3nIYlaMjN2cSFmsOzJMbrzli3nlFdiiIylKkS
 jxTSTJYouzLPAu4AF2KlNxKMzUa6hignpbokCmj5IwXtshvZDZziYti7a3pLjtKAYTDTnvSfwoko
 oJj2yZKbfbGFgtTGgTdA3yMx0ihzt6tG2LKZjgYUAPa7GKw_G45HcZ.pDqvPMSJbfNJTedRzJqG5
 upt1I2X0120ENh0KYSWVWKPASpyBrb6OamNVgvSJT2tp6jFjpNXBWFiWPjJbDz9CgwnRGV.VdBhl
 YVu2JVq2ji0QTAilHnMD_y0yIOcStoeekwYkdEfP1f4hLAoWBbD_X7jTBxpK_82tOl1P5ZTrx0zm
 153L26fynIXENaFb1RaW5yG.B3_QNjOgy9sPvHzMhaA4IqKoNFx.YaFAvOy9RUzdzup2FOH6.9Hh
 FB_sY3.pjRUwYS0QQHqYkzctyVIY7aedLg.bG6MYxShGjut25bS03MCwmTDw_Cdiwy7bkj5O7wY9
 7ZOZyNMFpvhC4je03nhFI1BG8jdjz8E.0q8AeArx59ZJpUOIN9H1niA3wX3ys23ndi6AIeoqlpyB
 gYww_Ozs3fx_9zHxJTgXfzv4PeBXtd64S6jBWlba1MW2Jj3TtfrNM6PvovVIdcpZgjOaikpKvkWG
 vMHXP7_DUBB4Y673NpeUtsFoWfnf9O9CfCv9uC7JQMrmFS5jEyf0A.gR74EuFvme7hA.qGfXyjj7
 AGL.TqxtDETb9htdRVW5C5JgEHy1eQQwDx6MvQLKv6XC2hnQ26lOf7yM6xRoC9lYyZi9ll9adjGF
 32vzUIoEzn_cmj_bXjKklYjfdzhU5z1ZubVBjolzVrWKJw4l2fC1sWqEK6jclvGeV8umEJnsiZDx
 SJqJ0KYkXEJA0aZXvs73lD9rqLZ_ZqorTPd499wz709b03EZtJr08yIHtCS1EtZurboV967.bMMH
 yfx82L3Il2FZjpfSrEDzXPIKHxivdC58dE48xTzDqRCf8Ad3jiSVvi5D2_THHllnjLUKAlhCuvIp
 7mrG7PyWC0CHlikrgfhTzYJ94ODFR9JdBmwJ6JwHzAE4k6PNwrCk6Cln5.POEfwTpT3wojbcpbvh
 l3swupc_h8bQ5cLpQUFP3meiE3uyCaAK5NCkeRafK384tHFSo29b5FLNWhKUg9m.4WIEAhU1EzSv
 QzXg54OBlCGtUGGEvpy1ITMV1ncR6Mw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f4eba601-69cb-4c92-be90-6761b481aff0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Jun 2023 20:00:39 +0000
Received: by hermes--production-ne1-6d679867d5-5vpxd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3de0d904516dfd44a291f116baddfae9;
          Thu, 29 Jun 2023 20:00:34 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v12 11/11] LSM: selftests for Linux Security Module syscalls
Date:   Thu, 29 Jun 2023 12:55:35 -0700
Message-Id: <20230629195535.2590-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230629195535.2590-1-casey@schaufler-ca.com>
References: <20230629195535.2590-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

