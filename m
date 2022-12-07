Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13166646434
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 23:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiLGWmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 17:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGWmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 17:42:14 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494158566A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 14:42:13 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id q1so17650514pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 14:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uaKfifrJZK97daCe72D9/Gb5Lld6G4q6AB5r5eFaeng=;
        b=dn8hBayyXUsKjEVEx5dDu08340dzvh7FkXff2++s3jpKZMNNstIRA9DM1fRczHAEOk
         CZIUbvCf3i2emcPyRLTFr/PQux85J9c4guugGSnQEXZFo1i68RVRGl9Zin3WpcXgQCwH
         NgOKeJKfYOBvTp8MZUHSXVUJSMePZvsbr7miOQx1wD1p75MZx71vO1/FZrE9g6NSiGA5
         veV9HrQrtU8tWnv9Ele5g4Ct4E0Ig1ggdlwQPcYycsm+W5DmikR4DqrXuUcTplq3TF6M
         +8LsTsVKAiPFBrgZ4l2eK7TvgXxAgtvz7sOQXWSJPurPQ3et2tM8NGEv3HjuJ/TcihPq
         K29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uaKfifrJZK97daCe72D9/Gb5Lld6G4q6AB5r5eFaeng=;
        b=0Kn2RVSkregqDxeg+5pCmLL1EI6BLtWo18Dsf1uTLGDovqg5rXHxIavze22qhcekF4
         oRdsHV5T+4iDQLyWFlXFDIKFZwl5TXjdrCAG2LG4eYaXL/24Ds6E3R6MbY63DN/2hLip
         ujXrVLfD4ePImBv2iLDgI7ra2Q/v148l8kggSyQVIDTtu6xv6B3XY6oTu65nL1qWnJbM
         XpIJHMrap8QVwbMByDu55TuL2P2faKM2LiHRiV71ZQKBFSZXQTrBUurUHy1qc8Whu8vV
         0LN6/XOvtoG+Z6ZUqdsLKfBrrJVXmzObLV0BiYQg385kyY20cJcgEOirVNufuU+8chIv
         CFPg==
X-Gm-Message-State: ANoB5pnjLWE1CeF1lzfYhi9snNf8iJzRn5bu2UoLffEcwi5Fqcyed1Ho
        /LB6LXedvEk6/gAOFilVJjQb++ozNe3yC90uWfdtrg==
X-Google-Smtp-Source: AA0mqf6dvrG55NohnKYLjhsioiiUtIObh6VFX65KBGhcOhsxPu2KKsydYRNLcO2j00NQid2OWiRtLZLjB60G0oS7PqM=
X-Received: by 2002:a63:c143:0:b0:45b:f8be:7400 with SMTP id
 p3-20020a63c143000000b0045bf8be7400mr68182432pgi.30.1670452932521; Wed, 07
 Dec 2022 14:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20221123012104.3317665-1-joel@joelfernandes.org>
 <20221123012104.3317665-3-joel@joelfernandes.org> <20221207221423.GH4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQrdBsC0xKNSu-Y9wN5W4YOrQEHrKVCfxEJRtJVArk6vA@mail.gmail.com>
