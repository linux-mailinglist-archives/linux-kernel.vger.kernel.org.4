Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB22B636AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbiKWUQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbiKWUQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:16:15 -0500
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6764178196
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669234569; bh=tapgCZ8UuEph/YgY9+reXApe/56KaTMCmFw4iIqnImg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=FGS3lUPlr0MUlbrsZLOqk/0paEh93pbj0wIebypSTFyI8uvCuLbHHBpkcz6d3yhBEveH0blOrB0jiafR9uO5UOaCwKxkqthkZCsRqbcpSDVW2bthFO1i1ilGSPF1goKLYFDmJyGvEpot1RB8yllP2yZAEm+JSdFvLlhGlef2kvsOWNrphegnfzT3It4UUVQ/pDH3Tb16eP+ldScZ7k3GcW9x4J+b4Sp/FH1YynH+0Lg44mUS4J76bfwYuxZlc8Nq4J7jOhqbK+ZwyOFRuZVZsUClGTUb5yejU6lVy+hfJ03aeicrWTx8u7EAney7c/bgSvKViFSUVIngyKwwGwOtiw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669234569; bh=MZbdQzdO9uYwou+YKeEdltqQEFCNRUQhkAxflK22JBD=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=TGfzb4mRN/sN1+g9eRt8tE3X4csM/r2IeHGGmXgNBWflccgcx2U6Lg+mhfbdjX40DEqLbBaEbGZ4Bo4aIPCoy9ivl5cWC3otPvWq1rebaVzWnqIwohkrVzJTabTobuC4rHUkqKH6WWd2U42wpQcyXlZyICpvWZ8sEIuYjdFJFsyFKp1bW1vzEr9r7sZFpIFwc9dC/VuipMukeve3u2mXEX6eUsxSjBmEvvoBuBxtTccuueUb2/qixIdkyhctlcuuFYW77t4pJkWIXOfq2DthiFIbYiCn0iahSbXjuyWjxwwfeeYarIpaEd7gyvaqMasZPTTDPzSRHm722GfaYQxgUQ==
X-YMail-OSG: H9bkC84VM1lt2_4zv8BzLcFoiCUZHrWmPxpLE8QY6t1i98a686I6a81QErFIQ_x
 cxlsatomADK6BmlYc.6HqgzN8hvBhuF7xpiUncj3Ix6KZh3P5TnJYv2T8tA1lNIZA9.uwJLaDaSv
 zcx3ZuZS0Q9o3_ijJY9YbTSyh_5eNOr5gVifLs.ccNq9stkciAcqdGdql.dciN7wkzq7WQ3DcVb7
 7PzAc.0GrWz6DW8iR5BVzdHyzRz016qwrQDyf14CSbUCsmf9aYu5o9b1c4tgvcG8dhODjyJo4niB
 MU0bidxMBFHXcfc2B08LOj0ThYmmhMek51XuZSHoyZSv3GwWGGXS0izIt_gwmTnRCa8_cGiRwt78
 jRXp.8wbgcSN.NTOnHIKMAQb1VgOXS0zS1J_wefxokDQwqKnjm1xu50J3PFaapFGC0afd.bZUp_K
 jO4cXj4yTKNKMlEvsXc6IpR3Ewh0IjBObKbxkUcroq5xaRJRqm5Up3has0NrASUGpzOojPDpDfme
 gtK.MGcY8BzI.yAsVdUGxjEq3ibBdkp3Rv0yNyEjn5754dyMNydqa4fLte2Vl.VNGAjVcu7PxU4G
 ZZXfXKy22KJQpATlHJflkPTDG5763MWHlxYKrEkXu5eyeo9qESllsHu6rUhe1WkMWQrvDPrtD3nH
 CxEefpYSdpSiXZk6fHcIXMAWzf61sGFLWMEP7_nHulKJPHPmn3gafVP6oUcDQWpDmnVYj.mnarQw
 1Sbd479rS9NPmEH5Hh_Q5PKahJh.0dhjAFVovGuLX54ofNl5nUayu9NKjFrgThDVInmDRRZj.0oT
 hwRTZNyQKjgXklH.efdHaHbRe6y.mXSOHrEocJVrNIoiI7yauR0o0FVc6JQIQTUPetESmhWjYHNH
 QSSMBoRKSCm2bg.94yBZ2781AFc9H1yc0YKMZaZcBEEh6agpOcQy4oOyRbqiD8LKbTpe7j5IkNrJ
 FLWy1T8vC4KPyJjwGm3xE9cyzNL2Qp_Bl3f4xOG282hbZbiYHVNeVYGvXPzPSvJXi.69L.Jw2m7U
 zJvQnm_xSun3ooBgwKrywwzXBXgkZVvYwVRok5wiC3y0Sy7x2olgby6nIw8AKeCmWzic0.HjyWH9
 RTZslNoB7d5d9wLR7xAy.pR1y_S_yM6fd7cZX6vxcczzG7MJAq7Nym1waaS9ZEkUFDr8nrcoj4fH
 HYQLcNcgEf9pBc.M7IzdfVqScK4xMzzzkFGLg8LcwVKUXgDLNNKhtmOymCIAwkhPsMvEN5AkVgBx
 KvJocRATP4N_Z_2JvfL_4fJaPeZLk4o21WBR_QC262tNvQwT0vS3YGItUpUXl8uhyZbQ_pBqeM1l
 7jpiwtb7ZoxqSADokJv8lZqXpq.SWZJLZff2E3Y3DicUQDx.iL97B92f7uUhqz9ZyO6FDKdyL3hU
 8K1Yivk71JN_apRb_LAevWthIZ9lnkMDKvT6e0YDwqBrRWquapclTxDK3Qr7ceMIjajaE9t5ZRAh
 AcEApL6lttGUAxpeVoXUPMUvJN4nK.qy3yIwAFVnll13bCkzr7THzqicFCFHdH6A6DV.hjzrQMgf
 sscLp6joHEwlkVVJ8rfB08rx4w3sG3R0cvBijD1srHLnC9GAYgA1axjjD6IJNX.fojYYA4XFCGFu
 CERGVCs8.KpM1Mz_qO5K0x4GAiC1_dbuWzmdXJZsFOFeoqgOdfhGhUasUhMN58sb3GyZpXeLXQSk
 Y94qUzhPbrSYaiFa63ApW0eJfwGFhfz6SKtUfFnV.AuaXvti3KDn7fab8TmFG.SRg1Ov2P7AO8l9
 xvXHicXOjfEO42tn16Y8dduaMXGRxycIYeJEWvuetsvPbTi0RLnKt02dk6YvSfVK2_4NxJ0OvtWv
 mtY0pAA6eKKtpEkHy4VwYcrNtt.p_JHif5XFSHmdeNO0UbU1c7ovyARJDL16QFT9Zsy5UclSpB2s
 KYNvMykmyrDyUwz_eWO9yBBTaYekLlYGxPOvsDxeFsQQPWR5FHxFUQTWFnSVeneK3zrdkzyntc2_
 f9jzdHjmqDn0FDXy0M540TlnxVBrQa0jpp51GFhqjnDC_VXXkroWXYbo8nAYUYBgBhvkKISQR.8t
 frsKZbMeAWnKXKv5ELH411RX1weUtivguS0lEqH7uHU31yH7IgQZ77YWhIcprdymf.zQEF.hbb4R
 KrCx.IlWmVCnWJ.y250ITnbibJN__pGXlu_KWDC8sRrZJYRgQmbdNd7AZ.ziNC2EBhw0za0apB51
 G8dG_sO7iYY6212zsV2Z_nUaq3h1EQruXbZ5ZtiINnIWDm7L5TYFH9GeLAqucPgORObkLz8nbB_N
 ExLw48_bcntTOsvckLsTyuyTZ4Pg-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Nov 2022 20:16:09 +0000
