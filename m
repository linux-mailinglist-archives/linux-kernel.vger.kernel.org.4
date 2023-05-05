Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6096F8871
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjEESKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjEESKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:10:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6F818911
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:10:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62C6A63FC2
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE0EC433A7
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683310229;
        bh=bOlduRXRE2CmVm5OdOFE0fJpR9HoKc1/4AJwBj0XMUM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GuTudXBdsQrSS/Ys36+HWbku4Rug5v8wdn3J5L97LVIxIg/zV7RSUeSCKMXAxFFrK
         tivrTSe0DmUWN8Hm+zHxFX6pA0Vywg2a1OpPLNMh0oXaKeXtwgnB/Az4xhs+zClWPI
         2gAM52H9MBvLi7TA7+R9MYbhO8EHaeQ2BLskhb95KA/+LL39MShZrTKAGrs2g8C8fy
         dOAutWvn4lg2RUoYJj29gPEtWqOcFlw8dYBEgtV4/XTc3dV+vpZvmdKvPQBqYkkTlD
         jaYVxDGRUZwFGhfhh+7o4+OyskSdzlLaSuqHMRrEZfgJRInIoISmroO4cUdvTzEYKL
         wSoub8aXom8QA==
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1aaebed5bd6so14632415ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 11:10:29 -0700 (PDT)
X-Gm-Message-State: AC+VfDx4T3C7tsgVcZIGl6NmVU4/UkcNeQcrMuliePbPp37g226p13wl
        PG84RC7/SLIRwxTgbj/wdke6eOaxe6Pm9apZAU/ngg==
X-Google-Smtp-Source: ACHHUZ5733YTKhW8VCiZE7bfxgTgjjKBDJWIqOYm6AgXRyny/hmS3UwsqHS8yD0sV2qwRwGpW/bsFLYNik+hZCxWA9A=
X-Received: by 2002:a17:90a:e7cb:b0:24d:d50f:95d2 with SMTP id
 kb11-20020a17090ae7cb00b0024dd50f95d2mr2431889pjb.22.1683310229260; Fri, 05
 May 2023 11:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230427142934.55435-1-francesco@dolcini.it> <20230427142934.55435-10-francesco@dolcini.it>
In-Reply-To: <20230427142934.55435-10-francesco@dolcini.it>
From:   Robert Foss <rfoss@kernel.org>
Date:   Fri, 5 May 2023 20:10:18 +0200
X-Gmail-Original-Message-ID: <CAN6tsi7Cwnr0tv03SDX6vJQVeLF0JmCOxk9gwesZDThWLiXONA@mail.gmail.com>
Message-ID: <CAN6tsi7Cwnr0tv03SDX6vJQVeLF0JmCOxk9gwesZDThWLiXONA@mail.gmail.com>
Subject: Re: [PATCH v1 9/9] drm/bridge: tc358768: remove unused variable
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        tomi.valkeinen@ideasonboard.com, dri-devel@lists.freedesktop.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 4:34=E2=80=AFPM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> Remove the unused phy_delay_nsk variable, before it was wrongly used
> to compute some register value, the fixed computation is no longer using
> it and therefore can be removed.
>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  drivers/gpu/drm/bridge/tc358768.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/t=
c358768.c
> index 947c7dca567a..d3af42a16e69 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -641,7 +641,7 @@ static void tc358768_bridge_pre_enable(struct drm_bri=
dge *bridge)
>         u32 val, val2, lptxcnt, hact, data_type;
>         s32 raw_val;
>         const struct drm_display_mode *mode;
> -       u32 dsibclk_nsk, dsiclk_nsk, ui_nsk, phy_delay_nsk;
> +       u32 dsibclk_nsk, dsiclk_nsk, ui_nsk;
>         u32 dsiclk, dsibclk, video_start;
>         const u32 internal_delay =3D 40;
>         int ret, i;
> @@ -725,11 +725,9 @@ static void tc358768_bridge_pre_enable(struct drm_br=
idge *bridge)
>                                   dsibclk);
>         dsiclk_nsk =3D (u32)div_u64((u64)1000000000 * TC358768_PRECISION,=
 dsiclk);
>         ui_nsk =3D dsiclk_nsk / 2;
> -       phy_delay_nsk =3D dsibclk_nsk + 2 * dsiclk_nsk;
>         dev_dbg(priv->dev, "dsiclk_nsk: %u\n", dsiclk_nsk);
>         dev_dbg(priv->dev, "ui_nsk: %u\n", ui_nsk);
>         dev_dbg(priv->dev, "dsibclk_nsk: %u\n", dsibclk_nsk);
> -       dev_dbg(priv->dev, "phy_delay_nsk: %u\n", phy_delay_nsk);
>
>         /* LP11 > 100us for D-PHY Rx Init */
>         val =3D tc358768_ns_to_cnt(100 * 1000, dsibclk_nsk) - 1;
> --
> 2.25.1
>

Reviewed-by: Robert Foss <rfoss@kernel.org>
