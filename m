Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB12E72B55E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 04:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjFLCWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 22:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbjFLCV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 22:21:59 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB4812D
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 19:21:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b3be39e666so5787075ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 19:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686536517; x=1689128517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iX82bm2JR5hf31jvqQXI5M30/jYJ7ofydTO4Qj8cvNo=;
        b=z7erw18PvcrfZfglEVH8DIj5dHPJk0icF8vZvtykLDC0GNcIaU2UJwrY79kmqyA+K9
         fwkBTh0p6r8dn4LxuicxlJ0TAy3OSf063OHtTrXp3fvIkSx6xXVWHYDFJUFz6cn9NEhS
         bNpsVbMB+HqnXhCqnYtM8Bdjht7yrDLLx1+mxGK/Gn4JwfDTq5S+jms/+w5IJMc/vGkf
         zV7pVRjnfKOW5Nzd3MfHDF6m+AUle9t88nBDhU04dQ642zyGgDuCZuGcMkLxu4Psy5XK
         0Wmqvcz1zwy7/omIQzKQUhKuzDdX5t7nqhQuR/qHubhSqbT1EHNJGJ07SiEfj02yQegC
         W8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686536517; x=1689128517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iX82bm2JR5hf31jvqQXI5M30/jYJ7ofydTO4Qj8cvNo=;
        b=ltmjijhD+GH7QKpYA2OdB63iMBlL64tdLiswmG8x41yThBsQM8caziLeYOzjZz+m+C
         DxcYsILLpmKwFlTR3bqlAvqy2/OWCb5jHy+Fvnm1J4QZlfqtvBtp76ef9dxTxsbP39qm
         9MRlr7aU73yIE+DmtSVhttqo9MQ6+NcfrGWfGXp16voEZCZ24ZdcupBrDuyo4s3K6peu
         mk8cc3hHSzomdiBClYYVd46jDlZn/GS9i+kzdHwz2PSQaze9S3J8pnPX9crVB80ULB59
         QBDa2gJClapy3FmKE36keCLo8Y27jF3cmEY30CfyLRFvb7pkzZJjIwaYDhMdEhqudMrx
         dZFA==
X-Gm-Message-State: AC+VfDyiossONMmCiBbQa/7yOgvkybR3FSKWrQoYO9W94klzcfVRtYT4
        xBSWKw8mDne8tHTouRqwwGeagQ==
X-Google-Smtp-Source: ACHHUZ6vhNu3NFgDTmoZTWzNtx+/+VuKS9FEcg8/rZI09qodWnvLKcqYn9rwL0zN8J+JzkHPTy3EfA==
X-Received: by 2002:a17:903:2349:b0:1ad:ea13:1914 with SMTP id c9-20020a170903234900b001adea131914mr5763417plh.30.1686536517551;
        Sun, 11 Jun 2023 19:21:57 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-79-151.pa.nsw.optusnet.com.au. [49.179.79.151])
        by smtp.gmail.com with ESMTPSA id s23-20020a170902989700b001b04772d33esm6914646plp.165.2023.06.11.19.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 19:21:57 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q8XBq-00Ahpl-1K;
        Mon, 12 Jun 2023 12:21:54 +1000
Date:   Mon, 12 Jun 2023 12:21:54 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>, linux-xfs@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [6.5-rc5 regression] core dump hangs (was Re: [Bug report] fstests
 generic/051 (on xfs) hang on latest linux v6.5-rc5+)
Message-ID: <ZIaBQnCKJ6NsqGhd@dread.disaster.area>
References: <20230611124836.whfktwaumnefm5z5@zlang-mailbox>
 <ZIZSPyzReZkGBEFy@dread.disaster.area>
 <20230612015145.GA11441@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612015145.GA11441@frogsfrogsfrogs>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 11, 2023 at 06:51:45PM -0700, Darrick J. Wong wrote:
