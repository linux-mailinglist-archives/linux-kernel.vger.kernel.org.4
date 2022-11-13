Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B105B626F0F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 11:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbiKMKxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 05:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbiKMKxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 05:53:02 -0500
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E92D11C;
        Sun, 13 Nov 2022 02:53:01 -0800 (PST)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 2ADAqTdQ013918;
        Sun, 13 Nov 2022 19:52:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2ADAqTdQ013918
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1668336750;
        bh=VoXjLJD2Krz8hkxRFt5NBX3Jyhcn+yxYhLFSidrHSg8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JrzNa+8VJ5nspbI1Rq8UBfJrMau8cX1qsM6+o2mV18galNsOWn5l5q1q2IkYbFh4D
         mG3g9sWqNRhftVcTcAXWKOSATfRZkBShjJcTHzzK6DlA2qnhpKFKEBRBRB1WSGzdGc
         Cp6Nz0+RHJI2hvmkEPJbvphdZoBdYJOIcvUjUoy27GH1mL8gW1IDOXoQKQtBJ61oEm
         q0+ri/2gbUtQPN7sfM2T8IuK/oJ8XMT9vwaGJ9VOlIIeoGknucmVgv6LHOq1i7WgZV
         N8X8C0bHOsN5aUtPLsjiGvgo57ziYp6C+thZ/9IgFsbfKQBSG+vmFFDMLWEijMxAGl
         dL4/F9HvKehew==
X-Nifty-SrcIP: [209.85.167.174]
Received: by mail-oi1-f174.google.com with SMTP id r76so8877668oie.13;
        Sun, 13 Nov 2022 02:52:30 -0800 (PST)
X-Gm-Message-State: ANoB5plaA/Gv+e+RQSMBXPnwtrX6XeQT/IJDu1BG8K29oPfrg9OgE5uS
        0GGIXhN3C/oP5kk4u9S7JyTKv3rvy4FkTSAL7lM=
X-Google-Smtp-Source: AA0mqf6vpINw5rP6oIj4S6FNJmD8UvmSGDt71CCnF3eBcYG9Uj0meKzNDfcrNS0qIDY9wOUeQkItDY9A0zdXNIuFfKk=
X-Received: by 2002:a05:6808:208c:b0:354:94a6:a721 with SMTP id
 s12-20020a056808208c00b0035494a6a721mr3934182oiw.194.1668336749128; Sun, 13
 Nov 2022 02:52:29 -0800 (PST)
MIME-Version: 1.0
References: <d7365c44c13b563e9576cf23bd68d64e5ea57f6f.1668000538.git.geert+renesas@glider.be>
 <Y2wQV6JX0nbkpGtL@bergen.fjasle.eu>
In-Reply-To: <Y2wQV6JX0nbkpGtL@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 13 Nov 2022 19:51:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNATzZnH+P5EkU=96VYNbvaC7wKqN9iY2+zf472nx1jguCQ@mail.gmail.com>
Message-ID: <CAK7LNATzZnH+P5EkU=96VYNbvaC7wKqN9iY2+zf472nx1jguCQ@mail.gmail.com>
Subject: Re: [PATCH] modpost: Join broken long printed messages
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 5:47 AM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Wed 09 Nov 2022 14:30:55 GMT Geert Uytterhoeven wrote:
> > Breaking long printed messages in multiple lines makes it very hard to
> > look up where they originated from.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
>
> thanks, I do appreciate such changes!
>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>


Applied to linux-kbuild.
Thanks.

