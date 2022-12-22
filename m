Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9BD654441
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbiLVPZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbiLVPZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:25:16 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA0631EFA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:23:56 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o5-20020a05600c510500b003d21f02fbaaso4128400wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=is8eOCOUHh28WCvnVkZFiUBMmSnyVVi5EENP2Q9yDrQ=;
        b=e3zjxSILoAIDIfAytzMAfpjBCocaoXQXsl0FxH7xFOeaqnr0pNBnBwAM1lTUCs5zkK
         vv+9o0GtlWFvdXt/0rZrXtjsGc8h4651EHPub2AA+3u4Q+UjIfeO6+61dCqfaV7FvsoQ
         mOAse3Nc0o3rmP4k7XAHcwlAcHspEBBCGYv5rja7KZJ5od8kusnTJjRlTkaDC/m+Fi8O
         6ImxHM+LzjM39rxUC0OjOX6usp1rYgMhEgKzQ+NAHCDqeEQOg8AIZqbtJkU74kJao7gS
         URsoClthBsw3ctdnTkJqkGWy5oKUqsj0Y8gtxJGRr9GrwVd5k/90bA5s4bxAEZ6Md9Fp
         +BJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=is8eOCOUHh28WCvnVkZFiUBMmSnyVVi5EENP2Q9yDrQ=;
        b=25Tj4U2y/iUxOeyCBUSg16ltnYKabeteNNdt9qFRjS0Zll/T/p+gY/u9R+uYsuHkV9
         yfWEAw+9hMl9Qp7InW4iw/IMPhiniuoIdGl2M8OwOWygpeRHWNsKdL28fRzxaoGRQUl2
         iNuuixboBkk1zAhTN8Eiih7jNVZ5pvbl0imUgCqK8/8j6ChTgaPW1niuux7KKBfDQVmI
         A8OuCV2Wz+fhmV88wGjLJxavLk3GqHJMAvRvVNsPS93+gosjcYpJ5IMsHmo+lguqJuPQ
         LA+tmF2tDG3acJuR2/azu7einrNysJ7r4F1HbmI4ZqSyulWezRiSxdRbRtL2u3kMVQLg
         ktNA==
X-Gm-Message-State: AFqh2kqWgcbnh0fmXmaiGEMs8LZFXj4X/h1DNyOfQ6PY4lJzzeonwg/o
        55a/cBI6CQJQF5lzmgq4IIBlfnrb2rR2gpt2ewlP+Q==
X-Google-Smtp-Source: AMrXdXsAAFbAwoPzz/qvyF2/Muv5x34+WYbFLi7B70fteIj56XO/l9ZeYPsFop03LFnIMCOc8cQgkmac2q17NZy0LjU=
X-Received: by 2002:a7b:cd94:0:b0:3d3:4b1a:974b with SMTP id
 y20-20020a7bcd94000000b003d34b1a974bmr577660wmj.113.1671722635094; Thu, 22
 Dec 2022 07:23:55 -0800 (PST)
MIME-Version: 1.0
References: <20221216185012.2342675-1-abdulras@google.com> <CAEUhbmUsFt0H-Dd3XHjuk6sUq0hrV9SFU=1jD2LQ10xywZOZiA@mail.gmail.com>
 <CAO8XFHv_wV_oSuS+e412yr6vjm-44Vf2gJuMO4FvgPeodhWQww@mail.gmail.com> <CAEUhbmX6PE_E8PCEp4mo8Fpjtc-Pm-tmpxws0UKCp715qB+qRg@mail.gmail.com>
