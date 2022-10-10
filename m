Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B415F9B94
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiJJJCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiJJJCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:02:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B5413F01
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 02:02:01 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29A8aBLT017227;
        Mon, 10 Oct 2022 09:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=Run2Si5vlheDSNxdT+KRMD9hcnQjrmBkaFer1IZSy4A=;
 b=JoaPPHtvx7a0DF69FOVU2/EAtUSEQpa1r2UqMMQkC2tl6InfGrEr0dkN1PZ1CVfvjJVl
 w2KaPpGofpZZ/6wFnrsuUFybz8P34eTPafFJxyXltmFjpANj6RwobiO8MGuB9hXkxF8U
 i0lOkr6neZ6E7wn8ScbP56FU+jKnqsYk1TjOFYCKuT10BuGddtOHdF3kE6kA7kvIAsdT
 PejlE1aPqVIlqKcZPHCsLwFBmyhL3pcWAYki0x4iOQvzbQJjpPPfjqjPOQx+aJjxduPo
 Y6oqDPZmwKHjvWe2KWZBv6VJq/+DEXGTlZP+nS1sEdivMQjQIFy10rLLPevGi0cSO6mn TA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k32csbpjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 09:01:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29A91wmT014591
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 09:01:58 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 10 Oct 2022 02:01:56 -0700
Date:   Mon, 10 Oct 2022 14:31:52 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     Suren Baghdasaryan <surenb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: PSI idle-shutoff
Message-ID: <20221010090152.GE1474@hu-pkondeti-hyd.qualcomm.com>
References: <20220913140817.GA9091@hu-pkondeti-hyd.qualcomm.com>
 <20220915062027.GA14713@hu-pkondeti-hyd.qualcomm.com>
 <CAJuCfpE_nM2uqixnds0d6wbsz4=OQ3KPoJ5HOqDhQXaxFGxwXQ@mail.gmail.com>
 <CAJuCfpEeNzDQ-CvMN3fP5LejOzpnfgUgvkzpPj1CLF-8NqNoww@mail.gmail.com>
 <CAJuCfpFr3JfwkWbDqkU=NUJbCYuCWGySwNusMCdmS3z95WD2AQ@mail.gmail.com>
 <20221010055714.GA1474@hu-pkondeti-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221010055714.GA1474@hu-pkondeti-hyd.qualcomm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WvhLc2u7op4LcLw1NBtF_AdJMX1UYW0-
X-Proofpoint-ORIG-GUID: WvhLc2u7op4LcLw1NBtF_AdJMX1UYW0-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210100054
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 11:27:14AM +0530, Pavan Kondeti wrote:
> On Wed, Oct 05, 2022 at 09:32:44AM -0700, Suren Baghdasaryan wrote:
> > On Sun, Oct 2, 2022 at 11:11 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Fri, Sep 16, 2022 at 10:45 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > On Wed, Sep 14, 2022 at 11:20 PM Pavan Kondeti
> > > > <quic_pkondeti@quicinc.com> wrote:
> > > > >
> > > > > On Tue, Sep 13, 2022 at 07:38:17PM +0530, Pavan Kondeti wrote:
> > > > > > Hi
> > > > > >
> > > > > > The fact that psi_avgs_work()->collect_percpu_times()->get_recent_times()
> > > > > > run from a kworker thread, PSI_NONIDLE condition would be observed as
> > > > > > there is a RUNNING task. So we would always end up re-arming the work.
> > > > > >
> > > > > > If the work is re-armed from the psi_avgs_work() it self, the backing off
> > > > > > logic in psi_task_change() (will be moved to psi_task_switch soon) can't
> > > > > > help. The work is already scheduled. so we don't do anything there.
> > > >
> > > > Hi Pavan,
> > > > Thanks for reporting the issue. IIRC [1] was meant to fix exactly this
> > > > issue. At the time it was written I tested it and it seemed to work.
> > > > Maybe I missed something or some other change introduced afterwards
> > > > affected the shutoff logic. I'll take a closer look next week when I'm
> > > > back at my computer and will consult with Johannes.
> > >
> > > Sorry for the delay. I had some time to look into this and test psi
> > > shutoff on my device and I think you are right. The patch I mentioned
> > > prevents new psi_avgs_work from being scheduled when the only non-idle
> > > task is psi_avgs_work itself, however the regular 2sec averaging work
> > > will still go on. I think we could record the fact that the only
> > > active task is psi_avgs_work in record_times() using a new
> > > psi_group_cpu.state_mask flag and then prevent psi_avgs_work() from
> > > rescheduling itself if that flag is set for all non-idle cpus. I'll
> > > test this approach and will post a patch for review if that works.
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

I have added an else block here and it is never hit.

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
> 
> Thanks Suren for taking a look. I was not at work last week, so could not
> reply earlier. 
> 
> As chengming pointed out already, when kworker is woken up (some tasks ran in
> the last window, so we scheudled a work. now kworker woke up when system is
> idle), PSI_NONIDLE condition will be true here,  we end up setting the
> PSI_STATE_WAKE_CLOCK flag. Correct? Any ways, I am going to test this patch and
> report my observations.
> 
I have tested this patch and it did not help i.e PSI work has been re-armed
periodically.

Thanks,
Pavan
