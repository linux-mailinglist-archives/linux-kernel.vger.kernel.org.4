Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F165ED860
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiI1JCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiI1JCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:02:22 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544D8DF6B5;
        Wed, 28 Sep 2022 02:02:21 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-131a7bce1acso1066092fac.7;
        Wed, 28 Sep 2022 02:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UD/bWW+0wk4E9lEqOO5K0o6p06TOy6G7+0fEDj4qYW0=;
        b=qjE+g0WJ+O6OJPoUPIflSlEuB+MqVoceg7Ja+WcNRQUk7OHgS0AbOuQcpF/sNhWH3B
         Lgnj8+2dA7AETcw1J1bB9rR58nnABnh6jaM2aq6/EksGdoiG9822CkeDcLGPipE3kSO7
         YpSANJuKK3XWKV70xh8YlvQb1ZvH/q3iYKPxgyJfI5MOLvlMyNhODmVqTiwDpC82S1A1
         AbU7uGYML+/gAh0oRf3aqAPUx6BI0qneafHJtGwj1IA8/WBapms3qsXHg9kL6XcL/MKG
         4V3B7qNJ2l/f6XuK0tFjdHVx0UuKa1CIREe4XWyuZj9utwnljVvsWK2l6GCVsO4UdJF+
         ByFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UD/bWW+0wk4E9lEqOO5K0o6p06TOy6G7+0fEDj4qYW0=;
        b=ZthEPV0r+SJ9/oOMH15t9Nfp4nU+ovzFi/c0YeUY6Azk6FisjgToWhvxSh35UWgef9
         MJ0CRdP+b4epLm9c6v6Ka7bWND9TSW3gtFrYy0DYt+FPZ0z97BiOOEolb1aWLt3BINyh
         F/4gqWKHyDa6QPMT2GYFOT/y4oihCR4MJ+CC4bgzMXvXqB1OrS++ovK1z2VKp6Rfs/rv
         V5kqqJ3jmkVN0Zz6tT/RpSsIv0eDUC86elcrk8TbRt1r2Iforxq5TMaBrgGtfDVPtNdH
         r6nhkIAZk9fbJWyeqZ4Q8cAkP0qFVHeU+S6XWnJEkQuChMVBVFhHI+0gSpgdiq96NMAe
         uNyg==
X-Gm-Message-State: ACrzQf1SbKqeCOorrnGczkX7tk/2tg1rbKq5IbR6IuWB76HENyCfnkI6
        MsVZwQCXzJX3gFi0IH0mJmaDyq5G1hiRPVt+o9I=
X-Google-Smtp-Source: AMsMyM5ujk+Oc81+S+ewdw/Ez4+jZI0RZxdZDv4LAzGgfXYpMXmjOK0UXxMKyUnobDtlYUDZAdDMBEgl68vhlfn3Rgk=
X-Received: by 2002:a05:6870:461a:b0:12a:e54e:c8a2 with SMTP id
 z26-20020a056870461a00b0012ae54ec8a2mr4780900oao.252.1664355740443; Wed, 28
 Sep 2022 02:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com> <166421282763.1683223.5035885857817205401.b4-ty@chromium.org>
In-Reply-To: <166421282763.1683223.5035885857817205401.b4-ty@chromium.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 28 Sep 2022 11:01:44 +0200
Message-ID: <CA+icZUUjy7HFQVZ0iUDmGxfazobow1iwcagWX_Opht-7F+BRrg@mail.gmail.com>
Subject: Re: [PATCH v5 00/22] KCFI support
To:     Kees Cook <keescook@chromium.org>
Cc:     samitolvanen@google.com, peterz@infradead.org,
        ndesaulniers@google.com, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, joao@overdrivepizza.com, nathan@kernel.org,
        llvm@lists.linux.dev, mark.rutland@arm.com,
        linux-hardening@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@kernel.org>, catalin.marinas@arm.com,
        rostedt@goodmis.org, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 7:21 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, 8 Sep 2022 14:54:42 -0700, Sami Tolvanen wrote:
