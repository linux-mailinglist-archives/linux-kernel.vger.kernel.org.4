Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8F45ECE94
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiI0UcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbiI0UcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:32:11 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907145EDF2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664310729; bh=eEdhd7ixy7ZZ+fuEjNn1TqBCKeGy52lT7FyaDnEW6c0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=bNvn+wiTZj3Z1cZgFtGhoQepCMZSszdDw7q3rgsCIJzAJ1IFkcDQS14TY5NYMXFHBWytBdV02z6V7mzZVER2/SB+SYH0He/oZDkeoRUkvhQim6P4JsFnQXoFpIfY3JCbJ0u2eEJ95cT+xm3GtaGSGTH1mwOF0oKoHKTND04RF7L11nnLCnZgte2005FMwGcOzhOpXyiwopuuzug8v6r3cNBIEbFQ8oAfkRyRqZb0ClkllQt0rqpqqH3F+my55vcaMqvKq2gAZEMvrTPT+x/s6tXa3biu9B0ic2VzZ7QERK0WhSPE3qLIbEVhm5VuBdoflp5KtZFFXl1yj9Vt6qcHUw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664310729; bh=wYIrusa36pRhmX8sInAgD2MXoN3vKfNp/D4nv5WUCcL=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=MqNU5UeVtySitQ7+csIka6lxuPL7i4WDBL9IF7bxAc5j4r2BxrVZQNHX/0Px4VnDevNUn2h5P1wzE7Bl9+ZbfBAKDBIJHfuTrccQ55swJcBPRM+KUyq31sj/BUBJuRxL2QeAAV4Ro5coOeair937W03JCKhaQ2eZzpGLxCxvcwAI4xp1oMFAggZy3SiWViD4iQhD90hX1Wa82wDVGRCPxEYC6Zg8L7Jrd0DwREfLyTg+G9gv+9Er1SClP5PT5WHfpdqyVoQAIpprEROabm2Ktdwd/59IiywRn7icmLW8xN0wHPMatkFSbCtBFChWGnUTxfdv8Jx6JPGksR7Wn4pqwA==
X-YMail-OSG: L6W9rKAVM1krJpUoOxJS5J6jN23gmZ7rwjqwdg7puGS8AFSBWMxucfkX56mU4ZT
 WKE2mdhowbxk00Uhy28dK0urLsvDT3QTxGIjveOzDXTbzOdegKbJWZWMhvpqSUc56NiEoTdsU2wG
 uvsHnB0BnIvtRFFuJSGezWrYiJ_lT1N.e1EtnOhghfK8LtHcQA2Ov6qOH2Cg8kibPaOMC5Lca9oL
 L2q87RYoF0X0chl.dZnaAxbO4rk9rG.f2lb4ub1CWMgp0CHzx8wZTpzdSunhYQ4io6YH6E1KFlNe
 deL5b.z4XYaNyMNQ_iXfLI0kJMLXSs6xRiqA.g_DfcNLJTZqFSd.7Hha7o6o7w78ZRXo6kl7kQKy
 kp8Yc.uAPB6zXnHi5vJCDu1ANiwcuHNNPvx5XxMQuLenaIZK3dSCQRLyx8yJ1iouk77xa_NyC7CD
 40YShaPQQqxx85nAcX9grmDONcVr10dVDMERg1wRKRS.KSHlRpH_D7sFtPnmcz6inNS8v.NjxHWN
 vLvZjlNxxes3Z33UHfvbqB92p.W6rGsdO6wLfzi9Otns_a2jIbjLQujvlDX5YK4BFk8Jgk6qKCWR
 7r37x.bYVPXMZTtA8d37H8etZKxz_rfSpcPh_wnu3hdtWyM7UldhzffGQmL7TmthtP03hWEUNROf
 YdXAWc3Tws1EAEuzvU4F5c1o_Jk2r9dk1DEyad_X_ruRlAgtGzROC6f_3YIru9DLTY5hWfcPAY6p
 W6qo9C3jO7UM8h7.1gUEYzCv2DCxYROk7zn1QsF2yWVe4CnuZiNXKWFX3XbxgJsBMTTuXgxjoZ13
 61vjrKrV8vQ0TRXI8qiXMvF_EGVPEWXbLrHXtxpHgDZbww4Es6hbq_H7oP2aGiaY6qlU_Amthhnc
 3Zaoqy2Ld_Djasf99erQJLwFHey2muVJYSBW1pHk0XY3P5hwFZBR53mi8WacZ0uddGYBMU1CzsJb
 e22eIQ1Ry3sKiwBzKvOJnVX4d07MP2D9dGRAg5kfSP6WOVrJ7xtoOHsorDQTXlSrni1rUN6KwkXE
 kPlngbhJ27w8n29OBipodX5s8Xdg0OcgRtALZvMENT7nibxmDN0HsRy6sVgzKmAxDXyrY0VBhjnS
 tdU3LwoJfR_4_fxjZKjuqLcU53lx9EqYfAjEeyiN44y8PpUv7DwnOFC7Ld2FIyUcFDmMl85ZNgiT
 kwrtaamviyuFmqfcH1TgmVQlkxDDnL8pK7WF9y6HNsTsQvI5xH47Pp_UsIDR1ZaFkIOAe064JYz7
 o2luYmHjJcarrngk6dRSD8UQxKghGQSLN9mh62xj7Ki0za5uwispquxB6dwkvSiz36RjFIn70ohR
 59uU1NvdYAtNghktaa364HryFX_ZZZ8ttNVXz4PAHkLkQNW78T.y2fqy8glYqtI3gu.Bvwvtpp8i
 CvMMNg7vgxoE8XlyE6OTMt8VHeH89QcIO.yvStU.HyzieG3xQJchTjJoqiKCFZV.GtL9Z_8pFzVY
 vi0btRPEw4R6Clrd4AMKsUiDAqQLwwXjRhX5AegyLzaW4cMfESJfEZN5x5tv4se._78qVEj9L7Q_
 DVUAHHrbWK5AXcLWl89hoyu4r0UWRTz9WgUNn7T4C6cvotf12SgmTdXV9VYj3c9G6u_64.DhUcbn
 5PUIjP5P.EK4vlGsz2g2V9mgW5RZi_RDMyGC5uv7lgtUc04jeIkSBlSG7ssqN568iT2nfF692b4I
 gi.VJqkpVPe27pQm2qFYeHqSoOnY4eO5vnNQYi28ocJhzFp7ndln6LzpES.eFxmZxlb.eg35ehkf
 0cBXEh9Up92sdI9PQUMOO8fJA7UHSoBU_zmtVsrIveHHnhQ4OiOSNMym1fpRGFaK4MoyLewIyGwQ
 FJ1Iup3aU6uLTQDsGg.JWBN3E0va0JRvxvxvaFdCDekGX6P_xWK2G_oL7q_PfoV5MaiVrxiBB13A
 5r0hZQ3ujkEZfX2QV.mE38XMCOC8q60DPykpkoSkjmLnR7UX.gjrVdHLtvWaGOi7z03tneG_pVMY
 cE_9e5agDLDrt8R._JM1YAKtAXCiG_mareErC03dZgGXkUoLmhyGbcbTlIbtGmufOS7su5_vJRIO
 igTiUoInL04P0ArQgO5g6zbHJtwJW75BElaSe8mMOhqX9LO18Qdicl47l1NT8_RbthTz.Dp3.nys
 UxGIICV2EEUS5ixS24T97i2Cm262wWuZ2eHxXnBZfXVc0mGhLlTGmCktSTth3UN.spj6TT0mGX1H
 i_mOMXR3npUR8BEvqpkpz2nRBeEJl5kkFBN1t2FV0gCZNlYAZW0DV.xbcotY-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 20:32:09 +0000
