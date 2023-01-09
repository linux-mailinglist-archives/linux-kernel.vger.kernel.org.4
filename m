Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB770662E7D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbjAISOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237274AbjAISNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:13:17 -0500
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1F46E439
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673287839; bh=eGww+YKFQ1wSkfIuOCIXTDhxU9oIMI2Gh5M5OLB5stE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=U2mtjUTWZG652L8AZeGLqFwfTD6jnN8hM5c6cO5MWdjjlOXj1q7TzrEUXeEDwNPR/nD214NYDMUXoCRYgNQ+UUkNBmbtB4eWu3G/1d0ZlplGHQ5pKsTTlfIEfMLzsgkukyhYXgBP6yOynYrU6HDqtGmUh4IVv4noI1+J72tMd6X2zVL5wJhPUCxEeeQ+tef3JxkFNPwUqeNTbMwLE2u64GDTVpiUgwl57psL/vYsVJbX9wbViuhLVUdM0At7TeCVWVFbNZ7+8XwRYthEDj2OnFsv5hRrnE2i8newyZlNvYcGrngh8x1huiKhOylgIrYF+gxjMam2WA+e8PIOS2gM2Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673287839; bh=DeT3kryq9m8GD9dpYllZmACn6ZGBRdK3VmWQ4UU8Fld=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=c9DfVxYKWnhgu6wXbe6uZlwj5RyJ6arCytifsYIAI+NUyc4+4BSBqlgN8OUwxerejHgECSq4w45ExyytQcQqXPEYuKqPmzKcN15p0jwMUWw8Jlstc/PEj7p1LuDqhehBiV8w2m6z1WOKiWjZsaGn0C0U5OXHH1GCaUjFg03Jipging40ctp75DNeFeawZlL3jgHGrB5PB34Olw2HSb8u+Xjxn0DBxoXQRbpCYSdLJusXcQ9WsIpIt+j4xK6hU8gXzlek1JUD8Yed7nVSgClTCqj086luSs3RGPGPya9NtPaj4g2UFzrghd2eUmUqHEkRX3i/mMaMSqSgzOSuIyrnJw==
X-YMail-OSG: VbK4PRkVM1lieQ1rsQ0F8XuIVlKFovrBomr3VH3WCWq6E_J_4v_rVOpOaGzd6K.
 Ak5LgZoALnk9YPujNCMD3eWjAU5IA7PCsbft70Si2k8kutJonOyAWkWLxXYf5GecwhXrF2eJ8qHg
 4TFYWGt9L0Fm8tJcZ0qhU1CuA57tlQ16OxbaaANGbNvOdsfsWimaLFNlFpsSB3WLRcUz8w0JIfvk
 IEXzk5sBJXoPNpRWvrl0MuTQyJr8TDKFdNNU5ba5Z0Pl6zj.mHgXlZGT5nH5pG8wl0DYkprOJNvu
 f.n1_OtO_PvdxKeilceIeQtBcRjkHaRJIZW_JAupaSTl2X9wQdJRxrYunh.Q3uBUUBneP59npdXF
 p2wj4SoYNGCJFle5rWpoZqJMU3ejc6NypvH6mHUySMerGfJ0rQcP9YgeOx21R8L6souDM5YX74HE
 y05cd4E3sBJNZO9OTUUiBM.TYUh4lLtEnofx32nOIbGPviLKm7gSHbX9k8uvGLEI40kfqZujSX.s
 REfps2dErw9KtRIN8c.30jqdCWlJkf3HgUJkys7HKcl0UBU7k.6mAkIWjA_CO.HbEtv9URz.qC81
 00C3ZF8.suwVETIo7XgCL2rMPVLJXlbh0YvAenlLnukHPfR5LMFy9.VZDelVIG8CLQTxCFGZpruk
 dFufdSKqi33XzOhDesYO4h9g8Q0xEXPksKLdRLm8ILNpiE4D2OUNu6W62jtmIF0WeJqDE.3mXQ7m
 h5BgQyeXdAGDLQUAcBsCeqnOc9ATvw0NV.G9fQqK7v8Uovnn2C9TrJvJ8ylxN4VkaK_Ez5oGQ1ZM
 e442S9h6xSsKjoLtwl1xefECH7EYX8dmg65o2HN2AincH5Pj3GgkNCejfJtPPpgnKUEGK8saRoNg
 YMV5endFpSzDakQ2GzJntqRHYNqMooiNNOGRYJ8nOG2JigTehS0EfkaPM6ZXNy2bxGOOUqnAGY6H
 ffVCR695lYaBd9_RBLWqcbqSsPLJRcxzF3CuMzi3sOQ7F_laUE28cvDZQDgHdt3mCRDrKzl28M6C
 oH_oZaEPYifOxIPq01g2rgz10Yq.2X.U64W2rYc8tnUok12HZmO5UurxaiM6QICi9RQk2rEusOVp
 UMb6dNV7JHaxDQE9LdpAMaZjuRaadjrfHi.kQmclM5lrO05NTm86VJBVhK2ntTyYtOytFrxxU_dr
 wpqs7JGc0SBMxR7xwSQW_q6oiirpP611JepknP08U4whSTI4hu5ibVbKkhG5eSh0gTZUstpiiBhL
 Y8iWjcZBZgMwNzILeEH29aoBx29O1xIlTjlznjMTlXaBt6KO.WpK_5U1yK7EDy7VGNlP1YgouJg_
 fAJrDsFE8QKekEbSro4HmPEy2GiCjvOmle5DHBIkv3z0x0FMy7PppVy3CmXQMfCg8RfVhhwdvyNv
 2lEbjbcEg.hOcsx8SMXUxrsH9hZujrxVJ8oWWcosJ5btUXhY08.El0N8DE1tZXHG05JCLpaCMVy2
 7IWjchiXeu.ifYJ03JZVHMMGrBZCL7zTvOPtZQnFim8s0j7ExFdqYbPeQ08BtIbNefnIfOh5iedR
 1IqfVXhUQGQXOc2BlVpMscEXsJ3K22mqfbMm2WVCNwGI78XTR5KtiDQjOPtN0Dq67.jjyTB1RXdE
 rDCSQMsetwhJEJpKyMAQ2h0B81pzDjfZlEAYYBC1vnkVvn6jZs.KS5gvzlqdiqcEDmjAJJBeEcih
 aBjuh41lGZEHgVWSJy5ljiVui54.Iy0.Ai8pDv8FKilnasdv66e0uzt_kOqjMpco8jsFbeUL.Sb7
 4qwkYKoSjmMe0QT9nv3H32oJOhLEhFJE7v847tRnF.aZtEwxK_0v4KWzge8nvDLDavuBO15c_jpf
 h.oNXWlPzoNxI_gdSmq20JkF2whBqC6myecoZ8OrZ.roF9iYEOrI2E_D7qnE8c6DeMqLi_RewZYq
 TclBkPXIo8qv6Fr.VM9N3Ea2Uln8JxVgpcUCm60QAu4s7ffDF0bNJfEggHNpwnw_cQ3UJT9i.IZk
 eqpJups1Dv_td0KngHXi7T6scFmktA4Pfl6wrhhVY2mw0oYpEw_.FBZ6gAs8hlmMMBf3uRvkNT.p
 RXSABOkPaxw6OCstneb3PirIK7Umu20N5g0r2uOdyb0bVyOKwZy_HHImdR_RHIMpjq41.TU2Z60c
 dp9KGL.ngoXtugnQHppRy1KLFBf6Euu5EpOcFTNuU2DFL2Z6GN3EQp764YcHz8GE3WHDyHG75gTa
 qKWO2xnQo7kQij.XR118cOWlAq7GV1VBFRnMY95xp46LgR.BjFNOSvRQTd0n3qRh88gt6T_z7ufu
 1KUIEIntf_OkBPT3T2zL3Sg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Mon, 9 Jan 2023 18:10:39 +0000