> On Mon, Jun 12, 2023 at 09:01:19AM +1000, Dave Chinner wrote:
> > On Sun, Jun 11, 2023 at 08:48:36PM +0800, Zorro Lang wrote:
> > > Hi,
> > > 
> > > When I tried to do fstests regression test this weekend on latest linux
> > > v6.5-rc5+ (HEAD=64569520920a3ca5d456ddd9f4f95fc6ea9b8b45), nearly all
> > > testing jobs on xfs hang on generic/051 (more than 24 hours, still blocked).
> > > No matter 1k or 4k blocksize, general disk or pmem dev, or any architectures,
> > > or any mkfs/mount options testing, all hang there.
> > 
> > Yup, I started seeing this on upgrade to 6.5-rc5, too. xfs/079
> > generates it, because the fsstress process is crashing when the
> > XFS filesystems shuts down (maybe a SIGBUS from a mmap page fault?)
> > I don't know how reproducable it is yet; these only showed up in my
> > thrusday night testing so I haven't had a chance to triage it yet.
> > 
> > > Someone console log as below (a bit long), the call trace doesn't contains any
> > > xfs functions, it might be not a xfs bug, but it can't be reproduced on ext4.
> > 
> > AFAICT, the coredump is being done on the root drive (where fsstress
> > is being executed from), not the XFS test/scratch devices that
> > fsstress processes are exercising. I have ext3 root drives for my
> > test machines, so at this point I'm not sure that this is even a
> > filesystem related regression. i.e. it may be a recent regression in
> > the coredump or signal handling code....
> 
> Willy was complaining about the same thing on Friday.  Oddly I've not
> seen any problems with coredumps on 6.4-rc5, so .... <shrug>

A quick check against xfs/179 (the case I was seeing) indicates that
it is a regression between v6.4-rc4 and v6.4-rc5.

Looking at the kernel/ changelog, I'm expecting that it is a
regression introduced by this commit:

commit f9010dbdce911ee1f1af1398a24b1f9f992e0080
Author: Mike Christie <michael.christie@oracle.com>
Date:   Thu Jun 1 13:32:32 2023 -0500

    fork, vhost: Use CLONE_THREAD to fix freezer/ps regression
    
    When switching from kthreads to vhost_tasks two bugs were added:
    1. The vhost worker tasks's now show up as processes so scripts doing
    ps or ps a would not incorrectly detect the vhost task as another
    process.  2. kthreads disabled freeze by setting PF_NOFREEZE, but
    vhost tasks's didn't disable or add support for them.
    
    To fix both bugs, this switches the vhost task to be thread in the
    process that does the VHOST_SET_OWNER ioctl, and has vhost_worker call
    get_signal to support SIGKILL/SIGSTOP and freeze signals. Note that
    SIGKILL/STOP support is required because CLONE_THREAD requires
    CLONE_SIGHAND which requires those 2 signals to be supported.
    
    This is a modified version of the patch written by Mike Christie
    <michael.christie@oracle.com> which was a modified version of patch
    originally written by Linus.
    
    Much of what depended upon PF_IO_WORKER now depends on PF_USER_WORKER.
    Including ignoring signals, setting up the register state, and having
    get_signal return instead of calling do_group_exit.
    
    Tidied up the vhost_task abstraction so that the definition of
    vhost_task only needs to be visible inside of vhost_task.c.  Making
    it easier to review the code and tell what needs to be done where.
    As part of this the main loop has been moved from vhost_worker into
    vhost_task_fn.  vhost_worker now returns true if work was done.
    
    The main loop has been updated to call get_signal which handles
    SIGSTOP, freezing, and collects the message that tells the thread to
    exit as part of process exit.  This collection clears
    __fatal_signal_pending.  This collection is not guaranteed to
    clear signal_pending() so clear that explicitly so the schedule()
    sleeps.
    
    For now the vhost thread continues to exist and run work until the
    last file descriptor is closed and the release function is called as
    part of freeing struct file.  To avoid hangs in the coredump
    rendezvous and when killing threads in a multi-threaded exec.  The
    coredump code and de_thread have been modified to ignore vhost threads.
    
    Remvoing the special case for exec appears to require teaching
    vhost_dev_flush how to directly complete transactions in case
    the vhost thread is no longer running.
    
    Removing the special case for coredump rendezvous requires either the
    above fix needed for exec or moving the coredump rendezvous into
    get_signal.
    
    Fixes: 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
    Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
    Co-developed-by: Mike Christie <michael.christie@oracle.com>
    Signed-off-by: Mike Christie <michael.christie@oracle.com>
    Acked-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

I'm just building a v6.5-rc5 with this one commit reverted to test
it right now.....

<a few minutes later>

Yup, 6.5-rc5 with that patch reverted doesn't hang at all. That's
the problem.

I guess the regression fix needs a regression fix....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
