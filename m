Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12F96F1F46
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346500AbjD1U1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346249AbjD1U1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:27:08 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B6130D5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682713623; bh=6nAgtmk/PEjknCjYSf7RXeIOx5guKIsnj7Ok7tftIWk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=VjYvan98LitEPpsd4ba/Fyv8LHZQwN/AziNdbDikNPP24TqW49Fae9uoQLSkZvceSlslo2hN0RqgCkXcTRHFD6XhbdoHRhigmH7heXpfVMQ7/BHlNpg+1++FLWcyNcWi7AJIVvp0qtfAKE/W+6ouBDmamU8gfaCC4lXqlGTsnRdWCUEiXv6l6Hqlh6tnNf0PXUFWV043kWFB13GR9aOu7UMxsGmyfJMujhOFoJOo/Q5o2A/eWk/G4nonvlEoWnhzD81spd106U/6zfvBAmSqfRxrHLNMBNaK/xYjoBn3J+Cn48cLYDdH/ELQ0rRt3Dxom3I0aT2CuFxfsLpzJ4DFiA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682713623; bh=ldeVGpOIeGHs1tucD1MuYvl5c5x7ETJO4U3ezM1DOTx=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Otll+Zs78hJQ98ZTHxNP5Rds5QfgSxtQsuWo1S7I96JY4uoUu7lJ3IhCSq3vsqX7BC2JgMJt6UJhQbY8eRsdhgOV/36QoGX11lZaCQrjYcWFacVLgzOWaLoID+2Dd6QuoR5K9flCZModS1wTclciih5OMww6g+FrhPnbx164ff50Mqeg3EXhY/ghmf3+/3B+qLqLSJKmHzGIM5eYr2q7DW+OVf0NoDAUK6dWFFAPmbqVv+hXF8WAR7a5vKFOuiHM0lgrEGJRRnLX7bH9bvfXAAqXcElaB2RnIO+BBgl5aGWgIq0N3L9cZPUtKz7V7fhpNFLJNoWrJ6+iJOlnntw82A==
X-YMail-OSG: 0EN2ZHgVM1lFaT4ig0xpCACcQJuG5h.XE0CuET3aZNK0pMqopc8JsVC_V6UCyDG
 rI9N0JalyUKV.lsZfAOQMyA.Jti6.EdjWpl7n54qHre91MQWOPLAsgKk8wA6v8HUQ1bFFulrYfl3
 vTRxjepX7VQfQld.xxSzHGTOTKIwSBwZfXgASki.ew6NQfYjX_WCA8wsuP3eY9VV9BA7jJYYr2bf
 Q9Yz85VWAVSr15RRYLNw58oJ0ItiypcWE3vlzLwEK9I3mre3Ut3_mCb1llibXVblIMnHWvaj3le1
 G1Vwyp614A80V9opO6CY9QpesUANlEppynj.yyFfgx_8RizoUZGpWVzDCaEKzigS3bk0pKKe53yU
 KiH2oiOzIdcSMki6J8hZ3m6bj_lGee4TeUwj9QNZHizq_9sK5gKNzATmo0GEfrrjuHTExXOaNUWO
 HQKLf3IsmAbBs5712PJAalAX1fhuQPfxqpbYj5fPK9_kTuw09XRhyDwBJIxmvUVPBo_FuT_GKV95
 ci4zEsWYjX1Tre2FLkpv08U_7l6IM9EomUhBJ0WsMUVey0naqrj2beJvLT_q_DHMlovAc0i1JAmE
 _TkDc4uFXb_K.UV628lYLJ530nsHrc.3bPL6mIbuoRFVvZx49p1dy0DoHe9GCtiPytSVSNMGI98k
 fKhsCvW_0BQ9ve4uqS26js.ejqMSx87wZf85QWxEoYaMOdeLsNuD0D6zKd9RiKW3DRidmBP43_Ji
 c0Wi3STOeUNxNEDTseP2qBDpNmri99b.34DsP_xAtgp2shwaUUijTWcUyJ1t3N0fXJIYAX0o96Qe
 MV_JcHvcjjL1suAXTu9U8_v2KqxHfCKuBlIqwf6xZAAmp5M2cmxOzJs_XfxzPxQwYIsz0vIZmhxl
 PGjY8DWMIyymb1WO1VimuJq4mBVwOX4ipuF__cvofm2AvsTyNsCyJG7s3FTiIMtijeiYASu5jqTD
 LCF.6jdDvmOUGKl8Qm1ant.qdr.GYHjVb1O7eCwX83NI9l7qg6T075PBKblsnWTsJ05t8pZmKr9V
 sUKjDSVlqPiCBja7gHu3LKrQcnSAFPjoFqfAn0jgSF.PNHRAsZJRjrtBhXWrkUbWIH9Ob7f4PeT8
 IwaDiGXP3C2f_RxfMBLullijmqio1HHpEyWX5xo7WY0ubXMW4YTDiGMcPh2q1p217n0ILQyMpjrV
 KU6quyQfg.aqDrYEnaRhmCVOMbRCXxJooBf4b3IhDb_RwO6EFM20HukxQHt7oUeti1TPariKo0EJ
 .4vhyjhjOLtP2H1prsHuRQiszCXyLMziXFwHjgjTxo0g9qlHYJd1tsuQJd0OufRfyqogGTCa3F3l
 0Ak2O_sysPNSPvdUUq8MIjmTwf2saOu4.W2GCWpl9tepZ1edNcIcDsAyidenYm35OTeBdFV2iTW5
 ZkcWwMD.4qxAc12zhgHqXCUoTNXMIzJm_v9nrFY95y93Vbn34k5bBYqRWGRJk7T7vMW0X.KSMBfF
 cuErZZBmibB5RafhCYvCdhp8Nw3duDOl6_tTXkuWuR_MQkJsw1DIgaMlpx7YjNmi5wCpZ.GPNjEt
 ERZaDxkzF9GFE3z2OqD_fvTYucRPIP2O632ZL6yAM2otTacYf6gWkAA.7ScKrAOInK8QDJL1EbG2
 F9woldM06ooQzxAbyT9GWEtRYTCCrhI6bF5YvA_3GhQsqsDriQBag0.d7aOKrEA0ZTDqlmqija56
 vKFxyqGptQDZe72fqAJYCjxCwlhlYmaruuTJzdLCb44kUN3cgjRQXdWyrA.74zCZJKYfGENrZepS
 6BBSfhI89cLQGGb6htnBycZow3u2cJ5pmrTT5hW9vu9aO_MvSTkAtYVQamOAg7SGohak.nv6cVVJ
 WnN2vChpKuVskd9QecNCipFbdOPRpjRFnNsEaPmEU4k.UHATAFnfYkPJ1DWWgSKhMfZ_xpQTVZed
 _lC0TNgTQeEGf7TriDvd1Fj3jj.OT1CjlWHXoH.3tVPQ24fJY2mWllIuecUXdNaiMM4qP.LBL3pe
 wzbAUvia7ceWQlZDc8ftSZfK6dF5vZ8EItzRSR4eHL2blyjroPnOaCev9weKffdpJ9Xq48j_msff
 8pkDvNQFZeUlsaYZD_P0NZ_BzDJOjiBdjEIL1vkdXJiEaZ0inCL5SWU6OxcHzoRlNu9PIGkx6ed5
 UP8DWVFE1wE.3Wa0fYM8N_E4Q27NoBgPR3RniBJaI_fP5rHbOutq4iKqfn3rNr0hfKIsnNwBkFAA
 l4B2GeCpSxgj4qyffiMC5HjuOEbb8rrQsaTQ4PlLjMheM44_1TxRgNjL2lePyRfBCbJRiw7HifV0
 psmjwbpRr5HKrFjaD.Jg-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: dec20065-3092-42e8-a0aa-d176dcaa20d9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Apr 2023 20:27:03 +0000
