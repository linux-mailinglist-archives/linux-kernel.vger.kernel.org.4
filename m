Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777175F584D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJEQdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJEQc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:32:58 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EE4659DB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 09:32:57 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-358bf076f1fso98924477b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 09:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tO1cqxBl5Ixvz5qgHxYOFF3bhJ6a/cA5ECS1RiJpe5w=;
        b=sZOqwo+6l3Eyq2GP9Hk9q+guT9/5nNNfx+IJZD4FQ/kD1cYOJWESWbTN7cVcekzIvs
         9zW11zGtGbtQwTnzR11EH9hecRi47wjVDL6tmTyJLqrKhzKBy1qAJTFpz13CoRTt7MC3
         JacPBVny5y0UaDs+6ZBLptq9TyASLCq6PIwY2z6H3Jz8b2xvnmGmvFA/PH72QQws51bP
         kApR3xalIDfe8aNPYR38GOZKjvhPSQXJgCP0WHz4RSUIGOv1Dv1WOk1Fz+v/9aLA3rwr
         VzPPO7VLOu7kXuO1JSZbITpMPDNimCWVb1aeBLX2Es07fzAf10kBC2tFu4/PkaGdvYlo
         NNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tO1cqxBl5Ixvz5qgHxYOFF3bhJ6a/cA5ECS1RiJpe5w=;
        b=m6n3lf0vR2SYI+6xO/vgC4tOvReBqd0b3RARIncFI+Vb0wVzYs8gjvN7/L1lB4rzsi
         bGxh3E6lCbRUt0On5QdFLoPofs9iBFnM8TwMFDUklJv0Wnqh0s+Zz7XKHV99oWlNEWLh
         un+fyudUh0TgeD8NLS61zrzSpv/v0efH24VM6OSFRXqk4TBX2ldG7sIEpmFfFV6mLQGW
         AIDj/rIainICqjUUB78Okx4PlAcGlOY97kXWTRxMaFRoACoxvr7EG5wrToJ6BZ+f7IEs
         +waIrAjgUk+jVIyrP40lS+w/aLF/Vh4oxoMWgnS4eETv72YNwrofagwjVxY4RlAi7uga
         IAAw==
X-Gm-Message-State: ACrzQf17J0/XgfFsIrID1Zu2oRCxGXNzxnWJ2V6S4Wyu3Y2/hedvZBVI
        OTdlC17yJvvnkgpO9/i0SLVkmM+/RXUz4JMmZav58Q==
X-Google-Smtp-Source: AMsMyM6Ug/uEVFi6hVoJw88GCsPdVF+D5xbdtYx5P1Ezm8OSxTN5hccFF4CzvTnYqxxkNQgu3/r/KYo7H0RHmAOoWAg=
X-Received: by 2002:a81:6ccf:0:b0:35b:c5a5:1df3 with SMTP id
 h198-20020a816ccf000000b0035bc5a51df3mr597262ywc.132.1664987576017; Wed, 05
 Oct 2022 09:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220913140817.GA9091@hu-pkondeti-hyd.qualcomm.com>
 <20220915062027.GA14713@hu-pkondeti-hyd.qualcomm.com> <CAJuCfpE_nM2uqixnds0d6wbsz4=OQ3KPoJ5HOqDhQXaxFGxwXQ@mail.gmail.com>
 <CAJuCfpEeNzDQ-CvMN3fP5LejOzpnfgUgvkzpPj1CLF-8NqNoww@mail.gmail.com>
In-Reply-To: <CAJuCfpEeNzDQ-CvMN3fP5LejOzpnfgUgvkzpPj1CLF-8NqNoww@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 5 Oct 2022 09:32:44 -0700
Message-ID: <CAJuCfpFr3JfwkWbDqkU=NUJbCYuCWGySwNusMCdmS3z95WD2AQ@mail.gmail.com>
Subject: Re: PSI idle-shutoff
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
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