Received: by hermes--production-bf1-759bcdd488-hrxt2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8ccea4647f87bd204746bbf9e900b582;
          Tue, 27 Sep 2022 20:32:05 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 39/39] LSM: Create lsm_module_list system call
Date:   Tue, 27 Sep 2022 13:31:55 -0700
Message-Id: <20220927203155.15060-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927195421.14713-1-casey@schaufler-ca.com>
References: <20220927195421.14713-1-casey@schaufler-ca.com>
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

Create a system call to report the list of Linux Security Modules
that are active on the system. The list is provided as an array
of LSM ID numbers.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 include/linux/syscalls.h               |  1 +
 include/uapi/asm-generic/unistd.h      |  5 ++-
 kernel/sys_ni.c                        |  1 +
 security/lsm_syscalls.c                | 50 ++++++++++++++++++++++++++
 5 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 56d5c5202fd0..40b35e7069a7 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -373,6 +373,7 @@
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
 451	common	lsm_self_attr		sys_lsm_self_attr
+452	common	lsm_module_list		sys_lsm_module_list
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 7f87ef8be546..e2e2a9e93e8c 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1057,6 +1057,7 @@ asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long l
 					    unsigned long home_node,
 					    unsigned long flags);
 asmlinkage long sys_lsm_self_attr(struct lsm_ctx *ctx, size_t *size, int flags);
