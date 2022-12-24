Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F709655AC2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 17:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiLXQuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 11:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiLXQuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 11:50:17 -0500
X-Greylist: delayed 174 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 24 Dec 2022 08:50:16 PST
Received: from condef-05.nifty.com (condef-05.nifty.com [202.248.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBB3C767
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 08:50:16 -0800 (PST)
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-05.nifty.com with ESMTP id 2BOGklSh019306
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 01:46:47 +0900
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 2BOGkTPF003578
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 01:46:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 2BOGkTPF003578
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1671900390;
        bh=TlHmyh0nEjNqJa7OxlDKADlGglP7IhjXAeNsJ0gbZ54=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=orVWby5fKyrq+5/4nvDHSDUFTh12G112IDbBuvP1etFAPVrZ/qBw7Z2ThaHQKhR3c
         ZHsZZqm6+wME+I7vkJIi/gfhJs+58aNlV725zcF3P3eY1ZGNVY/N3acRJaLyfYl8+6
         bvXVSSPThOElpmW+Vj6EApcT5p6P0OdxtCW2e8pFh+UIYAMjxPQWd/jxVPvMr+WuEX
         MIzD4q6Okr5uQwgTk8/6871mvVlpKP2DkvmAYNMvkfjhduj6BR4YA1vmN8HmZfokqr
         m2ZtN49+tncgayDrigQM/A5ZYcLw+rowebDRzgPc+rpV61gz4lUdNIFcQ19vjKlcnD
         nPw0JTQqYjxTw==
X-Nifty-SrcIP: [209.85.160.43]
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-14455716674so8972959fac.7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 08:46:30 -0800 (PST)
X-Gm-Message-State: AFqh2kpcOXoQPJlhtRJTwlFbB9CjDOrTTFLQRJf2m9S71s5z+mD6RLKV
        Cb32dXaEORmVuG8ijusE+qTYlS3wUONTR60+QcM=
X-Google-Smtp-Source: AMrXdXtbxhYoRQFIQnQewzMHGwl7TmmoHCt+qA8DDDbj7gMCbb+6I9uflc+J80tKX+7UkZrzVg3UW+/1ks1M8wHrYu0=
X-Received: by 2002:a05:6871:4193:b0:144:d060:72e with SMTP id
 lc19-20020a056871419300b00144d060072emr909779oab.287.1671900388872; Sat, 24
 Dec 2022 08:46:28 -0800 (PST)
MIME-Version: 1.0
References: <20221217084155.663235-1-mgorny@gentoo.org>
In-Reply-To: <20221217084155.663235-1-mgorny@gentoo.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 25 Dec 2022 01:45:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ8=YbOVvugBUQBo8eXRMH+YA49aS-1C=2hCGq0xoW7XA@mail.gmail.com>
Message-ID: <CAK7LNAQ8=YbOVvugBUQBo8eXRMH+YA49aS-1C=2hCGq0xoW7XA@mail.gmail.com>
Subject: Re: [PATCH] kheaders: prefer gtar over tar for better compatibility
To:     =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     Dmitry Goldin <dgoldin+lkml@protonmail.ch>,
        linux-kernel@vger.kernel.org, Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 5:42 PM Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org> =
wrote:
>
> Commit 86cdd2fdc4e39c388d39c7ba2396d1a9dfd66226 ("kheaders: make headers
> archive reproducible") introduced a number of options specific to GNU
> tar to the `tar` invocation in `gen_kheaders.sh` script.  This causes
> the script to fail to work on systems where `tar` is not GNU tar.  This
> can occur e.g. on recent Gentoo Linux installations that support using
> bsdtar from libarchive instead.
>
> To achieve better portability, try using `gtar` over `tar` if the former
> is available.  This is the name frequently used on systems featuring
> support for installing GNU tar alongside another tar implementation.
> If `gtar` is not present, `tar` is used for compatibility with regular
> systems.
>
> Link: https://bugs.gentoo.org/884061
> Reported-by: Sam James <sam@gentoo.org>
> Tested-by: Sam James <sam@gentoo.org>
> Signed-off-by: Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org>
> ---
>  kernel/gen_kheaders.sh | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
> index 473036b43..d2445af7f 100755
> --- a/kernel/gen_kheaders.sh
> +++ b/kernel/gen_kheaders.sh
> @@ -80,11 +80,20 @@ done | cpio --quiet -pdu $cpio_dir >/dev/null 2>&1
>  find $cpio_dir -type f -print0 |
>         xargs -0 -P8 -n1 perl -pi -e 'BEGIN {undef $/;}; s/\/\*((?!SPDX).=
)*?\*\///smg;'
>
> +# The following tar invocations use options specific to GNU tar. On some
> +# systems (e.g. Gentoo), `tar` can be a different tool (e.g. bsdtar), an=
d GNU
> +# tar can be found as `gtar`.
> +if [ -x "$(command -v gtar)" ]; then
> +       tar=3Dgtar
> +else
> +       tar=3Dtar
> +fi
> +
>  # Create archive and try to normalize metadata for reproducibility.
>  # For compatibility with older versions of tar, files are fed to tar
>  # pre-sorted, as --sort=3Dname might not be available.
>  find $cpio_dir -printf "./%P\n" | LC_ALL=3DC sort | \
> -    tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=3D$KBUILD_BUILD_TIMESTAMP}" \
> +    $tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=3D$KBUILD_BUILD_TIMESTAMP}" =
\
>      --owner=3D0 --group=3D0 --numeric-owner --no-recursion \
>      -I $XZ -cf $tarfile -C $cpio_dir/ -T - > /dev/null



I checked the options in bsd tar [1].

Presumably, there is no way to make it work for both
due to incompatible options (--owner vs --uid, --group vs --gid).


Instead of inserting a workaround like this,
another way is to allow users to override a variable
from the command line.


See the top Makefile, for example,


AWK             =3D awk


Then, users can do "make AWK=3Dgawk"





[1] https://www.freebsd.org/cgi/man.cgi?tar(1)






> --
> 2.39.0
>
