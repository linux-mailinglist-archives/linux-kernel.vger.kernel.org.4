Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B5B68038D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 02:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbjA3Box (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 20:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbjA3Bow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 20:44:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E906A1ABD7;
        Sun, 29 Jan 2023 17:44:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81D8BB80D7C;
        Mon, 30 Jan 2023 01:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33153C4339B;
        Mon, 30 Jan 2023 01:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675043085;
        bh=E5XnEq9h0U82mV6p/h1nN6SZASUnciqdn/ltY7RTWvw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YY0P9DLyD66e0iMPyhESV1LyYHoPNS06OfDEhF2DgI2nFCs+29QwF9iteRlp63dIV
         aOBjeIWj94+BFQFLDobQAjllCQk61YQqHxKHe7gO65SFB8tx/P8bA+NFswphFt243k
         4a0IxttagUP5Dz90nCrA5o5lBTlMOqYOZ+of3t9VJkaZhiq+jxpNT+FRv7V58mKQss
         fYpSIhEFG949Q7dVC8ymVAA1Bme+XcknbEJ9gZxgcYMBeffjOVAZdGCXvAfZVHs0UM
         ezmPCubr3UdgABsLKUuKzsNC13V8x3eRLjUuFgCoUPf/98NTNBmi6VWyygOq7oDEey
         xLaQya5SyO6BA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-163bd802238so1215716fac.1;
        Sun, 29 Jan 2023 17:44:45 -0800 (PST)
X-Gm-Message-State: AFqh2kryjVA49MRGqoa7qWPvBuMyxKj+AVCKs8h14iM9uygr+raNmu06
        6WigLC3zpEEvdsApDaBvuPuK+IC9UM5LHsyE0cw=
X-Google-Smtp-Source: AK7set/zKQ3r7GXwg1m1nwKCNultqL4yP0CNssdCrIRedeapqeoyFPLgLEW9ucd+T0RwKXdr3gmqvtuoeK9EHenHFoM=
X-Received: by 2002:a05:6870:110f:b0:160:3296:a9b9 with SMTP id
 15-20020a056870110f00b001603296a9b9mr2070231oaf.287.1675043084483; Sun, 29
 Jan 2023 17:44:44 -0800 (PST)
MIME-Version: 1.0
References: <20230122141428.115372-1-masahiroy@kernel.org> <Y9blKNz0ZZbvsMAb@bergen.fjasle.eu>
In-Reply-To: <Y9blKNz0ZZbvsMAb@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 30 Jan 2023 10:44:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQr+Zcwh=ob01h5bkbc6jAuxiPxg_NK99cn8_rtk3PGAA@mail.gmail.com>
Message-ID: <CAK7LNAQr+Zcwh=ob01h5bkbc6jAuxiPxg_NK99cn8_rtk3PGAA@mail.gmail.com>
Subject: Re: [PATCH 1/7] kbuild: do not put .scmversion into the source tarball
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 6:29 AM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Sun 22 Jan 2023 23:14:21 GMT, Masahiro Yamada wrote:
> > .scmversion is used by (src)rpm-pkg and deb-pkg to carry
> > KERNELRELEASE.
> >
> > In fact, deb-pkg does not rely on it any more because the generated
> > debian/rules specifies KERNELRELEASE from the command line.
> >
> > Do likwise for (src)rpm-pkg, and remove this feature.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/Makefile.package |  6 ++----
> >  scripts/package/mkspec   |  6 +++---
> >  scripts/setlocalversion  | 19 +------------------
> >  3 files changed, 6 insertions(+), 25 deletions(-)
> >
> > diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> > index 525a2820976f..e84c4e8ceb8e 100644
> > --- a/scripts/Makefile.package
> > +++ b/scripts/Makefile.package
> > @@ -32,7 +32,7 @@ export KDEB_SOURCENAME
> >  TAR_CONTENT := Documentation LICENSES arch block certs crypto drivers fs \
> >                 include init io_uring ipc kernel lib mm net rust \
> >                 samples scripts security sound tools usr virt \
> > -               .config .scmversion Makefile \
> > +               .config Makefile \
> >                 Kbuild Kconfig COPYING $(wildcard localversion*)
> >  MKSPEC     := $(srctree)/scripts/package/mkspec
> >
> > @@ -47,10 +47,8 @@ if test "$(objtree)" != "$(srctree)"; then \
> >       echo >&2; \
> >       false; \
> >  fi ; \
> > -$(srctree)/scripts/setlocalversion --save-scmversion; \
> >  tar -I $(KGZIP) -c $(RCS_TAR_IGNORE) -f $(2).tar.gz \
> > -     --transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3); \
> > -rm -f $(objtree)/.scmversion
> > +     --transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3)
> >
> >  # rpm-pkg
> >  # ---------------------------------------------------------------------------
> > diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> > index adab28fa7f89..d3c6701b7769 100755
> > --- a/scripts/package/mkspec
> > +++ b/scripts/package/mkspec
> > @@ -90,7 +90,7 @@ $S  rm -f scripts/basic/fixdep scripts/kconfig/conf
> >  $S   rm -f tools/objtool/{fixdep,objtool}
> >  $S
> >  $S   %build
> > -$S   $MAKE %{?_smp_mflags} KBUILD_BUILD_VERSION=%{release}
> > +$S   $MAKE %{?_smp_mflags} KERNELRELEASE=%{version} KBUILD_BUILD_VERSION=%{release}
> >  $S
> >       %install
> >       mkdir -p %{buildroot}/boot
> > @@ -101,8 +101,8 @@ $S
> >       %else
> >       cp \$($MAKE -s image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEASE
> >       %endif
> > -$M   $MAKE %{?_smp_mflags} INSTALL_MOD_PATH=%{buildroot} modules_install
> > -     $MAKE %{?_smp_mflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
> > +$M   $MAKE %{?_smp_mflags} KERNELRELEASE=%{version} INSTALL_MOD_PATH=%{buildroot} modules_install
> > +     $MAKE %{?_smp_mflags} KERNELRELEASE=%{version} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
> >       cp System.map %{buildroot}/boot/System.map-$KERNELRELEASE
> >       cp .config %{buildroot}/boot/config-$KERNELRELEASE
> >  $S$M rm -f %{buildroot}/lib/modules/$KERNELRELEASE/build
> > diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> > index af4754a35e66..3b31702b4a4a 100755
> > --- a/scripts/setlocalversion
> > +++ b/scripts/setlocalversion
> > @@ -11,16 +11,11 @@
> >  #
> >
> >  usage() {
> > -     echo "Usage: $0 [--save-scmversion] [srctree]" >&2
> > +     echo "Usage: $0 [srctree]" >&2
>
> Hi Masahiro,
>
> as .scmversion will not we generated (or removed by 'make clean' or
> 'make mrproper'), might it make sense to add it to
> scripts/remove-stale-files?
>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
>
> Kind regards,
> Nicolas


Good point.

.scmversion is removed after the tarball is created
(see "rm -f $(objtree)/.scmversion"), but
it is left over if the user interrupts while the
tarball is being created.

I will fold it locally.

Thanks.






-- 
Best Regards
Masahiro Yamada
