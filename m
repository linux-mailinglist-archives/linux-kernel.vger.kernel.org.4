Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6458D69C3E5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 02:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjBTBFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 20:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBTBFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 20:05:09 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8691DBD8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 17:05:05 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id be16so1989501lfb.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 17:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8tnLv6srBYz9vUMQ8IWlYdg8pCsry8VFkUmI6+ovL1o=;
        b=mFRk4qTwVPz/Vkbqcprh89CQ4+5Xb7IclYyZx/msY2OJmrSENtNZI1xJmvJjHMLDAS
         la9Wrwo0w7ULbrgKZ5BbdYFPhvlzvYEP3SktWker5RIKCSstrBqZJbhjscZqHebtvoEO
         PK+rJSglavrgvZYiXA/1IeA//1rlsDMGEG/WS7JdFsS/sydfhaskiOsP79gcklpU910W
         4Rvd83Wt/w0Ksn6p7ZY95NKa5c5NnfXaoRJIPE1JOJYlbDskuGZS523Rt2Aika7iUFYY
         7PmiKeSvpfUfWb2DaMxgmmTObsgH8cTc9loz8xGbgww4ZU4WYyFxaYv6uK8taoE38Ns1
         0/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tnLv6srBYz9vUMQ8IWlYdg8pCsry8VFkUmI6+ovL1o=;
        b=w5QGKaqfByMogDb72jdk+Rrqwk8+Nh+XRdRJIglloKIbxwcea29AcRZbyF6AQBMj1i
         xHz0xWg5VXbZsg4yscURBw/c1T2REW7f7AjV2QZbc1z9yOpmqifFck98VhUUMmdWNQ6R
         gr505hiGNdyMuJJ7ZQYvBpua/pC3e1+GNmaHL/Opj4t52c4u+OAgFMkrB1Ua8YW2YOLE
         L0qYM13kXGc6S/43rwyceFfid02FcorcQThrbjHd0sKea6l+7lzdnH3R40PJFesQashG
         JgY3OakTjw0QECkNWVH72PnbNIrDdMtYaolC95QjZ5XB4tQEAttCrs3VDTxZ38bpND42
         ZTPQ==
X-Gm-Message-State: AO0yUKUzaGJKRci5EkMMTZ6GNvpvnQx/vrK+Ei4H+kh9nvFA+2pirFBz
        Egq7a7OEWeuqtDeNxNwfEREXqAWZ8nOwVVoEzXI=
X-Google-Smtp-Source: AK7set96EX0qhGHHSdIM1qzZ0BQKxN0bPYt5OTx65FqR31+mYEdVZ0BwxvhWMcb6c6eLvLUjkvjFi1irbfyaf4XG1pI=
X-Received: by 2002:a19:7606:0:b0:4dc:807a:d143 with SMTP id
 c6-20020a197606000000b004dc807ad143mr123673lff.7.1676855103945; Sun, 19 Feb
 2023 17:05:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675907639.git.chenfeiyang@loongson.cn> <f60027664200d6d1f0ed6c7b87915a223afb982f.1675907639.git.chenfeiyang@loongson.cn>
 <Y+lWQC3XU3xWqEi2@1wt.eu> <CACWXhK=FKV=CppZnHtO3x33GhJgMQ8gmcgxp_Hn-bo7YcxRrnQ@mail.gmail.com>
 <Y/JzPSYMPh/Hgjyn@1wt.eu>
In-Reply-To: <Y/JzPSYMPh/Hgjyn@1wt.eu>
From:   Feiyang Chen <chris.chenfeiyang@gmail.com>
Date:   Mon, 20 Feb 2023 09:04:52 +0800
Message-ID: <CACWXhK=Ur4jbE4o7M05Ru91vr8sTwdJeyJUcCE6uwaEfjeFxag@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] tools/nolibc: Add statx() and make stat() rely on
 statx() if necessary
To:     Willy Tarreau <w@1wt.eu>
Cc:     paulmck@kernel.org, Feiyang Chen <chenfeiyang@loongson.cn>,
        arnd@arndb.de, chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vincent Dagonneau <v@vda.io>
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

