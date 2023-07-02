Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782D1744E54
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 17:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjGBP15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 11:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGBP14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 11:27:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177D3E67;
        Sun,  2 Jul 2023 08:27:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0D8360C1F;
        Sun,  2 Jul 2023 15:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B63C433C7;
        Sun,  2 Jul 2023 15:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688311673;
        bh=VM5onG+VbkQgUqgIDtQ44kWkgFnGQ04Jet0hC14QD8I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rWi1bTNctFWA20DS1DJ5f4/THEP3AJjqO/48oOH+vCV2aRoqSFosiR7Vn7mWxjBj3
         bn7F1FQaEZLkFLXpl4VEJTGZQrHxR7A5rkMtoYT7PANYUgXm4Qoh5nTTZUqrrl3VZ6
         kfOwge0zwyeeX1JYQPZ2VeXMBOhuJ/QjxtfV1la1cAXgTW71dvhZeXrcAAw7w5eZKV
         vi2o09ymPM6A5imjQCGP5MImkTVkIb6s8sABgrHUbA4QFC15dCiGPVrOVxOZBam4h8
         V+QruXtS2lQlG2vtu40Tvcu35HDoDKbySvgQJp5JYE6E6wtH9WW5wHhPSOS4Ih/xlh
         xWxTKUSnFsxyQ==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3909756b8b1so1885195b6e.1;
        Sun, 02 Jul 2023 08:27:53 -0700 (PDT)
X-Gm-Message-State: AC+VfDzFXzx8+t483Qlxal4wbBtOk5mQu0QL2mEU/uoBt2uqVLssjyZm
        EOpKGcx4BVB7z8qvxVCUVFny67nxohi5jU8wpGI=
X-Google-Smtp-Source: ACHHUZ4/tr3MkXDmNRc5e6apwmXmV39o1g74FFALKNrkdJAhapiro33bZhsIuv3YBKbbFq0rvr512/Xt0fshwDfEsoc=
X-Received: by 2002:a05:6808:3d0:b0:3a3:7ddd:1abc with SMTP id
 o16-20020a05680803d000b003a37ddd1abcmr5662529oie.36.1688311673183; Sun, 02
 Jul 2023 08:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230629160351.2996541-1-masahiroy@kernel.org>
 <20230629160351.2996541-2-masahiroy@kernel.org> <CAJFTR8Txd-6-=5RSoHhgg1a6mr4rEAUv2Ta1F5OLsC3NC4U-Sw@mail.gmail.com>
In-Reply-To: <CAJFTR8Txd-6-=5RSoHhgg1a6mr4rEAUv2Ta1F5OLsC3NC4U-Sw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 3 Jul 2023 00:27:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNASSNW80XJZtX8H2ov8kfZ+ZwP1-ue4QHAKTJr8xRqswwg@mail.gmail.com>
Message-ID: <CAK7LNASSNW80XJZtX8H2ov8kfZ+ZwP1-ue4QHAKTJr8xRqswwg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kconfig: menuconfig: remove jump_key::index
To:     Jesse T <mr.bossman075@gmail.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Jul 1, 2023 at 1:09=E2=80=AFPM Jesse T <mr.bossman075@gmail.com> wr=
ote:
>
> On Thu, Jun 29, 2023 at 12:03=E2=80=AFPM Masahiro Yamada <masahiroy@kerne=
l.org> wrote:
> >
> > You do not need to remember the index of each jump key because you can
> > count it up after a key is pressed.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/kconfig/expr.h  | 1 -
> >  scripts/kconfig/mconf.c | 7 ++++---
> >  scripts/kconfig/menu.c  | 8 --------
> >  3 files changed, 4 insertions(+), 12 deletions(-)
> >
> > diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
> > index 9c9caca5bd5f..4a9a23b1b7e1 100644
> > --- a/scripts/kconfig/expr.h
> > +++ b/scripts/kconfig/expr.h
> > @@ -275,7 +275,6 @@ struct jump_key {
> >         struct list_head entries;
> >         size_t offset;
> >         struct menu *target;
> > -       int index;
> >  };
> >
> >  extern struct file *file_list;
> > diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
> > index 7adfd6537279..fcb91d69c774 100644
> > --- a/scripts/kconfig/mconf.c
> > +++ b/scripts/kconfig/mconf.c
> > @@ -22,8 +22,6 @@
> >  #include "lkc.h"
> >  #include "lxdialog/dialog.h"
> >
> > -#define JUMP_NB                        9
> > -
> >  static const char mconf_readme[] =3D
> >  "Overview\n"
> >  "--------\n"
> > @@ -399,6 +397,7 @@ static int handle_search_keys(int key, int start, i=
nt end, void *_data)
> >  {
> >         struct search_data *data =3D _data;
> >         struct jump_key *pos;
> > +       int index =3D '1';
> >
> >         if (key < '1' || key > '9')
> >                 return 0;
> > @@ -408,11 +407,13 @@ static int handle_search_keys(int key, int start,=
 int end, void *_data)
> >                         if (pos->offset >=3D end)
> >                                 break;
> >
> > -                       if (key =3D=3D '1' + (pos->index % JUMP_NB)) {
> > +                       if (key =3D=3D index) {
> >                                 data->target =3D pos->target;
> >                                 return 1;
> >                         }
> >                 }
> > +
> > +               index =3D next_key(index);
> >         }
> >
> >         return 0;
> > diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
> > index 5578b8bc8a23..198eb1367e7a 100644
> > --- a/scripts/kconfig/menu.c
> > +++ b/scripts/kconfig/menu.c
> > @@ -735,15 +735,7 @@ static void get_prompt_str(struct gstr *r, struct =
property *prop,
> >         }
> >         if (head && location) {
> >                 jump =3D xmalloc(sizeof(struct jump_key));
> > -
> >                 jump->target =3D location;
> > -
> > -               if (list_empty(head))
> > -                       jump->index =3D 0;
> > -               else
> > -                       jump->index =3D list_entry(head->prev, struct j=
ump_key,
> > -                                                entries)->index + 1;
> > -
> >                 list_add_tail(&jump->entries, head);
> >         }
> >
> > --
> > 2.39.2
> >
>
> Looks good!
> Reviewed-by: Jesse Taube <Mr.Bossman075@gmail.com>
>
> One slight off-topic question.
> The names of the menu-based config programs have names similar to their
> corresponding file gconfig ('gconf'), xconfig ('qconf'), menuconfig ('mco=
nf'),
> and nconfig ('nconf'). The only exceptions to this one-letter naming are =
mconfig
> is not memuconfig and qconfig isn't xconfig. Would it be possible to
> add an alias
> to fix this?

I also wondered the same question in the past.

I think xconfig was implemented differently at first,
then later it was rewritten based on Qt.
The former developers kept the target name 'xconfig'
to avoid unneeded impacts, but the internal implementation
changed a lot. So, it is a historical reason, I guess.

I do not think it would be rewritten
based on yet another library, but
I just convinced myself "it's just a name" after all.



>
> Side-side note config isn't in the docs.
>
> Thanks,
> Jesse Taube



--=20
Best Regards
Masahiro Yamada
