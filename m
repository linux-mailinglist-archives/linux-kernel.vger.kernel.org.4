Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA849662E5E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237464AbjAISKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbjAISJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:09:42 -0500
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5332625
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673287749; bh=G0wcZ/Rhqtww1ThfnjNfR8i7612RX9e/53Euok8eGoU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ApGS7m61xDImekYfFyRyApsd5HupFOAf3KZwQ1e2BEbtm/5yYiLicaWxGGkKgCpJsqXeRufi60Crz59uyzaUKO+bck6Kvh0J2wk2kTeCoVI7o14W99ch4c1qXPXaQ6Ll49efBlrQc65phuWy8rDJbgPYUhvxP+6gsgnuLgOUqGiEWTlsuHYNHCcS/4qVH3RBNNY0D2QfboW+eh5lgf9Wsutz4SDPX1kJJUdgrz2moCpzzzzTE9v2oT3YdJ96n/Y55PbzDhI8jTj0b+qr5xI5DxMZhtc4TThOzASpfPZXoqF6okwyYhLbESONoiCEtRAqTxeGBvk8/YbwyN84jB5KCg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673287749; bh=jAIbvs3dRmHTfBGydXVimzpWt4T1dI3y/d5pnvLP9Ba=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=UrOoFaSPcWLUnDHGSucq+eErvSNAWVLFdc9B6wpPVqnEKyNXUACeyOAUvl6xtLii6HP3FO4SWTz5wYqvtYYaEFE8tkRT972AaiysLieF+qS3omxqSt7pVjbrYKvZJBBUmpZQSuENLWAIjodAtF056MF2UipGJoiVvGLnXmorTkjjT6/etQ//jDttkL8axvUo7ty4XPTNKZRLJHqNMs0kqJEPiVAE6155N2cD1cFTGXuZrO3FpCS40CvdQN32BJnEj/RKqWbKO/ml/rxWdk9drYVzuKVU9c8HEtto5ahLUI6EaGiEvYBiKzP0ScIrcyI2OZltNAJ5Yx+XUchIFUGzYQ==
X-YMail-OSG: 6QWsHTsVM1nS2OHkK70OB5.wQ1P_T6c2zo0Wsx.qxqGW3GrQZddvMtVoTParOrF
 FIBO__N6yD3DguRNZ7.X0dsujtOemLhFsG4zilMXkUgFkPYtyZd0VNbK5VF2bIaDqrepfhBqQb.5
 yN4Xydm9vUvlsfyFr6pejokkUkqxjtPMFP4UyTw_EryAJu3qkN37KZbDEdD.wTRQl57PEGqHKX9A
 B9jhvkxqQFmZuIV3gu62KhhrQhJJZVUxy4aB0vo_cTfnV_PWBSNQmGfEtsCFxkISl1SKqiiUHGlI
 ww6f4LisENIiZ7UZUfENXg5uK9HLzumMMD8PH4nxJngX5kvAw8GwhTlfaXSuNMe7IsZfMKInC2Sm
 Ny2QwFs2H7yILRpG5mM3EL5gnRAamFCwmQvy6M5CNlvhALkd126vPhpB5yIuo493Et1YUOAIQiAk
 SAkp9lTogZZo.oRo2GYPO8I_ta.lhc6pMkIgdLOGHKmhZHsdJtrsc7uG21V8GoZ6ma2i2E9MHcNJ
 jX.j_iU9E9oSTLY8UJ9rqIuunQOrErrtngrWH3yPvKMEtv8Cfk_v4XPkK61WbA52uP8th9Umf8FB
 rTgGFDq9GmiY_yp9uutG.GhupYRA8PnKrFIE8CZcWR5lqVJNToRZA_YokWKyLUv.Ufo9qCFySOq7
 VfIak4dIao_D1oFmKpabZOhkZOvj8JBdK_g2SgF7FUl._gvdtHszG6PnEyTXgBK0VhnWMaUEb1jx
 Im8mXe_bTP5wYT3jpfVRmmeucM6AKW4tx.Xm2dgvvPVpvTGoP.uJOBtrlZ_kJSqivvvzhMCvnhV_
 KVvEpwiOMi3E5ANWXpJxA6ik8_js19Vzicfg80cE9RTULdnDHujQU8emtNXdqM8mLC1vhAt5ec1Y
 3kgZQIBAJhfApNXiKLm9HcTAm426aIWoEQwtOmLIEY_aRB7aSY8oj7zpcwr2AYIfISNqqwkmokOF
 hN.Lrag57Xz6elC34fJQktYv7bakMCmpE2HrmMZNBXrP91DI3HEcYSsNbzh1NUzCnZKWrx3mJZh6
 KEIzsGV8LaPXmkDKSncwPg.qCGUyk_3_l6AMWD.jCk7hX1ihUMNFZ_.DzIz6udD8QTIvs1E5Ay3W
 QMrkC6tWn2grVEcOcxkey_527XvOmVBctLiBD1n35U1AD8UtaPKrqGFyO9jcq2ZNNFc3q4TkEIMT
 T4eBsyabj6RuxHyQH.kuLBbIPLgBlWmbWqfANqz3FFs4Z4kNy8qFmjiPEMMbl_WCA9yO4Zfxlv3O
 OGzxHAKIC.fPXzcB9yuykRSEWeLuNnmwjGgPcPTbYGv3TZK3r7Y32bgC7kZCXYqwGfpyFJVlh4vW
 9v.SkujQHYJW1NgCmtzN.sgcmHpHJyCJq9007lCpDRgQeMVWfNWmDsnwWumPjipTDzvMn.djC6en
 BERSdsQ.v4jmaSILwN0n.7Kc5CRjbw3ZPBaSpfHXTwJiD5YGYQ._3DVPr9CXKicxu5gXFpBdjSNn
 H8UhgK9jBe.iWRBDG3NEZmxN4Yl2envAIrleYPUmvYWR2Y6uclyo3e_AwWyDGF0wPhX_K1Tj34uJ
 nexlaSCNvn3ocnmqOogKSAKpofaSmN7.XdeTFFmZB1jIQAlobhGcZ6pU1BW8zFs6ulfsADXpNRgg
 l.ycG1_fJuqIViN0kQnLmn2hvHUfQw5lN2XZemnF9Ae.oMVBMjLxYlqN_ut2BZQ.DgEICdp9buZm
 WF6lVKXihjy6YHUncy1mJxiU5AKTg_S4A5IWZ0L2UX6ttCmtAX7Omkc3Hxd1BLZr.O4ueehlP4IW
 qfoYdqPblD3rqng.YbXqyBD7Wo8JRcqutxDom4R6xdAZ1MO0AJ_paM2n9I4XosF_uYWBOFumOLSf
 VAEWmjRIl8kf.YgG_PnDnG3Ai7CTPWcpU1rIk8ccqvKsgQaBH.aPuRzJgv4vrJIMfXsi7FGD8VEj
 pScpa68OamHIXXmBWQIVMZ8Lu00GGXvWwuI5tsXabAQ9Ad65WA1r7XmVJgHIQtsKm5CMEgB0u6u2
 7Ytfj6mv6zIqP3UvzNNYG4b2BeilNzcVo4Tw1Skln1sG12J23cQNcXNyLBgp9UxC5kByvDDQpvYd
 0TLDovtgVBZrgc4Aw8kgsnUsNwI1EIqlCPXlQXtXC00u6qVFwynV338IbrCgVk5B1XJ0GW0AkHr9
 _fXNEfMlKRfG0sXQez2ctB2QU1zojIECTFl6WsM.UVD7P7ue.Zy1mDiYZD4nL18I_GIDmSXw7soq
 QqidYRizVhTRrPjbwP.dHxjCY5p47VHOz.ZEQ7LmpIBTU8xjd63VXHzf8jJsnRh7tGbHy7ykMnyC
 IliELc29XwSzmCRrK02Bm
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Mon, 9 Jan 2023 18:09:09 +0000
Received: by hermes--production-ne1-7b69748c4d-474lb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3be57d1d3a3d9a781b586d3784815f58;
          Mon, 09 Jan 2023 18:09:05 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v5 5/8] LSM: Create lsm_module_list system call