Received: by hermes--production-ne1-7b69748c4d-drrwg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d39a5b2fbd300476a1ee2f5b9fcd175a;
          Mon, 09 Jan 2023 18:10:38 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v5 6/8] LSM: lsm_set_self_attr syscall for LSM self attributes
Date:   Mon,  9 Jan 2023 10:07:15 -0800
Message-Id: <20230109180717.58855-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109180717.58855-1-casey@schaufler-ca.com>
References: <20230109180717.58855-1-casey@schaufler-ca.com>
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

Create a system call lsm_set_self_attr() to set a security
module maintained attribute of the current process. Historically
these attributes have been exposed to user space via entries in
procfs under /proc/self/attr.

The attribute value is provided in a lsm_ctx structure. The structure
identifys the size of the attribute, and the attribute value. The format
of the attribute value is defined by the security module, but will always
be \0 terminated if it is a string. The ctx_len value must always be
strlen(ctx)+1 if the value is a string. The flags field is reserved for
future security module specific use and must be 0.

        ---------------------------
        | __u32 id                |
        ---------------------------
        | __u64 flags             |
        ---------------------------
        | __kernel_size_t ctx_len |
        ---------------------------
        | __u8 ctx[ctx_len]       |
        ---------------------------

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/userspace-api/lsm.rst |  3 +++
 include/linux/syscalls.h            |  2 ++
 kernel/sys_ni.c                     |  1 +
 security/lsm_syscalls.c             | 41 +++++++++++++++++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
