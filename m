Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A5A6299A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbiKONHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiKONHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:07:52 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0D012AED;
        Tue, 15 Nov 2022 05:07:51 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bp15so24251879lfb.13;
        Tue, 15 Nov 2022 05:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jit8/LMIi2E2JbS+B0jlbkJrIY5fatnANghVdci0Jow=;
        b=TA1tZ2At0TX0fgo78X2fKrojsqeP0jXwc8xMILewE7h7gBnAqQBf9PmI+wNMvv4QpP
         02hsHLd7H6rr/10x/JUe0EMcD0wirwv4/x9CZbN/Lu91oFIl6D/+6xWmNYEaJMGN990s
         eYuTRXf9+uD10Z0Mr9tiG3qd9ZLYAbHhGjWDmlIHjrplE5pIiBv+FLKpbNbzqJDHzjUj
         EFQ87Bbli6XL52haS29jJy0BJTStwIRkixJaAYYWuiIeiSI0iFpEpIFv7LFnNLxDIflF
         NSjgT7QOKh/ndzTiD3BhkxS8Yot0gSHVICZGa9VH0QHDZB8S9QrFWK4g1JW/hV24Qowr
         dOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jit8/LMIi2E2JbS+B0jlbkJrIY5fatnANghVdci0Jow=;
        b=hjH6SuTnwXBiKpiy7t7WV4zoohKb5usE1Al7PwBIFrXkpyOhXqdpgeAC3gl5tM5qIZ
         PBXyP24bamFOziGp5FN+EuSqbfyLz1CsEVZwKNFGoj0nsjPuj7jgxN7Va32GO5D5XF5l
         78hCnfvqWYE2sWNdlR87wkjhM4lAbIhe5mUgekFortEFkY4nnC7DT8Z/b77PV3OB+foK
         SLu85BBC8suw/XtuapaQFJViExaDH3wr4uZUfBov/qyEH9XqSi+FVrvN3COFlWj5EPTt
         RbeILdYQnYj74U1QWgQ+5+9o7Wmhgq8O6GSRRe3V1VUDYgl2vPUdXyBKCJz01DbCyvfl
         lmOw==
X-Gm-Message-State: ANoB5pnaa2EQVNxE33K8Fzj0521m2TYz4a2KO6GmI8jKe9sWUWOJqMKi
        2jSHJ8cbdEmbZvtOpxGqYJo=
X-Google-Smtp-Source: AA0mqf6lk4j7FNDRj9vujNwx5fO7muYBMA1P6euzRTK5dVLh216qBJCxxpXctQBUezisiCNp3+mzSQ==
X-Received: by 2002:a19:7608:0:b0:497:aa48:8fe7 with SMTP id c8-20020a197608000000b00497aa488fe7mr6320236lff.612.1668517669730;
        Tue, 15 Nov 2022 05:07:49 -0800 (PST)
Received: from pc636 (host-90-235-25-77.mobileonline.telia.com. [90.235.25.77])
        by smtp.gmail.com with ESMTPSA id p7-20020a2eb107000000b0026de0c8098csm2510739ljl.26.2022.11.15.05.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:07:49 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 15 Nov 2022 14:07:47 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
        paulmck@kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu/kfree: Do not request RCU when not needed
Message-ID: <Y3OPI/pWZ5jf4X9y@pc636>
References: <20221109024758.2644936-1-joel@joelfernandes.org>
 <Y2z3Mb3u8bFZ12wY@pc636>
 <CAEXW_YSq89xzgyQ9Tdt1tCqz8VAfzb7kSXVZmnxDuJ65U0UZ3w@mail.gmail.com>
 <Y20EOinwcLSZHmXg@pc638.lan>
 <Y22ry4Q2OY2zovco@google.com>
 <Y3Iyka86FlUh9D1P@pc636>
 <CAEXW_YR8ycdF0Y80p2qKXQm3Qc+XA441jQZ3uiHk=TbaXngNkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YR8ycdF0Y80p2qKXQm3Qc+XA441jQZ3uiHk=TbaXngNkQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 03:49:16PM -0500, Joel Fernandes wrote:
> On Mon, Nov 14, 2022 at 7:20 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
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
> 
> Yes sure, I am doing a run now with my patch. However, I have a
> question -- why do you feel blocking in the kworker is not an issue?
> You are taking a snapshot before queuing the normal kwork and then
> reading the snapshot when the normal kwork runs. Considering it is a
> high priority queue, the delay between when you are taking the
> snapshot, and reading it is likely small so there is a bigger chance
> of blocking in cond_synchronize_rcu(). Did I miss something?
> 
We can wait indeed in the reclaim worker. But the worker does not do any
nasty or extra work here. If there is a need we block and wait. After a
grace period, we are awoken and proceed.

Therefore i do not see the reason in handling two cases:

if (gp_done)
    queue_work();
else
    queue_rcu_work();

it is the same if we just queue the work and check on entry. The current
scenario is: queue the work after a grace period. This is the difference.

Right if the reclaimer was a high prio kthread a time would be shorter. 

In your scenario the time seems even shorter(i have not checked) because
you update a snapshot of krcp each time a kvfree_rcu() is invoked. So
basically even though you have objects whose grace period is passed you
do not separate it anyhow. Because you update the:

krcp->gp_snap = get_state_synchronize_rcu();

too often.

--
Uladzislau Rezki
