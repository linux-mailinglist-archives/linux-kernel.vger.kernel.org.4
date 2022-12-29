Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E42B65935A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 00:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiL2XjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 18:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbiL2Xig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 18:38:36 -0500
Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3433310FF3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 15:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1672357112; bh=TMEsHu4LlAJ0jeoKtnejUwfMeI4bpUXByg0YCSHhEkQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=DzWsG2UAgvZbB5Xa/ZzSg3Z8Y8GXtVWs2yq1Jbtb2EZnOFytLUg3v/+pjXZ2wINRv+f7ElbWM76Zh5aue/FXJvDwnphTG/9B8Ni0udk+Y9h9VvCT8/ipcLZ3OwnQ++faW3plxCdQYUQZbQOtL4HTiMgdALq3B8DPWWec47c9R68kzYFc1sD1J1lA52qLcCHx0Q3rjmBTd5ceLXeJ4yHEW2PtFet0ZIPhctdbTPG7vjja5VO2Y/sZ2k8TJ9K9DPfy4hVG5YsbvvG3FVqsOkSJ7HujX6MqV/KFJanY5Cswf27edKVdQcnFVRyrIxZomgloPe/0tmxdIxn3v3DHcp8jMA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1672357112; bh=GH3Js6+VifG7f9b9HSWA9JswyIB6iSBJo2wC4y6utex=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=swh4JEATnCBuArJhSrtC5uoOKTFiwxyGMpNhEltSWVabK2Iw85zDCFxVfQZ4z7Um9LqAe0FrhzT4qCUsDCvED6aJK5vVcnZbqf1nh8bpmp2sLba/TcqSZjXOwrhC6pSjuc1WPe8qgdUM73GgjUV+cKl9uu0xvuiIys8LohcZFiemtViBhfYzUzzP04OXaLSOvK4xm9cB55cA5v+kPKlTyeQXINOFqPt+TurE97Ckq1rAynLNqCqS5ukRDROWh1OLwf3g1nx5NQuPbuoxHN/1zkcmCflds4JHL+Y6vog+gyr1eLFd+imbj5SD4aizWvnuJKufCRR6MrSO75CPCELI/Q==
X-YMail-OSG: QfpDx8kVM1leyKB.V6XadyPH1cz6P_XTCoerHCrP1TsiLJcPsh.G3VTabsPISLE
 k_cr9xmkQjyZC5HQ1ZQ0lsGVAfPzIqIlL3.Drg868kpdziw9nbnd9aWipYm8vCycPWx1EHeHsduL
 ouOo43AtFvQwX8oYa2QzQghYfCVJKAHNQhJSDneSrYVisWS8TjUVoRUL6sSscUwSIlM3m_.DsnTN
 FqKNa.I2_FD8Crhka3IsWvqjA5fUGBdSekM_alzE7KWGQmZkN7q.Yx1G8uy6nlfv0FzlPKSSh6yt
 bnyJGBQRYzRiQllWbXm_GZscB.jaLE5.tZlI605vnFrZ_9ekWsz8c8op6CnD59Ug.TupVls0DEjs
 X5ynp962cEC5UU7k0_Y68Dpsb35evUMSK.BglTn6jxxzf2Sog9r4oCkJvMlfqFNbu8IKJgP5lM5f
 aAQLOX1wbxWB.A8UfGVgoulBx2Nb.p7rVMbXskAW4nwWmJj5Q2DZSqW1RmntWNXtiy4RsdYYfnC2
 _egKGcF1qaTqFetucehXp9WhugAf2I46jnSnLucQIUXTu9gFEZuoj.kurMTcfFJK0ekCx2SadKrF
 q7MV9KtOOPMeo8Oxzf501mzNAYKG8.qYpVYRtxVBaUmVgvj9_P8mYTTPpLRYQWo7Orwc9ubB84RB
 L_7nE4nV3Y5o_hzzxdLeeWEWJB81EOnXdKhAI1zC84By_OXBT8MW8ZV2a08uy81cN6pf9py3aY_p
 U2JBy_Si9DW.voOmgjP5IOrdND2ewCpDYBvuT.Hzd1KEVnPB7OuCEDE9y35ehJ2Qg5r2srjrCkCG
 aR3mZio5dzw4F4qMoDGISKxJL8vvbiggeiSUz_ukjpLr1uFH_.NrnnT0vCjoF5TqIxV8euBjgmrc
 taK8HDi0J9XqlhJ7dT_3f_d9gK_qwmub4jNxgF8Tg7LoRvklmqoAXFkmnAonPjJUBIOHUKHRH184
 Si_Rus2HLGW3VOH8iOkg12RBGtnP1JXyYmZlOwHh3tbRD6nrt6XXcrbi6naqQzGxnD8U5B37DsFF
 EkvziYs1hO4EibN.kzvGPQ1.FDtSfyDSuA8pu_Quqk5DB2IMaSh6sPwMw79pDTmE4JXtqri1qDJj
 qZf8JcnT3AZB_o55t9skR5mM1ZJ3iqvlRIJFpBT3h8DCSmp9TBdEBL.KOdHzLY1vBerlpQ7pbfZH
 XV7FJbRYjVnZ4Roqe1CCObxqe.SFDNzhP8eGFKRbaoDvF66pHa1N.3K.QATH8wleNUJXdAGIZ74t
 ESugkm0QpPg4R8Q6w9qKGkp1TqSJvV6gzchtTPmFH50q8Qxfv0Kv3GXZT7JuPGk5qvv38SV87Dz_
 QNYinY3TSHRJkEobQ54qwgRmnpyhhqqcxgO06sC817OUshGZxay9Q4bCFHmLyx7ZrJ8acJ1yCK_y
 9PZ0XVO_gHgCHkZ9msqR7dpcjBo4CrL8LNVEmfYDu7xavnFUCbmHGg90ELyPwID138P3sHGLtbiK
 S1OIJZ_y9fuq0lsZY9hFSJqEQLDl.nq7DCYiOT5G1KCeo86pcx4c1ylH8b747jkqARPnXPDzVgkh
 _jvjoNKEMmEiELeTHh8f_R1K9863Tc8hBMg0pBgZd280ykXsviv0_yqcagYVOZSWowVbvDm8vpp2
 iaQGCJ.zVyMuXFuFzlUuN6rp405vaPN1UIfNsFh9J_IxZkHKxd4JY._lz3k_RO3LRVvMTcQ50GlD
 ktfhDofyR61zhbGIDX62rKrT1gbtipHGurVJ6H44tGf3k3PBWHKflS41_xHGVmg6iMZfc6le6X_E
 RMd6pNwzEw707wbdg6u_mP5hUcxwNh_2h1VKGI7AoBMlkdB6jE5W_YgI2hMf0jnLJMJRPzV8Mgxr
 jd2xXOkW83dexamB0yM0NhU1TsaOIRu3yhFQ3Fz.npmZi3kvl2FI5liPQhBDL6uireqwJMBNhjHK
 70x9XVaZ1.PXPN1bnoM.19ro9DM.uiuknZq.ZyXG1NT5cXcEUM60ME9qiaahmp920RM_VHnrwj0m
 SFt6XN9rK6tMWKzF_JPRIqtXzKz2DRpW8dEWKdYCXcYkQY9xl6tglv6E5rvhSYaFo5LaupMdKLAW
 WpE2TZc_X5Cel..ArP0QcUUa8N4VfKeLu9Mnwa9v8P9gQr3hfoQ4bwh.CrRs_w0luP6uSI2ITwwp
 YK4m8G0.kT2xM3DaPvuSrgicJL8IxiwSQ67D2FBCMemKLg1h4895aiUm3EVL4vsLELc3FPr9NJkd
 DWjkfBWhdbeh3E4npYOTpPR3fXLJEo9sXjuyFo1IcjePrrNTE8MgdWNDJ3xaRwEDyt6FlNIy9FLW
 fw94ikIlwyM99utOa7s9U
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Dec 2022 23:38:32 +0000
Received: by hermes--production-gq1-d898c4779-kmgvg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c30ab77c0fba0515bdb50273bd82270d;
          Thu, 29 Dec 2022 23:38:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v4 8/8] LSM: selftests for Linux Security Module syscalls
Date:   Thu, 29 Dec 2022 15:34:54 -0800
Message-Id: <20221229233454.43880-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221229233454.43880-1-casey@schaufler-ca.com>
References: <20221229233454.43880-1-casey@schaufler-ca.com>
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
2.38.1

