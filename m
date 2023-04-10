Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531C06DCE42
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjDJXqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDJXqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:46:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521A3127;
        Mon, 10 Apr 2023 16:46:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCE9C62025;
        Mon, 10 Apr 2023 23:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B11CC4339C;
        Mon, 10 Apr 2023 23:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681170375;
        bh=ba5WN/ob26DX2j1mfRdkuBNwsPAtlnnuxEuuEqLz1C8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H9YruaKzVwG77HOg7V50SBlKkzs0L51pVIn+o0XlRzgSEeQjCTLCBHL51cp/Pp47o
         4meAL5FtIiOMAXUiAhwr+S0s1SbsahrRtnTBu0BmUMHxF+N2b4fups362WRhGzpom3
         UqjN5KrpLNBc47sK33HYzc7saKKl18CJdgLvfQOuHVpqwC4I60cWc81/oNF4HD1b7b
         4795Id9pICDUj6QqoRtwa6hwmGN4VRK/lFbWPi6LHgL4Qt6unw+SHd9lAgcfslVrQg
         4vbGwzl5SfkOJ8/VyMtwnRhN9VY5ed8DnLNxZEwcGBS3IAH8MkvkEU+XtE8ktRrJIz
         8IsEikzPeRBBw==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1845f865452so2611157fac.12;
        Mon, 10 Apr 2023 16:46:15 -0700 (PDT)
X-Gm-Message-State: AAQBX9clFPArgb4f60u1I5nxGHXoGERmXwI2wPagk15rlFvih0QZb5aF
        WHaGUQ5ds8R5lmG2x7QbBuTceKCFBK3QpCxPI/Y=
X-Google-Smtp-Source: AKy350ZILWCd+oIsHOLpDJRwibeS8dcr/Le5Iys4XOH5R1JLJZkWZsJVo3kbTpNawnM7wvQ91VsMZSb/BF4gabBP9RQ=
X-Received: by 2002:a05:6870:e989:b0:17e:d308:7790 with SMTP id
 r9-20020a056870e98900b0017ed3087790mr5598150oao.11.1681170374514; Mon, 10 Apr
 2023 16:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230410011316.26564-1-rdunlap@infradead.org>
In-Reply-To: <20230410011316.26564-1-rdunlap@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 11 Apr 2023 08:45:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQGqF-9Tw1ZQQUTcn23P8AKy8YQwVy1BJtc5eX-WEZkUw@mail.gmail.com>
Message-ID: <CAK7LNAQGqF-9Tw1ZQQUTcn23P8AKy8YQwVy1BJtc5eX-WEZkUw@mail.gmail.com>
Subject: Re: [PATCH v2] sparc: allow sparc32 alias for archhelp
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 10:13=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Currently, entering
> $ make ARCH=3Dsparc32 help
> prints the archhelp text for sparc64.
>
> Since "sparc32" is documented (Documentation/kbuild/kbuild.rst)
> to be a recognized alias for 32-bit sparc, also support that
> string in sparc's archhelp by allowing either ARCH=3Dsparc or
> ARCH=3Dsparc32 for sparc32 archhelp.
>
> Fixes: 5e53879008b9 ("sparc,sparc64: unify Makefile")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> ---
> v2: rebase/resend; add Masahiro to Cc: list
>
>  arch/sparc/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -- a/arch/sparc/Makefile b/arch/sparc/Makefile
> --- a/arch/sparc/Makefile
> +++ b/arch/sparc/Makefile
> @@ -83,7 +83,7 @@ vdso_install:
>  KBUILD_IMAGE :=3D $(boot)/zImage
>
>  # Don't use tabs in echo arguments.
> -ifeq ($(ARCH),sparc)
> +ifeq ($(ARCH),$(filter $(ARCH),sparc sparc32))
>  define archhelp
>    echo  '* image        - kernel image ($(boot)/image)'


BTW, this is strange.


The asterisk means it is built by 'all'.


But, I only see the following in this Makefile.


# Default target
all: zImage





Seeing arch/sparc/boot/Makefile,
it is true $(boot)/image is generated
as a side-effect of zImage, but it it true for
both 32-bit and 64-bit.

I think it is even better to rewrite archhelp
to unify the 32/64 bits.





>    echo  '* zImage       - stripped kernel image ($(boot)/zImage)'



--=20
Best Regards
Masahiro Yamada
