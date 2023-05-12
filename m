Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B24700B22
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241654AbjELPP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjELPPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:15:24 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E697C559F;
        Fri, 12 May 2023 08:15:17 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 6229F320095C;
        Fri, 12 May 2023 11:15:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 12 May 2023 11:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683904514; x=1683990914; bh=c+
        vlyWuglbTHULoU1IkNs67Ef6TpPir/blzEA1v/RPU=; b=P1/Hnrb29FQuhfzwp6
        pzdydqP8BTsN+RWfnZhYr0wiVdhTXG+uHrv80qRwD54aXSP9f3zri/jiYvjrcMFu
        8dQ92UHBCBFGJqxOH01I/aKnQr7tatvtVSPWwMuKYyZtFrzUoqYjvK/7noGPov1e
        1mc3VF/9zMzT6COQVk3V2R1PhK55/idXI547qz9l5dVWJgAZO33f1kkJ6fNrlMuT
        MGxsUcqBHnkup8RrKSmjvHM9tlW2+Z/6PEEHiuClkAWT6lvsRMFrW936CEYmfCYC
        UqfVJ2VWU5i4XtMCpCfw/KaDVryCAKf4Y1PVE3uKGuIEJEdpBiJd2cw8NxzRCDwU
        6y5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1683904514; x=1683990914; bh=c+vlyWuglbTHU
        LoU1IkNs67Ef6TpPir/blzEA1v/RPU=; b=kAyzZEXNjSoxFemztRRl5ybrx300k
        3eU/ohZpk/W1XYA3VoKtCck+RBgPmzXV6b2RanM5R7KxeqLTQ7O1COyw+1h9ygwu
        TcpTrRrIHMDHX70bpthbkX+DZMXC2fbZkoKlqeKMH+dazzvKvyeneCSrYfSrYdk5
        tTOgFB/MQ8nD/d+UrwGdZ2h2pa6F3CBdcVK/TEUKAFdPiXs1/HNBBdAjl0fvu+Yk
        kYgGU10/Qfr+T/TAhGwB0jRxT4eL63KP74sxexsv8J/DyG3NqFpV4n+DnU6v3UQr
        ppPPPcMVSNhPaizX1ttA6ZVEeGUbeUdSJm6Cw+Pkx7+RyNGW2N2D51fWQ==
X-ME-Sender: <xms:AlheZJAXW76JIGCmZBIlnJ2gSAdQbLqAXLo6ZTORKf9d9gA9HhitqA>
    <xme:AlheZHiEqsRmWMnktDKRzqnXzksRsxHHY0E6iTykgV0BymtlaFXZSPI7_7kxOlIg7
    7PGnDBgqO9G8PkS5r0>
X-ME-Received: <xmr:AlheZEmPnhUBdl3GsTwKJ30H1N2xKk0l4dK6Itr1jHo74UZM4aDl97ZAYOpPZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehtddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepleevudetgefhheekueekhfduffethfehteeftdfhvefgteelvedvudev
    teeufeehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihii
    iigr
X-ME-Proxy: <xmx:AlheZDwEblPRwUVA8Ud7eevHi87b9YNOcdJ0dTZrmSusdrFz70_HsA>
    <xmx:AlheZOR5OYneFkoLtrIk-eqCX12fZ6HCgLVdiViEF1DLUQcu0XJEQw>
    <xmx:AlheZGZaEqih-YGo23TC1TtbSdInYRFiUYi320Y4YN1mg0KJ0drUsQ>
    <xmx:AlheZMdm6WCAWLnHTqHKS0UWKvhQtuPxGAH08QzNzqJbcJICdWcjGg>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 May 2023 11:15:13 -0400 (EDT)
Date:   Fri, 12 May 2023 09:15:11 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tycho Andersen <tandersen@netflix.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] xfs: don't do inodgc work if task is exiting
Message-ID: <ZF5X/8RQSzGMn3aZ@tycho.pizza>
References: <20230511151702.14704-1-tycho@tycho.pizza>
 <20230512000724.GH858799@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512000724.GH858799@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 05:07:24PM -0700, Darrick J. Wong wrote:
