Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31ADA73468B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 16:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjFROU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 10:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjFROU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 10:20:27 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508D9E71;
        Sun, 18 Jun 2023 07:20:26 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bc4f89f0f2fso2770040276.3;
        Sun, 18 Jun 2023 07:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687098025; x=1689690025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKngzCbi/z0YczLfmgJ8G+89JRu+Tx99q0y6rf+xc3g=;
        b=VaAic+1rlhUTFVg7WGWjD/PM++B/69nK3R1DcgWj7rqNxpw4yV9fuUWKfpqgtW/K7I
         Jku2fodUUoezlMprvokwNK49VRwuEDr/JdcXT2eyuPymQU/KU44RR6E4F/VCjvAoxDk1
         KrGyx51eGhHP3KY8eiarxseURUuPzQcRrZnqyy8Wh1wskYRfipZKy11JzbyD16UzaKvC
         nsVkqLniY3F1bfuJP/l8ILPUL5tUoOJ/pHmFBOxEGlZGVPMIk7aUfKcOWy+M2DZ9RWfc
         Y3uvvy4nQTH4yi9lyWQ0OCifbD4zzFYRwWNQVmJHCU+m8tyCaeCz/eCA8ppT0z0pCwT+
         +7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687098025; x=1689690025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKngzCbi/z0YczLfmgJ8G+89JRu+Tx99q0y6rf+xc3g=;
        b=D0kaFF39C+VFt5VI7fqDkIluUMvHoPbYRHYeKLXblpj/np29WrQ/fpac4AnnH5t8Qf
         B6LzI/gDJluKcGrJlnT80r6peVaYdXeypMsV7mLI0eILLfDbG+a7U/9JsLnU3TyRSdaP
         ZcPIXRJxwUb51OK0jv/UzzuGgryZjQ4s7JjUwO5wH6Sge9b2ZnZiXRAkaJW5brQelWod
         dF5elm39xFCKqY3CyBKUd1YDANMXgEZ8BP1WP9ia5Z34NSDqhygG5SeXyLf/uVF6kTuk
         tu91+29utLSVvrZW5+T3CYlQnwnD/Z6fowYFwSqejHoN6K/FCOyILfOmQq1gnHo+rsOp
         x8CA==
X-Gm-Message-State: AC+VfDy/4iYq571isZ7AYP8qHYNwKk0iYqna6UTb1pd0cLeVjcTLEe+8
        zPxwBNliZRAd/WzE24CzwqbURpXiVTWWO4wecxw=
X-Google-Smtp-Source: ACHHUZ6OWkndylY7XcNfai46ffCnTYYuh35ry6WdKDFVRKwvPPPvXYLW796YQAzIMxPv4BZVitbcDftNF6Bg3+Aa+r4=
X-Received: by 2002:a0d:eb93:0:b0:56d:805:1507 with SMTP id
 u141-20020a0deb93000000b0056d08051507mr7753300ywe.16.1687098025485; Sun, 18
 Jun 2023 07:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230529052821.58175-1-maninder1.s@samsung.com>
 <CGME20230529052832epcas5p4fa1b8cf25d9810d32bd2ccf012086fb3@epcms5p1>
 <CANiq72ncDr68qeahrHuQ63dj1Va3=Us6ZSjGRkr6Zp8j+=yH_Q@mail.gmail.com>
 <20230529105707epcms5p1418eac680ebe1736196706b0db80dd39@epcms5p1>
 <CANiq72n_eso7_pgna8ukmEnuCQPsKYPr0NU-Ss9Nwv0VzX=etg@mail.gmail.com> <202305301611.34F0A680A2@keescook>
In-Reply-To: <202305301611.34F0A680A2@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 18 Jun 2023 16:20:14 +0200
Message-ID: <CANiq72=K1sXz=TjBSjx+7JuTueH6vjbz9--Q2dGDYj3naKvroQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] arch:hexagon/powerpc: use KSYM_NAME_LEN in array size
To:     Kees Cook <keescook@chromium.org>
Cc:     maninder1.s@samsung.com, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "bcain@quicinc.com" <bcain@quicinc.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "nathanl@linux.ibm.com" <nathanl@linux.ibm.com>,
        "ustavoars@kernel.org" <ustavoars@kernel.org>,
        "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Onkarnath <onkarnath.1@samsung.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 1:14=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, May 29, 2023 at 04:50:45PM +0200, Miguel Ojeda wrote:
> > Kees: what is the current stance on `[static N]` parameters? Something =
like:
> >
> >     const char *kallsyms_lookup(unsigned long addr,
> >                                 unsigned long *symbolsize,
> >                                 unsigned long *offset,
> >     -                           char **modname, char *namebuf);
> >     +                           char **modname, char namebuf[static KSY=
M_NAME_LEN]);
> >
> > makes the compiler complain about cases like these (even if trivial):
> >
> >     arch/powerpc/xmon/xmon.c:1711:10: error: array argument is too smal=
l;
> >         contains 128 elements, callee requires at least 512
> > [-Werror,-Warray-bounds]
> >             name =3D kallsyms_lookup(pc, &size, &offset, NULL, tmpstr);
> >                  ^                                           ~~~~~~
> >     ./include/linux/kallsyms.h:86:29: note: callee declares array
> > parameter as static here
> >             char **modname, char namebuf[static KSYM_NAME_LEN]);
> >                                  ^      ~~~~~~~~~~~~~~~~~~~~~~
>
> Wouldn't that be a good thing? (I.e. complain about the size mismatch?)

Yeah, I would say so (i.e. I meant it as a good thing).

> > But I only see 2 files in the kernel using `[static N]` (from 2020 and
> > 2021). Should something else be used instead (e.g. `__counted_by`),
> > even if constexpr-sized?.
>
> Yeah, it seems pretty uncommon. I'd say traditionally arrays aren't
> based too often, rather structs containing them.
>
> But ultimately, yeah, everything could gain __counted_by and friends in
> the future.

That would be nice!

Cheers,
Miguel