+asmlinkage long sys_lsm_module_list(unsigned int *ids, size_t *size, int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index aa66718e1b48..090617a9a53a 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -889,8 +889,11 @@ __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 #define __NR_lsm_self_attr 451
 __SYSCALL(__NR_lsm_self_attr, sys_lsm_self_attr)
 
+#define __NR_lsm_module_list 452
+__SYSCALL(__NR_lsm_module_list, sys_lsm_module_list)
+
 #undef __NR_syscalls
-#define __NR_syscalls 452
+#define __NR_syscalls 453
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 0fdb0341251d..bde9e74a3473 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -264,6 +264,7 @@ COND_SYSCALL(mremap);
 
 /* security/lsm_syscalls.c */
 COND_SYSCALL(lsm_self_attr);
+COND_SYSCALL(lsm_module_list);
 
 /* security/keys/keyctl.c */
 COND_SYSCALL(add_key);
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index da0fab7065e2..41d9ef945ede 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -154,3 +154,53 @@ SYSCALL_DEFINE3(lsm_self_attr,
 	kfree(final);
 	return rc;
 }
+
+/**
+ * lsm_module_list - Return a list of the active security modules
+ * @ids: the LSM module ids
+ * @size: size of @ids, updated on return
+ * @flags: reserved for future use, must be zero
+ *
+ * Returns a list of the active LSM ids. On success this function
+ * returns the number of @ids array elements. This value may be zero
+ * if there are no LSMs active. If @size is insufficient to contain
+ * the return data -E2BIG is returned and @size is set to the minimum
+ * required size. In all other cases a negative value indicating the
+ * error is returned.
+ */
+SYSCALL_DEFINE3(lsm_module_list,
+	       unsigned int __user *, ids,
+	       size_t __user *, size,
+	       int, flags)
+{
+	unsigned int *interum;
+	size_t total_size = lsm_id * sizeof(*interum);
+	size_t usize;
+	int rc;
+	int i;
+
+	if (get_user(usize, size))
+		return -EFAULT;
+
+	if (usize < total_size) {
+		if (put_user(total_size, size) != 0)
+			return -EFAULT;
+		return -E2BIG;
+	}
+
+	interum = kzalloc(total_size, GFP_KERNEL);
+	if (interum == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < lsm_id; i++)
+		interum[i] = lsm_idlist[i]->id;
+
+	if (copy_to_user(ids, interum, total_size) != 0 ||
+	    put_user(total_size, size) != 0)
+		rc = -EFAULT;
+	else
+		rc = lsm_id;
+
+	kfree(interum);
+	return rc;
+}
-- 
2.37.3

