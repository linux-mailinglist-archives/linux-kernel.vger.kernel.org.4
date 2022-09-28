Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDAA5ED2E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 04:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiI1CGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 22:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiI1CG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 22:06:27 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB67F508A;
        Tue, 27 Sep 2022 19:06:23 -0700 (PDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 28S2614p026989;
        Wed, 28 Sep 2022 11:06:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 28S2614p026989
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664330761;
        bh=XeKuSPgnAvNWCpG2G8pV3A3pJK6QQf7sh1aj1viXMjo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jw35+SYSAy/axTS2k4slHRA1Zrc62wXTc6WR7S/ZuLXoNSA+eVT0j2D+buoBB/PC4
         S3lY2oSpJdml8cRbng5Y2BdX4ku7L3xaBk0vlg20slt+PsKEFCmdgqsITR46505PwJ
         psruxj5qQADp09Awktq8vbPMccFLGFWwut7f+AJUXeCIGinRMvA6V/OmX4OqYoJrtX
         mVWOQESdNkB7SbQ2+wdOtZn+BJCumrFcREJoTfzgJg0/pxdR4vgALNbJnjajn1GtPP
         qkIsJ7rwBLatYMlJjKztOFZLZtxeTGhOraL6Yq1qR/0U/KT5HTFO1pngmtLP5Wk2z2
         Va5NxY1LQWU9g==
X-Nifty-SrcIP: [209.85.167.181]
Received: by mail-oi1-f181.google.com with SMTP id w13so2041599oiw.8;
        Tue, 27 Sep 2022 19:06:01 -0700 (PDT)
X-Gm-Message-State: ACrzQf0wW7prWSAP9Cv+p9AHYSs9aeRrF3EFcQ6f+azgnIBBjcv9npTn
        +yrQEdOOSSXUOfHlBGKDlesfnzo7kGwduaam7Rc=
X-Google-Smtp-Source: AMsMyM7D8msamuE8QgFk42iJpD0Bqfjug4yHUsohPP4e9k8H0TdewQ33sXwENDDQLtU4siIUo9U5AZBoe8puUIW/Db4=
X-Received: by 2002:a54:400c:0:b0:34f:9913:262 with SMTP id
 x12-20020a54400c000000b0034f99130262mr3145596oie.287.1664330760371; Tue, 27
 Sep 2022 19:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220922184525.3021522-1-zack@kde.org> <CAK7LNARRUbcZLNUOY-is=EVC7Ov8-0SHS=207=XbQkkjS59g4Q@mail.gmail.com>
 <a96c0711f0e163e1de8362b32010dbac2f973ee6.camel@vmware.com>
In-Reply-To: <a96c0711f0e163e1de8362b32010dbac2f973ee6.camel@vmware.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 28 Sep 2022 11:05:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNASMysHU59QELsUDTjubxpva4fDZYFa_=Uj9sd4YnRqZQQ@mail.gmail.com>
Message-ID: <CAK7LNASMysHU59QELsUDTjubxpva4fDZYFa_=Uj9sd4YnRqZQQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Add an option to skip vmlinux.bz2 in the rpm's
To:     Zack Rusin <zackr@vmware.com>
Cc:     "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Wed, Sep 28, 2022 at 10:09 AM Zack Rusin <zackr@vmware.com> wrote:
>
> On Tue, 2022-09-27 at 02:38 +0900, Masahiro Yamada wrote:
> > =E2=9A=A0 External Email
> >
> > On Fri, Sep 23, 2022 at 3:45 AM Zack Rusin <zack@kde.org> wrote:
> > >
> > > From: Zack Rusin <zackr@vmware.com>
> > >
> > > The debug vmlinux takes up the vast majority of space in the built
> > > rpm's. While having it enabled by default is a good idea because it
> > > makes debugging easier, having an option to skip it is highly valuabl=
e
> > > for CI/CD systems where small packages are a lot easier to deal with
> > > e.g. kernel rpm built using binrpm-pkg on Fedora 36 default 5.19.8 ke=
rnel
> > > config and localmodconfig goes from 255MB to 65MB which is an almost
> > > 4x difference.
> > >
> > > To skip adding vmlinux.bz2 to the built rpm add SKIP_RPM_VMLINUX
> > > environment variable which when set to "y", e.g. via
> > > "SKIP_RPM_VMLINUX=3Dy make binrpm-pkg" won't include vmlinux.bz2 in t=
he
> > > built rpm.
> > >
> > > Signed-off-by: Zack Rusin <zackr@vmware.com>
> > > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > > Cc: Michal Marek <michal.lkml@markovi.net>
> > > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > Cc: linux-kbuild@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > ---
> > >  scripts/package/mkspec | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> > > index 7c477ca7dc98..5a71fc0852b0 100755
> > > --- a/scripts/package/mkspec
> > > +++ b/scripts/package/mkspec
> > > @@ -23,6 +23,12 @@ else
> > >         M=3DDEL
> > >  fi
> > >
> > > +if [ "$RPM_SKIP_VMLINUX" =3D y ]; then
> > > +       D=3DDEL
> > > +else
> > > +       D=3D
> > > +fi
> > > +
> > >  if grep -q CONFIG_DRM=3Dy .config; then
> > >         PROVIDES=3Dkernel-drm
> > >  fi
> > > @@ -94,8 +100,8 @@ $M   $MAKE %{?_smp_mflags} INSTALL_MOD_PATH=3D%{bu=
ildroot} modules_install
> > >         $MAKE %{?_smp_mflags} INSTALL_HDR_PATH=3D%{buildroot}/usr hea=
ders_install
> > >         cp System.map %{buildroot}/boot/System.map-$KERNELRELEASE
> > >         cp .config %{buildroot}/boot/config-$KERNELRELEASE
> > > -       bzip2 -9 --keep vmlinux
> > > -       mv vmlinux.bz2 %{buildroot}/boot/vmlinux-$KERNELRELEASE.bz2
> > > +$D     bzip2 -9 --keep vmlinux
> > > +$D     mv vmlinux.bz2 %{buildroot}/boot/vmlinux-$KERNELRELEASE.bz2
> > >  $S$M   rm -f %{buildroot}/lib/modules/$KERNELRELEASE/build
> > >  $S$M   rm -f %{buildroot}/lib/modules/$KERNELRELEASE/source
> > >  $S$M   mkdir -p %{buildroot}/usr/src/kernels/$KERNELRELEASE
> > > --
> > > 2.34.1
> > >
> >
> >
> >
> >
> > This came from fc370ecfdb37b853bd8e2118c7ad9f99fa9ac5cd
> > I do not know how useful or annoying it is.
> > Presumably, it was a cheesy work, and rather annoying than useful.
> >
> >
> > In debian (scripts/package/mkdebian), this kind of stuff is
> > a separate debug package, and only built when CONFIG_DEBUG_INFO=3Dy.
> >
> >
> > Take more time in case somebody may come up with a better idea.
>
> I'd be happy to rework it in whatever way would be more convenient. Becau=
se rpm
> builds already depend on environment vars due to RPMOPTS I thought this a=
pproach was
> fitting but I'm not particularly attached to it. The important thing is t=
he the end
> result of not including vmlinux.bz2 in the rpm itself.
>
> I think the other reasonable question to ask is: is anyone still using vm=
linux.bz2
> from rpms? Because maybe just removing that code completely is the better=
 option
> here.


Yes, I like it.




--=20
Best Regards
Masahiro Yamada
