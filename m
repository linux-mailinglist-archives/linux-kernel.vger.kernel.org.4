Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E1E6932F1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 19:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBKSB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 13:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBKSBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 13:01:24 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB55268E
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 10:01:22 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so6181436wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 10:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uo9tC0EKACotZK/Cddb6UcgXeVdOByRK5YCjZOlIXv8=;
        b=lc3EUahjoDki5moCm8LjiRQUW1S+Hu6/lKGqlpQ6qBhGqkmsfPilPFhoQQ77P5Z0Cv
         pz2YbGa6GViJPOQhXeSd7hecsqLt/THHBe5j2Bd6bisVmPKaL6gup1LSI8HRZ2+xi+KS
         hfCep3eb94gKt795Q09MhAf7sLTQrYF4xkceskJFBDMt6gNw2m/8NOK0qotnEriKEDVA
         2WGhWmXwaFlJWjxrYm6mp2zS7Y1c9nzzUXbwuUcaL+J8jQqHdjTReu8yfG8ehAPBQ9jP
         iPhtThLRAoQ2KOPm1q/93TWqa/oa4IgBKG20iLJME5sGchmi48bmcpfFEpOqWYD8R9WT
         DlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uo9tC0EKACotZK/Cddb6UcgXeVdOByRK5YCjZOlIXv8=;
        b=nl1CGw962joBP4NN7YVN9eMMFW+u4HC5NVsbtC+6oVemOoFLifvInck//ewS2wOutq
         1dUEJ8HSU9JiNp/UCh2hsxaHVTBCrL87Izweswh8cOhCiNpqG69lJKG1XwOO5ihhGl1K
         Uxa45NVKSyipg3+I+2nkMs0rDBTg1U1VoRlfDaLAhTSZonfjpOBypF+96Kcq/9w1kxOH
         MWXibwYYDNiwv9SXDdXaaTTYUaxt28fHZCi18b6xsErJVSN7DiP9+it9SECVpxmEvS/W
         1IRwQRe4sbGlQN1q4grvce/MuOopCKiEuBS/PwSibrK9q02FOHw9L5RlCkR0VjD4kPWQ
         Iqxg==
X-Gm-Message-State: AO0yUKXbEP5Ul+7KUNJayexS0WVCd3KJNl2QqWRf8zfrPW0tSwNgOzIR
        dYCpKs0r5/Djehx1GYoBpXmzBA==
X-Google-Smtp-Source: AK7set9wHz2tT/B/MQNwGsssdWjMeRTS00ceKlUj1xwLw3XqEu2/8GxcAT61rQYyhoLX7QZGBHQ4Jw==
X-Received: by 2002:a05:600c:18a0:b0:3df:3bd6:63e5 with SMTP id x32-20020a05600c18a000b003df3bd663e5mr14881360wmp.12.1676138481424;
        Sat, 11 Feb 2023 10:01:21 -0800 (PST)
Received: from airbuntu (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b003da28dfdedcsm9802746wmq.5.2023.02.11.10.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 10:01:21 -0800 (PST)
Date:   Sat, 11 Feb 2023 18:01:19 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Subject: Re: [PATCH v2 2/3] sched/uclamp: Ignore (util == 0) optimization in
 feec() when p_util_max = 0
Message-ID: <20230211180119.4mbfn7j3skvoasop@airbuntu>
References: <20230205224318.2035646-1-qyousef@layalina.io>
 <20230205224318.2035646-3-qyousef@layalina.io>
 <CAKfTPtCf4+orEhYmFBg+tsMH7e5sV5zJZ1k8apjZkYwSAxAu+w@mail.gmail.com>
 <d7f29def-7004-b62d-9266-3ad997111e2f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d7f29def-7004-b62d-9266-3ad997111e2f@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/23 12:52, Dietmar Eggemann wrote:
> On 07/02/2023 11:04, Vincent Guittot wrote:
> > On Sun, 5 Feb 2023 at 23:43, Qais Yousef <qyousef@layalina.io> wrote:
> >>
> >> find_energy_efficient_cpu() bails out early if effective util of the
> >> task is 0. When uclamp is being used, this could lead to wrong decisions
> >> when uclamp_max is set to 0. Cater for that.
> 
> IMHO this needs a little bit more explanation. Someone could argue that
> 'util > 0, uclamp_min=0, uclamp_max=0' is a valid setup for a task which
> should let it appear as a task with 0 util (capped to 0).

You want me to explain the purpose of the optimization then?

The optimization skips energy calculation when util is 0 because the delta will
be 0. But when uclamp_max = 0 util is not really 0 - consequently  the delta
will not be 0.

Would such an explanation clarify things better?

> 
> >> Fixes: d81304bc6193 ("sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s early exit condition")
> >> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> >> ---
> >>  kernel/sched/fair.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 7a21ee74139f..a8c3d92ff3f6 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -7374,7 +7374,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >>         target = prev_cpu;
> >>
> >>         sync_entity_load_avg(&p->se);
> >> -       if (!uclamp_task_util(p, p_util_min, p_util_max))
> >> +       if (!uclamp_task_util(p, p_util_min, p_util_max) && p_util_max != 0)
> > 
> > The below should do the same without testing twice p_util_max:
> > uclamp_task_util(p, p_util_min, ULONG_MAX)
> 
> Since uclamp_task_util() is only used here and we don't want to test for
> capping to 0 anymore, why not just get rid of this function and use:
> 
>   !(task_util_est(p) || p_util_min)

That would be better, yes!

Question for you and Vincent. Do we really want this optimization? I started
with removing it - then erred on the conservative side and kept it.

I don't know how often we hit this case and I didn't see any benchmark run to
be able to verify anything when I looked at the history.

It seems helpful in theory - but why we save something if we ignore 0 but not
1 which I suspect will not produce a significant delta either.

I don't mind keeping it - but I think worth thinking if it is really adding
much.


Cheers

--
Qais Yousef
