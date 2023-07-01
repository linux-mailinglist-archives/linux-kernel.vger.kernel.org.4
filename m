Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69CC744676
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 06:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjGAEJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 00:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGAEJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 00:09:04 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB4492;
        Fri, 30 Jun 2023 21:09:03 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1b060bce5b0so2470194fac.3;
        Fri, 30 Jun 2023 21:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688184542; x=1690776542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gmp02HtvALfXppfVORZkmyM+4q1wj8f4w8M8Ul8HhUU=;
        b=XJ62a32uNQpAOgoP+2tFi09+ybi1NHkreO6Qhafgs2KU/RYVmRMb2yysi0PmYiQXP9
         R9Xe0dRES/ZAZhfWU4n2z3aKS4u2JfyWlmVPMY/Hil8rNFb9dQBcA1fmWDm9O+dRR95F
         yHHacarfhihD+ECAJO1Q6eW5NzVKdT3O0D6pQ89LFkt4vmwXUfcmQ9NX2Zh3TtJuXa6I
         QL2+LfGQQKX5HDiLa+lqLqER7ThttLggtuRnIw5sGgfKzFhvlKJb5p6wT/X4DmLdORcw
         PkvpQNiLqH/36bf7v8ryzcWjNiMn5Tqvb1cb/8uTgDF41mPvC/l/0JQFQDzzE5sUUj8b
         q0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688184542; x=1690776542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gmp02HtvALfXppfVORZkmyM+4q1wj8f4w8M8Ul8HhUU=;
        b=BZuXUiIcTFKux4zVNlK/Ayp3UMGJsR9Wc+kDd1HtRlLVO8oZdOZPvgXvjGIaFaTjr5
         wvqtAeqAsBl+41Qg6vSOLR9hUGUohyv6xMrhp13+eaPBNEsb89G6h6zYLwl2b4PlhkoG
         g6+zXpesnrqCC7R2dRwTqE5bThgkjRfnK2m/eei2Zag8tkcd30TQlzUMJKhAUuV6yY6Y
         T3aGsjZUQBXewPXQ7JFvBfERTulhXyl27JcXeNiaXrkLtRhqX9+se8bGoPhh/+tY60uH
         mAj8eTDCYTHM0JsKpJEv2O0oYMVkRWNpjy9Us9j12hbeK2y2W24cTjCbasviVtuVmYua
         U+7w==
X-Gm-Message-State: ABy/qLbtzbYKatQqNNUbFQbgMbDhgMbiqM3nXnstn68RCUQjvqpI9xc0
        D9xSdYTvyRXAAAH8RN6wmUsVU+mSPDcw8MaXYZS+j1RP9kA=
X-Google-Smtp-Source: ACHHUZ7sOj4+1Pb/Pan9nZ1J2Cxwgrzxlj4jClkk0wyIivSGd4JZX3nbgmp3ZnpbjVwynzrsDwdazoqERa+9meuMrvE=
X-Received: by 2002:a05:6871:42cf:b0:1b0:68f7:da6 with SMTP id
 lt15-20020a05687142cf00b001b068f70da6mr5975800oab.6.1688184542396; Fri, 30
 Jun 2023 21:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230629160351.2996541-1-masahiroy@kernel.org> <20230629160351.2996541-2-masahiroy@kernel.org>
In-Reply-To: <20230629160351.2996541-2-masahiroy@kernel.org>
From:   Jesse T <mr.bossman075@gmail.com>
Date:   Sat, 1 Jul 2023 00:08:51 -0400
Message-ID: <CAJFTR8Txd-6-=5RSoHhgg1a6mr4rEAUv2Ta1F5OLsC3NC4U-Sw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kconfig: menuconfig: remove jump_key::index
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 12:03=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> You do not need to remember the index of each jump key because you can
> count it up after a key is pressed.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/kconfig/expr.h  | 1 -
>  scripts/kconfig/mconf.c | 7 ++++---
>  scripts/kconfig/menu.c  | 8 --------
>  3 files changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
> index 9c9caca5bd5f..4a9a23b1b7e1 100644
> --- a/scripts/kconfig/expr.h
> +++ b/scripts/kconfig/expr.h
> @@ -275,7 +275,6 @@ struct jump_key {
>         struct list_head entries;
>         size_t offset;
>         struct menu *target;
> -       int index;
>  };
>
>  extern struct file *file_list;
> diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
> index 7adfd6537279..fcb91d69c774 100644
> --- a/scripts/kconfig/mconf.c
> +++ b/scripts/kconfig/mconf.c
> @@ -22,8 +22,6 @@
>  #include "lkc.h"
>  #include "lxdialog/dialog.h"
>
> -#define JUMP_NB                        9
> -
>  static const char mconf_readme[] =3D
>  "Overview\n"
>  "--------\n"
> @@ -399,6 +397,7 @@ static int handle_search_keys(int key, int start, int=
 end, void *_data)
>  {
>         struct search_data *data =3D _data;
>         struct jump_key *pos;
> +       int index =3D '1';
>
>         if (key < '1' || key > '9')
>                 return 0;
> @@ -408,11 +407,13 @@ static int handle_search_keys(int key, int start, i=
nt end, void *_data)
>                         if (pos->offset >=3D end)
>                                 break;
>
> -                       if (key =3D=3D '1' + (pos->index % JUMP_NB)) {
> +                       if (key =3D=3D index) {
>                                 data->target =3D pos->target;
>                                 return 1;
>                         }
>                 }
> +
> +               index =3D next_key(index);
>         }
>
>         return 0;
> diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
> index 5578b8bc8a23..198eb1367e7a 100644
> --- a/scripts/kconfig/menu.c
> +++ b/scripts/kconfig/menu.c
> @@ -735,15 +735,7 @@ static void get_prompt_str(struct gstr *r, struct pr=
operty *prop,
>         }
>         if (head && location) {
>                 jump =3D xmalloc(sizeof(struct jump_key));
> -
>                 jump->target =3D location;
> -
> -               if (list_empty(head))
> -                       jump->index =3D 0;
> -               else
> -                       jump->index =3D list_entry(head->prev, struct jum=
p_key,
> -                                                entries)->index + 1;
> -
>                 list_add_tail(&jump->entries, head);
>         }
>
> --
> 2.39.2
>

Looks good!
Reviewed-by: Jesse Taube <Mr.Bossman075@gmail.com>

One slight off-topic question.
The names of the menu-based config programs have names similar to their
corresponding file gconfig ('gconf'), xconfig ('qconf'), menuconfig ('mconf=
'),
and nconfig ('nconf'). The only exceptions to this one-letter naming are mc=
onfig
is not memuconfig and qconfig isn't xconfig. Would it be possible to
add an alias
to fix this?

Side-side note config isn't in the docs.

Thanks,
Jesse Taube
