Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263796C9241
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 05:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjCZDk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 23:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCZDk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 23:40:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E6B9EEA
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 20:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DED88B80B9E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 03:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C683C433D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 03:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679802021;
        bh=aNdHH/x3npE84NvqRHLCY4a1KFaMFDbk68uZH/TCbOs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mqXoKuS3szcQQU7SJQ3DWy7GX8vV7bOXRRp/wStTei8Lgx23P3zKIqvFF1dHYyoID
         YSCoViPQiazTr4ZjHqY45aU0teM30h2tsVMJRBjnjsUr8lDlv0y4uMrclcwhrUYbVf
         snBcGH7G1c/nrOQ8qRBzSVI1zxhOnFPaKZnbAx8wzQXXmz2rasxoWfbeHYFMtGdISo
         G4eK4HY/idazLi0FZhwy04EX4SDKeIeiDInCYr0uKBBTxsuGM4LVaEpBwUqDCrLj8z
         5DaDW2CsAkh9TCBrvNhTkOqfsixA1kY8jBO8G2ypBB4hC14OTOAMxjHae1Qnnn5uwD
         r5kiKYt6u/F6Q==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-17997ccf711so5969846fac.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 20:40:21 -0700 (PDT)
X-Gm-Message-State: AAQBX9eGrF3oz9pQ8lG13fEg6J842/I80tLT5FAECx7kmgErG2WTmhH6
        9VXojCgfSd/o6thjrsMkcAAHssVEs/5C5dHXlg0=
X-Google-Smtp-Source: AKy350a0iktmcIGh1E6nGTodhu+jOfBNrtXOtoCtrZFjAX1WRXhkOpRCPOvPOVaqQ2hqa6fBckTi4LOivah5bXdRdOM=
X-Received: by 2002:a05:6871:e86:b0:17e:d9e2:a55c with SMTP id
 vl6-20020a0568710e8600b0017ed9e2a55cmr2447043oab.11.1679802020793; Sat, 25
 Mar 2023 20:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230325143122.GA409315@mit.edu>
In-Reply-To: <20230325143122.GA409315@mit.edu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 26 Mar 2023 12:39:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNARndpbtzRAW1kEiqyNBmAxdqJKiTquvY9bW08LYTTMiOg@mail.gmail.com>
Message-ID: <CAK7LNARndpbtzRAW1kEiqyNBmAxdqJKiTquvY9bW08LYTTMiOg@mail.gmail.com>
Subject: Re: Change in kernel debian packages between -rc2 and -rc3
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 11:31=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrot=
e:
>
> Hi Masahiro,
>
> It appears that there is a backwards-incompatible (and, I believe,
> incorrect) change in the package version used when generated Debian
> packages between 6.2-rc2 and 6.2-rc3.
>
> I have CONFIG_LOCALVERSION set in my .config:
>
>    CONFIG_LOCALVERSION=3D"-xfstests"
>
> As a result, the uname -a of a kernel that I build contains -xfstests,
> e.g:
>
> root@kvm-xfstests:~# uname -r
> 6.3.0-rc3-xfstests-00043-g463f2e46bf7c
>
> Previously this would be correctly reflected in the Debian package
> version:
>
> % dpkg -I /build/linux-image-6.3.0-rc2-xfstests_6.3.0-rc2-xfstests-1016_a=
md64.deb
> ...
>  Package: linux-image-6.3.0-rc2-xfstests
>  Source: linux-6.3.0-rc2-xfstests
>  Version: 6.3.0-rc2-xfstests-1016
> ...
>
> However, after -rc3, the CONFIG_LOCALVERSION is no longer present in the =
package version:
>
> % dpkg -I /build/linux-image-6.3.0-rc3-xfstests-00043-g463f2e46bf7c_6.3.0=
-rc3-00043-g463f2e46bf7c-1017_amd64.deb
> ...
>  Package: linux-image-6.3.0-rc3-xfstests-00043-g463f2e46bf7c
>  Source: linux-6.3.0-rc3-xfstests-00043-g463f2e46bf7c
>  Version: 6.3.0-rc3-00043-g463f2e46bf7c-1017
> ...



I am afraid you are completely misunderstanding the two versions,
the ABI version and the package version.

They do not need to match. Actually, they do not match.

See real Debian (or Ubuntu) systems.


On Debian bullseye.


$ uname -r
5.10.0-21-amd64
$ dpkg-deb -I linux-image-5.10.0-21-amd64_5.10.162-1_amd64.deb
 [snip]
 Package: linux-image-5.10.0-21-amd64
 Source: linux-signed-amd64 (5.10.162+1)
 Version: 5.10.162-1
 Architecture: amd64




`uname -r` returns '5.10.0-21-amd64'.
This is what they call the ABI version, and
this is contained as a part of the package name,
'linux-image-5.10.0-21-amd64'

The package version is '5.10.162-1'

They are different.

This means the Debian kernel team built the kernel package
based on the stable kernel '5.10.162'.
The suffix '-1' indicates the Debian revision.
But, they gave a different uname '5.10.0-21-amd64'.



Get back to your question.

You set CONFIG_LOCALVERSION=3D"-xfstests".
It was reflected in 'uname -r' and in the package name.
This is correct.

It was _not_ reflected in the package version.
This is also correct since the package version
is not meant to reflect such user configuration
as CONFIG_LOCALVERSION.


The upstream version part '6.3.0-rc3-00043-g463f2e46bf7c'
represents the version of the source code.
In other words, it is determined by the git commit hash
(if you are using a git repository) and never affected by
CONFIG options or local files.

You can build multiple debian packages from the same git
commit hash, changing the .config, arch, or whatever.
In this case, the debian revision part, "-1017" is auto-incremented.

If you override the package version, you can use KDEB_PKGVERSION.





> Note the missing "-xfstests" in the above Version.  This also shows up
> in the name of the .deb file which is generated, and this is breaking
> my kernel build script[1].
>
> [1] https://github.com/tytso/xfstests-bld/blob/master/kernel-build/kbuild


This is just because your tool is wrong.
It was just working based on the wrong assumption.

Please fix it.





> I assume the problem is caused by one of these two commits:
>
> 36862e14e316 ("kbuild: deb-pkg: use dh_listpackages to know enabled packa=
ges")
> b611daae5efc ("kbuild: deb-pkg: split image and debug objects staging out=
 into functions")
>
> As these are the two commits which touch the builddeb script.
>
> Could you please take a look?
>
> Many thanks,
>
>                                                 - Ted



--=20
Best Regards
Masahiro Yamada
