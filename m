Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3799762EA89
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 01:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbiKRArS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 19:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240683AbiKRAqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 19:46:55 -0500
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87631716E9;
        Thu, 17 Nov 2022 16:46:53 -0800 (PST)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 2AI0kTX7018538;
        Fri, 18 Nov 2022 09:46:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 2AI0kTX7018538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1668732390;
        bh=4qQRF/YW+Q4Xdt29drvNG9moHWYxO2P8epgstiZEkCY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uipYHXdR0QIdZ0ZvA5xZiEw7mLmx0qQYsN9GuEE4R9LJC4S48SZtmSQ9HObrC1B09
         aItJ0PtMJglekRgk9CSvKROBH3deDUbNVEjEJhEGuZlcwzmM9pdE7EaPUdy2KfEc/1
         FPTcp1REsp3mEyyKr8cx0wkHr8mcbAMtkF4gaz26VOSP6CRfswITUkADpOLa5mEk3I
         ZR4ApcSwjBICWLJcakdfBFui2RhjNZTJ8AEuOHf6YIXngjAmxwKpDhhKKQHj2bbzIs
         XRdVP8oeGSsbZJGhVxMTE4rnaL/bX/sT2Nv1WlkFYgkKbFWoJYW73M5PiBxrBQJqtk
         QxrLrtI4v+g8A==
X-Nifty-SrcIP: [209.85.167.174]
Received: by mail-oi1-f174.google.com with SMTP id h132so3808878oif.2;
        Thu, 17 Nov 2022 16:46:30 -0800 (PST)
X-Gm-Message-State: ANoB5plr7wHebJ3jcy/JCDEOSiyJyerHr9uyvzyXU/dNxwCg2Z6yseCN
        Q4rD874ZysXbFMO4tCcdcANo8ovvKPwsWSa7228=
X-Google-Smtp-Source: AA0mqf5yVu+9Y/9GFv6cCoVodLb3NU1Rj/RRcH8JsCQHBvvPu6BM8uvAlDjrcsnhIILonY4bQtTkv4uPmrMskP7aLxU=
X-Received: by 2002:a05:6808:3009:b0:354:94a6:a721 with SMTP id
 ay9-20020a056808300900b0035494a6a721mr5243333oib.194.1668732388892; Thu, 17
 Nov 2022 16:46:28 -0800 (PST)
MIME-Version: 1.0
References: <20221113111525.3762483-1-masahiroy@kernel.org>
 <20221113111525.3762483-2-masahiroy@kernel.org> <Y3adxuxz5kLcYuKu@bergen.fjasle.eu>