On Sun, Oct 2, 2022 at 11:11 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Fri, Sep 16, 2022 at 10:45 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Wed, Sep 14, 2022 at 11:20 PM Pavan Kondeti
> > <quic_pkondeti@quicinc.com> wrote:
> > >
> > > On Tue, Sep 13, 2022 at 07:38:17PM +0530, Pavan Kondeti wrote:
> > > > Hi
> > > >
> > > > The fact that psi_avgs_work()->collect_percpu_times()->get_recent_times()
> > > > run from a kworker thread, PSI_NONIDLE condition would be observed as
> > > > there is a RUNNING task. So we would always end up re-arming the work.
> > > >
> > > > If the work is re-armed from the psi_avgs_work() it self, the backing off
> > > > logic in psi_task_change() (will be moved to psi_task_switch soon) can't
> > > > help. The work is already scheduled. so we don't do anything there.
> >
> > Hi Pavan,
> > Thanks for reporting the issue. IIRC [1] was meant to fix exactly this
> > issue. At the time it was written I tested it and it seemed to work.
> > Maybe I missed something or some other change introduced afterwards
> > affected the shutoff logic. I'll take a closer look next week when I'm
> > back at my computer and will consult with Johannes.
>
> Sorry for the delay. I had some time to look into this and test psi
> shutoff on my device and I think you are right. The patch I mentioned
> prevents new psi_avgs_work from being scheduled when the only non-idle
> task is psi_avgs_work itself, however the regular 2sec averaging work
> will still go on. I think we could record the fact that the only
> active task is psi_avgs_work in record_times() using a new
> psi_group_cpu.state_mask flag and then prevent psi_avgs_work() from
> rescheduling itself if that flag is set for all non-idle cpus. I'll
> test this approach and will post a patch for review if that works.

Hi Pavan,
Testing PSI shutoff on Android proved more difficult than I expected.
Lots of tasks to silence and I keep encountering new ones.
The approach I was thinking about is something like this:

---
 include/linux/psi_types.h |  3 +++
 kernel/sched/psi.c        | 12 +++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index c7fe7c089718..8d936f22cb5b 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -68,6 +68,9 @@ enum psi_states {
         NR_PSI_STATES = 7,
 };

+/* state_mask flag to keep re-arming averaging work */
+#define PSI_STATE_WAKE_CLOCK        (1 << NR_PSI_STATES)
+
 enum psi_aggregators {
         PSI_AVGS = 0,
         PSI_POLL,
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index ecb4b4ff4ce0..dd62ad28bacd 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -278,6 +278,7 @@ static void get_recent_times(struct psi_group
*group, int cpu,
                 if (delta)
                         *pchanged_states |= (1 << s);
         }
+        *pchanged_states |= (state_mask & PSI_STATE_WAKE_CLOCK);
 }

 static void calc_avgs(unsigned long avg[3], int missed_periods,
@@ -413,7 +414,7 @@ static void psi_avgs_work(struct work_struct *work)
         struct delayed_work *dwork;
         struct psi_group *group;
         u32 changed_states;
-        bool nonidle;
+        bool wake_clock;
         u64 now;

         dwork = to_delayed_work(work);
@@ -424,7 +425,7 @@ static void psi_avgs_work(struct work_struct *work)
         now = sched_clock();

         collect_percpu_times(group, PSI_AVGS, &changed_states);
-        nonidle = changed_states & (1 << PSI_NONIDLE);
+        wake_clock = changed_states & PSI_STATE_WAKE_CLOCK;
         /*
          * If there is task activity, periodically fold the per-cpu
          * times and feed samples into the running averages. If things
@@ -435,7 +436,7 @@ static void psi_avgs_work(struct work_struct *work)
         if (now >= group->avg_next_update)
                 group->avg_next_update = update_averages(group, now);

-        if (nonidle) {
+        if (wake_clock) {
                 schedule_delayed_work(dwork, nsecs_to_jiffies(
                                 group->avg_next_update - now) + 1);
         }
@@ -742,6 +743,11 @@ static void psi_group_change(struct psi_group
*group, int cpu,
         if (unlikely(groupc->tasks[NR_ONCPU] && cpu_curr(cpu)->in_memstall))
                 state_mask |= (1 << PSI_MEM_FULL);

+        if (wake_clock || test_state(groupc->tasks, PSI_NONIDLE)) {
+                /* psi_avgs_work was not the only task on the CPU */
+                state_mask |= PSI_STATE_WAKE_CLOCK;
+        }
+
         groupc->state_mask = state_mask;

         write_seqcount_end(&groupc->seq);
-- 

This should detect the activity caused by psi_avgs_work() itself and
ignore it when deciding to reschedule the averaging work. In the
formula you posted:

non_idle_time = (work_start_now - wakeup_now) + (sleep_prev - work_end_prev)

the first term is calculated only if the PSI state is still active
(https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L271).
psi_group_change() will reset that state if psi_avgs_work() was the
only task on that CPU, so it won't affect non_idle_time. The code
above is to take care of the second term. Could you please check if
this approach helps? As I mentioned I'm having trouble getting all the
tasks silent on Android for a clear test.

The issue with deferrable timers that you mentioned, how often does
that happen? If it happens only occasionally and prevents PSI shutoff
for a couple of update cycles then I don't think that's a huge
problem. Once PSI shutoff happens it should stay shut. Is that the
case?
Thanks,
Suren.


