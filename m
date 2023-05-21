Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA6D70ACAC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 08:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjEUGhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 02:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjEUGhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 02:37:04 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BBEEC;
        Sat, 20 May 2023 23:37:03 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-434834245c3so1500082137.0;
        Sat, 20 May 2023 23:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684651022; x=1687243022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNXWOz7UolGhGcbBAcgLcS0Q8bM1q+X2iGCobO7rdLA=;
        b=sQCY5/pidxzHE09Yg766989a2ysU7/HaceAkXm/1lI5TnG5+Vc27nEIWQBQhmQ6Nqk
         sOONm33e1bLrnjC8IU6+xjqOa4p6Ptt8x9YJLMyxlSlnrg+BkMuB9zl3y7ZGenBOG/nf
         T6/+zJVcCQghTnNysRPu9qxx+eAY111oXojzn8FM8f9U7n0UrVL7pViTG1XUrSoOdtBZ
         R3svAP0pvvf1jdhfc46xsTPVdV8e1X2UKJzvIMmdDOE15c00VWYRd9oYUWvqM2LIgdNW
         00VD9mIBjJ5u621/hb8Dkkg5f0cu1IBm8gKRAPphdKLokTflW3rzJ4FeHJi5fxFLX3l8
         H5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684651022; x=1687243022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNXWOz7UolGhGcbBAcgLcS0Q8bM1q+X2iGCobO7rdLA=;
        b=Z3m/nrDCqAVw7Higm+asBm40TZW6c1M7rgApY7N4CDmnW72LUvRIuByaSwz4/roSnE
         qOve7JmIYemAPz3yuXF+ZbGjsOu5GIX6B9lw900kc/v+Dq0zzA9LHCdzpWMgWqp1ZQA0
         DlqMf6uOCRjbPw4ns3OLtvvbHvlDGUeW2WrMsX0ik2KQr6P6/4Sn1P+6fvpsfNub1pCC
         77y+ItbYkqDeaIaeDis3L8M4PQGX4Q1KUXuMyexWRvSpP18pD8LA3tZx2wdtEgA6A/cy
         OR7f8P3aF1r20kfly2JX9NKuXO3vz2weAodIvO/Ddzest7btXsE1QB4e+cw2Y0qCiT+z
         pLFA==
X-Gm-Message-State: AC+VfDygJ08oiOevO9o7/PPIWbkY7yFR0YHzkanU4nv8aWiCU2ltWDV9
        N+i/9a25IsFnPr5YFl/GWa6BRrLHqFa/69q2JTS7mhwxOFw=
X-Google-Smtp-Source: ACHHUZ4Lg015Wd0pnzmRcl5ETKQG+12h8NkPBN5pZMfaIUo1dVN1MBAhQItqj69Hfnahaqs4ac74jfQY/xRuu4SNlhc=
X-Received: by 2002:a67:f1d2:0:b0:437:e767:5fa7 with SMTP id
 v18-20020a67f1d2000000b00437e7675fa7mr1596656vsm.3.1684651022142; Sat, 20 May
 2023 23:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230520184114.77725-1-andrea.righi@canonical.com> <20230520184114.77725-2-andrea.righi@canonical.com>
In-Reply-To: <20230520184114.77725-2-andrea.righi@canonical.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 21 May 2023 09:36:51 +0300
Message-ID: <CAOQ4uxgccn0CkaPqHB4ybD5f+yM+jTzm4BbpNHPFawTDC73KfQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ovl: Kconfig: introduce CONFIG_OVERLAY_FS_DEBUG
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 9:41=E2=80=AFPM Andrea Righi <andrea.righi@canonica=
l.com> wrote:
>
> Provide a Kconfig option to enable extra debugging checks for overlayfs.
>
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>

I think that could be useful someday...

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/Kconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/fs/overlayfs/Kconfig b/fs/overlayfs/Kconfig
> index 6708e54b0e30..fec5020c3495 100644
> --- a/fs/overlayfs/Kconfig
> +++ b/fs/overlayfs/Kconfig
> @@ -124,3 +124,12 @@ config OVERLAY_FS_METACOPY
>           that doesn't support this feature will have unexpected results.
>
>           If unsure, say N.
> +
> +config OVERLAY_FS_DEBUG
> +       bool "Overlayfs: turn on extra debugging checks"
> +       default n
> +       depends on OVERLAY_FS
> +       help
> +         Say Y here to enable extra debugging checks in overlayfs.
> +
> +         If unsure, say N.
> --
> 2.39.2
>
