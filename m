Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83ADB7051AF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbjEPPId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjEPPIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:08:31 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F6D2139
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:08:30 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-394440f483fso3684565b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1684249709; x=1686841709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nYCT/9S+bYFUGy7VAZpbgBqzml5j+HGzn66yLQVtiM=;
        b=ojjtI7ko9pIhI3+rYZMLN5IvD/g2uAadl2F831OUhvhnIdszAwjFudVaFxecoL5XJl
         GxMCO7i3iVUfS41yprG4T2MplunBCCIviuc1M65Gu7pJZ3JaPbeskRA+bAe6/+z6rRBM
         89iQMIuCayNvlpqrH33EJAQkE1b6pvF/NZCNewCZRzlDFyLL58oZ+PpDzazv20nEqtQL
         ydyl5MGqslcj4jboo8tNgFfxQFVhFAm2mRaB1ToRuA07eJAv7Xth55OZ5779+2MiZUJz
         5+M7NfufaKZO0Q28BOxZC1352pXVcJlvSdwhgJj/nqGYa+7ZJ9ZZaljpl0Ia6PdCcpeI
         m8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684249709; x=1686841709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nYCT/9S+bYFUGy7VAZpbgBqzml5j+HGzn66yLQVtiM=;
        b=lY7wMDTyphqzesZc88dgQFz+uv42IOzLFfPwFPqD+XJrlere5I6g+tUtOw2CTUbjBC
         4u7UndbEH+dxyCAbP6em6WupboDmhFNG7SP94HXrWY7mRwrRvGhyg2B5RyYQYGII7fb+
         sQjUHOAD00RDmcrkADETTtrKJZe2qkTbqFAQIKbrGphkKrLJZOpyJCJCFcggi6v1THc9
         1RFDfpL03Yb8jh484ShqGYpxcV6CzzZyWApwuhg7PSASLhHbmRLS8ZO9Y086ob+gsip2
         tkV4AQhX2Vh6ZE6mnXs4cqB4eKQU2WaUV5Xm1v9aAMO7kXoVUtmt6HGEInAfhwWgyOp/
         bvUQ==
X-Gm-Message-State: AC+VfDx/dmOjMpTbpkUspL5IlLuyLw+aezzJ6DR2YZLQ45oEedbRr8bY
        3HKwdhWJzjxDDlQu3JvTrCgOdtGZWr24J6jVD3MLyA==
X-Google-Smtp-Source: ACHHUZ52fr4D5ED9rrc1Rz+zJN0CmRQiOGOLOPOpw/wNfYAb9IbiK4amT4Q+S0TxK5BeC5T/eq1Z+R6ZNXb0ksz05Ew=
X-Received: by 2002:a05:6808:604:b0:394:27d6:8d98 with SMTP id
 y4-20020a056808060400b0039427d68d98mr11219350oih.31.1684249709102; Tue, 16
 May 2023 08:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230515025716.316888-1-vineeth@bitbyteword.org>
 <20230515025716.316888-3-vineeth@bitbyteword.org> <20230515100616.33ba5dd9@luca64>
 <CAO7JXPgq8V5yHM6F2+iXf4XJ9cyT30Hn4ot5b2k7srjsaPc3JQ@mail.gmail.com> <20230516093729.0771938c@luca64>
In-Reply-To: <20230516093729.0771938c@luca64>
From:   Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date:   Tue, 16 May 2023 11:08:18 -0400
Message-ID: <CAO7JXPh5uLV4QjAEi6bJXfAGSsZ=XsnCyzrvKS8m35BGbRPYJw@mail.gmail.com>
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

On Tue, May 16, 2023 at 3:37=E2=80=AFAM luca abeni <luca.abeni@santannapisa=
.it> wrote:
> > I have noticed this behaviour where the reclaimed time is not equally
> > distributed when we have more tasks than available processors. But it
> > depended on where the task was scheduled. Within the same cpu, the
> > distribution seemed to be proportional.
>
> Yes, as far as I remember it is due to migrations. IIRC, the problem is
> related to the fact that using "dq =3D -Uact / Umax * dt" a task running
> on a core might end up trying to reclaim some idle time from other
> cores (which is obviously not possible).
> This is why m-GRUB used "1 - Uinact" instead of "Uact"
>
This is what I was a little confused about. In "-Uact / Umax", all
the variables are per-cpu and it should only be reclaiming what is
free on the cpu right? And when migration happens, Uact changes
and the reclaiming adapts itself. I was thinking it should probably
be okay for tasks to reclaim differently based on what free bw is
left on the cpu it is running. For eg: if cpu 1 has two tasks of bw
.3 each, each task can reclaim "(.95 - .6) / 2" and another cpu with
only one task(.3 bandwidth) reclaims (.95 - .3). So both cpus
utilization is .95 and tasks reclaim what is available on the cpu.

