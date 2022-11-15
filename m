Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FE4629823
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbiKOMGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbiKOMGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:06:01 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2501613D78;
        Tue, 15 Nov 2022 04:05:12 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id d20so17185083ljc.12;
        Tue, 15 Nov 2022 04:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3EvCa6cklZcleBkPtAW83KAAzvvUfzZuN+g/oi5bp1s=;
        b=K40SJr58G5kItKrjShn3I9/gAUG9y/SeLEozWo0jyXiVHDP0lbc/TP32E6y/iTrPN4
         eARtkyAT+orQGZk4gBGoQDMk34ex2hG+t3wvkvqKstMs4TfhZPNfAGrBU3fOUdV+CM8p
         KTzzxVFZHCNeHkXxACMZydKst3N7JsflXgSs8QMcCw1m8bkpCWQhFQmvJ88oMYUs6GWk
         CGWGdWDoiUCR7Afo6kORS07PLbayTmtScj+AG7l9/+sOtxS+xDHo9KYokAToeDLw/JdQ
         BtbuB8kfpBxtDYPHDFtrgDY16dGL4mwBjUBPEW3DBla90O7Y2EBeVDlnTnmqJNkXvBLs
         jWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3EvCa6cklZcleBkPtAW83KAAzvvUfzZuN+g/oi5bp1s=;
        b=PYJaP3Xb2vtVtlMmNy6sxlxOTkFHWjw0avCAf49sGjhWK6NLmcPWnyG48Bz8U0b+1f
         21qB5enwKrZMu1eGEYR1/zZmIiHcybmRFzvatt0cPPoHwsai9SS6VnrKFFJRgZ7U4JXP
         I7d7t9X0wXZ1VrewIaEVri4BLrLQkma8ZRpCeCBK4l30u6BSbaehJ6TOxYjKSFJSlpE+
         RHZX9u6qy1vG1Hkc/vyNXGbYZmcd8UkU6XzkGjZeV1ylQF3TARiHAJu62qWTfb/rRTr2
         8+xb+Od75Dq9uNnZ9MDSVO3PsVDlnKwlmKgdAlcKgRaMMUWiI7MdtRHieL1MigAvT8hb
         Ou/w==
X-Gm-Message-State: ANoB5pnRqxbNGJ3YVwu0xeCAZSH6tktajdP/XA1GBZA2AJ31i+zrk4Cs
        zz587/ggA8+wvg3T4xczc1MuAC5XbfQ=
X-Google-Smtp-Source: AA0mqf7nnXr/zUzO3pJI10gT7XN5i4OwGyrXzs7SEaBLvLCs/1794UCVHIRD85uExkpFs8yA5/qJgA==
X-Received: by 2002:a05:651c:2203:b0:26f:bda0:cf0d with SMTP id y3-20020a05651c220300b0026fbda0cf0dmr5570405ljq.227.1668513910252;
        Tue, 15 Nov 2022 04:05:10 -0800 (PST)
Received: from pc636 (host-90-235-25-77.mobileonline.telia.com. [90.235.25.77])
        by smtp.gmail.com with ESMTPSA id i20-20020a198c54000000b004aa14caf6e9sm2186738lfj.58.2022.11.15.04.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 04:05:09 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 15 Nov 2022 13:05:07 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu/kfree: Do not request RCU when not needed
Message-ID: <Y3OAc+cBK5Dcky8l@pc636>
References: <20221109024758.2644936-1-joel@joelfernandes.org>
 <Y2z3Mb3u8bFZ12wY@pc636>
 <CAEXW_YSq89xzgyQ9Tdt1tCqz8VAfzb7kSXVZmnxDuJ65U0UZ3w@mail.gmail.com>
 <Y20EOinwcLSZHmXg@pc638.lan>
 <Y22ry4Q2OY2zovco@google.com>
 <Y3Iyka86FlUh9D1P@pc636>
 <20221114161733.GD4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221114161733.GD4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 08:17:33AM -0800, Paul E. McKenney wrote:
