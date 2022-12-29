Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C37658EFB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 17:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbiL2QXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 11:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiL2QWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:22:32 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6A313D1E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:22:32 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso23398966pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sx62UHYE4K/1LMVa7vYzyz951aPNbfYDTxkzvJVDcbE=;
        b=1TIHIZwz3shtBg/m9o0Cyfr+vMF6VQ/1tPJF5BjRY9CDbK9j52CaNfbSN14bDlYHkw
         c5gxx/P5B8EKRsE82QS2LHo1Zya2VBLB3HiyW243u+Z6Ffr7DY0GbQfskeigy9DTMVRs
         RZLQrRTnlzpPUcjZzmSLtY0lKbNGtpuHToQpsZ21nPEfz4eI2Ntan8/8ah3yCJryA7qw
         yaFq6JR3QFgCeKN3BDnx78mCx3MzLgFNqEf4TtsytzkgzDMVxGzOzyv2fqAP6b/8XWW3
         eZdL0Qk00p9gZTYoUcszOk2z16rjjyOffrQCszMyGvn/pe3ycC10o+moFXqSjCH8TrEs
         ftcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sx62UHYE4K/1LMVa7vYzyz951aPNbfYDTxkzvJVDcbE=;
        b=Ke11ylNHWasshTpLq9k4wHrSeWgUgsMeqxiKX0G0x+eNLc7t1RCsutsY39s3gk0TAK
         rThOkeY7lynOtnS4JMjSt86/isW/09mmRGIU5tx/fuX2kzAiHlWxGrapyyfP4QMi/Ieq
         0f3y0bbNfm72UrT6a4RFEzpHXQLFt3NShBqT6Kffp6aL2Mr76DwTjj9Y0OlSWl2mBK7c
         CRrXgPq0j04XZusjvZYtWEwc+cpkFrhH+UVj3XvJKsNEsVYSPxkKJnt+NV3pEHCh19q4
         BkbKgqnIvVWevJ/ZvKBFC+53R5AiGrHOonoUHQDPZrSQLV7BiRtSUrpxouUyUPue7N0m
         PP7w==
X-Gm-Message-State: AFqh2koLGnHzLsvBoOupxx3IeuT9l5n2duYVqFBQ7a84X27y+cdhKEG/
        +BU1bsaT/NucjxQf7bD91+UW1g==
X-Google-Smtp-Source: AMrXdXvYnhLxrzCb2aN5YpTDnDd0GnWOO+iNqjApUuYsI2vXmwxV66+UBQ+tQedx+jtaCH3pAORaaQ==
X-Received: by 2002:a05:6a20:d80a:b0:af:7c29:8a98 with SMTP id iv10-20020a056a20d80a00b000af7c298a98mr38238468pzb.16.1672330951444;
        Thu, 29 Dec 2022 08:22:31 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id bh1-20020a056a02020100b0049e315c3341sm1351206pgb.61.2022.12.29.08.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 08:22:30 -0800 (PST)
Date:   Thu, 29 Dec 2022 08:22:30 -0800 (PST)
X-Google-Original-Date: Thu, 29 Dec 2022 08:21:19 PST (-0800)
Subject:     Re: [PATCH] clocksource/drivers/riscv: Increase the clock source rating
In-Reply-To: <20221228004444.61568-1-samuel@sholland.org>
CC:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        prabhakar.csengg@gmail.com, samuel@sholland.org,
        aou@eecs.berkeley.edu, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     samuel@sholland.org
Message-ID: <mhng-e60a7fcd-f497-4bca-8de3-b57e2a2d3532@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2022 16:44:44 PST (-0800), samuel@sholland.org wrote:
> RISC-V provides an architectural clock source via the time CSR. This
> clock source exposes a 64-bit counter synchronized across all CPUs.
> Because it is accessed using a CSR, it is much more efficient to read
> than MMIO clock sources. For example, on the Allwinner D1, reading the
> sun4i timer in a loop takes 131 cycles/iteration, while reading the
> RISC-V time CSR takes only 5 cycles/iteration.
>
> Adjust the RISC-V clock source rating so it is preferred over the
> various platform-specific MMIO clock sources.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
>  drivers/clocksource/timer-riscv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index a0d66fabf073..55dad7965f43 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -73,7 +73,7 @@ static u64 notrace riscv_sched_clock(void)
>
>  static struct clocksource riscv_clocksource = {
>  	.name		= "riscv_clocksource",
> -	.rating		= 300,
> +	.rating		= 400,
>  	.mask		= CLOCKSOURCE_MASK(64),
>  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
>  	.read		= riscv_clocksource_rdtime,

I've never really understood what we're supposed to do here, it seems 
like we're just picking arbitrary ratings for the various clock drivers 
to get the one we want.  That's really a property of the whole platform, 
though, not the drivers, so trying to encode it as part of the driver 
seems awkward -- if anything I'd expect the ISA clock drivers to be the 
worst on any platform, as otherwise what's the point of adding the 
platform-specific mechanism?

That said, I'm fine with this as long as it's improving things on 
the platforms that actually exist.  IIUC it's only the D1 that has 
multiple clock drivers currently, so if it's good there it's good for 
me.  We'll go crazy trying to reason about all possible future hardware, 
so we can just sort out how to make stuff work as it shows up.  So:

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>

I'll let the clock folks chime in, happy to take it through the RISC-V 
tree but unless someone says something I'm going to assume it's aimed 
over there.

Thanks!