In-Reply-To: <CAEXW_YQrdBsC0xKNSu-Y9wN5W4YOrQEHrKVCfxEJRtJVArk6vA@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Wed, 7 Dec 2022 22:42:01 +0000
Message-ID: <CAJWu+opNvnOW=Gda6LiujPDX4yjYO0UJx9win24D7QvnVqNzNQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] locktorture: Allow non-rtmutex lock types to be boosted
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 10:23 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> Hi Paul,
>
> On Wed, Dec 7, 2022 at 10:14 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Nov 23, 2022 at 01:21:03AM +0000, Joel Fernandes (Google) wrote:
> > > Currently RT boosting is only done for rtmutex_lock, however with proxy
> > > execution, we also have the mutex_lock participating in priorities. To
> > > exercise the testing better, add RT boosting to other lock testing types
> > > as well, using a new knob (rt_boost).
> > >
> > > Tested with boot parameters:
> > > locktorture.torture_type=mutex_lock
> > > locktorture.onoff_interval=1
> > > locktorture.nwriters_stress=8
> > > locktorture.stutter=0
> > > locktorture.rt_boost=1
> > > locktorture.rt_boost_factor=1
> > > locktorture.nlocks=3
> > >
> > > For the rtmutex test, rt_boost is always enabled even if disabling is
> > > requested.
> > >
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/locking/locktorture.c | 91 +++++++++++++++++++-----------------
> > >  1 file changed, 48 insertions(+), 43 deletions(-)
> > >
> > > diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> > > index bc3557677eed..5a388ac96a9b 100644
> > > --- a/kernel/locking/locktorture.c
> > > +++ b/kernel/locking/locktorture.c
> > > @@ -46,6 +46,7 @@ torture_param(int, shutdown_secs, 0, "Shutdown time (j), <= zero to disable.");
> > >  torture_param(int, stat_interval, 60,
> > >            "Number of seconds between stats printk()s");
> > >  torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
> > > +torture_param(int, rt_boost, 0, "Perform an rt-boost from the writer, always 1 for rtmutex_lock");
> > >  torture_param(int, verbose, 1,
> > >            "Enable verbose debugging printk()s");
> > >  torture_param(int, nlocks, 1,
> > > @@ -129,15 +130,44 @@ static void torture_lock_busted_write_unlock(int tid __maybe_unused)
> > >         /* BUGGY, do not use in real life!!! */
> > >  }
> > >
> > > -static void torture_boost_dummy(struct torture_random_state *trsp)
> >
> > We no longer have torture_boot_dummy().  Is the point that the
> > "spinlocks" to priority boosting in PREEMPT_RT kernels?  If so,
> > would it make sense to do something like this for spinlock?
> >
> >         .task_boost     = IS_ENABLED(CONFIG_PREEMPT_RT) ? torture_rt_boost : torture_boost_dummy,
> >
> > Or maybe using a similar approach for the default value of the rt_boost
> > module parameter?
> >
> > Or is there some benefit of priority boosting for spinlocks even in
> > non-PREEMPT_RT kernels that I am missing?
>
> There are 2 advantages as far as I can see:
>
> 1. The shuffle thread which ends up in setscheduler exercises the same
> path as the rt mutex boost, so that would test races with that and the
> boost path.

I was too hasty in my reply, I meant here the thread's "RT boost"
racing with other paths such as migration / schedule() / other
setscheduler() paths.

Obviously rtmutex boost does not happen when there is no rtmutex to begin with.

Thanks,

  - Joel


>
> >
> >                                                         Thanx, Paul
> >
> > >       .writelock      = torture_rtmutex_lock,
> > >       .write_delay    = torture_rtmutex_delay,
> > > -     .task_boost     = torture_rtmutex_boost,
> > > +     .task_boost     = torture_rt_boost,
> > >       .writeunlock    = torture_rtmutex_unlock,
> > >       .readlock       = NULL,
> > >       .read_delay     = NULL,
> > > @@ -604,7 +609,7 @@ __releases(torture_rwsem)
> > >  static struct lock_torture_ops rwsem_lock_ops = {
> > >       .writelock      = torture_rwsem_down_write,
> > >       .write_delay    = torture_rwsem_write_delay,
> > > -     .task_boost     = torture_boost_dummy,
> > > +     .task_boost     = torture_rt_boost,
> > >       .writeunlock    = torture_rwsem_up_write,
> > >       .readlock       = torture_rwsem_down_read,
> > >       .read_delay     = torture_rwsem_read_delay,
> > > @@ -656,7 +661,7 @@ static struct lock_torture_ops percpu_rwsem_lock_ops = {
> > >       .exit           = torture_percpu_rwsem_exit,
> > >       .writelock      = torture_percpu_rwsem_down_write,
> > >       .write_delay    = torture_rwsem_write_delay,
> > > -     .task_boost     = torture_boost_dummy,
> > > +     .task_boost     = torture_rt_boost,
> > >       .writeunlock    = torture_percpu_rwsem_up_write,
> > >       .readlock       = torture_percpu_rwsem_down_read,
> > >       .read_delay     = torture_rwsem_read_delay,
> > > --
> > > 2.38.1.584.g0f3c55d4c2-goog
> > >
