Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E2A653D97
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 10:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiLVJlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 04:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbiLVJlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 04:41:05 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E9163F7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 01:41:02 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id gh17so3596943ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 01:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T5sljJc4I7u6hP7ibi4k54gj9SUSXUqTx/yNLLzCW5g=;
        b=O82v71gHFwz87qQJ6ygWvpIa8c8tKKIAbowaSnSYoWYqvo+4GQzq25o+VykzKvGF4O
         U9Vp1MmiGD1TqMeF+jzthu2CtWoI4a1i4hy/qXeL1gLA4dJlivXa2tXYPuyzCAiemNs7
         J/iibWlAP4fVuWZycAITlPgk2A/TlO6OLOjCbqNcvQ42eHOadcCCcyltT4ltCoF1TS+s
         WveVh6DfouxUdVQMx6PMKZfxDoErywjMwDz2tT5JXMyWv/z/JBonexQazvFpUQeP3gKQ
         HfxDN7ArHvNyhQHW7J4zLHr8r8J9fbKdnqv/MCUxysacJ3Ge3xoIHnPSHU6ROzbdQWXW
         yh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5sljJc4I7u6hP7ibi4k54gj9SUSXUqTx/yNLLzCW5g=;
        b=7cPCT5rjvTP/gpsyu65Gv8zf5mpQ9QuYkR/vEGW6DAdOo7cwCJbkEK0PwF6FeqmOxz
         befEsjD3xTcMSGhtn6LbhLaIEq/J+I23YL5PhSQigHFnASnzG1BcIomLIzttVZ/t6kPb
         YhpvEMk5JX+e1JQSIxAEIhY04Vfwlh3OA2BLEuORlYGGgYuREdOt9+giZZpQzoiC74OG
         OrUOcIJPy1+spA5pIWZrLwZgvQsmTXdEwf/be0FcrdSGC7KNGSpUgpzEiOvXVaPX7m3h
         fbmvxgyvvbsuRiicKQv4RNd2SQZlJf6po+LQe4T5Lmwr8CH9YFclysoRkWK3R1xh60Y/
         ej+Q==
X-Gm-Message-State: AFqh2kpU8L6sUnC8RcdV+Dt0Ubu6OzSMgWROvIGXYN0oEdpGT156domQ
        t4shp42gSnW4Pn0o1Rx6DpvQxhfJayhpXTQwbW4=
X-Google-Smtp-Source: AMrXdXtw+ao2n/b9tn3M3QtnM8+Y7ro93LfJirJJUBkOaUE2OomJOpQ2qCq5uD5uUsjx4EgJEGnXmKPhhnzM46uDkKA=
X-Received: by 2002:a17:906:68c9:b0:7c1:a0d:dd2c with SMTP id
 y9-20020a17090668c900b007c10a0ddd2cmr536671ejr.26.1671702060751; Thu, 22 Dec
 2022 01:41:00 -0800 (PST)
MIME-Version: 1.0
References: <20221216185012.2342675-1-abdulras@google.com> <CAEUhbmUsFt0H-Dd3XHjuk6sUq0hrV9SFU=1jD2LQ10xywZOZiA@mail.gmail.com>
 <CAO8XFHv_wV_oSuS+e412yr6vjm-44Vf2gJuMO4FvgPeodhWQww@mail.gmail.com>
In-Reply-To: <CAO8XFHv_wV_oSuS+e412yr6vjm-44Vf2gJuMO4FvgPeodhWQww@mail.gmail.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 22 Dec 2022 17:40:50 +0800
Message-ID: <CAEUhbmX6PE_E8PCEp4mo8Fpjtc-Pm-tmpxws0UKCp715qB+qRg@mail.gmail.com>
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

On Thu, Dec 22, 2022 at 1:39 AM Saleem Abdulrasool <abdulras@google.com> wrote:
>
> On Wed, Dec 21, 2022 at 8:17 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi,
> >
> > On Sat, Dec 17, 2022 at 3:12 AM Saleem Abdulrasool <abdulras@google.com> wrote:
> > >
> > > The compiler is free to generate vectorized operations for zero'ing
> > > memory.  The kernel does not use the vector unit on RISCV, similar to
> > > architectures such as x86 where we use `-mno-mmx` et al to prevent the
> > > implicit vectorization.  Perform a similar check for
> > > `-mno-implicit-float` to avoid this on RISC-V targets.
> > >
> > > Signed-off-by: Saleem Abdulrasool <abdulras@google.com>
> > > ---
> > >  arch/riscv/Makefile | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > > index 0d13b597cb55..68433476a96e 100644
> > > --- a/arch/riscv/Makefile
> > > +++ b/arch/riscv/Makefile
> > > @@ -89,6 +89,10 @@ KBUILD_AFLAGS_MODULE += $(call as-option,-Wa$(comma)-mno-relax)
> > >  # architectures.  It's faster to have GCC emit only aligned accesses.
> > >  KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
> > >
> > > +# Ensure that we do not vectorize the kernel code when the `v` extension is
> > > +# enabled.  This mirrors the `-mno-mmx` et al on x86.
> > > +KBUILD_CFLAGS += $(call cc-option,-mno-implicit-float)
> >
> > This looks like an LLVM flag, but not GCC.
>
> Correct, this is a clang flag, though I imagine that GCC will need a
> similar flag once it receives support for the V extension.
>
> > Can you elaborate what exact combination (compiler flag and source)
> > would cause an issue?
>
> The particular case that I was using was simply `clang -target
> riscv64-unknown-linux-musl -march=rv64gcv` off of main.
>
> > From your description, I guess it's that when enabling V extension in
> > LLVM, the compiler tries to use vector instructions to zero memory,
> > correct?
>
> Correct.

Thanks for the confirmation.

>
> > Can you confirm LLVM does not emit any float instructions (like F/D
> > extensions) because the flag name suggests something like "float"?
>
> The `-mno-implicit-float` should disable any such emission.  I assume
> that you are worried about the case without the flag?  I'm not 100%
> certain without this flag, but the RISCV build with this flag has been
> running smoothly locally for a while.
>
>

I still have some questions about the `-mno-implicit-float` option's behavior.

- If this option is not on, does the compiler emit any F/D extension
instruction for zero'ing memory when -march=rv64g? I want to know
whether the `-mno-implicit-float` option only takes effect when "v"
appears on the -march string.
- If the answer to the above question is no, I wonder why the option
is called `-mno-implicit-float` as float suggests the FPU usage, but
actually it is about vectorization. The Clang documentation says
almost nothing about this option.

> > > +
> > >  ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
> > >  prepare: stack_protector_prepare
> > >  stack_protector_prepare: prepare0
> > > --

Regards,
Bin
