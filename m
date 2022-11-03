Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F7F617E1B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiKCNkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiKCNkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:40:21 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0E21145A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:40:19 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k5so1645884pjo.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p7g5TBVGkKQ0lAvmW4KCQddZ6KI+cEcqJL4CP9OUs3I=;
        b=QQrPutByS9ukyv12+ok6rymDJkdnqSiHC5KCfYLG0aak2oITalT2a+z9a5C5xug4Pm
         5JfrClELCCmRPq6ZSZX4ROxEjmFsrRFUHanKvn75HTsF5zb9G7Uvvi474XtZWLqjtGLn
         wi+0KqreBCJWwy79YrLdaN0q+6K88NBdKTMnpSF1fNNF00K48vgXxpoYGe5lNa+5a/l0
         TJGhf/emMGvPtvsZ7x7KmNTV8Xzb9JKfzbBKJOh7BnO+01TVCBfqJs/0J4QE3Vqz6ECQ
         akprGaW97va1kbTD6Yy8djiyDDUB821NHTdDFTYYNSDk46vVjQ1uIeAftIav4tu6Arks
         tL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p7g5TBVGkKQ0lAvmW4KCQddZ6KI+cEcqJL4CP9OUs3I=;
        b=5aymBychAxVHn37+iA4pTwOstVhDcIXzWpEpVj18FfJWoiNpsN22qNcu8Cv4aG6rC1
         om7lCdY+QrMj6diYL1kkDyDl2gx94/QU/JjGcT1xZQXFRMl7i7nl+tgnWMq2VvDlcfrf
         t4r8TQ7Kz3Yplu66glaSvvI4xP4+SuVs1nnamrb/LV7VHnvwLW8jZIFi07TiPdilK4x/
         7wewRjK1fU+7w+wdienUR7WoBPGvAg3rjNCYVIwJS7cRllsna3rLxmrrAXk50OTSxONN
         zEv2WoZpg6UByEJ4w+On3kxkA+ILxtnM7Ndmz9REQgZkkLtASg3q2d9vPl4f8U3GdRvf
         J4Eg==
X-Gm-Message-State: ACrzQf29Nwf4+SbEQQz9L8OGaBvkGuq9I8gFJmqiiQcv8QTbKdyewJXB
        ZpyfjfWBtdefCskB8AsxZULGJgO4urtcZZgHtE8=
X-Received: by 2002:a17:90a:df91:b0:213:8a69:c504 with SMTP id
 p17-20020a17090adf9100b002138a69c504mt26837365pjv.82.1667482818297; Thu, 03
 Nov 2022 06:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220912132501.1812575-1-georgepee@gmail.com>
In-Reply-To: <20220912132501.1812575-1-georgepee@gmail.com>
From:   George Pee <georgepee@gmail.com>
Date:   Thu, 3 Nov 2022 08:40:07 -0500
Message-ID: <CAKj0CMvyYvp=LjGmG3dxzN4mjE76zBzjiLkCe-tK0bvsM0JDzA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM : Support for optional ARMv8.2 half-precision
 floating point extension
Cc:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Keith Packard <keithpac@amazon.com>,
        Austin Kim <austindh.kim@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 8:25 AM george pee <georgepee@gmail.com> wrote:
>
> Report feature /proc/cpuinfo as fphp to be consistent with arm64
>
> Signed-off-by: george pee <georgepee@gmail.com>
> ---
>  arch/arm/include/uapi/asm/hwcap.h | 1 +
>  arch/arm/kernel/entry-armv.S      | 3 ++-
>  arch/arm/kernel/setup.c           | 1 +
>  arch/arm/vfp/vfpmodule.c          | 2 ++
>  4 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/uapi/asm/hwcap.h b/arch/arm/include/uapi/asm/hwcap.h
> index 990199d8b7c6..5d635dce8853 100644
> --- a/arch/arm/include/uapi/asm/hwcap.h
> +++ b/arch/arm/include/uapi/asm/hwcap.h
> @@ -37,5 +37,6 @@
>  #define HWCAP2_SHA1    (1 << 2)
>  #define HWCAP2_SHA2    (1 << 3)
>  #define HWCAP2_CRC32   (1 << 4)
> +#define HWCAP2_FPHP    (1 << 5)
>
>  #endif /* _UAPI__ASMARM_HWCAP_H */
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index c39303e5c234..161f8df852e1 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -625,11 +625,12 @@ call_fpe:
>         ret.w   lr                              @ CP#6
>         ret.w   lr                              @ CP#7
>         ret.w   lr                              @ CP#8
> -       ret.w   lr                              @ CP#9
>  #ifdef CONFIG_VFP
> +       W(b)    do_vfp                          @ CP#9  (VFP/FP16)
>         W(b)    do_vfp                          @ CP#10 (VFP)
>         W(b)    do_vfp                          @ CP#11 (VFP)
>  #else
> +       ret.w   lr                              @ CP#9
>         ret.w   lr                              @ CP#10 (VFP)
>         ret.w   lr                              @ CP#11 (VFP)
>  #endif
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 1e8a50a97edf..8887d0f447d6 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -1258,6 +1258,7 @@ static const char *hwcap2_str[] = {
>         "sha1",
>         "sha2",
>         "crc32",
> +       "fphp",
>         NULL
>  };
>
> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> index 2cb355c1b5b7..0806b0b1f2c7 100644
> --- a/arch/arm/vfp/vfpmodule.c
> +++ b/arch/arm/vfp/vfpmodule.c
> @@ -831,6 +831,8 @@ static int __init vfp_init(void)
>
>                         if ((fmrx(MVFR1) & 0xf0000000) == 0x10000000)
>                                 elf_hwcap |= HWCAP_VFPv4;
> +                       if ((fmrx(MVFR1) & 0x0f000000) == 0x03000000)
> +                               elf_hwcap2 |= HWCAP2_FPHP;
>                 }
>         /* Extract the architecture version on pre-cpuid scheme */
>         } else {
> --
> 2.37.3
>

Any concerns with this?
