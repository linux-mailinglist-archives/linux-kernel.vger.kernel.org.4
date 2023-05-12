Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F767001E6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240207AbjELHzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240338AbjELHyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:54:37 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF9A11619
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 00:54:13 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-55a10577911so139313697b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 00:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683878051; x=1686470051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYNwvt4ygEmwWz8bQkGTZsHwBw2LQJ0FGs8uf5nofMA=;
        b=ictDbm8V1jhuniWNoQbZT3Yyb8YlucqQ1F9qBEzbqNsoBVWt6eNz47yTDwe+3WrbAi
         iTvKhFbbp9a1nKzyY4ifqeyi1V9ZRU6y/pjmjN0XphCa/Oo6ceVtWdjvrF+rGYqGNCRh
         jmTkiqNfcpOgYrly6IkZK1YTOM9zje1fDPDnS6Yfo6ZNa4PZ+kvXpenHfoWUytNAAswQ
         rtYTMtLLYZ0W1xwlGdZ4bUGTxpnbYq33qLlR0HT5vroBaRlzlwX4b1b6wxB5CQRv6qPf
         isZxJC5u3iBtqInc1/WGSQGryWK5+ayL95sA5NPmyCoAZROCHdIzlmFwO6N9kTlTXOZZ
         tFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683878051; x=1686470051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYNwvt4ygEmwWz8bQkGTZsHwBw2LQJ0FGs8uf5nofMA=;
        b=LtD5ME46OQQscaql8EX8q8utJivNLtbWCMfEhpMtlnRJ/911qWkWJk3ioxxfHf1TUC
         zLyZcDGECwNi7FdJEAQhfYp38DdXdghJhP8dvbCzgZx+nuokquCJXspVIrrh9/d3nfOV
         /35ECOEO2iB9yx3JSlGiyA8UKZL0TPFafu1+9tmxfFtAcLJAjuuvsf3hjJMETKuDMiEU
         Gk7y2lf99MMp11P7v67Vs5agwfnOhnXKMS6tYyRCNGCiMtpPlMjQjvVvnB3tW8be/ZyT
         3K8v5MPJCNV/qoS/lMZEo8YwLzEcqm6gLJ/M02ljZzGz8kOROeBKiUiF3Gr8C1R7s5k3
         CT/Q==
X-Gm-Message-State: AC+VfDz8Wgpax3fQn0J9etWyILMTEqAQB3tmtlFKFIyAMq9vDLKAo6TO
        vS6jUH3w/4GLnXoFJQ/oTfiyDkcIT7GQ/TsjJo4sWw==
X-Google-Smtp-Source: ACHHUZ4f5mzgwJ9scRqmDDAqQE6kFZyey+kWWc+0gd28idNHti6TeOtCDSeRcD4t1elHGRr8qxBvJlt2bB5qbh4nkrQ=
X-Received: by 2002:a0d:c281:0:b0:536:cb48:9059 with SMTP id
 e123-20020a0dc281000000b00536cb489059mr24762932ywd.50.1683878051035; Fri, 12
 May 2023 00:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683722688.git.geert+renesas@glider.be> <8db63020d18fc22e137e4a8f0aa15e6b9949a6f6.1683722688.git.geert+renesas@glider.be>
 <CAPDyKFoTJFoDtSdPcXXQN_zi+TCQwr3UjLYu5jMCq_1sCnnG3Q@mail.gmail.com> <CAMuHMdV6e84fbbm6m1Rn6f-1xdS10VkHaj5jOB0Sy1uKfacnNw@mail.gmail.com>
