Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CDC70501C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjEPOA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjEPOA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:00:26 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0271FE3;
        Tue, 16 May 2023 07:00:24 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 536D73200AA3;
        Tue, 16 May 2023 10:00:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 16 May 2023 10:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684245621; x=1684332021; bh=yh
        N5KqGWPRAalW32v42e9ah6iyUD8OWA7NQZxuoW7+4=; b=Z/TS7CJM0LJLHa3Fsp
        D5wlmuT8Z6KenkGNLk4AAi9hXVxRVIXe/99H85lvWH0/w3ifHej51iC1giGcs2xa
        tDZ+MepojsmmmMkuaDFN9eKrgw+W9TVudS+o7X4pqFsI54FS+w0gUysO2sZdix25
        lzrxtyIF35vjV/V2ntou4vrSx7nGpsuJd+yUDB5MEaNoJRaksnKrzi1accwapgiX
        CpBzb9L/fYyrEWG39A7t3ZbkXJNUsWJzMLYzFR2KZbkPX9tXcg3hV7PjEs5Km1XN
        T7b2Awvntk64XtSfYEaqv9eMo0/jg7+bSaQtsKOadIGjRI/gLttKOm05Xa0SAsHX
        SJHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684245621; x=1684332021; bh=yhN5KqGWPRAal
        W32v42e9ah6iyUD8OWA7NQZxuoW7+4=; b=YV5gWwV0K6jWLfeL3jkOJtyx0dO3z
        M55sWqW6BXL/hWbcjrGYzW68ZhYldSBKkeSBkLGuEABNJppEnHZRhGT/3MY+J47y
        MDOQtxjwG3QKi3QKBbz6y19QNgtYSuGs6fp8tEoNP7/HRewwBXxJS0VLu1RBFcsh
        2hPqzow/vs9QmGREZZ8PDcg3xFbPhKgrRx5maZkK/g0D4RKKvi5DLdpOdA+eUFly
        wOBx0e4aAWMWBSDqYtqdGQn73Y/1h4vLK4QNGmwGze59/qJN3LRGgLKwyjvjGvCd
        hbEHBLgU/2Kx1sdSNa5G/5mT/llPuu0MOC1bxpav4FYZ3PdBibTtWgRRw==
X-ME-Sender: <xms:dYxjZCZ7ToVlSSDA-lfdoRql6sTS7XWvhM_VOPO8rvvxSeneicm5og>
    <xme:dYxjZFavDAjclhlzVZtAJGTLGWAzdD4yz-MlGoWHlWvW1Hwb8Gty-o7noO-SLu_we
    GYyiR2ACCn2usgmXo8>
X-ME-Received: <xmr:dYxjZM9DlgH1ci8f_R-u1M25KgdbX7Ys8CbtLExKTlsOdXUYc0AD_6NyMWLMjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehledgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:dYxjZEpFnvc9Gd2sRyGCxWCq1vJ5a6jh5dLyjrdeup8ztIv0iCi9tw>
    <xmx:dYxjZNrAH-mSaSmcqMK8mY4dYq4ODfhnRl02DoU8E-0MvSZEMbAmyA>
    <xmx:dYxjZCSVpx8V4JqOcW_ZLL1A3MZxwfmMrQhWwdlsLv3CY-Gx2TFMkw>
    <xmx:dYxjZOmZJVrvTvAtLPRrAbQpBOR68wyc1k6fyo2TK8DRHvTNFc_gVw>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 May 2023 10:00:19 -0400 (EDT)
Date:   Tue, 16 May 2023 08:00:17 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tycho Andersen <tandersen@netflix.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] xfs: don't do inodgc work if task is exiting
Message-ID: <ZGOMcZAJ/IMdwJrU@tycho.pizza>
References: <20230511151702.14704-1-tycho@tycho.pizza>
 <20230512000724.GH858799@frogsfrogsfrogs>
 <ZF5X/8RQSzGMn3aZ@tycho.pizza>
 <20230512225414.GE3223426@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512225414.GE3223426@dread.disaster.area>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Thanks for this analysis, all very helpful,