Received: by hermes--production-gq1-546798879c-dcj2l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a31e9fc13eb2c1a30c94ee11b9cd508a;
          Fri, 28 Apr 2023 20:26:57 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v10 01/11] LSM: Identify modules by more than name
Date:   Fri, 28 Apr 2023 13:26:41 -0700
Message-Id: <20230428202651.159828-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428202651.159828-1-casey@schaufler-ca.com>
References: <20230428202651.159828-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a struct lsm_id to contain identifying information
about Linux Security Modules (LSMs). At inception this contains
the name of the module, an identifier associated with the security
module and an integer member "attrs" which identifies the API
related data associated with each security module. The initial set
of features maps to information that has traditionaly been available
in /proc/self/attr. They are documented in a new userspace-api file.
Change the security_add_hooks() interface to use this structure.
Change the individual modules to maintain their own struct lsm_id
and pass it to security_add_hooks().

The values are for LSM identifiers are defined in a new UAPI
header file linux/lsm.h. Each existing LSM has been updated to
include it's LSMID in the lsm_id.

The LSM ID values are sequential, with the oldest module
LSM_ID_CAPABILITY being the lowest value and the existing modules
numbered in the order they were included in the main line kernel.
This is an arbitrary convention for assigning the values, but
none better presents itself. The value 0 is defined as being invalid.
The values 1-99 are reserved for any special case uses which may
arise in the future. This may include attributes of the LSM
infrastructure itself, possibly related to namespacing or network
attribute management. A special range is identified for such attributes
to help reduce confusion for developers unfamiliar with LSMs.

