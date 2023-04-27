Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91FC6F018D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 09:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242946AbjD0HVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 03:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243093AbjD0HU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:20:58 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1B8269F;
        Thu, 27 Apr 2023 00:20:25 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-54fbee69fc4so93007537b3.1;
        Thu, 27 Apr 2023 00:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682580009; x=1685172009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzhMDOKc0/Bb4J3yE81nbwK8K9U+SfTK1yAzEB+SVpc=;
        b=nlaphVcn1IMWdNgpe4560zpAUKd0OZPqIA8zFNBzqNJEjcWHNTryCQHpQgdNCmLyUa
         NfjvuCTCNQhjXhPphYmnnBaMXSRWiOtfpgaXWdGvn+pfmcnRyTp667egk/l9f0Qej7dV
         AmFVreDzh0jHKKRc+HVH59YwB+3T49dpd7znNmHur/EipCXTULigi9cARC+65TCVqBSR
         zxrv7q4pY4su1lePaLuHc0acCXW47oB7wxnSS/uVkpWhl8fjoCwuPpeu2dvRnEon5et9
         OOVGXADVcUb1Nci0I/3HM/YT7MYLJwcsJG+GtfPcjKjoqBO8D/OfB+Um+jvqcNGGEZQu
         QyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682580009; x=1685172009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzhMDOKc0/Bb4J3yE81nbwK8K9U+SfTK1yAzEB+SVpc=;
        b=ik4WvhzogeElL+1rg15/V8oyTBAGmxYvAki2JTtsnrxgJWdVXOsrRaLaOizwEqCAMZ
         mrQs9mue7k3Xfj0ZVkvSGFR4AuANUwKkFI6eBQS0KohT/trZf9ktnSiwu8ec8J+uhoTG
         5vhBR5azTC76VjKjGRNzQhQ/75M0q+xaqC9VHIrmrRqxa9nJZFXbe+EhEEP80OquZuzB
         IctxHNTixcLwSEhyi8XnmDd1Z7UIgh14eF8pevHRFVEPoZdWSZ7chxdjdrAFKTSbXG8e
         tt7VU6WvuT6mPtUwuQ73OQC7uA9UFGzwzP3n9gXxY3K7SP0dnZYVErMzXuhW2rNqZ294
         fuqQ==
X-Gm-Message-State: AC+VfDzsCSNGBv+Jzm//pMwL1fe0mxwOZpss/6AcQrpPqF9FFsB+93s0
        5F1JSZwBWnJla+hxugRyf/IlluLvvYUsZM0jHrrqyY6Y+Zo5Gbo0ODs=
X-Google-Smtp-Source: ACHHUZ7zikdy7bi1Cn/YcwLvfLk7y6CcCIyyINOQOqxXuNkNK7fkUNboV9O5JjkA8m8fp0Zb2yabFzmQwOsspksUa1c=
X-Received: by 2002:a81:6d57:0:b0:54f:b5bc:42d1 with SMTP id
 i84-20020a816d57000000b0054fb5bc42d1mr482282ywc.47.1682580009530; Thu, 27 Apr
 2023 00:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230426124948.1072216-1-zhanggenjian@kylinos.cn>
 <CAOd03yQ98st7KvAkwfFqFvXGBdmWmOZZ-kWAH5DAi7gLd=ngaA@mail.gmail.com> <17660b99-d68d-328e-5fe6-c011709fa3e4@infradead.org>
In-Reply-To: <17660b99-d68d-328e-5fe6-c011709fa3e4@infradead.org>
From:   genjian zhang <zhanggenjian123@gmail.com>
Date:   Thu, 27 Apr 2023 15:18:56 +0800
Message-ID: <CAOd03yRAmPULzi8fYTnukCpRPHa1Zsv5ZFFeQRcQ7B1abQCGqA@mail.gmail.com>
Subject: Re: [PATCH] fix ___SYNC () build error when PROFILE_ALL_BRANCHES is enabled
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     tsbogend@alpha.franken.de, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 11:16=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Hi--
>
> >
> > Maybe the readability of this modification is not very good. Any
> > comments and suggestions are welcome. Thanks.
>
> Some of the patch description could use some cleaning up,
> then I have a question.
>
>
> On 4/26/23 06:02, genjian zhang wrote:
> > On Wed, Apr 26, 2023 at 8:51=E2=80=AFPM Genjian <zhanggenjian123@gmail.=
com> wrote:
> >>
> >> From: Genjian Zhang <zhanggenjian@kylinos.cn>
> >>
> >> compiler error (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110):
> >>
> >> {standard input}: Assembler messages:
> >> {standard input}:171: Error: found '(', expected: ')'
> >> {standard input}:171: Error: found '(', expected: ')'
> >> {standard input}:171: Error: non-constant expression in ".if" statemen=
t
> >> {standard input}:171: Error: junk at end of line, first unrecognized
> >> character is `('
> >>
> >> Preprocessor expand ___SYNC () macros.However,'if' will be wrongly
>
>                 expands ___SYNC() macros. However, 'if' will be wrongly
>
> >> replaced by C code when PROFILE_ALL_BRANCHES is enabled and ___SYNC
> >> is used in inline assembly.This leads to syntax errors in the code.
>
>                      assembly. This
>
> >> Compilers report a lot of errors like the above.
> >> Move '.if' into quoted strings to fix it.
> >>
> >> Reported-by: k2ci <kernel-bot@kylinos.cn>
> >> Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
> >> ---
> >>  arch/mips/include/asm/sync.h | 8 +++++---
> >>  1 file changed, 5 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/mips/include/asm/sync.h b/arch/mips/include/asm/sync=
.h
> >> index aabd097933fe..d9f5a87424e7 100644
> >> --- a/arch/mips/include/asm/sync.h
> >> +++ b/arch/mips/include/asm/sync.h
> >> @@ -175,7 +175,7 @@
> >>   */
> >>  #ifdef CONFIG_CPU_HAS_SYNC
> >>  # define ____SYNC(_type, _reason, _else)                       \
> >> -       .if     (( _type ) !=3D -1) && ( _reason );               \
> >> +       ((_type) !=3D -1) && (_reason);                           \
> >>         .set    push;                                           \
> >>         .set    MIPS_ISA_LEVEL_RAW;                             \
> >>         .rept   __SYNC_rpt(_type);                              \
> >> @@ -192,13 +192,15 @@
> >>  /*
> >>   * Preprocessor magic to expand macros used as arguments before we in=
sert them
> >>   * into assembly code.
> >> + * In addition,=E2=80=98if=E2=80=99 can not be substituted when CONFI=
G_PROFILE_ALL_BRANCHES is
>
>      * In addition, 'if' cannot be
>
> >> + * enabled.
> >>   */
> >>  #ifdef __ASSEMBLY__
> >>  # define ___SYNC(type, reason, else)                           \
> >> -       ____SYNC(type, reason, else)
> >> +       .if     ____SYNC(type, reason, else)
> >>  #else
> >>  # define ___SYNC(type, reason, else)                           \
> >> -       __stringify(____SYNC(type, reason, else))
> >> +       ".if"   __stringify(____SYNC(type, reason, else))
> >>  #endif
> >>
> >>  #define __SYNC(type, reason)                                   \
> >> --
> >> 2.25.1
>
>
> Is this problem that you are fixing being aggravated (caused) by
> the #define of if() in include/linux/compiler.h when CONFIG_PROFILE_ALL_B=
RANCHES
> is set?  I suspect that it is.

 right .

> It wouldn't hurt to mention that (if I am correct).
>
> Thanks.
> --
> ~Randy

Thank you for your suggestions. I will send a patch v2.
