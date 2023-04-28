Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C4D6F1F50
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346547AbjD1U2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346125AbjD1U2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:28:40 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524D01A4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682713718; bh=3rrx2/4CPchvROU7XfPjU63ZFDXsxZuUk/9nazGCq3E=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=oiN6rQSlVNOINNLUDvFahlFzE6OaW6ivEOwn3XEmFGJ0TkzELD5dEy+mw78yb1mMdwudcFmST7KGuj5nSxPfjiXTYU+evfrM/TPKbp3BGMHR2SlSHjmdbGKSUWPdvbPY5g32ePYkpZFNAgmE9si8XHnzebMwnJTK1HHfdwG6W+q4+aopgsWEizDV9ADckQFpfCs1PjLypRPkRmTOv/v8AoCbWT8GYe/qyiepYT2QG8y7BrfRRDdvQLmaKLn0PH6VUCPBmoQnoFO8oPciRcCSh92EkTHu5hsS5oEuiThhr1Z6YbvNtLqY+XiGHSNL03zRuWBfsKQFzdio0sjK06GaYA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682713718; bh=lJ0QVD5wkDil+YgIbx19IPl2Vyf0WCSRCNhQ8pYXfiu=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=hXMQeLB4qPzS8pzTB/pzxV5ZL6RuZnOVehzz7xAJZab835qKvP8vohurf2PBG4LllbmT8N/kr6GQYf108wmDV3Pmzd5O/AA8P43LbzBGc17ioZzzv2wFP6R41kjaP4TNBi+Tw1hFbAH7tgkVoJnDDUMBx3Dtpn/tVU7X97ovBIQFlFVo9wffbzdQbtPW6yltUzYoCrWg/9VTlchWncf+t/9b2JEUUvtIjOszwiK7c77BlzrK/0KmqJD/wtIsbgsHIq20+cuPBoxytyh9wKbuaitMm3lNbB0rgE3lJgeDJYPDpNQahUXQgyV69NxUPptFrNz26yL25Sqlp0awgQzCvw==
X-YMail-OSG: _7O72f8VM1nHW5HLy7KME2Hsa67vEzsSvgGv_iVXcWQR62mqtj6jJVOCS7qjIoZ
 KYNIGi8CEv9333NWNEUeFYfyrOBILADInQgmVwOk.D77arzZak7y9YHX9rOVnQLa3qyalLFnrJWy
 8wn0vfwEJWxC71jlzCFXwD44TcVcfqJN5Ep1GlsuqjbOTpNvKDjtesuJriEGEKJG9EP6D2q5wrun
 tsaPPjV0zlmCDRQHyvCfctP6xw7w5ZEvodguVJKb.2mvbmR2uTkTGjHjCtmKwjUWxL4gkE.3XOQd
 .RDaCkE2KpTzMGyFl0ma1BkhBj_ULlC5Tnmk0_._.OpMJqCO6.HkfOPQ_XaWDIQD0A9vp.2rQVQX
 pSNODyfK0Bd6asO7_DYYifsEpgjMFtYHJSUR8TyQRSmjwkR2yrYU7eJmfKowt1Em9lHlo3dH0gx7
 SUnxyR3pnXPwQw68CW8CQwkBArGRx0zC1KlHVaTN0wfX5zKO0m2f6Li9Jg9X1le8hSouGPtwOEQZ
 b.HUJJSFOiB_0sjIiCPUKllYwHKqZMNybgCCjdoyn36TILkAVFCWjQDyzRwrVsN7I9UfSOxDisSX
 BqW11e2TiXSvrLnUeRzBBwzbMax2FzSsgqf4MpzFW.ICfEPse8UUUdlRXKbA5TpC2dZQfHGdXkZ7
 7zsL_eQgHxuZSLkfl4KY0QkAELBQcXgwngfqJX3M1YJqHjaAQKlUlD5xuhVBeOTBNQCy74TnMa1q
 16ECkn.EcYQ2Uo5I1uexzFXT6.re8TovxTTBAwFq1xBZcO0JryvFnDN8eVi8L72G0GmVOPpaY4Cc
 5mhqTnIESAbIYP1PA70xGc0qG39j__mdNhTw12eEQYqiR7rRBuQBdXaAb1ik9Ibqjpd9e2R2CtOw
 4xXdXd1jXhjPiLV534g8LrU2lgjaKff0bpckMbMj32BxYkRQc_OPCdZtqZbsKkEi7grZAyyFqpYh
 EsizJq4s5s6SvR4VC9xLgWBkvaNbFPS4LtRssCPMn6nFpBmkcNooRidIp.DjP_ygMtpvaFkBEaa2
 9sWyMM.iugnfYTPHegTTHx3ab._P5j8wIqbvxAAgMPIlQNJ6845LHJgL.o3fKlRDCRJKF_Ynpj0a
 w.146UcguHD.8F2aqMYZGuMQDFSexvqxM7IoLHX1unDxtkxCBVDuIIrtZZJTswbANQWxW1D7F7xp
 zIKofnqIe2AJmkBbQcOt5HpEJB1O4jPUxZ.9SkZ6lQ4XNnOQC_AvTbC9eybjqpkIkL_Yekx0Pf.H
 aiI9_JYLJKhTvdnl4P1l2VFaxTJVvOkgFDwSPQ2tJIoEytQez3s8t57pvBOOUu3WIH23.EgKPMK6
 bDTDvxZn9Zah4oOx6yUpo5w9aXm5ac2WPoPFjBlgM9FynLyql8Ycg8bGLGa0MpAZ5V4xeeSbuSTx
 5QPuvH8.Wc9h.fboDsIP5wRmPApK7nBwbh1tFTQSVKeooBEJMY3jjxegEbHGIk.hIvGHIg_ghOwV
 M1Zrd0Me.XiapyRMFU1zd5tXBMaOf8pZh1rkhJzqyTle3zHxcXWPyoIwgevJxAfcTopDB6Qflae9
 lw4lpczbhUmipZvkAdQIPDl_UBYUBMf.fx1fZuKSSCz6w7d5scl9JUBWPiejFb5ghdwO3gE72fMx
 FfswJv5ng4avFckOTzpzrlrUn0Y43lp6w.YxVXnQrg56Qalf39Bsnch2yex_jvPdP4LZbYyd9Xqn
 WTYEtOzO4vH6sWsW0NBoF0KlqH4YOvCJt7ROGFQoAUHgfnPrjYkwPrteKCHu4sodmUnyRx8yx9gI
 i1c1yHRp1HQyoM60G68L_AHyGWOrWY8lI0Hp6kg9TlTLhX7rHxtejEeLYiHy_P.KwnSAchMkXgno
 2KBRUUZWmvOe4Mm7tf2z4dLj4V3tgCGSn_Wtn5r4ShK9QiYrEk6KvkMSx5qwPCnuWsPz7LEyPynF
 Za5939cTj9t1VIWdBqt5IYPk1AAFGNcOP9tDdJl_dJPWBwNCTbc_Qe28DVMvAh_JZEje4Zk_7nLz
 q5D3kIHbvvbfkZB9anIP0CpR7uG6ZTZGwy0rK6kdC.8m6vd8ba5pTXw1Xp_TgCx_H760VifETvCm
 h7dUj8JK_JdyBuaqrDMnCIXdDlNKlcirtG4aB3dN72dOA5PaR_YeEJVNaGN3W4xUJjzChHIf5rK9
 .lXglJJR.n.ATJXoXLiLehQ5Hls88O.5f2RsmhQD63GXz8VMCQMZbsbqVFbBOLxJ5.SXfrBFgnSU
 .UhOYt0HzPoXR6S2OOvLFQ2SxB8Ba4BC6otYjwBJ1toDn.5hKqbbY3A4vx5LtFS4Jjbm7MdCNd1d
 eVHIal39.dg94BqwACCY-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b45a82f2-6dc2-4956-8fcd-1d405b8b8989
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Apr 2023 20:28:38 +0000
Received: by hermes--production-ne1-7dbd98dd99-tcjjg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b58a5884cc254441b7169bc1ab603d8d;
          Fri, 28 Apr 2023 20:28:35 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v10 05/11] LSM: Create lsm_list_modules system call
