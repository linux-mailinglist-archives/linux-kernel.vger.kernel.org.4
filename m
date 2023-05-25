Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6CE7116A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243542AbjEYTBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243935AbjEYTAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:00:44 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF645619B
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:49:44 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d2467d640so100776b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685040500; x=1687632500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctZyno1jlRx7ypzgPMMZHkRj+UPDt+eB6LEWuTexkNk=;
        b=nWf03vCbYQ4cSj5twnUKfWZNpNtdKeyrVndu6CmTxmboCjwxbTKsgT3QiC4qrIwQeU
         MzhG7uNwcle9zKHMy4pd7C/dTFOIQbapP/MQnSw4WS6utNKtjKAsgFr1XcInUCymrYk1
         +YSrwt1HZS0LFZEGMQX4Im07MdQafXuoDDvpAGCKmyPs5BNFTVJj7fQ8P10eOMXfbZzP
         Up0qWrqwQUdu7HjfGoryhNl9Sj+YHplJoJI93EeqRe4TCPvL/bEmpAKEjq/DAJ4DeXYY
         gdAfNpFGrw0FqtuR73DEIauwvnxrHxAMu6BxFrL4KpMwOY1sBb1NqUc6Cpgj1cJOc/Ln
         t8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685040500; x=1687632500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctZyno1jlRx7ypzgPMMZHkRj+UPDt+eB6LEWuTexkNk=;
        b=Ai/BjWzKCjl8MqjkWjoT2IqtjIuDmEZnW9t1MjECmuctv+YSjTVSCa9vOaSEOrj/cV
         QLeSAP+UZiBgyItKcnd2lj7mi0rAW+vpXwDq3M1JgLrrrktsYAf6Kd6fNtXq1xmM46pb
         TNqMzauZrGKSnJhd39nG7mkw/Ynnn7jMwoc9Wwv1FEeoBQswzMWWUdGsYNiBqj+mo0DC
         uKxmtQGUT0QGfbPsvK+y+x3q6haXTeSk8bbqEqX32M9jA88EHZMACZaDfSQK2Q+TrFy4
         kLiwfzmYnUDMjTK5VU+nbsM34yE4heKD7toljo+LZU5k08yPBd4k7XRPMedhjfVB971i
         9taA==
X-Gm-Message-State: AC+VfDyzOFG6iLjRPeDALRrwwG2ELZVToejZcYR67hNtuzrB8ZQtw2QO
        pCxFAC4oj7qhGjivSVoIaSdTPnho3VKOaonvrudmnbavfmuUptfGRf7/yA==
X-Google-Smtp-Source: ACHHUZ7MG6eA+ZeuNFc1YY9P7eZcgIycX4tYDYofQ9DZFSMsEXI9wnymJAzJNO0AjjZcZCxsOstMfpF1NSBZLycVjA8=
X-Received: by 2002:a05:6214:130b:b0:621:451b:6e1c with SMTP id
 pn11-20020a056214130b00b00621451b6e1cmr2470051qvb.6.1685039794889; Thu, 25
 May 2023 11:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230521160426.1881124-1-masahiroy@kernel.org> <20230521160426.1881124-18-masahiroy@kernel.org>
In-Reply-To: <20230521160426.1881124-18-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 May 2023 11:36:23 -0700
Message-ID: <CAKwvOdnv-=eXtgwuZ8URz_FjnUansgg3MeuGGRf2C=Wr+VGkrA@mail.gmail.com>
Subject: Re: [PATCH v6 17/20] modpost: merge bad_tosec=ALL_EXIT_SECTIONS
 entries in sectioncheck table
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
> There is no distinction between TEXT_TO_ANY_EXIT and DATA_TO_ANY_EXIT.
> Just merge them.

Can something similar be done for ALL_PCI_INIT_SECTIONS and
ALL_XXXINIT_SECTIONS? (as a follow up)

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/mod/modpost.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index aea9d6cd243d..b5f7f4811c39 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -844,8 +844,7 @@ static const char *const optim_symbols[] =3D { "*.con=
stprop.*", NULL };
>  enum mismatch {
>         TEXT_TO_ANY_INIT,
>         DATA_TO_ANY_INIT,
> -       TEXT_TO_ANY_EXIT,
> -       DATA_TO_ANY_EXIT,
> +       TEXTDATA_TO_ANY_EXIT,
>         XXXINIT_TO_SOME_INIT,
>         XXXEXIT_TO_SOME_EXIT,
>         ANY_INIT_TO_ANY_EXIT,
> @@ -888,14 +887,9 @@ static const struct sectioncheck sectioncheck[] =3D =
{
>         .mismatch =3D DATA_TO_ANY_INIT,
>  },
>  {
> -       .fromsec =3D { TEXT_SECTIONS, NULL },
> +       .fromsec =3D { TEXT_SECTIONS, DATA_SECTIONS, NULL },
>         .bad_tosec =3D { ALL_EXIT_SECTIONS, NULL },
> -       .mismatch =3D TEXT_TO_ANY_EXIT,
> -},
> -{
> -       .fromsec =3D { DATA_SECTIONS, NULL },
> -       .bad_tosec =3D { ALL_EXIT_SECTIONS, NULL },
> -       .mismatch =3D DATA_TO_ANY_EXIT,
> +       .mismatch =3D TEXTDATA_TO_ANY_EXIT,
>  },
>  /* Do not reference init code/data from meminit code/data */
>  {
> @@ -1162,8 +1156,7 @@ static void default_mismatch_handler(const char *mo=
dname, struct elf_info *elf,
>         switch (mismatch->mismatch) {
>         case TEXT_TO_ANY_INIT:
>         case DATA_TO_ANY_INIT:
> -       case TEXT_TO_ANY_EXIT:
> -       case DATA_TO_ANY_EXIT:
> +       case TEXTDATA_TO_ANY_EXIT:
>         case XXXINIT_TO_SOME_INIT:
>         case XXXEXIT_TO_SOME_EXIT:
>         case ANY_INIT_TO_ANY_EXIT:
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
