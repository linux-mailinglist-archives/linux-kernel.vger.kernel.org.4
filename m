Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED2169D217
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjBTRZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjBTRZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:25:06 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13381BAD7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:25:05 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d7so1030893pfu.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GYPNxU6t8e7LjRfjaXJ+KRtP+S5u0n0SUVUkP+iTG08=;
        b=zRVVAHMeGtGSGx1xQjCd75hZfzooyrjnIJ4yEy2oGcOHNM1l+QSHlV7F5DUqJgfd4L
         sBTLV97sP+24h3HuKy/4tTZ6gqaYFw8noYcuOM4ZWGIhLauVQ3PSmXL2QClMypnnsDej
         9GB46c5vXbzlDqjPjDpLPxGkECAyhs3mV0p4Zx3ZU41w7E/94frIE69t32pdb3AJQl9n
         +MDXoSXBsm6BvpcNy2Z8d2gcsm0IPK7VpJ3nV8CflukcZOUwB0ixt4ofcdBKnBGATnKV
         piEa0+K9aZ5p56g8tzN7q1qbgPFY3BsO/mIhPM6c6NcNIBjUWxtP6spuUeM15zkKVA87
         Ilkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYPNxU6t8e7LjRfjaXJ+KRtP+S5u0n0SUVUkP+iTG08=;
        b=hvRwsmFebobhWbHl27m3glW5L4GMwxRj2TZ2lEY5qUt5M+K/+UMLaOfuXv4RoimQ0E
         M5BuUVoR0Kp9cLw3AV8myjPU2ka5+wodfk9NNWTqexxll1K4wMQ+D1MiUoOyVNGx8DsX
         g2Tb4ZzLhZ13keTCteHG7QS5rZs7/+M7yhgyw4wyYl5hUJEJKrQHLTYqT8d7JY8mUP6Z
         mh7pm4xtkSuPz55wNZb0cArcNSLgbdhJEFOeN+H5GX5Oo5A3KAkTFO0Lg6h+enf5XNe8
         iwwF5iIsolXgvSbTqfgPOUMiaJfW3kXSPwZs7m+GtNPAuFqit3xKqh4WE8vbG38v0Upo
         QaVg==
X-Gm-Message-State: AO0yUKVru2cichIn5/Fd0/tqD6aFSXsPGj6Y1BkY2w3KCRvfCZCm126H
        7EOQiCjkYVZizfSTB+4WSBrNYvRCsKN8exT2NezNbw==
X-Google-Smtp-Source: AK7set8OQLVJ2Umc/3kkqk1htcUx25yEJUbXhEH6ClR7LbLS4GFrGuMTv4uNQvczyIsiaHP3UEGUL/L3xjNsDRC1ECA=
X-Received: by 2002:a05:6a00:be3:b0:5a9:b27e:af42 with SMTP id
 x35-20020a056a000be300b005a9b27eaf42mr435979pfu.6.1676913905010; Mon, 20 Feb
 2023 09:25:05 -0800 (PST)
MIME-Version: 1.0
References: <20230205224318.2035646-1-qyousef@layalina.io> <20230205224318.2035646-3-qyousef@layalina.io>
 <CAKfTPtCf4+orEhYmFBg+tsMH7e5sV5zJZ1k8apjZkYwSAxAu+w@mail.gmail.com>
 <d7f29def-7004-b62d-9266-3ad997111e2f@arm.com> <20230211180119.4mbfn7j3skvoasop@airbuntu>
 <d7b319cc-5c02-df0f-44d5-cd3aa2bd2474@arm.com>
In-Reply-To: <d7b319cc-5c02-df0f-44d5-cd3aa2bd2474@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 20 Feb 2023 18:24:53 +0100
Message-ID: <CAKfTPtBXSSRu4hxr3HnJ2VmedGL122aHZteZMJaeuur537sdeQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] sched/uclamp: Ignore (util == 0) optimization in
 feec() when p_util_max = 0
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 at 13:47, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 11/02/2023 19:01, Qais Yousef wrote:
> > On 02/08/23 12:52, Dietmar Eggemann wrote:
> >> On 07/02/2023 11:04, Vincent Guittot wrote:
> >>> On Sun, 5 Feb 2023 at 23:43, Qais Yousef <qyousef@layalina.io> wrote:
> >>>>
> >>>> find_energy_efficient_cpu() bails out early if effective util of the
> >>>> task is 0. When uclamp is being used, this could lead to wrong decisions
> >>>> when uclamp_max is set to 0. Cater for that.
> >>
> >> IMHO this needs a little bit more explanation. Someone could argue that
> >> 'util > 0, uclamp_min=0, uclamp_max=0' is a valid setup for a task which
> >> should let it appear as a task with 0 util (capped to 0).
> >
> > You want me to explain the purpose of the optimization then?
> >
> > The optimization skips energy calculation when util is 0 because the delta will
> > be 0. But when uclamp_max = 0 util is not really 0 - consequently  the delta
>
> I would say:
>
> s/really/necessarily
> s/delta/energy delta
>
> > will not be 0.
> >
> > Would such an explanation clarify things better?
>
> Yes. It key to understand that there is a 2-step process. First,
> admittance to a possible target (util and uclamp) and second, energy
> diff based target-selection (util).
>
> >>>> Fixes: d81304bc6193 ("sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s early exit condition")
> >>>> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> >>>> ---
> >>>>  kernel/sched/fair.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>>> index 7a21ee74139f..a8c3d92ff3f6 100644
> >>>> --- a/kernel/sched/fair.c
> >>>> +++ b/kernel/sched/fair.c
> >>>> @@ -7374,7 +7374,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >>>>         target = prev_cpu;
> >>>>
> >>>>         sync_entity_load_avg(&p->se);
> >>>> -       if (!uclamp_task_util(p, p_util_min, p_util_max))
> >>>> +       if (!uclamp_task_util(p, p_util_min, p_util_max) && p_util_max != 0)
> >>>
> >>> The below should do the same without testing twice p_util_max:
> >>> uclamp_task_util(p, p_util_min, ULONG_MAX)
> >>
> >> Since uclamp_task_util() is only used here and we don't want to test for
> >> capping to 0 anymore, why not just get rid of this function and use:
> >>
> >>   !(task_util_est(p) || p_util_min)
> >
> > That would be better, yes!
> >
> > Question for you and Vincent. Do we really want this optimization? I started
> > with removing it - then erred on the conservative side and kept it.
>
> Hard to say ... at least we know that util=0 will have absolutely no
> effect on task placement. So we can spare the heavy EAS algorithm in
> this case for sure.
>
> > I don't know how often we hit this case and I didn't see any benchmark run to
> > be able to verify anything when I looked at the history.
>
> There are very few EAS wakeups with `task_util_est(p) = 0`. Probably not
> relevant.
>
> > It seems helpful in theory - but why we save something if we ignore 0 but not
> > 1 which I suspect will not produce a significant delta either.
>
> True, it's hard to find the real line of significance here.
>
> > I don't mind keeping it - but I think worth thinking if it is really adding
> > much.
>
> I would keep it and just remove uclamp_task_util(). We still have a lot
> of uclamp/util related functions, we should try to keep the number as
> low as possible. Just checked it, this check has been there from the
> beginning of EAS.

Yes make sense to keep the test as proposed by Dietmar and save the cycles

>
