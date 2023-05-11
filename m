Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4A36FEF26
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjEKJsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjEKJst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:48:49 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B7D1FFE
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:48:48 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-b9d8b2e1576so10691568276.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683798527; x=1686390527;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vx18VK8gbasjrWf/cSU+rJppsMri3t7m3OEVcEQZqnI=;
        b=y0vL277mhdkg0IVyKVF9Xj5BrJGL4T4KRCytU0vWSXUL5Nn/ZM6nF9bPbE+GHaEanR
         OGyLRpkxZ2ZfGnIxVlL77bgBiljl86Gtt6NOj2l6MIA1yxcI4yLkOJ6diCpZ8GI5e2wI
         twdCy5OEhLwuCtSv+5ktrCeaiC13IB5JFArPrF6YbimlRI7PvfV4UIiGlT9YTxQ0hPWG
         PaHwdRQYt7VM5HYCHMzGcT1URzrGtyfXDAmTLlgAqncsbaHtUBU5yMJmdk2zfMon4/eg
         JDsb6oRzQrZUYyWjJPmfmKHYYcEJXXhsX47A6PIJkoPGjX5aT01vVdf11bChcrs+BrtI
         WB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683798527; x=1686390527;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vx18VK8gbasjrWf/cSU+rJppsMri3t7m3OEVcEQZqnI=;
        b=FMPJ9EOV29XS4LsbplBhNfhurp5y3HMtz/LM/OxEml/sh0AGLuIQEQEDAuj1DDG2fc
         puHXJg8IeMo71VKiaKhKm3CdY2Z5Pw+HZgDcE5hBnwdcRUeBe4DryjQYKGqceUCTE4jN
         eZP6oh1teHp026h5kMMegI/bWb0odwbnq/dKpOyvkDRQUyeXToODeW09ciNLEa62hKVB
         fNMncxJ67lS4SxUCXwRSnMzYedPSrRCHT4HM7ZI5iyOK9/OBgflI75JtPrEFUAGGOJ0D
         qJCOHO1G9e9ytzPPiOVLeQvYx31zloBNck3F/LiIczn8Me1xISlKtDnCMFsz511lMRgV
         O5Gw==
X-Gm-Message-State: AC+VfDx6EUca4PHfG+cqr9G+MAcJmSJfKkEq9OoYHM1fubsxqaZxN7LL
        g3h1ABXp4Q/hz+zYY/gBKXGSQOmngD3axBsQp5TAxw==
X-Google-Smtp-Source: ACHHUZ6zKEPk0T0Rs0M+OLTRj/ZtKnufURKamigf+d5W/5pl3IhfOKJmLsK4V4GYDqd2RzyNOgNTx3ByvndgzekpG5k=
X-Received: by 2002:a25:d710:0:b0:ba6:bb9a:3e30 with SMTP id
 o16-20020a25d710000000b00ba6bb9a3e30mr696571ybg.6.1683798527480; Thu, 11 May
 2023 02:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683722688.git.geert+renesas@glider.be> <fe235a1f65bb6c86d2afcdf52d85f80ae728dcc5.1683722688.git.geert+renesas@glider.be>
In-Reply-To: <fe235a1f65bb6c86d2afcdf52d85f80ae728dcc5.1683722688.git.geert+renesas@glider.be>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 May 2023 11:48:11 +0200
Message-ID: <CAPDyKFoAr47m0cKjwgCLFwEUDoHDzssHnz=33KDb47xrC=1iew@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iopoll: Call cpu_relax() in busy loops
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023 at 15:23, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> It is considered good practice to call cpu_relax() in busy loops, see
> Documentation/process/volatile-considered-harmful.rst.  This can not
> only lower CPU power consumption or yield to a hyperthreaded twin
> processor, but also allows an architecture to mitigate hardware issues
> (e.g. ARM Erratum 754327 for Cortex-A9 prior to r2p0) in the
> architecture-specific cpu_relax() implementation.
>
> In addition, cpu_relax() is also a compiler barrier.  It is not
> immediately obvious that the @op argument "function" will result in an
> actual function call (e.g. in case of inlining).
>
> Where a function call is a C sequence point, this is lost on inlining.
> Therefore, with agressive enough optimization it might be possible for
> the compiler to hoist the:
>
>         (val) = op(args);
>
> "load" out of the loop because it doesn't see the value changing. The
> addition of cpu_relax() would inhibit this.
>
> As the iopoll helpers lack calls to cpu_relax(), people are sometimes
> reluctant to use them, and may fall back to open-coded polling loops
> (including cpu_relax() calls) instead.
>
> Fix this by adding calls to cpu_relax() to the iopoll helpers:
>   - For the non-atomic case, it is sufficient to call cpu_relax() in
>     case of a zero sleep-between-reads value, as a call to
>     usleep_range() is a safe barrier otherwise.  However, it doesn't
>     hurt to add the call regardless, for simplicity, and for similarity
>     with the atomic case below.
>   - For the atomic case, cpu_relax() must be called regardless of the
>     sleep-between-reads value, as there is no guarantee all
>     architecture-specific implementations of udelay() handle this.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Makes sense to me! Feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> v2:
>   - Add Acked-by,
>   - Add compiler barrier and inlining explanation (thanks, Peter!).
> ---
>  include/linux/iopoll.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
> index 2c8860e406bd8cae..0417360a6db9b0d6 100644
> --- a/include/linux/iopoll.h
> +++ b/include/linux/iopoll.h
> @@ -53,6 +53,7 @@
>                 } \
>                 if (__sleep_us) \
>                         usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
> +               cpu_relax(); \
>         } \
>         (cond) ? 0 : -ETIMEDOUT; \
>  })
> @@ -95,6 +96,7 @@
>                 } \
>                 if (__delay_us) \
>                         udelay(__delay_us); \
> +               cpu_relax(); \
>         } \
>         (cond) ? 0 : -ETIMEDOUT; \
>  })
> --
> 2.34.1
>
