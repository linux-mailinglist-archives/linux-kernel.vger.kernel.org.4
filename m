Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F7F6194C5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiKDKs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKDKs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:48:56 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952182A1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 03:48:54 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i21so6967419edj.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 03:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACk6vStBBSLwltQvQYGOjLG1IfGMIIYahN3E1+0kWF4=;
        b=oRsClose6x79L1fumJ+Tc8Nnr3s7PipIPLGr6C6VYD26X9A23IihgSC8CVCs96++Dm
         hbRaE7X93NVY/Ec1f3Q9uNWsbGFJ0BoM/5LjBX43yyO4J4dzQsY6I1UmfBOCyFwpm6VF
         hJx6r9zzAG/o+F2y71C+15emGOyDW4D/cQwJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACk6vStBBSLwltQvQYGOjLG1IfGMIIYahN3E1+0kWF4=;
        b=TfB8mnewtZgIz2hV+m5IvoejWzPonN9t4l+m6qJxbugAcaWXiOysweO6yrfQ77K2Qk
         Nf14/3ORV9HBDXc21SSLBcJmfR6JTqrCEjkoZlxTCtzywLPHhQL51mIA0A3zBWhvzCSQ
         VAtLzxbVXdN8vudTvljqHHqYJNlaFD+WSrhktuehSw2sGaSdbCLrZZ3jWEDl5/nOqaOd
         r0UwhKwf+V/ZyVgOLvAN1dcBqxhmjen0dOOydcr7dxyq1MTonwXaR+p2lp4+az8+Afef
         jt/1sHvt6B27/mZct2EItsLUmVkyj9Un8X0nMHHYTfcqzBEpVNLytzPeeilQbmvfz0VD
         ej0w==
X-Gm-Message-State: ACrzQf1s36IDed2Pu7bIMDTA3ADxpCnQJlxQ2cXpyRo3LuFXhf0xP+dl
        r8XIFrR8Y3t37J4kmzepTr7AbgTrEqdARNOr8f/TOg==
X-Google-Smtp-Source: AMsMyM6j9PScCUhbebhbA0bhtKHpwJgN1jSCm6blTTUVCLtqpq/M+2Q7y5Zp5HG+AQVb5yckf2M9Q2cTYu3wqF2qjH8=
X-Received: by 2002:aa7:de9a:0:b0:44d:8191:44c5 with SMTP id
 j26-20020aa7de9a000000b0044d819144c5mr34002064edv.232.1667558933159; Fri, 04
 Nov 2022 03:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
 <20221028093403.6673-7-vincent.guittot@linaro.org> <20221101192848.pjns3um7dnrwrk5p@airbuntu>
 <CAKfTPtA=vJQA_=6Un1CqwzMUaOxMeFGTKUZnj8qyqvqmSdYBAg@mail.gmail.com>
 <20221103142732.m5ibwkuymvhcdxkn@airbuntu> <CAKfTPtDu=c-psGnHkoWSPRWoh1Z0VBBfsN++g+krv4B1SJmFjg@mail.gmail.com>
 <CAEXW_YQd2y9=RHw3Sge7ghnhBz0AyR+B-U4zG10LXuSbg5bGSA@mail.gmail.com> <CAKfTPtBJQOY7UUkm1=wvG18UWgLLiTW0dr3bTGUJY=siM_LLxQ@mail.gmail.com>
In-Reply-To: <CAKfTPtBJQOY7UUkm1=wvG18UWgLLiTW0dr3bTGUJY=siM_LLxQ@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 4 Nov 2022 10:48:42 +0000
Message-ID: <CAEXW_YTcmbPg+UCacb4Vy0LeYuorT-yECoa39pqtw5wPUkzsvQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/9] sched/fair: Add sched group latency support
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Qais Yousef <qyousef@layalina.io>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 10:37 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
[...]
> > during *same CPU* competition between different groups by juggling
> > around the wakeup-preemption window -- which maybe is good for
> > Android.
> >
> > OTOH, the =E2=80=9Cprefer idle=E2=80=9D flag in android that Qais is re=
ferring to,
> > will need a completely different method as I cannot see how a nice
> > value can communicate that (that can complement Vincent's changes
> > here). And it will need to have a per-task interface as well. We have
>
> Why a negative latency_nice value condition can't be used ? or latency -2=
0  ?

That's overloading the meaning of a value, the whole nice thing is
supposed to be "relative to something". So you are being nice to
something else. Here -20 means you are not being nice. But in fact you
are, because you are avoiding hurting something else by going to an
idle CPU. So it becomes really weird.

Also, why would -19 or -18 not be a value instead to cause wakeup to
prefer an idle CPU? It confuses the user on how to choose value and we
should refrain from that IMHO.
