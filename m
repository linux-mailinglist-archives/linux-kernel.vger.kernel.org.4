Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063125E6AF0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiIVSag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiIVS3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:29:50 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A6510D0CD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:27:30 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id iw17so9631291plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=P2G+h7SMpgZAj0ir+cJJ3OrD93Kkyvw6av5m2/MqFrU=;
        b=EPPhzxlxohXjUEfjcoxBXBc2UpUI4B+r6Z/jngunTL0ICZiBTmGkOrX14rPtWysqEm
         hS2JQF9VSOQDmp1k32CpZI96IrRwOz7OtAaxDQnZMVDOQssBj/cEdTIzXFPP7WVQ+9sY
         9kwPJ8ZWPySmPsQ0rHoNML0SmSq+1q9CMp1gdems2EGTmYmxSlF5UYyZiX2Ckq+/gc8E
         OWZOUEdOWI/4UjRA7zo+Kbeen9ns9/AJsRS56rWLrae9D0IF3yHpa8vNkdeY6QIyQr6q
         rBCx4Skwvgy/b6Tx7Gk7XQLKEMV9S9mCh5EvC5ut/FVRcESOAKGAwHxt1k+4hviHkKZh
         Qk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=P2G+h7SMpgZAj0ir+cJJ3OrD93Kkyvw6av5m2/MqFrU=;
        b=gB2xnPLJrkx1p5Im9/7TynaGAqda/7bE3uuUEJhL4H2kmaIMK4wCkbiXTapEdWSRVR
         K1ecJw0RAvVjreoHtxPS6ti/142PIQI3DylQBfmFObBRCoHpBg9gtvuNcjojzALX9vl7
         kpv0DPqmf52x1OQkKV5NDM3AZ2QFzYx2Jh449LJkLirGwNd9WE6CcfktklzExfBDHDa6
         /3FgU7NcryWjssCAK/9r1CrSKrWbLAMQYtmaNCAzCYQjqUiXccGnbryIcIFxqn+Vg79+
         ITI6HC0TdTgRzLjKwiuJ/5ooZV2IxfTV1eiHlsVQy7wWex6aw8MjE/08bdczx+/V+FAo
         4DbA==
X-Gm-Message-State: ACrzQf1W+auCSx7q8uL3sWsrr5TN/LvcOOD5Z70bFSfTxHQ62qrjUEG3
        fYgSuhls7k843LHFAoTr0VA1lUFYija37woAwjs=
X-Google-Smtp-Source: AMsMyM47BxQFdeBclVFiRtxk1u1ErC3IOjGokQDFqiBDOYs8TbykT/gHzd/h2/dPblMPFgtU0qos6JQnYOYYO3L4acg=
X-Received: by 2002:a17:902:7e83:b0:177:e667:7841 with SMTP id
 z3-20020a1709027e8300b00177e6677841mr4505384pla.18.1663871225158; Thu, 22 Sep
 2022 11:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220922124306.34729-1-dev@pschenker.ch> <20220922124306.34729-5-dev@pschenker.ch>
In-Reply-To: <20220922124306.34729-5-dev@pschenker.ch>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Thu, 22 Sep 2022 20:26:54 +0200
Message-ID: <CABkfQAEZ1Dyqz=rh2yssq0=4sZrt9GRXJCseCQT-in7+cVrh4g@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/bridge: lt8912b: clarify lvds output status
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        David Airlie <airlied@linux.ie>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
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

Le jeu. 22 sept. 2022 =C3=A0 14:43, Philippe Schenker <dev@pschenker.ch> a =
=C3=A9crit :
>
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> Add comments on the lt8912_write_lvds_config() config to document the
> current settings and to make it clear that this is a hardcoded
> configuration not relevant for the HDMI output (could be removed without
> affecting the HDMI port).
>
> No changes on the actual register writes.
>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>
>  drivers/gpu/drm/bridge/lontium-lt8912b.c | 26 ++++++++++++++++--------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/b=
ridge/lontium-lt8912b.c
> index 5968f4af190b..3e870d45f881 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
> @@ -165,24 +165,32 @@ static int lt8912_write_rxlogicres_config(struct lt=
8912 *lt)
>         return ret;
>  };
>
> +/* enable LVDS output with some hardcoded configuration, not required fo=
r the HDMI output */
>  static int lt8912_write_lvds_config(struct lt8912 *lt)
>  {
>         const struct reg_sequence seq[] =3D {
> +               // lvds power up
>                 {0x44, 0x30},
>                 {0x51, 0x05},
> -               {0x50, 0x24},
> -               {0x51, 0x2d},
> -               {0x52, 0x04},
> -               {0x69, 0x0e},
> +
> +               // core pll bypass
> +               {0x50, 0x24}, // cp=3D50uA
> +               {0x51, 0x2d}, // Pix_clk as reference, second order passi=
ve LPF PLL
> +               {0x52, 0x04}, // loopdiv=3D0, use second-order PLL
> +               {0x69, 0x0e}, // CP_PRESET_DIV_RATIO
>                 {0x69, 0x8e},
>                 {0x6a, 0x00},
> -               {0x6c, 0xb8},
> +               {0x6c, 0xb8}, // RGD_CP_SOFT_K_EN,RGD_CP_SOFT_K[13:8]
>                 {0x6b, 0x51},
> -               {0x04, 0xfb},
> +
> +               {0x04, 0xfb}, // core pll reset
>                 {0x04, 0xff},
> -               {0x7f, 0x00},
> -               {0xa8, 0x13},
> -               {0x02, 0xf7},
> +
> +               // scaler bypass
> +               {0x7f, 0x00}, // disable scaler
> +               {0xa8, 0x13}, // 0x13: JEIDA, 0x33: VESA
> +
> +               {0x02, 0xf7}, // lvds pll reset
>                 {0x02, 0xff},
>                 {0x03, 0xcf},
>                 {0x03, 0xff},
> --
> 2.37.3
>
