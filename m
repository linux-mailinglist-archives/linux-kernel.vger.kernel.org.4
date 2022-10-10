Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024325FA663
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiJJUfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiJJUfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:35:22 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1459A7FE51
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:34:21 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id b145so14303978yba.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vBQummT3bN9J6ubJxVcc8t1TqKvA1EAmc850BQ9TFII=;
        b=Nm19jOt0utIuzFz5i5JM5/Uaq5P+aswJQ5Zs8JApC84kXY5pZuNwi8u/CFT0J5y+5y
         OmZsgJe3a0CfvQ6bWiIwS2rfVR0CvcmfUd+Cc9ER7/+rlzxh+cQvfeUX7e33VURX21NM
         IChrBIw+tLR3dd5PyOV6eGpRnMBrLL07H5wgy+/J1g1R5ls/yDcNIhKuuLzI9vygCNZd
         UmxvvmfrBbZdG/R+LJrFLGckd8OM+hY1kUyUcyFlne/pCpW/y8UcFI/uAOng1Xc/rGdG
         8EVR8zoIjz5blahGeqg3yZ+UMGZ2SdqDzxFJ6geFpjEc/Di3QL9I74sp/4ufk+1/jKRQ
         M4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBQummT3bN9J6ubJxVcc8t1TqKvA1EAmc850BQ9TFII=;
        b=knT7Zjd3x7chny78JAmr+1+hlLd0jRfL6puNsVYcxyB4MSxQsCD5Zg7giX+NRmOw+N
         JGAx50VaD983jPykPDa861MVl3gNkzz5NNfNuqwFZvwiuuVFKPgVjbE0Su1eaTsUaECx
         7ndKDhGcNQm5LtkjNguMxrrcBFnLGpJEZMItPghl2vSsCycLdyTXjsT+ovytL1fbfjPC
         ZH5G4QbXBTRPFBufW0kaHUkvVB5rDC00YregDWx4cRJ/mV/3oP0N2lbnMkwIjM7WJMmY
         fnjXH+cDLXA1nmj1rv5wJfcrtTpAVBDCwGU59oAuCYgZJ78X0t0KEVptLXsL/QfsOLi4
         4Vcg==
X-Gm-Message-State: ACrzQf2iIQuH1SrA0Oz7k0YJKGWY4MoPFzcnKRyDqhozVRZpOujduvRc
        K2Ll2Fk9Gq7u8PktNpWxYNVrQqWFaBkb6qgsrsYCe2Kc0CUqww==
X-Google-Smtp-Source: AMsMyM6K+OnRTYG210ctic4wktCvgSZh5K+/ZThudnkpotJIc55fGggQLp9+Seg8fplQtXH7IxXcRwqA/zsoCyp8Law=
X-Received: by 2002:a05:6902:1244:b0:6bd:6409:9591 with SMTP id
 t4-20020a056902124400b006bd64099591mr20264556ybu.431.1665434011948; Mon, 10
 Oct 2022 13:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220913140817.GA9091@hu-pkondeti-hyd.qualcomm.com>
 <20220915062027.GA14713@hu-pkondeti-hyd.qualcomm.com> <CAJuCfpE_nM2uqixnds0d6wbsz4=OQ3KPoJ5HOqDhQXaxFGxwXQ@mail.gmail.com>
 <CAJuCfpEeNzDQ-CvMN3fP5LejOzpnfgUgvkzpPj1CLF-8NqNoww@mail.gmail.com>
 <CAJuCfpFr3JfwkWbDqkU=NUJbCYuCWGySwNusMCdmS3z95WD2AQ@mail.gmail.com> <43f4d1c3-52fe-5254-7d50-c420de6d11a6@bytedance.com>
In-Reply-To: <43f4d1c3-52fe-5254-7d50-c420de6d11a6@bytedance.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 10 Oct 2022 13:33:20 -0700
Message-ID: <CAJuCfpG0aUPGqHo-T9dQmn_7E4t71dq3DY2u6N=izkuvFuZU-Q@mail.gmail.com>
Subject: Re: PSI idle-shutoff
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
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

