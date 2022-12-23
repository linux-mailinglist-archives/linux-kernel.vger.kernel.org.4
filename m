Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4939C654CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 07:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbiLWG5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 01:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiLWG5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 01:57:47 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E16140F9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 22:57:42 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id x22so10029168ejs.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 22:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yswg7rMmhxbBUpoVnt35yC1P/QAchcZKkUcdaMOuKIY=;
        b=Qp6FkpLML6AVjNhVUTui+QJ76pgWaEmNyndUMzVKcrLjfjKzFw9evUg1jnwwj+m9Jn
         nRVX8T97DZJK5R2RgPv3SnQW4PfCks7SFuIIk2LRmwLlzAy1FpV+yLZbinrnkuoW4bbF
         8Zwnj++7yponDy5YwLr9CW0Zcs8cccj9ERRoSmIhl+mb/ruX3Wk1OiShLreVoUkiRHXL
         GP5A1fy+PcSfr+4JgWHx5xCkYt4v1kmVfPC6KXEctO7ZXxPp6Ilm4zszX/XBJPx3nVD3
         pDDRghO6xGN36SSmX0GKaJJyxa266hJGUPdVUKFT5sEE1mC0+nq7qKxronrUj6wpF6ju
         AP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yswg7rMmhxbBUpoVnt35yC1P/QAchcZKkUcdaMOuKIY=;
        b=vxDUvZU2ihejTEX4bhbfMilu6yOp0AeG3B26XcQDwy05nWBvBlDZ5PxLtIb+FkNZP8
         n+ZCM6AglT/lVuz9qK6kUnthlvmKSSzDf5adDzLV31g/gfwOdkmAwYHb1XPmH4M2HFHx
         j8LyIaad5YhXrw0Kog1gprWElTYoqLElnoxLXNl6PI62kmjr04gqYcY0Fm0KjwLGglRw
         Q3FGgrfvJu5Yz9qVwXPxRW7bMMwhJPYB3bj2S2CHwU9xLFol+6wWBy6Ugd9yLYL2mq6g
         v7i5a4CrhkTGns7NeXq/YPXAGYRyTxqUuR/+lGyeu7k39TNJZZdhfyCK+MteyJ2RC/Co
         Q4qw==
X-Gm-Message-State: AFqh2krO3cpHoU2NOrU62PC0vwQD6SWa8ndhyE0qBgPebuPOIdNbTIFB
        fqAe+4pp7aRnAu4w64Q0H/MssF1uq06jrSwcGjY=
X-Google-Smtp-Source: AMrXdXvi65TdNtln+0GgUG2IhQZbLB02RGrVSF8kgdogr8WTpK8VbsOYnnE8p1dKjyAPUXkkbuVqOQpwtuxBZPdcBAE=
X-Received: by 2002:a17:906:1945:b0:7c0:bb4c:e792 with SMTP id
 b5-20020a170906194500b007c0bb4ce792mr702023eje.618.1671778660629; Thu, 22 Dec
 2022 22:57:40 -0800 (PST)
MIME-Version: 1.0
References: <20221216185012.2342675-1-abdulras@google.com> <CAEUhbmUsFt0H-Dd3XHjuk6sUq0hrV9SFU=1jD2LQ10xywZOZiA@mail.gmail.com>
 <CAO8XFHv_wV_oSuS+e412yr6vjm-44Vf2gJuMO4FvgPeodhWQww@mail.gmail.com>
 <CAEUhbmX6PE_E8PCEp4mo8Fpjtc-Pm-tmpxws0UKCp715qB+qRg@mail.gmail.com> <CAO8XFHvrbj86gcBpN7z7n_cGk2wLHND=t0k+QtYgzZGMQOLpsA@mail.gmail.com>
In-Reply-To: <CAO8XFHvrbj86gcBpN7z7n_cGk2wLHND=t0k+QtYgzZGMQOLpsA@mail.gmail.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Fri, 23 Dec 2022 14:57:30 +0800
Message-ID: <CAEUhbmW-EH4tQr4sXQAJ6iuwO31iWEE=XQXpTMVBp8fX66LDxg@mail.gmail.com>
Subject: Re: [PATCH] riscv: avoid enabling vectorized code generation
To:     Saleem Abdulrasool <abdulras@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hi,