In-Reply-To: <Y3adxuxz5kLcYuKu@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 18 Nov 2022 09:45:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT7EJGGLpGtK-zAt7ynVc+aXvSL9PCPKv1DUWX1bB8d2w@mail.gmail.com>
Message-ID: <CAK7LNAT7EJGGLpGtK-zAt7ynVc+aXvSL9PCPKv1DUWX1bB8d2w@mail.gmail.com>
Subject: Re: [PATCH 1/3] kbuild: add kbuild-file macro
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Fri, Nov 18, 2022 at 5:47 AM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Sun, 13 Nov 2022 20:15:23 +0900 Masahiro Yamada wrote:
> > While building, installing, cleaning, Kbuild visits sub-directories
> > and includes 'Kbuild' or 'Makefile' that exists there.
> >
> > Add 'kbuild-file' macro, and reuse it from scripts/Makefie.*
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/Kbuild.include       | 5 +++++
> >  scripts/Makefile.asm-generic | 6 +++---
> >  scripts/Makefile.build       | 6 +-----
> >  scripts/Makefile.clean       | 5 +----
> >  scripts/Makefile.dtbinst     | 2 +-
> >  5 files changed, 11 insertions(+), 13 deletions(-)
> >
> > diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> > index 2bc08ace38a3..cbe28744637b 100644
> > --- a/scripts/Kbuild.include
> > +++ b/scripts/Kbuild.include
> > @@ -40,6 +40,11 @@ escsq =3D $(subst $(squote),'\$(squote)',$1)
> >  # Quote a string to pass it to C files. foo =3D> '"foo"'
> >  stringify =3D $(squote)$(quote)$1$(quote)$(squote)
> >
> > +###
> > +# The path to Kbuild or Makefile. Kbuild has precedence over Makefile.
> > +kbuild-dir =3D $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
> > +kbuild-file =3D $(or $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Ma=
kefile)
> > +
> >  ###
> >  # Easy method for doing a status message
> >         kecho :=3D :
> > diff --git a/scripts/Makefile.asm-generic b/scripts/Makefile.asm-generi=
c
> > index 1d501c57f9ef..8d01b37b7677 100644
> > --- a/scripts/Makefile.asm-generic
> > +++ b/scripts/Makefile.asm-generic
> > @@ -10,15 +10,15 @@ PHONY :=3D all
> >  all:
> >
> >  src :=3D $(subst /generated,,$(obj))
> > --include $(src)/Kbuild
> > +
> > +include $(srctree)/scripts/Kbuild.include
> > +-include $(kbuild-file)
> >
> >  # $(generic)/Kbuild lists mandatory-y. Exclude um since it is a specia=
l case.
> >  ifneq ($(SRCARCH),um)
> >  include $(srctree)/$(generic)/Kbuild
> >  endif
> >
> > -include $(srctree)/scripts/Kbuild.include
> > -
> >  redundant :=3D $(filter $(mandatory-y) $(generated-y), $(generic-y))
> >  redundant +=3D $(foreach f, $(generic-y), $(if $(wildcard $(srctree)/$=
(src)/$(f)),$(f)))
> >  redundant :=3D $(sort $(redundant))
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 41f3602fc8de..37cf88d076e8 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -38,11 +38,7 @@ subdir-ccflags-y :=3D
> >
> >  include $(srctree)/scripts/Kbuild.include
> >  include $(srctree)/scripts/Makefile.compiler
> > -
> > -# The filename Kbuild has precedence over Makefile
> > -kbuild-dir :=3D $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
> > -include $(or $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Makefile)
> > -
> > +include $(kbuild-file)
> >  include $(srctree)/scripts/Makefile.lib
> >
> >  # Do not include hostprogs rules unless needed.
> > diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
> > index 878cec648959..3649900696dd 100644
> > --- a/scripts/Makefile.clean
> > +++ b/scripts/Makefile.clean
> > @@ -9,10 +9,7 @@ PHONY :=3D __clean
> >  __clean:
> >
> >  include $(srctree)/scripts/Kbuild.include
> > -
> > -# The filename Kbuild has precedence over Makefile
> > -kbuild-dir :=3D $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
> > -include $(or $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Makefile)
> > +include $(kbuild-file)
> >
> >  # Figure out what we need to build from the various variables
> >  # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > diff --git a/scripts/Makefile.dtbinst b/scripts/Makefile.dtbinst
> > index 190d781e84f4..2ab936e4179d 100644
> > --- a/scripts/Makefile.dtbinst
> > +++ b/scripts/Makefile.dtbinst
> > @@ -15,7 +15,7 @@ __dtbs_install:
> >
> >  include include/config/auto.conf
> >  include $(srctree)/scripts/Kbuild.include
> > -include $(src)/Makefile
> > +include $(kbuild-file)
> >
> >  dtbs    :=3D $(addprefix $(dst)/, $(dtb-y) $(if $(CONFIG_OF_ALL_DTBS),=
$(dtb-)))
> >  subdirs :=3D $(addprefix $(obj)/, $(subdir-y) $(subdir-m))
> > --
> > 2.34.1
>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
>
> What do you think about using $(kbuild-file) also in Makefile.modpost?


Yes, we can replace it as well.
I will fix it.

Thanks for the close review, as always!






>
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -93,7 +93,7 @@ obj :=3D $(KBUILD_EXTMOD)
>  src :=3D $(obj)
>
>  # Include the module's Makefile to find KBUILD_EXTRA_SYMBOLS
> -include $(or $(wildcard $(src)/Kbuild), $(src)/Makefile)
> +include $(kbuild-file)
>
>  module.symvers-if-present :=3D $(wildcard Module.symvers)
>  output-symdump :=3D $(KBUILD_EXTMOD)/Module.symvers
>
>
> Kind regards,
> Nicolas
>
> --
> epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
> =E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
>      -- frykten for herren er opphav til kunnskap --



--=20
Best Regards
Masahiro Yamada
