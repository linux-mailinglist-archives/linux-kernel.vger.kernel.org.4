Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50DF5E6AEF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiIVSab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiIVS3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:29:05 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A4E1114C2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:26:57 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id u69so9983092pgd.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=x/KOEzvs5/HZ3ITyDMwqUGxQmeTcr0AR1wyo8XABotg=;
        b=oAxyP8tCqeYuU1oeTTDzPYwAqW0TWMjBk4MNm/Q9k1jDviJ2qcMy7OceSjh3XrlXt+
         WrJ+yOR5ex/qDj8dt7tlnl2XGCAvoZO8td+AMezzfYRVUPdslh8eBR95OmSePwMdsY5w
         3xtyQTxmWE5Q4RNdohSNfkLFDqoCcD6ufLevaPyBO+DVdoEXzu0mo/PRJJWJFqFvcSwK
         sGOo1/zyIuhLmTPgLaKUvqllYvtcrC4IFp5CsofhcgxRVcvSocTW/e6ptYefbqGssPoJ
         jRCb4UK8zF68zyaR3bjkUAx621UjF9YuaXrpLkf2noW4zTj6hS6l28jZypsbhXvdHYQg
         ZfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=x/KOEzvs5/HZ3ITyDMwqUGxQmeTcr0AR1wyo8XABotg=;
        b=3ErSGq7emEO/OJahwivt8eNRqI5YA2C9rIeDF8RVRpOAdLsCPwxxLZiLqlofz9PytY
         vlOejYD0uaz3kmLSQzNAw4LG47/tSSDvnVflEPMFznrbRlZ7KsqwBfhAKC6cY0R6WR1h
         IzgOE+fBtaBmYkshodBvLL9uhX6N1i0qqRooaGmtl4CXzDJQvNNwQqPHaGuvHUZLc95C
         Cg+cCHYpEGVPo+wudyb1zAfY1ZjhLZgU4olUv/H8D3camMkrzdFH6xTHj/+mIN5srieN
         OvgHPS87SethIXq7sG9goF8A6hPfLbNxgfCuSiB+z7Y/NAooB/8f+aVa8ixcmb3QT6QQ
         eloQ==
X-Gm-Message-State: ACrzQf0jbV60PPmHgARtuAGrinrbdE8LdQ3Mm9tbLTo0+zOnJaHJBWUS
        Z4OcgvYDhpDT6mv7JsKVfmyET+sv6UTln3CABT0=
X-Google-Smtp-Source: AMsMyM7SjLqOheQS7Tgisez4lt6X6IFltXK5bMjjFxT+e/IvOiU4nqQZoLfrUtCqjnkJetnfbLjFO+igd7zFPPgDyZs=
X-Received: by 2002:a63:1f49:0:b0:43b:a2df:857 with SMTP id
 q9-20020a631f49000000b0043ba2df0857mr4244126pgm.137.1663871165524; Thu, 22
 Sep 2022 11:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220922124306.34729-1-dev@pschenker.ch> <20220922124306.34729-3-dev@pschenker.ch>
In-Reply-To: <20220922124306.34729-3-dev@pschenker.ch>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Thu, 22 Sep 2022 20:25:54 +0200
Message-ID: <CABkfQAFLAMtj2yV3tCrjcVN70K2F4y4R31mHqm49oeoPcs3KHQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/bridge: lt8912b: set hdmi or dvi mode
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
> From: Philippe Schenker <philippe.schenker@toradex.com>
>
> The Lontium LT8912 does have a setting for DVI or HDMI. This patch reads
> from EDID what the display needs and sets it accordingly.
>
> Fixes: 30e2ae943c26 ("drm/bridge: Introduce LT8912B DSI to HDMI bridge")
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>
>  drivers/gpu/drm/bridge/lontium-lt8912b.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/b=
ridge/lontium-lt8912b.c
> index 0fd3472e767c..6a4bb7422176 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
> @@ -323,6 +323,8 @@ static int lt8912_video_setup(struct lt8912 *lt)
>                                   vsync_activehigh ? BIT(0) : 0);
>         ret |=3D regmap_update_bits(lt->regmap[I2C_MAIN], 0xab, BIT(1),
>                                   hsync_activehigh ? BIT(1) : 0);
> +       ret |=3D regmap_update_bits(lt->regmap[I2C_MAIN], 0xb2, BIT(0),
> +                                 lt->connector.display_info.is_hdmi ? BI=
T(0) : 0);
>
>         return ret;
>  }
> --
> 2.37.3
>
