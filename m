Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825B167FBD6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 00:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjA1XbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 18:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjA1XbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 18:31:22 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9238D1C5BD;
        Sat, 28 Jan 2023 15:31:19 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o20so13894944lfk.5;
        Sat, 28 Jan 2023 15:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I0S3B5PU0WSUcNuHyr1ZtmRb3x1+XFor4xpSEEFcyEE=;
        b=o1jprqTqTnaJ47gNeIwm9EbYvAI/0rr6zGeOvntePSEWWxCmabKNsHdi6IkHAruUiI
         jF44IJDhWCDM4BNfKHJVLocX84JZW2AKazEUlRdM1zP+72iEd6m1lIV9fJiIR3RqjSkI
         bvlbSU7c4jpo7JMqhUaLcqLE78p4tE3zvS9kNcDn0bCDa/sfCQkxNakj15FLrjvwqQgN
         /+1IJdCXasE6KvQnzzMHZJq5sgkKrmAvGFYzAqIc8LkLjAS8SilZo6aFuFI3c2n0qYNi
         bhf+0WduvyXGsm/weGiGuJj1mMu0JObc9UKpqfwLI1a5faj7TezU4fgqUX75q7cw3m5n
         IadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0S3B5PU0WSUcNuHyr1ZtmRb3x1+XFor4xpSEEFcyEE=;
        b=QHHsaCNgpoCaZ5K4qCr2iJPbRQiBnjKBsBrwExrfsSqX6JngsmKLZbCOyRpd74Fgkj
         67swL6PPFRxJY+E7UTRoANksriHxckotH2CRbZMpXFB2ip8NlWW/lIeWMu7HdI6HWXfC
         pt0kb0IHJWn3hSMQHFXizcZedO8UExtQmh+oyJoHgiHhn1IU78NH+5sh/tltatgBFzI1
         ClAv0ZvCLeU0pnixPxNA9uFYyWC3180ohUmG0XrZS8J6aATzpn8f4EkNNlZUaRslR1R5
         PUfPmZrbMGcVbue2Zp3RgCYCqAcaS6gzdMmZ7I1KvmCSrjsG1U8FdQHYBicty5YqQPpf
         4e3A==
X-Gm-Message-State: AO0yUKWi1kzjspqqKPUT4InHhNgaq/4OhKHkE3uyZO+2t2hgHghXxuth
        IDPDp0xG95O6CRs2kL91aOnimkIyxTSv0NNghFc=
X-Google-Smtp-Source: AK7set/fVQq6PZZoBWoE3stX7Y00RBCgPwhDtkEBaVRmWzHDHLpg96Vnov8LOYXQoXWxhIexEmfkJ7DaihD6KesnMAs=
X-Received: by 2002:ac2:538a:0:b0:4d8:580b:2f23 with SMTP id
 g10-20020ac2538a000000b004d8580b2f23mr623686lfh.132.1674948677422; Sat, 28
 Jan 2023 15:31:17 -0800 (PST)
MIME-Version: 1.0
References: <20230128173843.765212-1-masahiroy@kernel.org> <20230128173843.765212-2-masahiroy@kernel.org>
In-Reply-To: <20230128173843.765212-2-masahiroy@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 29 Jan 2023 00:30:40 +0100
Message-ID: <CA+icZUWTdAihUVSjEgV2BVOVCktUYccd--9y3bv18PrJDX5nhw@mail.gmail.com>
Subject: Re: [PATCH 2/4] kbuild: deb-pkg: create source package without cleaning
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev
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

On Sat, Jan 28, 2023 at 6:40 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> If you run 'make deb-pkg', all objects are lost due to 'make clean',
> which makes the incremental builds impossible.
>
> Instead of cleaning, pass the exclude list to tar's --exclude-from
> option.
>
> Previously, *.diff.gz contained some check-in files such as
> .clang-format, .cocciconfig.
>
> With this commit, *.diff.gz will only contain the .config and debian/.
> The other source files will go into the tarball.
>

Thanks for the patch.

While at this...

...why not switch over to Debian's packaging default XZ compressor:
*.orig.xz and *.diff.xz (or *.debian.tar.xz)?

EXAMPLE binutils:

DSC: http://deb.debian.org/debian/pool/main/b/binutils/binutils_2.40-2.dsc
TAR: http://deb.debian.org/debian/pool/main/b/binutils/binutils_2.40.orig.tar.xz
DIFF: http://deb.debian.org/debian/pool/main/b/binutils/binutils_2.40-2.debian.tar.xz

-Sedat-

