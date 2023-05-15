Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0078870287D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240089AbjEOJ2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239936AbjEOJ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:27:20 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F28172D
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:27:15 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-ba6fa8be5f7so5357254276.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684142834; x=1686734834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4D8nUrI0/GVZUihdtNaUuevI8IcxKFnE2SuuoPSClT0=;
        b=cv9MIT0jYldnuFeGkeH6zI/uSwaWWodEs+ESq5M4AM08AXn/8/o++/BB0YlAJly5dh
         tZ/2qXTV5MSO26MSAKRA4iF+pFWQ6XtWBIztmmJIB8TXKLOZSLX0dO8bwnAch2WjEh5t
         BlLQdCg1vfj7F3UIF8fj5tEzcT1+axfYRYhFqRDBZVgjv7UEdbYs8g5iLJi5he+kUlwU
         Scy52OZFIsDe2/FKYqEi/P27CVbafOgHnj8VRhskeLmdwUUZ/y2V/+T4iBQRNBIlkCyb
         QNzXtDqNHBh/kHUGLFUMdLtpdFUp0Qki9MLRQtyjGwXGzQHkfbRsFmHT9E8GfopaB608
         1jTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684142834; x=1686734834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4D8nUrI0/GVZUihdtNaUuevI8IcxKFnE2SuuoPSClT0=;
        b=Bx2rUGB6j7CqOmQu76tO3Pa1oyzGBa3faeQwgXiv9zahjYG+Pz8uO+2KV9W9D5vjHH
         Dz3f1w6Whz1iwJqkVk6Kh7GKV6yCYh3v/NnGLfu2XlO4HJE7+78NFbwQ+PCL85qoyHi0
         DJFpAjcrVthLuVmU0fm8THWx2bkKJQ3B5IXidTjViQE+ei+pG79gkCa4VoVeatucDe7N
         SaZfV5rwy1MgYKgC/6FyCvkKW8LKSl7pwLMh4EW7VHry5fd0PEa3MW95TESugljjnZeU
         0lJ0pu3FL5rmv92QEqCjDJlgdMvoL1pcV37YQ2wh3bOHgVT+mKfP61DscCZwF8N7PXbu
         n3uQ==
X-Gm-Message-State: AC+VfDwRaD11DQmRqi88GoueM4PVFoAT3kZkmAgiY7pBqgEwnlIyLZdz
        7V6Z6tlS/DCR7xWN+NYg1uWxrMMa5plhBxWOIoqeuw==
X-Google-Smtp-Source: ACHHUZ5dcmVKznCdPQ6LG8FeKzsLYf33bfNB0QZ6tMfujNuJ3pDibxHBtgywI3MUVAzK/i9R07BIHbNNNochJUX1eWQ=
X-Received: by 2002:a25:25cf:0:b0:ba7:4ef5:1ffc with SMTP id
 l198-20020a2525cf000000b00ba74ef51ffcmr5965295ybl.41.1684142834473; Mon, 15
 May 2023 02:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683722688.git.geert+renesas@glider.be> <8db63020d18fc22e137e4a8f0aa15e6b9949a6f6.1683722688.git.geert+renesas@glider.be>
 <CAPDyKFoTJFoDtSdPcXXQN_zi+TCQwr3UjLYu5jMCq_1sCnnG3Q@mail.gmail.com>
 <CAMuHMdV6e84fbbm6m1Rn6f-1xdS10VkHaj5jOB0Sy1uKfacnNw@mail.gmail.com>
 <CAPDyKFr0o_GYauvxorBwg_0uEPYzt4YztohTAHHnYVPtgM4W=Q@mail.gmail.com> <CAMuHMdXEP97-hYKx83Bk02=gofsZMJwiHAsz6KzkKeD3Swxf3A@mail.gmail.com>
In-Reply-To: <CAMuHMdXEP97-hYKx83Bk02=gofsZMJwiHAsz6KzkKeD3Swxf3A@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 May 2023 11:26:38 +0200
Message-ID: <CAPDyKFrz+mv9E5AMgQJBW0exQmO+PYpUWf6ihDvH7q0wkTjpsw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023 at 10:03, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
>
> Hi Ulf,
>
> On Fri, May 12, 2023 at 9:54=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> > On Thu, 11 May 2023 at 14:44, Geert Uytterhoeven <geert@linux-m68k.org>=
 wrote:
> > > On Thu, May 11, 2023 at 12:27=E2=80=AFPM Ulf Hansson <ulf.hansson@lin=
aro.org> wrote:
> > > > On Wed, 10 May 2023 at 15:23, Geert Uytterhoeven
> > > > <geert+renesas@glider.be> wrote:
> > > > > read_poll_timeout_atomic() uses ktime_get() to implement the time=
out
> > > > > feature, just like its non-atomic counterpart.  However, there ar=
e
> > > > > several issues with this, due to its use in atomic contexts:
> > > > >
> > > > >   1. When called in the s2ram path (as typically done by clock or=
 PM
> > > > >      domain drivers), timekeeping may be suspended, triggering th=
e
> > > > >      WARN_ON(timekeeping_suspended) in ktime_get():
> > > > >
> > > > >         WARNING: CPU: 0 PID: 654 at kernel/time/timekeeping.c:843=
 ktime_get+0x28/0x78
> > > > >
> > > > >      Calling ktime_get_mono_fast_ns() instead of ktime_get() woul=
d get
> > > > >      rid of that warning.  However, that would break timeout hand=
ling,
> > > > >      as (at least on systems with an ARM architectured timer), th=
e time
> > > > >      returned by ktime_get_mono_fast_ns() does not advance while
> > > > >      timekeeping is suspended.
> > > > >      Interestingly, (on the same ARM systems) the time returned b=
y
> > > > >      ktime_get() does advance while timekeeping is suspended, des=
pite
> > > > >      the warning.
> > > >
> > > > Interesting, looks like we should spend some time to further
> > > > investigate this behaviour.
> > >
> > > Probably, I was a bit surprised by this behavior, too.
> > >
> > > > >   2. Depending on the actual clock source, and especially before =
a
> > > > >      high-resolution clocksource (e.g. the ARM architectured time=
r)
> > > > >      becomes available, time may not advance in atomic contexts, =
thus
> > > > >      breaking timeout handling.
> > > > >
> > > > > Fix this by abandoning the idea that one can rely on timekeeping =
to
> > > > > implement timeout handling in all atomic contexts, and switch fro=
m a
> > > > > global time-based to a locally-estimated timeout handling.  In mo=
st
> > > > > (all?) cases the timeout condition is exceptional and an error
> > > > > condition, hence any additional delays due to underestimating wal=
l clock
> > > > > time are irrelevant.
> > > >
> > > > I wonder if this isn't an oversimplification of the situation. Don'=
t
> > > > we have timeout-error-conditions that we expected to happen quite
> > > > frequently?
> > >
> > > We may have some.  But they definitely do not happen when time
> > > does not advance, or they would have been mitigated long ago
> > > (the loop would never terminate).
> >
> > Right, I was merely thinking of the case when ktime isn't suspended,
> > which of course is the most common case.
> >
> > >
> > > > If so, in these cases, we really don't want to continue looping lon=
ger
> > > > than actually needed, as then we will remain in the atomic context
> > > > longer than necessary.
> > > >
> > > > I guess some information about how big these additional delays coul=
d
> > > > be, would help to understand better. Of course, it's not entirely e=
asy
> > > > to get that data, but did you run some tests to see how this change=
s?
> > >
> > > I did some timings (when timekeeping is available), and the differenc=
es
> > > are rather minor.  The delay and timeout parameters are in =C2=B5s, a=
nd
> > > 1 =C2=B5s is already a few orders of magnitude larger than the cycle =
time
> > > of a contemporary CPU.
> >
> > Ohh, I was certainly expecting a bigger spread. If it's in that
> > ballpark we should certainly be fine.
> >
> > I will run some tests at my side too, as I am curious to see the
> > behaviour. I will let you know, whatever the result is, of course.
> >
> > >
> > > Under-estimates are due to the time spent in op() (depends on the
> > > user, typical use is a hardware device register read), udelay()
> > > (architecture/platform-dependent accuracy), and general loop overhead=
.
> >
> > Yes, you are right. My main concern is the accuracy of the udelay, but
> > I may be totally wrong here.
> >
> > >
> > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > ---
> > > > > Alternatively, one could use a mixed approach (use both
> > > > > ktime_get_mono_fast_ns() and a local (under)estimate, and timeout=
 on the
> > > > > earliest occasion), but I think that would complicate things with=
out
> > > > > much gain.
> > > >
> > > > Another option could be to provide two different polling APIs for t=
he
> > > > atomic use-case.
> > > >
> > > > One that keeps using ktime, which is more accurate and generally
> > > > favourable - and another, along the lines of what you propose, that
> > > > should be used by those that can't rely on timekeeping.
> > >
> > > At the risk of people picking the wrong one, leading to hard to
> > > find bugs?
> >
> > I agree, If we don't need two APIs, it's certainly better to stick with=
 one.
> >
> > My main point is that we should not sacrifice "performance" for the
> > most common case, just to keep things simple, right?
>
> Most of these loops run just 1 or 2 cycles.
> Performance mostly kicks in when timing out, but note that not
> calling ktime_get() also reduces loop overhead...

That's a good point too!

It sure sounds like the benefits are superior to the potential
downside. Let me not stand in the way of getting this applied.
Instead, feel free to add my:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
