Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F53725368
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjFGFff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjFGFfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:35:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEE419AA;
        Tue,  6 Jun 2023 22:35:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 587E263A7E;
        Wed,  7 Jun 2023 05:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE690C4339B;
        Wed,  7 Jun 2023 05:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686116129;
        bh=Cz6SN9RqMOYGdXRwEOaCy8og6z2MAlsLW1X6BHhj7Po=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iffVS97yvnPbpmyAy2RM3CWZxmNLo5G5w7pGFJoMEIPUZ4w1sDhoRUWWm5HsJXkle
         zGKMDj6pIxJfjTEcrMWpxDAPv5EJhI4ORo3ExYPEWrTDRmSRZIgazHvYbGPcncOsO1
         PcFFovHEi0Enmp939K2vAM6FiIMq5RkeWTX0IeUClxCGpLi9PEs6SZpi0vQktcLD/T
         UejWv9HwtAAup/9nv2w7Ce5eNovL3RvmYiyn5qI6qcvccObKsy5whOlE0PBKy1X6j5
         1F10RgviaA2FkHYyVSyV6EE/+yfW5/oybYuyVLLLaHqTcbc03pAKSQ2t2neTcCI0q6
         0+IsyN7K0EyFA==
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-3f6b2f1a04bso76112911cf.3;
        Tue, 06 Jun 2023 22:35:29 -0700 (PDT)
X-Gm-Message-State: AC+VfDxYIGtwEEeIxfIEOpBtT67vFANZ/hZNuuu7rCWUaZeEnPiEYYGP
        LLJZZArHKSt04QYaVJc4TFqSbtsuYyHQ7C6WDTs=
X-Google-Smtp-Source: ACHHUZ5N2NVlLFhA5RdZQejj9p52u6cl/vh/nT4XCbBGO87ObfbjU9pCUSlzISB0RpYz/z2MwfFGkPthnYo9SUe1s2w=
X-Received: by 2002:a05:622a:1355:b0:3f5:c9f:1b27 with SMTP id
 w21-20020a05622a135500b003f50c9f1b27mr2533009qtk.1.1686116128847; Tue, 06 Jun
 2023 22:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230606061741.69755-1-bgray@linux.ibm.com>
In-Reply-To: <20230606061741.69755-1-bgray@linux.ibm.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 7 Jun 2023 14:34:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQfLO5tueB2d6WsyWC=cLwiONo13+MLKFO0sSt57aTw-A@mail.gmail.com>
Message-ID: <CAK7LNAQfLO5tueB2d6WsyWC=cLwiONo13+MLKFO0sSt57aTw-A@mail.gmail.com>
Subject: Re: [PATCH v2] initramfs: Encode dependency on KBUILD_BUILD_TIMESTAMP
To:     Benjamin Gray <bgray@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Andrew Donnellan <ajd@linux.ibm.com>
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

On Tue, Jun 6, 2023 at 3:18=E2=80=AFPM Benjamin Gray <bgray@linux.ibm.com> =
wrote:
>
> gen_initramfs.sh has an internal dependency on KBUILD_BUILD_TIMESTAMP
> for generating file mtimes that is not exposed to make, so changing
> KBUILD_BUILD_TIMESTAMP will not trigger a rebuild of the archive.
>
> Declare the mtime date as a new parameter to gen_initramfs.sh to encode
> KBUILD_BUILD_TIMESTAMP in the shell command, thereby making make aware
> of the dependency.
>
> It will rebuild if KBUILD_BUILD_TIMESTAMP changes or is newly set/unset.
> It will _not_ rebuild if KBUILD_BUILD_TIMESTAMP is unset before and
> after. This should be fine for anyone who doesn't care about setting
> specific build times in the first place.
>
> Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
> Tested-by: Andrew Donnellan <ajd@linux.ibm.com>
> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
>
> ---


Applied to linux-kbuild. Thanks.




> v2: Remove redundant comment, quote argument to shell script
> ---
>  usr/Makefile         |  1 +
>  usr/gen_initramfs.sh | 16 +++++++++-------
>  2 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/usr/Makefile b/usr/Makefile
> index 59d9e8b07a01..f8e1ad19e05c 100644
> --- a/usr/Makefile
> +++ b/usr/Makefile
> @@ -64,6 +64,7 @@ quiet_cmd_initfs =3D GEN     $@
>         $(CONFIG_SHELL) $< -o $@ -l $(obj)/.initramfs_data.cpio.d \
>         $(if $(CONFIG_INITRAMFS_ROOT_UID), -u $(CONFIG_INITRAMFS_ROOT_UID=
)) \
>         $(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_GID=
)) \
> +       $(if $(KBUILD_BUILD_TIMESTAMP), -d "$(KBUILD_BUILD_TIMESTAMP)") \
>         $(ramfs-input)
>
>  # We rebuild initramfs_data.cpio if:
> diff --git a/usr/gen_initramfs.sh b/usr/gen_initramfs.sh
> index 63476bb70b41..14b5782f961a 100755
> --- a/usr/gen_initramfs.sh
> +++ b/usr/gen_initramfs.sh
> @@ -23,6 +23,7 @@ $0 [-o <file>] [-l <dep_list>] [-u <uid>] [-g <gid>] {-=
d | <cpio_source>} ...
>         -g <gid>       Group ID to map to group ID 0 (root).
>                        <gid> is only meaningful if <cpio_source> is a
>                        directory.  "squash" forces all files to gid 0.
> +       -d <date>      Use date for all file mtime values
>         <cpio_source>  File list or directory for cpio archive.
>                        If <cpio_source> is a .cpio file it will be used
>                        as direct input to initramfs.
> @@ -190,6 +191,7 @@ prog=3D$0
>  root_uid=3D0
>  root_gid=3D0
>  dep_list=3D
> +timestamp=3D
>  cpio_list=3D$(mktemp ${TMPDIR:-/tmp}/cpiolist.XXXXXX)
>  output=3D"/dev/stdout"
>
> @@ -218,6 +220,13 @@ while [ $# -gt 0 ]; do
>                         [ "$root_gid" =3D "-1" ] && root_gid=3D$(id -g ||=
 echo 0)
>                         shift
>                         ;;
> +               "-d")   # date for file mtimes
> +                       timestamp=3D"$(date -d"$1" +%s || :)"
> +                       if test -n "$timestamp"; then
> +                               timestamp=3D"-t $timestamp"
> +                       fi
> +                       shift
> +                       ;;
>                 "-h")
>                         usage
>                         exit 0
> @@ -237,11 +246,4 @@ done
>
>  # If output_file is set we will generate cpio archive
>  # we are careful to delete tmp files
> -timestamp=3D
> -if test -n "$KBUILD_BUILD_TIMESTAMP"; then
> -       timestamp=3D"$(date -d"$KBUILD_BUILD_TIMESTAMP" +%s || :)"
> -       if test -n "$timestamp"; then
> -               timestamp=3D"-t $timestamp"
> -       fi
> -fi
>  usr/gen_init_cpio $timestamp $cpio_list > $output
> --
> 2.40.1
>


--=20
Best Regards
Masahiro Yamada
