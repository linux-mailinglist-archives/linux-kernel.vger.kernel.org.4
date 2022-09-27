Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1425ECDF5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbiI0UKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiI0UKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:10:20 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E931E0C59
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309351; bh=kZmX5D8gvn+IorW7ZBc7wQ4cuZ2xPhtzeLbcbM3NOUA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=T7tZKSPF06+f/UG5dasdwtipQs1cmeqXRf5Xr3NXLTcVxpl2vg2k7vQ1r7BR4g81yVVY2VzDd4hPKUAJy3iTk2INCRdbPglo9cBLr9G+iRkdF9ed6b9eLWUEOwcNWGNXhCWn9uFFeRshr8XIGy6Kt0p6sjxjWM9lpdNVMtUEWYSgVp06SweakP9wR/sD7CgnpkJ3dzq7f/ooUz1Ep5xg/GgQU+L0zQ9SZ2kt+BV1TSqDhwjycaW44zl6+MUWbql4ikDr/l1NbZp2FfYDNn3dH9WEI2F1M9tRXQBIU3mQOwK80aGsrSoJe65/rUZO/hlvI4Kzmj7jyVClZlspniJe0A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309351; bh=jyyKoViioSEMtD728aWLJQuwwJ3bHww7hlonDVU+/Kt=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=d3PFDzcSCQcvEt1dWy3FH4RrQ2fRMC5hZhloB81WOQj6bO7leyPm9VfufmkenTk3tmEpBa+WLgiGF1SopexV5qn01PHbq5Q2tkmYwPA+9rZFNiuaO4XbTSetp8zXybEO6UahZ+uyW2vs0ggPdgo7mBlg9AKj0OzdFuYfdJaVkT7iQUqwpqTo7Aax/LIgUX1EUNAM8bedE4TCVjCmFmJPf4u79V07JUKvQF9YBQoIPZbMlpD9/5d4d7YN7fkjxSNqOZ2VUaJHf4rljyBX86Pi6Bx/MxQu3jQ7dAkXYbNLYsono0vb6NtkUWPWA54/6MZtG7hzLOTO6EeU6t3xePycGQ==
X-YMail-OSG: fHNfqrYVM1lak68bp2UhuO4XTccAU8de_.KxvxBk40UeIRhLxlEvXHJ5Fgvatyl
 CDJxrAsRMeDw0KJyk_ttzvugnLHqnjt81oaBzI07yoce8FbI6tc9PrOoqc6hOQHv_w8eFFigwChL
 fRjjAmzMVkk02T0xP7wN1qQ_EFndEQF8.Ykg6Q53hqfc7zyyY7ewva8Vf6JZfBFwAsG_YfGzaI9n
 hgFptYuclBBfR7kVIDd.HAV6fXPNGR.gTU7Q8fQp6LLkIJHmGVUEXGGrYr8vIfpc97uVSOXP0zxa
 CkcezDm6BXPl224rc9d_G6lQywSCVdAPSAYk.D5CmUHvMB1k0MFnXdLGiqgnuuDSRNFwF6sJLI8s
 9tTowMQr.BpR6ID1XEPAZ5LRt0BGNETDksU40mRyA4XBZeC.WYSXfMgTGL2jVMKrhXlujcn2EbRn
 DaycYaFSHYtHcnRUWm_uoI0kXdwdMq8Akx_JqIbYqvUavkBD0Skq_dTS6qD2_Tym8yfGqan6Kpvw
 dR1sg1j3URrc7BEMxrep3MM_TVoxENZeKf2A3WQYHbJ.q0I21bDl0HGN2zkvbgdW6LODSePZORNY
 DI0Sj.8Gux5XgLlG0OB7QAXcrOmUaiucOsDzlULryE5FdR1b.4AKc0pwC8lGwAJUK28lTodELYQ9
 nF28mA9pRy6uEozhRPzI3CGF4CThID1VnGZFtmUMS862_j8eGreSHpNT2zR9J_MUIDbYhp4dS4Qb
 mIhNcghE.pcWJJGqr8Sw0oGWONMyiedGwM.0WeSq1LE.uHmNiLMPy.vx8hIz8ptwHD1OAb0drwKi
 psibpwFwAtuAdP4SeMOwmnxGLY2YSqwz77s3C8JQuSb9pQKPeoq1xwFbfxr4PUxOY6H9DjC452sp
 21PxN7EAJeRt6WMqOR.dDmxDFU.J1Z.lJ3s7vPUs5giunUOwXOLLkhFsT8iBowL8TrPgN6dJBjPA
 5Q6SFHzQ3Lb5SF9Ck.EW2ZwrLz4SzWlDsj9b__5bLQUu6FDHidHObXBlFai0VweNbvHrtbMYR6Cj
 q_lV_5JxHfu45cNsIP4fTJa3_nMC..rKkraayEc9Qg05ZiQ0dWfvf0l2eRP7S_YfD1HATQyuskcP
 d.Gr7i3aSM3vShqV7GtTf6bccwahZOhPIxEB5iUo6AbDIDLCDiTljJ2My8C0rhNMyiVjxbfrh1QT
 qrawRLnwgMoKdiIve_IgV10ylN2ImZwub0OCqmXnnaTokv8fllrHIuWMsNbuQEtlV2Jl43vE1cg2
 rES5Cr7piiXblvRQeAm2nHigZBhXDIMQiyUuf8lzmW9Jsgi_tFVI7MdaOUn8NtsLTPDwsbYiSIPT
 5Ck5Z4EzpGYfT7tSbLbVFkK7Ph4vOLkR4CRNIvPV.hyGUHL0CpP0MIkbZibahUJ4oVThh57rsD3t
 seGVVXjGHfAgZU5tFpIturSkcwuvNw3jARk5uQmKODrSfTwdhgnvZqXJhfq.Ywy0A3oEAPOMmKFw
 SA3593E15xYzAsZ2XxGfsQk6adguT4TwmCE4TCeo2i_khr7H5g4KfeE.VNRTqYjphTwBfpWUiP4v
 4LzsuWj2p1xY3AW_RBf0S2VLC5nCK5TsgLNyYQZK83lffI7eZNgm1qnMly6PdqIPvNPZtJMaq1RN
 lB72DP45zPrTPqawfViaxocws1r5y4MFTVggQsOpq7AWxU6rUat12hnGdOwuWDOp0F5FGTT5.AnI
 YoK7fBCUQkNvpvUyripirs12eDZniEulFJT8ZMxWlrb118dLC6up.r.UuBBGp29oIqMx4To1kiH7
 gyG_.kP8_FsydPUVZMYqml9YbeJBky.cK41YFxE6JbbbCd9vtb6tAkJ1VAyatglOFcyrzowFamJy
 pzItm.9D5k5rTFZdUmBYGE63t3vlnzzQfbl1X5X8qCWOZ_nMQMyOoyvJmI_YRdoH60lQIHf.q2lH
 GKXu714eiaoBHBbA6xW2eIzBhD1awbQyuA5L4AC39tbaEN7kopdw02mnhpSaPyI8pyPdu1WyHx0w
 pwu4N6sk9hVvjYTSpoVcKZWM3CjXQe08lBy9xLxvxSBQWK3TJD6OkLddgv9fBElVAMi0vlUZY75j
 7Cny3dJvTX3utGTRnelZdPY.BkcHTW4hIo0RK0_Dpq.E4MbVfTGJZuxPwnAaJOvqaXgeP7CaZ1i6
 DqyTpIcXls0mTeAL1IFvWWPQimPuRFLmHajJWM7jf8Y6v_tHuHYuhvWMBPcYvUdB51Mz09QL3DwX
 doH1btocmHfGmn5syDTyVDuUlHQBw0.aQg1OV3DL68_y.QyJVuSshZ6htWafI
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 20:09:11 +0000
Received: by hermes--production-ne1-6dd4f99767-x2f2n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 962ba498c220faeab9c55c1f2e7ba390;
          Tue, 27 Sep 2022 20:09:09 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 27/39] binder: Pass LSM identifier for confirmation
