Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C5A6E7ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbjDSPp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbjDSPpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:45:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6CBA5D5;
        Wed, 19 Apr 2023 08:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20BB963CB5;
        Wed, 19 Apr 2023 15:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BA0C433A0;
        Wed, 19 Apr 2023 15:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681919107;
        bh=90/tbLhV1ayXAjshEn/Ria2dF5WRQsSyCH03+eREOJc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s8uo2ZzagsbAOEk23kn6eQh/sW+2gj9qRvXTVv7AyUQMn7PH9TO3+WnO09ss9M1yq
         7PRwnTdQnwonVvkv2Wu30dwc42VxhDcCvlxDLC4n+c402I+KV0pkkC4QRwcXKldqEq
         AiUU9UFgx7Jxx7INXCmH/PZ1La+SDfbLXNQ17I8Jrg4XQUDypid/gdbW5lBnU8xk43
         UUlTQV85ThCyImKOPGWrHDBim9HgyjnZzppFdZYOkeVpzs+5OQVcARqOBxRBYkfNKT
         As2gJoXlPx8NxE9IjrHKvS8wuUloziFo4NiNwi9rEGvsJxOSWjT2T1W0nyb24Otjlx
         w55wiXN+Ure8w==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6a5e7482961so895663a34.3;
        Wed, 19 Apr 2023 08:45:07 -0700 (PDT)
X-Gm-Message-State: AAQBX9fU/S7GZNPkyBh2FQQK/gkPE50K6lE/ipRGOlAOEGBbqKnUdgNX
        bdOShRySdxlYbiLd2tMRzpofGpqFa0uXXZ/k/OM=
X-Google-Smtp-Source: AKy350awxs0egxRonUq1BNIltf2oXCLUHFnYsxjk327cz2GTGYOHoUZge6aRtUP8EgIkT9l3f5KVzRj6W1Rs7wIFT3Q=
X-Received: by 2002:a05:6870:1687:b0:184:af3:910d with SMTP id
 j7-20020a056870168700b001840af3910dmr80817oae.32.1681919106743; Wed, 19 Apr
 2023 08:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_76F930F42F060E84C8BFA5440D0A35A17209@qq.com>
In-Reply-To: <tencent_76F930F42F060E84C8BFA5440D0A35A17209@qq.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 20 Apr 2023 00:44:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQys34ptXW+-OPnR22pDVvHZf0JEKy5-=ufFdOu0jBU-Q@mail.gmail.com>
Message-ID: <CAK7LNAQys34ptXW+-OPnR22pDVvHZf0JEKy5-=ufFdOu0jBU-Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rpm-pkg: fix rpm-pkg build error
To:     29581992@qq.com
Cc:     nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        sunjw10@lenovo.com
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

On Wed, Apr 19, 2023 at 12:18=E2=80=AFPM <29581992@qq.com> wrote:
>
> From: Jiwei Sun <sunjw10@lenovo.com>
>
> The following error will trigger when building rpm-pkg
> $ make rpm-pkg
>   SYNC    include/config/auto.conf.cmd
>   HOSTLD  scripts/kconfig/conf
>   UPD     include/config/kernel.release
>   UPD     .tmp_HEAD
>   ARCHIVE linux.tar.gz
> sh ./scripts/package/mkspec >./kernel.spec
> rpmbuild  --target x86_64-linux -bs kernel.spec \
> --define=3D'_smp_mflags %{nil}' --define=3D'_sourcedir rpmbuild/SOURCES' =
--define=3D'_srcrpmdir .'
> Building target platforms: x86_64-linux
> Building for target x86_64-linux
> Wrote: ./kernel-6.3.0_rc7-47.src.rpm
> rpmbuild  --target x86_64-linux -rb kernel-6.3.0_rc7-47.src.rpm \
> --define=3D'_smp_mflags %{nil}'
> Installing kernel-6.3.0_rc7-47.src.rpm
> Building target platforms: x86_64-linux
> Building for target x86_64-linux
> Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.QtGSXP
> + umask 022
> + cd /mnt/datapart/rpmbuild/BUILD
> + cd /mnt/datapart/rpmbuild/BUILD
> + rm -rf linux
> + /usr/bin/gzip -dc /mnt/datapart/rpmbuild/SOURCES/linux.tar.gz
> + /usr/bin/tar -xof -
> + STATUS=3D0
> + '[' 0 -ne 0 ']'
> + cd linux
> /var/tmp/rpm-tmp.QtGSXP: line 40: cd: linux: No such file or directory
> error: Bad exit status from /var/tmp/rpm-tmp.QtGSXP (%prep)
>
> There is linux.tar, not linux, and the linux.tar.gz is create by the foll=
owing
>  quiet_cmd_archive =3D ARCHIVE $@
>        cmd_archive =3D git -C $(srctree) $(git-config-tar$(suffix $@)) ar=
chive \
>                      --output=3D$$(realpath $@) --prefix=3D$(basename $@)=
/ $(archive-args)
> Here the $@ is linux.tar.gz, and $(basename $@) will be linux.tar,
> The above fact is the cause, so use $(basename $(basename $@)) to get the=
 right directory name.
>
> Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
> ---
>  scripts/Makefile.package | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index 4d90691505b1..3718ecdf9edf 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -49,7 +49,7 @@ git-config-tar.zst =3D -c tar.tar.zst.command=3D"$(ZSTD=
)"
>
>  quiet_cmd_archive =3D ARCHIVE $@
>        cmd_archive =3D git -C $(srctree) $(git-config-tar$(suffix $@)) ar=
chive \
> -                    --output=3D$$(realpath $@) --prefix=3D$(basename $@)=
/ $(archive-args)
> +                    --output=3D$$(realpath $@) --prefix=3D$(basename $(b=
asename $@))/ $(archive-args)


Thanks for the report and patch, but
this would introduce another regression for
'make perf-tar-src-pkg'.

If you run it on the mainline
the file name will be "perf-6.3.0-rc7.tar"

The inner $(basename ...) will strip ".tar",
then the outer $(basename ...) will strip ".0-rc7".

The resulting prefix will become "perf-6.3/"
while the expected prefix is "pref-6.3.0-rc7/".




>
>  # Linux source tarball
>  # ----------------------------------------------------------------------=
-----
> --
> 2.27.0
>


--=20
Best Regards
Masahiro Yamada
