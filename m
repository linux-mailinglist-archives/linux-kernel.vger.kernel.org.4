Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E27E6D8F4C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjDFGU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjDFGUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:20:54 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E58A93CC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 23:20:53 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id 89so27253983uao.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 23:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680762052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Kz8SNhi1cpYQJqD/AT3lCWMWGthZUaWRueclcoldFw=;
        b=mPvWNRiVsTupIoec66q+0JGs7s/4YhEwZZ04g/jmghXnDUFI/6nyTIM1XQon4YhQ+d
         sUeW9y2q+BiIUCu5oCuJ39jm6hTaGPLWUN9o/Hyw+LUaoZQ6CaysXslzfjHm/cOGUY3J
         luBsHTXmU8iyVg2z19eX9ALbgMcoSCgUvfohw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680762052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Kz8SNhi1cpYQJqD/AT3lCWMWGthZUaWRueclcoldFw=;
        b=JBezwc98n1kuXC1CQNFivYT9FRVhxI58QTlNb22TEsmAKePdxEZSbkkX1isRQKZsBR
         6D9Cbl1/9pjW6gNenz7Mb6z5UUnO0i8X87772eqgkI/YhqoL6f6oPVqPcBWFS21vr6Qu
         mRioccoXMGG+cGBK9YC6YaqrSpHVDU6uK45r5u5yyOCefq8pA86CmTcmJRLLi5AgKiwW
         9leiX7M9bRq/bUk3SFEDQxMNlSqbttqTbn9uSUNX7zTCgMSnc2k7fPuj+lbPS3W0YU8r
         snByRrjfa4jUb6YHcVs6IqIYugC++jOpndh+nyfn3xMqikmvA2MjWw84oLeEpNwd4WPY
         4Xcg==
X-Gm-Message-State: AAQBX9fFT7n/XyqL4XfeW5B0YeiuIUDjJlIaGBCgfMDvVX9WFsfyFJ6Y
        uwvzAyae1dXD85vZjvS/GD1f+G2k6pNGbI5yp4nK/g==
X-Google-Smtp-Source: AKy350Yp2FIaz+ilkqlK7ibx9rFilAky16tPkK48Dbsh+GzGOd0UvkGhSb+M4eo0JEvts5cE5ZH/AYrK9lJqHNhSarI=
X-Received: by 2002:a9f:3110:0:b0:68a:a9d:13f5 with SMTP id
 m16-20020a9f3110000000b0068a0a9d13f5mr6292638uab.1.1680762052315; Wed, 05 Apr
 2023 23:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230404104800.301150-1-angelogioacchino.delregno@collabora.com> <20230404104800.301150-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230404104800.301150-6-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 6 Apr 2023 14:20:41 +0800
Message-ID: <CAGXv+5HTPd_2r0Bb2nY94gUwWzpn_wvU_ZMYu6u9hWBeaVzrwA@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] drm/mediatek: dp: Change logging to dev for mtk_dp_aux_transfer()
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
        daniel@ffwll.ch, matthias.bgg@gmail.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 6:48=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Change logging from drm_{err,info}() to dev_{err,info}() in functions
> mtk_dp_aux_transfer() and mtk_dp_aux_do_transfer(): this will be
> essential to avoid getting NULL pointer kernel panics if any kind
> of error happens during AUX transfers happening before the bridge
> is attached.
>
> This may potentially start happening in a later commit implementing
> aux-bus support, as AUX transfers will be triggered from the panel
> driver (for EDID) before the mtk-dp bridge gets attached, and it's
> done in preparation for the same.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index ac21eca0e20e..19b145cf2e05 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -849,7 +849,7 @@ static int mtk_dp_aux_do_transfer(struct mtk_dp *mtk_=
dp, bool is_read, u8 cmd,
>                 u32 phy_status =3D mtk_dp_read(mtk_dp, MTK_DP_AUX_P0_3628=
) &
>                                  AUX_RX_PHY_STATE_AUX_TX_P0_MASK;
>                 if (phy_status !=3D AUX_RX_PHY_STATE_AUX_TX_P0_RX_IDLE) {
> -                       drm_err(mtk_dp->drm_dev,
> +                       dev_err(mtk_dp->dev,
>                                 "AUX Rx Aux hang, need SW reset\n");
>                         return -EIO;
>                 }
> @@ -2061,7 +2061,7 @@ static ssize_t mtk_dp_aux_transfer(struct drm_dp_au=
x *mtk_aux,
>                 is_read =3D true;
>                 break;
>         default:
> -               drm_err(mtk_aux->drm_dev, "invalid aux cmd =3D %d\n",
> +               dev_err(mtk_dp->dev, "invalid aux cmd =3D %d\n",
>                         msg->request);
>                 ret =3D -EINVAL;
>                 goto err;
> @@ -2077,7 +2077,7 @@ static ssize_t mtk_dp_aux_transfer(struct drm_dp_au=
x *mtk_aux,
>                                              to_access);
>
>                 if (ret) {
> -                       drm_info(mtk_dp->drm_dev,
> +                       dev_info(mtk_dp->dev,
>                                  "Failed to do AUX transfer: %d\n", ret);

This part no longer applies cleanly due to

    drm/mediatek: dp: Change the aux retries times when receiving AUX_DEFER

Also I think all these calls could be collapsed into one line?

ChenYu

>                         goto err;
>                 }
> --
> 2.40.0
>
