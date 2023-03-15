Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91BD6BAD8A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjCOKW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjCOKWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:22:25 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064A1B777
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:21:43 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i5so19505221pla.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678875702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AQQJ0Uf0eLIb6Ygg4GpKqNPBMj3ruRX/H8PY5MFTtkY=;
        b=RlqJAVUedD3SEFw/YVmD+IEKiTmgu+qhrKhMsjVv6+A+avNimVf9DH1nASFX4rtrtd
         +Xnsw4KJngv1RxNNi/wAzAlsWdFql4FEnRkBU2QHZ3qEQ//DVlLnEsk97JDifq/k9d7P
         pKIw/NNJgnuLU/piHDjKJSP2wPnyxonviLrOCi9oHk78TdCgsNVcLm+tiqE25kC2GuRz
         1jwiQ0QkxcTKM6IYq5SecNZPAg+MIzfAIyTZYLUaqJv4Um6Tu97XQR0B9ZZBQ983ovaK
         oshOhMUBjTm4REoPT618yKHxajvi/hqs6IJCCqf3lMZo4SS4WTxGXKkijzhP821EWcEH
         q/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678875702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQQJ0Uf0eLIb6Ygg4GpKqNPBMj3ruRX/H8PY5MFTtkY=;
        b=F0u8NtmcS3Gq+3jbppbKzXkmzLJqBC/y5PK5dEWohBdNHpd6ah6JdICbHtv08+RSjB
         AvU+RfNJFJJvD3h2gL7sHLvB9ZupBk9wxh5rU9cHv/WglDy4j2/XciQhZX1utV/oeQ8o
         qWPrrF99vTDNbkXvPFE6tM1Loa5G/XfTtfSejqhcO1R0FxhXMNgxSgqOtXRFDEfeVEgD
         1YgUSSYYUEOKJjceS5ygvDTPZtqryGKL3xqkUxs59TuiUpi8HOja1NF2nmo9bKAr5aJU
         oDjlCXLtPSJsjdL3zZZVHHnLBQxZ3k1Rduc+welwPnYxt7Ah2ZpxcAoA/DUUsqj9Bqtb
         1Nvw==
X-Gm-Message-State: AO0yUKUl4H9tokXq8+O19AUNDlpVeKG7F77tWokJAXGk+mzXouHW/rjT
        B6IuxrZdsRi31SuvvXmnSmZK1eg/rW+Om9F7hRgDGw==
X-Google-Smtp-Source: AK7set+c0evLYxigXDHnozOSaMMMQcszmAqSAJcJLLC8mZFOLK6WPTTqsONkfW0dEa7jxuoPZQQNm+wOQ9mFLgM2qvo=
X-Received: by 2002:a17:90a:d590:b0:234:13dc:4a9e with SMTP id
 v16-20020a17090ad59000b0023413dc4a9emr14811889pju.3.1678875702298; Wed, 15
 Mar 2023 03:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAKfTPtAf5RrzZRSHtfK+r3QvnFQ-oM3+rJ-z5SB8T4+nUv1aQw@mail.gmail.com>
 <20230309142825.GB273121@hirez.programming.kicks-ass.net> <ZAnvCGdlOrWbIC/o@hirez.programming.kicks-ass.net>
 <CAKfTPtADUas2QHZCQyu0ad-JTKRQ=PcsB=o7+PuJNVxHwAzkCQ@mail.gmail.com>
 <ZAs+zV0o9ShO7nLT@vingu-book> <02a08042-e7c4-464d-bc20-9ec4ccdab1ff@arm.com>
 <8c093661-7431-00d8-d703-b8f7a7c8e747@arm.com> <CAKfTPtBw9SJxVBcN1qff7jRzE81kXSjbc-rXD6goEBFiXEwbyg@mail.gmail.com>
 <20230314120726.GG1845660@hirez.programming.kicks-ass.net>
 <CAKfTPtBHocw4N-YMHeqfMj78Ro=aF8sJPanxVCN=tM70hr6r8g@mail.gmail.com>
 <20230314171607.GN2017917@hirez.programming.kicks-ass.net>
 <CAKfTPtBurhAxcykDWQHoSZ0aiokgK4jhamdh-F29643cL1jVsw@mail.gmail.com>
 <CAKfTPtCra1QV32w1MZQY2SHVDv58m2MT2QwpHu0huJJ3B1wcCA@mail.gmail.com> <5527ad0e-0f6d-fb4c-7505-a1c80192ed3b@arm.com>
In-Reply-To: <5527ad0e-0f6d-fb4c-7505-a1c80192ed3b@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 15 Mar 2023 11:21:30 +0100
Message-ID: <CAKfTPtDfnersgtWQy7Qxq1x1Y6BZP-6K95gcQB1Mi0RaU3TpYg@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rkagan@amazon.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 at 11:15, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 15/03/2023 09:42, Vincent Guittot wrote:
> > On Wed, 15 Mar 2023 at 08:18, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> >>
> >> On Tue, 14 Mar 2023 at 18:16, Peter Zijlstra <peterz@infradead.org> wrote:
> >>>
> >>> On Tue, Mar 14, 2023 at 02:24:37PM +0100, Vincent Guittot wrote:
> >>>
> >>>>> @@ -7632,11 +7646,8 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
> >>>>>          * min_vruntime -- the latter is done by enqueue_entity() when placing
> >>>>>          * the task on the new runqueue.
> >>>>>          */
> >>>>> -       if (READ_ONCE(p->__state) == TASK_WAKING) {
> >>>>> -               struct cfs_rq *cfs_rq = cfs_rq_of(se);
> >>>>> -
> >>>>> +       if (READ_ONCE(p->__state) == TASK_WAKING || reset_vruntime(cfs_rq, se))
> >>>>
> >>>> That's somehow what was proposed in one of the previous proposals but
> >>>> we can't call rq_clock_task(rq_of(cfs_rq)) because rq lock might not
> >>>> be hold and rq task clock has not been updated before being used
> >>>
> >>> Argh indeed. I spend a lot of time ensuring we didn't take the old rq
> >>> lock on wakeup -- and then a lot of time cursing about how we don't :-)
> >>>
> >>> Now, if we could rely on the rq-clock being no more than 1 tick behind
> >>> current, this would still be entirely sufficient to catch the long sleep
> >>> case.
> >>
> >> We should also take care when loading rq_clock_task that we are not
> >> racing with an update especially for a 32bits system like pelt
> >> last_update_time
> >
> > We still have this possibility:
> > https://lore.kernel.org/lkml/ZAiFxWLSb9HDazSI@vingu-book/
> >
> > which uses pelt last_update_time when migrating and keep using
> > rq_clock_task in place_entity
>
> Isn't there an issue with this approach on asymmetric CPU capacity systems?
>
> We do a sync_entity_load_avg() in select_task_rq_fair()
> (find_energy_efficient_cpu() for EAS and select_idle_sibling() for CAS)
> to sync cfs_rq and se.

ah yes, I forgot this point.
That being said, is it a valid problem for EAS based system ? I mean
we are trying to fix a vruntime comparison overflow that can happen
with a very long sleeping task (around 200 days) while only a very low
weight entity is always running  during those 200 days.

>
> [...]
>