index e342d75b99ab..c7da13801305 100644
--- a/Documentation/userspace-api/lsm.rst
+++ b/Documentation/userspace-api/lsm.rst
@@ -57,6 +57,9 @@ Get the security attributes of the current process
 .. kernel-doc:: security/lsm_syscalls.c
     :identifiers: sys_lsm_get_self_attr
 
+.. kernel-doc:: security/lsm_syscalls.c
+    :identifiers: sys_lsm_set_self_attr
+
 .. kernel-doc:: security/lsm_syscalls.c
     :identifiers: sys_lsm_module_list
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 9eb4cb6bbeb1..a9f1ec9942af 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1062,6 +1062,8 @@ asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long l
 asmlinkage long sys_lsm_get_self_attr(struct lsm_ctx *ctx, size_t *size,
 				      int flags);
 asmlinkage long sys_lsm_module_list(u32 *ids, size_t *size, int flags);
+asmlinkage long sys_lsm_set_self_attr(struct lsm_ctx *ctx, size_t size,
+				      int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index af1fd28c0420..c3884c1c7339 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -265,6 +265,7 @@ COND_SYSCALL(mremap);
 /* security/lsm_syscalls.c */
 COND_SYSCALL(lsm_get_self_attr);
 COND_SYSCALL(lsm_module_list);
+COND_SYSCALL(lsm_set_self_attr);
 
 /* security/keys/keyctl.c */
 COND_SYSCALL(add_key);
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index 92af1fcaa654..026a86674a1f 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -181,6 +181,47 @@ SYSCALL_DEFINE3(lsm_get_self_attr,
 	return rc;
 }
 
+/**
+ * sys_lsm_set_self_attr - Set current task's security module attribute
+ * @ctx: the LSM contexts
+ * @size: size of @ctx
+ * @flags: which attribute to set
+ *
+ * Sets the calling task's LSM context. On success this function
+ * returns 0. If the attribute specified cannot be set a negative
+ * value indicating the reason for the error is returned.
+ */
+SYSCALL_DEFINE3(lsm_set_self_attr,
+		struct lsm_ctx __user *, ctx,
+		size_t, size,
+		u32, flags)
+{
+	int rc = -EINVAL;
+	int attr;
+	void *page;
+	struct lsm_ctx *ip;
+
+	if (size > PAGE_SIZE)
+		return -E2BIG;
+	if (size <= sizeof(*ip))
+		return -EINVAL;
+
+	attr = attr_used_index(flags);
+	if (attr < 0)
+		return attr;
+
+	page = memdup_user(ctx, size);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
+	ip = page;
+	if (sizeof(*ip) + ip->ctx_len <= size)
+		rc = security_setprocattr(ip->id, lsm_attr_names[attr].name,
+					  ip->ctx, ip->ctx_len);
+	kfree(page);
+	return (rc > 0) ? 0 : rc;
+}
+
 /**
  * sys_lsm_module_list - Return a list of the active security modules
  * @ids: the LSM module ids
-- 
2.39.0

