Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD275FB8C5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJKRBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiJKRBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:01:01 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1AE95AD1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:01:00 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 81so17204110ybf.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sTNTMApw48NuBlFkdy+LxEq1jZub5Jw5txwJf6Lvs1Y=;
        b=ksHxMK2wxTV5aEAwAa4RM1BrRz/KsiBWlyxguy8T1dN1YvkIgn3NTyM9+MVcE/qZdJ
         6KvGmO0Bhc1xchkmMlIbs7+L10opregi77gDllHdqvHt4//n0PKLs1pReCbyqsOvJ6/U
         ttal6Ma6ZSZvsNoueVdoGa5I+Iq1ntuNBK21tMJ43wdn0E0aMDb/rdXeBWxuV51WFhgI
         fqh63QqxwDTLyYBNaSuHaViJ+/8q+n0EPsfWuuDWFUJRc1yUSrIRUbAGETKaujcFEvYY
         qHyzEpjqajQJ5ZunNYXApUceyRqQ+JuwJRj7UIgv/bKaGUBRfW+DReeWUTEAXvPhrMzX
         5Hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTNTMApw48NuBlFkdy+LxEq1jZub5Jw5txwJf6Lvs1Y=;
        b=dca/cjzkKnfdCj/nGETsTsxl8pER+s60Z5wVEsuYK1E9JXOHgi3lsjixo7inoymncX
         /gAUjdNIvwhOu02GiFLzDQOaqFWAO29UqHiMFq/dS9ImJ0ifljGLUu4Jxr3hCd23qNmH
         fui19nnO0AZ9RCmL1a8G4ZppKDdrP0TOonJxUBevQkRP66oaxR9xmWr8MpxUQP0sVxAP
         OcrHUTAREEihJSmkomszcEOA0QlZgviI/wEDD4G9c1os2u3oZUXqZkZOps8N8LrvGRRL
         2QLkDv0g623AVBV4lu9UMuCXJs0MIilU25GUHJU4898su1JTnrc7T+cLt1CsQgopNFmk
         CsKw==
X-Gm-Message-State: ACrzQf1T/wEVVAitUjQmB1JPdN8kGHzghvUqZzAp0JaCuZlu84oSj44C
        knmpcugBRGXWbWddfYq6gzguV0Y+7NjiG/gQEm5oIA==
X-Google-Smtp-Source: AMsMyM6CvSQ2r7xPDC7r4fcOQ37CfSg8AS1xALiyW6bMEDh9thOJlfDhtc+rIk/Fl75sGx266U0JR9ElRW1DCHsZywA=
X-Received: by 2002:a05:6902:1244:b0:6bd:6409:9591 with SMTP id
 t4-20020a056902124400b006bd64099591mr24779106ybu.431.1665507659147; Tue, 11
 Oct 2022 10:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220913140817.GA9091@hu-pkondeti-hyd.qualcomm.com>
 <20221010104206.12184-1-zhouchengming@bytedance.com> <CAJuCfpF7Z+CYhk-f_aaDTE232+m9z_n-QfjGfdLje7QrX9bFtw@mail.gmail.com>
 <a73f58a3-9f96-2ce5-38a0-8abab27a2260@bytedance.com>
In-Reply-To: <a73f58a3-9f96-2ce5-38a0-8abab27a2260@bytedance.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 11 Oct 2022 10:00:48 -0700
Message-ID: <CAJuCfpET+B3X-uX2vDp-2yH-+OVxOu3YXL7JWZrPuoh22P+5SQ@mail.gmail.com>
Subject: Re: [PATCH] sched/psi: Fix avgs_work re-arm in psi_avgs_work()
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     hannes@cmpxchg.org, quic_pkondeti@quicinc.com,
        peterz@infradead.org, quic_charante@quicinc.com,
        linux-kernel@vger.kernel.org
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

