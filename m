Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF51A5FA6C1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiJJU7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiJJU7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:59:31 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB78D7C1DB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:59:25 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-358bf076f1fso110762667b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ilM3DTIeozedzw6br0G5UM+s8fEVh+nCtK9XbmG9l5Q=;
        b=kuMKlJjWNsUUQrWZFeMHsTFFB6uCjoTkBm9/M5hPsCWQUv2LA315opPvgVoC573Rpg
         cJT5FZQ+aAZC/DXB5zAqzFvfNqRKhzk75aGCZrUsEHXZTD5iS0rSDJgLaTaQ6QkPpnvb
         lV/StZ1WCxDQhuZmN3qT7f94zK6IQwwirt7gOU5zajxfwJN0Exyo62CyZkOaen60Mkfb
         FfWnm8pIcvg/BBFTMoh3x5oZFns8wuugmk7N9SRF7LYhCamL6+0uSY5c+PemgnO6ISC5
         uE9QAn9i4CHEkBENUcahPNkIuY2VKCx5Nva1hl+k5uy3nd3moTALHacHc/auVclJUL/g
         MRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ilM3DTIeozedzw6br0G5UM+s8fEVh+nCtK9XbmG9l5Q=;
        b=h7s6ZRXNBkQI+q7wOk1x4eLjjCpqivn2cGdmeUQ0CGoaX3g0BGnHqm1+U9v/gtAMAP
         udklNjuIzr1mmw/+fMkfiZsP0CAqPChhNYUm69094P0bOuJK9U4LhIyBOmMkB1jaq9JP
         MdTmePwAR+YHBAKuzYWTWeUpNrGSCVMjy3V1i2X9yJ8iikgRkG3iiTnYGNo7XJrVsbx7
         BpOt9I00ZoTFGCwCyVFHSjlI/BorPGADXD8bqmoLVj1y/TB+ZI/nhGwDi4SjRKtuxq0Z
         SGjG9RjqReTB3CCCfM1N8OSQXsilDw57DzrkrSjCviITL5KOb30rKlOWubAwIM50PPAs
         i/yA==
X-Gm-Message-State: ACrzQf07vl0KKEYUNKINpVUMujpapkTXgncgyPEymJP4BA6SUmogY5LR
        sqNVeyz1Ln2bMY7Ay8oHmq9kY60FkqZ3Tqok/L9nHZnlg7/QXw==
X-Google-Smtp-Source: AMsMyM5LoCwmvD5AuGXp9YGSsDgv0wP1IWwsdrZZCxILC5JQD1PN4CBPmY/cpbloLrPLw94lJBfkpql4Lc3jC88Qfsk=
X-Received: by 2002:a81:a0d7:0:b0:357:6a14:e736 with SMTP id
 x206-20020a81a0d7000000b003576a14e736mr19340819ywg.455.1665435563944; Mon, 10
 Oct 2022 13:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220913140817.GA9091@hu-pkondeti-hyd.qualcomm.com>
 <20220915062027.GA14713@hu-pkondeti-hyd.qualcomm.com> <CAJuCfpE_nM2uqixnds0d6wbsz4=OQ3KPoJ5HOqDhQXaxFGxwXQ@mail.gmail.com>
 <CAJuCfpEeNzDQ-CvMN3fP5LejOzpnfgUgvkzpPj1CLF-8NqNoww@mail.gmail.com>
 <CAJuCfpFr3JfwkWbDqkU=NUJbCYuCWGySwNusMCdmS3z95WD2AQ@mail.gmail.com>
 <43f4d1c3-52fe-5254-7d50-c420de6d11a6@bytedance.com> <ff2addac-5a6c-1aa5-5f1c-d62b0444ae4c@bytedance.com>
In-Reply-To: <ff2addac-5a6c-1aa5-5f1c-d62b0444ae4c@bytedance.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 10 Oct 2022 13:59:12 -0700
Message-ID: <CAJuCfpHyYMak-mfVmtEN9Z-hGYQ6Wko57TLjukz9HaN26EDAuA@mail.gmail.com>
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

On Sun, Oct 9, 2022 at 6:17 AM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2022/10/9 20:41, Chengming Zhou wrote:
> > Hello,
> >
> > I just saw these emails, sorry for late.
> >
> > On 2022/10/6 00:32, Suren Baghdasaryan wrote:
> >> On Sun, Oct 2, 2022 at 11:11 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >>>
> >>> On Fri, Sep 16, 2022 at 10:45 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >>>>
> >>>> On Wed, Sep 14, 2022 at 11:20 PM Pavan Kondeti
> >>>> <quic_pkondeti@quicinc.com> wrote:
> >>>>>
> >>>>> On Tue, Sep 13, 2022 at 07:38:17PM +0530, Pavan Kondeti wrote:
> >>>>>> Hi
> >>>>>>
> >>>>>> The fact that psi_avgs_work()->collect_percpu_times()->get_recent_times()
> >>>>>> run from a kworker thread, PSI_NONIDLE condition would be observed as
> >>>>>> there is a RUNNING task. So we would always end up re-arming the work.
> >>>>>>
> >>>>>> If the work is re-armed from the psi_avgs_work() it self, the backing off
> >>>>>> logic in psi_task_change() (will be moved to psi_task_switch soon) can't
> >>>>>> help. The work is already scheduled. so we don't do anything there.
> >>>>
> >>>> Hi Pavan,
> >>>> Thanks for reporting the issue. IIRC [1] was meant to fix exactly this
> >>>> issue. At the time it was written I tested it and it seemed to work.
> >>>> Maybe I missed something or some other change introduced afterwards
> >>>> affected the shutoff logic. I'll take a closer look next week when I'm
> >>>> back at my computer and will consult with Johannes.
> >>>
> >>> Sorry for the delay. I had some time to look into this and test psi
> >>> shutoff on my device and I think you are right. The patch I mentioned
> >>> prevents new psi_avgs_work from being scheduled when the only non-idle
> >>> task is psi_avgs_work itself, however the regular 2sec averaging work
> >>> will still go on. I think we could record the fact that the only
> >>> active task is psi_avgs_work in record_times() using a new
> >>> psi_group_cpu.state_mask flag and then prevent psi_avgs_work() from
> >>> rescheduling itself if that flag is set for all non-idle cpus. I'll
> >>> test this approach and will post a patch for review if that works.
> >>
> >> Hi Pavan,
> >> Testing PSI shutoff on Android proved more difficult than I expected.
> >> Lots of tasks to silence and I keep encountering new ones.
> >> The approach I was thinking about is something like this:
> >>
> >> ---
> >>  include/linux/psi_types.h |  3 +++
> >>  kernel/sched/psi.c        | 12 +++++++++---
> >>  2 files changed, 12 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> >> index c7fe7c089718..8d936f22cb5b 100644
> >> --- a/include/linux/psi_types.h
> >> +++ b/include/linux/psi_types.h
> >> @@ -68,6 +68,9 @@ enum psi_states {
> >>          NR_PSI_STATES = 7,
> >>  };
> >>
> >> +/* state_mask flag to keep re-arming averaging work */
> >> +#define PSI_STATE_WAKE_CLOCK        (1 << NR_PSI_STATES)
> >> +
> >>  enum psi_aggregators {
> >>          PSI_AVGS = 0,
> >>          PSI_POLL,
> >> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> >> index ecb4b4ff4ce0..dd62ad28bacd 100644
> >> --- a/kernel/sched/psi.c
> >> +++ b/kernel/sched/psi.c
> >> @@ -278,6 +278,7 @@ static void get_recent_times(struct psi_group
> >> *group, int cpu,
> >>                  if (delta)
> >>                          *pchanged_states |= (1 << s);
> >>          }
> >> +        *pchanged_states |= (state_mask & PSI_STATE_WAKE_CLOCK);
> >
> > If the avgs_work kworker is running on this CPU, it will still see
> > PSI_STATE_WAKE_CLOCK set in state_mask? So the work will be re-armed?
> >
> > Maybe I missed something... but I have another different idea which
> > I want to implement later only for discussion.
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index ee2ecc081422..f322e8fd8d41 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -241,11 +241,13 @@ static void get_recent_times(struct psi_group *group, int cpu,
>                              enum psi_aggregators aggregator, u32 *times,
>                              u32 *pchanged_states)
>  {
> +       int current_cpu = raw_smp_processor_id();
>         struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
>         u64 now, state_start;
>         enum psi_states s;
>         unsigned int seq;
>         u32 state_mask;
> +       bool only_avgs_work = false;
>
>         *pchanged_states = 0;
>
> @@ -256,6 +258,14 @@ static void get_recent_times(struct psi_group *group, int cpu,
>                 memcpy(times, groupc->times, sizeof(groupc->times));
>                 state_mask = groupc->state_mask;
>                 state_start = groupc->state_start;
> +               /*
> +                * This CPU has only avgs_work kworker running, snapshot the
> +                * newest times then don't need to re-arm work for this groupc.
> +                * Normally this kworker will sleep soon and won't
> +                * wake_clock in psi_group_change().
> +                */
> +               if (current_cpu == cpu && groupc->tasks[NR_RUNNING] == 1)
> +                       only_avgs_work = true;

Why do you determine only_avgs_work while taking a snapshot? The
read_seqcount_retry() might fail and the loop gets retried, which
might lead to a wrong only_avgs_work value if the state changes
between retries. I think it's safer to do this after the snapshot was
taken and to use tasks[NR_RUNNING] instead of groupc->tasks.

>         } while (read_seqcount_retry(&groupc->seq, seq));
>
>         /* Calculate state time deltas against the previous snapshot */
> @@ -280,6 +290,10 @@ static void get_recent_times(struct psi_group *group, int cpu,
>                 if (delta)
>                         *pchanged_states |= (1 << s);
>         }
> +
> +       /* Clear PSI_NONIDLE so avgs_work won't be re-armed for this groupc */
> +       if (only_avgs_work)
> +               *pchanged_states &= ~(1 << PSI_NONIDLE);

This seems to be safe because changed_states&(1<< PSI_NONIDLE) is used
only for re-arming psi_avgs_work, however semantically this is
incorrect. The CPU was not idle when it was executing psi_avgs_work.
IMO a separate flag would avoid this confusion.

>  }
>
>  static void calc_avgs(unsigned long avg[3], int missed_periods,
>
>
> >
> > Thanks.
> >
> >>  }
> >>
> >>  static void calc_avgs(unsigned long avg[3], int missed_periods,
> >> @@ -413,7 +414,7 @@ static void psi_avgs_work(struct work_struct *work)
> >>          struct delayed_work *dwork;
> >>          struct psi_group *group;
> >>          u32 changed_states;
> >> -        bool nonidle;
> >> +        bool wake_clock;
> >>          u64 now;
> >>
> >>          dwork = to_delayed_work(work);
> >> @@ -424,7 +425,7 @@ static void psi_avgs_work(struct work_struct *work)
> >>          now = sched_clock();
> >>
> >>          collect_percpu_times(group, PSI_AVGS, &changed_states);
> >> -        nonidle = changed_states & (1 << PSI_NONIDLE);
> >> +        wake_clock = changed_states & PSI_STATE_WAKE_CLOCK;
> >>          /*
> >>           * If there is task activity, periodically fold the per-cpu
> >>           * times and feed samples into the running averages. If things
> >> @@ -435,7 +436,7 @@ static void psi_avgs_work(struct work_struct *work)
> >>          if (now >= group->avg_next_update)
> >>                  group->avg_next_update = update_averages(group, now);
> >>
> >> -        if (nonidle) {
> >> +        if (wake_clock) {
> >>                  schedule_delayed_work(dwork, nsecs_to_jiffies(
> >>                                  group->avg_next_update - now) + 1);
> >>          }
> >> @@ -742,6 +743,11 @@ static void psi_group_change(struct psi_group
> >> *group, int cpu,
> >>          if (unlikely(groupc->tasks[NR_ONCPU] && cpu_curr(cpu)->in_memstall))
> >>                  state_mask |= (1 << PSI_MEM_FULL);
> >>
> >> +        if (wake_clock || test_state(groupc->tasks, PSI_NONIDLE)) {
> >> +                /* psi_avgs_work was not the only task on the CPU */
> >> +                state_mask |= PSI_STATE_WAKE_CLOCK;
> >> +        }
> >> +
> >>          groupc->state_mask = state_mask;
> >>
> >>          write_seqcount_end(&groupc->seq);
