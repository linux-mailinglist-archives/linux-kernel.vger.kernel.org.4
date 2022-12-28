Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559D765726D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 04:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiL1D7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 22:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiL1D7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 22:59:10 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CA0DF41
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 19:59:09 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id t17so35884210eju.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 19:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uajz3/rFZIhwuvQqTExbgiK8YMKxE8V5aNoMCt5C2v8=;
        b=lHXBOBizmfaIzvp++AQ6RJ92WuaqW6pG9YZRpq5bLYzS8MOlLALqcAC+075kTGL5SS
         GSM0SmuU05twt0HJj7q5cdRSvfNkKVR51J+05O+s2yzgxgjwhLdzcBkGfT/kVPo2hwzR
         KlxfTUJFig94MrwK7j9n3VhxOPeFJB66B0ObpUEeNAUaDJ/COPnjLrcjDc1vtxO1LQBs
         5pm9pckLt+D+wo/mlVvChGG26zmTu8Z0Bmb4dgx/2aajaHcv0j2CDkv1/5Q3SQLQEx3A
         uB3Zk5kC12vi0S+mx6n2wbVIynymM+xQu5nwrRZaHkGcl9a4P1w5Gzbbuo6jmjV/BQkx
         UdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uajz3/rFZIhwuvQqTExbgiK8YMKxE8V5aNoMCt5C2v8=;
        b=u5hVMLcofrMfU+QzYsuV3ieVho18f872yg0Pq8ZTytM+ajkdgwbAey8nJ7RngDb9DD
         e0DJLRllTzn3ZajM8hLDYd/hG60qD/TkFWHqPdb08UZEGApNX5xP9hI0MG5CjATvd2x6
         h6Eszjm2wbd5Q4hs6dwaFgx3sssC45ej88l1yYwz7fyXpgIHMBkwwjgIjcNH9SxAngZW
         B2yskZG2bVFFbJcu5nSKZGIizccGCOECHpL2+ns8NVadsPPAlkBS+zP4VbY48pR4cYh0
         B7MqkCTER/bPhFfk1iI0iwgDN8crowz41UY4xHRV/YZ5xwXrzEPPY7wIQGKVwYOgbZgW
         4bog==
X-Gm-Message-State: AFqh2kpy/dmaTODMzHXwC1H5bX+bV7RKFuS/bIKHns6e3Q6ORjShrIui
        rdbH06CsPlUL/97UJmRE5gKCD4eElysrP7eoAfiiMw==
X-Google-Smtp-Source: AMrXdXtwEtyDk+WDtQkPybw4BXyKeFjO2U4aWXjYbVkZHi7uXkJp/qZbgHSEK2c1NAljUwtDsAxeamTn5bcGiQwUjzI=
X-Received: by 2002:a17:906:3385:b0:7b2:7af0:c231 with SMTP id
 v5-20020a170906338500b007b27af0c231mr1586588eja.240.1672199948219; Tue, 27
 Dec 2022 19:59:08 -0800 (PST)
MIME-Version: 1.0
References: <20221228004444.61568-1-samuel@sholland.org>
In-Reply-To: <20221228004444.61568-1-samuel@sholland.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 28 Dec 2022 09:28:56 +0530
Message-ID: <CAAhSdy2WhPouNAYHLaJL8_W4Y4uBRCta=0TcPxpSrsGOmPpboA@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/riscv: Increase the clock source rating
To:     Samuel Holland <samuel@sholland.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prabhakar Lad <prabhakar.csengg@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 6:14 AM Samuel Holland <samuel@sholland.org> wrote:
>
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

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

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
>         .name           = "riscv_clocksource",
> -       .rating         = 300,
> +       .rating         = 400,
>         .mask           = CLOCKSOURCE_MASK(64),
>         .flags          = CLOCK_SOURCE_IS_CONTINUOUS,
>         .read           = riscv_clocksource_rdtime,
> --
> 2.37.4
>
