Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9DE5F0700
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiI3JBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiI3JBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:01:20 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7203135058;
        Fri, 30 Sep 2022 02:01:18 -0700 (PDT)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 28U90tcu029720;
        Fri, 30 Sep 2022 18:00:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 28U90tcu029720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664528456;
        bh=PMDB3JvvC9iXMc1tjF7wmm3kug78wzmW2BYEeDumeM0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tqg1WkeSLYxBHE/Cacr9jv4CiDKZYShtaPNaAsMP+c5lfugtpHADC2Msl5lpb8DL8
         rh6LiAp2N++/Hr+EBxQbICIG4fY1mGfpsOg2tJtOgBVgzlfqQkV6mgfsXaw3/m//MM
         A85QVXkTSsDWGJFUaCjwogkcif8jfiNo/30jrOMkUdng/7sWmdOPBKfgsxbOYZfLHC
         CZNDJ9HRNjq8O/OJxApkk3SVyJDMhgaouvqfAxvgtjGXRcDzNnaf/zi9h7uh6VUrp1
         y6Mr+Mxn99wovILgf22xz+648wa+HNC27QtDHgN9drfz4x3dNFwfRq7J9itPt6Zf1V
         zPx3uaoI059fA==
X-Nifty-SrcIP: [209.85.160.49]
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1280590722dso4762592fac.1;
        Fri, 30 Sep 2022 02:00:56 -0700 (PDT)
X-Gm-Message-State: ACrzQf3+UmHti9qjEVqJ3wb/rGUkIpk5Y3Y2A+6jtrthy3wPXFt+MNst
        X5hSnbm1IOhe1dKT/g+DT2avz852MJP0AulpX94=
X-Google-Smtp-Source: AMsMyM5qlsM7xqjeZO6xc67j0rGtoUvWdplHf4+Z6//zz/S7s78h7y9ZdRN/hkzZcxLtO+78OKb+hi5E6aQZudWqFzw=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr4154153oab.287.1664528455237; Fri, 30
 Sep 2022 02:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220930085351.2648034-1-masahiroy@kernel.org>
In-Reply-To: <20220930085351.2648034-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 30 Sep 2022 18:00:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNARdkP-QM83Le3Uyvfwv1=FgR06pGzyjwixGrjzOLqz0Jg@mail.gmail.com>
Message-ID: <CAK7LNARdkP-QM83Le3Uyvfwv1=FgR06pGzyjwixGrjzOLqz0Jg@mail.gmail.com>
Subject: Re: [PATCH] Kconfig.debug: split debug-level and DWARF-version into
 separate choices
To:     linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Fri, Sep 30, 2022 at 5:55 PM Masahiro Yamada <masahiroy@kernel.org> wrot=
e:
>
> Commit f9b3cd245784 ("Kconfig.debug: make DEBUG_INFO selectable from
> a choice") added CONFIG_DEBUG_INFO_NONE into the DWARF version choice,
> but it should rather belong to the debug level choice.
>
> This commit cosolidates CONFIG options into two choices:
>
>  - Debug info level (NONE / REDUCED / DEFAULT)
>
>  - DWARF format (DWARF_TOOLCHAIN_DEFAULT / DWARF4 / DWARF5)
>
> This is more consistent with compilers' policy because the -g0 compiler
> flag means "no debug info".
>
>   GCC manual:
>
>     -g<level>
>
>       Request debugging information and also use level to specify how
>       much information. The default level is 2.
>
>       Level 0 produces no debug information at all. Thus, -g0 negates -g.
>
>       Level 1 produces minimal information, enough for making backtraces
>       in parts of the program that you don=E2=80=99t plan to debug. This =
includes
>       descriptions of functions and external variables, and line number
>       tables, but no information about local variables.
>
>       Level 3 includes extra information, such as all the macro
>       definitions present in the program. Some debuggers support macro
>       expansion when you use -g3.
>
>   Rustc Codegen manual:
>
>     debuginfo
>
>       This flag controls the generation of debug information. It takes
>       one of the following values:
>
>       0: no debug info at all (the default).
>       1: line tables only.
>       2: full debug info.
>
> I moved CONFIG_DEBUG_INFO_REDUCED into the debug level choice.
>
> This change will make it easier to add another debug info level if
> necessary.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  lib/Kconfig.debug | 60 +++++++++++++++++++++++++++++------------------
>  1 file changed, 37 insertions(+), 23 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d3e5f36bb01e..03e75a54be6c 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -232,17 +232,11 @@ config DEBUG_INFO
>           information will be generated for build targets.
>
>  choice
> -       prompt "Debug information"
> +       prompt "Debug information level"
>         depends on DEBUG_KERNEL
>         help
>           Selecting something other than "None" results in a kernel image
>           that will include debugging info resulting in a larger kernel i=
mage.
> -         This adds debug symbols to the kernel and modules (gcc -g), and
> -         is needed if you intend to use kernel crashdump or binary objec=
t
> -         tools like crash, kgdb, LKCD, gdb, etc on the kernel.
> -
> -         Choose which version of DWARF debug info to emit. If unsure,
> -         select "Toolchain default".
>
>  config DEBUG_INFO_NONE
>         bool "Disable debug information"
> @@ -250,9 +244,41 @@ config DEBUG_INFO_NONE
>           Do not build the kernel with debugging information, which will
>           result in a faster and smaller build.
>
> +config DEBUG_INFO_REDUCED
> +       bool "Reduced debugging information"
> +       select DEBUG_INFO
> +       help
> +         If you say Y here compiler is instructed to generate less debug=
ging
> +         information for structure types. This means that tools that
> +         need full debugging information (like kgdb or systemtap) won't
> +         be happy. But if you merely need debugging information to
> +         resolve line numbers there is no loss. Advantage is that
> +         build directory object sizes shrink dramatically over a full
> +         DEBUG_INFO build and compile times are reduced too.
> +         Only works with newer gcc versions.
> +
> +config DEBUG_INFO_DEFAULT
> +       bool "Default-level debugging information"
> +       select DEBUG_INFO
> +       help
> +         If you say Y here compiler is instructed to generate the defaul=
t
> +         level of debugging information.
> +
> +         This adds debug symbols to the kernel and modules (gcc -g), and
> +         is needed if you intend to use kernel crashdump or binary objec=
t
> +         tools like crash, kgdb, LKCD, gdb, etc on the kernel.
> +
> +endchoice # "Debug information level"
> +
> +choice
> +       prompt "DWARF version"
> +       depends on DEBUG_INFO
> +       prompt "DWARF version"



Nit.
The same prompt appears twice.
I will drop one.










--=20
Best Regards
Masahiro Yamada
