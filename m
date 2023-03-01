Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC226A6ABF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 11:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCAKYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 05:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCAKYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 05:24:47 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D426D6A6B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 02:24:46 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id p6so7439043pga.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 02:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jra8BlpEp5tQk24mlqoulQy0sFVz/ZQsJRpaaxqzSZw=;
        b=PRVpWcAkCq7NgiCxzrtPNfvPE4AfyvLVTmgUdgmtnaeLuVbjIdcmQROp9Vcb79ELNJ
         zDUvx9QH3eKsVHIGTX4TXdGHhRqfjspOaMD/q8RIO9Cj6rfpA8G2hgwisHh9aMtSLomQ
         KlGWfzAZ4Oo3gY9SO0VRWLvdafRwIgy4KNf5AtqLcAqer/JZAOl6nlKbSbUyuyEurz3G
         c6ooHywMEwQTI8IXJrB+kspgO/RxKKtiTEg8yCoXg5PQCUn6lHhZMzF4V2gl+AVtogyS
         TOjx0U15pugCJsCgwy6yB0urYCj0msM3+TLcREDAadIqqzNzmisOS3SFc19b9vPvZGyo
         XP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jra8BlpEp5tQk24mlqoulQy0sFVz/ZQsJRpaaxqzSZw=;
        b=voq1bBIX0pZsVf2l0KfgKmCWY6b0dbz0/4Wt2UDmFfEWUGj08DSzdEuiywg9hN+JdP
         XqYt6+oEqw1MfKzGAHwi+C2rJn64uXS+gP7YN05ZMllBpIPSfxmhpPKPWl/gR673PJpy
         kGy9pv3O2H5kGpOO3KgvwjBs+4mbIoiHC2iwnDJdBpRvPvtT9+5FmGZUaagEHvW1qKji
         bPPH2OcdZSCbO6z8XiNH00JHHd+QDOlhEvVXJgh5OfcA/FP8TqUONc+u6LI7KwCivKfb
         mOzkg3slEMQ19995kORO1BBmVuV/I3k0JTM8etd5UMUL1q3XJkvntB+XYXP5r063mPEo
         DnjQ==
X-Gm-Message-State: AO0yUKW4mN3PyC+P8JT44+E6ydlrcRxZ/B3/1zJR3XTtGL3mrl3k+uWw
        TQKGCtyOCNzKmIldA08cl10E3WV/dW6F56vEp80g5Q==
X-Google-Smtp-Source: AK7set/ZPBCpLxfSahAsqJGErr+qo4LEhLG88TYoDjBzsVCAsxitIKdtsDrvWBYHHrUqcy5K2LWtemG+O9XL5AhS0dM=
X-Received: by 2002:a05:6a00:804:b0:5a8:5c7d:e4db with SMTP id
 m4-20020a056a00080400b005a85c7de4dbmr3972654pfk.3.1677666285565; Wed, 01 Mar
 2023 02:24:45 -0800 (PST)
MIME-Version: 1.0
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net> <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net> <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net> <20221108194843.i4qckcu7zwqstyis@airbuntu>
 <Y2vMBWpPlIArwnI7@hirez.programming.kicks-ass.net> <424e2c81-987d-f10e-106d-8b4c611768bc@arm.com>
 <CAKfTPtD0ZOndFef3-JxBn3G9tcX=cZEObjHZ0iqiVTJz7+QrmQ@mail.gmail.com>
 <249816c9-c2b5-8016-f9ce-dab7b7d384e4@arm.com> <CAKfTPtA4gSZAmi3FtU2Y57cuqCzC5LCR=+7Q8Xh=VtkbfaQP5Q@mail.gmail.com>
 <CAKfTPtCdoAtQUJgSGgCZtCWhtv0_WgDrBpGSRTwHG=SV_Jf4ew@mail.gmail.com> <94eeb587-e9c9-1d92-7fd3-edde46fd4dba@arm.com>
In-Reply-To: <94eeb587-e9c9-1d92-7fd3-edde46fd4dba@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 1 Mar 2023 11:24:33 +0100
Message-ID: <CAKfTPtCYQTUdAPb1_yy3103P9KnC5ccAnF0djgOYSkmo_=gU5w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Qais Yousef <qyousef@layalina.io>,
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

On Wed, 22 Feb 2023 at 21:29, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 21/02/2023 10:29, Vincent Guittot wrote:
> > On Mon, 20 Feb 2023 at 14:54, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> >>
> >> On Fri, 17 Feb 2023 at 14:54, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>>
> >>> On 09/02/2023 17:16, Vincent Guittot wrote:
> >>>> On Tue, 7 Feb 2023 at 11:29, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>>>>
> >>>>> On 09/11/2022 16:49, Peter Zijlstra wrote:
> >>>>>> On Tue, Nov 08, 2022 at 07:48:43PM +0000, Qais Yousef wrote:
> >>>>>>> On 11/07/22 14:41, Peter Zijlstra wrote:
> >>>>>>>> On Thu, Sep 29, 2022 at 03:41:47PM +0100, Kajetan Puchalski wrote:
>
> [...]
>
> >>> I ran the same test (boosting only for DVFS requests) with:
>                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ *
> >>>
> >>> -->8--
> >>>
> >>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> >>> index dbc56e8b85f9..7a4bf38f2920 100644
> >>> --- a/kernel/sched/sched.h
> >>> +++ b/kernel/sched/sched.h
> >>> @@ -2946,6 +2946,8 @@ static inline unsigned long cpu_util_cfs(int cpu)
> >>>                              READ_ONCE(cfs_rq->avg.util_est.enqueued));
> >>>         }
> >>>
> >>> +       util = max(util, READ_ONCE(cfs_rq->avg.runnable_avg));
> >>> +
> >
> > Another reason why it gives better results could be that
> > cpu_util_cfs() is not only used for DVFS selection but also to track
> > the cpu utilization in load balance and EAS so the cpu will be faster
> > seen as overloaded and tasks will be spread around when there are
> > contentions.
> >
> > Could you try to take cfs_rq->avg.runnable_avg into account only when
> > selecting frequency ?
>
> I actually did exactly this. (* but not shown in the code snippet).
> I just used the boosting for CPU frequency selection (from
> sugov_get_util()). I added the the `_freq` suffix in the kernel name to
> indicate this.

Ok. So the improvement that you are seeing, is really related to
better freq selection

>
> > That being said I can see some place in load balance where
> > cfs_rq->avg.runnable_avg could give some benefits like in
> > find_busiest_queue() where it could be better to take into account the
> > contention when selecting the busiest queue
>
> Could be. Looks like so far we only use it in group_has_capacity(),
> group_is_overloaded() and for NUMA.

I think it could be interesting to use runnable_avg in
find_busiest_queue() for migrate_util case to select the rq with
highest contention as an example

>
> [...]
