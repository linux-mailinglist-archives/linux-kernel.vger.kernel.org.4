Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45792606D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiJUCXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiJUCWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:22:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB22E22C46E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:22:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id k2so3916348ejr.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lx2lPg4xYlyyOY7piY5e3Is2536NPXCIzsL1B5cyMrM=;
        b=Nqwbj4OIvxR5gaelkNE7wpLkSK/aU8o3OSBaSiVuH1O2eqAhn2jk8tOLApGfkJhIpV
         5K6yR6ilB/RQr66VLuv7m6cXiwe5L0ePFPOHrtjkfaW4OY6NlPURH5+9F7IYwuYiCckP
         BnNTbB8Q5KTtYKDcMNiIZPQBxoDSj46RO3rXLn9JKfPtYx/mlnkXJIqPdtMV6VIraSfq
         4+GQ2Kstsi8ydR6cNW8J9z6fnz4l96iOGYLqp9/+0QrCtqqZakKUs5rmIJEtEGmXf5w0
         W/08E+ug3uCjzl07Q1b+bjIwjlQtCSy3ok8G2XBUQr8iiGv3JLO1fuQjmy38bT07fXXV
         pjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lx2lPg4xYlyyOY7piY5e3Is2536NPXCIzsL1B5cyMrM=;
        b=RSiiyUTPZwl7VOZX9hlSniZ64hdfTe6NJ/U7+jYavrMgTXbDVRYGWVDF1mB0Q0dqzE
         ywkBdCICb2voznuuL79LEEr+z1nk5Tp0+nIFDpXkmtyxU/8a6t/Nun14qIbSazP49fqU
         45H04AMc7kqU0f//SbOZU9tH2uJ9b3Cv9qDyNwXaiDZJNFfCZZW7FspYFumYSVBEbIOO
         4HxnnmQC51pi0GpjvUc9WN/SX/Np4pN84xHoPz+UEvt9O5/mVz3j1tHZkZCiVwdfrHwk
         qtBmqeW3fG5qGbJ3/IVN5UUaRhBe1aWRRleOIGymK9UTANFMSQhtbTtYRf2AprOefl8c
         ADJQ==
X-Gm-Message-State: ACrzQf3sINvx1YeQ+2AC4O7O20qCixl5yXU6pVZIAjyMrsh3YwNgNist
        qFYMHlZjJ8gvw+eYqnQrwOlgVWFjSQWwSjzK0YkacQ==
X-Google-Smtp-Source: AMsMyM6Uk3P5CXEJlZ4fLNHlQbkZnIxBMp9PTzHnf82MqscYlZhrGxg2IcU1y/e2BPBXq2/Kl4TvyNO0L9GB1SHqFdQ=
X-Received: by 2002:a17:906:c14f:b0:793:30e1:96be with SMTP id
 dp15-20020a170906c14f00b0079330e196bemr8635613ejc.447.1666318963977; Thu, 20
 Oct 2022 19:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20221003214501.2050087-1-connoro@google.com> <20221003214501.2050087-10-connoro@google.com>
 <xhsmhv8orgb59.mognet@vschneid.remote.csb> <CALE1s+ODz2FUJoSHcORa25kckk81qSHuZ6RSE6-k=s2gzQ+eOQ@mail.gmail.com>
 <xhsmhtu3zwxpt.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmhtu3zwxpt.mognet@vschneid.remote.csb>
From:   "Connor O'Brien" <connoro@google.com>
Date:   Thu, 20 Oct 2022 19:22:32 -0700
Message-ID: <CALE1s+OcUDfpJY991BfDB9mS7t5ZPfdukoD2jRxFBNwOX+hzgQ@mail.gmail.com>
Subject: Re: [RFC PATCH 09/11] sched/rt: Fix proxy/current (push,pull)ability
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
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