> Thanks,
> Suren.
>
> > Thanks,
> > Suren.
> >
> > [1] 1b69ac6b40eb "psi: fix aggregation idle shut-off"
> >
> > > >
> > > > Probably I am missing some thing here. Can you please clarify how we
> > > > shut off re-arming the psi avg work?
> > > >
> > >
> > > I have collected traces on an idle system (running android12-5.10 with minimal
> > > user space). This is a older kernel, however the issue remain on latest kernel
> > > as per code inspection.
> > >
> > > I have eliminated noise created by other work items. For example, vmstat_work.
> > > This is a deferrable work but gets executed since this is queued on the same
> > > CPU on which PSI work timer is queued. So I have increased
> > > sysctl_stat_interval to 60 * HZ to supress this work.
> > >
> > > As we can see from the traces, CPU#7 comes out of idle only to execute PSI
> > > work for every 2 seconds. The work is always re-armed from the psi_avgs_work()
> > > as it finds PSI_NONIDLE condition. The non-idle time is essentially
> > >
> > > non_idle_time = (work_start_now - wakeup_now) + (sleep_prev - work_end_prev)
> > >
> > > The first term accounts the non-idle time since the task woken up (queued) to
> > > the execution of the work item. It is around ~4 usec (54.119420 - 54.119416)
> > >
> > > The second term account for the previous update. ~2 usec (52.135424 -
> > > 52.135422).
> > >
> > > PSI work needs to be run when there is some activity after the last update is done
> > > i.e last time the work is run. Since we use non-deferrable timer, the other
> > > deferrable timers gets woken up and they might queue work or wakeup other threads
> > > and creates activity which inturn makes PSI work to be scheduled.
> > >
> > > PSI work can't just be made deferrable work. Because, it is a system level
> > > work and if the CPU on which it is queued is idle for longer duration but the
> > > other CPUs are active, we miss PSI updates. What we probably need is a global
> > > deferrable timers [1] i.e this timer should not be bound to any CPU but
> > > run when any of the CPU comes out of idle. As long as one CPU is busy, we keep
> > > running the PSI but if the whole system is idle, we never wakeup.
> > >
> > >           <idle>-0     [007]    52.135402: cpu_idle:             state=4294967295 cpu_id=7
> > >           <idle>-0     [007]    52.135415: workqueue_activate_work: work struct 0xffffffc011bd5010
> > >           <idle>-0     [007]    52.135417: sched_wakeup:         comm=kworker/7:3 pid=196 prio=120 target_cpu=007
> > >           <idle>-0     [007]    52.135421: sched_switch:         prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/7:3 next_pid=196 next_prio=120
> > >      kworker/7:3-196   [007]    52.135421: workqueue_execute_start: work struct 0xffffffc011bd5010: function psi_avgs_work
> > >      kworker/7:3-196   [007]    52.135422: timer_start:          timer=0xffffffc011bd5040 function=delayed_work_timer_fn expires=4294905814 [timeout=494] cpu=7 idx=123 flags=D|P|I
> > >      kworker/7:3-196   [007]    52.135422: workqueue_execute_end: work struct 0xffffffc011bd5010: function psi_avgs_work
> > >      kworker/7:3-196   [007]    52.135424: sched_switch:         prev_comm=kworker/7:3 prev_pid=196 prev_prio=120 prev_state=I ==> next_comm=swapper/7 next_pid=0 next_prio=120
> > >           <idle>-0     [007]    52.135428: cpu_idle:             state=0 cpu_id=7
> > >
> > >           <system is idle and gets woken up after 2 seconds due to PSI work>
> > >
> > >           <idle>-0     [007]    54.119402: cpu_idle:             state=4294967295 cpu_id=7
> > >           <idle>-0     [007]    54.119414: workqueue_activate_work: work struct 0xffffffc011bd5010
> > >           <idle>-0     [007]    54.119416: sched_wakeup:         comm=kworker/7:3 pid=196 prio=120 target_cpu=007
> > >           <idle>-0     [007]    54.119420: sched_switch:         prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/7:3 next_pid=196 next_prio=120
> > >      kworker/7:3-196   [007]    54.119420: workqueue_execute_start: work struct 0xffffffc011bd5010: function psi_avgs_work
> > >      kworker/7:3-196   [007]    54.119421: timer_start:          timer=0xffffffc011bd5040 function=delayed_work_timer_fn expires=4294906315 [timeout=499] cpu=7 idx=122 flags=D|P|I
> > >      kworker/7:3-196   [007]    54.119422: workqueue_execute_end: work struct 0xffffffc011bd5010: function psi_avgs_work
> > >
> > > [1]
> > > https://lore.kernel.org/lkml/1430188744-24737-1-git-send-email-joonwoop@codeaurora.org/
> > >
> > > Thanks,
> > > Pavan
