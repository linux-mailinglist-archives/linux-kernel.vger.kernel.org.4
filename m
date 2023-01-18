Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148806712F1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 06:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjARFDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 00:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjARFD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 00:03:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B688530F2;
        Tue, 17 Jan 2023 21:03:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D5C0615B3;
        Wed, 18 Jan 2023 05:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795C8C433F1;
        Wed, 18 Jan 2023 05:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674018202;
        bh=Z13dWD4V4kzQr0mX5r5RbTrVyA9DIQDhBvDTdQOR2PY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YEjnc3+mhyvHMw8QzoWaOOdZUI79wCJGlWhJAmeyuNs1Q/ZPZDm2ZQL3eVGdschH9
         mSakoJKVbyrSsw68mjlxcNVlnyP806oZi1LsqgJM0ALsUwB7xNldGsWqhjGxOvNTW1
         g/CDiyww+v8aFVpUuvxBuBRyRopX5dXS5uJuXVFywC0humpZvGWwb9VXlDbH73DU5K
         oU6lsSBTQyMH8LQVPB0p2mAtG3LU0ahUnLSJjAn4xJVn8GtbzqKj8h6ONbjvZTyF24
         QC1TnNmTTFBODmIbQELpCrAN2BJwmf6eQ+PbHN2PiLpUzhl9PVBXaan7IVigwfYOZG
         qHRdea960jifA==
Received: by mail-oi1-f182.google.com with SMTP id p185so6668354oif.2;
        Tue, 17 Jan 2023 21:03:22 -0800 (PST)
X-Gm-Message-State: AFqh2koP3nMbcPfAn80fHbKYMJxTYUjrrYarHp8dp3xf0KFJ12aIdoF/
        uJwJU9it6EL7Bb0idFjrCxjb21SJGNanct+Ok5M=
X-Google-Smtp-Source: AMrXdXuHkWlYkMTG0lAFWSMbl7WzBoBqRysIjXTwot1v84GrJC/fXYpOAaA6oRm5flkZpTqRxb2+r49QeUwQnOH6YgU=
X-Received: by 2002:aca:acd5:0:b0:364:5d10:7202 with SMTP id
 v204-20020acaacd5000000b003645d107202mr263716oie.194.1674018201671; Tue, 17
 Jan 2023 21:03:21 -0800 (PST)
MIME-Version: 1.0
References: <20230117-kernel-kheaders-gitignore-v2-1-1c29b3adf04a@weissschuh.net>
 <CAK7LNARi8Gm7n0nRidyf++YmW9zZ1qv7huN8nP3MCNzWGK42Cg@mail.gmail.com> <20230118005830.pqupfqnwwkd64q3g@t-8ch.de>
In-Reply-To: <20230118005830.pqupfqnwwkd64q3g@t-8ch.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 18 Jan 2023 14:02:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNARo4H+wKFMjd-DuzS33eV_i86bZW-S7s4Y4q7V7M7NA6w@mail.gmail.com>
Message-ID: <CAK7LNARo4H+wKFMjd-DuzS33eV_i86bZW-S7s4Y4q7V7M7NA6w@mail.gmail.com>
Subject: Re: [PATCH v2] kheaders: ignore and clean temporary kheaders_data directory
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nicolas Schier <n.schier@avm.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:10 AM Thomas Wei=C3=9Fschuh <linux@weissschuh.ne=
t> wrote:
>
> On Tue, Jan 17, 2023 at 11:24:47PM +0900, Masahiro Yamada wrote:
> > On Tue, Jan 17, 2023 at 10:50 PM Thomas Wei=C3=9Fschuh <linux@weissschu=
h.net> wrote:
> > >
> > > If the kheaders archive generation is interrupted then this directory
> > > may be left.
> > > Ignore it, it will be deleted by the next run of kernel/gen_kheaders.=
sh.
> > > Also add it to clean-files so it can be cleaned up by make.
> > >
> > > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> >
> >
> > Or, just rename the temporary directory.
> > For example,
> >
> >   cpio_dir=3D$outdir/$(dirname $tarfile)/.tmp_cpio_dir
> >
> >
> >
> > Dot files are ignored.
> > 'make clean' removes the .tmp_* pattern.
>
> This sounds great.
>
> Unfortunately 'make clean' only cleans files and not directories based
> on this pattern.


Agh, you are right.

Can you extend .tmp_* to match any file type?

Maybe, something like this?


 \( -name '*.[aios]' -o [snip] '*.*.symversions' \) -type f -print
-o -name '.tmp_*' -print





>
> Should it be extended?
>
> > > ---
> > > Changes in v2:
> > > - Also add the directory to clean-files
> > > - Link to v1: https://lore.kernel.org/r/20230117-kernel-kheaders-giti=
gnore-v1-1-2a3a070efd0d@weissschuh.net
> > > ---
> > >  kernel/.gitignore | 1 +
> > >  kernel/Makefile   | 2 +-
> > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/.gitignore b/kernel/.gitignore
> > > index c6b299a6b786..57ab1d703763 100644
> > > --- a/kernel/.gitignore
> > > +++ b/kernel/.gitignore
> > > @@ -1,3 +1,4 @@
> > >  # SPDX-License-Identifier: GPL-2.0-only
> > >  /config_data
> > >  /kheaders.md5
> > > +/kheaders_data.tar.xz.tmp/
> > > diff --git a/kernel/Makefile b/kernel/Makefile
> > > index 10ef068f598d..f3535944f635 100644
> > > --- a/kernel/Makefile
> > > +++ b/kernel/Makefile
> > > @@ -156,4 +156,4 @@ quiet_cmd_genikh =3D CHK     $(obj)/kheaders_data=
.tar.xz
> > >  $(obj)/kheaders_data.tar.xz: FORCE
> > >         $(call cmd,genikh)
> > >
> > > -clean-files :=3D kheaders_data.tar.xz kheaders.md5
> > > +clean-files :=3D kheaders_data.tar.xz kheaders.md5 kheaders_data.tar=
.xz.tmp
> > >
> > > ---
> > > base-commit: d532dd102151cc69fcd00b13e5a9689b23c0c8d9
> > > change-id: 20230117-kernel-kheaders-gitignore-f0d73456cb6b
> > >
> > > Best regards,
> > > --
> > > Thomas Wei=C3=9Fschuh <linux@weissschuh.net>



--=20
Best Regards
Masahiro Yamada