> On Thu, May 11, 2023 at 09:17:02AM -0600, Tycho Andersen wrote:
> > From: Tycho Andersen <tandersen@netflix.com>
> > 
> > Similar to 5a8bee63b10f ("fuse: in fuse_flush only wait if someone wants
> > the return code"), we have a task that is stuck that can't be killed, so a
> > pid ns can't exit, wreaking all kinds of havoc:
> > 
> > INFO: task C2 CompilerThre:3546103 blocked for more than 1912 seconds.
> >       Tainted: G           OE     5.15.35netflix-g54efd87a8576 #1
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > task:C2 CompilerThre state:D stack:    0 pid:3546103 ppid:3546047 flags:0x00004222
> > Call Trace:
> >  <TASK>
> >  __schedule+0x2c5/0x8d0
> >  schedule+0x3a/0xa0
> >  schedule_timeout+0x115/0x280
> >  ? __schedule+0x2cd/0x8d0
> >  wait_for_completion+0x9f/0x100
> >  __flush_work+0x161/0x1f0
> >  ? worker_detach_from_pool+0xb0/0xb0
> >  destroy_inode+0x3b/0x70
> >  __dentry_kill+0xcc/0x160
> >  dput+0x141/0x2e0
> >  ovl_destroy_inode+0x15/0x50 [overlay]
> >  destroy_inode+0x3b/0x70
> >  __dentry_kill+0xcc/0x160
> >  dput+0x141/0x2e0
> >  __fput+0xe1/0x250
> >  task_work_run+0x73/0xb0
> >  do_exit+0x37e/0xb80
> >  do_group_exit+0x3a/0xa0
> >  get_signal+0x140/0x870
> >  ? perf_event_groups_first+0x80/0x80
> >  arch_do_signal_or_restart+0xae/0x7c0
> >  ? __x64_sys_futex+0x5e/0x1d0
> >  ? __x64_sys_futex+0x5e/0x1d0
> >  exit_to_user_mode_prepare+0x10f/0x1c0
> >  syscall_exit_to_user_mode+0x26/0x40
> >  do_syscall_64+0x46/0xb0
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > RIP: 0033:0x7f3295cf3cf5
> > RSP: 002b:00007f327c834d00 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> > RAX: fffffffffffffe00 RBX: 00007f32900bde50 RCX: 00007f3295cf3cf5
> > RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f32900bde78
> > RBP: 00007f327c834dd0 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f32900bde74
> > R13: 00007f32900bde78 R14: 00007f32900bde28 R15: 0000000000000000
> >  </TASK>
> > 
> > The bad call path is:
> > 
> > xfs_fs_destroy_inode() ->
> >   xfs_inode_mark_reclaimable ->
> >     xfs_inodegc_queue() ->
> >       xfs_inodegc_want_queue_work()
> >       xfs_inodegc_want_flush_work() ->
> >         flush_work() ->
> >           __flush_work() ->
> >             wait_for_completion()
> > 
> > We can avoid this task getting stuck by just not queuing the gc work from
> > do_exit().
> > 
> > The fact that there's a lockup at all probably indicative of another xfs
> > bug somewhere else that I am still looking for, but we should at least not
> > generate unkillable tasks as a result.
> 
> Yeah, we just added a couple of fixpatches to 6.4 to deal with inodegc
> hangs:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/xfs?id=03e0add80f4cf3f7393edb574eeb3a89a1db7758
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/xfs?id=2254a7396a0ca6309854948ee1c0a33fa4268cec
> 
> If you've got a spare machine and a reproducer, could you try applying
> those two to see if the problem goes away?

Thanks for these. I haven't figured out how to reproduce it on demand,
but I also haven't spent a bunch of time. Maybe we can just apply
these to our kernel and see. I put some stack traces from around the
time when the lockup happens, maybe those will ring a bell?

> If you have online fsck enabled (I hope not in a 5.15 kernel) then
> turn it off or apply:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/xfs?id=2d5f38a31980d7090f5bf91021488dc61a0ba8ee

Yes, we do not have it enabled.

> > Signed-off-by: Tycho Andersen <tandersen@netflix.com>
> > CC: "Eric W. Biederman" <ebiederm@xmission.com>
> > ---
> >  fs/xfs/xfs_icache.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> > index 351849fc18ff..90e94d84f8ad 100644
> > --- a/fs/xfs/xfs_icache.c
> > +++ b/fs/xfs/xfs_icache.c
> > @@ -2011,6 +2011,9 @@ xfs_inodegc_want_queue_work(
> >   *
> >   * Note: If the current thread is running a transaction, we don't ever want to
> >   * wait for other transactions because that could introduce a deadlock.
> > + * If the task is currently exiting there is nobody to wait for
> > + * the flush and it can deadlock, so we should not try to flush in this case
> 
> What do you mean by "there is nobody to wait for"?  The process state
> still exists in the kernel, so the completion should wake up the exiting
> process, right?

Yeah, sloppy language there. The problem is really that we can't kill
this thing when it's locked up like this, since signals have been
disabled. To get rid of these things, we have to evac a whole box,
which is a pretty big hammer.

Everything not stuck in do_exit() is "mostly fine", since it will
still respond well to kill in most cases.

Tycho



INFO: task java:3546393 blocked for more than 1912 seconds.
      Tainted: G           OE     5.15.35netflix-g54efd87a8576 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:skyframe-evalua state:D stack:    0 pid:3546393 ppid:3532734 flags:0x00000220
Call Trace:
 <TASK>
 __schedule+0x2c5/0x8d0
 schedule+0x3a/0xa0
 schedule_timeout+0x115/0x280
 ? xfs_buf_read_map+0x52/0x2e0 [xfs]
 ? xfs_da_read_buf+0xcf/0x120 [xfs]
 __down+0x90/0xe0
 ? down+0x43/0x60
 down+0x43/0x60
 xfs_buf_lock+0x29/0xa0 [xfs]
 xfs_buf_find.isra.34+0x1fd/0x610 [xfs]
 xfs_buf_get_map+0x4c/0x400 [xfs]
 xfs_buf_read_map+0x52/0x2e0 [xfs]
 ? xfs_read_agi+0x8c/0x120 [xfs]
 xfs_trans_read_buf_map+0x223/0x2d0 [xfs]
 ? xfs_read_agi+0x8c/0x120 [xfs]
 xfs_read_agi+0x8c/0x120 [xfs]
 xfs_ialloc_read_agi+0x2a/0x90 [xfs]
 xfs_dialloc+0x1ab/0x680 [xfs]
 ? xfs_trans_reserve_quota_icreate+0x32/0x40 [xfs]
 ? xfs_trans_alloc_icreate+0x75/0xf0 [xfs]
 xfs_create+0x39e/0x5b0 [xfs]
 xfs_generic_create+0x129/0x380 [xfs]
 ? generic_permission+0x27/0x200
 vfs_create+0x12b/0x1c0
 ovl_create_real+0xd7/0x220 [overlay]
 ovl_create_or_link+0x166/0x670 [overlay]
 ? bpf_lsm_path_notify+0x10/0x10
 ? security_inode_alloc+0x4d/0x90
 ? inode_init_always+0x1bc/0x230
 ? alloc_inode+0x31/0xa0
 ? new_inode_pseudo+0x23/0x60
 ovl_create_object+0xe6/0x120 [overlay]
 path_openat+0xe79/0x1050
 do_filp_open+0xc5/0x140
 ? process_backlog+0xd0/0x160
 ? __check_object_size+0xd1/0x1a0
 ? do_sys_openat2+0x23a/0x310
 do_sys_openat2+0x23a/0x310
 do_sys_open+0x57/0x80
 do_syscall_64+0x3a/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f077c4e7274
RSP: 002b:00007f05bc5c2290 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f077c4e7274
RDX: 0000000000000241 RSI: 00007f061400e6b0 RDI: 00000000ffffff9c
RBP: 00007f05bc5c22f0 R08: 0000000000000000 R09: 00000006322fa308
R10: 00000000000001b6 R11: 0000000000000293 R12: 0000000000000000
R13: 00007f061400e6b0 R14: 0000000000000241 R15: 00007f0540002340
 </TASK>
INFO: task git:3543232 blocked for more than 1912 seconds.
      Tainted: G           OE     5.15.35netflix-g54efd87a8576 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:git             state:D stack:    0 pid:3543232 ppid:3543231 flags:0x00000224
Call Trace:
 <TASK>
 __schedule+0x2c5/0x8d0
 schedule+0x3a/0xa0
 schedule_timeout+0x115/0x280
 ? xfs_buf_get_map+0x2cf/0x400 [xfs]
 ? obj_cgroup_charge_pages+0xc3/0x100
 __down+0x90/0xe0
 ? down+0x43/0x60
 down+0x43/0x60
 xfs_buf_lock+0x29/0xa0 [xfs]
 xfs_buf_find.isra.34+0x1fd/0x610 [xfs]
 xfs_buf_get_map+0x4c/0x400 [xfs]
 ? xfs_vn_lookup+0x87/0xa0 [xfs]
 xfs_buf_read_map+0x52/0x2e0 [xfs]
 ? xfs_read_agi+0x8c/0x120 [xfs]
 xfs_trans_read_buf_map+0x223/0x2d0 [xfs]
 ? xfs_read_agi+0x8c/0x120 [xfs]
 xfs_read_agi+0x8c/0x120 [xfs]
 xfs_ialloc_read_agi+0x2a/0x90 [xfs]
 xfs_dialloc+0x1ab/0x680 [xfs]
 ? xfs_trans_reserve_quota_icreate+0x32/0x40 [xfs]
 ? xfs_trans_alloc_icreate+0x75/0xf0 [xfs]
 xfs_create+0x39e/0x5b0 [xfs]
 xfs_generic_create+0x129/0x380 [xfs]
 ? generic_permission+0x27/0x200
 vfs_mkdir+0x123/0x1d0
 ovl_mkdir_real+0x28/0xa0 [overlay]
 ovl_create_real+0x143/0x220 [overlay]
 ovl_create_or_link+0x166/0x670 [overlay]
 ? bpf_lsm_path_notify+0x10/0x10
 ? security_inode_alloc+0x4d/0x90
 ? inode_init_always+0x1bc/0x230
 ? alloc_inode+0x31/0xa0
 ? new_inode_pseudo+0x23/0x60
 ovl_create_object+0xe6/0x120 [overlay]
 vfs_mkdir+0x123/0x1d0
 do_mkdirat+0xfa/0x120
 __x64_sys_mkdir+0x26/0x30
 do_syscall_64+0x3a/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f99dc46bf27
RSP: 002b:00007ffca63aa6a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00007ffca63aa8c0 RCX: 00007f99dc46bf27
RDX: 0000000000000000 RSI: 00000000000001ff RDI: 00005648b2aa2b20
RBP: 00005648b298ba40 R08: 00007ffca63aa5ac R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000018
R13: 000000000000000c R14: 00005648b2aa2b1f R15: 00005648b2af1af0
 </TASK>
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
INFO: task java:3546788 blocked for more than 1912 seconds.
      Tainted: G           OE     5.15.35netflix-g54efd87a8576 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:java            state:D stack:    0 pid:3546788 ppid:3546785 flags:0x00000220
Call Trace:
 <TASK>
 __schedule+0x2c5/0x8d0
 schedule+0x3a/0xa0
 schedule_timeout+0x115/0x280
 __down+0x90/0xe0
 ? down+0x43/0x60
 down+0x43/0x60
 xfs_buf_lock+0x29/0xa0 [xfs]
 xfs_buf_find.isra.34+0x1fd/0x610 [xfs]
 xfs_buf_get_map+0x4c/0x400 [xfs]
 xfs_buf_read_map+0x52/0x2e0 [xfs]
 ? xfs_read_agi+0x8c/0x120 [xfs]
 xfs_trans_read_buf_map+0x223/0x2d0 [xfs]
 ? xfs_read_agi+0x8c/0x120 [xfs]
 xfs_read_agi+0x8c/0x120 [xfs]
 xfs_iunlink+0x62/0x1b0 [xfs]
 xfs_remove+0x1f5/0x300 [xfs]
 xfs_vn_unlink+0x55/0xa0 [xfs]
 vfs_unlink+0x11c/0x2a0
 ovl_do_remove+0x3d5/0x4c0 [overlay]
 vfs_unlink+0x11c/0x2a0
 do_unlinkat+0x2ac/0x300
 __x64_sys_unlink+0x1f/0x30
 do_syscall_64+0x3a/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f45d14ad1a7
RSP: 002b:00007f45d1fe3d08 EFLAGS: 00000202 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00007f45c800cbe0 RCX: 00007f45d14ad1a7
RDX: 00007f45c8019e70 RSI: 00007f45c8000030 RDI: 00007f45c800cbe0
RBP: 00007f45d1fe3d30 R08: 0000000000000c70 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000202 R12: 00007f45c8009d80
R13: 00007f45d135c6e0 R14: 00007f45c8009880 R15: 00007f45c800e7c0
 </TASK>
INFO: task kworker/66:1:3548191 blocked for more than 1912 seconds.
      Tainted: G           OE     5.15.35netflix-g54efd87a8576 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/66:1    state:D stack:    0 pid:3548191 ppid:     2 flags:0x00004000
Workqueue: xfs-inodegc/nvme1n1 xfs_inodegc_worker [xfs]
Call Trace:
 <TASK>
 __schedule+0x2c5/0x8d0
 schedule+0x3a/0xa0
 schedule_timeout+0x115/0x280
 __down+0x90/0xe0
 ? down+0x43/0x60
 down+0x43/0x60
 xfs_buf_lock+0x29/0xa0 [xfs]
 xfs_buf_find.isra.34+0x1fd/0x610 [xfs]
 xfs_buf_get_map+0x4c/0x400 [xfs]
 xfs_buf_read_map+0x52/0x2e0 [xfs]
 ? xfs_read_agi+0x8c/0x120 [xfs]
 xfs_trans_read_buf_map+0x223/0x2d0 [xfs]
 ? xfs_read_agi+0x8c/0x120 [xfs]
 xfs_read_agi+0x8c/0x120 [xfs]
 xfs_iunlink_remove+0x5a/0x220 [xfs]
 xfs_ifree+0x7a/0x4c0 [xfs]
 ? xfs_trans_alloc+0xec/0x1e0 [xfs]
 xfs_inactive_ifree+0xa1/0x1a0 [xfs]
 xfs_inactive+0xf1/0x170 [xfs]
 xfs_inodegc_worker+0x76/0x100 [xfs]
 process_one_work+0x200/0x3d0
 worker_thread+0x2d/0x3e0
 ? process_one_work+0x3d0/0x3d0
 kthread+0x11a/0x140
 ? set_kthread_struct+0x40/0x40
 ret_from_fork+0x22/0x30
 </TASK>
INFO: task python3.7:3548278 blocked for more than 1912 seconds.
      Tainted: G           OE     5.15.35netflix-g54efd87a8576 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:python3.7       state:D stack:    0 pid:3548278 ppid:3548276 flags:0x00000224
Call Trace:
 <TASK>
 __schedule+0x2c5/0x8d0
 schedule+0x3a/0xa0
 rwsem_down_write_slowpath+0x237/0x550
 ? do_unlinkat+0x125/0x300
 do_unlinkat+0x125/0x300
 __x64_sys_unlink+0x1f/0x30
 do_syscall_64+0x3a/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f06794fa1a7
RSP: 002b:00007ffca979e3b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00000000018f1380 RCX: 00007f06794fa1a7
RDX: 00007f067b8f7bc0 RSI: 00007f067818fb10 RDI: 00007f067818fb10
RBP: 00000000ffffff9c R08: 0000000000000000 R09: 00007f067b411fc3
R10: 00007f067b35fd50 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000001db7678 R14: 0000000000000082 R15: 0000000000000000
 </TASK>
INFO: task python3.7:3548500 blocked for more than 1912 seconds.
      Tainted: G           OE     5.15.35netflix-g54efd87a8576 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:python3.7       state:D stack:    0 pid:3548500 ppid:3548349 flags:0x00000224
Call Trace:
 <TASK>
 __schedule+0x2c5/0x8d0
 schedule+0x3a/0xa0
 schedule_timeout+0x115/0x280
 __down+0x90/0xe0
 ? down+0x43/0x60
 down+0x43/0x60
 xfs_buf_lock+0x29/0xa0 [xfs]
 xfs_buf_find.isra.34+0x1fd/0x610 [xfs]
 xfs_buf_get_map+0x4c/0x400 [xfs]
 xfs_buf_read_map+0x52/0x2e0 [xfs]
 ? xfs_read_agi+0x8c/0x120 [xfs]
 xfs_trans_read_buf_map+0x223/0x2d0 [xfs]
 ? xfs_read_agi+0x8c/0x120 [xfs]
 xfs_read_agi+0x8c/0x120 [xfs]
 xfs_ialloc_read_agi+0x2a/0x90 [xfs]
 xfs_dialloc+0x1ab/0x680 [xfs]
 ? xfs_trans_reserve_quota_icreate+0x32/0x40 [xfs]
 ? xfs_trans_alloc_icreate+0x75/0xf0 [xfs]
 xfs_create+0x39e/0x5b0 [xfs]
 xfs_generic_create+0x129/0x380 [xfs]
 ? generic_permission+0x184/0x200
 vfs_mkdir+0x123/0x1d0
 ovl_mkdir_real+0x28/0xa0 [overlay]
 ovl_create_real+0x143/0x220 [overlay]
 ovl_create_or_link+0x166/0x670 [overlay]
 ? bpf_lsm_path_notify+0x10/0x10
 ? security_inode_alloc+0x4d/0x90
 ? inode_init_always+0x1bc/0x230
 ? alloc_inode+0x31/0xa0
 ? new_inode_pseudo+0x23/0x60
 ovl_create_object+0xe6/0x120 [overlay]
 vfs_mkdir+0x123/0x1d0
 do_mkdirat+0xfa/0x120
 __x64_sys_mkdir+0x26/0x30
 do_syscall_64+0x3a/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f375aad1f27
RSP: 002b:00007ffc07169838 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 00007f375aad1f27
RDX: 00007f375ced1bc0 RSI: 00000000000001c0 RDI: 00007f3759584750
RBP: 00000000000001c0 R08: 0000000000000000 R09: 00007f375c9ebebc
R10: 00007ffc071694f0 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000011e8160 R14: 0000000000acb0a0 R15: 0000000000000000
 </TASK>
INFO: task exe:3548515 blocked for more than 1912 seconds.
      Tainted: G           OE     5.15.35netflix-g54efd87a8576 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:exe             state:D stack:    0 pid:3548515 ppid: 23215 flags:0x00000000
Call Trace:
 <TASK>
 __schedule+0x2c5/0x8d0
 schedule+0x3a/0xa0
 schedule_timeout+0x115/0x280
 ? ___perf_sw_event+0x11f/0x150
 __down+0x90/0xe0
 ? down+0x43/0x60
 down+0x43/0x60
 xfs_buf_lock+0x29/0xa0 [xfs]
 xfs_buf_find.isra.34+0x1fd/0x610 [xfs]
 xfs_buf_get_map+0x4c/0x400 [xfs]
 xfs_buf_read_map+0x52/0x2e0 [xfs]
 ? xfs_read_agi+0x8c/0x120 [xfs]
 xfs_trans_read_buf_map+0x223/0x2d0 [xfs]
 ? xfs_read_agi+0x8c/0x120 [xfs]
 xfs_read_agi+0x8c/0x120 [xfs]
 xfs_ialloc_read_agi+0x2a/0x90 [xfs]
 xfs_dialloc+0x1ab/0x680 [xfs]
 ? xfs_trans_reserve_quota_icreate+0x32/0x40 [xfs]
 ? xfs_trans_alloc_icreate+0x75/0xf0 [xfs]
 xfs_create+0x39e/0x5b0 [xfs]
 xfs_generic_create+0x129/0x380 [xfs]
 ? generic_permission+0xf3/0x200
 vfs_mkdir+0x123/0x1d0
 ovl_mkdir_real+0x28/0xa0 [overlay]
 ovl_create_real+0x143/0x220 [overlay]
 ovl_create_or_link+0x166/0x670 [overlay]
 ? bpf_lsm_path_notify+0x10/0x10
 ? security_inode_alloc+0x4d/0x90
 ? inode_init_always+0x1bc/0x230
 ? alloc_inode+0x31/0xa0
 ? new_inode_pseudo+0x23/0x60
 ovl_create_object+0xe6/0x120 [overlay]
 vfs_mkdir+0x123/0x1d0
 do_mkdirat+0xfa/0x120
 __x64_sys_mkdirat+0x28/0x30
 do_syscall_64+0x3a/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x560269a7fdfb
RSP: 002b:000000c00079fc08 EFLAGS: 00000216 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 000000c000081800 RCX: 0000560269a7fdfb
RDX: 00000000000001c0 RSI: 000000c000ab2480 RDI: ffffffffffffff9c
RBP: 000000c00079fc68 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000216 R12: 0000000000000000
R13: 0000000000000001 R14: 000000000000000a R15: ffffffffffffffff
 </TASK>
INFO: task bazelenv:3548683 blocked for more than 1912 seconds.
      Tainted: G           OE     5.15.35netflix-g54efd87a8576 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:bazelenv        state:D stack:    0 pid:3548683 ppid:3435211 flags:0x00000220
Call Trace:
 <TASK>
 __schedule+0x2c5/0x8d0
 schedule+0x3a/0xa0
 schedule_timeout+0x115/0x280
 __down+0x90/0xe0
 ? down+0x43/0x60
 down+0x43/0x60
 xfs_buf_lock+0x29/0xa0 [xfs]
 xfs_buf_find.isra.34+0x1fd/0x610 [xfs]
 xfs_buf_get_map+0x4c/0x400 [xfs]
 xfs_buf_read_map+0x52/0x2e0 [xfs]
 ? xfs_read_agf+0x84/0x100 [xfs]
 xfs_trans_read_buf_map+0x223/0x2d0 [xfs]
 ? xfs_read_agf+0x84/0x100 [xfs]
 xfs_read_agf+0x84/0x100 [xfs]
 xfs_alloc_read_agf+0x3a/0x1b0 [xfs]
 xfs_alloc_fix_freelist+0x434/0x500 [xfs]
 ? __kmalloc+0x3c0/0x400
 ? xfs_dquot_to_disk+0xfe/0x110 [xfs]
 ? xfs_qm_dquot_logitem_format+0x89/0x150 [xfs]
 xfs_free_extent_fix_freelist+0x61/0xa0 [xfs]
 __xfs_free_extent+0x6a/0x1c0 [xfs]
 xfs_trans_free_extent+0x3b/0xd0 [xfs]
 xfs_extent_free_finish_item+0x23/0x40 [xfs]
 xfs_defer_finish_noroll+0x24b/0x5a0 [xfs]
 xfs_defer_finish+0x13/0x80 [xfs]
 xfs_itruncate_extents_flags+0x13b/0x220 [xfs]
 xfs_setattr_size+0x35c/0x3d0 [xfs]
 ? aa_compute_fperms+0x16f/0x190
 xfs_vn_setattr+0xf7/0x110 [xfs]
 notify_change+0x355/0x4a0
 ? tomoyo_init_request_info+0x7c/0x90
 ? ovl_setattr+0xd1/0x1b0 [overlay]
 ovl_setattr+0xd1/0x1b0 [overlay]
 notify_change+0x355/0x4a0
 ? do_truncate+0x7c/0xd0
 do_truncate+0x7c/0xd0
 path_openat+0xb94/0x1050
 ? __alloc_pages+0x17f/0x320
 do_filp_open+0xc5/0x140
 ? __check_object_size+0xd1/0x1a0
 ? do_sys_openat2+0x23a/0x310
 do_sys_openat2+0x23a/0x310
 do_sys_open+0x57/0x80
 do_syscall_64+0x3a/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f94a252f000
RSP: 002b:00007ffeaa4d0e50 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000055ecddc90420 RCX: 00007f94a252f000
RDX: 0000000000000241 RSI: 000055ecddc8db60 RDI: 00000000ffffff9c
RBP: 00007ffeaa4d0eb0 R08: 0000000000000020 R09: 0000000000000000
R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000003 R14: 0000000000000001 R15: 000055ecddc8db60
 </TASK>
INFO: task journalctl:3549038 blocked for more than 1912 seconds.
      Tainted: G           OE     5.15.35netflix-g54efd87a8576 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:journalctl      state:D stack:    0 pid:3549038 ppid:469330 flags:0x00000224
Call Trace:
 <TASK>
 __schedule+0x2c5/0x8d0
 schedule+0x3a/0xa0
 schedule_timeout+0x115/0x280
 ? __traceiter_sched_wakeup+0x29/0x40
 ? ttwu_do_wakeup+0x106/0x170
 wait_for_completion+0x9f/0x100
 __flush_work+0x161/0x1f0
 ? worker_detach_from_pool+0xb0/0xb0
 xfs_inodegc_flush.part.25+0x4f/0xa0 [xfs]
 xfs_fs_statfs+0x35/0x1e0 [xfs]
 statfs_by_dentry+0x67/0x90
 vfs_statfs+0x16/0xd0
 ovl_statfs+0x40/0x70 [overlay]
 statfs_by_dentry+0x67/0x90
 vfs_statfs+0x16/0xd0
 fd_statfs+0x2d/0x60
 __do_sys_fstatfs+0x20/0x50
 do_syscall_64+0x3a/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f81de0c0cf7
RSP: 002b:00007ffc758c49c8 EFLAGS: 00000246 ORIG_RAX: 000000000000008a
RAX: ffffffffffffffda RBX: 000055b2a7d70d20 RCX: 00007f81de0c0cf7
RDX: 000000000000000d RSI: 00007ffc758c49d0 RDI: 0000000000000005
RBP: 0000000000000040 R08: 00007f81ddcc8603 R09: 0000000000000018
R10: 00007f81ddf23760 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00000000ffffffff R15: 0000000000000000
 </TASK>