Date:   Mon,  9 Jan 2023 10:07:14 -0800
Message-Id: <20230109180717.58855-6-casey@schaufler-ca.com>
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

Create a system call to report the list of Linux Security Modules
that are active on the system. The list is provided as an array
of LSM ID numbers.

The calling application can use this list determine what LSM
specific actions it might take. That might include chosing an
output format, determining required privilege or bypassing
security module specific behavior.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/userspace-api/lsm.rst |  3 +++
 include/linux/syscalls.h            |  1 +
 kernel/sys_ni.c                     |  1 +
 security/lsm_syscalls.c             | 41 +++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
index 98a0c191b499..e342d75b99ab 100644
--- a/Documentation/userspace-api/lsm.rst
+++ b/Documentation/userspace-api/lsm.rst
@@ -57,6 +57,9 @@ Get the security attributes of the current process
 .. kernel-doc:: security/lsm_syscalls.c
     :identifiers: sys_lsm_get_self_attr
 
+.. kernel-doc:: security/lsm_syscalls.c
+    :identifiers: sys_lsm_module_list
+
 Additional documentation
 ========================
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a89205c70ffa..9eb4cb6bbeb1 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1061,6 +1061,7 @@ asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long l
 					    unsigned long flags);
 asmlinkage long sys_lsm_get_self_attr(struct lsm_ctx *ctx, size_t *size,
 				      int flags);
+asmlinkage long sys_lsm_module_list(u32 *ids, size_t *size, int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 7b2513d5605d..af1fd28c0420 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -264,6 +264,7 @@ COND_SYSCALL(mremap);
 
 /* security/lsm_syscalls.c */
 COND_SYSCALL(lsm_get_self_attr);
+COND_SYSCALL(lsm_module_list);
 
 /* security/keys/keyctl.c */
 COND_SYSCALL(add_key);
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index 55e8bf61ac8a..92af1fcaa654 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -180,3 +180,44 @@ SYSCALL_DEFINE3(lsm_get_self_attr,
 	kfree(final);
 	return rc;
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
+		u32 __user *, ids,
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

