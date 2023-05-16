Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0D870431B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 03:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjEPBrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 21:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjEPBrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 21:47:16 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E9B2681
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:47:14 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-38e3228d120so7154650b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1684201634; x=1686793634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vQMONc5SJDyCvN7VZRBXzuqqiXsyACiKWFthRnNjkI=;
        b=MJ1jp2jKeZlhrFpiyXssgMah5dc3o5krDLHVOiR0AZia+Lqn9dfT8qtVIhmqCho2vT
         T9iDlq+DyxbBb1aq+P3T6wmlnrWFRFWOpOjwZp1Y7YeUYij0dg75hbzXn3CO1JkcVB5q
         7fdN24YuXgRYmhULBdSi259hdYNiLt1vMbNOoP6AEl9aALNw4Enu7jKfFON70Ho/NBrP
         sJkWBFC9JsM4h6jA9Q000f74LWzz6PuMElq1uuaitTsoyM6xkweI+nsgeU4OnzW0nOk0
         v3p9WGCmpuBNSTbwuk6Z0PceQtzR0fFkr7RvqdGEGclm2H+BKrBAWcKhpeA16UUVSoiJ
         Yp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684201634; x=1686793634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vQMONc5SJDyCvN7VZRBXzuqqiXsyACiKWFthRnNjkI=;
        b=XQLmypvm+1Tl5ZO5V+n1XFhuetPCkZs3NR7IauIiaB5lY3bRuxXi6KBbshUCxCGE05
         kcYEVqf5osplfHXLUt9VrCK42Xb38gGNMaiMyJRM1ywjqlhEuzgO+USRdOL7HDJUhOEw
         Dx1lF+uaQycvQe1Mv/DuIqFJth8bHoXjO8/lVg+sT1zOhpWVR2aclaSEwRNGs4phFKE5
         wmfvFY/awJS4NGYD4hE1abWCDOaIfmoq+6Yhu9vq99oHJjIeYkPNy7RleqOZeZ3oEXjV
         CYUMj+hMad1vMmztAcd8rSCEkzIlFwCMON6hWyVcf0JluhyPo6oBakbAuBpdDknI8FGP
         ImRA==
X-Gm-Message-State: AC+VfDymSSDR/qxNiNebz875jT5f6SMVT7f5I/4Yg6OcTyeIGiTZQxzX
        Cw6hoyxBNdXitBcpsHifoVeHEVZrXXNa8fGw33r1Gg==
X-Google-Smtp-Source: ACHHUZ7niwSe+XVzisHsadeHDBRjQ1d1V4QqTLQeyQjsBlq+b+NyhnKZFwY3Q8zeutdPuzTiykiwl74B2MiAm0eSRD8=
X-Received: by 2002:a05:6808:1a04:b0:395:df63:63af with SMTP id
 bk4-20020a0568081a0400b00395df6363afmr5860001oib.54.1684201634118; Mon, 15
 May 2023 18:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230515025716.316888-1-vineeth@bitbyteword.org>
 <20230515025716.316888-3-vineeth@bitbyteword.org> <20230515100616.33ba5dd9@luca64>
In-Reply-To: <20230515100616.33ba5dd9@luca64>
From:   Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date:   Mon, 15 May 2023 21:47:03 -0400
Message-ID: <CAO7JXPgq8V5yHM6F2+iXf4XJ9cyT30Hn4ot5b2k7srjsaPc3JQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] sched/deadline: Fix reclaim inaccuracy with SMP
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Mon, May 15, 2023 at 4:06=E2=80=AFAM luca abeni <luca.abeni@santannapisa=
.it> wrote:

>
> this patch is giving me some headaches:
>
Sorry about that.. I was also stressing out on how to get the
reclaiming done right for the past couple of days ;-)

> Vineeth Pillai <vineeth@bitbyteword.org> wrote:
> [...]
> >   *   Uextra:         Extra bandwidth not reserved:
> > - *                   =3D Umax - \Sum(u_i / #cpus in the root domain)
> > + *                   =3D Umax - this_bw
>
> While I agree that this setting should be OK, it ends up with
>         dq =3D -Uact / Umax * dt
> which I remember I originally tried, and gave some issues
> (I do not remember the details, but I think if you try N
> identical reclaiming tasks, with N > M, the reclaimed time
> is not distributed equally among them?)
>
I have noticed this behaviour where the reclaimed time is not equally
distributed when we have more tasks than available processors. But it
depended on where the task was scheduled. Within the same cpu, the
distribution seemed to be proportional. But the tasks migrated often
and then depending on whether the task got a whole cpu for its
runtime or not, the reclaimed bandwidth differed. I thought that
should be okay as it depended upon where the task landed.

One other problem I saw was cpu usage spiking above max_bw leading to
system hang sometimes. I thought stopping reclaiming when running_bw
gets larger than max_bw(in 4th patch) fixed this, but when I ran the
tests long enough, I did see this hang.

> I need to think a little bit more about this...
>
Thanks for looking into this.. I have a basic idea why tasks with less
bandwidth reclaim less in SMP when number of tasks is less than number
of cpus, but do not yet have a verifiable fix for it.

If patches 1 and 4 looks good to you, we shall drop 2 and 3 and fix the
SMP issue with varying bandwidth separately.. Patch 4 would differ a
bit when I remove 2 and 3 so as to use the formula:
 "dq =3D -(max{u, (Umax_reclaim - Uinact - Uextra)} / Umax_reclaim) dt"

Thanks for your patience with all these brainstorming:-)

Thanks,
Vineeth
