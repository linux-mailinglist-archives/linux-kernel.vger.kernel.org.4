Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EF65F6E4E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiJFTk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiJFTkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:40:16 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD6C6D553
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:40:15 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id 3so3055527vsh.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oEc/V5K1Hiz7/4wWbbIIQE2MUW9NYfI5CWqEEyZwESU=;
        b=NYC0CmQIuFWQzXFFZgBfc7weSbJfuC2QUMUCsdwp6SZG9JIuTX/6Z9o7nz+Hv64OTu
         AEr+pGRgCzhIL3Vzk26rGKUlKq6E+PJn9MGx2VCga1NoHjE4YC0UV4ZxuqyNNhiRK+bA
         CgFYONIBM0wY9kEsqV5rxQkFHIu0t3ho+HWdfyLlTEivyoh6OaEFMbz1kssda+e9wUGJ
         idcLv9la3esvdEEXgWbPmdJhKnDMoV2HtVcPSH/tKYIVFeuBojEsDcE69Z2KbIY1gTZc
         11GSsgjPc45hMnozlarI/WmDBXUI22nTAsYMcCk8d8rjxDJik+bgmyC+O6l0SK4NOhkl
         PtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEc/V5K1Hiz7/4wWbbIIQE2MUW9NYfI5CWqEEyZwESU=;
        b=oG32x2EznmvB+OA3X79JHgNWJZK3gjFuFnsa4h3bYTiGLnfWB+qcvOiA/IOiK++FlK
         rrdv9IcsACQExg1S/f9Twj3PnHmQUgqxaH5w3JGwM/7btc0BfYLlSnO69jFYwlDDsn5I
         fEWm7L5pUE1//tugrSSpi2qpDwbFV8KnGJh0ejy6jYXyDgxv4eUToTGZItzgsXzKvktc
         KreJFQONJ/wtbATB/EUZGJB6vfptiwca905BiBHFkXiHOzpFEy7mKO+u2ronCIKz078F
         ch0MGjW0HKr+PD5HbyBWtX1xzQpZFGNMJd/T+NWks8b/IZJWZRjrr6wpOCyaETlqFg3h
         8h3w==
X-Gm-Message-State: ACrzQf1p83Tu1NJj10AZng+6tfoOxygPB2iMFrhNnYYUWLOL+i1SCs7M
        S3EM7fA7CY3l5/55NSofs66dK4Uot2xyb9/uvyqzSw==
X-Google-Smtp-Source: AMsMyM670pxWPsqsaj/wgnyeYiQ8w0AcRuG0UXXGJGGNz6gs/OUI07bqEmePGSW/VbLMkf1nQxpCmjccMgRupRMoeB8=
X-Received: by 2002:a67:d51b:0:b0:3a6:f485:8874 with SMTP id
 l27-20020a67d51b000000b003a6f4858874mr945789vsj.15.1665085214332; Thu, 06 Oct
 2022 12:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <cb6c406e-1431-fcfd-ef82-87259760ead9@joelfernandes.org>
 <20220930134931.mpopdvri4xuponw2@wubuntu> <00140e95-0fe2-1ce4-1433-a3211f9da20c@joelfernandes.org>
 <20221003161404.kdow5uyj7kvbqyxs@wubuntu> <bb28d85a-c50f-a25f-aeb4-672eecb75b55@joelfernandes.org>
 <20221005100402.3i46oqx5lxsw2qer@wubuntu> <CAEXW_YSPBzjvWaFqhvYpO=RFyjKR0uTPChUwScNsFnEaZupsVQ@mail.gmail.com>
In-Reply-To: <CAEXW_YSPBzjvWaFqhvYpO=RFyjKR0uTPChUwScNsFnEaZupsVQ@mail.gmail.com>
From:   Youssef Esmat <youssefesmat@google.com>
Date:   Thu, 6 Oct 2022 14:40:03 -0500
Message-ID: <CALUeGD0OP4ZqDFcT10=ih40tGsm9gjjno7NP_Jwd1RxiUJZ0CQ@mail.gmail.com>
Subject: Re: Sum of weights idea for CFS PI
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, bristot@redhat.com,
        clark.williams@gmail.com, bigeasy@linutronix.de,
        "Paul E. McKenney" <paulmck@kernel.org>
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

