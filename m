Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7DF6865A2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjBAMAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBAMAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:00:46 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A6627D72
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 04:00:44 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id k16so12492128wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 04:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=luqjBbwnzOHV1V80oPmyfyIdt66TA1GvqfXDIDpwaYI=;
        b=Jk0exLlgmQWv8NxPHx6jR6KVIZ+u6/oYNDtv2967DrY1orw9TrSY3YEscR9JbKF8rC
         BV31GOD3b292MKBPm53sx+SWCehNmZtjaXCusLDYUaV3x5LHmjaFhS4Exc/FcrhzGVOO
         HD4wfzP9q2YLWaIatnEWGH+m4+GLSndA/4Q3rSRYeP/eceUn2kDEyxwqFNQERvEBnPEe
         MSbP7QDx8Lsy3xzaHFJ88J091aTyOIFq1oK8bX1XL5ZOB8edwGCvvzuPcYvttaUfq/+z
         2qnQoP2nXBTDsL0Av7g68d5kF1XY9rRdE+rgPSMpgdoU3EDJVhUflknRa5awA0GiOlJO
         J/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=luqjBbwnzOHV1V80oPmyfyIdt66TA1GvqfXDIDpwaYI=;
        b=d3xrI6R9vCR1B765dbQaNEQpHLvntW1q4tzw9msaCajoAWEcjYou6PYtDFCaookL1/
         vYTV2Q4f2MMGf/ib535WQilfleSh60tzeRnlvdh+9zZKhHRFsRWrFgYbB8S1CPVA+zSl
         aDCvCqIdOjGz8sG66RKNUKpVD6HLYg0Ry5735fNr78s4g3P5kON7hYBIovelHadgHvQ6
         XQckELifRQwnKPfQbcFl65SOhO8N9y194NXqkgwGgH9Fo6jkPS5jgrkSagqauHeY3CLz
         DHkEYBT4ka+xTyzFOfGQpNpEZWd61lb5AsZe+1VDdXVmNC1IIyKzQFeA1/0Ulqcf63cJ
         QdNQ==
X-Gm-Message-State: AO0yUKVGRwLMglGHMfkl6WqNnXiyE86wYzNZihjdziXw8VXwrUWhZJob
        tXeKpA5GW7FZgb/3dBGI654vnc1dPM4XUHSOcXB5bz1a
X-Google-Smtp-Source: AK7set8hbqbSlaYJzAa+DyTtcrKtXgSDG625BwasUrD9vG/j/PmuK2/fVTSOwVx6CdUH4c1vspGAE4RGCLrxZ+FVM3Y=
X-Received: by 2002:a05:600c:5545:b0:3dd:7baa:693e with SMTP id
 iz5-20020a05600c554500b003dd7baa693emr139421wmb.36.1675252842826; Wed, 01 Feb
 2023 04:00:42 -0800 (PST)
MIME-Version: 1.0
References: <20230131221154.39291-1-skhan@linuxfoundation.org>
In-Reply-To: <20230131221154.39291-1-skhan@linuxfoundation.org>
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date:   Wed, 1 Feb 2023 14:00:06 +0200
Message-ID: <CAJ1xhMX2VHPB43MTphSXEaKPywAOgUwW1V7zrxUyt7zN1F6OPQ@mail.gmail.com>
Subject: Re: [PATCH v3] ver_linux: add missing software to checklist
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

On Wed, Feb 1, 2023 at 12:39 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Update to add missing software checks to bring it in sync with the
> Documentation/Changes list. Make improvements to the output with
> separator between different sections.
>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> Changes since v2: Fix extra line in usage
>
>  scripts/ver_linux | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/ver_linux b/scripts/ver_linux
> index 1a8ee4ff0e32..adef5dc67038 100755
> --- a/scripts/ver_linux
> +++ b/scripts/ver_linux
> @@ -6,20 +6,29 @@
>  # differ on your system.
>
>  BEGIN {
> -       usage = "If some fields are empty or look unusual you may have an old version.\n"
> -       usage = usage "Compare to the current minimal requirements in Documentation/Changes.\n"
> +       usage = "\nMinimum required software versions to build and run current kernel version.\n"
> +       usage = usage "If some fields are empty or look unusual you may have an old version.\n"
> +       usage = usage "Compare with the current minimal requirements in Documentation/Changes."
>         print usage
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

LGTM, thanks.
