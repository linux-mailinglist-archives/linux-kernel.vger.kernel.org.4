Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0536970F8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjBNW43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjBNW40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:56:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C6D28D00;
        Tue, 14 Feb 2023 14:56:24 -0800 (PST)
Date:   Tue, 14 Feb 2023 22:56:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676415382;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F/EyZtc/c4hULHkzUWu3gLrNDX4NGHDqf7vxGPy2BCQ=;
        b=JTVFvuwU0aYI15OKztuXlSY5Zn6fPvKrT5/s6UP6VyIV0/M5oBP8NBL91YBna9pW1oRGKC
        M9UIkyHU2KoitPVARKKnUGEUf7q7SjWS9pHpnm0CHJb+R5ik40zpFEojbxI3x2WELf/bcj
        MXyvRmzLNmAmhqMBHD6i6LcNgxldDShTZpia5gJ4x3aX0papVtDHgBM0wTzcpVCAv/UU/H
        qQ4m5Y1rkLvL3EGwlVlZpoARxMZg9nJ70bGhvnv5Ho0Swh+cG/hoYXcatpwI9U5nth933d
        QDiA6Zf8MqOOQ3FM1RPPfldpH4i18PEpYMsnJLY8/KwFTOEHgvBov51ALxqQPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676415382;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F/EyZtc/c4hULHkzUWu3gLrNDX4NGHDqf7vxGPy2BCQ=;
        b=FdKkpmd6Vl01v2MUrlXi38TF1la6Ov1yO5PXcE+QwYxJ9xYhpL6QVuogIMpgvp646C+zVw
        hset+cBK3FjlYZBg==
From:   "tip-bot2 for Srivatsa S. Bhat (VMware)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/hotplug: Remove incorrect comment about
 mwait_play_dead()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230128003751.141317-1-srivatsa@csail.mit.edu>
References: <20230128003751.141317-1-srivatsa@csail.mit.edu>
MIME-Version: 1.0
Message-ID: <167641538169.4906.16439407610502454489.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     fcb3a81d221750d2a54b4e3a82b3efbbeab8780c
Gitweb:        https://git.kernel.org/tip/fcb3a81d221750d2a54b4e3a82b3efbbeab8780c
Author:        Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
AuthorDate:    Fri, 27 Jan 2023 16:37:51 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 14 Feb 2023 23:44:34 +01:00

x86/hotplug: Remove incorrect comment about mwait_play_dead()

The comment that says mwait_play_dead() returns only on failure is a bit
misleading because mwait_play_dead() could actually return for valid
reasons (such as mwait not being supported by the platform) that do not
indicate a failure of the CPU offline operation. So, remove the comment.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230128003751.141317-1-srivatsa@csail.mit.edu

---
 arch/x86/kernel/smpboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 55cad72..9013bb2 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1833,7 +1833,7 @@ void native_play_dead(void)
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
 
-	mwait_play_dead();	/* Only returns on failure */
+	mwait_play_dead();
 	if (cpuidle_play_dead())
 		hlt_play_dead();
 }
