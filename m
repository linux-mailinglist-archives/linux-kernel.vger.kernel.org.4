Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4A0711214
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjEYRYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjEYRYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:24:22 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CC51B6
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:23:53 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-625a9e2bf6bso5995866d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685035432; x=1687627432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VC9d8VClaITWEwUqcZuECdjYIAHc9o2yDDJtZ/g64PQ=;
        b=2N4wtctLmAyqgk6QelqOPqcr11aEX0XTiLh40tSKsZu79Sy4COrVl2Z8K24JocwdoW
         dYrKrwaD8bN2bpiI4Nj8B8J4QwFK0synUuMU+eXYSC7SVFXmh6xLIxPgyRADyiXO08qx
         XyqvzzB8Dlo3mUzMgMDiq69NcrW8vZIPXnVsTbx5a5ptd2l4gwXbTlCim583CyqVBudU
         nhQukbeip9nqQca6/H9rHUZnTOcIB12CDWbVikX1CXeKx1z5ztrqgpo/9/JWZ/0M1u1Q
         FbEXGOMuolY08JM1UdQRy7aokre5tRBznwdrNNHpmlM/GI3wUxk8x85j7+WvWasJ3M1f
         BcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685035432; x=1687627432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VC9d8VClaITWEwUqcZuECdjYIAHc9o2yDDJtZ/g64PQ=;
        b=WLGdWnHMr3gHlARosuBTEY1KmGcBWbPpcZ5dgo+i6ZT1B4fxwmGrYTXeae2vpZXrG4
         ZLor20vuU/VhMbCNPobYDr6jeOwFzly/1NT7Jj7zZrUdmw3MG7BCtut29AxiXN8IVfaB
         o1Ajrx7I4iJLKUDzxeq360FeYy6H+pzooQKe9ths32XQjQG83w2MvXn8ZZQFQTrAbVtt
         Sp+Q+PnL+2uamAtaQGZQIFPdHfQgWaXpmC9vnh/zDGmX68B6+X2mHGMn5C9yFBz1vLEx
         1vWByEKOSfftnUIDg/f1OZeVYopPGpC8yBAQXqjOsMMU9VPmq6V4pq8GES0WJJHOaCoD
         zupg==
X-Gm-Message-State: AC+VfDy5Wn/1xJxFGBMT/Q9XhhgiVZXbKPW/3pRkkR4kTqOpcyfHcZ6s
        A5U6rcgRkK1UsoBimH9DVLTZGnYeK3AQh1HDfxQJFO6KYEVNEpOaXUc=
X-Google-Smtp-Source: ACHHUZ4qe1nrt/7Y3nnUpJTssvtLZ9Ax5aXY+A9hbBKo1yMUqtOd2FwROyCyhdET7piu/JRXMZMAooTYMsxLsncG8LQ=
X-Received: by 2002:ad4:5bcf:0:b0:5ed:d3d:405 with SMTP id t15-20020ad45bcf000000b005ed0d3d0405mr1730001qvt.34.1685035431606;
 Thu, 25 May 2023 10:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230521160426.1881124-1-masahiroy@kernel.org> <20230521160426.1881124-10-masahiroy@kernel.org>