[1] https://packages.debian.org/sid/binutils

> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/Makefile.package | 27 ++++++++++++++++++++++-----
>  scripts/package/mkdebian | 27 +++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index dfbf40454a99..cb135c99a273 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -50,6 +50,21 @@ fi ; \
>  tar -I $(KGZIP) -c $(RCS_TAR_IGNORE) -f $(2).tar.gz \
>         --transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3)
>
> +# Source Tarball
> +# ---------------------------------------------------------------------------
> +
> +quiet_cmd_exclude_list = GEN     $@
> +      cmd_exclude_list = $(srctree)/scripts/gen-exclude.py --prefix=./ --rootdir=$(srctree) > $@; echo "./$@" >> $@
> +
> +.exclude-list: FORCE
> +       $(call cmd,exclude_list)
> +
> +quiet_cmd_tar = TAR     $@
> +      cmd_tar = tar -I $(KGZIP) -c -f $@ -C $(srctree) --exclude-from=$< --exclude=./$@ --transform 's:^\.:linux:S' .
> +
> +%.tar.gz: .exclude-list
> +       $(call cmd,tar)
> +
>  # rpm-pkg
>  # ---------------------------------------------------------------------------
>  PHONY += rpm-pkg
> @@ -81,12 +96,11 @@ binrpm-pkg:
>
>  PHONY += deb-pkg
>  deb-pkg:
> -       $(MAKE) clean
>         $(CONFIG_SHELL) $(srctree)/scripts/package/mkdebian
> -       $(call cmd,src_tar,$(KDEB_SOURCENAME))
> -       origversion=$$(dpkg-parsechangelog -SVersion |sed 's/-[^-]*$$//');\
> -               mv $(KDEB_SOURCENAME).tar.gz ../$(KDEB_SOURCENAME)_$${origversion}.orig.tar.gz
> -       +dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) --source-option=-sP -i.git -us -uc
> +       $(Q)origversion=$$(dpkg-parsechangelog -SVersion |sed 's/-[^-]*$$//');\
> +               $(MAKE) -f $(srctree)/scripts/Makefile.package ../$(KDEB_SOURCENAME)_$${origversion}.orig.tar.gz
> +       +dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) \
> +               --build=source,binary --source-option=-sP -nc -us -uc
>
>  PHONY += bindeb-pkg
>  bindeb-pkg:
> @@ -174,4 +188,7 @@ help:
>         @echo '  perf-tarxz-src-pkg  - Build $(perf-tar).tar.xz source tarball'
>         @echo '  perf-tarzst-src-pkg - Build $(perf-tar).tar.zst source tarball'
>
> +PHONY += FORCE
> +FORCE:
> +
>  .PHONY: $(PHONY)
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index c3bbef7a6754..12c057ffbe6e 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -84,6 +84,8 @@ set_debarch() {
>         fi
>  }
>
> +rm -rf debian
> +
>  # Some variables and settings used throughout the script
>  version=$KERNELRELEASE
>  if [ -n "$KDEB_PKGVERSION" ]; then
> @@ -135,6 +137,31 @@ fi
>  mkdir -p debian/source/
>  echo "1.0" > debian/source/format
>
> +cat<<'EOF' > debian/source/local-options
> +#
> +# Ugly: ignore anything except .config or debian/
> +# (is there a cleaner way to do this?)
> +#
> +diff-ignore
> +
> +extend-diff-ignore = ^[^.d]
> +
> +extend-diff-ignore = ^\.[^c]
> +extend-diff-ignore = ^\.c($|[^o])
> +extend-diff-ignore = ^\.co($|[^n])
> +extend-diff-ignore = ^\.con($|[^f])
> +extend-diff-ignore = ^\.conf($|[^i])
> +extend-diff-ignore = ^\.confi($|[^g])
> +extend-diff-ignore = ^\.config.
> +
> +extend-diff-ignore = ^d($|[^e])
> +extend-diff-ignore = ^de($|[^b])
> +extend-diff-ignore = ^deb($|[^i])
> +extend-diff-ignore = ^debi($|[^a])
> +extend-diff-ignore = ^debia($|[^n])
> +extend-diff-ignore = ^debian[^/]
> +EOF
> +
>  echo $debarch > debian/arch
>  extra_build_depends=", $(if_enabled_echo CONFIG_UNWINDER_ORC libelf-dev:native)"
>  extra_build_depends="$extra_build_depends, $(if_enabled_echo CONFIG_SYSTEM_TRUSTED_KEYRING libssl-dev:native)"
> --
> 2.34.1
>
