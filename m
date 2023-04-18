Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB096E5651
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 03:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjDRBS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 21:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDRBS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:18:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E444EF5;
        Mon, 17 Apr 2023 18:18:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88E1D62651;
        Tue, 18 Apr 2023 01:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E970DC4339B;
        Tue, 18 Apr 2023 01:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681780699;
        bh=yxqXE0xqSqAG3ZtCTAIanNNrObebqPlfP+3p3fGfGnE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=un3oyaP3y9vegmHuygUsbH1JC7Po6YstpBYUVdjiF5HnIkOzkYzN8K+JsvLlgz9Zm
         KCYsw7PgcZrHTHNm7FSiadlvUx4rzwZA4cJ8c3DBnHeoatMRF69dSXUD8PmnBVjs5z
         DSus/9KP8/WTH3XtEoQOQvnS2Zk0F8lB35+v8xKQ8WN8oLmc/0gY/4Z6S1bNnsspBP
         8e9n58+r3T1THM+X3FKM8h+IUGtAAQ54YpinkjFLMcxqloCwdMuBEI6AKgEksGgW2l
         m8cai/ddbxY2YlN/BJwAX6/Q/SuiXbdldp/uUi07m7Kik3VwOt/cLCguB5qFFS9UCL
         46lhdE+Sx7ubA==
Received: by mail-oo1-f49.google.com with SMTP id bg38-20020a056820082600b005421db6ed5bso2222793oob.12;
        Mon, 17 Apr 2023 18:18:19 -0700 (PDT)
X-Gm-Message-State: AAQBX9fhBlGbdf0grucht0rI9CeNJskj1Vv2Bfz3OM47njGuLXLSezvU
        nYmLg7VIUIGRi9/zqRxr9vSyBPlHJCJdl7c3nh4=
X-Google-Smtp-Source: AKy350ZACWFaxxKz9OQtqzz782v2Gaou4+ityrNLzAB1WuooTCi9ec4TcrzXQFpk8aBwVheHjN09N/tFJLbbtQJMPZ8=
X-Received: by 2002:a4a:e9b2:0:b0:541:fdc8:7a3d with SMTP id
 t18-20020a4ae9b2000000b00541fdc87a3dmr5013245ood.1.1681780699209; Mon, 17 Apr
 2023 18:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230417142548.249610-1-masahiroy@kernel.org> <3a857172b78f1bbd6427600bdd5afa81dd21c73f.camel@decadent.org.uk>
In-Reply-To: <3a857172b78f1bbd6427600bdd5afa81dd21c73f.camel@decadent.org.uk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 18 Apr 2023 10:17:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNARnd=Jryg80NeRddYvHqHGTrzES0T5YNSAKShz3D_JGdw@mail.gmail.com>
Message-ID: <CAK7LNARnd=Jryg80NeRddYvHqHGTrzES0T5YNSAKShz3D_JGdw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: add srcdeb-pkg target
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bastian Germann <bage@linutronix.de>,
        Nicolas Schier <nicolas@fjasle.eu>,
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

On Mon, Apr 17, 2023 at 11:52=E2=80=AFPM Ben Hutchings <ben@decadent.org.uk=
> wrote:
>
> On Mon, 2023-04-17 at 23:25 +0900, Masahiro Yamada wrote:
> > This new target builds only the debian source package.
> >
> > Unify the build rules of deb-pkg, srcdeb-pkg, bindeb-pkg to avoid
> > code duplication.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
> > ---
> [...]
> >  bindeb-pkg: debian
> > -     +dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) =
$(DPKG_FLAGS) -b -nc -uc
> > +deb-pkg srcdeb-pkg bindeb-pkg:
> > +     +$(strip dpkg-buildpackage \
> > +     --build=3D$(build-type) --no-pre-clean --unsigned-changes \
> > +     $(if $(findstring source, $(build-type)), \
> > +             --unsigned-source) \
> > +     $(if $(findstring binary, $(build-type)), \
> > +             -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch), \
> > +             --no-check-builddeps) \
> [...]
>
> There is no need to make the use of --unsigned-source (-us) or -r
> conditional on the build type.  They will be ignored if not applicable.



True, but you can also say there is no need
to pass options that we know are unnecessary.


My motivation is to make unneeded options
really don't-care.



2/2 will add KDEB_SOURCE_COMPRESS.

If I do not make it optional,
"KDEB_SOURCE_COMPRESS=3Dfoo make bindeb-pkg"
would fail.




dpkg-buildpackage --build=3Dbinary --no-pre-clean --unsigned-changes
--unsigned-source --compression=3Dfoo -r'fakeroot -u' -a$(cat
debian/arch)
dpkg-buildpackage: info: source package linux-upstream
dpkg-buildpackage: info: source version 6.3.0-rc7-00003-geb58366b57fe-33
dpkg-buildpackage: info: source distribution kinetic
dpkg-buildpackage: info: source changed by Masahiro Yamada
<masahiro.yamada@canonical.com>
dpkg-buildpackage: info: host architecture amd64
 dpkg-source --compression=3Dfoo --before-build .
dpkg-source: error: foo is not a supported compression

Use --help for program usage information.





"dpkg-buildpackage --build=3Dbinary" does not
generate a source package, but still checks
if --compression=3Dfoo is correct.



> This is also adding --no-check-builddeps (-d), which is not explained
> in the commit message.  It might be valid to add this for srcdeb-pkg,
> but the build dependency check is valuable for bindeb-pkg and deb-pkg.


Yes.
So, I added --no-check-builddeps to the else arm.



I will add the following commit description:


--no-check-builddeps is added to srcbin-pkg
so that build dependencies will not be checked.





>
> Ben.
>
> --
> Ben Hutchings
> Sturgeon's Law: Ninety percent of everything is crap.



--=20
Best Regards
Masahiro Yamada