In-Reply-To: <20230521160426.1881124-10-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 May 2023 10:23:40 -0700
Message-ID: <CAKwvOdnjAM9tVe9M0+Gz4gsrHDUvjKuDdKZ_VpLiQEFk1=BnTw@mail.gmail.com>
Subject: Re: [PATCH v6 09/20] modpost: pass struct module pointer to check_section_mismatch()
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 9:05=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> The next commit will use it.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/mod/modpost.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 40fac4f64fcd..378fb9649545 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1229,7 +1229,7 @@ static void default_mismatch_handler(const char *mo=
dname, struct elf_info *elf,
>         }
>  }
>
> -static void check_section_mismatch(const char *modname, struct elf_info =
*elf,
> +static void check_section_mismatch(struct module *mod, struct elf_info *=
elf,
>                                    Elf_Sym *sym,
>                                    unsigned int fsecndx, const char *from=
sec,
>                                    Elf_Addr faddr, Elf_Addr taddr)
> @@ -1240,7 +1240,7 @@ static void check_section_mismatch(const char *modn=
ame, struct elf_info *elf,
>         if (!mismatch)
>                 return;
>
> -       default_mismatch_handler(modname, elf, mismatch, sym,
> +       default_mismatch_handler(mod->name, elf, mismatch, sym,
>                                  fsecndx, fromsec, faddr,
>                                  tosec, taddr);
>  }
> @@ -1358,7 +1358,7 @@ static int addend_mips_rel(struct elf_info *elf, El=
f_Shdr *sechdr, Elf_Rela *r)
>  #define R_LARCH_SUB32          55
>  #endif
>
> -static void section_rela(const char *modname, struct elf_info *elf,
> +static void section_rela(struct module *mod, struct elf_info *elf,
>                          Elf_Shdr *sechdr)
>  {
>         Elf_Rela *rela;
> @@ -1404,12 +1404,12 @@ static void section_rela(const char *modname, str=
uct elf_info *elf,
>                         break;
>                 }
>
> -               check_section_mismatch(modname, elf, elf->symtab_start + =
r_sym,
> +               check_section_mismatch(mod, elf, elf->symtab_start + r_sy=
m,
>                                        fsecndx, fromsec, r.r_offset, r.r_=
addend);
>         }
>  }
>
> -static void section_rel(const char *modname, struct elf_info *elf,
> +static void section_rel(struct module *mod, struct elf_info *elf,
>                         Elf_Shdr *sechdr)
>  {
>         Elf_Rel *rel;
> @@ -1459,7 +1459,7 @@ static void section_rel(const char *modname, struct=
 elf_info *elf,
>                         fatal("Please add code to calculate addend for th=
is architecture\n");
>                 }
>
> -               check_section_mismatch(modname, elf, elf->symtab_start + =
r_sym,
> +               check_section_mismatch(mod, elf, elf->symtab_start + r_sy=
m,
>                                        fsecndx, fromsec, r.r_offset, r.r_=
addend);
>         }
>  }
> @@ -1476,19 +1476,19 @@ static void section_rel(const char *modname, stru=
ct elf_info *elf,
>   * to find all references to a section that reference a section that wil=
l
>   * be discarded and warns about it.
>   **/
> -static void check_sec_ref(const char *modname, struct elf_info *elf)
> +static void check_sec_ref(struct module *mod, struct elf_info *elf)
>  {
>         int i;
>         Elf_Shdr *sechdrs =3D elf->sechdrs;
>
>         /* Walk through all sections */
>         for (i =3D 0; i < elf->num_sections; i++) {
> -               check_section(modname, elf, &elf->sechdrs[i]);
> +               check_section(mod->name, elf, &elf->sechdrs[i]);
>                 /* We want to process only relocation sections and not .i=
nit */
>                 if (sechdrs[i].sh_type =3D=3D SHT_RELA)
> -                       section_rela(modname, elf, &elf->sechdrs[i]);
> +                       section_rela(mod, elf, &elf->sechdrs[i]);
>                 else if (sechdrs[i].sh_type =3D=3D SHT_REL)
> -                       section_rel(modname, elf, &elf->sechdrs[i]);
> +                       section_rel(mod, elf, &elf->sechdrs[i]);
>         }
>  }
>
> @@ -1659,7 +1659,7 @@ static void read_symbols(const char *modname)
>                                              sym_get_data(&info, sym));
>         }
>
> -       check_sec_ref(modname, &info);
> +       check_sec_ref(mod, &info);
>
>         if (!mod->is_vmlinux) {
>                 version =3D get_modinfo(&info, "version");
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
