Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A807B5ECDB4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbiI0UEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbiI0UEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:04:00 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8DB1E0C6C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308965; bh=ARvlGx7mZdnvkYbvCVi5OxetmM11nBSp/TfSq7uJPo8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ETnMQLYYZhr27mpQn/qG5T4Fgetrjqac7DaeBFe7pSa2GTctjhSCsLj7xVkmLQesdcmiwnREwa3jJdCrZq7MWCJryw+ulZGFONe85V74aXqWX8hPgwq+mudawCjco/Gv9a5CpB0cg82LsnTq20TizmlXSxAIgqbNplA2AnODjFvyheAXFOlUnFnwACW0iMiAfXw/KOV2jXDMISQiOzloM5HqmJn+rNAOspQ9gXylvS+YXi4N2KiaFpHMNBVa9O4VnmNkjSTvTJvbXUxVOi4qD20ibDAx/16Wuoteo0XOrdCo0s+nGr3Ryc+eIRDDcc9jcfYO0rX+NdYy/0T2jQu+eQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308965; bh=yte57HEQ4ImA3Y8jiYIuuB2LPOLKz5wNkPQK1eA7sgd=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XWAISSpQTZdguyPisE7uAwXTrBwkFbsnkhNzcDWBf+TAIgt8HdBMq0G28q7c4Wd/C8AJxvr9/syk+syiFPHmhtXw0ohT/wYkY5YSAQ/hnsOCIaea7e42x458prxo5DCCfLJ0iUpewh5g62QTrVfjWrp1vif6oJRD1bMhOeEx1yYSChli/D8P5/vqxttSFrJZrwMLSxxWC2eBC8MchFhAp/ZIpQCPaRWV4lLJZgRx1s4qruGfNfZX7cFNATimRhYYOESEqLtU8pov4cQSdKUXoY8debg8iADSZ+q9R/X3AA2XsH9t5itoYCyj7CGYu5Exsu8Q2O7xTIzxWu9oMXYvPg==
X-YMail-OSG: L.CEY3cVM1kU6n4Tk57aDEbhquTUHPlbRdYJp29gdf1ukV0yGRsnrD23fx.DkSv
 X7X0Uk6E2wT6UZD3vc0xqO7fF1ZcWmK.gxhGViT7Fkn3.H7XGKjoH0xVGD_EIEee8MZyKfy9VkET
 4djR7XHCOuGUiPFtH6cvsqYoDEc3zW1SzUZn8eemQxnwk0Kglkka9RUqZylmoeQN1q5Ew5zJumed
 52mwEgvhBmnd6UeY16bNt0hnrD1V03Ni30xMlZ2G6oywSfI7kfLU3tj_5..zXX7RX.OdLtiCsUWf
 S0OOLd8F.4XuC._DHUE2zhwvf462jrrQQXiBwgTGXwE79NDLmEaZtngVDmtDqDVKe4WAxyyl1c1Z
 0l02pDfisf4LMo7zBE9crKiLjsWMiWQmp30aC24baoyvW3W3qhj88OpCtXt7lD6oQ31NHcoN5IJk
 r_7b382d4zS6LlSp0A98YeROwfZ1ddmcR4qktOwhvlBXmqqQsIIhpE4IMHkzmi.BpGAbO1xlfrKP
 wYjA5RQ_6JeiJY4j5K8hENRW8LdyuC_Cplv.qZeIfu7Y8aAErwt9ww.m6ehvRH62tR5yhXDkMxpA
 VUur2YyHWxXrTHVmZKzOd0Y_DZjTXepny_hQ5VqGuOwX8pFXPXv8lF5KiVXyv627zV5ehfmbZ1no
 WGLF2bljpZmtnZNZJPqBzpl1KqgmnOExdNKJG7eSSJ6h3zDvGefi86OIUqMBOv4.ISizoQ9gD2bE
 D_uxHKPWemqnQhxRKTkS1bggZOlSSswdfik_pMy0.8be2n2tgphXadYN86pra3F_9Y2gCJ.uYC5t
 K.4rgJq21xdudGgqnxtYXNI75Jfo0TM3wJVHcwWsCe3zDJ7J0NtYAUQBNxhvRArddP0qrjPqF2ie
 .56nj5trCBbtP92sZ0nGqxDXvoE7Xi7SzXORLnjE6S96FP_vkrDWte49AgHSL3fhvLdVS9UzG9v8
 W1pifQA8kGkw3MLgoCbywMck9DjAHldNgO72bjH.m0kPE_nw0vU5N0NBdAQZgJrMHRfRv.SEBNHX
 MXAY4nv4RTShadKVgrqhskj2c9PgnXeFq778jmn8Zb4dVN6GAUuJGvVg.NY1rZZ8BzEiZVJHpuDm
 oAHGhrIMt43j_9zMU2_6a57CT4ea5ysQS8F3W4ExjZ_m0LXyJkMmg.SufO9FrJ6fDIHBP.mjVc6J
 Zn4jmaqOUwW.3KgQ4hDdzoii8d52MSMc.NIZzlmelHbrS_Zym30_WRwpYa8imSnae5DTaXbPVZWh
 8x9UGsXhVHgbarUhHTKES1LAyZoqzUdjkiF46haFyZHyHsHB4uI8ms4OMYrfpWfctxoN4gMmjkyE
 n14rNdrDt9NhXWE93TfvmUBo679Z_Jbg6jqxgAl5kYwq4p5zBdt0ck.b_QoaGMwXaeDw7HduouTi
 6K0SmrbFQ.jhCHfHD2gkyfRoW4V7UjyyQx4k4n0m7O_wFrfqicr8IpuLHGTCbmYaynfACP61LRm_
 lQKAMnNTiPvS.WZfhIgPnY_TPUgwDWeb8bEiN56TUMPbFISMesOI8Tt3Hr2Qzwkfd6.nBw4GG2Aw
 0RylxLF50JFy26WAy8jT4Hjig.yYARB9sRc7t1HcB3MJunqrKac3EcDXPB_2Wsr2mJJsIUmpV1Mu
 vVO5cAt2wTt3hzqU3aXxUhukf8oCg2XFn4hHLT5haGPYLXtBTnbxYUb2bUkMu9f6pjd8mF0sM2NC
 IRW2.dtpcgSp1krl1h8PlBC9rEWCMPCn5_b0vV9Yp5FGEZW8uDZcEQV.iCEP5rtHlxXCmnj3iQDX
 ka476o1eGlGctl0aFz5jcDCXqaCcmdh2hk96Ir1VYhBKkaVJB5XDPmby2S9iwKB3JHp9fBSePzFJ
 PHHdIk5p54cg0uHIkgtNS1GrBNf2fwjjPvKK3B0G72fs_zwBp2yZALEHZKZCeT6.X68nMQBVbW._
 NK76WFfWGcmZv0TXH1mKNMtZ9yw9GaJCEGAFdslP6ORryXxZpAcxx1w_y7tfPZzW_aXb_J9Zv4Ao
 ebTv1e5HBxZbO9sLVp6kD49maCjfpwKZ_3W87NlH6Cn57QXN_jN1FDqMA6ER8mlkVf10xqVP0kTE
 0VCFNpyrroJC8DVPUCHgFYzS.x3YIfJj0xLt1XAkRctIX.EyK2yV6viX1np1zYEyh6e94GfN68Kd
 4JLJDenxujcr4Ehwibbt.qIXwXQboANw8RJgh_DzAwSbIj6ntjwvJH9EIiejpeslrYG3vSkkTyTv
 C0MtTSSmjfdbvn25wtSFZOIf5Nn2dFWwTjRThBNY.RPjp5BT7GptiIKgaQUVkH9hvOaissOWoStC
 9Mmb3fuAotVVOoCyNOVOmNGJs0VvdszFLTKEuUwk-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 20:02:45 +0000