On Sun, Oct 9, 2022 at 5:41 AM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Hello,
>
> I just saw these emails, sorry for late.
>
> On 2022/10/6 00:32, Suren Baghdasaryan wrote:
> > On Sun, Oct 2, 2022 at 11:11 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >>
> >> On Fri, Sep 16, 2022 at 10:45 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >>>
> >>> On Wed, Sep 14, 2022 at 11:20 PM Pavan Kondeti
> >>> <quic_pkondeti@quicinc.com> wrote:
> >>>>
> >>>> On Tue, Sep 13, 2022 at 07:38:17PM +0530, Pavan Kondeti wrote:
> >>>>> Hi
> >>>>>
> >>>>> The fact that psi_avgs_work()->collect_percpu_times()->get_recent_times()
> >>>>> run from a kworker thread, PSI_NONIDLE condition would be observed as
> >>>>> there is a RUNNING task. So we would always end up re-arming the work.
> >>>>>
> >>>>> If the work is re-armed from the psi_avgs_work() it self, the backing off
> >>>>> logic in psi_task_change() (will be moved to psi_task_switch soon) can't
> >>>>> help. The work is already scheduled. so we don't do anything there.
> >>>
> >>> Hi Pavan,
> >>> Thanks for reporting the issue. IIRC [1] was meant to fix exactly this
> >>> issue. At the time it was written I tested it and it seemed to work.
> >>> Maybe I missed something or some other change introduced afterwards
> >>> affected the shutoff logic. I'll take a closer look next week when I'm
> >>> back at my computer and will consult with Johannes.
> >>
> >> Sorry for the delay. I had some time to look into this and test psi
> >> shutoff on my device and I think you are right. The patch I mentioned
> >> prevents new psi_avgs_work from being scheduled when the only non-idle
> >> task is psi_avgs_work itself, however the regular 2sec averaging work
> >> will still go on. I think we could record the fact that the only
> >> active task is psi_avgs_work in record_times() using a new
> >> psi_group_cpu.state_mask flag and then prevent psi_avgs_work() from
> >> rescheduling itself if that flag is set for all non-idle cpus. I'll
> >> test this approach and will post a patch for review if that works.
> >
> > Hi Pavan,
> > Testing PSI shutoff on Android proved more difficult than I expected.
> > Lots of tasks to silence and I keep encountering new ones.
> > The approach I was thinking about is something like this:
> >
> > ---
> >  include/linux/psi_types.h |  3 +++
> >  kernel/sched/psi.c        | 12 +++++++++---
> >  2 files changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> > index c7fe7c089718..8d936f22cb5b 100644
> > --- a/include/linux/psi_types.h
> > +++ b/include/linux/psi_types.h
> > @@ -68,6 +68,9 @@ enum psi_states {
> >          NR_PSI_STATES = 7,
> >  };
> >
> > +/* state_mask flag to keep re-arming averaging work */
> > +#define PSI_STATE_WAKE_CLOCK        (1 << NR_PSI_STATES)
> > +
> >  enum psi_aggregators {
> >          PSI_AVGS = 0,
> >          PSI_POLL,
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index ecb4b4ff4ce0..dd62ad28bacd 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -278,6 +278,7 @@ static void get_recent_times(struct psi_group
> > *group, int cpu,
> >                  if (delta)
> >                          *pchanged_states |= (1 << s);
> >          }
> > +        *pchanged_states |= (state_mask & PSI_STATE_WAKE_CLOCK);
>
> If the avgs_work kworker is running on this CPU, it will still see
> PSI_STATE_WAKE_CLOCK set in state_mask? So the work will be re-armed?

Ah, you are right. psi_group_change will set this flag again once
avgs_work starts running and we will see it here.

>
> Maybe I missed something... but I have another different idea which
> I want to implement later only for discussion.
>
> Thanks.
>
> >  }
> >
> >  static void calc_avgs(unsigned long avg[3], int missed_periods,
> > @@ -413,7 +414,7 @@ static void psi_avgs_work(struct work_struct *work)
> >          struct delayed_work *dwork;
> >          struct psi_group *group;
> >          u32 changed_states;
> > -        bool nonidle;
> > +        bool wake_clock;
> >          u64 now;
> >
> >          dwork = to_delayed_work(work);
> > @@ -424,7 +425,7 @@ static void psi_avgs_work(struct work_struct *work)
> >          now = sched_clock();
> >
> >          collect_percpu_times(group, PSI_AVGS, &changed_states);
> > -        nonidle = changed_states & (1 << PSI_NONIDLE);
> > +        wake_clock = changed_states & PSI_STATE_WAKE_CLOCK;
> >          /*
> >           * If there is task activity, periodically fold the per-cpu
> >           * times and feed samples into the running averages. If things
> > @@ -435,7 +436,7 @@ static void psi_avgs_work(struct work_struct *work)
> >          if (now >= group->avg_next_update)
> >                  group->avg_next_update = update_averages(group, now);
> >
> > -        if (nonidle) {
> > +        if (wake_clock) {
> >                  schedule_delayed_work(dwork, nsecs_to_jiffies(
> >                                  group->avg_next_update - now) + 1);
> >          }
> > @@ -742,6 +743,11 @@ static void psi_group_change(struct psi_group
> > *group, int cpu,
> >          if (unlikely(groupc->tasks[NR_ONCPU] && cpu_curr(cpu)->in_memstall))
> >                  state_mask |= (1 << PSI_MEM_FULL);
> >
> > +        if (wake_clock || test_state(groupc->tasks, PSI_NONIDLE)) {
> > +                /* psi_avgs_work was not the only task on the CPU */
> > +                state_mask |= PSI_STATE_WAKE_CLOCK;
> > +        }
> > +
> >          groupc->state_mask = state_mask;
> >
> >          write_seqcount_end(&groupc->seq);
