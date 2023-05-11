Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B536FF5A1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbjEKPRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237687AbjEKPRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:17:43 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB4F1992;
        Thu, 11 May 2023 08:17:42 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 7D09E32005B5;
        Thu, 11 May 2023 11:17:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 May 2023 11:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1683818261; x=1683904661; bh=1KBcMNjElx
        S0tYStsAjRh8dTuKNGBSAOW5dI2XnF5tc=; b=WyeQRbpyqLnZfx0b7Yl02o2r7Y
        T9AF/sk7bE8v69NdozGiXYbZkHr3ptoWyuzepRCk8YO7w3r10MOOlriuvI273gkj
        FWBb4Y5yqVbR6lt9dh0N9wSuYZlJ/3SxAduNYY/z2Ti0Q1yGJwDkEhz1peMqfoiG
        pZEtD2cTgtnvJtAMlumhjbsG5tkW9xkwRKEGRGoOmgUww6HldSJhACxxDKHcOpXn
        WgADEfEArJUlzonxNnjYbq3fLed37dVzkZUZW4gZHUSwFz/n99TBKicMKmLZvfjh
        4QTqE4hKMTTepNEQ7QxN1MS6HnK9KDbefor8Li0c9Um6qlJ3g/oiHOpG5XpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683818261; x=1683904661; bh=1KBcMNjElxS0t
        YStsAjRh8dTuKNGBSAOW5dI2XnF5tc=; b=MdJWHlcvuV8sLmlJt/+1T3hRvpWWG
        BG/Z4bW005ADHXXMTooMnm7EnlP1pXh7Vh+DU316qY6ec7YJBsvt9/dmE4s6HWO8
        KMVtDjiL4zDvIBTrTq0O1FUbuC4eIEOAfn1iYGwGSDx2MItONGBZfzxGOEK1hDtA
        DP1wqujlJC/VMkDZKOHNijEgJttNFZemPl89RoJ4YJda8yZ1v6/smRlRXbFMtuTT
        MrzbYFSGOKPwYbv8MlZiwE6vH8NgxKlU1jhFi186ntUWL/QpdykJIMk1WcokTSe3
        Qz15yX3eoy7pK0D2otBFhbzrOV7wCq6JLJQ6blntF2PoMb+ZNDAedXuaQ==
X-ME-Sender: <xms:FAddZLbdr5KQJuyI3a-Zwa1D7vHLPXkDr9Uzh6AcCMxCx2lK6pIftQ>
    <xme:FAddZKYG0fWRN4iX5HyVng7pZlRg17GhWrYVSraF-lyaftO7Wmmnz2jPqC2VZsuSY
    S80iq3vZ1rYhvV53jc>
X-ME-Received: <xmr:FAddZN9QYYKMm7cXFz5KqH_fj0hOnCfxSq0DzjKiamcHEQBCKOoaqrgTYS5qsZ-yAdBusv_B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegkedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfihtghhohcu
    tehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrfgrth
    htvghrnhepheeffeehleeftdfgjeegheelieefvdfghfeuudeuheehuefhhffhtefhiedv
    geegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
    ihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:FAddZBo1jyavf6q36FIaMaINn5nXJPHGF8Phvv_2Uj2TwUnqJlQUtg>
    <xmx:FAddZGq86tAnuk3TfQEiieQV8eLPM_7x-aSRofS3shVnrbnLnXsdOA>
    <xmx:FAddZHQR2PdVmJwuxqbb01ciikG-YDcLehfVsiMPzDQvlZTw0dQVhg>
    <xmx:FQddZPkZIFfkMSpeuz0zzwLpGAjxEEh1yhiDwVEN_hUIDLixXMVcHg>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 May 2023 11:17:39 -0400 (EDT)
From:   Tycho Andersen <tycho@tycho.pizza>
To:     "Darrick J . Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.pizza>,
        Tycho Andersen <tandersen@netflix.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH] xfs: don't do inodgc work if task is exiting
Date:   Thu, 11 May 2023 09:17:02 -0600
Message-Id: <20230511151702.14704-1-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tycho Andersen <tandersen@netflix.com>

Similar to 5a8bee63b10f ("fuse: in fuse_flush only wait if someone wants
the return code"), we have a task that is stuck that can't be killed, so a
pid ns can't exit, wreaking all kinds of havoc:

INFO: task C2 CompilerThre:3546103 blocked for more than 1912 seconds.
      Tainted: G           OE     5.15.35netflix-g54efd87a8576 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:C2 CompilerThre state:D stack:    0 pid:3546103 ppid:3546047 flags:0x00004222
Call Trace:
 <TASK>
 __schedule+0x2c5/0x8d0
 schedule+0x3a/0xa0
 schedule_timeout+0x115/0x280
 ? __schedule+0x2cd/0x8d0
 wait_for_completion+0x9f/0x100
 __flush_work+0x161/0x1f0
 ? worker_detach_from_pool+0xb0/0xb0
 destroy_inode+0x3b/0x70
 __dentry_kill+0xcc/0x160
 dput+0x141/0x2e0
 ovl_destroy_inode+0x15/0x50 [overlay]
 destroy_inode+0x3b/0x70
 __dentry_kill+0xcc/0x160
 dput+0x141/0x2e0
 __fput+0xe1/0x250
 task_work_run+0x73/0xb0
 do_exit+0x37e/0xb80
 do_group_exit+0x3a/0xa0
 get_signal+0x140/0x870
 ? perf_event_groups_first+0x80/0x80
 arch_do_signal_or_restart+0xae/0x7c0
 ? __x64_sys_futex+0x5e/0x1d0
 ? __x64_sys_futex+0x5e/0x1d0
 exit_to_user_mode_prepare+0x10f/0x1c0
 syscall_exit_to_user_mode+0x26/0x40
 do_syscall_64+0x46/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f3295cf3cf5
RSP: 002b:00007f327c834d00 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f32900bde50 RCX: 00007f3295cf3cf5
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f32900bde78
RBP: 00007f327c834dd0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f32900bde74
R13: 00007f32900bde78 R14: 00007f32900bde28 R15: 0000000000000000
 </TASK>

The bad call path is:

xfs_fs_destroy_inode() ->
  xfs_inode_mark_reclaimable ->
    xfs_inodegc_queue() ->
      xfs_inodegc_want_queue_work()
      xfs_inodegc_want_flush_work() ->
        flush_work() ->
          __flush_work() ->
            wait_for_completion()

We can avoid this task getting stuck by just not queuing the gc work from
do_exit().

The fact that there's a lockup at all probably indicative of another xfs
bug somewhere else that I am still looking for, but we should at least not
generate unkillable tasks as a result.

Signed-off-by: Tycho Andersen <tandersen@netflix.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/xfs/xfs_icache.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 351849fc18ff..90e94d84f8ad 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -2011,6 +2011,9 @@ xfs_inodegc_want_queue_work(
  *
  * Note: If the current thread is running a transaction, we don't ever want to
  * wait for other transactions because that could introduce a deadlock.
+ * If the task is currently exiting there is nobody to wait for
+ * the flush and it can deadlock, so we should not try to flush in this case
+ * either.
  */
 static inline bool
 xfs_inodegc_want_flush_work(
@@ -2021,6 +2024,9 @@ xfs_inodegc_want_flush_work(
 	if (current->journal_info)
 		return false;
 
+	if (current->flags & PF_EXITING)
+		return false;
+
 	if (shrinker_hits > 0)
 		return true;
 

base-commit: 78b421b6a7c6dbb6a213877c742af52330f5026d
-- 
2.34.1

