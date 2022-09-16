Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984EF5BA639
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 07:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiIPFFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 01:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIPFFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 01:05:21 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DB8481C0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 22:05:19 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CEAFE5C0243;
        Fri, 16 Sep 2022 01:05:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 16 Sep 2022 01:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1663304716; x=1663391116; bh=S9j0j1Lz1/cpeYXutB+jjIO0x
        PRBQqXx5zC+Ilqp1fk=; b=kCwpt0NliST/EYKU2XDzmofiTnhzrTzigxsvelLru
        gAtW5U2J7RHP6JAM/f9EWZwJLusyeZ6B4DtsepeqUZVKdOQkTFH95A4gn+MFCgDP
        DdQixKYy3IR1GweMwjYNJtF7TcTtebf5SHGDDhTwQgDWItx6e8RfPNiRnKAfizaf
        15oBhLmonoANbSc9RfJnTa722TYzbUMsjANCBABpd2JthPochJG7risrTATdBGkf
        vC5Mx+BOeuq5kqLDgSwaeWsk6kI08l0iUaJ6AFZbkSVl0hSfV3CEusZipEhTEQwH
        BKoMACROQARWoWss7hYaxwBVoZAm0ODAoAvgkIUJEvcXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1663304716; x=1663391116; bh=S9j0j1Lz1/cpeYXutB+jjIO0xPRBQqXx5zC
        +Ilqp1fk=; b=ZYULg6WLKnL9puoWilOYnCxEVn7ACUx1ytPVFc8Xrdnns6FBFBZ
        rVL8J1rmcPMVduvpYMSCJLUOwC2f56DCbLZUct+MV0ui8N4pig4sf07NSVFnm06W
        FrRyxY9/OwE3cZPdTA81HrKBeqd3Yws26r+b49VCXvnLmAHDhu+MzIR+dnyELG06
        DjyYjG2Q4tQNeRFPTPZY5igYPzpG9dp55OZ9AyKJP8OWFZwG0grVRswj7R6yT5z0
        jAgWO0ZSQFM1a/wUMZP1R32bfIxrPvqTmxxScocGQIVn58c4QNjiA5H58IBcJLW+
        k5I/43377jxRGrdOgGz3yEYuUeKL6toi53w==
X-ME-Sender: <xms:DAQkY3jQhGmHLrV4XRhVhIglivPful62s6DLytz2pBHCjvFB9xux2g>
    <xme:DAQkY0CvbsfdW5VHFfs-jWxAugCAqL3PHXtY2anM4DSF8kOf-PBLR2MKjnLPiIMiC
    BjgtAiyQHNf0D1xPg>
X-ME-Received: <xmr:DAQkY3F29GGF0VRp9WMCAJHKHSr62OA2V1sBI9If6FcrlMrUGk1KG9Ks_QCv4_KIWtSBqImLyIklfTR_CFH5wEXcIXAkY1vkKpwFbH9bwte_Hi5hYiMfpqTSNmbp_jt0-d72Yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeduledgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:DAQkY0Rgj8r5WBw4Z2Mtom14kknQyEzJnDIfiOMqoH3brmNShKmS-A>
    <xmx:DAQkY0zZfAIljp-FZUqzDHUdISYvHrQcg5ufXjcoagztz6kOCZUAcA>
    <xmx:DAQkY65pWfUzfn7je6agm02j5vIes-rUCu6kayXDt1AHN7aNvu-KfQ>
    <xmx:DAQkY3yJ4ttefYgjCCYj6WXQWbxoMs-DSziz39JYy-iA7L3Uqw8t7w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Sep 2022 01:05:15 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Russell Currey <ruscur@russell.cc>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Save AMR/IAMR when switching tasks
