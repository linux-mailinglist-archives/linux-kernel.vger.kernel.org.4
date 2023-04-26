Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447EC6EF60E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241185AbjDZONK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241020AbjDZONI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:13:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E49E6A57;
        Wed, 26 Apr 2023 07:13:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A21660F13;
        Wed, 26 Apr 2023 14:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C51C433EF;
        Wed, 26 Apr 2023 14:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682518386;
        bh=x0IE+aictI7iBTlgwDbCKYRNktLIdJfBV50W/zzhHKg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T8WxxuGPDIvZ2iwwGO02hUjUWqPfrh5APAdbg4eA8/VA0W5BFVsCG4jfjnltRJUKh
         3tL8qAGFbx6Iw27yqAVOEgGFfMiGgHpYzg3FOgczi75hColg3SvG474GpiBWlcGVuY
         Nl7vLsJapDZ48tQ4BV4JZXLijs/MZK/W/EQCC3j6gMYVRLegSU51IT5eERVxV3DnZd
         ZsK3ferK4nIwi6lWUFWqHKQwDShVtS2KqovMPdzDlEIATi/+sV0JbunSlXl95HXwSs
         hzgb6sZava+y5THWTGbzyAzDF2Ydu6st8Kdyqxo9ogKz6nIYbuhettmjxvZDWjn1Eb
         V5KmkndQwIDJQ==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-541b60e0a7fso3882148eaf.1;
        Wed, 26 Apr 2023 07:13:06 -0700 (PDT)
X-Gm-Message-State: AAQBX9cKxi4wgLtEFwkKSEdmgibs9QgsKary74cHjfg4TO8lgvMyPLBp
        x0kKeLJ98VlCe1G6iW9BEZWZArPjiivUdx8TWJ0=
X-Google-Smtp-Source: AKy350aqhP/aEkdht7qgL09oEeT4Iv7LEfU/bCvci2PM5b4mh70GxTqJapvFlKkB85aTp3T0WRG2r9BXXOcaa6Nw0+k=
X-Received: by 2002:a05:6808:13cf:b0:38c:63d6:9e73 with SMTP id
 d15-20020a05680813cf00b0038c63d69e73mr10491166oiw.25.1682518386000; Wed, 26
 Apr 2023 07:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230425110859.1757001-1-masahiroy@kernel.org> <20230425180802.GA2881732@dev-arch.thelio-3990X>
In-Reply-To: <20230425180802.GA2881732@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 26 Apr 2023 23:12:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNARyW56E=RC_23NuEr7ZYi-iuxo6CvKfrPcCxJXcAF3ngg@mail.gmail.com>
Message-ID: <CAK7LNARyW56E=RC_23NuEr7ZYi-iuxo6CvKfrPcCxJXcAF3ngg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: deb-pkg: specify targets in debian/rules as .PHONY
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 3:08=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Tue, Apr 25, 2023 at 08:08:59PM +0900, Masahiro Yamada wrote:
> > If a file with the same name exists, the target is not run.
> >
> > For example, the following command fails.
> >
> >   $ make O=3Dbuild-arch bindeb-pkg
> >     [ snip ]
> >   sed: can't read modules.order: No such file or directory
> >   make[6]: *** [../Makefile:1577: __modinst_pre] Error 2
> >   make[5]: *** [../scripts/Makefile.package:150: intdeb-pkg] Error 2
> >   make[4]: *** [../Makefile:1657: intdeb-pkg] Error 2
> >   make[3]: *** [debian/rules:14: binary-arch] Error 2
> >   dpkg-buildpackage: error: debian/rules binary subprocess returned exi=
t status 2
> >   make[2]: *** [../scripts/Makefile.package:139: bindeb-pkg] Error 2
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Applied to linux-kbuild.



>
> > ---
> >
> >  scripts/package/mkdebian | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> > index a4c2c2276223..b6cb95473548 100755
> > --- a/scripts/package/mkdebian
> > +++ b/scripts/package/mkdebian
> > @@ -269,6 +269,8 @@ cat <<EOF > debian/rules
> >  srctree ?=3D .
> >  KERNELRELEASE =3D ${KERNELRELEASE}
> >
> > +.PHONY: clean build build-arch build-indep binary binary-arch binary-i=
ndep
> > +
> >  build-indep:
> >  build-arch:
> >       \$(MAKE) -f \$(srctree)/Makefile ARCH=3D${ARCH} \
> > --
> > 2.37.2
> >



--=20
Best Regards
Masahiro Yamada