On Thu, Oct 6, 2022 at 8:53 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Wed, Oct 5, 2022 at 6:04 AM Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > Hi Joel
> >
> > On 10/04/22 16:27, Joel Fernandes wrote:
> >
> > [...]
> >
> > > I am treating the following the same:
> > >
> > >       a.  when A is running, it would be as above.
> > >       b.  but if A was sleeping, B, C, and D would get 1/3.
> > >
> > >  similar to
> > >
> > >       a.  when A is running *and blocked on C for all its runtime*
> > >               ^^ -- in this case, B and D should not have their distributions
> > >                     changed at all because they are not participating in the
> > >                     lock acquire and release. So they should neither be hurt
> > >                     any more, nor be boosted. They should simply stay same [1]
> > >
> > >       b.  but if A was sleeping, B, C, and D would get 1/3.
> > >
> > >
> > > [1] Why? Consider 3 tasks in the all-RT case, A high, B medium and C low prio.
> > >
> > > If all are running 100% and A does not block on C, B is blocked by A
> > > indefinitely. So the prio of A and B are inverted. We seek to rectify this, that
> > > is we need make changes such that, B is returned back to the blocked state. We
> > > do this by boosting C.
> > >
> > > In other words, the prio inheritance will cause B's distribution to not be
> > > changed (it was supposed to be blocked before and it is now going to be blocked
> > > state again).
> > >
> > > CFS should not behave any differently, B's distribution should not be changed
> > > before/after the priority inhertiance of A by C. That's just my opinion - and
> > > that's how I calculated to distribution. With that mind, could you go back to
> > > seeing if my math was originally correct or did I mess something up?
> >
> > It's not about the math. But I think the before and after can't be the same for
> > C..
>
> C is acquiring/releasing the lock so I expect its distribution to
> change. I was talking about the poor B who has nothing to do with the
> lock.
>
> > > > I don't think this is valid. If A is blocked on C for 50% of the time, and
> > > > sleeping for 50% of the time, when did it get blocked/unblocked?
> > > >
> > > > This will have an impact on the average share for C and skew it, no?
> > > >
> > > > Unless I missed something, the average share of C being (3/5 + 1/3) is an
> > > > impossible state. You need to consider the portion of time when C runs as 1/5,
> > > > when A is actually not blocked on anything, too.
> > > >
> > > > Hmm actually I just re-read your statement below and you just say 3/5 (18/30)
> > > > is too much. You didn't consider the average. I'll leave the above in hope to
> > > > help me understand what am I missing and where I went wrong :-)
> > > >
> > > > Generally IMHO looking at the average will not help. I think if the share
> > > > values make sense in each state individually (and I believe they are), that
> > > > would be enough. AFAICS, B and D are still taking the right amount of time when
> > > > C inherits the bandwidth. And C by definition will run longer when A is blocked
> > > > on it for the whole duration of this blocked time.
> > >
> > > I was degenerating the case where A sleeps (say I/O) vs A blocks, to simplify
> > > the math, and then taking average of that. I think that's reasonable?
> >
> > I'm not sure. This is skewing the results in my view.
> >
> > I think the comparison should just be:
> >
> > 1) A, B, C, and D are all running and nothing gets blocked at all. Then shares
> >    would be:
> >
> >    2/5, 1/5, 1/5, 1/5
> >
> > 2) A is blocked and C; B, C, D are running with no blocked time. Shares would
> >    be:
> >
> >    - , 1/5, 3/5, 1/5
> >
> > By definition, we want to treat A in (2) as RUNNING because as soon as
> > C unblocks A we should return to (1). From B and D perspective, their share is
> > not impacted throughout this transition. Which is AFAIU is what we want to
> > achieve.
> >
> > I think considering the sleeping time and averaging can lead to misleading
> > results if care is not taken.
>
> Yes, but that doesn't mean we can just ignore it. It is easy in my
> view to skew the inherited weight to a very large number, only to find
> that tasks unrelated to the lock acquire/release are "suffering"
> though they had nothing to do with the lock or the PI. But it is
> reasonable to try the simple approach first and see the impact.
>
> I also never said the averaging approach or consideration of sleeping
> time is perfect ;-)
>
> > Anyway - just trying to explain how I see it and why C is unlikely to be taking
> > too much time. I could be wrong. As Youssef said, I think there's no
> > fundamental problem here.
>
> I know on Android where they use smaller HZ, the large tick causes
> lots of problems for large nice deltas. Example if a highly niced task
> was to be preempted for 1ms, and preempts instead at 3ms, then the
> less-niced task will not be so nice (even less nice than it promised
> to be) any more because of the 2ms boost that the higher niced task
> got. This can lead the the sched_latency thrown out of the window. Not
> adjusting the weights properly can potentially make that problem much
> worse IMO.

Once C releases the lock it should get adjusted and A will get
adjusted also regardless of tick. At the point we adjust the weights
we have a chance to check for preemption and cause a reschedule.

If C doesn't release the lock quickly (hopefully rare), it should
continue to run at the adjusted weight since it is still blocking A.

>
> Thanks.
