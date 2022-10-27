Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9059860FD52
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbiJ0Qmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiJ0Qmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:42:33 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13FF32A9A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:42:32 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-36cbcda2157so20744247b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrpT7jDzvIdd9Y+I9KcU+R/FrIS418eDQ+csIqtnsLY=;
        b=bCUbZ0x6v07vNmPZXYNcBG5Ey/ryv5OToKooQuXyplODjf24p5tWQ75jkhjBZV7gT3
         oEsD+bBMYkbuXg+M/p6MAapBGs3r/Rv0wzvDTNq9Bn4+xNbDhY8Px2jjU0edEBq+nvST
         x6BxxX1ldzDvoynXqS/GXEnx2xgZbkC/ItOOUZTXPwE4M0X5LFkw02oW2vsxWgjrnVoq
         Tx4W7yBmJ5iJmJvREIW10dyHlLQBy6BZEYS3ZAm8QLKkvwtyUhONMH++0PRzFF+0ENdo
         b0cU2ASNHKh1+zWAMkz396EQEz8QufIJTCgaOF7SOhfzH9SSkxcjCXYR+oiS5AzSJI9U
         QBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrpT7jDzvIdd9Y+I9KcU+R/FrIS418eDQ+csIqtnsLY=;
        b=7Ckjs1/tdCU1pcOkiz/dFB0sybdt/n59EPUB2nwJEsdxbPscJZ9T5m06E70OXIqlhD
         DtOl8yTQub7xjtkzGvzhUHk2MzYU9vM/0cBls1HbMHIbDWFJnBSmqdkNr3wdaqOcyokA
         9Fby0WS4h/HGDihb07rPv2gExt/nA4wYIOq0UzFpzk+Se3hEw0s84OETxKzJ39NXdnPA
         3rCH7tCZTlg3Y4l7krVnut+5vZQBwmjnXJN4xeqTijBWmz0McvwMzDDYmmI/dwdged7G
         E1DG4wQ1x8rh6B57j4bl2VgdDbJqHtwhfMRlL3OJk7Ktv1/wUF2AYSHZjdINPLWKEJaA
         skyQ==
X-Gm-Message-State: ACrzQf3AaJjr/PTQxDZum3UeN0ZGp1b9oI/e5wTtw6RBpJXH0PFN14rX
        CPMpj1mAXhb8iC/+hlRq2sQf6vUUhXD4AldUOR4r4A==
X-Google-Smtp-Source: AMsMyM4nDk2ORHx8hkcRQTC3kyPEB7IQDB/Q/0FuOAjTdfivEShbqfFkgF/S7EodPoMvamKbzlOi/TcLzOmgp2Y17zk=
X-Received: by 2002:a0d:c901:0:b0:351:b348:542f with SMTP id
 l1-20020a0dc901000000b00351b348542fmr45367421ywd.144.1666888951720; Thu, 27
 Oct 2022 09:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221024212144.2852069-1-glider@google.com> <20221024212144.2852069-3-glider@google.com>
 <CAK7LNARfKkiNSUfZAqDQd15O8NAhpX13dHDuGn3OPL_b_F_92g@mail.gmail.com>
In-Reply-To: <CAK7LNARfKkiNSUfZAqDQd15O8NAhpX13dHDuGn3OPL_b_F_92g@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 27 Oct 2022 09:41:54 -0700
Message-ID: <CAG_fn=WWiOvPRnw1ao-UPavY-U7rLFLa_a6b-k2noHKLunN+Yw@mail.gmail.com>
Subject: Re: [PATCH 3/5] Kconfig.debug: disable CONFIG_FRAME_WARN for KMSAN by default
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Oct 27, 2022 at 7:33 AM Masahiro Yamada <masahiroy@kernel.org> wrot=
e:
>
> On Tue, Oct 25, 2022 at 6:22 AM Alexander Potapenko <glider@google.com> w=
rote:
> >
> > KMSAN adds a lot of instrumentation to the code, which results in
> > increased stack usage (up to 2048 bytes and more in some cases).
> > It's hard to predict how big the stack frames can be, so we disable
> > the warnings for KMSAN instead.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: linux-kbuild@vger.kernel.org
> > Link: https://github.com/google/kmsan/issues/89
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > ---
> >  lib/Kconfig.debug | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 3fc7abffc7aa2..29280072dc0e4 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -400,8 +400,9 @@ config FRAME_WARN
> >         default 1536 if (!64BIT && XTENSA)
> >         default 1024 if !64BIT
> >         default 2048 if 64BIT
> > +       default 0 if KMSAN
>
>
>
> This is wrong.
>
> Kconfig picks up the first default entry which has
> true 'if' condition.
>
>
> Since (!64BIT || 64BIT) covers all the possible cases,
> this patch is just adding dead code.
>
Thanks for clarifying!
What we actually need is to forcefully disable CONFIG_FRAME_WARN under
KMSAN, but adding constructs like "select FRAME_WARN 0" or "select
FRAME_WARN=3D0" doesn't work, right?

I'll move "default 0 if KMSAN" to the beginning of FRAME_WARN declaration t=
hen.

>
>
>
>
>
> >         help
> > -         Tell gcc to warn at build time for stack frames larger than t=
his.
> > +         Tell the compiler to warn at build time for stack frames larg=
er than this.
> >           Setting this too low will cause a lot of warnings.
> >           Setting it to 0 disables the warning.
> >
> > --
> > 2.38.0.135.g90850a2211-goog
> >
>
>
> --
> Best Regards
> Masahiro Yamada



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
