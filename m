Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC2161840E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiKCQSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiKCQSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:18:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8DD2656
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 09:18:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id f7so3822856edc.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 09:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Lg2UqtA5ubSwaY82upgpYgIeAri2st+rw+ftxb/tfY=;
        b=wnRRKdL9HHArzn7VH6dv74vlZUwBr10F8BsAqBLZB9cUVAJJg4Q79h3hvBjPNer+5i
         AaP5fyZbS3a299CXhCkOEZWwr1oMTSqTN1O6Gn38vS1ywphAuTeDOuUKsXWvr4MuSK8K
         TpR1sXfLzk0uOLrvMwFVY+XGxASueH6bDhQgG8GuYuR7NFeap6wiQz4kcL5wLrqVZN/A
         DYek1eALMezvv/LOvaBZvpoVCY05cT0R+VZV7jzGzkZreHhqWL1nXi9ZpY8NjNieC7JV
         JuhkWueJdSqyHJrxSxDRuXfALU8exDTDJRSZZuDfxdk0PzJBc3Czx5amYWy8Gb1l51Fq
         zv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Lg2UqtA5ubSwaY82upgpYgIeAri2st+rw+ftxb/tfY=;
        b=fcysshHTgZx+rlrnXAQ3VfxKj5h01F/bIm6nhtRRR2QkqSqHTT4xduRrq7fjrMxHpB
         Wa7MUnwY/29iOC0eWHMVow/ayl0RZEYsQsvfsD1djBEg2nqtS9rux2NKJBKnFVTTby7D
         tJWb+XgPpdLGyKPGUgtIXO+9J5UdkdtWjqAObMB3ukJa71xqGOXCHArC670LfMlxZ7E9
         h5AD3Uae929Dlk26xT8G4CBcfUum7et8Gr1BD/7c0DHS+UKuL7VIsfUKxqNrHB/qPR0E
         NSm71aUF+oOHazPDTugDYvhORZQJlUO2lH/NBphFtVh2e8Bcn19jZmxHov1Q/4hTl9Hb
         Jr6w==
X-Gm-Message-State: ACrzQf3Plj9pSb3wjliuD+EPUBwi0LKScKxa5Mw5nU3KzTfGxcsHvjY/
        rARnRwNwn/rZnceD0GcIgdvELYsN0AH+N3/ukWTLbg==
X-Google-Smtp-Source: AMsMyM4e8z84xV9gGUnPbPjZ4Y/FoDNwAMKpTQT6uovGKYdP0eIdPxpKv++HkcVTEwpFvEGwkh6krSYFSzZQC4knIEQ=
X-Received: by 2002:aa7:d385:0:b0:461:8cd3:b38b with SMTP id
 x5-20020aa7d385000000b004618cd3b38bmr31178725edq.172.1667492312948; Thu, 03
 Nov 2022 09:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220912132501.1812575-1-georgepee@gmail.com>
In-Reply-To: <20220912132501.1812575-1-georgepee@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 3 Nov 2022 17:18:21 +0100
Message-ID: <CACRpkdY96uPTKgxK_LkQjTuqtd3GU=VYmGDg1zWqsyoxo0Twog@mail.gmail.com>
Subject: Re: [PATCH v2] ARM : Support for optional ARMv8.2 half-precision
 floating point extension
To:     george pee <georgepee@gmail.com>, Mark Brown <broonie@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Keith Packard <keithpac@amazon.com>,
        Austin Kim <austindh.kim@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for top-posting but provding context.

Please CC Mark Brown om FP extensions, he is looking after these.
Now add on To:

Yours,
Linus Walleij

On Mon, Sep 12, 2022 at 3:25 PM george pee <georgepee@gmail.com> wrote:

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
