Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC2F6AD59E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 04:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCGDVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 22:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjCGDVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 22:21:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127984D288;
        Mon,  6 Mar 2023 19:21:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7841D611D6;
        Tue,  7 Mar 2023 03:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6C9C433D2;
        Tue,  7 Mar 2023 03:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678159297;
        bh=NVWgD7aFXujXu7eEUoaNZK6PuCiU87JxjbqI4Lm93A8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X7sVVNKC7HiLCVeX1mpJR297LGcfNYe9H5F7tZ37epbZKwS5GmuZEVoJrW+ifEdef
         n9jemjBH2Lkd1Xbce9EJEPvGipfX0FfKUcsH0+Bs6MIKmZsCqtIru++fgMozMBADVa
         S+o2cV9u/vbWMFkpMNmRrZfWVwmq24DhdsiqC3A7Ju45h7MBQKJglK31Vx/jcZioJT
         kfscz9l06riZkS4kTdKDK39k37k1taULm6SmRHHpiCdjxzIIYzrYSFy8NNTW3ZIJ6c
         8JWq1RCeQ0IEk1LJc1rfIC6Fi/hRL1c0UeymdQwDEXxxGgdJ4iXUioQ/9sloJqqqiQ
         VVumtwhQ3+Gww==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-176b90e14a9so6186570fac.9;
        Mon, 06 Mar 2023 19:21:37 -0800 (PST)
X-Gm-Message-State: AO0yUKUsn76Z9AfVSG+WJrpBIgk2A407s223BnbhWWK74ammJT6uwcK8
        5qmuf8mp14tHB0ZDP054HDqP1thCkVOml5YBJlk=
X-Google-Smtp-Source: AK7set/Qf8fCMizgzBV6L0aw8HE6nxThKei/zMSFQcMSytpehDxWqkC38Riq6oawPUBiz/kK9Z332YEpozJfSwf3vlE=
X-Received: by 2002:a05:6871:6a81:b0:176:3e60:3269 with SMTP id
 zf1-20020a0568716a8100b001763e603269mr4455683oab.8.1678159297130; Mon, 06 Mar
 2023 19:21:37 -0800 (PST)
MIME-Version: 1.0
References: <20230305232536.19528-1-bage@linutronix.de> <20230305232536.19528-2-bage@linutronix.de>
In-Reply-To: <20230305232536.19528-2-bage@linutronix.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 7 Mar 2023 12:21:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNARnkOyusNFZsE9Hj9cg=TWJtv1By8e4UPCso92Wn=jgEQ@mail.gmail.com>
Message-ID: <CAK7LNARnkOyusNFZsE9Hj9cg=TWJtv1By8e4UPCso92Wn=jgEQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] kbuild: deb-pkg: default dpkg-buildpackage --build
To:     Bastian Germann <bage@linutronix.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 8:25=E2=80=AFAM Bastian Germann <bage@linutronix.de>=
 wrote:
>
> deb-pkg's dpkg-buildpackage invocation was added --build=3Dsource,binary
> recently. Before, it relied on the default, which is
> --build=3Dsource,binary,all and makes no difference for the built package=
s
> as there is no "Arch: all" package.


Is this paragraph true?

--build=3Dsource,binary,all sounds strange because
'all' is contained in 'binary'.



According to dpkb-buildpackage(1),

 binary =3D any,all

 full =3D source,binary =3D source,any,all  (default)


--build=3Dsource,binary would build everything
even if there were 'Arch: all'.





The code change is fine.
My plan was to use --build=3Dsource,binary later,
but I could not finish the entire work in the last cycle.




> However, the explicit --build eliminates overriding it via DPKG_FLAGS,
> which used to fill the gap of generating only a source package without
> building it.
>
> Recover the old, default behavior.
>
> Fixes: 7bf4582d7aad ("kbuild: deb-pkg: create source package without clea=
ning")
> Signed-off-by: Bastian Germann <bage@linutronix.de>
> ---
>  scripts/Makefile.package | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index b941e6341b36..fe1721915a59 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -120,7 +120,7 @@ debian-orig: linux.tar.gz debian
>  PHONY +=3D deb-pkg
>  deb-pkg: debian-orig
>         +dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) =
$(DPKG_FLAGS) \
> -               --build=3Dsource,binary -nc -us -uc
> +               -nc -us -uc
>
>  PHONY +=3D bindeb-pkg
>  bindeb-pkg: debian
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada
