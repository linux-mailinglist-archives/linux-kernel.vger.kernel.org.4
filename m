Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6DD6A6AEA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 11:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCAKjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 05:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjCAKjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 05:39:20 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5363028F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 02:39:18 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so12534094pja.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 02:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uiRZ6GzHz1lxWunhGNpwfFYJSlE5ilYxWgcoTvEJxoA=;
        b=XN6NRiayd1/5F5BrlB9fIXO5yop4aeQC7avNcCJXgh48bYAjo2YUOiV47bprEr9mxp
         0c99dlxxDl/GGLAIsLDpB7QNJsH9avwXkvhRAIF8qHOnK69mT9/9clZvNnCXJNFSt/Gu
         oygu9/T2Oxmph2EsXvQrkcetdGUtL3KTh3QxDZ+ehqAcWte1kW3SjPbYgMPEUeEjxUix
         AnshqpWF4QdBWncdi5e82W5wwKgzggc3VOyluNF5y1Gwm3aFH06ntm91QieQSTFxwgfZ
         eY9vbYVDG/fOKd3RD0CnvLN/Ac8rEXUn4Km0m3oPkihIGuXw92ZESzY0sX98sXh3G4ea
         RAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uiRZ6GzHz1lxWunhGNpwfFYJSlE5ilYxWgcoTvEJxoA=;
        b=pdQGXW9gqPkF25NnZ0K0xV0PJQlpBUgEKz6ot0L5tdVvDn03EJ2DFf0KqUD3vAQoeR
         TYsnY9KOBXnbcdWXFxfyvV5YZ2U5pSWlPgW+DqRB7I/b66c2i6MdeY2rrQdn0X01fyLP
         x6qbRSvQGV2ifIUI/WLumvKtCPV/wfbJXlWAfF68AuePZP8B07/qlDmY8iUfdv2Augwq
         VQoRvDmvnzArEU0+cqB3j0bxDsFNuV4d2mQzDDoXvcO0eGQa2nvTkSLEWgnZopV+IEcP
         A/hjWkJYb1YrL9pVDEBQfFP/DHWTk50+zvzXqJN1UB0UMgXsdPdtyVcDH+BmXWF4MxUy
         IFbA==
X-Gm-Message-State: AO0yUKVXGKBWuWdzgYk9VpoGf+xV+8ODSDloadU/CYjx0WzfztiAFhho
        96PnFTjmvfbMbSz9CETXas9ToQ4N6fpjoprcDJAqJw==
X-Google-Smtp-Source: AK7set8Fr9sdM45IA0G1+WwETPy5UIAmXI5IFG7rGg6sujTThHwMjDJiA/r5SDMpRBhdAEOOLMulooCcK/ZP/ZedNCc=
X-Received: by 2002:a17:902:efd2:b0:19b:370:f7b3 with SMTP id
 ja18-20020a170902efd200b0019b0370f7b3mr2070998plb.6.1677667157868; Wed, 01
 Mar 2023 02:39:17 -0800 (PST)
MIME-Version: 1.0
References: <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net> <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net> <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net> <20221108194843.i4qckcu7zwqstyis@airbuntu>
 <Y2vMBWpPlIArwnI7@hirez.programming.kicks-ass.net> <424e2c81-987d-f10e-106d-8b4c611768bc@arm.com>
 <CAKfTPtD0ZOndFef3-JxBn3G9tcX=cZEObjHZ0iqiVTJz7+QrmQ@mail.gmail.com> <20230223153700.55zydy7jyfwidkis@airbuntu>
In-Reply-To: <20230223153700.55zydy7jyfwidkis@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 1 Mar 2023 11:39:06 +0100
Message-ID: <CAKfTPtDVGcvmR5BoJpyoOBE19PcWZP+6NjSD7MnJyBAc7VMnmg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Jian-Min Liu <jian-min.liu@mediatek.com>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2023 at 16:37, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 02/09/23 17:16, Vincent Guittot wrote:
>
> > I don't see how util_est_faster can help this 1ms task here ? It's
> > most probably never be preempted during this 1ms. For such an Android
> > Graphics Pipeline short task, hasn't uclamp_min been designed for and
> > a better solution ?
>
> uclamp_min is being used in UI and helping there. But your mileage might vary
> with adoption still.
>
> The major motivation behind this is to help things like gaming as the original
> thread started. It can help UI and other use cases too. Android framework has
> a lot of context on the type of workload that can help it make a decision when
> this helps. And OEMs can have the chance to tune and apply based on the
> characteristics of their device.
>
> > IIUC how util_est_faster works, it removes the waiting time when
> > sharing cpu time with other tasks. So as long as there is no (runnable
> > but not running time), the result is the same as current util_est.
> > util_est_faster makes a difference only when the task alternates
> > between runnable and running slices.
> > Have you considered using runnable_avg metrics in the increase of cpu
> > freq ? This takes into the runnable slice and not only the running
> > time and increase faster than util_avg when tasks compete for the same
> > CPU
>
> Just to understand why we're heading into this direction now.
>
> AFAIU the desired outcome to have faster rampup time (and on HMP faster up
> migration) which both are tied to utilization signal.
>
> Wouldn't make the util response time faster help not just for rampup, but
> rampdown too?
>
> If we improve util response time, couldn't this mean we can remove util_est or
> am I missing something?

not sure because you still have a ramping step whereas util_est
directly gives you the final tager

>
> Currently we have util response which is tweaked by util_est and then that is
> tweaked further by schedutil with that 25% margin when maping util to
> frequency.

the 25% is not related to the ramping time but to the fact that you
always need some margin to cover unexpected events and estimation
error

>
> I think if we can allow improving general util response time by tweaking PELT
> HALFLIFE we can potentially remove util_est and potentially that magic 25%
> margin too.
>
> Why the approach of further tweaking util_est is better?

note that in this case it doesn't really tweak util_est but Dietmar
has taken into account runnable_avg to increase the freq in case of
contention

Also IIUC Dietmar's results, the problem seems more linked to the
selection of a higher freq than increasing the utilization;
runnable_avg tests give similar perf results than shorter half life
and better power consumption.

>
> Recently phoronix reported that schedutil behavior is suboptimal and I wonder
> if the response time is contributing to that
>
>         https://www.phoronix.com/review/schedutil-quirky-2023
>
>
> Cheers
>
> --
> Qais Yousef