On Sat, May 13, 2023 at 08:54:14AM +1000, Dave Chinner wrote:
> On Fri, May 12, 2023 at 09:15:11AM -0600, Tycho Andersen wrote:
> > INFO: task kworker/66:1:3548191 blocked for more than 1912 seconds.
> >       Tainted: G           OE     5.15.35netflix-g54efd87a8576 #1
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > task:kworker/66:1    state:D stack:    0 pid:3548191 ppid:     2 flags:0x00004000
> > Workqueue: xfs-inodegc/nvme1n1 xfs_inodegc_worker [xfs]
> > Call Trace:
> >  <TASK>
> >  __schedule+0x2c5/0x8d0
> >  schedule+0x3a/0xa0
> >  schedule_timeout+0x115/0x280
> >  __down+0x90/0xe0
> >  ? down+0x43/0x60
> >  down+0x43/0x60
> >  xfs_buf_lock+0x29/0xa0 [xfs]
> >  xfs_buf_find.isra.34+0x1fd/0x610 [xfs]
> >  xfs_buf_get_map+0x4c/0x400 [xfs]
> >  xfs_buf_read_map+0x52/0x2e0 [xfs]
> >  ? xfs_read_agi+0x8c/0x120 [xfs]
> >  xfs_trans_read_buf_map+0x223/0x2d0 [xfs]
> >  ? xfs_read_agi+0x8c/0x120 [xfs]
> >  xfs_read_agi+0x8c/0x120 [xfs]
> >  xfs_iunlink_remove+0x5a/0x220 [xfs]
> >  xfs_ifree+0x7a/0x4c0 [xfs]
> >  ? xfs_trans_alloc+0xec/0x1e0 [xfs]
> >  xfs_inactive_ifree+0xa1/0x1a0 [xfs]
> >  xfs_inactive+0xf1/0x170 [xfs]
> >  xfs_inodegc_worker+0x76/0x100 [xfs]
> >  process_one_work+0x200/0x3d0
> >  worker_thread+0x2d/0x3e0
> >  ? process_one_work+0x3d0/0x3d0
> >  kthread+0x11a/0x140
> >  ? set_kthread_struct+0x40/0x40
> >  ret_from_fork+0x22/0x30
> >  </TASK>
> 
> Yup, there's the stuck inodegc worker - also trying to get the AGI
> lock doing inode unlink. I'm not surprised at all by this - working
> out why this worker is stuck here is the goal because that is what
> is causing all your flush problems.
> 
> It also gives me a better idea of what the likely issue is, too.
>
> > INFO: task bazelenv:3548683 blocked for more than 1912 seconds.
> >       Tainted: G           OE     5.15.35netflix-g54efd87a8576 #1
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > task:bazelenv        state:D stack:    0 pid:3548683 ppid:3435211 flags:0x00000220
> > Call Trace:
> >  <TASK>
> >  __schedule+0x2c5/0x8d0
> >  schedule+0x3a/0xa0
> >  schedule_timeout+0x115/0x280
> >  __down+0x90/0xe0
> >  ? down+0x43/0x60
> >  down+0x43/0x60
> >  xfs_buf_lock+0x29/0xa0 [xfs]
> >  xfs_buf_find.isra.34+0x1fd/0x610 [xfs]
> >  xfs_buf_get_map+0x4c/0x400 [xfs]
> >  xfs_buf_read_map+0x52/0x2e0 [xfs]
> >  ? xfs_read_agf+0x84/0x100 [xfs]
> >  xfs_trans_read_buf_map+0x223/0x2d0 [xfs]
> >  ? xfs_read_agf+0x84/0x100 [xfs]
> >  xfs_read_agf+0x84/0x100 [xfs]
> >  xfs_alloc_read_agf+0x3a/0x1b0 [xfs]
> >  xfs_alloc_fix_freelist+0x434/0x500 [xfs]
> >  ? __kmalloc+0x3c0/0x400
> >  ? xfs_dquot_to_disk+0xfe/0x110 [xfs]
> >  ? xfs_qm_dquot_logitem_format+0x89/0x150 [xfs]
> >  xfs_free_extent_fix_freelist+0x61/0xa0 [xfs]
> >  __xfs_free_extent+0x6a/0x1c0 [xfs]
> >  xfs_trans_free_extent+0x3b/0xd0 [xfs]
> >  xfs_extent_free_finish_item+0x23/0x40 [xfs]
> >  xfs_defer_finish_noroll+0x24b/0x5a0 [xfs]
> >  xfs_defer_finish+0x13/0x80 [xfs]
> >  xfs_itruncate_extents_flags+0x13b/0x220 [xfs]
> >  xfs_setattr_size+0x35c/0x3d0 [xfs]
> >  ? aa_compute_fperms+0x16f/0x190
> >  xfs_vn_setattr+0xf7/0x110 [xfs]
> 
> And that confirms the suspicions I have - another process blocked on
> an AGF lock. That might be IO it's blocking on here, but combined
> with the inode unlink being stuck in inodegc, I have a suspicion
> that this is an AGF - AGI - inode buffer lock ordering issue.
> 
> There's been a heap of work done in this space since 5.15, and I'd
> suggest that almost none of it is trivially backportable as it's
> deeply intertwined with relatively complex algorithm changes.