Received: by hermes--production-ne1-6dd4f99767-97ndb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0896e936b45c39858cb958d2af309d20;
          Tue, 27 Sep 2022 20:02:43 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 16/39] LSM: Use lsmblob in security_ipc_getsecid
Date:   Tue, 27 Sep 2022 12:53:58 -0700
Message-Id: <20220927195421.14713-17-casey@schaufler-ca.com>
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

There may be more than one LSM that provides IPC data
for auditing. Change security_ipc_getsecid() to fill in
a lsmblob structure instead of the u32 secid. The
audit data structure containing the secid will be updated
later, so there is a bit of scaffolding here.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-audit@redhat.com
---
 include/linux/security.h |  7 ++++---
 kernel/auditsc.c         |  7 ++++++-
 security/security.c      | 12 +++++++++---
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index d9ab76c909e0..bedb2047138b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -541,7 +541,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1304,9 +1304,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 	return 0;
 }
 
-static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp,
+					 struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob, 0);
 }
 
 static inline int security_msg_msg_alloc(struct msg_msg *msg)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index d083c050d660..9eb2d84439da 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2643,12 +2643,17 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
 void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
 	struct audit_context *context = audit_context();
+	struct lsmblob blob;
 
 	context->ipc.uid = ipcp->uid;
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &context->ipc.osid);
+	security_ipc_getsecid(ipcp, &blob);
+	/* context->ipc.osid will be changed to a lsmblob later in
+	 * the patch series. This will allow auditing of all the object
+	 * labels associated with the ipc object. */
+	context->ipc.osid = lsmblob_value(&blob);
 	context->type = AUDIT_IPC;
 }
 
diff --git a/security/security.c b/security/security.c
index 9c49406e5ff9..afd6f6698fd7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2030,10 +2030,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 	return call_int_hook(ipc_permission, 0, ipcp, flag);
 }
 
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob)
 {
-	*secid = 0;
-	call_void_hook(ipc_getsecid, ipcp, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.ipc_getsecid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.ipc_getsecid(ipcp, &blob->secid[hp->lsmid->slot]);
+	}
 }
 
 int security_msg_msg_alloc(struct msg_msg *msg)
-- 
2.37.3

