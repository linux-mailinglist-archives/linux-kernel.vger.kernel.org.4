Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D2F6A28D9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 11:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBYKPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 05:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBYKPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 05:15:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2812C11642;
        Sat, 25 Feb 2023 02:15:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEE85B80885;
        Sat, 25 Feb 2023 10:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3613AC4339C;
        Sat, 25 Feb 2023 10:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677320107;
        bh=OtpZY6V2KS1nAe4VQkWcHx7CNr9e1WTp8HUUsJO4PDE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g+4tBKCERMc001BiWCtvGdKj778CitOyKeqoOTjcAnmK0UAIAVqfkm/6VpgzR43Wj
         Bj4ASa0cu64BpKN4h8lQgwMJJUCTQsGEZIYuZiRB6xH7Wy3lpAADudfsma8+HZugJT
         YJSYCoLl966/PWC1JFG6xX9PB/CiSoFJq8ILUPJG6HxIVvVsZv8+hXDxi3zgcJ/4ng
         2YKlRV1EL8qY7hE5obDz4gAqM2HUTWFOO0DhMcP61arQ/tnzTF8uH84m4NN3kwLyE1
         NNKsWjJD32XsgLDLnVqBueKHsdQiNIRqOokthBUzNIzEQtQCwjrH4xIhEMpCpWQue5
         HX4Rl8bNKJ8hw==
Received: by mail-ot1-f46.google.com with SMTP id h6-20020a9d7986000000b0068bd8c1e836so1006335otm.3;
        Sat, 25 Feb 2023 02:15:07 -0800 (PST)
X-Gm-Message-State: AO0yUKWXP/6uN7oMuNCUtdupQkaTP5oi6OZCBvpgqCi1Cq3otUtPyaTN
        0f31Fd+U9Ok6x0sZ/gKlQ3wYhnrviJ+wxpjU01w=
X-Google-Smtp-Source: AK7set8ybHrN1viDryZfCyQ4/Sw63dUWqIzppSiPB58LM6A5yoIQeOej1tlFZkqU2jzC2ewPJ2uObRQ/QFV5+jABl84=
X-Received: by 2002:a05:6830:26e5:b0:68d:7798:e0d2 with SMTP id
 m37-20020a05683026e500b0068d7798e0d2mr2542774otu.1.1677320106404; Sat, 25 Feb
 2023 02:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20230215012034.403356-1-masahiroy@kernel.org> <20230215012034.403356-12-masahiroy@kernel.org>
 <Y/k+v/Yj8VQ6q32H@fjasle.eu>
