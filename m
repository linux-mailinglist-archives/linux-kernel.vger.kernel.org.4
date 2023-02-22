Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0792769FCCC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjBVUKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjBVUKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:10:33 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D48842BDF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677096630; bh=cLBTpt6/NHbOeQZSABD5CvjjuowdS3zG8TJWG0C3m/w=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ACNMP4j1CRZGACEYyfZWEUUBOXIHo5NhvYaCKiyIIrS6noFY3LpolRrHyScxs2oUuS4tKktoJbdQ4ROYIaYMv78ZCG8ppnD/2l7iZTBuvah9GRRZRSJU0gI6GgGJXRJkMHnD/DOie8eC0ZS953NEegJFhPlAXVcwGIlmUwrIHvP7BvJ1Wh5niqyJA+OtPXB1IBXtCwKunelN7vS4iEWzYVgS5KJYjt2/57dXZUgvs0oi7RMQ0fBeD891uebCad5KIFIx9gjZe+l1E7/g/23HdWetdCBRgShqz9PEIPZ2JDGAQG/zB5qGwN7IQJJ75D6WrfB/TT9mkcoh3M6lICVB8g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677096630; bh=3Lc2OpvLEgFV8OSzHa1MI5RAVClTBAiLNlHjmaXlnpF=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=CsFLXX5+Az7MWhZw8AUThwQHBi6pMjK5FhSxe2VoH21ePXhQCns5JHnuQ1NArrdoq+wsc3O9f4vsnjWH0En0tiOIb8QbCv3yIExrMiPrNgvU0iFyoFszsdCsn6C9m1x5Ikdewrsntv4yjWAS5TIX5gdWiWkMB1pFk0WGhdoxk7pa4DpkTWO+yvOcuVyDNywULjXgKPXpoMrrkN8ei5vB2tuYhvn/4bb/pqvLzea7Bzn71M5lb7vHADQzNDuDRwMZkcJB5ZC9J+p4XXt5d1M57b3N841KhitcamOYC781OMGl9i3HfCFfxpytemxUfdp8kDIcsOZWpv3naBMlypNc+w==
X-YMail-OSG: HPxt4BMVM1n1c3DfMCYkM_8T9PyRMm8SM65fb5e38_CMAhhdlWZaNNjcWox3Y9h
 LN7Sed8F_GEdKDVJcPbg7H6DAV9OqHmkty16iFa5nBr2ZujlNPr9dxNi4aEaUGua8h1fMFFPgz4f
 hcyuz_iFQAI_XDWSWOAQiQzxG2gDwoZFdFAjKzyOjLvT26sZjdX46DIaOS0c_phyYma0P_iChLYD
 XUhl1weFhn4qJHDENef8FjdTC5ISXX0UL.foaWVEH7rJ6T4M91MHuArGPB_eKZZO8j0L15UuUDnx
 KakZUbJ6PMTgX7sxnsHxzdcPCHlFdnAPVhXSCVrlfkk.fmNZGjLEwrbKHeSmHevo5eVHttSiJTes
 0Z6LgGblj10vaB7r6BCbbN8DfueuNuafDCmnOvpDyr1POLrKdODsfMn1OQxA571mYEfFUeff4CYE
 9cx7WIEcFQF22gaAXNI_IZBhxBK95zg43Z9RYOkA.m_9DtjN8q.RAX9nlQPYnC5VZtM9QvL_y25J
 cToNhcpuHMT1QoNjFvvYBGfWCPLOlIKZI7d6YnH_n7fVmfnbH5.bHPZIWusLnJF5fd6eyBLOywbS
 rwfehiImuk4lf2Nqb6fOqFR2Abpe5pWSMV0pipGovJA2bd7uliZ2M_umdj1wo4ft54E2brk8PMjB
 NsKvB5QF.8Hw06F_yNwc9mSdUovJtRtuN59Y9bUMf6PyxSpt60qwq8A1JvxgUmv64okaB6yRxyOG
 4aCaUGG69KuBOE7CsTX1j4x8sBLUjejpx91qHL75jBARJ75Q5cmtgrT7Ly1JtN21CE3KNo_5N7xa
 .wcK0FtPfvwosSw8wP_5l0BPJfEz97Q0TWP0UeCLu0_8JvKHGLZIt8w7dvnZFQge3_DvRQhBXQY3
 ZsUObdRUOd8WMCl2dqbrXCpfTr78RFMzKNZGlP9rrO.l12VeMCx0cS9vm53a7Q7179sy6tAtiSku
 HAIqhWeanXtvZylscFlScdnY20tTjMCezA0XsWiwunBNLqN3_O8ksYIEPtgHowN0PU0eq2nCqhV7
 Pz6_lOUjuAiYEAJbYMSlx4qZJzJlYCM8K90pY6gKzCGN1NWOWWMq0fk79l4TOCzQmKUB0.A_4GN_
 pQvb5WO3LY7Z3UOWDOYMpWekY.5RYp7uvkv5YD3x.8.2zpjg_CKFjy5h8fF0FfwHVIxDK6KzcUdY
 tjOB0qJHsmbvDGk_tQKqRScDSdvCLF.YWZ0.I7mj0pP6tBbhTTmw64QkpV4hzsQbVTs7wy1K8i3d
 TQzr66tnLr8qCtj8q23nMgrWeldPBKJw4pvPx1y9WroKRu4cS5N6_XPaHWNVOn_riFRboQQRqm4t
 B6M0B6i9wIvxxlnshX2ciy_uyvkmEzSrCXNvPxVjuD_bn77rYrh8r3EcBSzuDdG4iV6y72D3.veu
 pakEvY9Lx0WHF2mRD0bi5_ZKEfbB6AxPo.4HJueEe73wVFvAC17sZTo_J6futkbaOE6ZuCMG3Nze
 LxuJyX6XrYUGDU9r4M75LIpCSFkvXYF74GPw841Dv0YOztnQuF8.Y_FGne0fUQ6sfWnX5JzRGEVZ
 dA273byesLRJmCaSkL_RywN823eojIYRCnk6VptBpcOVh5rE30NUI9JMD4ItjNqPu_NkZXIuDwJ4
 vkCTGxp00gQrBDRpOwvtNMUD_ov79IdnwXLXHY8v.9TxDyFTlHlzz33h8YE_Mu31DKj..pgzdh.6
 Nazb4OaoJn1nO01LZlmud3gBSL78kvZKrI2M3v.H0JAJYyzuwUQiA0YFPnJAEmg0JZGUBKIGHSsG
 uXHhgoaJMUZ80IiOmScpiYCVz9jQiHqUyqoMPfJkAy9CNMZ25016tN3bH7wlSzo97_imm.u2BIDd
 vnKzkXmckBrsEQFgEt3mzWfNDztIkinrOf5JLkUDEpUJYdELesgHw4hWlhd1XAQdWcK1Xe.Y3.eb
 rKed7aBmL2QQMcp3IN7YeIi_xcmskTMIUSKF66rx5AqrWrGtZMsM8yJgncAp.q2Xbu2MgXne.0_g
 XDrt54zhW0PPfno_YxgYKiABfwfqLNIcQc_DNwF1hEBM1QGJE9HFzsORA13a3a10bUBMTDv_l45T
 mSZa6crfyHINKmjvWbfWaLr04LvTCJ5bTEiOwUe2B4APfQ0_na1jPkYOYRFZxVggPu8bMAzSartV
 tHxr6pL5aDoEhtaQZgpewoNAaPOmnRQxr4_5.QotMlkBlB7FFd8Ca.VbBt1k6HKFOCQygrppbp.f
 Wxf5TGHTNe5BTpF8nMRvozTD7Z6BQoc_0X8Tkk4gj515gMgnzKLCQiT4TEWzf3wvK_YKOAN_3kyT
 yl.mNm2Xu66ZdAKVta14-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 22 Feb 2023 20:10:30 +0000
