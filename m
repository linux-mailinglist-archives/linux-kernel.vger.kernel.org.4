Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564E867C56B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbjAZID0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjAZIDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:03:24 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4472C5C0E9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:03:23 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso2712998wmn.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SihlUIPlgbPTgKFs++PqYDB0IWiavke0WResWLwzdvw=;
        b=fuy+HFMidrSln2e8SG1IWJRIWz1l1cSbRQE18GSQVX/KSKurk0wmdJD6uf2KQXJtEg
         pEtLwPiSYXFQ0NspUvBAOPWG/btsPEThf9rcwokSQZmPByB7X14FyYUMBbgzoT1J49En
         +5XdT146UXZG5SowDAMa92GlU5+dEfw1uiaxeKWdjyiXlaBXRoSVVj+bt5n6wXVkCfb1
         SRTbiJXMzlE/AnqwsAdFGUB1/hiegBVcUNaWLFW1vjr3AxxcwImR3eEzUk4zzdeQb9n9
         E9m+o6HxXp1Hbni71X8clo2Q4UCGnIVx54zS7/SCmU+fFQztTu7U6/QMqkcURSBOmRSR
         mCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SihlUIPlgbPTgKFs++PqYDB0IWiavke0WResWLwzdvw=;
        b=VwCDr19iRj/Qs168cQqysoSoEWIYEeu3H+FyVgD2fxyvO22p4C1wfrIfXMhYJQtun5
         nFtVKHbv7cH9CSodrxVr/A3HG4EL1YspF4IJO/sEp2LgaM2jl7Ci3MDtjX9m10rxiRtq
         Mp1iptQ0ArjnxaLgFjXQgNoCy8u6GPy+7m7uWmDZ5Wlx+I4QMISmSmS+ajhxIzoW9vLm
         i49edl9j1VKKMHnLpORkBfNsrX0VN6XvHML1Gib6thpVXQHW2r9DyVx2uQ0Nwg71OulX
         trqGmyl2tOxI70zSZvnd9LPSkoaetAF1JilUroQgPCiJ0IXhHx2taxTaRbJ0D+IBlNqx
         1Ydg==
X-Gm-Message-State: AFqh2koQfNtlUV5sjj33luAgV5cjJF670uSYr+GMitj6P5P069lBRmNr
        E2Irg8Gl8PVpdm3kGlzxxqFS1gSjRouyDp4CxnjdkZ7i
X-Google-Smtp-Source: AMrXdXtz9hFCpSo2C8pmWZUdmzgzEiFUkYc3GOTbGlSo2qTiab5QiNUpvBY6rrKt98/fxdEnbPu18nIjWmULgzh/xBE=
X-Received: by 2002:a05:600c:4f4a:b0:3db:647:a70b with SMTP id
 m10-20020a05600c4f4a00b003db0647a70bmr1873801wmq.195.1674720201671; Thu, 26
 Jan 2023 00:03:21 -0800 (PST)
