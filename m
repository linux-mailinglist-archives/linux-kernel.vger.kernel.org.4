Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A466C4D74
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjCVOW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjCVOWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:22:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B62C52920;
        Wed, 22 Mar 2023 07:21:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 128C4620FE;
        Wed, 22 Mar 2023 14:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77180C433A0;
        Wed, 22 Mar 2023 14:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679494917;
        bh=0aiD5bb+XDPSulptOsfFz6gzTu0h2IJzmzovRMJNE/s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PwlH5xurS2zAuT0Qbi3+r/DwoqbbuK/B3NVv9y6rFSiRtaWDWhQrlFcIKev+VNM9o
         lhu1PaTLjY+Zy5uyq4HrlP4kazhZlBufc1qRepvS8ngzEa+owddLC4UaJEaPLA6oE4
         F2F6Gy+c4z3ji44fWkfN/l2V4v4zsgBx4ObOwNGVIi6rGEVN02y3Ims46bUMq94xkm
         2Pbsm9LaPk9wO6ry1H0qQJXssZZLfKdWUTn1o//dzl3AiOGK7c0qSjnVUKYYPOLlgl
         lJbmLr9Id3LC6w2VPiVSOYHyefDo/3l56MpsKgFCqQWLF+5/vQoXQTsr/9lcH/WFRt
         dihx4RPAh+PiQ==
Received: by mail-ot1-f54.google.com with SMTP id f19-20020a9d5f13000000b00693ce5a2f3eso10425615oti.8;
        Wed, 22 Mar 2023 07:21:57 -0700 (PDT)
X-Gm-Message-State: AO0yUKUzFNloiV4PgwULCC+t6DheUCXXn+6lTOgDWK50PmaSMagNOStm
        Z4JO8/9ojAeRvW3bGpLVnWGHqTzYWzaB8wqIIzU=
X-Google-Smtp-Source: AK7set9A1WsRRFjWcLeMOAp1bulAbsHOLd+EjCnKRVDAn6dLp8nQkkURXCTM7XTid9ys7+5TKqzxj4jgf0vUdPZqvYo=
X-Received: by 2002:a05:6830:10e:b0:688:d1a8:389e with SMTP id
 i14-20020a056830010e00b00688d1a8389emr1126078otp.1.1679494916788; Wed, 22 Mar
 2023 07:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <4a55805c694cff4cc9281961f2d457262bea48e6.1679423785.git.kevin@kevinlocke.name>
 <3351f907cfd0b5d8372e858a8ec9065cc2bd91df.1679434718.git.kevin@kevinlocke.name>
In-Reply-To: <3351f907cfd0b5d8372e858a8ec9065cc2bd91df.1679434718.git.kevin@kevinlocke.name>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 22 Mar 2023 23:21:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQNkmf+etNU7HnAb8ktmKAVzG+-+HUCQNeoX3c8tRuMYA@mail.gmail.com>
Message-ID: <CAK7LNAQNkmf+etNU7HnAb8ktmKAVzG+-+HUCQNeoX3c8tRuMYA@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: deb-pkg: set version for linux-headers paths
To:     Kevin Locke <kevin@kevinlocke.name>
Cc:     linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 6:39=E2=80=AFAM Kevin Locke <kevin@kevinlocke.name>=
 wrote:
>
> As a result of the switch to dh_listpackages, $version is no longer set
> when install_kernel_headers() is called.  This causes files in the
> linux-headers deb package to be installed to a path with an empty
> $version (e.g. /usr/src/linux-headers-/scripts/sign-file rather than
> /usr/src/linux-headers-6.3.0-rc3/scripts/sign-file).
>
> To avoid this, while continuing to use the version information from
> dh_listpackages, pass $version from $package as the second argument
> of install_kernel_headers().
>
> Fixes: 36862e14e316 ("kbuild: deb-pkg: use dh_listpackages to know enable=
d packages")
> Signed-off-by: Kevin Locke <kevin@kevinlocke.name>
> ---

Applied to linux-kbuild/fixes. Thanks.



> Good idea!  Thanks for the quick review and feedback.  Here's an updated
> version.
>
> Changes since v1:
>  * Pass version as the second argument to install_kernel_headers(),
>    rather than as a global variable, as suggested by Masahiro Yamada.
>
>  scripts/package/builddeb | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index c5ae57167d7c..7b23f52c70c5 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -162,6 +162,7 @@ install_linux_image_dbg () {
>
>  install_kernel_headers () {
>         pdir=3D$1
> +       version=3D$2
>
>         rm -rf $pdir
>
> @@ -229,7 +230,7 @@ do
>         linux-libc-dev)
>                 install_libc_headers debian/linux-libc-dev;;
>         linux-headers-*)
> -               install_kernel_headers debian/linux-headers;;
> +               install_kernel_headers debian/linux-headers ${package#lin=
ux-headers-};;
>         esac
>  done
>
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada
