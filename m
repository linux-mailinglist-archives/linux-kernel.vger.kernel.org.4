Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEBC66BDCE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjAPM1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjAPM1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:27:38 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796401CF63
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:27:35 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q10so7995792wrs.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fo0HeDZBouoAPlxb6sVNoJ/wyr2YEVED6nbR3911MSQ=;
        b=QbrK//H35rcGYAPxIs7PaPciTEO3gdE00PomVgKpfLoTY6NgQLlo5H1CTAatYch6ud
         e1R0xRs4wKjD8kG9PDoM6knYdKlk36162rLQGEJKSazbA5HEIwGR5eBM9byTDH1MkQ9+
         lZj2FSqeQSI76fTCbiEVEaeAy/X7wKy+HUQ00d1N3785aiWbprK2mT2l3OjIE0VRVpVX
         tmgfyfbNEOh0vVYzHX8CwMQJD3vVxXZbv/hKj7M5Flt/1WLsH41xDYC9iLCXYetnfgqP
         Kdrsteqco8QYJ45n9zmJ8rrAM/8wXqrnR3dw4Vs54nxtGivX2hbhgWxMqEEql5Mig6OS
         rPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fo0HeDZBouoAPlxb6sVNoJ/wyr2YEVED6nbR3911MSQ=;
        b=KR2eef2YVFb0hYFdojV/4pOrgJ/lJluGOyZ4x35wtFJMIOLvrlckmjQcLKQJaCNBNw
         hCeE6+MBKaFL9e6xWy2mBtPtEUzbCps/HQX7cuxA3hekxwNOjFFui7mK8PXlX3u4mlxM
         F4p9mB5bpHOBviZ0vBeD05bUesb8wSc2ve/wiBFForKfQ8Hgc9GEpNCtvMLbHcvDHzxb
         zsUuKc8eopRxnR7c6gVRDFWcCg0t0+oIvnOg7C5KXg/8rEElWxvhNji+rAEb77MQGLYg
         b8AmbBDRVHw1HkPqKb3NdJObPKfL+qXLodcwbzf2Q8m9FPLglsWiM3ZX/psmYhGH3ie7
         M+SA==
X-Gm-Message-State: AFqh2ko5dIAzwKw0+lz5mq4N1ZdsdEppymg0sltMYF+gT3kTT6pYZW81
        wC+G3278NlwY6B/0VnaE+LslmJv5bssCNz6O2v0fL8j5DzY=
X-Google-Smtp-Source: AMrXdXtNaC1YHdRVuP4gcZTkJmG2r87dTdN1Dt7AU/GjvXAU+8db71ieHMZe+90cjY+1iXvx2hs+ie3QHZj8gz8vy0w=
X-Received: by 2002:a05:6000:16cf:b0:29f:7c87:749c with SMTP id
 h15-20020a05600016cf00b0029f7c87749cmr2127385wrf.195.1673872053835; Mon, 16
 Jan 2023 04:27:33 -0800 (PST)
MIME-Version: 1.0
References: <20230110204225.35503-1-skhan@linuxfoundation.org>
In-Reply-To: <20230110204225.35503-1-skhan@linuxfoundation.org>
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date:   Mon, 16 Jan 2023 14:26:57 +0200
Message-ID: <CAJ1xhMXtRUnLJQKkPyUemLpYiAP4ebmgExS6cV2Kta6rCd__0w@mail.gmail.com>
Subject: Re: [PATCH] ver_linux: add missing software to checklist
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

On Tue, Jan 10, 2023 at 11:13 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Update to add missing software checks to bring it in sync with the
> Documentation/Changes list. Make improvements to the output with
> separator between different sections.
>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  scripts/ver_linux | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/ver_linux b/scripts/ver_linux
> index 1a8ee4ff0e32..6131f6f1b35b 100755
> --- a/scripts/ver_linux
> +++ b/scripts/ver_linux
> @@ -6,10 +6,14 @@
>  # differ on your system.
>
>  BEGIN {
> -       usage = "If some fields are empty or look unusual you may have an old version.\n"
> -       usage = usage "Compare to the current minimal requirements in Documentation/Changes.\n"
> +       usage = "Minimum required software versions to build and run current kernel version.\n"
> +       usage = usage "If some fields are empty or look unusual you may have an old version.\n"
> +       usage = usage "Compare with the current minimal requirements in Documentation/Changes.\n"
>         print usage
>
> +       separator = "===================================================\n"

Embedding a new line character at the start of the separator string
would eliminate the need for the extra printf("\n") statements
introduced.

> +
> +       print separator
>         system("uname -a")
>         printf("\n")

Consequently, this printf could be removed as well.

>
> @@ -17,9 +21,15 @@ BEGIN {
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
> @@ -28,6 +38,8 @@ BEGIN {
>         printversion("Reiserfsprogs", version("reiserfsck -V"))
>         printversion("Reiser4fsprogs", version("fsck.reiser4 -V"))
>         printversion("Xfsprogs", version("xfs_db -V"))
> +       printversion("squashfs-tools", version("mksquashfs -version"))
> +       printversion("btrfs-progs", version("mkfs.btrfs --version"))
>         printversion("Pcmciautils", version("pccardctl -V"))
>         printversion("Pcmcia-cs", version("cardmgr -V"))
>         printversion("Quota-tools", version("quota -V"))
> @@ -36,7 +48,16 @@ BEGIN {
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
> +       printf("\n")
>
> +       print separator
>         while ("ldconfig -p 2>/dev/null" | getline > 0)
>                 if ($NF ~ libc || $NF ~ libcpp)
>                         if (!seen[ver = version("readlink " $NF)]++)
> @@ -50,12 +71,14 @@ BEGIN {
>         printversion("Sh-utils", version("expr --v"))
>         printversion("Udev", version("udevadm --version"))
>         printversion("Wireless-tools", version("iwconfig --version"))
> +       printf("\n")
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
