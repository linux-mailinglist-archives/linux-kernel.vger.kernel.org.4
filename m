Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8A75BBCD5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 11:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiIRJc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 05:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIRJcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 05:32:54 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077AF20BD1;
        Sun, 18 Sep 2022 02:32:54 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id 3so18316506qka.5;
        Sun, 18 Sep 2022 02:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4HPwnRM/JJt8uEUplB7308qRpztO7gO6jjhN/yfoSRA=;
        b=x0WKSWdSmUzeskBkj6sUm9RdwV/qdmX7cU7FKUMQDEX1vA4+go9pW5NlCuNGYUF24L
         CAiJOq93zmisVBJLPiVhDYR1MkzDidCW0J9VSjoWyKwliLm7FPetaDlzznijYxmhcQD6
         e4h9e/2UjsqnzfoEOc+WFCovMZ698sK8cx4zcNjuH6HqGygUNPaZnzWhn02anD8UX6SU
         8CGGCq3gzCppQoJsHqJzjEZ9UKWJjNExUP6Gp+25T2l4vXWi5AxMKnjZtjsdXshbXxhP
         /JYWz5x/14rOiWVUVDtrZOg5Si62zQlo3GVze5sdbB57ekK+fncNO20vBdf4330D6eEI
         8fVQ==
X-Gm-Message-State: ACrzQf3SEwzUXATve7MkDj+BuiYW2HqCkv2KD9kB8usQ0rOokF7uZO1i
        p9JKHkvBYbvZt4/rzx6FPMpUjOsHaB6iNQ==
X-Google-Smtp-Source: AMsMyM5QF+zgkKkmSZvQocjCJW93IfLps83wJ225LeZpKOiPcsiNMS7wxFPhLbjh1igoVljcwycDWg==
X-Received: by 2002:a37:b307:0:b0:6cd:f96a:ec1c with SMTP id c7-20020a37b307000000b006cdf96aec1cmr9339117qkf.40.1663493572904;
        Sun, 18 Sep 2022 02:32:52 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id q4-20020a37f704000000b006cbc6e1478csm10014885qkj.57.2022.09.18.02.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 02:32:52 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id p69so31956581yba.0;
        Sun, 18 Sep 2022 02:32:52 -0700 (PDT)
X-Received: by 2002:a05:6902:2c1:b0:6b2:8bb0:79a0 with SMTP id
 w1-20020a05690202c100b006b28bb079a0mr5574273ybh.202.1663493572301; Sun, 18
 Sep 2022 02:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220915233852.415407-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220915233852.415407-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 18 Sep 2022 11:32:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUhq6nJSPdR4XfFvune2g0xHLxB-jP38yhVdwFyO8VQBg@mail.gmail.com>
Message-ID: <CAMuHMdUhq6nJSPdR4XfFvune2g0xHLxB-jP38yhVdwFyO8VQBg@mail.gmail.com>
Subject: Re: [PATCH] ARM: shmobile: Kconfig: Drop selecting SOC_BUS
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Prabhakar,

On Fri, Sep 16, 2022 at 1:39 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Don't automatically select the SOC_BUS config option as we already have
> automatically selected it as part of the SOC_RENESAS config option [0]
> as renesas-soc.c [1] uses the APIs provided by SOC_BUS config option.
>
> [0] drivers/soc/renesas/Kconfig
> [1] drivers/soc/renesas/renesas-soc.c
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.1.

> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -6,5 +6,4 @@ menuconfig ARCH_RENESAS
>         select GPIOLIB
>         select NO_IOPORT_MAP
>         select PINCTRL
> -       select SOC_BUS
>         select ZONE_DMA if ARM_LPAE

Nice catch!
I guess it would make sense to move the GPIOLIB and PINCTRL selects
to drivers/soc/renesas/Kconfig, too, as they are needed for all
(arm32/arm64/riscv) Renesas SoCs?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
