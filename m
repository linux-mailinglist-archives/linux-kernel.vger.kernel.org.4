Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81CE6FEFE3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbjEKK10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237717AbjEKK1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:27:24 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88578A78
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:27:21 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-ba6d024a196so110573276.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683800841; x=1686392841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uykYdwxNJpjM8txnz6tWDxYllRH8wMK2T/tdDLN4Ol4=;
        b=k/46rzEyfOxnON6yLO9CfMB5FqAsBVFG1sHshkK7KaD1GjosC8TzgS3DTnGhaFdhQX
         vdcHO8v8xmXHkclpRwhy8+p9H8pQc5VQYuscQY7kEEy5kXg8fPdiElNgGYv/8vi5Db/N
         hX0TcDA9W7wikOR/eeUWlj6XUgYNY1gHj6TYzsk7TKyQTjV4UUb8ztswx55M2kl2SAV0
         6jsyzoEpqLJllmlzGqchSVxYDQQtD6i8bfpIPygHpHZV2VuuOApDz3SpTGwwzprvBaYx
         7kO1d6zIaT5psMTM4NCTzRHaZlu9ZcgmVPE5bVqjQut3rGZve5umxv0iWA3xtgyvwaAy
         RzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683800841; x=1686392841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uykYdwxNJpjM8txnz6tWDxYllRH8wMK2T/tdDLN4Ol4=;
        b=ARpWFlnio2UbNP34sz0azmSpn/JH588k79kMd7965+QVTuGdV2kn1P20Me5uIpI+9e
         x0f053Ow3ACmhofppeBOnudtPKw1h+7jjMS2oC3pxvkdowi4GD9JOdbWPFIwaisX7g83
         HYFwkrL5uodIPC0E39y25buz//pY4phkbKOD00G6vZuDJAwFGYFWmm1xEufP5ALnGaY7
         tgTK8VZ64eOenHG6EGyyWZDjNLBfsMJEYFpktt26FK0nChyFbeSnvPCBwVwyzEAhlwb+
         K/1BwpE33DAgQWH/kJc0Mweh4cNvCoO1oG362qaADVkny0Z3jQnbLE9gvnru4qFxOB/s
         rIGw==
X-Gm-Message-State: AC+VfDxzrcjz6fzQ5gXBEUW2a+NcZLnARY2vCaVg7XbB+r7S82eabEyh
        eH4l3BY6leelUIhaZBuDhs2EyZ3eCfpBpNc9cFFfnA==
X-Google-Smtp-Source: ACHHUZ6xHzX4VWPXbZ/KG1bAyRceepuq625gxgPDakbctcB0w7Y1RDt2WG0rJpTuCElIUyAMQ2sGtSXZHVxcvC6HSI4=
X-Received: by 2002:a05:6902:10c3:b0:b9a:3dd2:d21f with SMTP id
 w3-20020a05690210c300b00b9a3dd2d21fmr23165555ybu.56.1683800840848; Thu, 11
 May 2023 03:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683722688.git.geert+renesas@glider.be> <8db63020d18fc22e137e4a8f0aa15e6b9949a6f6.1683722688.git.geert+renesas@glider.be>
In-Reply-To: <8db63020d18fc22e137e4a8f0aa15e6b9949a6f6.1683722688.git.geert+renesas@glider.be>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 May 2023 12:26:44 +0200
Message-ID: <CAPDyKFoTJFoDtSdPcXXQN_zi+TCQwr3UjLYu5jMCq_1sCnnG3Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iopoll: Do not use timekeeping in read_poll_timeout_atomic()
To:     Geert Uytterhoeven <geert+renesas@glider.be>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023 at 15:23, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> read_poll_timeout_atomic() uses ktime_get() to implement the timeout
> feature, just like its non-atomic counterpart.  However, there are
> several issues with this, due to its use in atomic contexts:
>
>   1. When called in the s2ram path (as typically done by clock or PM
>      domain drivers), timekeeping may be suspended, triggering the
>      WARN_ON(timekeeping_suspended) in ktime_get():
>
>         WARNING: CPU: 0 PID: 654 at kernel/time/timekeeping.c:843 ktime_get+0x28/0x78
>
>      Calling ktime_get_mono_fast_ns() instead of ktime_get() would get
>      rid of that warning.  However, that would break timeout handling,
>      as (at least on systems with an ARM architectured timer), the time
>      returned by ktime_get_mono_fast_ns() does not advance while
>      timekeeping is suspended.
>      Interestingly, (on the same ARM systems) the time returned by
>      ktime_get() does advance while timekeeping is suspended, despite
>      the warning.

Interesting, looks like we should spend some time to further
investigate this behaviour.

>
>   2. Depending on the actual clock source, and especially before a
>      high-resolution clocksource (e.g. the ARM architectured timer)
>      becomes available, time may not advance in atomic contexts, thus
>      breaking timeout handling.
>
> Fix this by abandoning the idea that one can rely on timekeeping to
> implement timeout handling in all atomic contexts, and switch from a
> global time-based to a locally-estimated timeout handling.  In most
> (all?) cases the timeout condition is exceptional and an error
> condition, hence any additional delays due to underestimating wall clock
> time are irrelevant.

I wonder if this isn't an oversimplification of the situation. Don't
we have timeout-error-conditions that we expected to happen quite
frequently?

If so, in these cases, we really don't want to continue looping longer
than actually needed, as then we will remain in the atomic context
longer than necessary.

I guess some information about how big these additional delays could
be, would help to understand better. Of course, it's not entirely easy
to get that data, but did you run some tests to see how this changes?

>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Alternatively, one could use a mixed approach (use both
> ktime_get_mono_fast_ns() and a local (under)estimate, and timeout on the
> earliest occasion), but I think that would complicate things without
> much gain.

Another option could be to provide two different polling APIs for the
atomic use-case.

One that keeps using ktime, which is more accurate and generally
favourable - and another, along the lines of what you propose, that
should be used by those that can't rely on timekeeping.

>
> v2:
>   - New.
> ---
>  include/linux/iopoll.h | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
> index 0417360a6db9b0d6..bb2e1d9117e96679 100644
> --- a/include/linux/iopoll.h
> +++ b/include/linux/iopoll.h
> @@ -81,22 +81,30 @@
>                                         delay_before_read, args...) \
>  ({ \
>         u64 __timeout_us = (timeout_us); \
> +       s64 __left_ns = __timeout_us * NSEC_PER_USEC; \
>         unsigned long __delay_us = (delay_us); \
> -       ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
> -       if (delay_before_read && __delay_us) \
> +       u64 __delay_ns = __delay_us * NSEC_PER_USEC; \
> +       if (delay_before_read && __delay_us) { \
>                 udelay(__delay_us); \
> +               if (__timeout_us) \
> +                       __left_ns -= __delay_ns; \
> +       } \
>         for (;;) { \
>                 (val) = op(args); \
>                 if (cond) \
>                         break; \
> -               if (__timeout_us && \
> -                   ktime_compare(ktime_get(), __timeout) > 0) { \
> +               if (__timeout_us && __left_ns < 0) { \
>                         (val) = op(args); \
>                         break; \
>                 } \
> -               if (__delay_us) \
> +               if (__delay_us) { \
>                         udelay(__delay_us); \
> +                       if (__timeout_us) \
> +                               __left_ns -= __delay_ns; \
> +               } \
>                 cpu_relax(); \
> +               if (__timeout_us) \
> +                       __left_ns--; \
>         } \
>         (cond) ? 0 : -ETIMEDOUT; \
>  })
> --
> 2.34.1
>

Kind regards
Uffe
