Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD6E70A847
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 15:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjETNMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 09:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjETNMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 09:12:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C255CE;
        Sat, 20 May 2023 06:12:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A5C560AFF;
        Sat, 20 May 2023 13:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB10BC433D2;
        Sat, 20 May 2023 13:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684588323;
        bh=wjix5IqQaLwdfF1gkqB4SlaPuA5XKajeDY2XdF8xEis=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VaTaFLQWahiMaN3qIIEpPfrR5WPwhLbS1GtBOWXye+zGtcdUWti1sMD4vM0GDdEEK
         rKS/VefWb0vLCXUXBPM8SkY19nbFBO/95EHwnFtczqzDZVpD/rFoDv8CfoswmKPH4+
         56cuqtZREWRH4wK0HOMvI7QruHgqm11ZgTb6Q6Ox9xVSmVP1mygszyj0jFTU+0zL/G
         +YrBcuJv+TjQat9Mfp0DH06qGrqXU8Aofo5671s8VMvWo2VysYKaE9kJOzAYyeAivR
         axOMhyhhCjcsuEGH8Qe4Mg1/R1RlW/kLMeb+/O62LwqKkCR+7KYjQAP00oMLR00PCo
         0syARdjlHespQ==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5552a0a9557so79089eaf.0;
        Sat, 20 May 2023 06:12:02 -0700 (PDT)
X-Gm-Message-State: AC+VfDw8MOSZHkH4XtpF7XC/lSUH1fAlH8CaiunfZtAnVUCblu/jLfWp
        tSZA3K4wTNShRkUpVHQw+r846tnLgvKJlUp1gqQ=
X-Google-Smtp-Source: ACHHUZ4Lu7MTY72NW2ayPlKI7Kw9Tl3IQLt7fiY4AzyC6eo+BhtFymTkMaqpjADT55RPbNSuR0ellXcwVVStaPkF3rk=
X-Received: by 2002:a4a:9c50:0:b0:54f:49ed:a88b with SMTP id
 c16-20020a4a9c50000000b0054f49eda88bmr3023968ook.2.1684588322191; Sat, 20 May
 2023 06:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230514152739.962109-1-masahiroy@kernel.org> <20230514152739.962109-3-masahiroy@kernel.org>
 <CAKwvOd=2SJHNEQR1QHhLkA8V97o0BV90E346RT6-43SGnza9EQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=2SJHNEQR1QHhLkA8V97o0BV90E346RT6-43SGnza9EQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 20 May 2023 22:11:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAREQ1Zs94YiV0vAnaQh43OBVUbMTpzFNxfenEPAG3z_=w@mail.gmail.com>
Message-ID: <CAK7LNAREQ1Zs94YiV0vAnaQh43OBVUbMTpzFNxfenEPAG3z_=w@mail.gmail.com>
Subject: Re: [PATCH v5 02/21] modpost: remove fromsym info in __ex_table
 section mismatch warning
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

On Thu, May 18, 2023 at 3:53=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, May 14, 2023 at 8:27=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > report_extable_warnings() prints "from" in a pretty form, but we know
> > it is always located in the __ex_table section, i.e. a collection of
> > struct exception_table_entry.
>
> Would it still be helpful to have "from __ex_table" somewhere in the
> error string that may be shown to developers?


See the code.

The variable, 'fromsec' (i.e. "__ex_table") is remaining.

It prints a warning message as you wish.




> >
> > It is very likely to fail to get the symbol name and ends up with
> > meaningless message:
> >
> >   ... in reference from the (unknown reference) (unknown) to ...
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/mod/modpost.c | 11 ++---------
> >  1 file changed, 2 insertions(+), 9 deletions(-)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index ba4577aa4f1d..bbe066f7adbc 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -1297,23 +1297,16 @@ static void report_extable_warnings(const char*=
 modname, struct elf_info* elf,
> >                                     Elf_Rela* r, Elf_Sym* sym,
> >                                     const char* fromsec, const char* to=
sec)
> >  {
> > -       Elf_Sym* fromsym =3D find_elf_symbol2(elf, r->r_offset, fromsec=
);
> > -       const char* fromsym_name =3D sym_name(elf, fromsym);
> >         Elf_Sym* tosym =3D find_elf_symbol(elf, r->r_addend, sym);
> >         const char* tosym_name =3D sym_name(elf, tosym);
> > -       const char* from_pretty_name;
> > -       const char* from_pretty_name_p;
> >         const char* to_pretty_name;
> >         const char* to_pretty_name_p;
> >
> > -       get_pretty_name(is_function(fromsym),
> > -                       &from_pretty_name, &from_pretty_name_p);
> >         get_pretty_name(is_function(tosym),
> >                         &to_pretty_name, &to_pretty_name_p);
> >
> > -       warn("%s(%s+0x%lx): Section mismatch in reference from the %s %=
s%s to the %s %s:%s%s\n",
> > -            modname, fromsec, (long)r->r_offset, from_pretty_name,
> > -            fromsym_name, from_pretty_name_p,
> > +       warn("%s(%s+0x%lx): Section mismatch in reference to the %s %s:=
%s%s\n",
> > +            modname, fromsec, (long)r->r_offset,
> >              to_pretty_name, tosec, tosym_name, to_pretty_name_p);
> >
> >         if (!match(tosec, mismatch->bad_tosec) &&
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
