Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB36750D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjGLP4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjGLP4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:56:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7878FFB;
        Wed, 12 Jul 2023 08:56:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03E79618B4;
        Wed, 12 Jul 2023 15:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2A5C433CB;
        Wed, 12 Jul 2023 15:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689177360;
        bh=55xXchfz5zqRVrYF22tGshm6/d7zVQT3PRBBNpXtvDM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tqptt6ApYtfCJe/nxteJurpshJjhaKw185zUVmhyK0xlkbGM5NNHq/baZykp497XC
         6WQEiFR+UAAAZlGlGn7+7ECxsdVKQ5CTElF6ozEqEcThWPVGVMKSUo34o8/6XwE+vj
         upAGYitiw9vjOOXeGB61B3E1+9q9vCxgPLRp8oWAfuWf52tHAlEnISUqc9JxbIqhCY
         T/vR/roWUfICQssbKIi6GCGAiAAtm+iHjZoOFs+swiUvs0h9sOSmBrn4Plo0VdJ7Db
         5qjcH0fMLf4nyYwn6OkzeuqFqubkcMDMGJA5Q/YYMm/pQ1m2fuQ0I3GfS5TuPidfg2
         1FXDZNbez/W7w==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3a37909a64eso5115615b6e.1;
        Wed, 12 Jul 2023 08:56:00 -0700 (PDT)
X-Gm-Message-State: ABy/qLb4zV8jBmJGWMRn+x8a1GAE7mJ04BBJSDw9GYUtN+P8TWo13UP4
        70j5EWcumYzFhzg738I84bCD0/Bwav7ZyYXZEDo=
X-Google-Smtp-Source: APBJJlHUMAdockn4z7g4kk03gWerZuidBv27BqOiOXiFc+A7HlNRd3zVR+ycNVo+9U9EnA6IFpLknXnHUtDDQCwGbQI=
X-Received: by 2002:a05:6870:e307:b0:1b0:189c:87a0 with SMTP id
 z7-20020a056870e30700b001b0189c87a0mr20726096oad.41.1689177359663; Wed, 12
 Jul 2023 08:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230712015747.77263-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20230712015747.77263-1-wangkefeng.wang@huawei.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 13 Jul 2023 00:55:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNARuR5cturyngN31Oy=PwMG_-p5iOek2BuDSKHSyZg44Xg@mail.gmail.com>
Message-ID: <CAK7LNARuR5cturyngN31Oy=PwMG_-p5iOek2BuDSKHSyZg44Xg@mail.gmail.com>
Subject: Re: [PATCH -next] modpost: move some defines to the file head
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+To: Luis Chamberlain, the commiter of the breakage



On Wed, Jul 12, 2023 at 10:44=E2=80=AFAM Kefeng Wang <wangkefeng.wang@huawe=
i.com> wrote:
>
> with "module: Ignore RISC-V mapping symbols too", build error occurs,
>
> scripts/mod/modpost.c: In function =E2=80=98is_valid_name=E2=80=99:
> scripts/mod/modpost.c:1055:57: error: =E2=80=98EM_RISCV=E2=80=99 undeclar=
ed (first use in this function)
>   return !is_mapping_symbol(name, elf->hdr->e_machine =3D=3D EM_RISCV);
>
> Fix it by moving the EM_RISCV to the file head, also some other
> defines in case of similar problem in the future.



BTW, why is the flag 'is_riscv' needed?


All symbols starting with '$' look special to me.



Why not like this?


       if (str[0] =3D=3D '$')
                 return true;

       return false;






>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  scripts/mod/modpost.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 7c71429d6502..885cca272eb8 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -60,6 +60,22 @@ static unsigned int nr_unresolved;
>
>  #define MODULE_NAME_LEN (64 - sizeof(Elf_Addr))
>
> +#ifndef EM_RISCV
> +#define EM_RISCV               243
> +#endif
> +
> +#ifndef R_RISCV_SUB32
> +#define R_RISCV_SUB32          39
> +#endif
> +
> +#ifndef EM_LOONGARCH
> +#define EM_LOONGARCH           258
> +#endif
> +
> +#ifndef R_LARCH_SUB32
> +#define R_LARCH_SUB32          55
> +#endif
> +
>  void __attribute__((format(printf, 2, 3)))
>  modpost_log(enum loglevel loglevel, const char *fmt, ...)
>  {
> @@ -1428,22 +1444,6 @@ static int addend_mips_rel(uint32_t *location, Elf=
_Rela *r)
>         return 0;
>  }
>
> -#ifndef EM_RISCV
> -#define EM_RISCV               243
> -#endif
> -
> -#ifndef R_RISCV_SUB32
> -#define R_RISCV_SUB32          39
> -#endif
> -
> -#ifndef EM_LOONGARCH
> -#define EM_LOONGARCH           258
> -#endif
> -
> -#ifndef R_LARCH_SUB32
> -#define R_LARCH_SUB32          55
> -#endif
> -
>  static void section_rela(struct module *mod, struct elf_info *elf,
>                          Elf_Shdr *sechdr)
>  {
> --
> 2.41.0
>


--
Best Regards

Masahiro Yamada
