Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8026F5EFD0B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbiI2S26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbiI2S21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:28:27 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0F3143286
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 11:28:26 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e129so2156029pgc.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 11:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kmkU5eKx3bCGNBgsrw/HiECPrMWFtDQ93OEAZ05I5Zw=;
        b=OqOoGfkG5celZzk8DoeCB0Z415XFc+acvqmoX8nBDnRxJgZpg8tGcRuwUEs+9xxChk
         1Hu9orSfm438RdiaqE5SXGX+unJnOXQ8fweCClM5aky1wIdO63k+1n67zorgWReLZRRz
         XDDORlnnR5dIjX1/FUHYRduZZtQBcu2RjAxzT1PHhAJZ4xRuZQ0a+bNPlwbBGagY3V9E
         hsBFGmqWCZ0HoO+Lw7VoOJlgTQHjLePudthZrRONzfmUPWyzXj8DD62qR3aZEB/Q9hD0
         kSxdoiY5KvnClKNNNO+8uBUlqZ0RxOaJJasuZIG4SPX1mPDtIORUcCimKvhwMe8iSP/m
         OkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kmkU5eKx3bCGNBgsrw/HiECPrMWFtDQ93OEAZ05I5Zw=;
        b=pKa9TOOYq2IFX7JCbXjQSIfftv3hfpnpBWGnFEAW3s4rBwKW1pfveJlTqpOe+cBYvR
         oa18Q8X3UdSJJ2COjoAdp3JLdsbCkd81JAGFlILHi1etMiRD2mLfXkVUUA3fjPj3pGQQ
         k+su5osq/eRWl908tMQSVPfm6kiDBOF4/f+wT9JiSjqgD21U7xFXEE2So01Fxbsirtud
         0fFgXPO7rVzg0i5UbF8Z+IvJlhVumU60Qc75p2N/rkmt0H+LNZAXeobRWG8bosf7nWEO
         VdXfJHnlxJ633CsaeM+HraSn/CpDaZoh1kfAWj1VdDa3FET0uRqf8h7rdD6Pk+TYmvuU
         Gi3w==
X-Gm-Message-State: ACrzQf01owANYlZ9Yc3F4ft19YBkQsSIYVVVZTOnzrasFoKJA8No6ch/
        NT9iC8GYb+vxlCzs5prZIdDaARXz8ur4Q+4+XlH9+w==
X-Google-Smtp-Source: AMsMyM6aYy/t89e8ZoJ8vAq/RDFkJ3JUmYiYBj+AqR8RM1wpoJNPrAqLhiGUBk3HkWio80GxowYRw1EQeeWp6uRum/4=
X-Received: by 2002:a63:e709:0:b0:438:98e8:d1c with SMTP id
 b9-20020a63e709000000b0043898e80d1cmr4115018pgi.403.1664476105851; Thu, 29
 Sep 2022 11:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220929152010.835906-1-nathan@kernel.org>
In-Reply-To: <20220929152010.835906-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 29 Sep 2022 11:28:14 -0700
Message-ID: <CAKwvOdn61SYD81r5opTN1N8MAWe5YObPJ8wELei1qOySsoxJyA@mail.gmail.com>
Subject: Re: [PATCH] x86/Kconfig: Drop check for '-mabi=ms' for CONFIG_EFI_STUB
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 8:20 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> A recent change in LLVM made CONFIG_EFI_STUB unselectable because it no
> longer pretends to support '-mabi=ms', breaking the dependency in
> Kconfig. Lack of CONFIG_EFI_STUB can prevent kernels from booting via
> EFI in certain circumstances.
>
> This check was added by commit 8f24f8c2fc82 ("efi/libstub: Annotate
> firmware routines as __efiapi") to ensure that '__attribute__((ms_abi))'
> was available, as '-mabi=ms' is not actually used in any cflags.
> According to the GCC documentation, this attribute has been supported
> since GCC 4.4.7. The kernel currently requires GCC 5.1 so this check is
> not necessary; even when that change landed in 5.6, the kernel required
> GCC 4.9 so it was unnecessary then as well.  Clang supports
> '__attribute__((ms_abi))' for all versions that are supported for
> building the kernel so no additional check is needed. Remove the
> 'depends on' line altogether to allow CONFIG_EFI_STUB to be selected
> when CONFIG_EFI is enabled, regardless of compiler.
>
> Cc: stable@vger.kernel.org
> Fixes: 8f24f8c2fc82 ("efi/libstub: Annotate firmware routines as __efiapi")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1725
> Link: https://gcc.gnu.org/onlinedocs/gcc-4.4.7/gcc/Function-Attributes.html
> Link: https://github.com/llvm/llvm-project/commit/d1ad006a8f64bdc17f618deffa9e7c91d82c444d
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/x86/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f9920f1341c8..81012154d9ed 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1956,7 +1956,6 @@ config EFI
>  config EFI_STUB
>         bool "EFI stub support"
>         depends on EFI
> -       depends on $(cc-option,-mabi=ms) || X86_32
>         select RELOCATABLE
>         help
>           This kernel feature allows a bzImage to be loaded directly
>
> base-commit: f76349cf41451c5c42a99f18a9163377e4b364ff
> --
> 2.37.3
>


-- 
Thanks,
~Nick Desaulniers
