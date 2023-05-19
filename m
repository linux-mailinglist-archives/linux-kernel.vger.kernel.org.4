Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF34709C25
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjESQNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjESQNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:13:12 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD26D1A7
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:13:01 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6aaf52ff35bso3401544a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1684512781; x=1687104781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHquhOH1janzOdG3XB4hk90MhkxIdvt/1uHwN+rT0zk=;
        b=WCpmkxAGDyeiLO9ZEaCvW6RgQ3WuS0KqdFQjsYcMM9tFinA2q5H3nn9JKRMahUO90l
         uGY5Z2HB5sOorURNQv3gwtA5AcaxR+pG4kfymTc4DtQr0dQm83cxH3y1y2jVYg/z+kRU
         xttuuCvY91/d+DSiiE9L0wwqgK3IYrhYRvIHU+aZ5T5vzydFDzuzjQKSwzGQtW9TAt8G
         iyUCEyTwtXM52wQPc4N5t5mTTpj65NZBl+E/i3n50pQ3FEX6lVHIRfHNHV3aoGGeQ0W2
         QpPwpuu5N6erddGoKxKaToT8EU784KxheO+vw5iSFJSJUYacC2OUaJ/ViNGKDHsvAy0b
         OmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684512781; x=1687104781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHquhOH1janzOdG3XB4hk90MhkxIdvt/1uHwN+rT0zk=;
        b=YSwpK2h23IkOFu36+CfdH7w9yWI0HeVYWKN5veadqWG6ZUP6TPGhN2ggiTs9H7Vmap
         RvRwXRl+xFwihfbLLmJ2XURNciqESnkDQxHEiLHSEO0Vxgri0Bdrugg8FyFXNTI+t+wW
         1VWTKTjn3vUdb1iMydzcYZArFBaOiGvQM7dXivyocUQdU49dXu9UvjjC2iXkQOQbk8Es
         Sz9CbfYOiRQhhFW4hr1A6IB9qnTyPoLi2H8tUEGF/cr5NxY8LcRhDlNlWsHBP5U77TGj
         O0OTE71a5CmLaw9buntDWjllqsHtwKQhUb8670j/lfcPeV+t2yGG1UTp/VbtWFxHVPPo
         1UGQ==
X-Gm-Message-State: AC+VfDypa2xO2xFmFAd4tIMYJzf/Hbgv6/+Yfma/7PKQhVUlVzGIcl8A
        gcxIzSEVHQx1gVMsLfgKU94sBNTkWh7LSP9u9jn++Q==
X-Google-Smtp-Source: ACHHUZ6V+kguC9vGVpO+0BoaUu0woqNZ08zhdCOicNb//slcwMgQ8oCjHrbRSuWPyvFKo6wzVDlnaR+KV2CWgXAZbi8=
X-Received: by 2002:a05:6830:d5:b0:6a6:f06:48eb with SMTP id
 x21-20020a05683000d500b006a60f0648ebmr1269755oto.30.1684512781215; Fri, 19
 May 2023 09:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230515025716.316888-1-vineeth@bitbyteword.org>
 <20230515025716.316888-3-vineeth@bitbyteword.org> <20230515100616.33ba5dd9@luca64>
 <CAO7JXPgq8V5yHM6F2+iXf4XJ9cyT30Hn4ot5b2k7srjsaPc3JQ@mail.gmail.com>
 <20230516093729.0771938c@luca64> <CAO7JXPh5uLV4QjAEi6bJXfAGSsZ=XsnCyzrvKS8m35BGbRPYJw@mail.gmail.com>
 <20230519115621.2b3f75e2@luca64> <20230519121804.6c85a3ed@luca64>
In-Reply-To: <20230519121804.6c85a3ed@luca64>
From:   Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date:   Fri, 19 May 2023 12:12:50 -0400
Message-ID: <CAO7JXPhZPvzVRyL87qNT5VnaVOf=0wrRftFB-Rjx-vJc3JUMog@mail.gmail.com>
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

