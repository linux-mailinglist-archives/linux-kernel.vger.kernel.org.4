Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1AF742E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjF2T53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjF2T5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:57:25 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98B52D70
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688068640; bh=a7U5kwce0MDhdLD5TI5KgXeRpWWUTH9I4CiTtqUWD1k=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=WXRBz/GJbtY+MaNHvqGK+c4ppNWGy1I1cN2fN3B+9wkDplvFK5Fgbuzj97QV6DwVsRGDD05GVZbWwTmUnU12K3LFcgu1Ub6tfpQhev6KVRy7lSHFpKxSenyNbilKRMJ4LvJMPtxPhOWqOSJb2ZPbBwz156KCzD9aB9822dwGcr2yOCQzs4kSqgZTSlRp07nhjavIIC54zOEPnLHlFjtWi9oE5PsRr3DNKH22gtDcI9QYK0OKSwRpwEE63+R1gIj0JItJp6E1TLYT+KmDrNV2fBx1VC5H4M66TPaL5taCBbh3t9heCWXI5LFGPHAzj91yXnqF3RoP6r6wzRCynuq+Vg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688068640; bh=EaMOISBbHBCszTzoDoO1bgN+VnS9hZJApDum4XMNZur=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=pKH7E5jzP4hu9FFaYX+a+7p4xGKNAmyDOeTBugUVzruEjKmXd2K3f+Z/YFAdEGPY80mG/uvvJxcKGm5+wvPm45tLW1zeuo0ar3/E2CJkuE8Kph5/QSMgxWLVhoCk0qpcv+wM3aLB3u2skl3KzVfKe9LazN+ztoSFQXTOQcorZkSw8yyxIUlM+6fWOqlJObfhxZdxx2+slkB+n8Efa9jZzYM1cliCBadW74XZ7B//jahWwIwO2Zn0zdH4G3CAAa+OXp3zw66o2h+jRhICSe25sSEecTra3F0RcIChl8eZ8uF8KQCxK3ng0iae94GO5JPtN/mhUhDNcfGQ+DrSFSi9RA==
X-YMail-OSG: dybT4VYVM1kZ7H_j.PcgTrxOs8KluT9J3qmWOhvN5221bKGZwFX_zDazO05AyXC
 1FD2e8WL3QPeBq32BFC_iXZw.0wSJV04jZ_mS1QTxqXAOaqcI0Mjv_H9D0YTBMKqdOArENl28pQt
 v2uwSXIfErxAShIDWWwbcktr0aL9OwH23EOAurI7RispPjcVqUwh7b2ScQarmSXLZm5QhlYWEt9o
 4lTJlSVNaFnXQ6e4ulElA5pSIUnTFo9yg0dz4C0z7wri_mRAcw3r5C4XnSCiiND71uRwZcyTmmEF
 7iwFwzlM2twOUGRjRUSaHSSprOwWiTlHiOlzKefMvIgzholUa3SYagE57zPgvh_Wjcf8KpqwQ0ex
 wZfMdyOTljwp.AzhEnL_Ko4hPM6G4t0YXt.3Haseuq2O8baEkEvsnJbxDC31f.UEsmeO7cGoH_RO
 KP5OUPT_9K.qsLfnLUVT3ELLBSU7TxTocZQeaeyRGgKEQmCMO.dhHRNDE5AtbOsCkIzQ.6r7P_fn
 EWTobBEA3BN4BJz8j0gwWMk0UBbpIMl_4vB6uUgpZqVO4fmto.os52IZI.6X636NOXqhM9BXTGpX
 od314hJmnzebLTZriGVMKRyf3eI4mNFRKY7FOq2j9PtrDwUs_B1Nl94Mt6s1cYP5qkF_c97TXqqp
 ZZLPiLg3oHz5Z.idtK_gC6b3gLIy_qTBFBli.ECpcIC5k.bsfKEb2RCv8upsZyF1Yy4PXRNlDqn3
 OAajguQU5wzap8QED.vs5UBWkfAcaBGcURTVUYVcNiUPh06068C09STOFQysCuIN9_2ncafAKnGy
 M3gfPsQ9EstEWeHhHXTJ9Zsj5HMBf5w9yItCGQ8QDHroFc.kEmPqcuTtp_0UHLlUmqY1qyH6cC3C
 5P_.vgx8HxQ0_MzJrarASfyTruiXEjRCJ7OlRXlOWYoYiIm_U87juytnQmD5QJOYx7UhoF0JrbcB
 Qx0M_9bAwC_TJ9sWtcg7fxPuJl.FvtMBMHqOaqoqcvbTclFhgKyTMsZNpkVVFnFdJc2PEsosmYJE
 71XIpVhoC9kRjzrQXJsY0olobjWGmNNXPdO5GPMB8JqzPF98H5jfKOa3Idv_KNMzT_0Jl020q7Wg
 n4jMtbtP7iBmB8Mqm3cWT.52GvYBEZBvGroXUh_b9Hk7QhAdOorOA5puutLIyfDizShfqKh2Lvdw
 IZsuAnrZOBXYXVFOdD46y09u5u0miQxDsF_RtpgATvnwkFxdseqFAqt23WMb6RIcqb_gyyMPCo.s
 diftrxJ4gCUPcrUajg2Vba1GoNTu7yC35YvdKmr1ZGJNjEegWqACAInH44JvuhERDGf3UK43i08G
 Uqm0sQeg8vh5ORVrxYhxyg7kQJ09Dyk7dcMwI9_t5RZXVrXG9t7gtSeAfw0wizvpSg0fae8M8wEI
 3yIE.hgj49xTsaniDzOPzlWoEiqP5OKRaCvHUP2uzvis7BpRjBIv6NVfTYuGlI2ut8wOGXsrePdK
 OTMT2MtFmfTPBx9ntuCNQfWDO0dZJkoZ5yKlFGfKR3FQQ5OODsiE.Lx4cAzgjq46lzfH4vTSRhT.
 vNK1NPKeJ8h8gTeQM5t13fn4DkGbkuHrDtjy95Cagr0VRENbhkPOXPa5OcVoNbym7S1iYy3VXkOl
 .aR39CSv6hmUI_PvYDtVkWSEfRN09AQ.KPdvCnEMknmDWTaN4dOu8ox2OWJxursXyy0pxmWrR4Mm
 hAmIZdfpJxxOZhuGbQZQG4jj1TE37ioqd.Rj5a9ZaAXc0cORnl0rIwhdtmOVkpLr00keRQ_W9J2j
 S2l9sadIWr1HduS60ugspCclIXEb4bLq08RwAEkWO02FZ0EWmEhsRmLz0yGD7ASIGe.1UPqAuGrc
 hAdV5HxRqopx4Gcc.cXbqe5DFvcUatJeS0irk_jUduN7k6V_aOodCMbUcltEJgM4c6CqHuJR5pUm
 9f65AqSjbzqo0klpbQzRe1rN601Q9ZnF6ssvxsy0UpIyYrlLZLzWR6latU.Xjjl7fPBb375wElqm
 y8.05FUzt_7_jpdNF2FBCMQE4qyR_QRskkj1fYaktD.7WJIbk7gB.hEj_eGflT6zPcR9YWWNQduo
 juggp5JPrQ.BZq_hwDszkjUuHf0aT.LNVOnvoXw__JAbX9sFoSLXVLqrH1idAYscSie0uVU4KmoD
 alAokaLa7PcVN8wf2CS4kPGbsOQW6he.VEdmRUKTMzTY0phhx7eeKCWb6x5baxR0FOFE.m3OhJbX
 oAKzmfoRmKENoVG_kYhtm3PEpfVScgiLQCJn4cvKjaZnd2n_Bf.AGhX8VV9Kq6fnMhgu0OppcxjT
 7pflerBefqPIwvaG27w--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 53baf225-18aa-46c7-9057-20dacc56e931
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Jun 2023 19:57:20 +0000
Received: by hermes--production-ne1-6d679867d5-xspjz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2b963465d429516eabd169bf0e2fe051;
          Thu, 29 Jun 2023 19:57:17 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v12 05/11] LSM: Create lsm_list_modules system call
Date:   Thu, 29 Jun 2023 12:55:29 -0700
Message-Id: <20230629195535.2590-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230629195535.2590-1-casey@schaufler-ca.com>
References: <20230629195535.2590-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
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
Reviewed-by: Serge Hallyn <serge@hallyn.com>
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
index ee3881159241..f03f2d17ab49 100644
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
+ * @size: pointer to size of @ids, updated on return
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
2.40.1