Sounds like this is the type of work that might fix the bug? I could
try to convince people to upgrade to 6.1, would that be enough?

> I also recently found evidence of another AGI -> inode buffer -> AGF
> -> inode buffer deadlock issue debugging another hang from a machine
> making heavy use of O_TMPFILEs via OVL.  Without a kernel code to
> examine in intricate detail, I can't say if this is what you are
> seeing.

Ok. I haven't had success reproducing this without overlay in the mix,
but if it could be related I'll give it a shot. Next time we see this
I'll try to grab a kernel core as well.

> I also don't have a fix for that yet because, well, it's complex and
> I can really only accomodate one complex high priority bug at a time
> in my head and it hasn't been my highiest priority. As it is, I
> don't think the fix for it will be trivially backportable to 5.15,
> either....

Yup, no worries.

> > INFO: task journalctl:3549038 blocked for more than 1912 seconds.
> >       Tainted: G           OE     5.15.35netflix-g54efd87a8576 #1
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > task:journalctl      state:D stack:    0 pid:3549038 ppid:469330 flags:0x00000224
> > Call Trace:
> >  <TASK>
> >  __schedule+0x2c5/0x8d0
> >  schedule+0x3a/0xa0
> >  schedule_timeout+0x115/0x280
> >  ? __traceiter_sched_wakeup+0x29/0x40
> >  ? ttwu_do_wakeup+0x106/0x170
> >  wait_for_completion+0x9f/0x100
> >  __flush_work+0x161/0x1f0
> >  ? worker_detach_from_pool+0xb0/0xb0
> >  xfs_inodegc_flush.part.25+0x4f/0xa0 [xfs]
> >  xfs_fs_statfs+0x35/0x1e0 [xfs]
> >  statfs_by_dentry+0x67/0x90
> >  vfs_statfs+0x16/0xd0
> >  ovl_statfs+0x40/0x70 [overlay]
> 
> Fixed by commit 5e672cd69f0a ("xfs: introduce xfs_inodegc_push()")
> which also means that the commits Darrick suggested you try aren't
> relevant. The mod_delayed_work() issues they address weren't
> introduced until commit 7cf2b0f9611b ("xfs: bound maximum wait time
> for inodegc work") which has a direct dependency on 5e672cd69f0a
> being present....

Thanks, this looks like a useful patch. I wonder if we could do the
same thing when PF_EXITING, instead of just avoid queuing work at all?
We tend to get complaints about tasks in weird states when we block in
do_exit() for any nontrivial length of time.

In any case, looks like this backports pretty cleanly to 5.15, so I'll
put it in our kernels for now.

Thanks again for your help.

Tycho