In-Reply-To: <CAEUhbmX6PE_E8PCEp4mo8Fpjtc-Pm-tmpxws0UKCp715qB+qRg@mail.gmail.com>
From:   Saleem Abdulrasool <abdulras@google.com>
Date:   Thu, 22 Dec 2022 07:23:43 -0800
Message-ID: <CAO8XFHvrbj86gcBpN7z7n_cGk2wLHND=t0k+QtYgzZGMQOLpsA@mail.gmail.com>
Subject: Re: [PATCH] riscv: avoid enabling vectorized code generation
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Thu, Dec 22, 2022 at 1:41 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi,
>
> On Thu, Dec 22, 2022 at 1:39 AM Saleem Abdulrasool <abdulras@google.com> wrote:
> >
> > On Wed, Dec 21, 2022 at 8:17 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > On Sat, Dec 17, 2022 at 3:12 AM Saleem Abdulrasool <abdulras@google.com> wrote:
> > > >
> > > > The compiler is free to generate vectorized operations for zero'ing
> > > > memory.  The kernel does not use the vector unit on RISCV, similar to
> > > > architectures such as x86 where we use `-mno-mmx` et al to prevent the
> > > > implicit vectorization.  Perform a similar check for
> > > > `-mno-implicit-float` to avoid this on RISC-V targets.
> > > >
> > > > Signed-off-by: Saleem Abdulrasool <abdulras@google.com>
> > > > ---
> > > >  arch/riscv/Makefile | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > > > index 0d13b597cb55..68433476a96e 100644
> > > > --- a/arch/riscv/Makefile
> > > > +++ b/arch/riscv/Makefile
> > > > @@ -89,6 +89,10 @@ KBUILD_AFLAGS_MODULE += $(call as-option,-Wa$(comma)-mno-relax)
> > > >  # architectures.  It's faster to have GCC emit only aligned accesses.
> > > >  KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
> > > >
> > > > +# Ensure that we do not vectorize the kernel code when the `v` extension is
> > > > +# enabled.  This mirrors the `-mno-mmx` et al on x86.
> > > > +KBUILD_CFLAGS += $(call cc-option,-mno-implicit-float)
> > >
> > > This looks like an LLVM flag, but not GCC.
> >
> > Correct, this is a clang flag, though I imagine that GCC will need a
> > similar flag once it receives support for the V extension.
> >
> > > Can you elaborate what exact combination (compiler flag and source)
> > > would cause an issue?
> >
> > The particular case that I was using was simply `clang -target
> > riscv64-unknown-linux-musl -march=rv64gcv` off of main.
> >
> > > From your description, I guess it's that when enabling V extension in
> > > LLVM, the compiler tries to use vector instructions to zero memory,
> > > correct?
> >
> > Correct.
>
> Thanks for the confirmation.
>
> >
> > > Can you confirm LLVM does not emit any float instructions (like F/D
> > > extensions) because the flag name suggests something like "float"?
> >
> > The `-mno-implicit-float` should disable any such emission.  I assume
> > that you are worried about the case without the flag?  I'm not 100%
> > certain without this flag, but the RISCV build with this flag has been
> > running smoothly locally for a while.
> >
> >
>
> I still have some questions about the `-mno-implicit-float` option's behavior.
>
> - If this option is not on, does the compiler emit any F/D extension
> instruction for zero'ing memory when -march=rv64g? I want to know
> whether the `-mno-implicit-float` option only takes effect when "v"
> appears on the -march string.

AFAIK, and from a quick test, no, it will not.  That also makes sense
since the F/D/Q handling is not as likely to be useful for generating
a 0-filled array.  No, the use of `-mno-implicit-float` is not guarded
by the use of the vector extension, but it does only impact the
vectorized code generation (the loop vectorizer, load/store
vectorizer, and SLP vectorizer).

> - If the answer to the above question is no, I wonder why the option
> is called `-mno-implicit-float` as float suggests the FPU usage, but
> actually it is about vectorization. The Clang documentation says
> almost nothing about this option.

The flag itself is from GCC, it was added for the ARM architecture, to
prefer using the scalar core over the VFP register set as ARM uses the
VFP for vectorized operations.  As it so happens, internally in LLVM,
the loop vectorizer uses the (internal) `NoImplicitFloat` function
attribute to prevent the loop from being vectorized, and the flag that
controls this is exposed as `-mimplicit-float` and
`-mno-implicit-float`.

> > > > +
> > > >  ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
> > > >  prepare: stack_protector_prepare
> > > >  stack_protector_prepare: prepare0
> > > > --
>
> Regards,
> Bin
