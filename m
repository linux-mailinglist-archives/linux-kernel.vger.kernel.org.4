Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8228666A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 05:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbjALEw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 23:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238128AbjALEwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 23:52:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AB017E39;
        Wed, 11 Jan 2023 20:52:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF1B461F65;
        Thu, 12 Jan 2023 04:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B7CC433EF;
        Thu, 12 Jan 2023 04:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673499133;
        bh=puI6pmQu2ZBulYkEVUmsU5TYGSZwwHCRvW/+HBIj8UE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AxznadA80ioQfs+gPs1n2K33JimH6BoPAsLVPGc24vKc2OMSy5CH3orHPZ6UyaLxW
         8Y9akCar8pVqWn6Td61OTLMNznPOdhRQzyHFInps3oZvsLKerr7uXt+HSD62yyHj3c
         mM4dAjPkGi5o8lwv27qXvWOUUQDk3txxxFo8H+Pn9iikI6KrqfoQX1wK5heZWPcE8N
         5QRfXcUcAQJYd0Zky2QZVm699HQMFFNrI6ovPJYz8wkqUaSo9G0F+L4MyL40uZ5Ldq
         DaXATOXIrfmUtbQkDjIoV3Q4c6gmEXc5T/i4GYPVrjSXFAYBMDZv6xpAA7o3XWkAyx
         O4W93eVKnrj/w==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-15bb8ec196aso6019767fac.3;
        Wed, 11 Jan 2023 20:52:13 -0800 (PST)
X-Gm-Message-State: AFqh2konJrfapnpXbMPi/tu+rQXspI3Q+E3qBwl6iWqnVdDq1yyeUH0p
        7p2tfsy468v0n5D6wVfVYffO2ufkG+Qa1xtKiww=
X-Google-Smtp-Source: AMrXdXt1bjJlPmLyy/3/oqw9QiH6hx1fB/zYsb3i9V76/COZ37EBO3BT0CD5+mmVljZOZcTkPGj3x63mN2a3djggky8=
X-Received: by 2002:a05:6870:514c:b0:150:7e4a:2f00 with SMTP id
 z12-20020a056870514c00b001507e4a2f00mr2609492oak.194.1673499132468; Wed, 11
 Jan 2023 20:52:12 -0800 (PST)
MIME-Version: 1.0
References: <20230111-kconfig-v1-1-a921f03670f0@pefoley.com>
In-Reply-To: <20230111-kconfig-v1-1-a921f03670f0@pefoley.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 12 Jan 2023 13:51:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR2Hor39X6tBpB0p1hW5RyUY7-g0eXRiKuLm=b6fFqHZg@mail.gmail.com>
Message-ID: <CAK7LNAR2Hor39X6tBpB0p1hW5RyUY7-g0eXRiKuLm=b6fFqHZg@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Update all declared targets
To:     Peter Foley <pefoley2@pefoley.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 1:39 PM Peter Foley <pefoley2@pefoley.com> wrote:
>
> Currently qconf-cfg.sh is the only script that touches the "-bin"
> target, even though all of the conf_cfg rules declare that they do.
> Make the other scripts touch all declared targets to avoid
> incompatibilities with upcoming versions of GNU make:
> https://lists.gnu.org/archive/html/info-gnu/2022-10/msg00008.html
>
> e.g.
> scripts/kconfig/Makefile:215: warning: pattern recipe did not update peer target 'scripts/kconfig/nconf-bin'.
> scripts/kconfig/Makefile:215: warning: pattern recipe did not update peer target 'scripts/kconfig/mconf-bin'.
> scripts/kconfig/Makefile:215: warning: pattern recipe did not update peer target 'scripts/kconfig/gconf-bin'.
>
> Signed-off-by: Peter Foley <pefoley2@pefoley.com>



I prefer changing only one line:



diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 0b1d15efaeb0..af1c96198f49 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -209,7 +209,7 @@ $(obj)/gconf: | $(obj)/gconf-libs
 $(obj)/gconf.o: | $(obj)/gconf-cflags

 # check if necessary packages are available, and configure build flags
-cmd_conf_cfg = $< $(addprefix $(obj)/$*conf-, cflags libs bin)
+cmd_conf_cfg = $< $(addprefix $(obj)/$*conf-, cflags libs bin); touch
$(obj)/$*conf-bin

 $(obj)/%conf-cflags $(obj)/%conf-libs $(obj)/%conf-bin: $(src)/%conf-cfg.sh
        $(call cmd,conf_cfg)







Also, please update .gitignore


diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
index c8a3f9cd52f0..f8bdf0cf4662 100644
--- a/scripts/kconfig/.gitignore
+++ b/scripts/kconfig/.gitignore
@@ -3,5 +3,5 @@
 /[gmnq]conf
 /[gmnq]conf-cflags
 /[gmnq]conf-libs
-/qconf-bin
+/[gmnq]conf-bin
 /qconf-moc.cc





Thanks.







> ---
>  scripts/kconfig/gconf-cfg.sh | 2 ++
>  scripts/kconfig/mconf-cfg.sh | 3 +++
>  scripts/kconfig/nconf-cfg.sh | 3 +++
>  3 files changed, 8 insertions(+)
>
> diff --git a/scripts/kconfig/gconf-cfg.sh b/scripts/kconfig/gconf-cfg.sh
> index 040d8f3388202..d98c2ed09b158 100755
> --- a/scripts/kconfig/gconf-cfg.sh
> +++ b/scripts/kconfig/gconf-cfg.sh
> @@ -3,6 +3,7 @@
>
>  cflags=$1
>  libs=$2
> +bin=$3
>
>  PKG="gtk+-2.0 gmodule-2.0 libglade-2.0"
>
> @@ -31,3 +32,4 @@ fi
>
>  ${HOSTPKG_CONFIG} --cflags ${PKG} > ${cflags}
>  ${HOSTPKG_CONFIG} --libs ${PKG} > ${libs}
> +touch ${bin}
> diff --git a/scripts/kconfig/mconf-cfg.sh b/scripts/kconfig/mconf-cfg.sh
> index 1e61f50a59050..3719e1607d34a 100755
> --- a/scripts/kconfig/mconf-cfg.sh
> +++ b/scripts/kconfig/mconf-cfg.sh
> @@ -3,10 +3,13 @@
>
>  cflags=$1
>  libs=$2
> +bin=$3
>
>  PKG="ncursesw"
>  PKG2="ncurses"
>
> +touch ${bin}
> +
>  if [ -n "$(command -v ${HOSTPKG_CONFIG})" ]; then
>         if ${HOSTPKG_CONFIG} --exists $PKG; then
>                 ${HOSTPKG_CONFIG} --cflags ${PKG} > ${cflags}
> diff --git a/scripts/kconfig/nconf-cfg.sh b/scripts/kconfig/nconf-cfg.sh
> index f871a2160e363..a0edc427719f0 100755
> --- a/scripts/kconfig/nconf-cfg.sh
> +++ b/scripts/kconfig/nconf-cfg.sh
> @@ -3,10 +3,13 @@
>
>  cflags=$1
>  libs=$2
> +bin=$3
>
>  PKG="ncursesw menuw panelw"
>  PKG2="ncurses menu panel"
>
> +touch ${bin}
> +
>  if [ -n "$(command -v ${HOSTPKG_CONFIG})" ]; then
>         if ${HOSTPKG_CONFIG} --exists $PKG; then
>                 ${HOSTPKG_CONFIG} --cflags ${PKG} > ${cflags}
>
> ---
> base-commit: e8f60cd7db24f94f2dbed6bec30dd16a68fc0828
> change-id: 20230111-kconfig-e59c6154f506
>
> Best regards,
> --
> Peter Foley <pefoley2@pefoley.com>



--
Best Regards
Masahiro Yamada
