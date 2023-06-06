Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F207240A8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjFFLQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjFFLQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:16:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3B99E;
        Tue,  6 Jun 2023 04:16:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5ADA630D1;
        Tue,  6 Jun 2023 11:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BC6C433EF;
        Tue,  6 Jun 2023 11:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686050188;
        bh=XDJDcGG80GlYg7+dAvlJOwWlcqLK2ncWi2uAinUamoI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t9e2AJPQXQcELAE9KjMTAO+tm3PE1gdlVv27bCdXctG2qXkUF+FcLw/tkQxZdIWTo
         5H6/7SGkYHpMceqiLaSu+zzRUhkjY0MEaa801AOBZEeH9LgzfFoWzTzRy9VOsmuxTG
         FRQaiAfHzP066yODhuVuoTsJly5ooae0cwEbUNKtmkcoIvtYba9EDlwEc9vLH6ek71
         Lw7bALBDlfprCxQH1LuRUVGrY/fQ8/0nkqbP86m4qvPoU8r+7Ru/S/kGfXiGe5TGCV
         fd/umzPR69pHsTDFI+WcA4uSvHS6nsIlVIV3p6fV0V0cMRBjcVosh0nIxTAu3IT6Pp
         TrfjWrTupMdww==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-38e04d1b2b4so5078038b6e.3;
        Tue, 06 Jun 2023 04:16:28 -0700 (PDT)
X-Gm-Message-State: AC+VfDxbfzigPtjFcZwaXEIFKNKfrfcYFGhd7lDfDEPzpNT9a3PDCYFr
        yi/IY9E4+hixWiIVokI102s3o+Nr8drvz3PWh6Q=
X-Google-Smtp-Source: ACHHUZ5AzTOXvCe2ai1WaPE5RKi81mi2f4whjeE9f64UvotlAvLs5QntMNj14nNH0Vy0ihztwr5YbNgNkp3J7FA2U5s=
X-Received: by 2002:aca:6548:0:b0:398:59fe:6ee3 with SMTP id
 j8-20020aca6548000000b0039859fe6ee3mr1967791oiw.54.1686050187288; Tue, 06 Jun
 2023 04:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230606105706.60807b85ff79.I21ab3b54eeebd638676bead3b2f87417944e44f3@changeid>
In-Reply-To: <20230606105706.60807b85ff79.I21ab3b54eeebd638676bead3b2f87417944e44f3@changeid>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 6 Jun 2023 20:15:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNASe+HWuufyANGJJ0dajzSC4LFy=x2N6erGis0+ZQkAAXA@mail.gmail.com>
Message-ID: <CAK7LNASe+HWuufyANGJJ0dajzSC4LFy=x2N6erGis0+ZQkAAXA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kernel-doc: don't let V=1 change outcome
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 5:57=E2=80=AFPM Johannes Berg <johannes@sipsolutions=
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
> ---
> v2: - parse environment variables in build system rather than
>       the script itself, as suggested by Masahiro Yamada
>     - fix indentation
> ---
>  scripts/Makefile.build |  7 ++++++-
>  scripts/kernel-doc     | 28 +++++++++++++++++++++++-----
>  2 files changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 9f94fc83f086..90bb5badb0e9 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -101,7 +101,12 @@ else ifeq ($(KBUILD_CHECKSRC),2)
>  endif
>
>  ifneq ($(KBUILD_EXTRA_WARN),)
> -  cmd_checkdoc =3D $(srctree)/scripts/kernel-doc -none $<
> +  cmd_checkdoc =3D $(srctree)/scripts/kernel-doc -none \
> +        $(if $(KDOC_WALL), -Wall) \
> +        $(if $(KDOC_WRETURN), -Wreturn) \
> +        $(if $(KDOC_WSHORT_DESC), -Wshort-desc) \
> +        $(if $(KDOC_WSHORT_DESC), -Wcontents-before-sections) \



Sorry, I misunderstood your intention.
(I just thought existing env variables would be moved to Makefile)


I do not want to proliferate env variables any more.

If you need per-flag control, maybe we can do like this?

cmd_checkdoc =3D $(srctree)/scripts/kernel-doc -none \
              $(KDOCFLAGS)


Then, users can do

  $ make KDOCFLAGS=3D-Wall
  $ make KDOCFLAGS=3D-Wreturn

etc.




> +        $<
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


--
Best Regards
Masahiro Yamada
