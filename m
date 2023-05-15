Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9991F704132
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244768AbjEOWyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEOWyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:54:44 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A13A5EB
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 15:54:43 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-621350926dfso62913316d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 15:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684191282; x=1686783282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gO5XZWUWwMOC/rmTBmA5WU6snb7WE6dLECqjoeENkeI=;
        b=bPJez+1ndj65+nrcp3XO59yAn7KkkeLiabttia1Vdpe3KjIMJrZODiGoBhOlTxRooY
         W85/NQeWGmZQq5Fb3quemWpccUaN7q9XySXl/c8GfIjqdUAlB3OxtgC4pRzRA91tCeNC
         4ZHNW3ty1D2GutHoTTKTyKM7jZ7pYt9jlgHKRWBrjopZrp8gycohp72rAxO43/s8spH4
         omI6L5aGvIXsaefQ59GycZ2iaxlaFf8BEUt3vMWO9+ZBU19XFw9bVEjg31EhhgIAcVXR
         ONoIFwAZu2T6B91LG39Yz5tgVwM+o5WSh1Dw+Rx4uaLDds0kGZ875RR2j5dPVRtJSmno
         ZIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684191282; x=1686783282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gO5XZWUWwMOC/rmTBmA5WU6snb7WE6dLECqjoeENkeI=;
        b=VI3uRX1IeEyrTnv9P6TaUv/W98YDeM/mOfIUbNYnzSp8gGUgNp4UPtWck4Casvx26R
         /ApKGfpxepRc1JdcWOiFluChchsMbZkQB7MDPNYEuOVJfADAX21Ed5CfuzzGYrCdq6Va
         wQg04mVIsRZeBB4mDy9YXM7hP2yTqNsOxoFXqsBuRwK2Kq09wIhqUaLUdiRg7AHlcu1Q
         9UiZyleutiw1EBGzuiMZWJ8fAIHc6O2NpXf9I55QudKmj8RTtnAfSjAHQM0NOHPVN5ug
         pC/BH+JlOSZ+on1jEqorrthJooQ4qcj6NrZ/ak7t5WmM7vT5M4YdODvuxbHAyQUY8PgE
         GpqQ==
X-Gm-Message-State: AC+VfDxOuWsyllwsqGIFxnAWPHEXH7fs+Z1+NhlEwrcVElpslP4lN9Yx
        RyAIZU7qBzFFFB8vqHACV/9/vVLlB/1+DgS64NT09g==
X-Google-Smtp-Source: ACHHUZ5oakQjVzowpecEKRgaVe+SpLizYUarPdmm7dmAsjHP8i71wb+2y6P4uhQYptvnO8f6A8TChjYCFRJEDTAXJLI=
X-Received: by 2002:a05:6214:1cc4:b0:61b:6e43:b20 with SMTP id
 g4-20020a0562141cc400b0061b6e430b20mr52925743qvd.42.1684191282188; Mon, 15
 May 2023 15:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230514152739.962109-1-masahiroy@kernel.org> <20230514152739.962109-22-masahiroy@kernel.org>
 <93s3n008-7oon-30rq-5219-5r244919r38q@syhkavp.arg>
In-Reply-To: <93s3n008-7oon-30rq-5219-5r244919r38q@syhkavp.arg>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 15 May 2023 15:54:05 -0700
Message-ID: <CABCJKuf91O4OtBQ62CRuCYHWrENdvjnzHdyH135qCt24rX4Lsg@mail.gmail.com>
Subject: Re: [PATCH v5 21/21] kbuild: implement CONFIG_TRIM_UNUSED_KSYMS
 without recursion
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 2:39=E2=80=AFPM Nicolas Pitre <nico@fluxnic.net> wr=
ote:
>
> On Mon, 15 May 2023, Masahiro Yamada wrote:
>
> > When CONFIG_TRIM_UNUSED_KSYMS is enabled, Kbuild recursively traverses
> > the directory tree to determine which EXPORT_SYMBOL to trim. If an
> > EXPORT_SYMBOL turns out to be unused by anyone, Kbuild begins the
> > second traverse, where some source files are recompiled with their
> > EXPORT_SYMBOL() tuned into a no-op.
> >
> > Linus stated negative opinions about this slowness in commits:
> >
> >  - 5cf0fd591f2e ("Kbuild: disable TRIM_UNUSED_KSYMS option")
> >  - a555bdd0c58c ("Kbuild: enable TRIM_UNUSED_KSYMS again, with some gua=
rding")
> >
> > We can do this better now. The final data structures of EXPORT_SYMBOL
> > are generated by the modpost stage, so modpost can selectively emit
> > KSYMTAB entries that are really used by modules.
> >
> > Commit 2cce989f8461 ("kbuild: unify two modpost invocations") is anothe=
r
> > ground-work to do this in a one-pass algorithm. With the list of module=
s,
> > modpost sets sym->used if it is used by a module. modpost emits KSYMTAB
> > only for symbols with sym->used=3D=3Dtrue.
> >
> > BTW, Nicolas explained why the trimming was implemented with recursion:
> >
> >   https://lore.kernel.org/all/2o2rpn97-79nq-p7s2-nq5-8p83391473r@syhkav=
p.arg/
> >
> > Actually, we never achieved that level of optimization where the chain
> > reaction of trimming comes into play because:
> >
> >  - CONFIG_LTO_CLANG cannot remove any unused symbols
> >  - CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is enabled only for vmlinux,
> >    but not modules
>
> I did achieve it using LTO with gcc back then. See the section called
> "The tree that hides the forest" of https://lwn.net/Articles/746780/ for
> example results.

Clang can do similar optimizations, but not in relocatable links where
the linker must obviously preserve all the globals. A while ago there
was a suggestion of adding an option to LLD that allows one to pass a
list of symbols to preserve in relocatable LTO links, which would
allow us to better optimize vmlinux.o. However, I haven't had a chance
to look into this deeper than this proof of concept:

https://reviews.llvm.org/D142163

> > If deeper trimming is required, we need to revisit this, but I guess
> > that is unlikely to happen.
>
> Would have been nicer to keep this possibility as an option. The code is
> already there and working as intended. The build cost is intrinsic to
> the approach of course. The actual bug is to impose that cost onto
> people who didn't explicitly ask for it.
>
> But I'm no longer fighting this battle.

I agree, this looks like a reasonable solution for now.

Sami
