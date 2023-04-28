Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7841F6F1F98
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346707AbjD1UjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346543AbjD1UjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:39:19 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7AF2D45
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682714356; bh=Fp9lrVtrNVicSx7kowMCBpHDobGKxquDxegaCSkzu8A=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=DWh4W5dqX9dh/Cxms7m2IETPuiC3mwsPS1Sb2apROnvtyl+ZhLzwNN2VZAHB2HqlqFwenHkRmEFHWDA1SpG2xwvsBrWY0HZhDQLiP+0NnKsB3GjWkE7wA0evkmGOktomF8NHcHGHlVgMb+PygECP/NjuTu8nEptxkV9mXFPouyNz/ObfMrhW6kq/XuLza4DEx/Hd0VGrdkQ7YmwfmxYXfjdjbDsdgR5jtXdtU81ELObsrss4VEqjruO5qMEJbUXffO1WDwVoeBgg1Q/rUQjHWyA1QKl29hu9KYiz02oXvzHACtfNhBMAqKD6tDLcDxMa/0kTBJbPUiTvcskrnJf1Fw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682714356; bh=WBAEw8xIiVh6yMXjjVz3UohskO15Hn2Whbz4fRZfldQ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=feCFo4pTQxE2uMENoEMtUG9HQJFkofZ32Wjob2oWILJEsBa1v6zIYvTBWepXaYmUuIfatcCNsSrUIo6HTUpkZhz/cLb8JZX7Y18JzAjmLtODVSY2aX6/ISXRMiR0xwjijhGWcnrskP0Y+8ZbbEmktbexyIg/KASEsrH7itX4v0LQnAsIcICzsITuSL8XdOTXA/QNfAsQLR9JdAr2uprGWaoAOKpc1ZQOZvoRNLUGWh2Uag29u+kWKJOWqMmhxD79Q1J+UP1FJDygwl4bmUu6cDCBRZJukqcE26l1Vg1TNA+FBomSYPcWllBGPcTlF645Fk/SGUeFhsjiw8lGDiEejw==
X-YMail-OSG: PhVyqqsVM1ksKYRdXmfff2h0AX1Qw4uNUiek.zhW.nvDuZCgyhqljpq1ZNNgvrP
 JFjfeeu6.iHibELWTAI0K8Ildkno.TMVvkf0HvJZSZiW3oESLEYNbjh8ewvDQ0TCmyOk0g3MzPAV
 A8_idLVYKqdxG5dVIkow_E4B8KSU.VTrm.hhRZzYNongYYP1CWkMwIWd3EJVZmOi90y2yuHc_9YN
 aWHRUvDLEiJkkkbF_OVekU0Pr_yE7r9hqfuKkES7s044rIqzx.yWDIxdr0BL8boXWMGm8G0jtvnH
 p.OcjpsFPmONBemQwWnomJsuLOxiwcfuwTiQ4vX7r3iqSA5n2DWh79GOX3jbR9.y.hEWMvWLT7YI
 WCh7ofRk_.AAF_4r1RwuT7JCvd5XaJV.vz63xZD6sAT.AufPyo.VeCEv4Ftm1p_G.F_nwK40voJ6
 OEgZrBB2edzZm78jpZ6XxNSysJr4WzG0UsdGBYmJJkhOfXPDPPXZzOaf9wCJwqE5E5X0bYvekMAk
 Bx19iN.T8JtD3NddIwZ406OsfInLr.FHkDffKAfPmWwl5qkSj3Q6KnEG5P0Iy6rV0cercc690T6G
 B5c7KIycOMmSV9tKZauTJQc1DisOKK_.piRL83yjkTuExEa_sOB9DkuOizEjwfFQWOWUScgL5Y4R
 ohu5Hx8mGBQaDki4pjLA6UfhY_aAkfOZBA1KzDPbN4qaXva.8sE6Ik7R6CBPmOJjS6S_nyXflTfV
 yi9EOQ9Fxn7q6Cra1rtyFrVV_7B8jHoHhvUsYMtpdCexQvGSb5HFu3BYvTWTag2wxAaPY0bbYRc7
 jUG1EHF20MUdYSEGRihT8e0Cbrf0jYxSDMsj.rnsoZ.pzy7afiC6mtjqohYWugHbhKktG8vfZZH.
 eQqwkd2_TnJ3x4HdpvjFvgrd_kMf0INti5SANMldhMCRobjZb1WRUBHdH3.iA0niu9Qm8kPE1Ytq
 Eg4vP251n4aCmvSg4vbHU4jSBInUxKFw4zRQ2NUXEcQdFJnbd9kzBYae.tC3liuJN5tmv3fHtqAJ
 lXPKIerDu2.ziIjwf.5Z3gOWgFVRT1UWCI4g7gBLSZeeg.qg_kStdlv139sdLoDgIPMLr.jgYIfb
 w5bQ32d5yPpeBoVW9zgVbeB4FhnfxdAHVhMmb9YRtdNn93md.qyDfDjmrqRH396QYp3kApqe1Zpw
 v6qIhqbsJRAu05Dkn.6blNMmnoulZr1CpNahz2qb7p8ml4NW6G3s8NnZiiJb8tl9Gytj.zWebXTH
 IdaE04dBx2882bGbgsC4k.oFLRcbTpn84zfx1og6Mtgavaq3EkQPIK6y6HAKz27k3s62j1FU3qzz
 Ojg0OcuKQLsF8j2JoAhH0W6PeCeq_plBI7AX06tmlMkgYK7EtKknUhkDttMNq5U_yYGfG45RaJOv
 0aKY3E7Ny8FgRVWHM5JzNgq57ons7.ltO8UuRlkqB.n0ZVr5eVJGoGrWNljd78biATO7D6.pnQhc
 1SdAhEF5IWqe22pTPnJMV_VcdhUjX1OLgnlnr8Ecdh5N2.fiJ3rx6bvVob6fafDN4X1wpbSS6xm_
 pJF5fdFntHjBhE73MhdLFVDOMVaLOT..8cXtjftgUMjgUPeyNZEqy2OWR5.hyqw053HEhPsr5Yev
 TRF3PwwbAjQhCQucUK61sRV6UsB8cqkn.lv6k3qgXhZnVJpyojW1k9ZBnOQARcCxKwuQPe5BJvZe
 yjxN6DYqDuBt26pby7bQiQzcbLjTq1KbD9VUB1elCE6eiZWiifO8gbVq75bl4QnqWdK_q7Tur4p5
 Ov.1ex4LaCD.nycYmx0y3Zas73vooCjCbyhCM90VYIOg1E1qS3xdrH65DwPKg.06x5jM7swU5iFq
 m8gtIq4u2LuCQaHlq_jsw6L0hRZwi9tc5r05.vsy2ladSvZwf3n1kv3HCONazBrXLzcu2D.CTiWO
 Qvyavg2yUd8_.UB6IJFauNK1JxZUbOE.eGx5ggzyv6X.3OPFmksPJreUukzyELpW.izYJ95yycIN
 gnmqxuCzdbA7JXXNeK2FM_zJny7sWXCVCzLVI.Ryij_vnyoh4s7eMDGpBviaiaLOtZVOS5z_MaxU
 IEoL_Nh36IcbGl0E53W4_Q7jH7IUOIMMgkRxF16N_K5pXkLrdbELc3qw3inTtlZ1x7Vz5AwYqwbS
 jOSUW8R0OsTRM.otw7vwe0oQuqCVboASC1xLAgIgTddsEEMUco1w27CUVDkKYDjL5bvwV3MqdvUB
 jOeeLgq2vbHkcVgwYDHq6k8s0MC2bGwaD1mXyH4rmJU.t44V7QoQmI7hyJcRkL4aJlQzP7nQVhsS
 dGlOytDt_Hs.aMQzZ7OauNlJNeMOx2Q--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: aa2c239d-22b6-4f6c-bfe6-9c0ee50c93ec
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Apr 2023 20:39:16 +0000
Received: by hermes--production-bf1-5f9df5c5c4-wvm2h (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7872f02abf9ba03acc5bf1902aa8c755;
          Fri, 28 Apr 2023 20:39:15 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v10 11/11] LSM: selftests for Linux Security Module syscalls
Date:   Fri, 28 Apr 2023 13:34:17 -0700
Message-Id: <20230428203417.159874-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428203417.159874-1-casey@schaufler-ca.com>
References: <20230428203417.159874-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
2.39.2

