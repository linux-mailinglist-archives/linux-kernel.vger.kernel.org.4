Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4BC60E2BA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbiJZN5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbiJZN4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:56:37 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4949C7CF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:55:46 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id h18so366171ilq.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DT+ZdZw/Szp/XdP/+oiq277VJfumCyFlUwKrWAITL5M=;
        b=bu/77+GejM0UeaYIkx2rGntTb76sV9tGUzQpjFzvBZHz2/2ipFD58QIDV44evyQOdt
         EletwUT1AOpR1HGXYb5Ec21T7H7wsnvR0Akz6ccL2Nj3e+VAWHFVPcIhgTraeAuNrJI0
         CpD+dQn811Gl84vZvuxH+C8Sf9wA2FRRz2+oNBCVPu5EiJZlOKvUCfD3bdYs0ig48oD+
         8ON98bgr9OnrWfGxjSyOS/fv+VG9eWctHfHq+pnUM156rQTQGoBfBKObdFuId7zfqk83
         ii0h5tBGU0DLkt8hErsBUgQzrD0h2H68/UwZ66zk7cZJVEcFPps4/CahxRNNa2QYQP1D
         ovSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DT+ZdZw/Szp/XdP/+oiq277VJfumCyFlUwKrWAITL5M=;
        b=UdbzlWx7tLLrgvoFEShtwNf/7qfkhCMm1aNOKE8ESGQOZAn2MCJ29xNkokJo22ue65
         k+8MjZ77e6i7tnIT9aPSfk0kKvf4rj+/pN+EYgmDaLVm6SVobzLsvNm0XURknx+B/IID
         +iGd4hBgRUH+Es6pIB9O+WLz2MkQeJfLKaxPo60CqCAourVwwPRyEZ3auGjyx0Kvvs+T
         fkvfk1IJLrp5ti+wNufMGj8wZMyN0sk10SYogIkm7gPDqHhTJCBk/Nq2dWjb3SbIQVza
         NppxsiS/Xu+7FynVg8t/d97iROFyuNg51CrK3oSuR5q4Ht8iO2m8R0vZSa/6fsSH0LTW
         F0wA==
X-Gm-Message-State: ACrzQf2pTjSyppauDnsxPg86uPeQ6QHwCoJlFJjPy2vPYAvuhvPktr5e
        UWiXXvU3ZyPKu+zs/VuVcXK5BXHHGR23e/17Jps3TQ==
X-Google-Smtp-Source: AMsMyM7LtMJZ7peDhco+LS7h3Vnr3vLAVqU6EymZQQvnw9EwQvwgCXvC+HA4HxCF5rWdCWjsuzdq9+EpdZ6B4UYJ7S8=
X-Received: by 2002:a92:4449:0:b0:2de:95f1:8b80 with SMTP id
 a9-20020a924449000000b002de95f18b80mr26741891ilm.232.1666792545449; Wed, 26
 Oct 2022 06:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220925143908.10846-1-vincent.guittot@linaro.org>
 <20220925143908.10846-8-vincent.guittot@linaro.org> <CA+q576OoP6Ebax8aGM234JRf+WOJFEwChs25qB9M_rt7+r1wuA@mail.gmail.com>
 <CAKfTPtAh30v=XoJPvAeFxu274CDW0uf2UY4Z8ySJz123ko5xgw@mail.gmail.com>
 <CA+q576Po0bskXfBP3EXUGG9jFLAP66iH6EamXfPUg9LC6qQyCg@mail.gmail.com>
 <20221012152130.GA20993@vingu-book> <9d06c9ce-d4b3-23a8-9f9c-c1054de1aeb5@arm.com>
In-Reply-To: <9d06c9ce-d4b3-23a8-9f9c-c1054de1aeb5@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 26 Oct 2022 15:55:34 +0200
Message-ID: <CAKfTPtD1L3ii8VFnZHdaZm=BKz-tSw+cuu7s9U-s9zo14mpPRQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] sched/fair: Add latency list
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Youssef Esmat <youssefesmat@chromium.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        parth@linux.ibm.com, qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2022 at 12:44, Dietmar Eggemann <dietmar.eggemann@arm.com> w=
rote:
>
> On 12/10/2022 17:21, Vincent Guittot wrote:
> > Le mardi 11 oct. 2022 =C3=AF=C2=BF=C2=BD 18:54:27 (-0500), Youssef Esma=
t a =C3=AF=C2=BF=C2=BDcrit :
> >> Hi Vincent,
> >>
> >> On Tue, Oct 11, 2022 at 12:10 PM Vincent Guittot
> >> <vincent.guittot@linaro.org> wrote:
>
> [...]
>
> > @@ -10894,12 +10898,17 @@ static int cpu_idle_write_s64(struct cgroup_s=
ubsys_state *css,
> >  static s64 cpu_latency_nice_read_s64(struct cgroup_subsys_state *css,
> >                                   struct cftype *cft)
> >  {
> > +     unsigned long period =3D sysctl_sched_latency;
> >       int last_delta =3D INT_MAX;
> >       int prio, delta;
> >       s64 weight;
> >
> > +     if (sched_feat(GENTLE_FAIR_SLEEPERS))
> > +             period >>=3D 1;
> > +
> >       weight =3D css_tg(css)->latency_offset * NICE_LATENCY_WEIGHT_MAX;
> > -     weight =3D div_s64(weight, sysctl_sched_latency);
> > +     period =3D sysctl_sched_latency;
>
> Looks like this line is wrong here, period has been set already for
> GENTLE_FAIR_SLEEPERS and !GENTLE_FAIR_SLEEPERS?

Yes, I have factorized this in a function and the new version that I'm
preparing so The formula is not duplicated with the risk of error like
above

>
> > +     weight =3D div_s64(weight, period);
> >
> >       /* Find the closest nice value to the current weight */
> >       for (prio =3D 0; prio < ARRAY_SIZE(sched_latency_to_weight); prio=
++) {
>
> [...]
>
