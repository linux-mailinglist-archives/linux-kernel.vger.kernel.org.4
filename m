Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED7167713A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 18:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjAVRs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 12:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjAVRs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 12:48:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E8313D74;
        Sun, 22 Jan 2023 09:48:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E704560BCC;
        Sun, 22 Jan 2023 17:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB89C4339C;
        Sun, 22 Jan 2023 17:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674409736;
        bh=xD7a+ICcNUORoNgPmgIA6dKQcRIVrlR1bQKsoNQhcwI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R9QudQK7MKhnDue+Cfrl4hn1oEdev0zihg4kd0mBUVU2Xbvxt2cHdk6qHJr4ww2qK
         oUmzcCZvpagwnpaP1olTWMATKnbDvy17Bfnzl0XqAh8iTSif6R8FMAvCxOMcnZgFFT
         zvLPtLA+T0k9/bLB4ckKgYYylJQN8jUf9i3yPhaj1PfHUW17Mri7VV3RxqsJJzmNDa
         ogPUH1sl1ErSXGy2rR19naIwE3JLkofCTSMG3JOX0BR+a3ACYaWHHh/uu6BAQB61sg
         qDKGUuscpGaRZfPsp4fMUtMZg32dxhECoY2GE2GA/Wh9YVPUaaPIUwmMyC1LKR98f2
         NgFLDvpIPpMeg==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-15ff0a1f735so3520015fac.5;
        Sun, 22 Jan 2023 09:48:56 -0800 (PST)
X-Gm-Message-State: AFqh2koBOn07xTvcaVushhr4b7Ax3DkgqDk8i6DUpIAX8r3Lc7fm+MSu
        Jc609QPWf/xfjSY9v6e7UBkcEaOzb3hlSATJKc0=
X-Google-Smtp-Source: AMrXdXtvoxT2ZIDrNIS61KIdiJ14rtFDGARHY3PdXvco95149zfmQ8nlkFbug7LWA0hKOerHMNznWEHnHTskCU0CCck=
X-Received: by 2002:a05:6870:b0c:b0:15b:9941:ac30 with SMTP id
 lh12-20020a0568700b0c00b0015b9941ac30mr1694881oab.287.1674409735503; Sun, 22
 Jan 2023 09:48:55 -0800 (PST)
MIME-Version: 1.0
References: <20230119071215.23042-1-masahiroy@kernel.org>
In-Reply-To: <20230119071215.23042-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 23 Jan 2023 02:48:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNASUwTnOHDF9ym3u2R6bxrELEBsrKeaCCeHdz_mrA-yFYg@mail.gmail.com>
Message-ID: <CAK7LNASUwTnOHDF9ym3u2R6bxrELEBsrKeaCCeHdz_mrA-yFYg@mail.gmail.com>
Subject: Re: [PATCH] scripts: remove bin2c
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 4:13 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Commit 80f8be7af03f ("tomoyo: Omit use of bin2c") removed the last
> use of bin2c.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  Documentation/dontdiff     |  1 -
>  init/Kconfig               |  4 ----
>  scripts/.gitignore         |  1 -
>  scripts/Makefile           |  1 -
>  scripts/bin2c.c            | 36 ------------------------------------
>  scripts/remove-stale-files |  2 ++
>  6 files changed, 2 insertions(+), 43 deletions(-)
>  delete mode 100644 scripts/bin2c.c




Applied to linux-kbuild.



>
> diff --git a/Documentation/dontdiff b/Documentation/dontdiff
> index 352ff53a2306..3c399f132e2d 100644
> --- a/Documentation/dontdiff
> +++ b/Documentation/dontdiff
> @@ -91,7 +91,6 @@ asm_offsets.h
>  autoconf.h*
>  av_permissions.h
>  bbootsect
> -bin2c
>  binkernel.spec
>  bootsect
>  bounds.h
> diff --git a/init/Kconfig b/init/Kconfig
> index 7ceabd320425..f66ba19f9482 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -682,10 +682,6 @@ config CPU_ISOLATION
>
>  source "kernel/rcu/Kconfig"
>
> -config BUILD_BIN2C
> -       bool
> -       default n
> -
>  config IKCONFIG
>         tristate "Kernel .config support"
>         help
> diff --git a/scripts/.gitignore b/scripts/.gitignore
> index 11bf3c075fb6..6e9ce6720a05 100644
> --- a/scripts/.gitignore
> +++ b/scripts/.gitignore
> @@ -1,6 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  /asn1_compiler
> -/bin2c
>  /generate_rust_target
>  /insert-sys-cert
>  /kallsyms
> diff --git a/scripts/Makefile b/scripts/Makefile
> index 0e0ae3c06ed7..32b6ba722728 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -3,7 +3,6 @@
>  # scripts contains sources for various helper programs used throughout
>  # the kernel for the build process.
>
> -hostprogs-always-$(CONFIG_BUILD_BIN2C)                 += bin2c
>  hostprogs-always-$(CONFIG_KALLSYMS)                    += kallsyms
>  hostprogs-always-$(BUILD_C_RECORDMCOUNT)               += recordmcount
>  hostprogs-always-$(CONFIG_BUILDTIME_TABLE_SORT)                += sorttable
> diff --git a/scripts/bin2c.c b/scripts/bin2c.c
> deleted file mode 100644
> index c3d7eef3ad06..000000000000
> --- a/scripts/bin2c.c
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -/*
> - * Unloved program to convert a binary on stdin to a C include on stdout
> - *
> - * Jan 1999 Matt Mackall <mpm@selenic.com>
> - *
> - * This software may be used and distributed according to the terms
> - * of the GNU General Public License, incorporated herein by reference.
> - */
> -
> -#include <stdio.h>
> -
> -int main(int argc, char *argv[])
> -{
> -       int ch, total = 0;
> -
> -       if (argc > 1)
> -               printf("const char %s[] %s=\n",
> -                       argv[1], argc > 2 ? argv[2] : "");
> -
> -       do {
> -               printf("\t\"");
> -               while ((ch = getchar()) != EOF) {
> -                       total++;
> -                       printf("\\x%02x", ch);
> -                       if (total % 16 == 0)
> -                               break;
> -               }
> -               printf("\"\n");
> -       } while (ch != EOF);
> -
> -       if (argc > 1)
> -               printf("\t;\n\n#include <linux/types.h>\n\nconst size_t %s_size = %d;\n",
> -                      argv[1], total);
> -
> -       return 0;
> -}
> diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
> index c71bf2f68360..04fcdf739638 100755
> --- a/scripts/remove-stale-files
> +++ b/scripts/remove-stale-files
> @@ -29,3 +29,5 @@ rm -f scripts/extract-cert
>  rm -f scripts/kconfig/[gmnq]conf-cfg
>
>  rm -f rust/target.json
> +
> +rm -f scripts/bin2c
> --
> 2.34.1
>


-- 
Best Regards
Masahiro Yamada
