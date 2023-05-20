Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A0270A854
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 15:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjETN2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 09:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjETN2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 09:28:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AE1128;
        Sat, 20 May 2023 06:28:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5259B61202;
        Sat, 20 May 2023 13:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8C7C4339E;
        Sat, 20 May 2023 13:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684589291;
        bh=D1DRMMnBqO3s2bF0AUZ/SXa9AN919Eu79bFBS9fXRL4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fpkVru1/iK8sE1HPxW5HncmW8RJ0dTiRzmoq14gNXNRC0aajp435Nf6xzVtQXIaOn
         v9FgKvYtr00WXrZgQRHS/U1OSKu7dnyVrlCaaEGwaSq/ON/K3mfi8LaVpl8u9mKLlj
         dSqP0+n4R5L6OlcASrbYRbhdS1xitDllRtcBa9sjhiiH5KdBKbycC2/xR38GrSlUJm
         /M8fs+pMxYM3eMbtl42Wcvgl4Fm17avuMsgldaZVPmYKVIN3Il8IsDBEpyZq94RNnK
         XYsYAqAY55Q0JACy3zOyPyLp8KqEjGhaMfYT5g65DGGPWDniAtF2wz2wx90EryfrO3
         5pAz2ms3bpTQQ==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6aaef8ca776so1635751a34.2;
        Sat, 20 May 2023 06:28:11 -0700 (PDT)
X-Gm-Message-State: AC+VfDzGpO3jB5yWr7em2XdghaUhIQdT5JjJEXqDsqMKniWeUpYY5l6B
        Ll52KVxu7AKJ37tzhohoKZ8TI1Zu2iVUm3dN/+0=
X-Google-Smtp-Source: ACHHUZ5vyYZ7PHmjUxElKYg/VjLRTndtq3XJw3Wit+H45s1Re2lSNN0CCE7ie9FIq5LsEG2R2LA0qpoTeJqABu8upJo=
X-Received: by 2002:a05:6808:193:b0:394:4912:3367 with SMTP id
 w19-20020a056808019300b0039449123367mr2694813oic.45.1684589290899; Sat, 20
 May 2023 06:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230514152739.962109-1-masahiroy@kernel.org> <20230514152739.962109-11-masahiroy@kernel.org>
 <CAKwvOdmA1q1ojTWq79VK4HJqKfMHA=8VB9q61xJoKyYsegv3tg@mail.gmail.com>
In-Reply-To: <CAKwvOdmA1q1ojTWq79VK4HJqKfMHA=8VB9q61xJoKyYsegv3tg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 20 May 2023 22:27:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ3KO1BY5Nq6uhHQGm_eOVNvk206A-s5pSguTO3ykLUng@mail.gmail.com>
Message-ID: <CAK7LNAQ3KO1BY5Nq6uhHQGm_eOVNvk206A-s5pSguTO3ykLUng@mail.gmail.com>
Subject: Re: [PATCH v5 10/21] modpost: rename find_elf_symbol() and find_elf_symbol2()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 6:14=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, May 14, 2023 at 8:28=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > find_elf_symbol() and find_elf_symbol2() are not good names.
> >
> > Rename them to find_tosym(), find_fromsym(), respectively.
>
> The comments maybe could be updated, too. The end of the comment looks
> wrong for both.


What do you mean?

Please tell me which part should be changed, and how.






> Thanks for the patch!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > Changes in v5:
> >   - Change the names
> >
> >  scripts/mod/modpost.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 3b7b78e69137..0d2c2aff2c03 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -1124,8 +1124,8 @@ static inline int is_valid_name(struct elf_info *=
elf, Elf_Sym *sym)
> >   * In other cases the symbol needs to be looked up in the symbol table
> >   * based on section and address.
> >   *  **/
> > -static Elf_Sym *find_elf_symbol(struct elf_info *elf, Elf64_Sword addr=
,
> > -                               Elf_Sym *relsym)
> > +static Elf_Sym *find_tosym(struct elf_info *elf, Elf64_Sword addr,
> > +                          Elf_Sym *relsym)
> >  {
> >         Elf_Sym *sym;
> >         Elf_Sym *near =3D NULL;
> > @@ -1168,8 +1168,8 @@ static Elf_Sym *find_elf_symbol(struct elf_info *=
elf, Elf64_Sword addr,
> >   * The ELF format may have a better way to detect what type of symbol
> >   * it is, but this works for now.
> >   **/
> > -static Elf_Sym *find_elf_symbol2(struct elf_info *elf, Elf_Addr addr,
> > -                                unsigned int secndx)
> > +static Elf_Sym *find_fromsym(struct elf_info *elf, Elf_Addr addr,
> > +                            unsigned int secndx)
> >  {
> >         Elf_Sym *sym;
> >         Elf_Sym *near =3D NULL;
> > @@ -1207,10 +1207,10 @@ static void default_mismatch_handler(const char=
 *modname, struct elf_info *elf,
> >         const char *tosym;
> >         const char *fromsym;
> >
> > -       from =3D find_elf_symbol2(elf, r->r_offset, fsecndx);
> > +       from =3D find_fromsym(elf, r->r_offset, fsecndx);
> >         fromsym =3D sym_name(elf, from);
> >
> > -       to =3D find_elf_symbol(elf, r->r_addend, sym);
> > +       to =3D find_tosym(elf, r->r_addend, sym);
> >         tosym =3D sym_name(elf, to);
> >
> >         /* check whitelist - we may ignore it */
> > --
> > 2.39.2
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Best Regards
Masahiro Yamada