Date:   Tue, 27 Sep 2022 12:54:09 -0700
Message-Id: <20220927195421.14713-28-casey@schaufler-ca.com>
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

Send an identifier for the security module interface_lsm
along with the security context. This allows the receiver
to verify that the receiver and the sender agree on which
security module's context is being used. If they don't
agree the message is rejected.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 drivers/android/binder.c          | 21 +++++++++++++++++++++
 drivers/android/binder_internal.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 5cfdaec0f9b5..ff8f35b9bd1b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3222,6 +3222,7 @@ static void binder_transaction(struct binder_proc *proc,
 				    ALIGN(extra_buffers_size, sizeof(void *)) -
 				    ALIGN(lsmctx.len, sizeof(u64));
 
+		t->security_interface = lsm_task_ilsm(current);
 		t->security_ctx = (uintptr_t)t->buffer->user_data + buf_offset;
 		err = binder_alloc_copy_to_buffer(&target_proc->alloc,
 						  t->buffer, buf_offset,
@@ -4667,6 +4668,26 @@ static int binder_thread_read(struct binder_proc *proc,
 
 		tr.secctx = t->security_ctx;
 		if (t->security_ctx) {
+			int to_ilsm = lsm_task_ilsm(current);
+			int from_ilsm = t->security_interface;
+
+			if (to_ilsm == LSMBLOB_INVALID)
+				to_ilsm = 0;
+			if (from_ilsm == LSMBLOB_INVALID)
+				from_ilsm = 0;
+			/*
+			 * The sender provided a security context from
+			 * a different security module than the one this
+			 * process wants to report if these don't match.
+			 */
+			if (from_ilsm != to_ilsm) {
+				if (t_from)
+					binder_thread_dec_tmpref(t_from);
+
+				binder_cleanup_transaction(t, "security context mismatch",
+							   BR_FAILED_REPLY);
+				return -EINVAL;
+			}
 			cmd = BR_TRANSACTION_SEC_CTX;
 			trsize = sizeof(tr);
 		}
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index abe19d88c6ec..152d0b55e050 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -528,6 +528,7 @@ struct binder_transaction {
 	long    saved_priority;
 	kuid_t  sender_euid;
 	struct list_head fd_fixups;
+	int	security_interface;
 	binder_uintptr_t security_ctx;
 	/**
 	 * @lock:  protects @from, @to_proc, and @to_thread
-- 
2.37.3