Date:   Fri, 28 Apr 2023 13:26:45 -0700
Message-Id: <20230428202651.159828-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428202651.159828-1-casey@schaufler-ca.com>
References: <20230428202651.159828-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a system call to report the list of Linux Security Modules
that are active on the system. The list is provided as an array
of LSM ID numbers.

The calling application can use this list determine what LSM
specific actions it might take. That might include choosing an
output format, determining required privilege or bypassing
security module specific behavior.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 Documentation/userspace-api/lsm.rst |  3 +++
 include/linux/syscalls.h            |  1 +
 kernel/sys_ni.c                     |  1 +
 security/lsm_syscalls.c             | 39 +++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+)

diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
index e6c3f262addc..9edae18a2688 100644
--- a/Documentation/userspace-api/lsm.rst
+++ b/Documentation/userspace-api/lsm.rst
@@ -63,6 +63,9 @@ Get the specified security attributes of the current process
 .. kernel-doc:: security/lsm_syscalls.c
     :identifiers: sys_lsm_get_self_attr
 
+.. kernel-doc:: security/lsm_syscalls.c
+    :identifiers: sys_lsm_list_modules
+
 Additional documentation
 ========================
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 9a94c31bf6b6..ddbcc333f3c3 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1063,6 +1063,7 @@ asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
 				      size_t *size, __u32 flags);
 asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
 				      size_t size, __u32 flags);
+asmlinkage long sys_lsm_list_modules(u64 *ids, size_t *size, u32 flags);
 
 /*
  * Architecture-specific system calls
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index d03c78ef1562..ceb3d21a62d0 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -265,6 +265,7 @@ COND_SYSCALL(mremap);
 /* security/lsm_syscalls.c */
 COND_SYSCALL(lsm_get_self_attr);
 COND_SYSCALL(lsm_set_self_attr);
+COND_SYSCALL(lsm_list_modules);
 
 /* security/keys/keyctl.c */
 COND_SYSCALL(add_key);
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index ee3881159241..b89cccb2f123 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -53,3 +53,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
 {
 	return security_getselfattr(attr, ctx, size, flags);
 }
+
+/**
+ * sys_lsm_list_modules - Return a list of the active security modules
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
+SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *, size,
+		u32, flags)
+{
+	size_t total_size = lsm_active_cnt * sizeof(*ids);
+	size_t usize;
+	int i;
+
+	if (flags)
+		return -EINVAL;
+
+	if (get_user(usize, size))
+		return -EFAULT;
+
+	if (put_user(total_size, size) != 0)
+		return -EFAULT;
+
+	if (usize < total_size)
+		return -E2BIG;
+
+	for (i = 0; i < lsm_active_cnt; i++)
+		if (put_user(lsm_idlist[i]->id, ids++))
+			return -EFAULT;
+
+	return lsm_active_cnt;
+}
-- 
2.39.2

