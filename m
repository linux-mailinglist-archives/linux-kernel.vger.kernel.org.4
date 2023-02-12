Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7766269370E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 12:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjBLLqR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 12 Feb 2023 06:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBLLqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 06:46:16 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908EB12875
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 03:46:13 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id nd22so4143770qvb.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 03:46:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQ8uLz/nfTk+HTCBxSvta+7e8bSEcCJROyslrJUxvpU=;
        b=brnQsgNJ8ORAYNcxAaO3osnrLGnrgq8k2GaPfJ67NkbKIogg0yq9eWeV3LglQkB+uN
         Fn/46V/eCdphFIeJiTs0uZH5SbqOohKIPlTxSEjiCEGVDYu/6ct2JATZv9rnDxVleZFa
         ECY501zo4+aivB1V8wZJH0Ds5g+Ow3QU7zH7O3YOdbXTMrg6sJUSu+jDtPqhpZXOdzLD
         DbaURYyK2BKcUwMRUDZW5hYnVNiEaMDrpaKfLUBLBAOmITh/yFyinaVcbSsdNp05Sxk3
         HveDjmaNK4BRSrQD7gSlJT26F/irOYI2/zGpLnN2XmsU0YAYNXWkFJ7nNYS9fzIzGvyi
         Z/UQ==
X-Gm-Message-State: AO0yUKXHf5I1pcxoUYHWYVbXPVtz65fS3resW+LUn1bZaqjL57lr+uKZ
        ikPdyyPNZgCmRYkdUxSbmkNYurlsJ0PTNA==
X-Google-Smtp-Source: AK7set+35/fq4qrfbFz4YimQuw7xYQBa0o2M2TnI+vwV5zOTCl5FKTlYlcOWnELT3+a9TgNPwY2FqQ==
X-Received: by 2002:ad4:5762:0:b0:568:b43:572 with SMTP id r2-20020ad45762000000b005680b430572mr39060717qvx.47.1676202372363;
        Sun, 12 Feb 2023 03:46:12 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id g66-20020a37b645000000b0071a02d712b0sm7526053qkf.99.2023.02.12.03.46.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Feb 2023 03:46:11 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id 81so811530ybp.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 03:46:11 -0800 (PST)
X-Received: by 2002:a25:f202:0:b0:880:3ca9:736b with SMTP id
 i2-20020a25f202000000b008803ca9736bmr2654780ybe.464.1676202371498; Sun, 12
 Feb 2023 03:46:11 -0800 (PST)
MIME-Version: 1.0
References: <20230212113111.1720685-1-j.neuschaefer@gmx.net>
In-Reply-To: <20230212113111.1720685-1-j.neuschaefer@gmx.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 12 Feb 2023 12:46:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU6=qTHEGM6U2o7JOuEGxRmRaOnUkVhepoYKLy71XDNJg@mail.gmail.com>
Message-ID: <CAMuHMdU6=qTHEGM6U2o7JOuEGxRmRaOnUkVhepoYKLy71XDNJg@mail.gmail.com>
Subject: Re: [PATCH] soc: nuvoton: Fix Kconfig
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     openbmc@lists.ozlabs.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sun, Feb 12, 2023 at 12:31 PM Jonathan Neuschäfer
<j.neuschaefer@gmx.net> wrote:
> Unfortunately, version 5 of the Nuvoton WPCM450 SoC driver was applied
> to bmc.git, which misses a few fixes that were in version 6.
>
> This patch adds the missing fixes:

Thanks for your patch!

>  - Add a menu "Nuvoton SoC drivers" to make it easier to add other
>    Nuvoton SoC drivers later on

... and to prevent asking about the Nuvoton WPCM450 SoC driver when
configuring a kernel without support for Nuvoton SoCs.

>  - select CONFIG_REGMAP from CONFIG_WPCM450_SOC

Please include why this is needed.

>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: 77b8c67b5637 ("soc: nuvoton: Add SoC info driver for WPCM450")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  drivers/soc/nuvoton/Kconfig | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/nuvoton/Kconfig b/drivers/soc/nuvoton/Kconfig
> index df46182088ec2..2167d3d739d84 100644
> --- a/drivers/soc/nuvoton/Kconfig
> +++ b/drivers/soc/nuvoton/Kconfig
> @@ -1,11 +1,17 @@
>  # SPDX-License-Identifier: GPL-2.0
> -menuconfig WPCM450_SOC
> +menu "Nuvoton SoC drivers"
> +       depends on ARCH_NPCM || COMPILE_TEST
> +
> +config WPCM450_SOC
>         tristate "Nuvoton WPCM450 SoC driver"
>         default y if ARCH_WPCM450
>         select SOC_BUS
> +       select REGMAP
>         help
>           Say Y here to compile the SoC information driver for Nuvoton
>           WPCM450 SoCs.
>
>           This driver provides information such as the SoC model and
>           revision.
> +

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