Received: by hermes--production-bf1-5878955b5f-686fw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1f948ceb8dae6e5827701d3d40d1a9c3;
          Wed, 23 Nov 2022 20:16:03 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v3 2/9] LSM: Identify the process attributes for each module
Date:   Wed, 23 Nov 2022 12:15:45 -0800
Message-Id: <20221123201552.7865-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123201552.7865-1-casey@schaufler-ca.com>
References: <20221123201552.7865-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an integer member "attrs_used" to the struct lsm_id which
identifies the API related data associated with each security
module. The initial set of features maps to information that
has traditionaly been available in /proc/self/attr. They are
documented in a new userspace-api file.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/userspace-api/index.rst |  1 +
 Documentation/userspace-api/lsm.rst   | 55 +++++++++++++++++++++++++++
 include/linux/lsm_hooks.h             |  2 +
 include/uapi/linux/lsm.h              | 12 ++++++
 security/apparmor/lsm.c               |  1 +
 security/selinux/hooks.c              |  2 +
 security/smack/smack_lsm.c            |  1 +
 7 files changed, 74 insertions(+)
 create mode 100644 Documentation/userspace-api/lsm.rst

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index c78da9ce0ec4..6feff0fcd88f 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -30,6 +30,7 @@ place where this information is gathered.
    sysfs-platform_profile
    vduse
    futex2
+   lsm
 
 .. only::  subproject and html
 
diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
new file mode 100644
index 000000000000..6ddf5506110b
--- /dev/null
+++ b/Documentation/userspace-api/lsm.rst
@@ -0,0 +1,55 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
+.. Copyright (C) 2022 Intel Corporation
+
+=====================================
+Linux Security Modules
+=====================================
+
+:Author: Casey Schaufler
+:Date: November 2022
+
+Linux security modules (LSM) provide a mechanism to implement
+additional access controls to the Linux security policies.
+
+The various security modules may support any of these attributes:
+
+``LSM_ATTR_CURRENT`` is the current, active security context of the
+process.
+The proc filesystem provides this value in ``/proc/self/attr/current``.
+This is supported by the SELinux, Smack and AppArmor security modules.
+Smack also provides this value in ``/proc/self/attr/smack/current``.
+AppArmor also provides this value in ``/proc/self/attr/apparmor/current``.
+
+``LSM_ATTR_EXEC`` is the security context of the process at the time the
+current image was executed.
+The proc filesystem provides this value in ``/proc/self/attr/exec``.
+This is supported by the SELinux and AppArmor security modules.
+AppArmor also provides this value in ``/proc/self/attr/apparmor/exec``.
+
+``LSM_ATTR_FSCREATE`` is the security context of the process used when
+creating file system objects.
+The proc filesystem provides this value in ``/proc/self/attr/fscreate``.
+This is supported by the SELinux security module.
+
+``LSM_ATTR_KEYCREATE`` is the security context of the process used when
+creating key objects.
+The proc filesystem provides this value in ``/proc/self/attr/keycreate``.
+This is supported by the SELinux security module.
+
+``LSM_ATTR_PREV`` is the security context of the process at the time the
+current security context was set.
+The proc filesystem provides this value in ``/proc/self/attr/prev``.
+This is supported by the SELinux and AppArmor security modules.
+AppArmor also provides this value in ``/proc/self/attr/apparmor/prev``.
+
+``LSM_ATTR_SOCKCREATE`` is the security context of the process used when
+creating socket objects.
+The proc filesystem provides this value in ``/proc/self/attr/sockcreate``.
+This is supported by the SELinux security module.
+
+Additional documentation
+========================
+
+* Documentation/security/lsm.rst
+* Documentation/security/lsm-development.rst
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index d306db1044d1..7e88acc37a29 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1606,12 +1606,14 @@ struct security_hook_heads {
  * struct lsm_id - identify a Linux Security Module.
  * @lsm: Name of the LSM. Must be approved by the LSM maintainers.
  * @id: LSM ID number from uapi/linux/lsm.h
+ * @attrs_used: Which attributes this LSM supports.
  *
  * Contains the information that identifies the LSM.
  */
 struct lsm_id {
 	const u8	*lsm;
 	u32		id;
+	u64		attrs_used;
 };
 
 /*
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index 47791c330cbf..8e9124bf622c 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -29,4 +29,16 @@
 #define LSM_ID_BPF		110
 #define LSM_ID_LANDLOCK		111
 
+/*
+ * LSM_ATTR_XXX values identify the /proc/.../attr entry that the
+ * context represents. Not all security modules provide all of these
+ * values. Some security modules provide none of them.
+ */
+#define LSM_ATTR_CURRENT	0x0001
+#define LSM_ATTR_EXEC		0x0002
+#define LSM_ATTR_FSCREATE	0x0004
+#define LSM_ATTR_KEYCREATE	0x0008
+#define LSM_ATTR_PREV		0x0010
+#define LSM_ATTR_SOCKCREATE	0x0020
+
 #endif /* _UAPI_LINUX_LSM_H */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index b859b1af6c75..3a6bf4f95d84 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1206,6 +1206,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
 static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
 	.lsm = "apparmor",
 	.id = LSM_ID_APPARMOR,
+	.attrs_used = LSM_ATTR_CURRENT | LSM_ATTR_PREV | LSM_ATTR_EXEC,
 };
 
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5fcce36267bd..e831d9c38c54 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7018,6 +7018,8 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 static struct lsm_id selinux_lsmid __lsm_ro_after_init = {
 	.lsm = "selinux",
 	.id = LSM_ID_SELINUX,
+	.attrs_used = LSM_ATTR_CURRENT | LSM_ATTR_EXEC | LSM_ATTR_FSCREATE |
+		      LSM_ATTR_KEYCREATE | LSM_ATTR_PREV | LSM_ATTR_SOCKCREATE,
 };
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index c7ba80e20b8d..c2a05217bde4 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4791,6 +4791,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 static struct lsm_id smack_lsmid __lsm_ro_after_init = {
 	.lsm = "smack",
 	.id = LSM_ID_SMACK,
+	.attrs_used = LSM_ATTR_CURRENT,
 };
 
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
-- 
2.38.1