On Fri, May 19, 2023 at 6:18=E2=80=AFAM luca abeni <luca.abeni@santannapisa=
.it> wrote:
>
> On Fri, 19 May 2023 11:56:21 +0200
> luca abeni <luca.abeni@santannapisa.it> wrote:
> [...]
>
> OK, sorry again... I found my error immediately after sending the email.
> Uextra is computed as "Umax - ...", not "1 - ...".
> So, I now understand where the 35% comes from.
>
Thanks for debugging this, it makes sense now!

> I now _suspect_ the correct equation should be
>         dq =3D -(max{u_i / Umax, (Umax - Uinact - Uextra)}) * dt
> but I want to test it before wasting your time again; I'll write more
> after performing some more tests.
>
I tried this equation and it fixes the above issue. But a little
confused as to why we should not be limiting the second term to Umax?
In my testing, I was seeing the issue solved with this equation as
well:
 "dq =3D -(max{u_i, (Umax - Uinact - Uextra)} / Umax) * dt"

With both these equations, it doesn't solve couple of other issues we
had discussed before:
- tasks with different bandwidth reclaims differently even when #tasks
  is less than #cpus.
- cpu util may go to 100% when we have tasks with large bandwidth close
  to Umax

As an eg. for issue 1, three tasks - (7,10) (3,10) and (1,10):
TID[590]: RECLAIM=3D1, (r=3D7ms, d=3D10ms, p=3D10ms), Util: 95.20
TID[591]: RECLAIM=3D1, (r=3D3ms, d=3D10ms, p=3D10ms), Util: 81.94
TID[592]: RECLAIM=3D1, (r=3D1ms, d=3D10ms, p=3D10ms), Util: 27.19

re. issue 2, four tasks with same reservation (7,10), tasks tries
to reclaim leading to 100% cpu usage on all three cpus and leads to
system hang.

I was trying to understand the issue and it looks like static values
of Uextra and Umax are causing inaccuracies. Uextra is calculated
based on global bandwidth But based on the local state of the cpu, we
could reclaim more or less than (u_inact + rq->dl.extra_bw). Similarly
Umax is a local max for each cpu and we should not be reclaiming upto
Umax unconditionally. If the global load is high, reclaiming upto Umax
would cause problems as a migration can land in.

I was trying an idea to dynamically decide Uextra and Umax based on
global and local load.

The crux of the idea is as below

+ if (rq->dl.running_bw > rq->dl.max_bw)
+ return delta;
+
+ max_bw =3D rq->dl.this_bw + rq->dl.extra_bw;
+ extra_bw =3D rq->dl.extra_bw;
+ if (rq->dl.this_bw < rq->dl.extra_bw || max_bw > rq->dl.max_bw) {
+ extra_bw =3D rq->dl.max_bw - rq->dl.this_bw;
+ max_bw =3D rq->dl.max_bw;
+ }
+

And use this max_bw and extra_bw in the equation:
 "dq =3D -(max{u_i, (Umax - Uinact - Uextra)} / Umax) * dt"

The reasoning for above changes are:
- running_bw can be greater than max_bw in SMP and we should not be
  reclaiming if that's the case
- Initially we assume max_bw and extra_bw, based on global load.
  If this_bw < extra_bw, it means that cpus are not heavily loaded
  and incoming migrations can be satisfied with local cpu's available
  bandwidth and we could reclaim upto rq->dl.max_bw and use extra_bw
  as "rq->dl.max_bw - rq->dl.this_bw". Also we should limit max_bw for
  any cpu to a maximum of rq->dl.max_cpu.

This does not consider mix of normal and SCHED_FLAG_RECLAIM tasks and
minor changes on top of this are need to consider that scenario. This
seems to fix all the issues that I have encountered.

The above fix doesn't work on equation:
  "dq =3D -(max{u_i / Umax, (Umax - Uinact - Uextra)}) * dt"

cpu still spikes to 100% with 4 tasks of (7,10). I am not sure, but I
guess it might be because we are not limiting the second term to Umax.

Please let me know your thoughts on this.

Thanks again,
Vineeth