With "1 - Uinact", where Uinact accounts for a portion of global free
bandwidth, tasks reclaim proportionately to the global free bandwidth
and this causes tasks with lesser bandwidth to reclaim lesser when
compared to higher bandwidth tasks even if they don't share the cpu.
This is what I was seeing in practice.

But with Uact / Umax, Uact can be greater than Umax and this caused
some issues like tasks not getting their reserved bandwidth. For eg:
4 tasks with (7,10) on a 3 cpu system - one cpu can have Uact of 1.4
and scaled_delta to be greater than delta. This causes runtime to
deplete faster until one task is migrated. But after migration, the
target cpu will have this problem. So "Uact / Umax" was not working
in close to overcommit situations.

In summary "1 - Uinact" causes reclaiming much less while "Uact / Umax"
has issues during overcommitting of tasks with high bandwidth. This is
what I understood from experiments and reading.

> [...]
> > > I need to think a little bit more about this...
> > >
> > Thanks for looking into this.. I have a basic idea why tasks with less
> > bandwidth reclaim less in SMP when number of tasks is less than number
> > of cpus, but do not yet have a verifiable fix for it.
>
> I think I can now understand at least part of the problem. In my
> understanding, the problem is due to using
>         dq =3D -(max{u_i, (Umax - Uinact - Uextra)} / Umax) * dt
>
> It should really be
>         dq =3D -(max{u_i, (1 - Uinact - Uextra)} / Umax) * dt
>
> (since we divide by Umax, using "Umax - ..." will lead to reclaiming up
> to "Umax / Umax" =3D 1)
>
> Did you try this equation?
>
I had tested this and it was reclaiming much less compared to the first one=
.
I had 3 tasks with reservation (3,100) and 3 cpus.

With dq =3D -(max{u_i, (Umax - Uinact - Uextra)} / Umax) * dt (1)
TID[636]: RECLAIM=3D1, (r=3D3ms, d=3D100ms, p=3D100ms), Util: 95.08
TID[635]: RECLAIM=3D1, (r=3D3ms, d=3D100ms, p=3D100ms), Util: 95.07
TID[637]: RECLAIM=3D1, (r=3D3ms, d=3D100ms, p=3D100ms), Util: 95.06

With dq =3D -(max{u_i, (1 - Uinact - Uextra)} / Umax) * dt (2)
TID[601]: RECLAIM=3D1, (r=3D3ms, d=3D100ms, p=3D100ms), Util: 35.65
TID[600]: RECLAIM=3D1, (r=3D3ms, d=3D100ms, p=3D100ms), Util: 35.65
TID[602]: RECLAIM=3D1, (r=3D3ms, d=3D100ms, p=3D100ms), Util: 35.65

As the task bandwidth goes higher, equation (2) reclaims more, but
equation (2) is a constant of 95% as long as number of tasks less
than cpus. If the number of tasks is more than cpus, eq (2) fares
better in reclaiming than eq (1)

eq (1) with 5 tasks (3,100)
TID[627]: RECLAIM=3D1, (r=3D3ms, d=3D100ms, p=3D100ms), Util: 28.64
TID[626]: RECLAIM=3D1, (r=3D3ms, d=3D100ms, p=3D100ms), Util: 28.64
TID[629]: RECLAIM=3D1, (r=3D3ms, d=3D100ms, p=3D100ms), Util: 28.62
TID[628]: RECLAIM=3D1, (r=3D3ms, d=3D100ms, p=3D100ms), Util: 29.00
TID[630]: RECLAIM=3D1, (r=3D3ms, d=3D100ms, p=3D100ms), Util: 28.99

Here top shows 3 cpus in the range ~45 to 50% util

eq (2) with 5 tasks (3,100)
TID[667]: RECLAIM=3D1, (r=3D3ms, d=3D100ms, p=3D100ms), Util: 57.20
TID[670]: RECLAIM=3D1, (r=3D3ms, d=3D100ms, p=3D100ms), Util: 57.79
TID[668]: RECLAIM=3D1, (r=3D3ms, d=3D100ms, p=3D100ms), Util: 57.11
TID[666]: RECLAIM=3D1, (r=3D3ms, d=3D100ms, p=3D100ms), Util: 56.34
TID[669]: RECLAIM=3D1, (r=3D3ms, d=3D100ms, p=3D100ms), Util: 55.82

And here top shows all 3 cpus with 95% util

> I'll write more about this later... And thanks for coping with all my
> comments!
>
Thanks :-)

Vineeth
