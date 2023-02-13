Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCD7694C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjBMQN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjBMQN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:13:26 -0500
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6268C15573;
        Mon, 13 Feb 2023 08:13:24 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id v13so13593691eda.11;
        Mon, 13 Feb 2023 08:13:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGOKonKYSmEYy24c4Rg+g+Z+58w6/MyCGaceC8x0uAo=;
        b=mJj0Tjxbbe2DOITA5096MDPUJh2sTkPEtRthinz9r5JpNZte7XHEs9f+w/lLTD2pVv
         MGRXOXvCMORfy31QdWHFhWjFjCvDiOaGV+dzYLlhf2xWz89GyR9F2S8Eqv3UR6Yh7FN+
         M19BhOVynUbSl9hVTNdEFNGQepCnSbSw0zlurJV8GTvT22/0CwmvhAqxi4xEPpn+1BDD
         NrIHHmNwFCO+kkYvsmJK8HpVG9Lcp+XnoZe14rt05YxEF7Kgs3wFF3qiNxxkiP3N/Va/
         XuydJbHRFhntUIL/TfG9I3TbC1giN5RZRVQ7lsd2P/Jl2te8jZBys1u9j165mROmNgCp
         fUBA==
X-Gm-Message-State: AO0yUKUa1APNbDogZQtcv3R4Ib3vRSudkYldtWINYqqJ1zyEVDkLz8h5
        B4UxDraaMvWdfWIp2ItoZgVIb5UJMFfCpgrIrcVoNrfO
X-Google-Smtp-Source: AK7set8dpKKGHhBQTz/Weq1u5V8m7oVcIc7DAu1B+XKpoKsZFb13iAO73Wu0vWatwUfNtJT2aTAa+/7/PFZpPxeX7Pw=
X-Received: by 2002:a50:8ade:0:b0:4ab:4933:225b with SMTP id
 k30-20020a508ade000000b004ab4933225bmr4305420edk.6.1676304802988; Mon, 13 Feb
 2023 08:13:22 -0800 (PST)
MIME-Version: 1.0
References: <20230210110934.1379482-1-keguang.zhang@gmail.com>
In-Reply-To: <20230210110934.1379482-1-keguang.zhang@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Feb 2023 17:13:12 +0100
Message-ID: <CAJZ5v0hroiCx-XVMtL-_R4Ojej__bFPkhLbi7ZHp+wNKiTDWKw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: loongson32: Drop obsolete cpufreq platform device
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 12:10 PM Keguang Zhang <keguang.zhang@gmail.com> wrote:
>
> The obsolete cpufreq driver was removed, drop the platform device
> and data accordingly.

I'm going to pick up this one as 6.3 material unless there are any
objections, in which case please let me know.

Thanks!

> Link: https://lore.kernel.org/all/20230112135342.3927338-1-keguang.zhang@gmail.com
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>  .../mips/include/asm/mach-loongson32/cpufreq.h | 18 ------------------
>  .../include/asm/mach-loongson32/platform.h     |  1 -
>  arch/mips/loongson32/common/platform.c         | 16 ----------------
>  arch/mips/loongson32/ls1b/board.c              |  1 -
>  4 files changed, 36 deletions(-)
>  delete mode 100644 arch/mips/include/asm/mach-loongson32/cpufreq.h
>
> diff --git a/arch/mips/include/asm/mach-loongson32/cpufreq.h b/arch/mips/include/asm/mach-loongson32/cpufreq.h
> deleted file mode 100644
> index e422a32883ae..000000000000
> --- a/arch/mips/include/asm/mach-loongson32/cpufreq.h
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * Copyright (c) 2014 Zhang, Keguang <keguang.zhang@gmail.com>
> - *
> - * Loongson 1 CPUFreq platform support.
> - */
> -
> -#ifndef __ASM_MACH_LOONGSON32_CPUFREQ_H
> -#define __ASM_MACH_LOONGSON32_CPUFREQ_H
> -
> -struct plat_ls1x_cpufreq {
> -       const char      *clk_name;      /* CPU clk */
> -       const char      *osc_clk_name;  /* OSC clk */
> -       unsigned int    max_freq;       /* in kHz */
> -       unsigned int    min_freq;       /* in kHz */
> -};
> -
> -#endif /* __ASM_MACH_LOONGSON32_CPUFREQ_H */
> diff --git a/arch/mips/include/asm/mach-loongson32/platform.h b/arch/mips/include/asm/mach-loongson32/platform.h
> index e3fe93ba1bdb..2cdcfb5f6012 100644
> --- a/arch/mips/include/asm/mach-loongson32/platform.h
> +++ b/arch/mips/include/asm/mach-loongson32/platform.h
> @@ -12,7 +12,6 @@
>  #include <nand.h>
>
>  extern struct platform_device ls1x_uart_pdev;
> -extern struct platform_device ls1x_cpufreq_pdev;
>  extern struct platform_device ls1x_eth0_pdev;
>  extern struct platform_device ls1x_eth1_pdev;
>  extern struct platform_device ls1x_ehci_pdev;
> diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
> index 311dc1580bbd..64d7979394e6 100644
> --- a/arch/mips/loongson32/common/platform.c
> +++ b/arch/mips/loongson32/common/platform.c
> @@ -15,7 +15,6 @@
>
>  #include <platform.h>
>  #include <loongson1.h>
> -#include <cpufreq.h>
>  #include <dma.h>
>  #include <nand.h>
>
> @@ -62,21 +61,6 @@ void __init ls1x_serial_set_uartclk(struct platform_device *pdev)
>                 p->uartclk = clk_get_rate(clk);
>  }
>
> -/* CPUFreq */
> -static struct plat_ls1x_cpufreq ls1x_cpufreq_pdata = {
> -       .clk_name       = "cpu_clk",
> -       .osc_clk_name   = "osc_clk",
> -       .max_freq       = 266 * 1000,
> -       .min_freq       = 33 * 1000,
> -};
> -
> -struct platform_device ls1x_cpufreq_pdev = {
> -       .name           = "ls1x-cpufreq",
> -       .dev            = {
> -               .platform_data = &ls1x_cpufreq_pdata,
> -       },
> -};
> -
>  /* Synopsys Ethernet GMAC */
>  static struct stmmac_mdio_bus_data ls1x_mdio_bus_data = {
>         .phy_mask       = 0,
> diff --git a/arch/mips/loongson32/ls1b/board.c b/arch/mips/loongson32/ls1b/board.c
> index 727e06718dab..fed8d432ef20 100644
> --- a/arch/mips/loongson32/ls1b/board.c
> +++ b/arch/mips/loongson32/ls1b/board.c
> @@ -35,7 +35,6 @@ static const struct gpio_led_platform_data ls1x_led_pdata __initconst = {
>
>  static struct platform_device *ls1b_platform_devices[] __initdata = {
>         &ls1x_uart_pdev,
> -       &ls1x_cpufreq_pdev,
>         &ls1x_eth0_pdev,
>         &ls1x_eth1_pdev,
>         &ls1x_ehci_pdev,
>
> base-commit: 159c610af8cdf2b3c915e59162fc867b557cbe7e
> prerequisite-patch-id: a73e24e76a88f519d85fdeb7230e93d53c61434a
> --
> 2.34.1
>
