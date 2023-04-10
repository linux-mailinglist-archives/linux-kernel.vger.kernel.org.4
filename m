Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926676DCE27
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjDJXeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDJXeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:34:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC034185;
        Mon, 10 Apr 2023 16:34:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A2F762003;
        Mon, 10 Apr 2023 23:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5D1C433EF;
        Mon, 10 Apr 2023 23:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681169648;
        bh=4qjKROyCkLTd3tcqm+HtKEyO5cWift9JMeTdnjSFJsc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LbOBOCJdqc8rQMbsKdsk/HEABg4FDzYb5Rx0YEGzbBCJ/hMpXjeoT67UOx7o+JhcZ
         3EsAcTOE/GCX816H+E6HpgvUIZlotZU3HzX65EiF5zSoiUzPjkRwNUpK7mMLNXud7r
         w3nqPKz65EAyZ7B+Cbr2r1nGskCO2oGGV/0PQiPMCDiUpTBJFEJgCpByWhh7D6ghY4
         aKde5VUgKpGhXp5GTWCqBXns5H4w2uDHRKR+Zd+zc72gsEZL/lP+i+x8wb6DYaRDop
         pNfWvYTPeqDH7oNhrQoCn3S3f1WPHtuQaWcwpl3/MItPkHZtUYx+YN4RvbXB0AB43A
         DC8OyBuM/4ZNw==
Received: by mail-oo1-f48.google.com with SMTP id s19-20020a4adb93000000b00540fa505f2dso4364294oou.7;
        Mon, 10 Apr 2023 16:34:08 -0700 (PDT)
X-Gm-Message-State: AAQBX9diXWY4lVleFbTmZO+ZpmOF1UTiTYDmveqv/241A4uD/ysMNzjl
        N1HsmN1v+tfaboQopVJbT+X4NaqcJbanqDJSJD4=
X-Google-Smtp-Source: AKy350YJRB31Ym8057B3A1ckaL5w1WbJ2oB6Gg438inR9m/dE35xc+XqkqvVhT7LRC3DFs+LWGhoF2v1uQvLsRkHKoY=
X-Received: by 2002:a4a:c803:0:b0:541:c1bf:e46f with SMTP id
 s3-20020a4ac803000000b00541c1bfe46fmr2218305ooq.1.1681169648120; Mon, 10 Apr
 2023 16:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230410011316.26564-1-rdunlap@infradead.org>
In-Reply-To: <20230410011316.26564-1-rdunlap@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 11 Apr 2023 08:33:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQRpbNSwzaG-O95hZdUGa43ubXN-PU8WhpUcDth2f50JQ@mail.gmail.com>
Message-ID: <CAK7LNAQRpbNSwzaG-O95hZdUGa43ubXN-PU8WhpUcDth2f50JQ@mail.gmail.com>
Subject: Re: [PATCH v2] sparc: allow sparc32 alias for archhelp
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
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


ifneq ($(ARCH),sparc64)

is simpler.





>  define archhelp
>    echo  '* image        - kernel image ($(boot)/image)'
>    echo  '* zImage       - stripped kernel image ($(boot)/zImage)'



--=20
Best Regards
Masahiro Yamada
