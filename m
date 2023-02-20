Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD3C69CC64
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjBTNjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjBTNjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:39:46 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9D51C313
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:39:45 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id co23-20020a17090afe9700b002341fadc370so1436804pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+yYaa3LU9BQ8Bs1KkeqheK3uNYksjnBzqiGb+ils5Bw=;
        b=MtCnv1+YhTbZDlshd6QCf4OPs5KXTGn8OLfSJGOwnGq4RQ7Fw2Kxu2iGxSt8tEt3Et
         yc6m4sg2oPP5IHq+xKGViH3qSHPb0UakpSoQhTAkIxDPoyLvyJVlp9aV/l0Vxf8GHRVY
         hv+ux2lKrRr/qlSqAql684GzQBm2dO3mMz9/pYSHz+W6+mdlnXCwd/JpTfcOmWnHR7sF
         BBU1Bao3IljPXJknRzSeLnQiCKI7SluxQtxtogjP1adTM5NHn4TBKFHXYAC5bm+xNN8T
         RuStRAN/0z5G7+dagIS8l9CEH9DLYd4ZqawX7nBu8VyfF5KR7ATiiAHENfkfBh2amWAU
         +E7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yYaa3LU9BQ8Bs1KkeqheK3uNYksjnBzqiGb+ils5Bw=;
        b=rXk7YaC7vX0HZJ0KIuQi+8EfxOpJnrCPdecs/2Zh/HwTgmVv5XH/J2FaquRjot+MnC
         UEyjR2NqP3XSgg4CB6g7ivwCARm247CewVGMoBamAUjocCpSTUphP51oZ7dLTh3scRh3
         +zhnnjzrucdrKWIQATxCgtrosjEAk23LwP2RmhWeOXSuGZ/g3TDh2AeMEnLoP2dDMlzj
         Fy1zzxE06s3ViZ94EQ7o0nxbCDGj4GCl6qVWqsttw+Vx3bBhyJDdmHqnWEZODDGO60hU
         URZz9iubYNd+1zftMhDvjBGnAQHEUPRK5rYZjEbMvacdv0CPnqhFQmqjBBhoTUg7B2YS
         o++g==
X-Gm-Message-State: AO0yUKVsjoB75iKXlTCFRNoOygc5Pz+ilyHKWXesWEZfVH/KyodWBH/4
        rTQlWYcQVSy5KDunK5QILitDKb7ZI087Xs3KACIvgA==
X-Google-Smtp-Source: AK7set/AGtzXQ78/IJ26ZMfBgOk0Il+Y/+b/Z0tS/ZIG/aqL/DEnvKEulXp5kUj4k9okONQ9HpeeuK4zzPAJvme4Ejk=
X-Received: by 2002:a17:90b:4a06:b0:233:4f0d:7 with SMTP id
 kk6-20020a17090b4a0600b002334f0d0007mr814972pjb.42.1676900384848; Mon, 20 Feb
 2023 05:39:44 -0800 (PST)
MIME-Version: 1.0
References: <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net> <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net> <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net> <20221108194843.i4qckcu7zwqstyis@airbuntu>
 <Y2vMBWpPlIArwnI7@hirez.programming.kicks-ass.net> <424e2c81-987d-f10e-106d-8b4c611768bc@arm.com>
 <CAKfTPtD0ZOndFef3-JxBn3G9tcX=cZEObjHZ0iqiVTJz7+QrmQ@mail.gmail.com> <Y/NHvvcgOov6DoLc@hirez.programming.kicks-ass.net>
In-Reply-To: <Y/NHvvcgOov6DoLc@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 20 Feb 2023 14:39:33 +0100
Message-ID: <CAKfTPtAFFZaGSyjNL+9LfDBBR0b9TWw3DwFKJZXURgcf-_W6NA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
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

On Mon, 20 Feb 2023 at 11:13, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Feb 09, 2023 at 05:16:46PM +0100, Vincent Guittot wrote:
>
> > > The results is very similar to PELT halflife reduction. The advantage is
> > > that 'util_est_faster' is only activated selectively when the runtime of
> > > the current task in its current activation is long enough to create this
> > > CPU util boost.
> >
> > IIUC how util_est_faster works, it removes the waiting time when
> > sharing cpu time with other tasks. So as long as there is no (runnable
> > but not running time), the result is the same as current util_est.
>
> Uh.. it's double the speed, no? Even if there is no contention, the
> fake/in-situ pelt sum runs at double time and thus will ramp up faster
> than normal.

Ah yes. I haven't noticed it was (delta * 2) and not delta

>
> > util_est_faster makes a difference only when the task alternates
> > between runnable and running slices.
>
> UTIL_EST was supposed to help mitigate some of that, but yes. Also note
> that _FASTER sorta sucks here because it starts from 0 every time, if it
> were to start from the state saved by util_est_dequeue(), it would ramp
> up faster still.

Yes.

>
> Patch has a comment along those lines I think.
>
> > Have you considered using runnable_avg metrics in the increase of cpu
> > freq ? This takes into the runnable slice and not only the running
> > time and increase faster than util_avg when tasks compete for the same
> > CPU
>
> Interesting! Indeed, that's boosting the DVFS for contention. And as
> deggeman's reply shows, it seems to work well.
>
> I wonder if that one place where it regresses is exactly the case
> without contention.

Yes that might be the case indeed. I would expect uclamp_min to help
for ensuring a min frequency such scenario