LSM attribute values are defined for the attributes presented by
modules that are available today. As with the LSM IDs, The value 0
is defined as being invalid. The values 1-99 are reserved for any
special case uses which may arise in the future.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 Documentation/userspace-api/index.rst |  1 +
 Documentation/userspace-api/lsm.rst   | 55 +++++++++++++++++++++++++++
 MAINTAINERS                           |  1 +
 include/linux/lsm_hooks.h             | 16 +++++++-
 include/uapi/linux/lsm.h              | 54 ++++++++++++++++++++++++++
 security/apparmor/lsm.c               |  8 +++-
 security/bpf/hooks.c                  |  9 ++++-
 security/commoncap.c                  |  8 +++-
 security/landlock/cred.c              |  2 +-
 security/landlock/fs.c                |  2 +-
 security/landlock/ptrace.c            |  2 +-
 security/landlock/setup.c             |  6 +++
 security/landlock/setup.h             |  1 +
 security/loadpin/loadpin.c            |  9 ++++-
 security/lockdown/lockdown.c          |  8 +++-
 security/safesetid/lsm.c              |  9 ++++-
 security/security.c                   | 12 +++---
 security/selinux/hooks.c              |  9 ++++-
 security/smack/smack_lsm.c            |  8 +++-
 security/tomoyo/tomoyo.c              |  9 ++++-
 security/yama/yama_lsm.c              |  8 +++-
 21 files changed, 216 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/userspace-api/lsm.rst
 create mode 100644 include/uapi/linux/lsm.h

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index f16337bdb852..54c0f54cde89 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -31,6 +31,7 @@ place where this information is gathered.
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 0e64787aace8..25d09f6eb3ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18810,6 +18810,7 @@ S:	Supported
 W:	http://kernsec.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
 F:	security/
+F:	include/uapi/linux/lsm.h
 X:	security/selinux/
 
 SELINUX SECURITY MODULE
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 6e156d2acffc..c1f00d09033e 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1665,6 +1665,18 @@ struct security_hook_heads {
 	#undef LSM_HOOK
 } __randomize_layout;
 
+/**
+ * struct lsm_id - Identify a Linux Security Module.
+ * @lsm: name of the LSM, must be approved by the LSM maintainers
+ * @id: LSM ID number from uapi/linux/lsm.h
+ *
+ * Contains the information that identifies the LSM.
+ */
+struct lsm_id {
+	const char	*name;
+	u64		id;
+};
+
 /*
  * Security module hook list structure.
  * For use with generic list macros for common operations.
@@ -1673,7 +1685,7 @@ struct security_hook_list {
 	struct hlist_node		list;
 	struct hlist_head		*head;
 	union security_list_options	hook;
-	const char			*lsm;
+	struct lsm_id			*lsmid;
 } __randomize_layout;
 
 /*
@@ -1708,7 +1720,7 @@ extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
-				const char *lsm);
+			       struct lsm_id *lsmid);
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
 #define LSM_FLAG_EXCLUSIVE	BIT(1)
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
new file mode 100644
index 000000000000..f27c9a9cc376
--- /dev/null
+++ b/include/uapi/linux/lsm.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Linux Security Modules (LSM) - User space API
+ *
+ * Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
+ * Copyright (C) 2022 Intel Corporation
+ */
+
+#ifndef _UAPI_LINUX_LSM_H
+#define _UAPI_LINUX_LSM_H
+
+/*
+ * ID tokens to identify Linux Security Modules (LSMs)
+ *
+ * These token values are used to uniquely identify specific LSMs
+ * in the kernel as well as in the kernel's LSM userspace API.
+ *
+ * A value of zero/0 is considered undefined and should not be used
+ * outside the kernel. Values 1-99 are reserved for potential
+ * future use.
+ */
+#define LSM_ID_UNDEF		0
+#define LSM_ID_CAPABILITY	100
+#define LSM_ID_SELINUX		101
+#define LSM_ID_SMACK		102
+#define LSM_ID_TOMOYO		103
+#define LSM_ID_IMA		104
+#define LSM_ID_APPARMOR		105
+#define LSM_ID_YAMA		106
+#define LSM_ID_LOADPIN		107
+#define LSM_ID_SAFESETID	108
+#define LSM_ID_LOCKDOWN		109
+#define LSM_ID_BPF		110
+#define LSM_ID_LANDLOCK		111
+
+/*
+ * LSM_ATTR_XXX definitions identify different LSM attributes
+ * which are used in the kernel's LSM userspace API. Support
+ * for these attributes vary across the different LSMs. None
+ * are required.
+ *
+ * A value of zero/0 is considered undefined and should not be used
+ * outside the kernel. Values 1-99 are reserved for potential
+ * future use.
+ */
+#define LSM_ATTR_UNDEF		0
+#define LSM_ATTR_CURRENT	100
+#define LSM_ATTR_EXEC		101
+#define LSM_ATTR_FSCREATE	102
+#define LSM_ATTR_KEYCREATE	103
+#define LSM_ATTR_PREV		104
+#define LSM_ATTR_SOCKCREATE	105
+
+#endif /* _UAPI_LINUX_LSM_H */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index d6cc4812ca53..d7f22b0cf03f 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -24,6 +24,7 @@
 #include <linux/zstd.h>
 #include <net/sock.h>
 #include <uapi/linux/mount.h>