On Mon, 20 Feb 2023 at 03:06, Willy Tarreau <w@1wt.eu> wrote:
>
> Hi Feiyang,
>
> On Mon, Feb 13, 2023 at 09:06:36AM +0800, Feiyang Chen wrote:
> > On Mon, 13 Feb 2023 at 05:12, Willy Tarreau <w@1wt.eu> wrote:
> > >
> > > Hi Feiyang,
> > >
> > > On Thu, Feb 09, 2023 at 11:24:13AM +0800, chris.chenfeiyang@gmail.com wrote:
> > > > From: Feiyang Chen <chenfeiyang@loongson.cn>
> > > >
> > > > LoongArch and RISC-V 32-bit only have statx(). ARC, Hexagon, Nios2 and
> > > > OpenRISC have statx() and stat64() but not stat() or newstat(). Add
> > > > statx() and make stat() rely on statx() if necessary to make them happy.
> > > > We may just use statx() for all architectures in the future.
> > > >
> > > > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > > > ---
> > > >  tools/include/nolibc/sys.h | 56 ++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 56 insertions(+)
> > > >
> > > > diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> > > > index c4818a9c8823..70c30d457952 100644
> > > > --- a/tools/include/nolibc/sys.h
> > > > +++ b/tools/include/nolibc/sys.h
> > > > @@ -20,6 +20,7 @@
> > > >  #include <linux/time.h>
> > > >  #include <linux/auxvec.h>
> > > >  #include <linux/fcntl.h> // for O_* and AT_*
> > > > +#include <linux/stat.h>  // for statx()
> > >
> > > This one causes build warnings on all archs but x86_64:
> > >
> > >   /f/tc/nolibc/gcc-11.3.0-nolibc/aarch64-linux/bin/aarch64-linux-gcc -Os -fno-ident -fno-asynchronous-unwind-tables  -s -o nolibc-test \
> > >     -nostdlib -static -Isysroot/arm64/include nolibc-test.c -lgcc
> > >   In file included from sysroot/arm64/include/sys.h:23,
> > >                    from sysroot/arm64/include/nolibc.h:99,
> > >                    from sysroot/arm64/include/errno.h:26,
> > >                    from sysroot/arm64/include/stdio.h:14,
> > >                    from nolibc-test.c:15:
> > >   sysroot/arm64/include/linux/stat.h:9: warning: "S_IFMT" redefined
> > >       9 | #define S_IFMT  00170000
> > >         |
> > >   In file included from sysroot/arm64/include/nolibc.h:98,
> > >                    from sysroot/arm64/include/errno.h:26,
> > >                    from sysroot/arm64/include/stdio.h:14,
> > >                    from nolibc-test.c:15:
> > >   sysroot/arm64/include/types.h:27: note: this is the location of the previous definition
> > >
> > > This is caused by the definitions for S_IF* and S_IS* in types.h. However
> > > if I remove them I'm seeing x86_64 fail on S_IFCHR not defined. The root
> > > cause is that the x86_64 toolchain falls back to /usr/include for the
> > > include_next <limits.h> that others do not do (probably that when built
> > > it thought it was a native compiler instead of a cross-compiler). I'm
> > > apparently able to work around this by ifdefing out the definitions but
> > > it makes me feel like I'm hiding the dust under the carpet. Instead I'm
> > > thinking of reusing Vincent's work who added stdint and the definitions
> > > for the various INT*MAX values that are normally found in limits.h and
> > > providing our own limits.h so that this issue is globally addressed.
> > >
> > > I'm going to experiment a little bit about this and will propose something
> > > once I'm satisfied with a solution that we can queue for 6.4. Most likely
> > > it will involve merging a variant of Vincent's series first, a few changes
> > > to have limits.h then your series.
> > >
> >
> > Hi, Willy,
> >
> > OK. Thank you very much!
>
> You're welcome. I finally figured the root cause of the problem. As
> mentioned above, the cross-compiler mistakenly includes some glibc
> entries (regardless of me defining limits.h), and linux/stat.h sees
> glibc defined so it refrains from defining S_I* because this conflict
> was apparently already identified in the past. In order to work around
> the problem without touching the uapi headers, I preferred to modify
> the nolibc one to add a similar test and detect whether linux/stat.h
> had already provided them (see patch below). This way it remains simple
> to understand and still pretty effective. And now your patchset works
> fine with no modification.
>
> I'll send all of this to Paul next week-end once he's back.
>

Hi, Willy,

Thank you!

Thanks,
Feiyang

> Thanks,
> Willy
>
> --
>
> From 39843ae4a006c37cf09febaf286c438a9793f9a1 Mon Sep 17 00:00:00 2001
> From: Willy Tarreau <w@1wt.eu>
> Date: Sun, 19 Feb 2023 18:51:59 +0100
> Subject: [PATCH] tools/nolibc: check for S_I* macros before defining them
>
> Defining S_I* flags in types.h can cause some build failures if
> linux/stat.h is included prior to it. But if not defined, some toolchains
> that include some glibc parts will in turn fail because linux/stat.h
> already takes care of avoiding these definitions when glibc is present.
>
> Let's preserve the macros here but first include linux/stat.h and check
> for their definition before doing so. We also define the previously
> missing permission macros so that we don't get a different behavior
> depending on the first include found.
>
> Cc: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---
>  tools/include/nolibc/types.h | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
> index fbbc0e68c001..47a0997d2d74 100644
> --- a/tools/include/nolibc/types.h
> +++ b/tools/include/nolibc/types.h
> @@ -9,6 +9,7 @@
>
>  #include "std.h"
>  #include <linux/time.h>
> +#include <linux/stat.h>
>
>
>  /* Only the generic macros and types may be defined here. The arch-specific
> @@ -16,7 +17,11 @@
>   * the layout of sys_stat_struct must not be defined here.
>   */
>
> -/* stat flags (WARNING, octal here) */
> +/* stat flags (WARNING, octal here). We need to check for an existing
> + * definition because linux/stat.h may omit to define those if it finds
> + * that any glibc header was already included.
> + */
> +#if !defined(S_IFMT)
>  #define S_IFDIR        0040000
>  #define S_IFCHR        0020000
>  #define S_IFBLK        0060000
> @@ -34,6 +39,22 @@
>  #define S_ISLNK(mode)  (((mode) & S_IFMT) == S_IFLNK)
>  #define S_ISSOCK(mode) (((mode) & S_IFMT) == S_IFSOCK)
>
> +#define S_IRWXU 00700
> +#define S_IRUSR 00400
> +#define S_IWUSR 00200
> +#define S_IXUSR 00100
> +
> +#define S_IRWXG 00070
> +#define S_IRGRP 00040
> +#define S_IWGRP 00020
> +#define S_IXGRP 00010
> +
> +#define S_IRWXO 00007
> +#define S_IROTH 00004
> +#define S_IWOTH 00002
> +#define S_IXOTH 00001
> +#endif
> +
>  /* dirent types */
>  #define DT_UNKNOWN     0x0
>  #define DT_FIFO        0x1
> --
> 2.35.3
>
