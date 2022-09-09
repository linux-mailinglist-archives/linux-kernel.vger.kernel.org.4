Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D3B5B2EFC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiIIGbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIIGa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:30:58 -0400
Received: from condef-10.nifty.com (condef-10.nifty.com [202.248.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89CDEE535;
        Thu,  8 Sep 2022 23:30:55 -0700 (PDT)
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-10.nifty.com with ESMTP id 2896MtUp010741;
        Fri, 9 Sep 2022 15:22:55 +0900
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 2896MbQw025804;
        Fri, 9 Sep 2022 15:22:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 2896MbQw025804
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662704558;
        bh=MYlsGWZEaj6riF53CJWpIUBe3dUwLTh06kCOuMwA78I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EmF3zkc3LNSyQbmWSHXGfk4e90+a8K9lM7qun/spg8Uv+kAInTvVhTw/sjDonAAJA
         xUw0VJKG2lOxoIpdR9vBUJhs6923AKBqB8h/m7RrKUlIUYUDUHf5uMOsN1SmKybUyA
         R1q2rsiAeqCImofKS5mh8sytxF42GLVvpIqT1oWvYJjiob2iyq9tCj+Fa5dHEGXQfE
         /itBstjrb9wcEqjRxldkiPS9qpx23RQeVng1seRrfW6x07iM5g8bcMtx+9+cEEaEJj
         w6dvkeuw2VVsRpUrpabG/pKZWsZlmMzoIy+BCLb0jxbAfEL6u3ubypS/y6/+Foo5Pi
         RR9GIKIJ4b9Pg==
X-Nifty-SrcIP: [209.85.210.52]
Received: by mail-ot1-f52.google.com with SMTP id v2-20020a056830090200b006397457afecso470093ott.13;
        Thu, 08 Sep 2022 23:22:37 -0700 (PDT)
X-Gm-Message-State: ACgBeo1dBNuyUH1dFc4BLbCqe3Dq/y+VLxnIJ9LA0ib82l61EbqB1snb
        PoTqYChOlSvd2I7/Du5WFPdDZnY3+0PrIKJXO/s=
X-Google-Smtp-Source: AA6agR6D+NvAoj+USNTBBy4mDLL9rmTs8LTzmXobal0BhXDFou2m+Sac50RiyG6CPG0cg/e8ofovoO8np947WoZjx2g=
X-Received: by 2002:a9d:4806:0:b0:637:cdca:f8d3 with SMTP id
 c6-20020a9d4806000000b00637cdcaf8d3mr4944442otf.225.1662704556432; Thu, 08
 Sep 2022 23:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220908104337.11940-1-lukas.bulwahn@gmail.com> <20220908104337.11940-3-lukas.bulwahn@gmail.com>
In-Reply-To: <20220908104337.11940-3-lukas.bulwahn@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 9 Sep 2022 15:22:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQju9D9=SD_BYVbwk9t1vWdN4+4htGMwiCeWd7V+FjxkA@mail.gmail.com>
Message-ID: <CAK7LNAQju9D9=SD_BYVbwk9t1vWdN4+4htGMwiCeWd7V+FjxkA@mail.gmail.com>
Subject: Re: [PATCH 2/6] x86: make config X86_FEATURE_NAMES visible with EXPERT
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
> Make the config X86_FEATURE_NAMES visible when CONFIG_EXPERT is enabled.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>



> ---
>  arch/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 2ec0b1eabe86..7807eb1c8df8 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -438,7 +438,7 @@ config SMP
>           If you don't know what to do here, say N.
>
>  config X86_FEATURE_NAMES
> -       bool "Processor feature human-readable names" if EMBEDDED
> +       bool "Processor feature human-readable names" if EXPERT
>         default y
>         help
>           This option compiles in a table of x86 feature bits and corresponding
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
