Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FC172A9FA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 09:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjFJHlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 03:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjFJHlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 03:41:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1250735B0;
        Sat, 10 Jun 2023 00:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A33AA61F98;
        Sat, 10 Jun 2023 07:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC58C433D2;
        Sat, 10 Jun 2023 07:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686382859;
        bh=tegrmW+RF/fLr2u5shywVhTl3/zyR2OKt3A1//gzzow=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gLIXttt8KC198yzm8yM81Yc1n42yz/DOiuFd3X8juGGHbG8zjkparVxfz6iEWjDYB
         +Kjr6l9IyGy+oJlkHffPjUwk7s1V/mFuFz7BNmJxVb+v5xuu6YL7r1q7BZgmZwm9kO
         EyHbZlx87/2gfKW6rsOnF4oQk2d/b+kZM5VtNdF1gnQZvFdK53WtIcndCJj73/+cGe
         xRdDCGq8I475ROh517KeC5Fn5Y0olZLgSo1NDaIyeRaO2RIzPL6L4gcHx7GGlKKctw
         yaHDSKI8P12erL5dxHMtZsmjFB9Uvud81BF2051r4A+9zoSi9BQCY6SNChYoYG+HxM
         cYrpQMy0tbg9Q==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-55b00ad09feso1636174eaf.1;
        Sat, 10 Jun 2023 00:40:58 -0700 (PDT)
X-Gm-Message-State: AC+VfDxqk1YTqEethtQdAb6fRZQKitqD507U2m9ectV75e+ukhbRTUMF
        4sfXkcndchso2gY/Fu9IEAvcNDh+YsVokhL/1Pg=
X-Google-Smtp-Source: ACHHUZ7xWKpq2ZS/gECP2QjGgi/q3dedEHrupXd5ppbdxs9IE2mocHXypdQC83bUEDG0mRZ65VjSK9fbLBvVYetWuks=
X-Received: by 2002:a05:6808:28d:b0:39a:bca0:3c28 with SMTP id
 z13-20020a056808028d00b0039abca03c28mr517136oic.57.1686382858216; Sat, 10 Jun
 2023 00:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230609104642.0a5f030f59a5.I21ab3b54eeebd638676bead3b2f87417944e44f3@changeid>
In-Reply-To: <20230609104642.0a5f030f59a5.I21ab3b54eeebd638676bead3b2f87417944e44f3@changeid>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 10 Jun 2023 16:40:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNARAbz1jxiojiOXQpYgh=nLqswtwz0aKroSd52fvt_c_Gg@mail.gmail.com>
Message-ID: <CAK7LNARAbz1jxiojiOXQpYgh=nLqswtwz0aKroSd52fvt_c_Gg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kernel-doc: don't let V=1 change outcome
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 5:46=E2=80=AFPM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> The kernel-doc script currently reports a number of issues
> only in "verbose" mode, but that's initialized from V=3D1
> (via KBUILD_VERBOSE), so if you use KDOC_WERROR=3D1 then
> adding V=3D1 might actually break the build. This is rather
> unexpected.
>
> Change kernel-doc to not change its behaviour wrt. errors
> (or warnings) when verbose mode is enabled, but rather add
> separate warning flags (and -Wall) for it. Allow enabling
> those flags via environment/make variables in the kernel's
> build system for easier user use, but to not have to parse
> them in the script itself.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>



Applied to linux-kbuild with Jon's Ack.
Thanks.




> ---
> v2: - parse environment variables in build system rather than
>       the script itself, as suggested by Masahiro Yamada
>     - fix indentation
> v3: - use a single KDOCFLAGS variable
> ---
>  Documentation/kbuild/kbuild.rst |  6 ++++++
>  scripts/Makefile.build          |  2 +-
>  scripts/kernel-doc              | 28 +++++++++++++++++++++++-----
>  3 files changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuil=
d.rst
> index 2a22ddb1b848..bd906407e307 100644
> --- a/Documentation/kbuild/kbuild.rst
> +++ b/Documentation/kbuild/kbuild.rst
> @@ -150,6 +150,12 @@ the UTS_MACHINE variable, and on some architectures =
also the kernel config.
>  The value of KBUILD_DEBARCH is assumed (not checked) to be a valid Debia=
n
>  architecture.
>
> +KDOCFLAGS
> +---------
> +Specify extra (warning/error) flags for kernel-doc checks during the bui=
ld,
> +see scripts/kernel-doc for which flags are supported. Note that this doe=
sn't
> +(currently) apply to documentation builds.
> +
>  ARCH
>  ----
>  Set ARCH to the architecture to be built.
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 9f94fc83f086..a0b4fb58201c 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -101,7 +101,7 @@ else ifeq ($(KBUILD_CHECKSRC),2)
>  endif
>
>  ifneq ($(KBUILD_EXTRA_WARN),)
> -  cmd_checkdoc =3D $(srctree)/scripts/kernel-doc -none $<
> +  cmd_checkdoc =3D $(srctree)/scripts/kernel-doc -none $(KDOCFLAGS) $<
>  endif
>
>  # Compile C sources (.c)
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 2486689ffc7b..8f8440870a0f 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -23,7 +23,7 @@ kernel-doc - Print formatted kernel documentation to st=
dout
>
>  =3Dhead1 SYNOPSIS
>
> - kernel-doc [-h] [-v] [-Werror]
> + kernel-doc [-h] [-v] [-Werror] [-Wall] [-Wreturn] [-Wshort-description]=
 [-Wcontents-before-sections]
