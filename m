Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E38B5FB8FD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiJKRMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiJKRMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:12:13 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B197F6C757
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:12:11 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id e62so17232892yba.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KnLsDrpRlyfA2SNwggSxJNapTK/NC3BUKgKfLg4Iv+c=;
        b=DfClpkCStJqczyYfUb3/tTsHkX3dz2C9oKdUmETpb3hbcyXMXODTfFZ27smSo3D0bJ
         bP/VH/3up9gv7YJj5hwX+74b7Wnd2bvRwDY5cyR/RC8R/McLBwbyUt5/qTzIe3aC7NM+
         89UY0NFp2NmLzRmQRsGuDfSzxoxmUY0gl8MRs1wsp3vIbmqGXXs/tTCgbgbVRpgzAJUT
         oupMfv3H9onmYITGeHJvt3mFZj3fS99fM6UqHg3GOpuyvVQaV8Z2Poge/9/eTVyUDlQ9
         R2Tnf3V3qhcuIU3AqixGu0U1XA7by0mSmgRdGsloCf1qhSRhRG85FkqsDmrYCFlOrDN/
         AolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KnLsDrpRlyfA2SNwggSxJNapTK/NC3BUKgKfLg4Iv+c=;
        b=zCdQbubYrakNNd8320tBW7bgTY8WuwZiSeJJPeR+ZvWwIxxSBTy4OawE8qpYO8G1qZ
         rxIIsbclpGl05Bohr/nr8R+OOXq/eoaalmgA4VyzI2FuQS2UMTorsDIl413jGVMVXIR4
         Ja9uuV6Bd4nMYJ6zgkpqI4w594iY7dIL1uWADktsoi2axWhO0ZNaKFw/UlXLniGE4buM
         gL8ma3ssE8dK5xY34cr7xsPfmEmYDKvIz08MpAph/aMnBSHKas30lZrw7d3i2vzlpyJt
         u5k9GwWgSK07CbpMrj8yjO+eZ6VDVaPyoT9nmN1Q7XhEDCKCCOLhKb1r8/tSxE/GKZ4s
         DkOQ==
X-Gm-Message-State: ACrzQf27ymf+E8qHHqfps02Hv8ToTlAEsnfxI7zYNnqMd9i5X43P1fBm
        2CPZe46XLhUpGLTW95ffXb4yxEYcmIiyjqT0zirN3w==
X-Google-Smtp-Source: AMsMyM7ehCqLm7UIuqO0H1v4PFxI3U8r1zE0+cJdP8FObg01axHVhLJRmcUW0bxfdDOWTF0gnEbq6SkRe48zKp/h/zI=
X-Received: by 2002:a25:49c6:0:b0:6bc:17dc:4441 with SMTP id
 w189-20020a2549c6000000b006bc17dc4441mr24505236yba.593.1665508329942; Tue, 11
 Oct 2022 10:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAJuCfpGN4TooWJuvoh9RZM96hW4BmuKjwnuT2pM4rGPLcGEinQ@mail.gmail.com>
 <20221011113818.340-1-hdanton@sina.com>
In-Reply-To: <20221011113818.340-1-hdanton@sina.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 11 Oct 2022 10:11:58 -0700
Message-ID: <CAJuCfpG=bADguJWdxV4ZhTze9fmKP2bhsbf0xzbd06Fhr4_U5w@mail.gmail.com>
Subject: Re: PSI idle-shutoff
To:     Hillf Danton <hdanton@sina.com>
Cc:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, quic_charante@quicinc.com
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

On Tue, Oct 11, 2022 at 4:38 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On 10 Oct 2022 14:16:26 -0700 Suren Baghdasaryan <surenb@google.com>
> > On Mon, Oct 10, 2022 at 3:57 AM Hillf Danton <hdanton@sina.com> wrote:
> > > On 13 Sep 2022 19:38:17 +0530 Pavan Kondeti <quic_pkondeti@quicinc.com>
> > > > Hi
> > > >
> > > > The fact that psi_avgs_work()->collect_percpu_times()->get_recent_times()
> > > > run from a kworker thread, PSI_NONIDLE condition would be observed as
> > > > there is a RUNNING task. So we would always end up re-arming the work.
> > > >
> > > > If the work is re-armed from the psi_avgs_work() it self, the backing off
> > > > logic in psi_task_change() (will be moved to psi_task_switch soon) can't
> > > > help. The work is already scheduled. so we don't do anything there.
> > > >
> > > > Probably I am missing some thing here. Can you please clarify how we
> > > > shut off re-arming the psi avg work?
> > >
> > > Instead of open coding schedule_delayed_work() in bid to check if timer
> > > hits the idle task (see delayed_work_timer_fn()), the idle task is tracked
> > > in psi_task_switch() and checked by kworker to see if it preempted the idle
> > > task.
> > >
> > > Only for thoughts now.
> > >
> > > Hillf
> > >
> > > +++ b/kernel/sched/psi.c
> > > @@ -412,6 +412,8 @@ static u64 update_averages(struct psi_gr
> > >         return avg_next_update;
> > >  }
> > >
> > > +static DEFINE_PER_CPU(int, prev_task_is_idle);
> > > +
> > >  static void psi_avgs_work(struct work_struct *work)
> > >  {
> > >         struct delayed_work *dwork;
> > > @@ -439,7 +441,7 @@ static void psi_avgs_work(struct work_st
> > >         if (now >= group->avg_next_update)
> > >                 group->avg_next_update = update_averages(group, now);
> > >
> > > -       if (nonidle) {
> > > +       if (nonidle && 0 == per_cpu(prev_task_is_idle, raw_smp_processor_id())) {
> >
> > This condition would be incorrect if nonidle was set by a cpu other
> > than raw_smp_processor_id() and
> > prev_task_is_idle[raw_smp_processor_id()] == 0.
>
> Thanks for taking a look.

Thanks for the suggestion!

>
> > IOW, if some activity happens on a non-current cpu, we would fail to
> > reschedule psi_avgs_work for it.
>
> Given activities on remote CPUs, can you specify what prevents psi_avgs_work
> from being scheduled on remote CPUs if for example the local CPU has been
> idle for a second?

I'm not a scheduler expert but I can imagine some work that finished
running on a big core A and generated some activity since the last
time psi_avgs_work executed.  With no other activity the next
psi_avgs_work could be scheduled on a small core B to conserve power.
There might be other cases involving cpuset limitation changes or cpu
offlining but I didn't think too hard about these. The bottom line, I
don't think we should be designing mechanisms which rely on
assumptions about how tasks will be scheduled. Even if these
assumptions are correct today they might change in the future and
things will break in unexpected places.

>
> > This can be fixed in collect_percpu_times() by
> > considering prev_task_is_idle for all other CPUs as well. However
> > Chengming's approach seems simpler to me TBH and does not require an
> > additional per-cpu variable.
>
> Good ideas are always welcome.

No question about that. Thanks!
