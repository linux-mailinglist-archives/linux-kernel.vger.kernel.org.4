Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65531680828
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbjA3JFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbjA3JFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:05:51 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345242D17E;
        Mon, 30 Jan 2023 01:05:46 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id f34so17918643lfv.10;
        Mon, 30 Jan 2023 01:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLCAXpHbS1+35cXDsfgnrrYIidUGSDznuqt+LFz2Kpo=;
        b=B93D20grY8ixaFD84MbroYvYkrqlmHstoeTfuwxzoODbajqVlY28+EUIJCnZGL3eYM
         huRAq630DBO8DkJI6595oYyicBYF8Eh6mS7+ouJG9r8dRrx1F2dTzgzT5l8HC/kMFk2W
         69UrEapRmtkfe2j99vXYup/YdMx/nETF3d8JZtB5JUWs8NRF4R+0buMXfZJF0H3d4UwX
         GWvIv+fXLsdjY5al0DWqmYPhyI2V476WdgxwZR52vVQLF2MjC5zwXpXrKg8KZ7833KDb
         fDFTg02zuDc0vXqkRjXHuJpaRRkd15yy405valAeKVNxY4E5lIsPKwRP89yJ4gz6tGz0
         Nquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLCAXpHbS1+35cXDsfgnrrYIidUGSDznuqt+LFz2Kpo=;
        b=QmLkkuJxrX142BouRiXeyjbATfGvTuxSTcizPpiyrCpUJpKTj+86r7n4Uqrtsohvgj
         J0WMJH8SilYtke5kTZnymgmcaMihU7P5GTxTIUedQxszvPdugQzqNr0eU7kvGs6USgMa
         iKU/LLJTM+XRYfwpgsYOttsQTw0wZRllmr3j5KwSJ6wuL8TH99IJU6QHXwqOZFyf7PQu
         oeKSC47jgm4k4Teu6yErmCzxe2lEXwrP93180X7PitWKFEn5OvUrbSsmdJqA1oMC6Fer
         AcPxL+qIULjfDnCs3SPTIq4OxWhtUbnmLkRF3jq0CjgEBDNzUwkiOUD0d6L1WFuD91ZF
         FMAQ==
X-Gm-Message-State: AFqh2kr9rJhyHzkYhmtXpZPXjjIHL6zCVp9yIbxGw4BFi17/ziJCBMkK
        PMGg7ryQFzLabKfjcaAGK2icwbEg3rk6NW9lqnFmz+ra+IMl2w==
X-Google-Smtp-Source: AMrXdXt3tKUbF9CKwfmvskIYVhEVt8Sq7L1zFIeZ/3VPbZhmSyZMbTOSjYPcurdivSyy8lMZuEV1XCFm5QAX+7vvXp0=
X-Received: by 2002:a19:ae09:0:b0:4b5:2830:8998 with SMTP id
 f9-20020a19ae09000000b004b528308998mr2860087lfc.267.1675069544247; Mon, 30
 Jan 2023 01:05:44 -0800 (PST)
MIME-Version: 1.0
References: <Y9Tm1FiKBPKA2Tcx@localhost.localdomain>
In-Reply-To: <Y9Tm1FiKBPKA2Tcx@localhost.localdomain>
From:   Alex Shi <seakeel@gmail.com>
Date:   Mon, 30 Jan 2023 17:05:07 +0800
Message-ID: <CAJy-Am=qNEDUMi-K679a+uAZgegWmAgQS5_wKtbXX1ecX=ai4Q@mail.gmail.com>
Subject: Re: [PATCH] Doc/damon: fix the data path error
To:     Hui Su <suhui_kernel@163.com>
Cc:     sj@kernel.org, corbet@lwn.net, alexs@kernel.org,
        siyanteng@loongson.cn, rppt@kernel.org, bobwxc@email.cn,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alex Shi <alexsshi@kernel.org>

On Sat, Jan 28, 2023 at 5:12 PM Hui Su <suhui_kernel@163.com> wrote:
>
> %s/modules/module/
>
> Signed-off-by: Hui Su <suhui_kernel@163.com>
> ---
>  Documentation/admin-guide/mm/damon/lru_sort.rst               | 4 ++--
>  Documentation/admin-guide/mm/damon/reclaim.rst                | 4 ++--
>  .../translations/zh_CN/admin-guide/mm/damon/reclaim.rst       | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentat=
ion/admin-guide/mm/damon/lru_sort.rst
> index c09cace80651..7b0775d281b4 100644
> --- a/Documentation/admin-guide/mm/damon/lru_sort.rst
> +++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
> @@ -54,7 +54,7 @@ that is built with ``CONFIG_DAMON_LRU_SORT=3Dy``.
>  To let sysadmins enable or disable it and tune for the given system,
>  DAMON_LRU_SORT utilizes module parameters.  That is, you can put
>  ``damon_lru_sort.<parameter>=3D<value>`` on the kernel boot command line=
 or write