>
> >  scripts/mod/file2alias.c | 18 +++++++-----------
> >  scripts/mod/modpost.c    |  8 +++-----
> >  2 files changed, 10 insertions(+), 16 deletions(-)
> >
> > diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> > index 80d973144fded3b1..7df23905fdf1cb36 100644
> > --- a/scripts/mod/file2alias.c
> > +++ b/scripts/mod/file2alias.c
> > @@ -140,25 +140,22 @@ static void device_id_check(const char *modname, =
const char *device_id,
> >       int i;
> >
> >       if (size % id_size || size < id_size) {
> > -             fatal("%s: sizeof(struct %s_device_id)=3D%lu is not a mod=
ulo "
> > -                   "of the size of "
> > -                   "section __mod_%s__<identifier>_device_table=3D%lu.=
\n"
> > -                   "Fix definition of struct %s_device_id "
> > -                   "in mod_devicetable.h\n",
> > +             fatal("%s: sizeof(struct %s_device_id)=3D%lu is not a mod=
ulo of the size of section __mod_%s__<identifier>_device_table=3D%lu.\n"
> > +                   "Fix definition of struct %s_device_id in mod_devic=
etable.h\n",
> >                     modname, device_id, id_size, device_id, size, devic=
e_id);
> >       }
> >       /* Verify last one is a terminator */
> >       for (i =3D 0; i < id_size; i++ ) {
> >               if (*(uint8_t*)(symval+size-id_size+i)) {
> > -                     fprintf(stderr,"%s: struct %s_device_id is %lu by=
tes.  "
> > -                             "The last of %lu is:\n",
> > +                     fprintf(stderr,
> > +                             "%s: struct %s_device_id is %lu bytes.  T=
he last of %lu is:\n",
> >                               modname, device_id, id_size, size / id_si=
ze);
> >                       for (i =3D 0; i < id_size; i++ )
> >                               fprintf(stderr,"0x%02x ",
> >                                       *(uint8_t*)(symval+size-id_size+i=
) );
> >                       fprintf(stderr,"\n");
> > -                     fatal("%s: struct %s_device_id is not terminated =
"
> > -                             "with a NULL entry!\n", modname, device_i=
d);
> > +                     fatal("%s: struct %s_device_id is not terminated =
with a NULL entry!\n",
> > +                           modname, device_id);
> >               }
> >       }
> >  }
> > @@ -1154,8 +1151,7 @@ static int do_amba_entry(const char *filename,
> >       DEF_FIELD(symval, amba_id, mask);
> >
> >       if ((id & mask) !=3D id)
> > -             fatal("%s: Masked-off bit(s) of AMBA device ID are non-ze=
ro: "
> > -                   "id=3D0x%08X, mask=3D0x%08X.  Please fix this drive=
r.\n",
> > +             fatal("%s: Masked-off bit(s) of AMBA device ID are non-ze=
ro: id=3D0x%08X, mask=3D0x%08X.  Please fix this driver.\n",
> >                     filename, id, mask);
> >
> >       p +=3D sprintf(alias, "amba:d");
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 2c80da0220c326ef..56d856f2e5115150 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -519,9 +519,8 @@ static int parse_elf(struct elf_info *info, const c=
har *filename)
> >               int nobits =3D sechdrs[i].sh_type =3D=3D SHT_NOBITS;
> >
> >               if (!nobits && sechdrs[i].sh_offset > info->size) {
> > -                     fatal("%s is truncated. sechdrs[i].sh_offset=3D%l=
u > "
> > -                           "sizeof(*hrd)=3D%zu\n", filename,
> > -                           (unsigned long)sechdrs[i].sh_offset,
> > +                     fatal("%s is truncated. sechdrs[i].sh_offset=3D%l=
u > sizeof(*hrd)=3D%zu\n",
> > +                           filename, (unsigned long)sechdrs[i].sh_offs=
et,
> >                             sizeof(*hdr));
> >                       return 0;
> >               }
> > @@ -1355,8 +1354,7 @@ static void report_extable_warnings(const char* m=
odname, struct elf_info* elf,
> >       get_pretty_name(is_function(tosym),
> >                       &to_pretty_name, &to_pretty_name_p);
> >
> > -     warn("%s(%s+0x%lx): Section mismatch in reference"
> > -          " from the %s %s%s to the %s %s:%s%s\n",
> > +     warn("%s(%s+0x%lx): Section mismatch in reference from the %s %s%=
s to the %s %s:%s%s\n",
> >            modname, fromsec, (long)r->r_offset, from_pretty_name,
> >            fromsym_name, from_pretty_name_p,
> >            to_pretty_name, tosec, tosym_name, to_pretty_name_p);
> > --
> > 2.25.1
>
> --
> epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
> =E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
>      -- frykten for herren er opphav til kunnskap --



--=20
Best Regards
Masahiro Yamada