In-Reply-To: <CAMuHMdV6e84fbbm6m1Rn6f-1xdS10VkHaj5jOB0Sy1uKfacnNw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 12 May 2023 09:53:34 +0200
Message-ID: <CAPDyKFr0o_GYauvxorBwg_0uEPYzt4YztohTAHHnYVPtgM4W=Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iopoll: Do not use timekeeping in read_poll_timeout_atomic()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 at 14:44, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
>
> Hi Ulf,
>
> On Thu, May 11, 2023 at 12:27=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> > On Wed, 10 May 2023 at 15:23, Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > > read_poll_timeout_atomic() uses ktime_get() to implement the timeout
> > > feature, just like its non-atomic counterpart.  However, there are
> > > several issues with this, due to its use in atomic contexts:
> > >
> > >   1. When called in the s2ram path (as typically done by clock or PM
> > >      domain drivers), timekeeping may be suspended, triggering the
> > >      WARN_ON(timekeeping_suspended) in ktime_get():
> > >
> > >         WARNING: CPU: 0 PID: 654 at kernel/time/timekeeping.c:843 kti=
me_get+0x28/0x78
> > >
> > >      Calling ktime_get_mono_fast_ns() instead of ktime_get() would ge=
t
> > >      rid of that warning.  However, that would break timeout handling=
,
> > >      as (at least on systems with an ARM architectured timer), the ti=
me
> > >      returned by ktime_get_mono_fast_ns() does not advance while
> > >      timekeeping is suspended.
> > >      Interestingly, (on the same ARM systems) the time returned by
> > >      ktime_get() does advance while timekeeping is suspended, despite
> > >      the warning.
> >
> > Interesting, looks like we should spend some time to further
> > investigate this behaviour.
>
> Probably, I was a bit surprised by this behavior, too.
>
> > >   2. Depending on the actual clock source, and especially before a
> > >      high-resolution clocksource (e.g. the ARM architectured timer)
> > >      becomes available, time may not advance in atomic contexts, thus
> > >      breaking timeout handling.
> > >
> > > Fix this by abandoning the idea that one can rely on timekeeping to
> > > implement timeout handling in all atomic contexts, and switch from a
> > > global time-based to a locally-estimated timeout handling.  In most
> > > (all?) cases the timeout condition is exceptional and an error
> > > condition, hence any additional delays due to underestimating wall cl=
ock
> > > time are irrelevant.
> >
> > I wonder if this isn't an oversimplification of the situation. Don't
> > we have timeout-error-conditions that we expected to happen quite
> > frequently?
>
> We may have some.  But they definitely do not happen when time
> does not advance, or they would have been mitigated long ago
> (the loop would never terminate).

Right, I was merely thinking of the case when ktime isn't suspended,
which of course is the most common case.

>
> > If so, in these cases, we really don't want to continue looping longer
> > than actually needed, as then we will remain in the atomic context
> > longer than necessary.
> >
> > I guess some information about how big these additional delays could
> > be, would help to understand better. Of course, it's not entirely easy
> > to get that data, but did you run some tests to see how this changes?
>
> I did some timings (when timekeeping is available), and the differences
> are rather minor.  The delay and timeout parameters are in =C2=B5s, and
> 1 =C2=B5s is already a few orders of magnitude larger than the cycle time
> of a contemporary CPU.

Ohh, I was certainly expecting a bigger spread. If it's in that
ballpark we should certainly be fine.

I will run some tests at my side too, as I am curious to see the
behaviour. I will let you know, whatever the result is, of course.

>
> Under-estimates are due to the time spent in op() (depends on the
> user, typical use is a hardware device register read), udelay()
> (architecture/platform-dependent accuracy), and general loop overhead.

Yes, you are right. My main concern is the accuracy of the udelay, but
I may be totally wrong here.

>
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > Alternatively, one could use a mixed approach (use both
> > > ktime_get_mono_fast_ns() and a local (under)estimate, and timeout on =
the
> > > earliest occasion), but I think that would complicate things without
> > > much gain.
> >
> > Another option could be to provide two different polling APIs for the
> > atomic use-case.
> >
> > One that keeps using ktime, which is more accurate and generally
> > favourable - and another, along the lines of what you propose, that
> > should be used by those that can't rely on timekeeping.
>
> At the risk of people picking the wrong one, leading to hard to
> find bugs?

I agree, If we don't need two APIs, it's certainly better to stick with one=
.

My main point is that we should not sacrifice "performance" for the
most common case, just to keep things simple, right?

Kind regards
Uffe
