Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E29C6E961F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjDTNoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjDTNoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:44:17 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F595BA1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:44:16 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a52667955dso12402505ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681998256; x=1684590256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivWpDBmkPgmKgvHTR5P8q8ZV37qTEylKx14C8X7MiLg=;
        b=o/iL+O86hLQmiaxzhayW0o1B0qhhzJoAYkiTeWUJ3wo67n6B22VcyWE/tYhcrVzELk
         FKfPB1ddzAxKqHNCCrkV0IFpWfpyWofXQ0bvWE6nlrZ12Jp9oStfqVH1eKuFQ5tNd5cg
         jA0JhBm0hDeR/h1442XZ6WWqHorgVQZLQc891lDUflZBjMIlDw3Bn1jkQNbC+KiwSJMO
         8sFSGzeN+Nyi7eYV4V8FREt/yBvLft7eOhrlG9jr7cCxjVyjd2UDHLBzuSjYtEl5zLW+
         fpU1t0WkLYCWTg1LwOKORWsScIzV6+bKEmr/R5kAs/ibvkhDghuXqaFGaTInZaEkCVUD
         o8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681998256; x=1684590256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivWpDBmkPgmKgvHTR5P8q8ZV37qTEylKx14C8X7MiLg=;
        b=WHml6l07InLA6wRJ68HWnNxUE39J6bdLlWtJWAA4zyofJBjzFTjTFGL39Y5xMbcUhE
         TFv58lx3Lq2SrXPOvHZcJWTt2GKXECxNhH4MtT8k99wDXzOewl4gncLjSdpT6Bd2NONm
         ukejJUdnN7cwSdtsYnJOmt2SqhCiubYnGRUCBHh4SF5cpApuWJfSUHsPs2vfLxQSP7AO
         dK6NSUI/OnIjXlXnv/nENI074Osa4lTC7ZIx3d1f2XlQgCGXneioBn47VNcTHBXPcQuY
         ejYbJ+N0SKKbGPZfrB6zxUC85uyjMhtSz/tJQWyGT+Ne1ujE5ROwWPQRjEt5OIQQ2Nww
         0XcQ==
X-Gm-Message-State: AAQBX9fHZye5Gu4XkPgdz7dJ+4+yxc/TRSmgxIITUUGWPlb4EP2kSIeH
        FfdPK2hhX80W0M4XNdOBsFCG0T1VKdc3NIbKfhr2ug==
X-Google-Smtp-Source: AKy350bRP41B1w+gPnZGx2B8AHN/MG3zwD2ZvEZv3bIwvHCLSdA5zgXdK15jeOIMjKRbMoTQCsSW+ugtVxNJmH5E7Vs=
X-Received: by 2002:a17:902:748c:b0:1a6:be37:22e1 with SMTP id
 h12-20020a170902748c00b001a6be3722e1mr1502935pll.15.1681998256168; Thu, 20
 Apr 2023 06:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230416213406.2966521-1-davidai@google.com> <d83950c4-7458-aeea-f341-327c163704a8@arm.com>
 <CABN1KC+_HDi_i2zzpZVbqiUP5-QB9YrE5wzLqr==_wOemaCXzA@mail.gmail.com> <bf8f21be-7249-fc27-9704-211d0f5a12b1@arm.com>
In-Reply-To: <bf8f21be-7249-fc27-9704-211d0f5a12b1@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 20 Apr 2023 15:44:04 +0200
Message-ID: <CAKfTPtAgkyE1xntn-4u9o8DFhH9iGq54c-QXYr0cE+zvoPx9Gw@mail.gmail.com>
Subject: Re: [RFC PATCH v1] sched/uclamp: Introduce SCHED_FLAG_RESET_UCLAMP_ON_FORK
 flag
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     David Dai <davidai@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Qais Yousef <qyousef@google.com>,
        Quentin Perret <qperret@google.com>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 at 11:37, Dietmar Eggemann <dietmar.eggemann@arm.com> w=
rote:
>
> On 20/04/2023 03:11, David Dai wrote:
> > On Tue, Apr 18, 2023 at 10:18=E2=80=AFPM Dietmar Eggemann
> > <dietmar.eggemann@arm.com> wrote:
> >>
> >
> > Hi Dietmar, thanks for your time,
> >
> >> On 16/04/2023 23:34, David Dai wrote:
> >>> A userspace service may manage uclamp dynamically for individual task=
s and
> >>> a child task will unintentionally inherit a pesudo-random uclamp sett=
ing.
> >>> This could result in the child task being stuck with a static uclamp =
value
> >>
> >> Could you explain this with a little bit more detail? Why isn't the
> >> child task also managed by the userspace service?
> >
> > See Qais=E2=80=99 reply that contains more detail on how it=E2=80=99s b=
eing used in
> > Android. In general, if a dynamic userspace service will adjust uclamp
> > on the fly for a given task, but has no knowledge or control over if
> > or when a task forks. Depending on the timing of the fork, a child
> > task may inherit a very large or a small uclamp_min or uclamp_max
> > value. The intent of this patch is to provide more flexibility to the
> > uclamp APIs such that child tasks do not get stuck with a poor uclamp
> > value when spawned while retaining other sched attributes. When
> > RESET_ON_FORK is set on the parent task, it will reset uclamp values
> > for the child but also reset other sched attributes as well.
>
> OK, in this case, why not just change behavior and always reset the
> uclamp values at fork?
>
> Do we anticipate a use-case in which uclamp inheritance would be required=
?
>
> Let's not over-complicate the sched_[sg]etattr() unnecessarily.

I was about to ask the same question and I'm aligned with Dietmar.
Use RESET_ON_FORK and set all attributes

>
> [...]
>
> >> Does this issue happen with uclamp mainline or only with Android's
> >> slightly different version (max- vs. sum aggregation)?
> >
> > I=E2=80=99m using the version of uclamp that=E2=80=99s in Linus=E2=80=
=99 tree. How uclamp is
> > aggregated is unrelated to the problem I=E2=80=99m trying to solve with=
 this
> > patch. Which is to extend the uclamp APIs to have finer control for
> > the uclamp inheritance of child tasks.
>
> OK, I see.