Received: by hermes--production-ne1-746bc6c6c4-sslbc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 54abe124e3c28d3626a364ed2359f9f6;
          Wed, 22 Feb 2023 20:10:27 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v6 05/11] LSM: Create lsm_module_list system call
Date:   Wed, 22 Feb 2023 12:08:32 -0800
Message-Id: <20230222200838.8149-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230222200838.8149-1-casey@schaufler-ca.com>
References: <20230222200838.8149-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a system call to report the list of Linux Security Modules
that are active on the system. The list is provided as an array
of LSM ID numbers.

The calling application can use this list determine what LSM
specific actions it might take. That might include chosing an
output format, determining required privilege or bypassing
security module specific behavior.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/userspace-api/lsm.rst |  3 ++
 include/linux/syscalls.h            |  1 +
 kernel/sys_ni.c                     |  1 +
 security/lsm_syscalls.c             | 43 ++++++++++++++++++++++++++++-
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
index b45e402302b3..ecdf1acd15b1 100644
--- a/Documentation/userspace-api/lsm.rst
+++ b/Documentation/userspace-api/lsm.rst
@@ -63,6 +63,9 @@ Get the specified security attributes of the current process
 .. kernel-doc:: security/lsm_syscalls.c
     :identifiers: sys_lsm_get_self_attr
 
+.. kernel-doc:: security/lsm_syscalls.c
+    :identifiers: sys_lsm_module_list
+
 Additional documentation
 ========================
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1ef2a3de8ae0..9c947022a411 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1062,6 +1062,7 @@ asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long l
 asmlinkage long sys_lsm_get_self_attr(struct lsm_ctx *ctx, size_t *size,
 				      __u64 flags);
 asmlinkage long sys_lsm_set_self_attr(struct lsm_ctx *ctx, __u64 flags);
+asmlinkage long sys_lsm_module_list(u64 *ids, size_t *size, int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index d03c78ef1562..32784e271fa5 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -265,6 +265,7 @@ COND_SYSCALL(mremap);
 /* security/lsm_syscalls.c */
 COND_SYSCALL(lsm_get_self_attr);
 COND_SYSCALL(lsm_set_self_attr);
+COND_SYSCALL(lsm_module_list);
 
 /* security/keys/keyctl.c */
 COND_SYSCALL(add_key);
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index b89c4e7d009e..ccd3b236670b 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -19,7 +19,7 @@
 
 struct attrs_map {
 	char *name;
-	int attrs;
+	u64 attrs;
 };
 
 static const struct attrs_map lsm_attr_names[] = {
@@ -102,3 +102,44 @@ SYSCALL_DEFINE3(lsm_get_self_attr, struct lsm_ctx __user *, ctx,
 {
 	return security_getselfattr(flags, ctx, size);
 }
+
+/**
+ * sys_lsm_module_list - Return a list of the active security modules
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
+		u64 __user *, ids,
+		size_t __user *, size,
+		u64, flags)
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
2.39.0