In-Reply-To: <Y/k+v/Yj8VQ6q32H@fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 25 Feb 2023 19:14:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQXQDy1ijtbWTj97oejT=WAh8n3=PrHHBhDeAOjM66TfA@mail.gmail.com>
Message-ID: <CAK7LNAQXQDy1ijtbWTj97oejT=WAh8n3=PrHHBhDeAOjM66TfA@mail.gmail.com>
Subject: Re: [PATCH v6 12/12] kbuild: add srcdeb-pkg target
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Sat, Feb 25, 2023 at 7:48=E2=80=AFAM Nicolas Schier <nicolas@fjasle.eu> =
wrote:
>
> On Wed, Feb 15, 2023 at 10:20:34AM +0900 Masahiro Yamada wrote:
> > This new target builds only the debian source package.
> >
> > Factor similar code out to the 'build-deb-pkg' variable.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > Changes in v6:
> >   - New patch
> >
> >  scripts/Makefile.package | 23 ++++++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> > index b941e6341b36..8650d9432c26 100644
> > --- a/scripts/Makefile.package
> > +++ b/scripts/Makefile.package
> > @@ -100,6 +100,9 @@ binrpm-pkg:
> >       +rpmbuild $(RPMOPTS) --define "_builddir $(objtree)" --target \
> >               $(UTS_MACHINE)-linux -bb $(objtree)/binkernel.spec
> >
> > +# deb-pkg srcdeb-pkg bindeb-pkg
> > +# --------------------------------------------------------------------=
-------
> > +
> >  quiet_cmd_debianize =3D GEN     $@
> >        cmd_debianize =3D $(srctree)/scripts/package/mkdebian
> >
> > @@ -117,14 +120,27 @@ debian-orig: linux.tar.gz debian
> >               cp $< ../$(orig-name); \
> >       fi
> >
> > +build-deb-pkg =3D \
> > +        dpkg-buildpackage \
> > +        --build=3D$(build-type) --no-pre-clean --unsigned-changes \
> > +        $(if $(findstring source, $(build-type)), --unsigned-source) \
> > +        $(if $(findstring binary, $(build-type)), -r$(KBUILD_PKG_ROOTC=
MD) -a$$(cat debian/arch)) \
> > +        $(DPKG_FLAGS)
> > +
> >  PHONY +=3D deb-pkg
> > +deb-pkg: private build-type :=3D source,binary
> >  deb-pkg: debian-orig
> > -     +dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) =
$(DPKG_FLAGS) \
> > -             --build=3Dsource,binary -nc -us -uc
> > +     +$(build-deb-pkg)
> > +
> > +PHONY +=3D srcdeb-pkg
> > +srcdeb-pkg: private build-type :=3D source
> > +srcdeb-pkg: debian-orig
> > +     +$(build-deb-pkg)
> >
> >  PHONY +=3D bindeb-pkg
> > +bindeb-pkg: private build-type :=3D binary
> >  bindeb-pkg: debian
> > -     +dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) =
$(DPKG_FLAGS) -b -nc -uc
> > +     +$(build-deb-pkg)
> >
> >  PHONY +=3D intdeb-pkg
> >  intdeb-pkg:
> > @@ -225,6 +241,7 @@ help:
> >       @echo '  srcrpm-pkg          - Build only the source kernel RPM p=
ackage'
> >       @echo '  binrpm-pkg          - Build only the binary kernel RPM p=
ackage'
> >       @echo '  deb-pkg             - Build both source and binary deb k=
ernel packages'
> > +     @echo '  binsrc-pkg          - Build only the source kernel deb p=
ackage'
>
> typo: srcdeb-dpkg

I will fix. Thanks.


>
> With this typo fixed:
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
>
> >       @echo '  bindeb-pkg          - Build only the binary kernel deb p=
ackage'
> >       @echo '  snap-pkg            - Build only the binary kernel snap =
package'
> >       @echo '                        (will connect to external hosts)'
> > --
> > 2.34.1
>
> Thanks for the patch (and the whole patch set), I appreciate it!
>
> While testing, I stumbled over one thing, not really related to this patc=
h:
>
> As tar complains about any kind of tree changes while it creates an archi=
ve,
> 'olddefconfig' and 'srcdeb-pkg' must not be build at the same time.  Is i=
t
> sensible to add another 'mixed-build' check in top-level Makefile against=
 all
> target depending on linux.tar.gz?
>
>     $ make olddefconfig srcdeb-pkg -j8

This is already done.

The mixture of config targets and non-config targets
are treated as mixed-build. [1]
So, Kbuild internally divides it into 'make olddefconfig -j8'
followed by 'make srcdeb-pkg -j8'.


[1] https://github.com/torvalds/linux/blob/v6.2/Makefile#L335





>     #
>     # No change to .config
>     #
>       GEN     debian
>       UPD     .tmp_filelist
>       TAR     linux.tar.gz
>     tar: .: file changed as we read it
>     make[2]: *** [scripts/Makefile.package:58: linux.tar.gz] Error 1
>     make[2]: *** Deleting file 'linux.tar.gz'
>     make[1]: *** [Makefile:1654: srcdeb-pkg] Error 2
>     make: *** [Makefile:358: __build_one_by_one] Error 2


I ran the same command, but I could not reproduce this.





>
> Kind regards,
> Nicolas



--=20
Best Regards
Masahiro Yamada