Date:   Fri, 16 Sep 2022 00:05:14 -0500
Message-Id: <20220916050515.48842-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,URIBL_BLACK
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_PREEMPT=y (involuntary preemption enabled), it is possible
to switch away from a task inside copy_{from,to}_user. This left the CPU
with userspace access enabled until after the next IRQ or privilege
level switch, when AMR/IAMR got reset to AMR_KU[AE]P_BLOCKED. Then, when
switching back to the original task, the userspace access would fault:

  Kernel attempted to write user page (3fff7ab68190) - exploit attempt? (uid: 65536)
  ------------[ cut here ]------------
  Bug: Write fault blocked by KUAP!
  WARNING: CPU: 56 PID: 4939 at arch/powerpc/mm/fault.c:228 ___do_page_fault+0x7b4/0xaa0
  CPU: 56 PID: 4939 Comm: git Tainted: G        W         5.19.8-00005-gba424747260d #1
  NIP:  c0000000000555e4 LR: c0000000000555e0 CTR: c00000000079d9d0
  REGS: c00000008f507370 TRAP: 0700   Tainted: G        W          (5.19.8-00005-gba424747260d)
  MSR:  9000000000021033 <SF,HV,ME,IR,DR,RI,LE>  CR: 28042222  XER: 20040000
  CFAR: c000000000123780 IRQMASK: 3
  NIP [c0000000000555e4] ___do_page_fault+0x7b4/0xaa0
  LR [c0000000000555e0] ___do_page_fault+0x7b0/0xaa0
  Call Trace:
  [c00000008f507610] [c0000000000555e0] ___do_page_fault+0x7b0/0xaa0 (unreliable)
  [c00000008f5076c0] [c000000000055938] do_page_fault+0x68/0x130
  [c00000008f5076f0] [c000000000008914] data_access_common_virt+0x194/0x1f0
  --- interrupt: 300 at __copy_tofrom_user_base+0x9c/0x5a4
  NIP:  c00000000007b1a8 LR: c00000000073f4d4 CTR: 0000000000000080
  REGS: c00000008f507760 TRAP: 0300   Tainted: G        W          (5.19.8-00005-gba424747260d)
  MSR:  900000000280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24002220  XER: 20040000
  CFAR: c00000000007b174 DAR: 00003fff7ab68190 DSISR: 0a000000 IRQMASK: 0
  NIP [c00000000007b1a8] __copy_tofrom_user_base+0x9c/0x5a4
  LR [c00000000073f4d4] copyout+0x74/0x150
  --- interrupt: 300
  [c00000008f507a30] [c0000000007430cc] copy_page_to_iter+0x12c/0x4b0
  [c00000008f507ab0] [c0000000002c7c20] filemap_read+0x200/0x460
  [c00000008f507bf0] [c0000000005f96f4] xfs_file_buffered_read+0x104/0x170
  [c00000008f507c30] [c0000000005f9800] xfs_file_read_iter+0xa0/0x150
  [c00000008f507c70] [c0000000003bddc8] new_sync_read+0x108/0x180
  [c00000008f507d10] [c0000000003c06b0] vfs_read+0x1d0/0x240
  [c00000008f507d60] [c0000000003c0ba4] ksys_read+0x84/0x140
  [c00000008f507db0] [c00000000002a3fc] system_call_exception+0x15c/0x300
  [c00000008f507e10] [c00000000000c63c] system_call_common+0xec/0x250
  --- interrupt: c00 at 0x3fff83aa7238
  NIP:  00003fff83aa7238 LR: 00003fff83a923b8 CTR: 0000000000000000
  REGS: c00000008f507e80 TRAP: 0c00   Tainted: G        W          (5.19.8-00005-gba424747260d)
  MSR:  900000000280f033 <SF,HV,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 80002482  XER: 00000000
  IRQMASK: 0
  NIP [00003fff83aa7238] 0x3fff83aa7238
  LR [00003fff83a923b8] 0x3fff83a923b8
  --- interrupt: c00
  Instruction dump:
  e87f0100 48101021 60000000 2c230000 4182fee8 408e0128 3c82ff80 3884e978
  3c62ff80 3863ea78 480ce13d 60000000 <0fe00000> fb010070 fb810090 e80100c0
  ---[ end trace 0000000000000000 ]---

Fix this by saving and restoring the kernel-side AMR/IAMR values when
switching tasks.

Fixes: 890274c2dc4c ("powerpc/64s: Implement KUAP for Radix MMU")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
I have no idea if this is the right change to make, and it could be
optimized, but my system has been stable with this patch for 5 days now.

Without the patch, I hit the bug every few minutes when my load average
is <1, and I hit it immediately if I try to do a parallel kernel build.

Because of the instability (file I/O randomly raises SIGBUS), I don't
think anyone would run a system in this configuration, so I don't think
this bug is exploitable.

 arch/powerpc/kernel/process.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 0fbda89cd1bb..69b189d63124 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1150,6 +1150,12 @@ static inline void save_sprs(struct thread_struct *t)
 		 */
 		t->tar = mfspr(SPRN_TAR);
 	}
+	if (t->regs) {
+		if (mmu_has_feature(MMU_FTR_BOOK3S_KUAP))
+			t->regs->amr = mfspr(SPRN_AMR);
+		if (mmu_has_feature(MMU_FTR_BOOK3S_KUEP))
+			t->regs->iamr = mfspr(SPRN_IAMR);
+	}
 #endif
 }
 
@@ -1228,6 +1234,13 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 	if (cpu_has_feature(CPU_FTR_P9_TIDR) &&
 	    old_thread->tidr != new_thread->tidr)
 		mtspr(SPRN_TIDR, new_thread->tidr);
+	if (new_thread->regs) {
+		if (mmu_has_feature(MMU_FTR_BOOK3S_KUAP))
+			mtspr(SPRN_AMR, new_thread->regs->amr);
+		if (mmu_has_feature(MMU_FTR_BOOK3S_KUEP))
+			mtspr(SPRN_IAMR, new_thread->regs->iamr);
+		isync();
+	}
 #endif
 
 }
-- 
2.35.1