>     [ -man |
>       -rst [-sphinx-version VERSION] [-enable-lineno] |
>       -none
> @@ -133,6 +133,9 @@ my $dohighlight =3D "";
>
>  my $verbose =3D 0;
>  my $Werror =3D 0;
> +my $Wreturn =3D 0;
> +my $Wshort_desc =3D 0;
> +my $Wcontents_before_sections =3D 0;
>  my $output_mode =3D "rst";
>  my $output_preformatted =3D 0;
>  my $no_doc_sections =3D 0;
> @@ -187,9 +190,14 @@ if (defined($ENV{'KCFLAGS'})) {
>         }
>  }
>
> +# reading this variable is for backwards compat just in case
> +# someone was calling it with the variable from outside the
> +# kernel's build system
>  if (defined($ENV{'KDOC_WERROR'})) {
>         $Werror =3D "$ENV{'KDOC_WERROR'}";
>  }
> +# other environment variables are converted to command-line
> +# arguments in cmd_checkdoc in the build system
>
>  # Generated docbook code is inserted in a template at a point where
>  # docbook v3.1 requires a non-zero sequence of RefEntry's; see:
> @@ -318,6 +326,16 @@ while ($ARGV[0] =3D~ m/^--?(.*)/) {
>         $verbose =3D 1;
>      } elsif ($cmd eq "Werror") {
>         $Werror =3D 1;
> +    } elsif ($cmd eq "Wreturn") {
> +       $Wreturn =3D 1;
> +    } elsif ($cmd eq "Wshort-desc") {
> +       $Wshort_desc =3D 1;
> +    } elsif ($cmd eq "Wcontents-before-sections") {
> +       $Wcontents_before_sections =3D 1;
> +    } elsif ($cmd eq "Wall") {
> +        $Wreturn =3D 1;
> +        $Wshort_desc =3D 1;
> +        $Wcontents_before_sections =3D 1;
>      } elsif (($cmd eq "h") || ($cmd eq "help")) {
>                 pod2usage(-exitval =3D> 0, -verbose =3D> 2);
>      } elsif ($cmd eq 'no-doc-sections') {
> @@ -1748,9 +1766,9 @@ sub dump_function($$) {
>      # This check emits a lot of warnings at the moment, because many
>      # functions don't have a 'Return' doc section. So until the number
>      # of warnings goes sufficiently down, the check is only performed in
> -    # verbose mode.
> +    # -Wreturn mode.
>      # TODO: always perform the check.
> -    if ($verbose && !$noret) {
> +    if ($Wreturn && !$noret) {
>             check_return_section($file, $declaration_name, $return_type);
>      }
>
> @@ -2054,7 +2072,7 @@ sub process_name($$) {
>             $state =3D STATE_NORMAL;
>         }
>
> -       if (($declaration_purpose eq "") && $verbose) {
> +       if (($declaration_purpose eq "") && $Wshort_desc) {
>             emit_warning("${file}:$.", "missing initial short description=
 on line:\n$_");
>         }
>
> @@ -2103,7 +2121,7 @@ sub process_body($$) {
>         }
>
>         if (($contents ne "") && ($contents ne "\n")) {
> -           if (!$in_doc_sect && $verbose) {
> +           if (!$in_doc_sect && $Wcontents_before_sections) {
>                 emit_warning("${file}:$.", "contents before sections\n");
>             }
>             dump_section($file, $section, $contents);
> --
> 2.40.1
>


--=20
Best Regards
Masahiro Yamada