On Thu, Dec 22, 2022 at 11:23 PM Saleem Abdulrasool <abdulras@google.com> wrote:
>
> On Thu, Dec 22, 2022 at 1:41 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi,
> >
> > On Thu, Dec 22, 2022 at 1:39 AM Saleem Abdulrasool <abdulras@google.com> wrote:
> > >
> > > On Wed, Dec 21, 2022 at 8:17 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Sat, Dec 17, 2022 at 3:12 AM Saleem Abdulrasool <abdulras@google.com> wrote:
> > > > >
> > > > > The compiler is free to generate vectorized operations for zero'ing
> > > > > memory.  The kernel does not use the vector unit on RISCV, similar to
> > > > > architectures such as x86 where we use `-mno-mmx` et al to prevent the
> > > > > implicit vectorization.  Perform a similar check for
> > > > > `-mno-implicit-float` to avoid this on RISC-V targets.
> > > > >
> > > > > Signed-off-by: Saleem Abdulrasool <abdulras@google.com>
> > > > > ---
> > > > >  arch/riscv/Makefile | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > > > > index 0d13b597cb55..68433476a96e 100644
> > > > > --- a/arch/riscv/Makefile
> > > > > +++ b/arch/riscv/Makefile
> > > > > @@ -89,6 +89,10 @@ KBUILD_AFLAGS_MODULE += $(call as-option,-Wa$(comma)-mno-relax)
> > > > >  # architectures.  It's faster to have GCC emit only aligned accesses.
> > > > >  KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
> > > > >
> > > > > +# Ensure that we do not vectorize the kernel code when the `v` extension is
> > > > > +# enabled.  This mirrors the `-mno-mmx` et al on x86.
> > > > > +KBUILD_CFLAGS += $(call cc-option,-mno-implicit-float)
> > > >
> > > > This looks like an LLVM flag, but not GCC.
> > >
> > > Correct, this is a clang flag, though I imagine that GCC will need a
> > > similar flag once it receives support for the V extension.
> > >
> > > > Can you elaborate what exact combination (compiler flag and source)
> > > > would cause an issue?
> > >
> > > The particular case that I was using was simply `clang -target
> > > riscv64-unknown-linux-musl -march=rv64gcv` off of main.
> > >
> > > > From your description, I guess it's that when enabling V extension in
> > > > LLVM, the compiler tries to use vector instructions to zero memory,
> > > > correct?
> > >
> > > Correct.
> >
> > Thanks for the confirmation.
> >
> > >
> > > > Can you confirm LLVM does not emit any float instructions (like F/D
> > > > extensions) because the flag name suggests something like "float"?
> > >
> > > The `-mno-implicit-float` should disable any such emission.  I assume
> > > that you are worried about the case without the flag?  I'm not 100%
> > > certain without this flag, but the RISCV build with this flag has been
> > > running smoothly locally for a while.
> > >
> > >
> >
> > I still have some questions about the `-mno-implicit-float` option's behavior.
> >
> > - If this option is not on, does the compiler emit any F/D extension
> > instruction for zero'ing memory when -march=rv64g? I want to know
> > whether the `-mno-implicit-float` option only takes effect when "v"
> > appears on the -march string.
>
> AFAIK, and from a quick test, no, it will not.  That also makes sense
> since the F/D/Q handling is not as likely to be useful for generating
> a 0-filled array.  No, the use of `-mno-implicit-float` is not guarded
> by the use of the vector extension, but it does only impact the
> vectorized code generation (the loop vectorizer, load/store
> vectorizer, and SLP vectorizer).

Thank you. The quick test you did seems to match what the LLVM commit [1] says:

    "It also disables implicit uses of scalar FP, but I don't know if
we have any of those for RISC-V."

[1] https://github.com/llvm/llvm-project/commit/549231d38e10de7371adb85f5452d42ad42f4201

>
> > - If the answer to the above question is no, I wonder why the option
> > is called `-mno-implicit-float` as float suggests the FPU usage, but
> > actually it is about vectorization. The Clang documentation says
> > almost nothing about this option.
>
> The flag itself is from GCC, it was added for the ARM architecture, to
> prefer using the scalar core over the VFP register set as ARM uses the
> VFP for vectorized operations.  As it so happens, internally in LLVM,
> the loop vectorizer uses the (internal) `NoImplicitFloat` function
> attribute to prevent the loop from being vectorized, and the flag that
> controls this is exposed as `-mimplicit-float` and
> `-mno-implicit-float`.
>

It seems GCC does not have such a flag. Thanks for the history
introduction. It was introduced on Arm to disable vectorized operation
using VFP, hence it was named as -no-implict-float. But IMHO the
option is badly named. Maybe -no-implicit-vectorization better fits
what it really does.

FWIW,
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

Regards,
Bin
