Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DBD66037C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbjAFPj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbjAFPjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:39:16 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943A776803;
        Fri,  6 Jan 2023 07:39:15 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1322d768ba7so1877095fac.5;
        Fri, 06 Jan 2023 07:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOU74MfLltUT+h+F/CrT1EH2iRW8ZoWBGIJbj4ikcZg=;
        b=kCHCa/r/NH7je4QvL7iXn+mGinMO0F8rBjuPT2QnoR6UCmONeCpDaIl710U7xlpmT6
         ikc1XvbZrH2G6v6Ld0fca1JWE5cOEg+kijfMUaFDYx835qxVEn/NO4CRdNIV1hXhLi6O
         rrlxk+4D9lTSqnIgV2F/N+SXbUbcjK/Jzijiqx247t8iDkut1B0x8qPdt36ZE01G1QZW
         /5R0EoDpcDbcFNpofc0nZGeQSzfXDpRT+ZaQn6YmnNmhgSospP8Ca2nKXFCRIl9L06qc
         0O0Hf1tAT1axF1D8RPs/Aprow4ZU5Du+LmsxjuIoYb/wQtuBG8ejJ4PRaBaX6KY3PrTK
         u6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOU74MfLltUT+h+F/CrT1EH2iRW8ZoWBGIJbj4ikcZg=;
        b=F06yqebb7xDQZgx5Q9Unc1dyLa0uAdcBtIxE/hScAQSQTFAAZQwheUupor8i7YfVHL
         /zACm1DuV6124XiE7mRVsXnzpyIPj6tX8ljTSSJPIicc8Kc5ykFykjWIfyn+zxMmjz04
         jANegVLyW2V8+MlYOlI2hPtmf9BRpndzlOgv0VuiWj+1HF0Uv1yW+i1oK3MyeAG9jx1P
         DW7ZmZZ+tgiJaRn3i1y3xSPHqczD8Ec1p+OFxXkzw6zBTXoYHaSaBiLOJn/XCGs0+YGR
         mvgkoTVlr3M1aRsUUsE0GdZkUHfUcJhMPcy3etpLSZhFdWg79hGTk/j0SHG/cjC2nuPR
         QYeQ==
X-Gm-Message-State: AFqh2kpznEWAIdcvsF+Ykyw8/xa8crhN01WjTbc8/hMU/dClaH2trXWC
        dEopLJfOM6cFMYlg4EdMmLx3UyWvzklUPQBRVMY=
X-Google-Smtp-Source: AMrXdXt0/0Yzb/5d06C0pGHF7OeoMwC1Beik/HhdgRVorPYXTJ/t6Z10/P3fO3icF9eUsmYUsIHQhJSZPSADJk9q0Qw=
X-Received: by 2002:a05:6870:c59c:b0:150:d9aa:4011 with SMTP id
 ba28-20020a056870c59c00b00150d9aa4011mr1145315oab.96.1673019554943; Fri, 06
 Jan 2023 07:39:14 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221227082932.798359-1-geert@linux-m68k.org> <alpine.DEB.2.22.394.2212270933530.311423@ramsan.of.borg>
In-Reply-To: <alpine.DEB.2.22.394.2212270933530.311423@ramsan.of.borg>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 6 Jan 2023 10:39:03 -0500
Message-ID: <CADnq5_PtJ2JxAH7vaQsMHomUmiAxhiOqn4suf1SAQkaqt=sg+g@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.2-rc1
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-mips@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-f2fs-devel@lists.sourceforge.net, kasan-dev@googlegroups.com,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 10:34 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> On Tue, 27 Dec 2022, Geert Uytterhoeven wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v6.2-rc1[1] compared to v6.1[2].
> >
> > Summarized:
> >  - build errors: +11/-13
>
> amd-gfx@lists.freedesktop.org
> linux-arm-kernel@lists.infradead.org
> linux-media@vger.kernel.org
> linux-wireless@vger.kernel.org
> linux-mips@vger.kernel.org
> linux-sh@vger.kernel.org
> linux-f2fs-devel@lists.sourceforge.net
> linuxppc-dev@lists.ozlabs.org
> kasan-dev@googlegroups.com
> linux-xtensa@linux-xtensa.org
>
>    + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/displ=
ay_mode_vba_31.c: error: the frame size of 2224 bytes is larger than 2048 b=
ytes [-Werror=3Dframe-larger-than=3D]:  =3D> 7082:1
>    + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/disp=
lay_mode_vba_314.c: error: the frame size of 2208 bytes is larger than 2048=
 bytes [-Werror=3Dframe-larger-than=3D]:  =3D> 7127:1
