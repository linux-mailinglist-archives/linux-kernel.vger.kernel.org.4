Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D281A5EC2C0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiI0McA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiI0Mby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:31:54 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C8A5C9D7;
        Tue, 27 Sep 2022 05:31:50 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id o7so5869641qkj.10;
        Tue, 27 Sep 2022 05:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/pgjHOejlC8oGKDlQhQOq2adEqMriIKNJeVAPevDKWk=;
        b=otv3anjU3TXCWAikxTxJX3D0nviaJjUzzdSkoJzWulaING5Mo2L3rY1drTzvGXdDsf
         g2+zGVWhn2W6xqMz193sysq4mRKWIXADCi1yEeonhMjqBLORoYHgWZtxgmFRfc7VbbnT
         wmqQG/Bz+6daxengvoKLi/GyAmYOdpjuLjEVBf9R1y/keGkAUJGkCi7+6Oetho9wJmLK
         Dc6A+VyJHMkVdsyuGa1SGav8yYrUsrYewSZ+ipxksOBSBe91bPwucrtGGeHEY3U/oS9v
         w69qBVd9oh3zy3+bx4VRa5keHA59hgdjMG/3TISX9UmKVgwhq5829ZoWczRuEPiPEbcx
         isBg==
X-Gm-Message-State: ACrzQf1ATspJnD5W4dBR3ICaioGwJyVdpYCajEObQpDzmktcHLCJVR6Q
        yZwvB/lu3wbWMNRidBGflTSfj+BLCvNfqQ==
X-Google-Smtp-Source: AMsMyM5T05fAr4joaBJsMiFyNjFErXuIL0MtS2dYjfammkRmOuVIlzTuzfuFPfbWRt2+55VcUrgroA==
X-Received: by 2002:a05:620a:24d2:b0:6ce:cc17:c0dd with SMTP id m18-20020a05620a24d200b006cecc17c0ddmr17562040qkn.325.1664281909533;
        Tue, 27 Sep 2022 05:31:49 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id r13-20020ae9d60d000000b006cf19068261sm152976qkk.116.2022.09.27.05.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 05:31:48 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-349c4310cf7so98618187b3.3;
        Tue, 27 Sep 2022 05:31:48 -0700 (PDT)
X-Received: by 2002:a81:9c49:0:b0:34a:de:97b8 with SMTP id n9-20020a819c49000000b0034a00de97b8mr24981503ywa.384.1664281908221;
 Tue, 27 Sep 2022 05:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220818145616.3156379-1-arnd@kernel.org> <20220818145616.3156379-6-arnd@kernel.org>
In-Reply-To: <20220818145616.3156379-6-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Sep 2022 14:31:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU3bKa5rU6Tx6LVYOnzSmQZJ5o=5hj=aYqwaOPVPUX-5w@mail.gmail.com>
Message-ID: <CAMuHMdU3bKa5rU6Tx6LVYOnzSmQZJ5o=5hj=aYqwaOPVPUX-5w@mail.gmail.com>
Subject: Re: [PATCH 5/5] ARM: make ARCH_MULTIPLATFORM user-visible
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
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

Hi Arnd,

On Thu, Aug 18, 2022 at 4:56 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Some options like CONFIG_DEBUG_UNCOMPRESS and CONFIG_CMDLINE_FORCE are
> fundamentally incompatible with portable kernels but are currently allowed
> in all configurations. Other options like XIP_KERNEL are essentially
> useless after the completion of the multiplatform conversion.
>
> Repurpose the existing CONFIG_ARCH_MULTIPLATFORM option to decide
> whether the resulting kernel image is meant to be portable or not,
> and using this to guard all of the known incompatible options.
>
> This is similar to how the RISC-V kernel handles the CONFIG_NONPORTABLE
> option (with the opposite polarity).
>
> A few references to CONFIG_ARCH_MULTIPLATFORM were left behind by
> earlier clanups and have to be removed now up.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch, which is now commit 84fc863606239d8b ("ARM: make
ARCH_MULTIPLATFORM user-visible") in soc/for-next.

> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -320,7 +320,19 @@ config ARCH_MMAP_RND_BITS_MAX
>         default 16
>
>  config ARCH_MULTIPLATFORM
> -       def_bool MMU && !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
> +       bool "Require kernel to be portable to multiple machines" if EXPERT
> +       depends on MMU && !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
> +       default y
> +       help
> +         In general, all Arm machines can be supported in a single
> +         kernel image, covering either Armv4/v5 or Armv6/v7.
> +
> +         However, some configuration options require hardcoding machine
> +         specific physical addresses or enable errata workarounds that may
> +         break other machines.
> +
> +         Selecting N here allows using those options, including
> +         DEBUG_UNCOMPRESS, XIP_KERNEL and ZBOOT_ROM. If unsure, say Y.
>
>  menu "Platform selection"
>         depends on MMU
> @@ -1609,6 +1621,7 @@ config CMDLINE_EXTEND
>
>  config CMDLINE_FORCE
>         bool "Always use the default kernel command string"
> +       depends on !ARCH_MULTIPLATFORM

This change broke half of the boards in my collective.
Dropping this dependency again fixes the issue for me.

On older platforms that boot an image with an appended DTB, or where
the boot loader has no support for updating chosen/bootargs, I rely on
CMDLINE_FORCE.

Note that the CMDLINE choice depends on CONFIG_ATAGS=y, although
my systems do not use ATAGS at all.  Arm64, loongarch, microblaze,
nios2, powerpc, and riscv do not have such a limitation, so perhaps
that should be lifted on arm, too?

I do see the rationale behind this change, and agree that a fixed
command line can make the kernel unbootable on other platforms.
However, a common command line is not guaranteed to cause that.
E.g. all Renesas boards use the same chosen/bootargs in upstream DTS,
which works fine if your DHCP server hands out proper nfsroot
parameters (note that mine, running on OpenWRT, doesn't, hence my use
of CMDLINE_FORCE ;-).

>         help
>           Always use the default kernel command string, even if the boot
>           loader passes other arguments to the kernel.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