> On Mon, Nov 14, 2022 at 01:20:33PM +0100, Uladzislau Rezki wrote:
> > > On Thu, Nov 10, 2022 at 03:01:30PM +0100, Uladzislau Rezki wrote:
> > > > > Hi,
> > > > > 
> > > > > On Thu, Nov 10, 2022 at 8:05 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > > 
> > > > > > > On ChromeOS, using this with the increased timeout, we see that we
> > > > > > almost always
> > > > > > > never need to initiate a new grace period. Testing also shows this frees
> > > > > > large
> > > > > > > amounts of unreclaimed memory, under intense kfree_rcu() pressure.
> > > > > > >
> > > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > > ---
> > > > > > > v1->v2: Same logic but use polled grace periods instead of sampling
> > > > > > gp_seq.
> > > > > > >
> > > > > > >  kernel/rcu/tree.c | 8 +++++++-
> > > > > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > > index 591187b6352e..ed41243f7a49 100644
> > > > > > > --- a/kernel/rcu/tree.c
> > > > > > > +++ b/kernel/rcu/tree.c
> > > > > > > @@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
> > > > > > >
> > > > > > >  /**
> > > > > > >   * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace
> > > > > > period
> > > > > > > + * @gp_snap: The GP snapshot recorded at the last scheduling of monitor
> > > > > > work.
> > > > > > >   * @head: List of kfree_rcu() objects not yet waiting for a grace period
> > > > > > >   * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a
> > > > > > grace period
> > > > > > >   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a
> > > > > > grace period
> > > > > > > @@ -2964,6 +2965,7 @@ struct kfree_rcu_cpu {
> > > > > > >       struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> > > > > > >       raw_spinlock_t lock;
> > > > > > >       struct delayed_work monitor_work;
> > > > > > > +     unsigned long gp_snap;
> > > > > > >       bool initialized;
> > > > > > >       int count;
> > > > > > >
> > > > > > > @@ -3167,6 +3169,7 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu
> > > > > > *krcp)
> > > > > > >                       mod_delayed_work(system_wq, &krcp->monitor_work,
> > > > > > delay);
> > > > > > >               return;
> > > > > > >       }
> > > > > > > +     krcp->gp_snap = get_state_synchronize_rcu();
> > > > > > >       queue_delayed_work(system_wq, &krcp->monitor_work, delay);
> > > > > > >  }
> > > > > > >
> > > > > > How do you guarantee a full grace period for objects which proceed
> > > > > > to be placed into an input stream that is not yet detached?
> > > > > 
> > > > > 
> > > > > Just replying from phone as I’m OOO today.
> > > > > 
> > > > > Hmm, so you’re saying that objects can be queued after the delayed work has
> > > > > been queued, but processed when the delayed work is run? I’m looking at
> > > > > this code after few years so I may have missed something.
> > > > > 
> > > > > That’s a good point and I think I missed that. I think your version did too
> > > > > but I’ll have to double check.
> > > > > 
> > > > > The fix then is to sample the clock for the latest object queued, not for
> > > > > when the delayed work is queued.
> > > > > 
> > > > The patch i sent gurantee it. Just in case see v2:
> > > 
> > > You are right and thank you! CBs can be queued while the monitor timer is in
> > > progress. So we need to sample unconditionally. I think my approach is still
> > > better since I take advantage of multiple seconds (I update snapshot on every
> > > CB queue monitor and sample in the monitor handler).
> > > 
> > > Whereas your patch is snapshotting before queuing the regular work and when
> > > the work is executed (This is a much shorter duration and I bet you would be
> > > blocking in cond_synchronize..() more often).
> > > 
> > There is a performance test that measures a taken time and memory
> > footprint, so you can do a quick comparison. A "rcutorture" can be
> > run with various parameters to figure out if a patch that is in question
> > makes any difference.
> > 
> > Usually i run it as:
> > 
> > <snip>
> > #! /usr/bin/env bash
> > 
> > LOOPS=10
> > 
> > for (( i=0; i<$LOOPS; i++ )); do
> >         tools/testing/selftests/rcutorture/bin/kvm.sh --memory 10G --torture rcuscale --allcpus --duration 1 \
> >         --kconfig CONFIG_NR_CPUS=64 \
> >         --kconfig CONFIG_RCU_NOCB_CPU=y \
> >         --kconfig CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y \
> >         --kconfig CONFIG_RCU_LAZY=n \
> >         --bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot" --trust-make
> >         echo "Done $i"
> > done
> > <snip>
> > 
> > just run it from your linux sandbox.
> 
> Would it make sense to modify the "if test "$do_kvfree" = "yes" code
> in tools/testing/selftests/rcutorture/bin/torture.sh to do something
> like this instead of what it currently does?
> 

<snip>
if test "$do_kvfree" = "yes"
then
        torture_bootargs="rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot"
        torture_set "rcuscale-kvfree" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --memory 2G --trust-make
fi
<snip>

it does almost the same but i add some repeat loops usually to get some
average results.

> Though if so, it would be much faster to use kvm.sh's --buildonly flag
> to build the kernel, then kvm-again.sh to rerun that kernel.
> 
I think can be easily run from the bash in while true; do ... done; script
with a desired number of iteration.

But maybe torture.sh already has it. I mean number of iterations.

--
Uladzislau Rezki
