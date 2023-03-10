Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6427E6B45EF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjCJOjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjCJOin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:38:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D45591F6;
        Fri, 10 Mar 2023 06:38:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C66EB822E6;
        Fri, 10 Mar 2023 14:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D375DC433A7;
        Fri, 10 Mar 2023 14:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678459080;
        bh=vapC+EIa/mZr6VuhbqnVcKjFD/05NucbmdXBmu2bpFw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bWKAQLzeij0wAuh7QpUEPXONEXiPT+SIV3TCbwxX69Y/DTFS8OLhS1p/deCGMQGEn
         TmyqeQIW2sNIyABLcmedX/UHMh9i3hzpl/Id0n6mvT9METgrkkPFmUvGw5Bz6hbKEg
         cLoQVGAUljaCHhk73XJZAAUWdIy0nVKP0TRCudZQ7Ipj+GlxUxGlLLKJvO37nf+hZW
         R5L3pVsSCqELqcgdSuNQPR/yvw4zJAQXD3xBeOJ52Z38ifp5KQithEltfyvkpxkrT+
         n782YsDWwxHtq/XezEcUr9tT4MmhMzK9mnCWdUjnYHRX1O5MO+YVZ5V52wnLeDSDMH
         nrsA/s8qIRGjA==
Received: by mail-lf1-f46.google.com with SMTP id g17so6889999lfv.4;
        Fri, 10 Mar 2023 06:38:00 -0800 (PST)
X-Gm-Message-State: AO0yUKWNSNpgUUuq9YxDNIhgavfpVbmBr3KEZYyMjX0bs0o7zhdhrN5G
        XIltq+AkDPv9aGhPQmoYpafLii4677WkCTFAZT4=
X-Google-Smtp-Source: AK7set/IauEBhrjovg4oAyTeT9IXXjukFGMHNL8r27ZxV1eEnqXaA1PZTMrvVcn+0VZZ7Ui8FH1Rt1uiijJL7EMP8Jk=
X-Received: by 2002:ac2:46db:0:b0:4db:38ba:618d with SMTP id
 p27-20020ac246db000000b004db38ba618dmr7850269lfo.12.1678459079193; Fri, 10
 Mar 2023 06:37:59 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNASjiAB93mu0igQsiwgu=zrgu3gArMJZ+6CXHuJ+kG_ELg@mail.gmail.com>
 <20230307112028.14190-1-bage@linutronix.de> <20230307112028.14190-2-bage@linutronix.de>
In-Reply-To: <20230307112028.14190-2-bage@linutronix.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 10 Mar 2023 23:37:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNASJeECGBiaWNjdhDbnBP3-8TKUOCXXbmbu8C9+Qa4FDxg@mail.gmail.com>
Message-ID: <CAK7LNASJeECGBiaWNjdhDbnBP3-8TKUOCXXbmbu8C9+Qa4FDxg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] kbuild: deb-pkg: default dpkg-buildpackage --build
To:     Bastian Germann <bage@linutronix.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Mar 7, 2023 at 8:20=E2=80=AFPM Bastian Germann <bage@linutronix.de>=
 wrote:
>
> deb-pkg's dpkg-buildpackage invocation was added --build=3Dsource,binary
> recently. Before, it relied on the default, which is the same, so it
> no difference for the built packages.
>
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



I applied this, then dropped it.

This patch is wrong.


If this patch is applied, 'make deb-pkg'
would not produce the source package at all.


Now I recalled the reason why I added this.



dpkg-buildpackage(1):

 full
     Builds everything.  This is an alias for source,any,all, and the
     same as the default case when no build option is specified.
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


NACK





--
Best Regards
Masahiro Yamada