On Mon, Oct 10, 2022 at 5:07 PM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Hello,
>
> On 2022/10/11 05:21, Suren Baghdasaryan wrote:
> > On Mon, Oct 10, 2022 at 3:42 AM Chengming Zhou
> > <zhouchengming@bytedance.com> wrote:
> >>
> >> Pavan reported a problem that PSI avgs_work idle shutoff is not
> >> working at all. Because PSI_NONIDLE condition would be observed in
> >> psi_avgs_work()->collect_percpu_times()->get_recent_times() even if
> >> only the kworker running avgs_work on the CPU.
> >>
> >> Although commit 1b69ac6b40eb ("psi: fix aggregation idle shut-off")
> >> avoided the ping-pong wake problem when the worker sleep, psi_avgs_work()
> >> still will always re-arm the avgs_work, so shutoff is not working.
> >>
> >> This patch changes to consider current CPU groupc as IDLE if the
> >> kworker running avgs_work is the only task running and no IOWAIT
> >> or MEMSTALL sleep tasks, in which case we will shut off the avgs_work
> >> if other CPUs' groupc are also IDLE.
> >>
> >> One potential problem is that the brief period of non-idle time
> >> incurred between the aggregation run and the kworker's dequeue will
> >> be stranded in the per-cpu buckets until avgs_work run next time.
> >> The buckets can hold 4s worth of time, and future activity will wake
> >> the avgs_work with a 2s delay, giving us 2s worth of data we can leave
> >> behind when shut off the avgs_work. If the kworker run other works after
> >> avgs_work shut off and doesn't have any scheduler activities for 2s,
> >> this maybe a problem.
> >>
> >> Reported-by: Pavan Kondeti <quic_pkondeti@quicinc.com>
> >> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> >
> > Copying my comments from
> > https://lore.kernel.org/all/CAJuCfpHyYMak-mfVmtEN9Z-hGYQ6Wko57TLjukz9HaN26EDAuA@mail.gmail.com/
> > in case you want to continue the discussion here...
> >
> >> ---
> >>  kernel/sched/psi.c | 15 +++++++++++++++
> >>  1 file changed, 15 insertions(+)
> >>
> >> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> >> index ee2ecc081422..f4cdf6f184ba 100644
> >> --- a/kernel/sched/psi.c
> >> +++ b/kernel/sched/psi.c
> >> @@ -242,6 +242,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
> >>                              u32 *pchanged_states)
> >>  {
> >>         struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
> >> +       int current_cpu = raw_smp_processor_id();
> >> +       bool only_avgs_work = false;
> >>         u64 now, state_start;
> >>         enum psi_states s;
> >>         unsigned int seq;
> >> @@ -256,6 +258,15 @@ static void get_recent_times(struct psi_group *group, int cpu,
> >>                 memcpy(times, groupc->times, sizeof(groupc->times));
> >>                 state_mask = groupc->state_mask;
> >>                 state_start = groupc->state_start;
> >> +               /*
> >> +                * This CPU has only avgs_work kworker running, snapshot the
> >> +                * newest times then don't need to re-arm for this groupc.
> >> +                * Normally this kworker will sleep soon and won't wake
> >> +                * avgs_work back up in psi_group_change().
> >> +                */
> >> +               if (current_cpu == cpu && groupc->tasks[NR_RUNNING] == 1 &&
> >> +                   !groupc->tasks[NR_IOWAIT] && !groupc->tasks[NR_MEMSTALL])
> >> +                       only_avgs_work = true;
> >
> > Why do you determine only_avgs_work while taking a snapshot? The
> > read_seqcount_retry() might fail and the loop gets retried, which
> > might lead to a wrong only_avgs_work value if the state changes
> > between retries. I think it's safer to do this after the snapshot was
> > taken and to use tasks[NR_RUNNING] instead of  roupc->tasks.
>
> Ah, you are right, coping groupc->tasks[NR_RUNNING] and tasks[NR_IOWAIT], tasks[NR_MEMSTALL]
> is ok for me. (Maybe we only need to copy groupc->tasks[NR_RUNNING]?)
>
> Another way is to add an else branch:
>
>                 if (current_cpu == cpu && groupc->tasks[NR_RUNNING] == 1 &&
>                     !groupc->tasks[NR_IOWAIT] && !groupc->tasks[NR_MEMSTALL])
>                         only_avgs_work = true;
>                 else
>                         only_avgs_work = false;
>
> Both are ok for me.

Let's use the simple way and use the tasks[] after the snapshot is taken.

>
> >
> >>         } while (read_seqcount_retry(&groupc->seq, seq));
> >>
> >>         /* Calculate state time deltas against the previous snapshot */
> >> @@ -280,6 +291,10 @@ static void get_recent_times(struct psi_group *group, int cpu,
> >>                 if (delta)
> >>                         *pchanged_states |= (1 << s);
> >>         }
> >> +
> >> +       /* Clear PSI_NONIDLE so avgs_work won't be re-armed for this groupc */
> >> +       if (only_avgs_work)
> >> +               *pchanged_states &= ~(1 << PSI_NONIDLE);
> >
> > This seems to be safe because changed_states&(1<< PSI_NONIDLE) is used
> > only for re-arming psi_avgs_work, however semantically this is
> > incorrect. The CPU was not idle when it was executing psi_avgs_work.
> > IMO a separate flag would avoid this confusion.
>
> Yes, it's safe, but has this confusion. Use a separate flag looks better, like PSI_ONLY_AVGS_WORK.
> But then in collect_percpu_times() we still have to clear PSI_NONIDLE of this CPU if PSI_ONLY_AVGS_WORK
> has been set.
>
>         for_each_possible_cpu(cpu) {
>                 u32 times[NR_PSI_STATES];
>                 u32 nonidle;
>                 u32 cpu_changed_states;
>
>                 get_recent_times(group, cpu, aggregator, times,
>                                 &cpu_changed_states);
>                 changed_states |= cpu_changed_states;
>
> cpu_changed_states should clear PSI_NONIDLE if PSI_ONLY_AVGS_WORK already set.

No, PSI_NONIDLE should not be affected by PSI_ONLY_AVGS_WORK. These
flags should be independent and aggregated into changed_states without
affecting each other. Something similar to how I suggested with
PSI_STATE_WAKE_CLOCK in
https://lore.kernel.org/all/CAJuCfpFr3JfwkWbDqkU=NUJbCYuCWGySwNusMCdmS3z95WD2AQ@mail.gmail.com/#t.
Thanks,
Suren.

>
> I'm not sure if it's better to clear here, maybe we can add a comment in get_recent_times()
> when do PSI_NONIDLE clear?
>
> Thanks!
>