+#include <uapi/linux/lsm.h>
 
 #include "include/apparmor.h"
 #include "include/apparmorfs.h"
@@ -1215,6 +1216,11 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
 	.lbs_task = sizeof(struct aa_task_ctx),
 };
 
+static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
+	.name = "apparmor",
+	.id = LSM_ID_APPARMOR,
+};
+
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
@@ -1910,7 +1916,7 @@ static int __init apparmor_init(void)
 		goto buffers_out;
 	}
 	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
-				"apparmor");
+				&apparmor_lsmid);
 
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index e5971fa74fd7..b6e71c5a401d 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -5,6 +5,7 @@
  */
 #include <linux/lsm_hooks.h>
 #include <linux/bpf_lsm.h>
+#include <uapi/linux/lsm.h>
 
 static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
@@ -15,9 +16,15 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(task_free, bpf_task_storage_free),
 };
 
+static struct lsm_id bpf_lsmid __lsm_ro_after_init = {
+	.name = "bpf",
+	.id = LSM_ID_BPF,
+};
+
 static int __init bpf_lsm_init(void)
 {
-	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
+	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks),
+			   &bpf_lsmid);
 	pr_info("LSM support for eBPF active\n");
 	return 0;
 }
diff --git a/security/commoncap.c b/security/commoncap.c
index 5bb7d1e96277..69958af95163 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -25,6 +25,7 @@
 #include <linux/binfmts.h>
 #include <linux/personality.h>
 #include <linux/mnt_idmapping.h>
+#include <uapi/linux/lsm.h>
 
 /*
  * If a non-root user executes a setuid-root binary in
@@ -1440,6 +1441,11 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 
 #ifdef CONFIG_SECURITY
 
+static struct lsm_id capability_lsmid __lsm_ro_after_init = {
+	.name = "capability",
+	.id = LSM_ID_CAPABILITY,
+};
+
 static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(capable, cap_capable),
 	LSM_HOOK_INIT(settime, cap_settime),
@@ -1464,7 +1470,7 @@ static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 static int __init capability_init(void)
 {
 	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
-				"capability");
+			   &capability_lsmid);
 	return 0;
 }
 
diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index ec6c37f04a19..2eb1d65f10d6 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -42,5 +42,5 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 __init void landlock_add_cred_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			   LANDLOCK_NAME);
+			   &landlock_lsmid);
 }
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index adcea0fe7e68..fa0e6e76991c 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1307,5 +1307,5 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 __init void landlock_add_fs_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			   LANDLOCK_NAME);
+			   &landlock_lsmid);
 }
diff --git a/security/landlock/ptrace.c b/security/landlock/ptrace.c
index 4c5b9cd71286..eab35808f395 100644
--- a/security/landlock/ptrace.c
+++ b/security/landlock/ptrace.c
@@ -116,5 +116,5 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 __init void landlock_add_ptrace_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			   LANDLOCK_NAME);
+			   &landlock_lsmid);
 }
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index 3f196d2ce4f9..17116c87f268 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -8,6 +8,7 @@
 
 #include <linux/init.h>
 #include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
 
 #include "common.h"
 #include "cred.h"
@@ -24,6 +25,11 @@ struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
 	.lbs_superblock = sizeof(struct landlock_superblock_security),
 };
 
+struct lsm_id landlock_lsmid __lsm_ro_after_init = {
+	.name = LANDLOCK_NAME,
+	.id = LSM_ID_LANDLOCK,
+};
+
 static int __init landlock_init(void)
 {
 	landlock_add_cred_hooks();
diff --git a/security/landlock/setup.h b/security/landlock/setup.h
index 1daffab1ab4b..38bce5b172dc 100644
--- a/security/landlock/setup.h
+++ b/security/landlock/setup.h
@@ -14,5 +14,6 @@
 extern bool landlock_initialized;
 
 extern struct lsm_blob_sizes landlock_blob_sizes;
+extern struct lsm_id landlock_lsmid;
 
 #endif /* _SECURITY_LANDLOCK_SETUP_H */
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index d73a281adf86..d359f2ea1a0a 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -20,6 +20,7 @@
 #include <linux/string_helpers.h>
 #include <linux/dm-verity-loadpin.h>
 #include <uapi/linux/loadpin.h>
