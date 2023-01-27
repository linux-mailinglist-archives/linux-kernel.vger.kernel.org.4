Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0FA67F11A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjA0W3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjA0W3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:29:30 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C716086EBF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:29:28 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m7-20020a17090a71c700b0022c0c070f2eso9322195pjs.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tBDTJUFvOvLe8zxVo3fN71Ve2f8EQzmQK5VcIUe+DW4=;
        b=dI8Uc8ZeGmmKvwcvrW1r6U90XYaOeH7k9bGWvMC2B3U6aBWv24EHMIJDabHFN68Jdc
         0GeAN31Kgtad8Jt1lYjcniqmjOvFvUsoSJB5I34SrTK3+GLzjx5E8beTmrXL+FH6tgph
         ndKgXV1r6VanZBmYReyzDWmutPJR+inORkj39EU+ip4DPxsQFCQlP/ptlDiOnnVzYCF9
         zAgyUlbbBrHvlIGncOXJJ3rxO9p6OCTEmkyriUF8+bPxl52Lq9RvMIsoXj3RIXtjrvMU
         4TkSbXaTE8ElgJ0DmyztEFREtxgZAzIGntPJ5XKuAPsjGOoV0CqmJdlzAHg5HN+3yqt8
         EzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBDTJUFvOvLe8zxVo3fN71Ve2f8EQzmQK5VcIUe+DW4=;
        b=sgvFlNgu0XGlxz1pyIxlOQ1dMFs2vc3S60X9oPX5WbpTc/XVT4ZxzDUbH0v9d9LbPP
         i//2WqRtx6ar4TmKc6LJJs9KDqYvyVEk4noXLzxQsfCAM+ApupFEknbadLMzucWLBgIs
         NUs8laMOo+YSt2uKR4v1cOYpHSPCtdWv8XYC8INwXoJRuOjo0yv+sAUX2N0DKDNNnDYj
         jB2korCyLDDCmhRZFSQNasOr6PS3TmBjRFLoHTrcLt8gsCJjT383nD6FW1ELKaKBtY97
         tq7WDWShizZL0w1hWahiAGMYUGzQp44SrXEWOyEezkG7eAsAlWzub4B2cThuohVg+osV
         5i6A==
X-Gm-Message-State: AO0yUKUCpbK4P6iTdlB0AEB9CzsGm4YPmBNCbZV7dGGrP9/OsiK5mPZT
        Ad2ophhJqRtJtMPym4jggyrxEw3RDCxQ1ZSQZjrPJw==
X-Google-Smtp-Source: AK7set8T/qv93wAgM/ZyOlrx9hNItAMM2Ck32gQb/PF6EHV1/En8vzDVl18DrAyo/AHdjjBAp+7QEUl3clPEwlai/HE=
X-Received: by 2002:a17:90a:c204:b0:22c:1613:164f with SMTP id
 e4-20020a17090ac20400b0022c1613164fmr1364669pjt.103.1674858568225; Fri, 27
 Jan 2023 14:29:28 -0800 (PST)
MIME-Version: 1.0
References: <73e639d5-702b-0d03-16d9-a965b1963ef6@huawei.com>
 <Y6RRfF5yRew7rdCp@hirez.programming.kicks-ass.net> <Y9GG3N5ivVvyETa2@u40bc5e070a0153.ant.amazon.com>
 <Y9J25xMrItpeHIxD@hirez.programming.kicks-ass.net> <Y9LG5vkf/4ufJb35@u40bc5e070a0153.ant.amazon.com>
 <Y9O5Fwfib2CVAMwl@hirez.programming.kicks-ass.net> <CAKfTPtBMSg2SDXq=sVt99TyM+tEXRFL74EQ57-t5uKYAXUUyLg@mail.gmail.com>
 <xm26v8kr7ho0.fsf@google.com>
In-Reply-To: <xm26v8kr7ho0.fsf@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 27 Jan 2023 23:29:16 +0100
Message-ID: <CAKfTPtBaL06+EFUscYqgA=psTV4r-MxVwxyKHXDXppWPD2ku0w@mail.gmail.com>
Subject: Re: [bug-report] possible s64 overflow in max_vruntime()
To:     Benjamin Segall <bsegall@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Roman Kagan <rkagan@amazon.de>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 at 23:10, Benjamin Segall <bsegall@google.com> wrote:
>
> Vincent Guittot <vincent.guittot@linaro.org> writes:
>
> > On Fri, 27 Jan 2023 at 12:44, Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >> On Thu, Jan 26, 2023 at 07:31:02PM +0100, Roman Kagan wrote:
> >>
> >> > > All that only matters for small sleeps anyway.
> >> > >
> >> > > Something like:
> >> > >
> >> > >         sleep_time = U64_MAX;
> >> > >         if (se->avg.last_update_time)
> >> > >           sleep_time = cfs_rq_clock_pelt(cfs_rq) - se->avg.last_update_time;
> >> >
> >> > Interesting, why not rq_clock_task(rq_of(cfs_rq)) - se->exec_start, as
> >> > others were suggesting?  It appears to better match the notion of sleep
> >> > wall-time, no?
> >>
> >> Should also work I suppose. cfs_rq_clock takes throttling into account,
> >> but that should hopefully also not be *that* long, so either should
> >> work.
> >
> > yes rq_clock_task(rq_of(cfs_rq)) should be fine too
>
> No, last_update_time is based on cfs_rq_clock_pelt(cfs_rq), and it will
> get more and more out of sync as time goes on, every time the cfs_rq
> throttles. It won't reset when the throttle is done.

I was referring to the rq_clock_task(rq_of(cfs_rq)) - se->exec_start
that Roman was asking for

>
> >
> > Another thing to take into account is the sleeper credit that the
> > waking task deserves so the detection should be done once it has been
> > subtracted from vruntime.
> >
> > Last point, when a nice -20 task runs on a rq, it will take a bit more
> > than 2 seconds for the vruntime to be increased by more than 24ms (the
> > maximum credit that a waking task can get) so threshold must be
> > significantly higher than 2 sec. On the opposite side, the lowest
> > possible weight of a cfs rq is 2 which means that the problem appears
> > for a sleep longer or equal to 2^54 = 2^63*2/1024. We should use this
> > value instead of an arbitrary 200 days
