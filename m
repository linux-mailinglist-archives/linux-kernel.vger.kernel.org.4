Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21714653567
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiLURjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiLURjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:39:16 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF5BE1F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:39:15 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h7so15675649wrs.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fR1kbCDUkA9DvVzs/WSk5pBrfny7Vm/0ugw0mQRZKMc=;
        b=UcpPcCzlTg6O7p4UU3mS50/UlE8ElDXkJVzXxNw0j+PVmRIF0GJYY5QeDNHyqDQ5Pg
         /SgFNijVGIjIyqOosw9KjkqPExMt6fmY5lCSSmz2zj2r6skVbDAhUTvGB7qAjK2h1qrl
         hRCi2YmDlYSGUZPn2H1uMzIi2RpwhkkQtyWTlivZR89oX1dAk4QZtY0FQyNrprEu0tUy
         q9LTJ9yPDZ5NZn8xOGFgdjU0k2pp5tUmutGqzdYTOoKlKCgbLy0kFmyQd3IYdqLlaUIE
         d0+DpYfwK3ZxbyTHts4i+oJAn96CpHlR+ZF9sVSZz2EJ7bEdLNFx6a9ng5Zz01SggLv8
         Xesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fR1kbCDUkA9DvVzs/WSk5pBrfny7Vm/0ugw0mQRZKMc=;
        b=K11BJv4jXmy9xeyoCvCRrM9qWoaLM39rcC13tlu6gIkT3ccvZmbQZcpJvvEcsHDljU
         RfUliV8p7w5wSEh2i/iScoUZ+7fu4+9FS6Un3NN0l55OH/MTMQYD3Q5ZA8Ho78UQQ++C
         mIMUD0JJ5oeS1HI21hP/u457+frAUOM5pnJ1F+dJlIvSvZekK0ZBEj57zSftU1IzwQ2G
         eFZvSLb1a5y091t62bnG5E/gSzyPTdT6gf112+qlnfN38W2jzPcesrw7ItwTxMHUP6AX
         UUXeQRWq7Jl7FuCfzQwDWxkXST76c9Bk/cTrm1d0WLcGHKtuOnhdbr8abInheiJauXUm
         p3rg==
X-Gm-Message-State: AFqh2kpWtOX7RZe6nW+tvhdDmwTi1IfXH02SppvDX1RnT7HpmyP52NVO
        +JT8zvrdyAyOHIXzXEnkFZ2l6dxzuzXVLtHmJZf+6wAM+TMa6Q==
X-Google-Smtp-Source: AMrXdXvwgkUIHGbRYtwbc3maX91bHhDzczQHQxN9LoNIF9j0O3LJznArds+7tZrUlrS1lITiA7W8NoNZMQJhR8axU6w=
X-Received: by 2002:adf:eb09:0:b0:242:739d:7f85 with SMTP id
 s9-20020adfeb09000000b00242739d7f85mr75763wrn.407.1671644354463; Wed, 21 Dec
 2022 09:39:14 -0800 (PST)
MIME-Version: 1.0
References: <20221216185012.2342675-1-abdulras@google.com> <CAEUhbmUsFt0H-Dd3XHjuk6sUq0hrV9SFU=1jD2LQ10xywZOZiA@mail.gmail.com>
In-Reply-To: <CAEUhbmUsFt0H-Dd3XHjuk6sUq0hrV9SFU=1jD2LQ10xywZOZiA@mail.gmail.com>
From:   Saleem Abdulrasool <abdulras@google.com>
Date:   Wed, 21 Dec 2022 09:39:02 -0800
Message-ID: <CAO8XFHv_wV_oSuS+e412yr6vjm-44Vf2gJuMO4FvgPeodhWQww@mail.gmail.com>
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

On Wed, Dec 21, 2022 at 8:17 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi,
>
> On Sat, Dec 17, 2022 at 3:12 AM Saleem Abdulrasool <abdulras@google.com> wrote:
> >
> > The compiler is free to generate vectorized operations for zero'ing
> > memory.  The kernel does not use the vector unit on RISCV, similar to
> > architectures such as x86 where we use `-mno-mmx` et al to prevent the
> > implicit vectorization.  Perform a similar check for
> > `-mno-implicit-float` to avoid this on RISC-V targets.
> >
> > Signed-off-by: Saleem Abdulrasool <abdulras@google.com>
> > ---
> >  arch/riscv/Makefile | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index 0d13b597cb55..68433476a96e 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -89,6 +89,10 @@ KBUILD_AFLAGS_MODULE += $(call as-option,-Wa$(comma)-mno-relax)
> >  # architectures.  It's faster to have GCC emit only aligned accesses.
> >  KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
> >
> > +# Ensure that we do not vectorize the kernel code when the `v` extension is
> > +# enabled.  This mirrors the `-mno-mmx` et al on x86.
> > +KBUILD_CFLAGS += $(call cc-option,-mno-implicit-float)
>
> This looks like an LLVM flag, but not GCC.

Correct, this is a clang flag, though I imagine that GCC will need a
similar flag once it receives support for the V extension.

> Can you elaborate what exact combination (compiler flag and source)
> would cause an issue?

The particular case that I was using was simply `clang -target
riscv64-unknown-linux-musl -march=rv64gcv` off of main.

> From your description, I guess it's that when enabling V extension in
> LLVM, the compiler tries to use vector instructions to zero memory,
> correct?

Correct.

> Can you confirm LLVM does not emit any float instructions (like F/D
> extensions) because the flag name suggests something like "float"?

The `-mno-implicit-float` should disable any such emission.  I assume
that you are worried about the case without the flag?  I'm not 100%
certain without this flag, but the RISCV build with this flag has been
running smoothly locally for a while.


> > +
> >  ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
> >  prepare: stack_protector_prepare
> >  stack_protector_prepare: prepare0
> > --
>
> Regards,
> Bin