>

@Siqueira, Rodrigo @Mahfooz, Hamza

Can you take a look at fixing the DML stack size here up?

Alex


> arm64-gcc5/arm64-allmodconfig
>
>    + /kisskb/src/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c: error: a=
rray subscript 2 is above array bounds of 'u32[2]' {aka 'unsigned int[2]'} =
[-Werror=3Darray-bounds]:  =3D> 641:28
>    + /kisskb/src/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c: error: a=
rray subscript 3 is above array bounds of 'u32[2]' {aka 'unsigned int[2]'} =
[-Werror=3Darray-bounds]:  =3D> 641:28
>
> m68k-gcc8/m68k-allmodconfig
> See also https://lore.kernel.org/all/CAMuHMdWpPX2mpqFEWjjbjsQvDBQOXyjjdpK=
nQu9qURAuVZXmMw@mail.gmail.com
>
>    + /kisskb/src/include/linux/bitfield.h: error: call to '__field_overfl=
ow' declared with attribute error: value doesn't fit into mask:  =3D> 151:3
>
> In function 'u32_encode_bits',
>      inlined from 'ieee80211_mlo_multicast_tx' at /kisskb/src/net/mac8021=
1/tx.c:4435:17,
>      inlined from 'ieee80211_subif_start_xmit' at /kisskb/src/net/mac8021=
1/tx.c:4483:3:
>
> mipsel-gcc5/mips-allmodconfig
>
>    + /kisskb/src/include/linux/compiler_types.h: error: call to '__compil=
etime_assert_262' declared with attribute error: Unsupported access size fo=
r {READ,WRITE}_ONCE().:  =3D> 358:45
>    + /kisskb/src/include/linux/compiler_types.h: error: call to '__compil=
etime_assert_263' declared with attribute error: Unsupported access size fo=
r {READ,WRITE}_ONCE().:  =3D> 358:45
>
> In function 'follow_pmd_mask',
>      inlined from 'follow_pud_mask' at /kisskb/src/mm/gup.c:735:9,
>      inlined from 'follow_p4d_mask' at /kisskb/src/mm/gup.c:752:9,
>      inlined from 'follow_page_mask' at /kisskb/src/mm/gup.c:809:9:
>
> sh4-gcc11/sh-defconfig (G=C3=BCnter wondered if pmd_t should use union)
>
>    + /kisskb/src/include/linux/fortify-string.h: error: '__builtin_memcpy=
' offset [0, 127] is out of the bounds [0, 0] [-Werror=3Darray-bounds]:  =
=3D> 57:33
>
> /kisskb/src/arch/s390/kernel/setup.c: In function 'setup_lowcore_dat_on':
> s390x-gcc11/s390-all{mod,yes}config
>
>    + /kisskb/src/include/linux/fortify-string.h: error: '__builtin_memset=
' pointer overflow between offset [28, 898293814] and size [-898293787, -1]=
 [-Werror=3Darray-bounds]:  =3D> 59:33
>
> /kisskb/src/fs/f2fs/inline.c: In function 'f2fs_move_inline_dirents':
>
> powerpc-gcc11/ppc64_book3e_allmodconfig
> powerpc-gcc11/powerpc-all{mod,yes}config
>
>    + /kisskb/src/kernel/kcsan/kcsan_test.c: error: the frame size of 1680=
 bytes is larger than 1536 bytes [-Werror=3Dframe-larger-than=3D]:  =3D> 25=
7:1
>
> xtensa-gcc11/xtensa-allmodconfig (patch available)
>
>    + {standard input}: Error: unknown pseudo-op: `.cfi_def_c':  =3D> 1718
>
> sh4-gcc11/sh-allmodconfig (ICE =3D internal compiler error)
>
> > [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/1b929c02afd37=
871d5afb9d498426f83432e71c2/ (all 152 configs)
> > [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/830b3c68c1fb1=
e9176028d02ef86f3cf76aa2476/ (all 152 configs)
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                                             -- Linus Torv=
alds