+#include <uapi/linux/lsm.h>
 
 #define VERITY_DIGEST_FILE_HEADER "# LOADPIN_TRUSTED_VERITY_ROOT_DIGESTS"
 
@@ -214,6 +215,11 @@ static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
 	return loadpin_check(NULL, (enum kernel_read_file_id) id);
 }
 
+static struct lsm_id loadpin_lsmid __lsm_ro_after_init = {
+	.name = "loadpin",
+	.id = LSM_ID_LOADPIN,
+};
+
 static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
 	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
@@ -265,7 +271,8 @@ static int __init loadpin_init(void)
 	if (!register_sysctl_paths(loadpin_sysctl_path, loadpin_sysctl_table))
 		pr_notice("sysctl registration failed!\n");
 #endif
-	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks),
+			   &loadpin_lsmid);
 
 	return 0;
 }
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index a79b985e917e..141a0b94098e 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -13,6 +13,7 @@
 #include <linux/security.h>
 #include <linux/export.h>
 #include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
 
 static enum lockdown_reason kernel_locked_down;
 
@@ -75,6 +76,11 @@ static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
 };
 
+static struct lsm_id lockdown_lsmid __lsm_ro_after_init = {
+	.name = "lockdown",
+	.id = LSM_ID_LOCKDOWN,
+};
+
 static int __init lockdown_lsm_init(void)
 {
 #if defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY)
@@ -83,7 +89,7 @@ static int __init lockdown_lsm_init(void)
 	lock_kernel_down("Kernel configuration", LOCKDOWN_CONFIDENTIALITY_MAX);
 #endif
 	security_add_hooks(lockdown_hooks, ARRAY_SIZE(lockdown_hooks),
-			   "lockdown");
+			   &lockdown_lsmid);
 	return 0;
 }
 
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index e806739f7868..86b57785f86e 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -19,6 +19,7 @@
 #include <linux/ptrace.h>
 #include <linux/sched/task_stack.h>
 #include <linux/security.h>
+#include <uapi/linux/lsm.h>
 #include "lsm.h"
 
 /* Flag indicating whether initialization completed */
@@ -261,6 +262,11 @@ static int safesetid_task_fix_setgroups(struct cred *new, const struct cred *old
 	return 0;
 }
 
+static struct lsm_id safesetid_lsmid __lsm_ro_after_init = {
+	.name = "safesetid",
+	.id = LSM_ID_SAFESETID,
+};
+
 static struct security_hook_list safesetid_security_hooks[] = {
 	LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
 	LSM_HOOK_INIT(task_fix_setgid, safesetid_task_fix_setgid),
@@ -271,7 +277,8 @@ static struct security_hook_list safesetid_security_hooks[] = {
 static int __init safesetid_security_init(void)
 {
 	security_add_hooks(safesetid_security_hooks,
-			   ARRAY_SIZE(safesetid_security_hooks), "safesetid");
+			   ARRAY_SIZE(safesetid_security_hooks),
+			   &safesetid_lsmid);
 
 	/* Report that SafeSetID successfully initialized */
 	safesetid_initialized = 1;
diff --git a/security/security.c b/security/security.c
index cf6cc576736f..a482c6048df9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -504,17 +504,17 @@ static int lsm_append(const char *new, char **result)
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @hooks: the hooks to add
  * @count: the number of hooks to add
- * @lsm: the name of the security module
+ * @lsmid: the identification information for the security module
  *
  * Each LSM has to register its hooks with the infrastructure.
  */
 void __init security_add_hooks(struct security_hook_list *hooks, int count,
-				const char *lsm)
+			       struct lsm_id *lsmid)
 {
 	int i;
 
 	for (i = 0; i < count; i++) {
-		hooks[i].lsm = lsm;
+		hooks[i].lsmid = lsmid;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
 	}
 
@@ -523,7 +523,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	 * and fix this up afterwards.
 	 */
 	if (slab_is_available()) {
-		if (lsm_append(lsm, &lsm_names) < 0)
+		if (lsm_append(lsmid->name, &lsm_names) < 0)
 			panic("%s - Cannot get early memory.\n", __func__);
 	}
 }
@@ -2146,7 +2146,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->name))
 			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