> > KCFI is a forward-edge control-flow integrity scheme in the upcoming
> > Clang 16 release, which is more suitable for kernel use than the
> > existing CFI scheme used by CONFIG_CFI_CLANG. KCFI doesn't require
> > LTO, doesn't alter function references to point to a jump table, and
> > won't break function address equality.
> >
> > This series replaces the current arm64 CFI implementation with KCFI
> > and adds support for x86_64.
> >
> > [...]
>
> I assume that Peter's Ack means I should carry the tree, so, to that end:
>
> Applied to for-next/kcfi, thanks!
>

Hi,

I did regularly KCFI testing.

1. Used Sami's samitolvanen.github#linux/kcfi Git on the Linux side.

2. Used *not* LLVM-16 (including KCFI) but with LLVM-15 from
samitolvanen.github#llvm-project/15.x/kcfi Git on the toolchain side.

My last testing was with [1] (Linux v6.0-rc7 + KCFI) and [2] (LLVM
v15.0.1 + KCFI) plus drm-i915-gt/KCFI for Linux v6.0-rc7 patch from
Nathan (see [3]).
Thanks Sami for updating 15.x/kcfi on LLVM side on my request.

So, feel free to add my:

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM-15 (with KCFI
support) on x86-64

Thanks to all involved people!

Best regards,
-Sedat-

[1] https://github.com/samitolvanen/linux/commits/kcfi
[2] https://github.com/samitolvanen/llvm-project/commits/15.x/kcfi
[3] https://github.com/ClangBuiltLinux/linux/issues/1716#issuecomment-1257311327

> [01/22] treewide: Filter out CC_FLAGS_CFI
>         https://git.kernel.org/kees/c/f143ff397a3f
> [02/22] scripts/kallsyms: Ignore __kcfi_typeid_
>         https://git.kernel.org/kees/c/d0f9562ee43a
> [03/22] cfi: Remove CONFIG_CFI_CLANG_SHADOW
>         https://git.kernel.org/kees/c/9fca7115827b
> [04/22] cfi: Drop __CFI_ADDRESSABLE
>         https://git.kernel.org/kees/c/92efda8eb152
> [05/22] cfi: Switch to -fsanitize=kcfi
>         https://git.kernel.org/kees/c/89245600941e
> [06/22] cfi: Add type helper macros
>         https://git.kernel.org/kees/c/e84e008e7b02
> [07/22] lkdtm: Emit an indirect call for CFI tests
>         https://git.kernel.org/kees/c/cf90d0383560
> [08/22] psci: Fix the function type for psci_initcall_t
>         https://git.kernel.org/kees/c/44f665b69c67
> [09/22] arm64: Add types to indirect called assembly functions
>         https://git.kernel.org/kees/c/c50d32859e70
> [10/22] arm64: Add CFI error handling
>         https://git.kernel.org/kees/c/b26e484b8bb3
> [11/22] arm64: Drop unneeded __nocfi attributes
>         https://git.kernel.org/kees/c/5f20997c194e
> [12/22] init: Drop __nocfi from __init
>         https://git.kernel.org/kees/c/5dbbb3eaa2a7
> [13/22] treewide: Drop function_nocfi
>         https://git.kernel.org/kees/c/607289a7cd7a
> [14/22] treewide: Drop WARN_ON_FUNCTION_MISMATCH
>         https://git.kernel.org/kees/c/4b24356312fb
> [15/22] treewide: Drop __cficanonical
>         https://git.kernel.org/kees/c/5659b598b4dc
> [16/22] objtool: Preserve special st_shndx indexes in elf_update_symbol
>         https://git.kernel.org/kees/c/5141d3a06b2d
> [17/22] objtool: Disable CFI warnings
>         https://git.kernel.org/kees/c/3c68a92d17ad
> [18/22] kallsyms: Drop CONFIG_CFI_CLANG workarounds
>         https://git.kernel.org/kees/c/dfb352ab1162
> [19/22] x86/tools/relocs: Ignore __kcfi_typeid_ relocations
>         https://git.kernel.org/kees/c/ca7e10bff196
> [20/22] x86: Add types to indirectly called assembly functions
>         https://git.kernel.org/kees/c/ccace936eec7
> [21/22] x86/purgatory: Disable CFI
>         https://git.kernel.org/kees/c/a4b7a12c5594
> [22/22] x86: Add support for CONFIG_CFI_CLANG
>         https://git.kernel.org/kees/c/3c516f89e17e
>
> --
> Kees Cook
>
