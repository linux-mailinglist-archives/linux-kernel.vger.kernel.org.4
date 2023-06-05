Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AFF721B46
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 02:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjFEAhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 20:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjFEAhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 20:37:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EA1CD;
        Sun,  4 Jun 2023 17:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75B3D61CB8;
        Mon,  5 Jun 2023 00:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA34AC433EF;
        Mon,  5 Jun 2023 00:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685925427;
        bh=8ViOZ/67sFC1dwMBsTpVWnyzKQ+Cxx+t5f/lBwak1P0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VuknoifnPM3Ny8uuPvhWMe3iKC6lE+/ud3dTUXPfJKlxcw4v2UEumVfUd9jW7w/bS
         XNPBYMbEOkU8x57jN72rmSTW15i++Wte5y5W6MiCp9E/1/QlPTEHx/H9anIn0o7UCL
         NICepO4JqRrXVkRPvIu3Fba39mWJMpsHNdP+UxNeiL8xmxa/6z5S/U6sX7Qg6AY0gt
         MYITBJLuL6GjitrIYz6L6ADIkD81sI3GoL5VKvtKsbuFORWmFnh9Cf64ViBvhwsVxy
         SOVU87WTtXLV0n5wt5LnOlq0HBNwEcF8hnTuUH2rDyn4ER/ruYlKdVOJz7bNJoWPnT
         JEt5j/czJTwIg==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-558c8a109bdso372805eaf.1;
        Sun, 04 Jun 2023 17:37:07 -0700 (PDT)
X-Gm-Message-State: AC+VfDyZgiIrfLbjztRSAGL+SwgtnzCBFoILhCuqdZyES/7UWP9oshu1
        wq3Jo0u4bszernGO2oHsnMK+JRn/ZBm/x7jFBg4=
X-Google-Smtp-Source: ACHHUZ7Jm7elrU5npuF1QxqdtBRteBO0IRNznr6jV6ddUwArpX9BkikZ+hfd26MESp8Llek/+jq5zcQT/c7HnabSCGQ=
X-Received: by 2002:a4a:b3cb:0:b0:54f:4e01:7fc9 with SMTP id
 q11-20020a4ab3cb000000b0054f4e017fc9mr5073688ooo.3.1685925427055; Sun, 04 Jun
 2023 17:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230602230014.a435aab03cee.I21ab3b54eeebd638676bead3b2f87417944e44f3@changeid>
In-Reply-To: <20230602230014.a435aab03cee.I21ab3b54eeebd638676bead3b2f87417944e44f3@changeid>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 5 Jun 2023 09:36:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ87U202fgqkd5T9G82h4F6sNOMW2=vH1HmgAoVA48CMw@mail.gmail.com>
Message-ID: <CAK7LNAQ87U202fgqkd5T9G82h4F6sNOMW2=vH1HmgAoVA48CMw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernel-doc: don't let V=1 change outcome
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 3, 2023 at 6:00=E2=80=AFAM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> The kernel-doc script currently reports a number of issues
> only in "verbose" mode, but that's initialized from V=3D1
> (via KBUILD_VERBOSE), so if you use KDOC_WERROR=3D1 then
> adding V=3D1 might actually break the build. This is rather
> unexpected.

Agree.


>
> Change kernel-doc to not change its behaviour wrt. errors
> (or warnings) when verbose mode is enabled, but rather add
> separate warning flags (and -Wall) for it.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  scripts/kernel-doc | 41 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 2486689ffc7b..1eb1819fbe13 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -23,7 +23,7 @@ kernel-doc - Print formatted kernel documentation to st=
dout
>
>  =3Dhead1 SYNOPSIS
>
> - kernel-doc [-h] [-v] [-Werror]
> + kernel-doc [-h] [-v] [-Werror] [-Wreturn] [-Wshort-description] [-Wcont=
ents-before-sections] [-Wall]
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
> @@ -191,6 +194,24 @@ if (defined($ENV{'KDOC_WERROR'})) {
>         $Werror =3D "$ENV{'KDOC_WERROR'}";
>  }
>
> +if (defined($ENV{'KDOC_WRETURN'})) {
> +       $Wreturn =3D "$ENV{'KDOC_WRETURN'}";
> +}
> +
> +if (defined($ENV{'KDOC_WSHORT_DESC'})) {
> +       $Wshort_desc =3D "$ENV{'KDOC_WSHORT_DESC'}";
> +}
> +
> +if (defined($ENV{'KDOC_WCONTENTS_BEFORE_SECTION'})) {
> +       $Wcontents_before_sections =3D "$ENV{'KDOC_WCONTENTS_BEFORE_SECTI=
ON'}";
> +}
> +
> +if (defined($ENV{'KDOC_WALL'})) {
> +       $Wreturn =3D "$ENV{'KDOC_WALL'}";
> +       $Wshort_desc =3D "$ENV{'KDOC_WALL'}";
> +       $Wcontents_before_sections =3D "$ENV{'KDOC_WALL'}";
> +}



Adding an environment variable to each of them is tedious.


If you enable -Wall via the command line option,
these lines are unneeded?

For example,

ifneq ($(KBUILD_EXTRA_WARN),)
  cmd_checkdoc =3D $(srctree)/scripts/kernel-doc -none \
         $(if $(findstring 2, $(KBUILD_EXTRA_WARN)), -Wall) $<
endif







--=20
Best Regards
Masahiro Yamada