@@ -2159,7 +2159,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->name))
 			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9a5bdfc21314..2ee92d3fb79d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -92,6 +92,7 @@
 #include <linux/fsnotify.h>
 #include <linux/fanotify.h>
 #include <linux/io_uring.h>
+#include <uapi/linux/lsm.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -7032,6 +7033,11 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 }
 #endif /* CONFIG_IO_URING */
 
+static struct lsm_id selinux_lsmid __lsm_ro_after_init = {
+	.name = "selinux",
+	.id = LSM_ID_SELINUX,
+};
+
 /*
  * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
  * 1. any hooks that don't belong to (2.) or (3.) below,
@@ -7355,7 +7361,8 @@ static __init int selinux_init(void)
 
 	hashtab_cache_init();
 
-	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
+	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
+			   &selinux_lsmid);
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index cfcbb748da25..0b466d3b31b7 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -43,6 +43,7 @@
 #include <linux/fs_parser.h>
 #include <linux/watch_queue.h>
 #include <linux/io_uring.h>
+#include <uapi/linux/lsm.h>
 #include "smack.h"
 
 #define TRANS_TRUE	"TRUE"
@@ -4856,6 +4857,11 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 	.lbs_superblock = sizeof(struct superblock_smack),
 };
 
+static struct lsm_id smack_lsmid __lsm_ro_after_init = {
+	.name = "smack",
+	.id = LSM_ID_SMACK,
+};
+
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
@@ -5062,7 +5068,7 @@ static __init int smack_init(void)
 	/*
 	 * Register with LSM
 	 */
-	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
+	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), &smack_lsmid);
 	smack_enabled = 1;
 
 	pr_info("Smack:  Initializing.\n");
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index af04a7b7eb28..7de4fcdcbf90 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
 #include "common.h"
 
 /**
@@ -542,6 +543,11 @@ static void tomoyo_task_free(struct task_struct *task)
 	}
 }
 
+static struct lsm_id tomoyo_lsmid __lsm_ro_after_init = {
+	.name = "tomoyo",
+	.id = LSM_ID_TOMOYO,
+};
+
 /*
  * tomoyo_security_ops is a "struct security_operations" which is used for
  * registering TOMOYO.
@@ -595,7 +601,8 @@ static int __init tomoyo_init(void)
 	struct tomoyo_task *s = tomoyo_task(current);
 
 	/* register ourselves with the security framework */
-	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
+	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks),
+			   &tomoyo_lsmid);
 	pr_info("TOMOYO Linux initialized\n");
 	s->domain_info = &tomoyo_kernel_domain;
 	atomic_inc(&tomoyo_kernel_domain.users);
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 06e226166aab..c56572ec9d50 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -18,6 +18,7 @@
 #include <linux/task_work.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <uapi/linux/lsm.h>
 
 #define YAMA_SCOPE_DISABLED	0
 #define YAMA_SCOPE_RELATIONAL	1
@@ -421,6 +422,11 @@ static int yama_ptrace_traceme(struct task_struct *parent)
 	return rc;
 }
 
+static struct lsm_id yama_lsmid __lsm_ro_after_init = {
+	.name = "yama",
+	.id = LSM_ID_YAMA,
+};
+
 static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
@@ -477,7 +483,7 @@ static inline void yama_init_sysctl(void) { }
 static int __init yama_init(void)
 {
 	pr_info("Yama: becoming mindful.\n");
-	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
+	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), &yama_lsmid);
 	yama_init_sysctl();
 	return 0;
 }
-- 
2.39.2