MIME-Version: 1.0
References: <20230124204324.33858-1-skhan@linuxfoundation.org>
In-Reply-To: <20230124204324.33858-1-skhan@linuxfoundation.org>
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date:   Thu, 26 Jan 2023 10:02:51 +0200
Message-ID: <CAJ1xhMU3CPK9nLyx0ejqMt6KKcaeewsstQzUA7KKExumJ7hYzQ@mail.gmail.com>
Subject: Re: [PATCH v2] ver_linux: add missing software to checklist
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 11:04 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Update to add missing software checks to bring it in sync with the
> Documentation/Changes list. Make improvements to the output with
> separator between different sections.
>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> Changes since v1: addressed review comments
>
>  scripts/ver_linux | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/ver_linux b/scripts/ver_linux
> index 1a8ee4ff0e32..2daee7e88c45 100755
> --- a/scripts/ver_linux
> +++ b/scripts/ver_linux
> @@ -6,20 +6,29 @@
>  # differ on your system.
>
>  BEGIN {
> -       usage = "If some fields are empty or look unusual you may have an old version.\n"
> -       usage = usage "Compare to the current minimal requirements in Documentation/Changes.\n"
> +       usage = "Minimum required software versions to build and run current kernel version.\n"
> +       usage = usage "If some fields are empty or look unusual you may have an old version.\n"
> +       usage = usage "Compare with the current minimal requirements in Documentation/Changes.\n"
>         print usage

The usage message is followed by three new line characters, the 1st is
embedded in the last line of the usage message, the second is output
by the print function, and the third by the leading new line character
in the separator string.
All other sections use two trailing new line characters instead.
If the formatting of this section is desired to be consistent with all
the other sections, this print function may be substituted with the
printf function, which does not append a new line character to its
argument.

>
> +       separator = "\n===================================================\n"
> +
> +       print separator
>         system("uname -a")
> -       printf("\n")
>
>         vernum = "[0-9]+([.]?[0-9]+)+"
>         libc = "libc[.]so[.][0-9]+$"
>         libcpp = "(libg|stdc)[+]+[.]so([.][0-9]+)+$"
>
> +       print separator
>         printversion("GNU C", version("gcc -dumpversion"))
> +       printversion("Clang/LLVM (optional)", version("clang --version"))
> +       printversion("Rust (optional)", version("rustc --version"))
> +       printversion("bindgen (optional)", version("bindgen --version"))
>         printversion("GNU Make", version("make --version"))
> +       printversion("bash", version("bash --version"))
>         printversion("Binutils", version("ld -v"))
> +       printversion("pahole", version("pahole --version"))
>         printversion("Util-linux", version("mount --version"))
>         printversion("Mount", version("mount --version"))
>         printversion("Module-init-tools", version("depmod -V"))
> @@ -28,6 +37,8 @@ BEGIN {
>         printversion("Reiserfsprogs", version("reiserfsck -V"))
>         printversion("Reiser4fsprogs", version("fsck.reiser4 -V"))
>         printversion("Xfsprogs", version("xfs_db -V"))
> +       printversion("squashfs-tools", version("mksquashfs -version"))
> +       printversion("btrfs-progs", version("mkfs.btrfs --version"))
>         printversion("Pcmciautils", version("pccardctl -V"))
>         printversion("Pcmcia-cs", version("cardmgr -V"))
>         printversion("Quota-tools", version("quota -V"))
> @@ -36,7 +47,15 @@ BEGIN {
>         printversion("Nfs-utils", version("showmount --version"))
>         printversion("Bison", version("bison --version"))
>         printversion("Flex", version("flex --version"))
> +       printversion("Grub", version("grub-install --version"))
> +       printversion("mcelog", version("mcelog --version"))
> +       printversion("iptables", version("iptables --version"))
> +       printversion("openssl & libcrypto", version("openssl version"))
> +       printversion("bc", version("bc --version"))
> +       printversion("Sphinx (for doc builds)", version("sphinx-build --version"))
> +       printversion("cpio", version("cpio --version"))
>
> +       print separator
>         while ("ldconfig -p 2>/dev/null" | getline > 0)
>                 if ($NF ~ libc || $NF ~ libcpp)
>                         if (!seen[ver = version("readlink " $NF)]++)
> @@ -51,11 +70,12 @@ BEGIN {
>         printversion("Udev", version("udevadm --version"))
>         printversion("Wireless-tools", version("iwconfig --version"))
>
> +       print separator
>         while ("sort /proc/modules" | getline > 0) {
>                 mods = mods sep $1
>                 sep = " "
>         }
> -       printversion("Modules Loaded", mods)
> +       printversion("Modules Loaded:\n", mods)
>  }
>
>  function version(cmd,    ver) {
> --
> 2.34.1
>

Other than that, LGTM. Thanks.