> -proper values to ``/sys/modules/damon_lru_sort/parameters/<parameter>`` =
files.
> +proper values to ``/sys/module/damon_lru_sort/parameters/<parameter>`` f=
iles.
>
>  Below are the description of each parameter.
>
> @@ -283,7 +283,7 @@ doesn't make progress and therefore the free memory r=
ate becomes lower than
>  20%, it asks DAMON_LRU_SORT to do nothing again, so that we can fall bac=
k to
>  the LRU-list based page granularity reclamation. ::
>
> -    # cd /sys/modules/damon_lru_sort/parameters
> +    # cd /sys/module/damon_lru_sort/parameters
>      # echo 500 > hot_thres_access_freq
>      # echo 120000000 > cold_min_age
>      # echo 10 > quota_ms
> diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentati=
on/admin-guide/mm/damon/reclaim.rst
> index 4f1479a11e63..d2ccd9c21b9a 100644
> --- a/Documentation/admin-guide/mm/damon/reclaim.rst
> +++ b/Documentation/admin-guide/mm/damon/reclaim.rst
> @@ -46,7 +46,7 @@ that is built with ``CONFIG_DAMON_RECLAIM=3Dy``.
>  To let sysadmins enable or disable it and tune for the given system,
>  DAMON_RECLAIM utilizes module parameters.  That is, you can put
>  ``damon_reclaim.<parameter>=3D<value>`` on the kernel boot command line =
or write
> -proper values to ``/sys/modules/damon_reclaim/parameters/<parameter>`` f=
iles.
> +proper values to ``/sys/module/damon_reclaim/parameters/<parameter>`` fi=
les.
>
>  Below are the description of each parameter.
>
> @@ -251,7 +251,7 @@ therefore the free memory rate becomes lower than 20%=
, it asks DAMON_RECLAIM to
>  do nothing again, so that we can fall back to the LRU-list based page
>  granularity reclamation. ::
>
> -    # cd /sys/modules/damon_reclaim/parameters
> +    # cd /sys/module/damon_reclaim/parameters
>      # echo 30000000 > min_age
>      # echo $((1 * 1024 * 1024 * 1024)) > quota_sz
>      # echo 1000 > quota_reset_interval_ms
> diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/reclai=
m.rst b/Documentation/translations/zh_CN/admin-guide/mm/damon/reclaim.rst
> index c976f3e33ffd..d15a2f20bb11 100644
> --- a/Documentation/translations/zh_CN/admin-guide/mm/damon/reclaim.rst
> +++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/reclaim.rst
> @@ -45,7 +45,7 @@ DAMON_RECLAIM=E6=89=BE=E5=88=B0=E5=9C=A8=E7=89=B9=E5=AE=
=9A=E6=97=B6=E9=97=B4=E5=86=85=E6=B2=A1=E6=9C=89=E8=A2=AB=E8=AE=BF=E9=97=AE=
=E7=9A=84=E5=86=85=E5=AD=98=E5=8C=BA=E5=9F=9F=E5=B9=B6=E5=88=86=E9=A1=B5=E3=
=80=82
>
>  =E4=B8=BA=E4=BA=86=E8=AE=A9=E7=B3=BB=E7=BB=9F=E7=AE=A1=E7=90=86=E5=91=98=
=E5=90=AF=E7=94=A8=E6=88=96=E7=A6=81=E7=94=A8=E5=AE=83=EF=BC=8C=E5=B9=B6=E4=
=B8=BA=E7=BB=99=E5=AE=9A=E7=9A=84=E7=B3=BB=E7=BB=9F=E8=BF=9B=E8=A1=8C=E8=B0=
=83=E6=95=B4=EF=BC=8CDAMON_RECLAIM=E5=88=A9=E7=94=A8=E4=BA=86=E6=A8=A1=E5=
=9D=97=E5=8F=82=E6=95=B0=E3=80=82=E4=B9=9F=E5=B0=B1
>  =E6=98=AF=E8=AF=B4=EF=BC=8C=E4=BD=A0=E5=8F=AF=E4=BB=A5=E6=8A=8A ``damon_=
reclaim.<parameter>=3D<value>`` =E6=94=BE=E5=9C=A8=E5=86=85=E6=A0=B8=E5=90=
=AF=E5=8A=A8=E5=91=BD=E4=BB=A4=E8=A1=8C=E4=B8=8A=EF=BC=8C=E6=88=96=E8=80=85=
=E6=8A=8A
> -=E9=80=82=E5=BD=93=E7=9A=84=E5=80=BC=E5=86=99=E5=85=A5 ``/sys/modules/da=
mon_reclaim/parameters/<parameter>`` =E6=96=87=E4=BB=B6=E3=80=82
> +=E9=80=82=E5=BD=93=E7=9A=84=E5=80=BC=E5=86=99=E5=85=A5 ``/sys/module/dam=
on_reclaim/parameters/<parameter>`` =E6=96=87=E4=BB=B6=E3=80=82
>
>  =E6=B3=A8=E6=84=8F=EF=BC=8C=E9=99=A4 ``=E5=90=AF=E7=94=A8`` =E5=A4=96=E7=
=9A=84=E5=8F=82=E6=95=B0=E5=80=BC=E5=8F=AA=E5=9C=A8DAMON_RECLAIM=E5=90=AF=
=E5=8A=A8=E6=97=B6=E5=BA=94=E7=94=A8=E3=80=82=E5=9B=A0=E6=AD=A4=EF=BC=8C=E5=
=A6=82=E6=9E=9C=E4=BD=A0=E6=83=B3=E5=9C=A8=E8=BF=90=E8=A1=8C=E6=97=B6=E5=BA=
=94=E7=94=A8=E6=96=B0
>  =E7=9A=84=E5=8F=82=E6=95=B0=E5=80=BC=EF=BC=8C=E8=80=8CDAMON_RECLAIM=E5=
=B7=B2=E7=BB=8F=E8=A2=AB=E5=90=AF=E7=94=A8=EF=BC=8C=E4=BD=A0=E5=BA=94=E8=AF=
=A5=E9=80=9A=E8=BF=87 ``=E5=90=AF=E7=94=A8`` =E7=9A=84=E5=8F=82=E6=95=B0=E6=
=96=87=E4=BB=B6=E7=A6=81=E7=94=A8=E5=92=8C=E9=87=8D=E6=96=B0=E5=90=AF=E7=94=
=A8=E5=AE=83=E3=80=82
> @@ -218,7 +218,7 @@ nr_quota_exceeds
>  =E5=B0=B1=E5=BC=80=E5=A7=8B=E7=9C=9F=E6=AD=A3=E7=9A=84=E5=B7=A5=E4=BD=9C=
=E3=80=82=E5=A6=82=E6=9E=9CDAMON_RECLAIM=E6=B2=A1=E6=9C=89=E5=8F=96=E5=BE=
=97=E8=BF=9B=E5=B1=95=EF=BC=8C=E5=9B=A0=E6=AD=A4=E7=A9=BA=E9=97=B2=E5=86=85=
=E5=AD=98=E7=8E=87=E4=BD=8E=E4=BA=8E20%=EF=BC=8C=E5=AE=83=E4=BC=9A=E8=A6=81=
=E6=B1=82
>  DAMON_RECLAIM=E5=86=8D=E6=AC=A1=E4=BB=80=E4=B9=88=E9=83=BD=E4=B8=8D=E5=
=81=9A=EF=BC=8C=E8=BF=99=E6=A0=B7=E6=88=91=E4=BB=AC=E5=B0=B1=E5=8F=AF=E4=BB=
=A5=E9=80=80=E5=9B=9E=E5=88=B0=E5=9F=BA=E4=BA=8ELRU=E5=88=97=E8=A1=A8=E7=9A=
=84=E9=A1=B5=E9=9D=A2=E7=B2=92=E5=BA=A6=E5=9B=9E=E6=94=B6=E4=BA=86::
>
> -    # cd /sys/modules/damon_reclaim/parameters
> +    # cd /sys/module/damon_reclaim/parameters
>      # echo 30000000 > min_age
>      # echo $((1 * 1024 * 1024 * 1024)) > quota_sz
>      # echo 1000 > quota_reset_interval_ms
> --
> 2.34.1
>
