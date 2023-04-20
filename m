Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5026E8B40
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbjDTHR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDTHR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:17:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7668A2726;
        Thu, 20 Apr 2023 00:17:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEC0C64557;
        Thu, 20 Apr 2023 07:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8C9C4339C;
        Thu, 20 Apr 2023 07:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681975073;
        bh=Jph0kWmC5akucLxf0Bkm1MeYGJgR8Sd/uxI3YXx8XIQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pe5c+yViEaO6bCzCGXwrjrI6GHSBA4/guJp7PM8Q420cSlur2Y89gs5vM1Kh+Y98A
         QHGMc1heBWyWAAVyJKlGDhowtiCJ+0wmeo/ccaJAvV+vjEYm30/hQlxrUgAOKl3wPY
         FNNOBX53dcUenJdbmUsZzGxzL82X8gAAul4jV+cyrtcZi9TYu5VZBEu6m14+ORZunM
         3ujdQZdrVtPh+rx5N7kSz+sIdSj8gPlXHfMoAUaAy4Ue3XZRSBg+aVxYZahmhml5DV
         f+JHdrE++PNDSS235Gfscm9C/9UVzsRtsAsg1Fgq6b08nTNgjbDc+AMG/yN/q0I8ku
         Eu4ug/pqhS/tg==
Received: by mail-oo1-f48.google.com with SMTP id l1-20020a4acf01000000b005472eb23b30so424849oos.1;
        Thu, 20 Apr 2023 00:17:53 -0700 (PDT)
X-Gm-Message-State: AAQBX9fD61lAGObgYenS5k2V4qIhY9sWVGEGCocCS5fwjyRljKC3IR8W
        iyadfGKycOj36NhlCqTchl/9JYWAbD2xFTk0WtM=
X-Google-Smtp-Source: AKy350Y+lE/V5zaTHmxSCq2E88mHEfJfr95SIh6J560AHJpGS22RdjczVWRFe9c1xEWqquQiN3hpUP5ewWx5oZrcrBM=
X-Received: by 2002:a4a:4983:0:b0:545:c026:8efa with SMTP id
 z125-20020a4a4983000000b00545c0268efamr543946ooa.2.1681975072637; Thu, 20 Apr
 2023 00:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230417142548.249610-1-masahiroy@kernel.org> <20230417142548.249610-2-masahiroy@kernel.org>
 <ZEBQPeihAuP4jVYG@bergen.fjasle.eu>
In-Reply-To: <ZEBQPeihAuP4jVYG@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 20 Apr 2023 16:17:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQjXTZhObuZ6R159kaOcsjTnTHftqnZe6GMfk0ibCkOkw@mail.gmail.com>
Message-ID: <CAK7LNAQjXTZhObuZ6R159kaOcsjTnTHftqnZe6GMfk0ibCkOkw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kbuild: deb-pkg: add KDEB_SOURCE_COMPRESS to specify
 compression type
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Bastian Germann <bage@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 5:34=E2=80=AFAM Nicolas Schier <nicolas@fjasle.eu> =
wrote:
>
> On Mon 17 Apr 2023 23:25:48 GMT, Masahiro Yamada wrote:
> > Add KDEB_SOURCE_COMPRESS to specify the compression for the orig and
> > debian tarballs. (The existing KDEB_COMPRESS is used to specify the
> > compression for binary packages.)
>
> Sounds to me, that it would make sense to sum-up some documentation for
> kbuild Debian package configuration.
>
> > Supported algorithms are gzip, bzip2, lzma, and xz, all of which are
> > supported by dpkg-source.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/Makefile.package | 31 +++++++++++++++++++++++--------
> >  1 file changed, 23 insertions(+), 8 deletions(-)
> >
> > diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> > index d8a36304b26e..ce3d8b4e9cb0 100644
> > --- a/scripts/Makefile.package
> > +++ b/scripts/Makefile.package
> > @@ -41,19 +41,25 @@ check-git:
> >               false; \
> >       fi
> >
> > -git-config-tar.gz  =3D -c tar.tar.gz.command=3D"$(KGZIP)"
> > -git-config-tar.bz2 =3D -c tar.tar.bz2.command=3D"$(KBZIP2)"
> > -git-config-tar.xz  =3D -c tar.tar.xz.command=3D"$(XZ)"
> > -git-config-tar.zst =3D -c tar.tar.zst.command=3D"$(ZSTD)"
> > +git-config-tar.gz   =3D -c tar.tar.gz.command=3D"$(KGZIP)"
> > +git-config-tar.bz2  =3D -c tar.tar.bz2.command=3D"$(KBZIP2)"
> > +git-config-tar.lzma =3D -c tar.tar.lzma.command=3D"$(LZMA)"
> > +git-config-tar.xz   =3D -c tar.tar.xz.command=3D"$(XZ)"
> > +git-config-tar.zst  =3D -c tar.tar.zst.command=3D"$(ZSTD)"
> >
> >  quiet_cmd_archive =3D ARCHIVE $@
> >        cmd_archive =3D git -C $(srctree) $(git-config-tar$(suffix $@)) =
archive \
> >                      --output=3D$$(realpath $@) --prefix=3D$(basename $=
@)/ $(archive-args)
> >
> > +suffix-gzip  :=3D .gz
> > +suffix-bzip2 :=3D .bz2
> > +suffix-lzma  :=3D .lzma
> > +suffix-xz    :=3D .xz
> > +
> >  # Linux source tarball
> >  # --------------------------------------------------------------------=
-------
> >
> > -linux-tarballs :=3D $(addprefix linux, .tar.gz)
> > +linux-tarballs :=3D $(addprefix linux, .tar.gz .tar.bz2 .tar.lzma .tar=
.xz)
> >
> >  targets +=3D $(linux-tarballs)
> >  $(linux-tarballs): archive-args =3D $$(cat $<)
> > @@ -88,6 +94,15 @@ binrpm-pkg:
> >  # deb-pkg srcdeb-pkg bindeb-pkg
> >  # --------------------------------------------------------------------=
-------
> >
> > +KDEB_SOURCE_COMPRESS ?=3D gzip
>
> According to dpkg-source(1), xz is the default compression for deb
> source format >=3D 2.  Shouldn't we use xz here by default as well?


Yes.
xz is the default because we switched to format 3.0 (quilt).

But, we used gzip for a long time, so I did not change it
in this commit.


I do not have a strong opinion.

Ben (debian kernel maintainer) is in the CC list,
perhaps he has some preference.






--
Best Regards
Masahiro Yamada
