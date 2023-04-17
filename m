Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEE46E4591
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjDQKtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjDQKsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:48:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D704ECB;
        Mon, 17 Apr 2023 03:47:52 -0700 (PDT)
Date:   Mon, 17 Apr 2023 10:46:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681728406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2eRms53gsCOGxd9wfLLeeaNB85kzjJoqLxCQxZQiw6Q=;
        b=EBRq/5zINw18RCMNTUNRcjn31FnbGfhFsFDo6+OCRE6uy8Lcb0TRyRCup0stmkAW3fso5A
        10pnTaNorpzMp6RlihHjG125uPA4seEwOar+ylIGlsFXgBOzsEPdlnj4K0nzLM/D5DsxxP
        N62unRu8lUrMK6Tbzr/gksmG5ekuvj42s3XhUcm85U1UhT89F6rpk/ItgpBt6coZb2Z7BP
        755yEG4Q3dLH8amZVISFk6KpetDO+ObfQ4Egt7qSYe8clABOzXrRoF7wnlCu8MW7pV9uyP
        M8bGoNj3fUtpvpyvLv3p9XjvaZeEIct5cPkRuOdKsi9zLM3XTax93aL/wv5Ikw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681728406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2eRms53gsCOGxd9wfLLeeaNB85kzjJoqLxCQxZQiw6Q=;
        b=iCeuKA7/qepbW3Bjx3np1pkdJN+xPOvas8qTXg7k7Qja1UHolCPXUE0n8V2m9pm4cbgGEa
        srKEs5xNKsaUhLBw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] scsi: message: fusion: Mark mpt_halt_firmware()
 __noreturn
Cc:     kernel test robot <lkp@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <d8129817423422355bf30e90dadc6764261b53e0.1681342859.git.jpoimboe@kernel.org>
References: <d8129817423422355bf30e90dadc6764261b53e0.1681342859.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168172840572.404.16516527452411089196.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     6e36a56a5f617262c0e8ae7e961487361c720b9e
Gitweb:        https://git.kernel.org/tip/6e36a56a5f617262c0e8ae7e961487361c720b9e
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 12 Apr 2023 16:49:40 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Apr 2023 17:31:27 +02:00

scsi: message: fusion: Mark mpt_halt_firmware() __noreturn

mpt_halt_firmware() doesn't return.  Mark it as such.

Fixes the following warnings:

  vmlinux.o: warning: objtool: mptscsih_abort+0x7f4: unreachable instruction
  vmlinux.o: warning: objtool: mptctl_timeout_expired+0x310: unreachable instruction

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Mark Rutland <mark.rutland@arm.com>
Debugged-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/d8129817423422355bf30e90dadc6764261b53e0.1681342859.git.jpoimboe@kernel.org
---
 drivers/message/fusion/mptbase.c | 2 +-
 drivers/message/fusion/mptbase.h | 2 +-
 tools/objtool/check.c            | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 9b3ba2d..4f0afce 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -6935,7 +6935,7 @@ EXPORT_SYMBOL(mpt_clear_taskmgmt_in_progress_flag);
  *	@ioc: Pointer to MPT_ADAPTER structure
  *
  **/
-void
+void __noreturn
 mpt_halt_firmware(MPT_ADAPTER *ioc)
 {
 	u32	 ioc_raw_state;
diff --git a/drivers/message/fusion/mptbase.h b/drivers/message/fusion/mptbase.h
index 4bd0682..0f226cd 100644
--- a/drivers/message/fusion/mptbase.h
+++ b/drivers/message/fusion/mptbase.h
@@ -945,7 +945,7 @@ extern int	mpt_raid_phys_disk_get_num_paths(MPT_ADAPTER *ioc,
 		u8 phys_disk_num);
 extern int	 mpt_set_taskmgmt_in_progress_flag(MPT_ADAPTER *ioc);
 extern void	 mpt_clear_taskmgmt_in_progress_flag(MPT_ADAPTER *ioc);
-extern void     mpt_halt_firmware(MPT_ADAPTER *ioc);
+extern void __noreturn mpt_halt_firmware(MPT_ADAPTER *ioc);
 
 
 /*
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 724a63b..e1b01ea 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -219,6 +219,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"lbug_with_loc",
 		"machine_real_restart",
 		"make_task_dead",
+		"mpt_halt_firmware",
 		"nmi_panic_self_stop",
 		"panic",
 		"panic_smp_self_stop",