On Wed, Oct 19, 2022 at 10:05 AM Valentin Schneider <vschneid@redhat.com> wrote:
>
> On 14/10/22 15:32, Connor O'Brien wrote:
> > On Mon, Oct 10, 2022 at 4:40 AM Valentin Schneider <vschneid@redhat.com> wrote:
> >> Consider:
> >>
> >>    p0 (FIFO42)
> >>     |
> >>     | blocked_on
> >>     v
> >>    p1 (FIFO41)
> >>     |
> >>     | blocked_on
> >>     v
> >>    p2 (FIFO40)
> >>
> >>   Add on top p3 an unrelated FIFO1 task, and p4 an unrelated CFS task.
> >>
> >>   CPU0
> >>   current:  p0
> >>   proxy:    p2
> >>   enqueued: p0, p1, p2, p3
> >>
> >>   CPU1
> >>   current:  p4
> >>   proxy:    p4
> >>   enqueued: p4
> >>
> >>
> >> pick_next_pushable_task() on CPU0 would pick p1 as the next highest
> >> priority task to push away to e.g. CPU1, but that would be undone as soon
> >> as proxy() happens on CPU1: we'd notice the CPU boundary and punt it back
> >> to CPU0. What we would want here is to pick p3 instead to have it run on
> >> CPU1.
> >
> > Given this point, is there any reason that blocked tasks should ever
> > be pushable, even if they are not part of the blocked chain for the
> > currently running task? If we could just check task_is_blocked()
> > rather than needing to know whether the task is in the middle of the
> > "active" chain, that would seem to simplify things greatly. I think
> > that approach might also require another dequeue/enqueue, in
> > ttwu_runnable(), to catch non-proxy blocked tasks becoming unblocked
> > (and therefore pushable), but that *seems* OK...though I could
> > certainly be missing something.
> >
>
> So for an active chain yes we probably don't want any task in the chain to
> be visible to load-balance - proxy and curr because they both make up the
> currently-executed task (but there are active load balances in
> e.g. CFS...), and the rest of the chain because of the above issues.
>
> As for blocked tasks in a separate chain, ideally we would want them to be
> picked up by load-balance. Consider:
>
>       blocked_on       owner
>   p0 ------------> m0 -------> p1
> FIFO4                         FIFO3
>
>       blocked_on       owner
>   p2 ------------> m1 -------> p3
> FIFO2                         FIFO1
>
>
> If all those tasks end up on a single CPU for whatever reason, we'll pick
> p0, go through proxy(), and run p1.
>
> If p2 isn't made visible to load-balance, we'll try to move p3 away -
> unfortunately nothing will make it bring p2 with it. So if all other CPUs
> are running FIFO1 tasks, load-balance will do nothing.

Got it, makes sense & will need to think some more about this case.

Another case to consider: if we have another task p4 on the same CPU
also blocked on m0, should it be pushable? There might not be much
point in pushing it away from p1, but preventing that seems like it
would complicate things even further since it would require that the
entire tree of tasks blocked on p1 not be visible to load-balance.

>
> If p2 is made visible to load-balance, we'll try to move it away, but
> if/when we try to pick it we'll move it back to where p3 is...
> One possible change here is to make the blocked chain migrate towards the
> proxy rather than the owner - this makes scheduling priority considerations
> a bit saner, but is bad towards the owner (migrating blocked tasks is
> "cheap", migrating running tasks isn't).
>
> > A related load balancing correctness question that caught my eye while
> > taking another look at this code: when we have rq->curr != rq->proxy
> > and then rq->curr is preempted and switches out, IIUC rq->curr should
> > become pushable immediately - but this does not seem to be the case
> > even with this patch. Is there a path that handles this case that I'm
> > just missing, or a reason that no special handling is needed?
> > Otherwise I wonder if __schedule() might need a dequeue/enqueue for
> > the prev task as well in this case.
>
> pick_next_task() does a put_prev_task() before picking the new highest
> priority task, so if curr gets preempted (IOW pick_next_task() returns a p
> != curr) then it has had put_prev_task() done on it which which should make
> it pushable.

Right now, that call to put_prev_task() passes in rq->proxy rather
than rq->curr, which IIUC means that if the outgoing rq->proxy is
newly pushable due to no longer being the "donor" task/scheduling
context then that will be detected - but I don't see how this does
anything about the outgoing rq->curr. Consider if we have the
following tasks all on a single CPU with the p0->p1 chain currently
running, and then p2 is raised to FIFO3:

      blocked_on       owner
  p0 ------------> m0 -------> p1
FIFO2                         FIFO1

      blocked_on       owner
  p2 ------------> m1 -------> p3
FIFO1                         FIFO1

My understanding is that the p2->p3 chain would preempt and
__schedule() would call put_prev_task() on p0, set_next_task() on p2,
and proxy_tag_curr() on p3, all of which will appropriately update
those tasks' pushability. But p1 should become pushable now that it's
switching out, and I don't see how that occurs.
