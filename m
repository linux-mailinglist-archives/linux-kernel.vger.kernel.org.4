Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3625B2EEE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiIIGao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiIIGak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:30:40 -0400
Received: from condef-04.nifty.com (condef-04.nifty.com [202.248.20.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68317C0E56;
        Thu,  8 Sep 2022 23:30:33 -0700 (PDT)
Received: from conssluserg-02.nifty.com ([10.126.8.81])by condef-04.nifty.com with ESMTP id 2896Mmfb024092;
        Fri, 9 Sep 2022 15:22:48 +0900
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2896MLgs017587;
        Fri, 9 Sep 2022 15:22:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2896MLgs017587
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662704542;
        bh=5gq83gYMVKdRU9r4hYVd7D4iDUbndUfSB3Fa4VRbM4A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AnqLwOKSyV1yvR9h2eklSSZLeceed6RdO2Gf/5J9GCEA+KUZUte/VCxEIe566Bx5W
         z8xGHUohBHNbDCpQR9FliNJVlObeKgjMNVNlLKRwdkMeLCGNNA/MDArrpocDwVPu4I
         eNfzeSKSR+NdTMp11/S5g7cpZ6tOJRciR8UnV1BN68Rw4rY4mWjT99JxjYDUHg17Ad
         cPk8Ge+dVWYT1ujNt1x5J1TofMVley7cGfi5zO0B8sqk3LvbMYQDS32So6+cvHaCOe
         DGToSLfQpqXjB8JIck1Rum68RwwzfeeVjcnf6pn73m1fME0xswf2zUwYNbtz4zgXdV
         4jYavkTsmmSNw==
X-Nifty-SrcIP: [209.85.160.44]
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1225219ee46so1552109fac.2;
        Thu, 08 Sep 2022 23:22:22 -0700 (PDT)
X-Gm-Message-State: ACgBeo0yPPs3YxI6cvYrJhlck57Le/hA/iP/bJKsYio+0xFk5ymYYs7W
        EMlblvPKVdsKybTm7vl7pP7nG60g2NNk0k/7bCU=
X-Google-Smtp-Source: AA6agR5EfzPia/RtqfbgAaGxxK9GzsmSY41Hz6mLA8v9uVa6Dj7ot+FeljQw/MpvxviU07INWGgyx2GDfngU3/ZEkp4=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr3918880oab.287.1662704541192; Thu, 08
 Sep 2022 23:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220908104337.11940-1-lukas.bulwahn@gmail.com> <20220908104337.11940-2-lukas.bulwahn@gmail.com>
In-Reply-To: <20220908104337.11940-2-lukas.bulwahn@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 9 Sep 2022 15:21:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQzPo3WuxEa4PpEQ3BEmzLgFP1Zbn0mnU+jFzf-+Rk0Jg@mail.gmail.com>
Message-ID: <CAK7LNAQzPo3WuxEa4PpEQ3BEmzLgFP1Zbn0mnU+jFzf-+Rk0Jg@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm: make config ARM_PATCH_PHYS_VIRT visible with EXPERT
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 7:43 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 6a108a14fa35 ("kconfig: rename CONFIG_EMBEDDED to CONFIG_EXPERT")
> introduces CONFIG_EXPERT to carry the previous intent of CONFIG_EMBEDDED
> and just gives that intent a much better name. That has been clearly a good
> and long overdue renaming, and it is clearly an improvement to the kernel
> build configuration that has shown to help managing the kernel build
> configuration in the last decade.
>
> However, rather than bravely and radically just deleting CONFIG_EMBEDDED,
> this commit gives CONFIG_EMBEDDED a new intended semantics, but keeps it
> open for future contributors to implement that intended semantics:
>
>     A new CONFIG_EMBEDDED option is added that automatically selects
>     CONFIG_EXPERT when enabled and can be used in the future to isolate
>     options that should only be considered for embedded systems (RISC
>     architectures, SLOB, etc).
>
> Since then, this CONFIG_EMBEDDED implicitly had two purposes:
>
>   - It can make even more options visible beyond what CONFIG_EXPERT makes
>     visible. In other words, it may introduce another level of enabling the
>     visibility of configuration options: always visible, visible with
>     CONFIG_EXPERT and visible with CONFIG_EMBEDDED.
>
>   - Set certain default values of some configurations differently,
>     following the assumption that configuring a kernel build for an
>     embedded system generally starts with a different set of default values
>     compared to kernel builds for all other kind of systems.
>
> Considering the first purpose, at the point in time where CONFIG_EMBEDDED
> was renamed to CONFIG_EXPERT, CONFIG_EXPERT already made 130 more options
> become visible throughout all different menus for the kernel configuration.
> Over the last decade, this has gradually increased, so that currently, with
> CONFIG_EXPERT, roughly 170 more options become visible throughout all
> different menus for the kernel configuration. In comparison, currently with
> CONFIG_EMBEDDED enabled, just seven more options are visible, one in x86,
> one in arm, and five for the ChipIdea Highspeed Dual Role Controller.
>
> As the numbers suggest, these two levels of enabling the visibility of even
> more configuration options---beyond what CONFIG_EXPERT enables---never
> evolved to a good solution in the last decade. In other words, this
> additional level of visibility of configuration option with CONFIG_EMBEDDED
> compared to CONFIG_EXPERT has since its introduction never become really
> valuable. It requires quite some investigation to actually understand what
> is additionally visible and it does not differ significantly in complexity
> compared to just enabling CONFIG_EXPERT. This CONFIG_EMBEDDED---or any
> other config to show more detailed options beyond CONFIG_EXPERT---is
> unlikely to be valuable unless somebody puts significant effort in
> identifying how such visibility options can be properly split and creating
> clear criteria, when some config option is visible with CONFIG_EXPERT and
> when some config option is visible only with some further option enabled
> beyond CONFIG_EXPERT, such as CONFIG_EMBEDDED attempted to do. For now, it
> is much more reasonable to simply make those additional seven options that
> visible with CONFIG_EMBEDDED, visible with CONFIG_EXPERT, and then remove
> CONFIG_EMBEDDED. If anyone spends significant effort in structuring the
> visibility of config options, they may re-introduce suitable new config
> options simply as they see fit.
>
> Make the config ARM_PATCH_PHYS_VIRT visible when CONFIG_EXPERT is enabled.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>

> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 4adfa5dd3556..4b212ab1b281 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -243,7 +243,7 @@ config ARCH_MTD_XIP
>         bool
>
>  config ARM_PATCH_PHYS_VIRT
> -       bool "Patch physical to virtual translations at runtime" if EMBEDDED
> +       bool "Patch physical to virtual translations at runtime" if EXPERT
>         default y
>         depends on !XIP_KERNEL && MMU
>         help
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
