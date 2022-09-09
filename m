Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D995B2F04
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiIIGbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiIIGbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:31:12 -0400
Received: from condef-02.nifty.com (condef-02.nifty.com [202.248.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64C3F0289;
        Thu,  8 Sep 2022 23:31:09 -0700 (PDT)
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-02.nifty.com with ESMTP id 2896PLmq003944;
        Fri, 9 Sep 2022 15:25:21 +0900
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2896Otxx016731;
        Fri, 9 Sep 2022 15:24:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2896Otxx016731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662704696;
        bh=7NjVtVy//nlbx9x3Pt5ijYazqoLxIT1B+J2u/cAaj5Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KaFtlN+jzzJHMJL7c8FlP3XnT2MXGlN9MN3qKNXeuVsKp446gcsOJv9z4a+ybaOmB
         OlhaK0CsiSKB0kA7ZAto9iF/oIf7KX7lgF97kID7F2pP6njvRlaSud7i9Vb9zsFGa9
         veemIoSD/Rg4KipRuU4apgs5oIFnTpCzTrJTNHJxmobqqXttLfN1zc6XU/3uawal4q
         155fKL5LmrGfd131UnybC6I2MS+65fjIrCjjsAy7f/x2xgjV7tRpJoTfLqMgJ7priv
         x20/MBLp8EzPvOmlnLaJF1mpMqqSz7oeHQFrW6NlQkKs1vWm5L1/m84CDLAl9BhImh
         nRlaRcf9BZeUQ==
X-Nifty-SrcIP: [209.85.160.42]
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1225219ee46so1563400fac.2;
        Thu, 08 Sep 2022 23:24:56 -0700 (PDT)
X-Gm-Message-State: ACgBeo2x3Mz0Gix4lRa9CirddqtGJIK88sL7DJlQR7SzX5RmmHMN5VnQ
        +irFiAgiq+LE6vAv+dtyZe+uyGKbP1maYiKIeoE=
X-Google-Smtp-Source: AA6agR68HxJp7Gt5/W9hJjJn1oNwjlIoYy1BfzwQ+ek2/Aphzioca6ZO3YEOgn/MHLAPX31bHXbrpRG4YXb9tNqZENw=
X-Received: by 2002:a05:6808:1b85:b0:34d:8ce1:d5b0 with SMTP id
 cj5-20020a0568081b8500b0034d8ce1d5b0mr1415326oib.194.1662704695320; Thu, 08
 Sep 2022 23:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220908104337.11940-1-lukas.bulwahn@gmail.com> <20220908104337.11940-7-lukas.bulwahn@gmail.com>
In-Reply-To: <20220908104337.11940-7-lukas.bulwahn@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 9 Sep 2022 15:24:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT4_BJfWqB4ydFqscMaC2zRd7fKycaJvK=8ThXAYMFbDw@mail.gmail.com>
Message-ID: <CAK7LNAT4_BJfWqB4ydFqscMaC2zRd7fKycaJvK=8ThXAYMFbDw@mail.gmail.com>
Subject: Re: [PATCH 6/6] init/Kconfig: remove confusing config EMBEDDED
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

On Thu, Sep 8, 2022 at 7:44 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
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
> Hence, all uses of CONFIG_EMBEDDED have been replaced with CONFIG_EXPERT.
>
> Considering the second purpose, note that already probably arguing that a
> kernel build for an embedded system would choose some values differently is
> already tricky: the set of embedded systems with Linux kernels is already
> quite diverse. Many embedded system have powerful CPUs and it would not be
> clear that all embedded systems just optimize towards one specific aspect,
> e.g., a smaller kernel image size. So, it is unclear if starting with "one
> set of default configuration" that is induced by CONFIG_EMBEDDED is a good
> offer for developers configuring their kernels.
>
> Also, the differences of needed user-space features in an embedded system
> compared to a non-embedded system are probably difficult or even impossible
> to name in some generic way.
>
> So it is not surprising that in the last decade hardly anyone has
> contributed changes to make something default differently in case of
> CONFIG_EMBEDDED=y.
>
> In v6.0-rc4, SECRETMEM is the only config switched off if
> CONFIG_EMBEDDED=y. That one use was removed as well, SECRETMEM was made
> configurable at build time by experts using menuconfig instead.
>
> As there are no further uses of CONFIG_EMBEDDED and CONFIG_EMBEDDED never
> lived up to its intended purpose defined above, simply delete this
> confusing CONFIG_EMBEDDED.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  init/Kconfig | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 9e3fd79b089c..d7429e0b8cae 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1818,14 +1818,6 @@ config DEBUG_RSEQ
>
>           If unsure, say N.
>
> -config EMBEDDED
> -       bool "Embedded system"
> -       select EXPERT
> -       help
> -         This option should be enabled if compiling the kernel for
> -         an embedded system so certain expert options are available
> -         for configuration.
> -
>  config HAVE_PERF_EVENTS
>         bool
>         help
> --
> 2.17.1
>



So, I am supposed to pick this up after 01-05 land.

(please ping me if I forget about it).


For now,
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>



-- 
Best Regards
Masahiro Yamada
