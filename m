Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EA3706616
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjEQLF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjEQLFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:05:22 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1395B1987
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:05:07 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so8557481276.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1684321506; x=1686913506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/0gQgYqRuMuJwK1HCJXl/1oAzn1fx03WmCmc25oohc=;
        b=oq02hkTKUnnixI4jNHxsj43M3DOYL4409vzTHJlBnC5dOtuu9q+AuDtRkncdBb30ML
         E6rD+KaA3bdTaTWMu7MH1oUydS4CuRCCPxNvfmF/22eTcCnAAGcyOS8/wa2KORttgl6e
         4JvfdX+yriGtnzCQSttuNuLF1JnyqjTpWFNvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684321506; x=1686913506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/0gQgYqRuMuJwK1HCJXl/1oAzn1fx03WmCmc25oohc=;
        b=AN513RTXEkNbOjZdvty4ptoC0RGouZOiW042EJv7ys9vxR3fhmdF8pgo7/SNXH8GDI
         YHGgQWRuHsjzeXbgbbZwZa49OgwCRmWX1JuGbzF+K6I65A78eSy2qiHGzFnN6nDMVU8t
         KUjHLD05diELvQPqZwO48Gq7fX+JlXuCJGamOMz8bTm7ScdY0FyN5S7rRQvy2H62skyg
         wa0Gf9L9vilLKDsn/r28Xyrb+aDdO7R3IIkb+Iq6QLRTOgCxxTdLAMDtCh4USylce1Zx
         qP8QJ0IejBEnTRXrJLnljiYoYv+5fL3WpDQYGWZoCMc0pUM0YjYd0LVeV4ytxhw4DZB/
         T9Vw==
X-Gm-Message-State: AC+VfDxIBwxu1sGmMF5x/Kkqyq8nQDUODScLTWQQjQU4GPxxvsmlPZmj
        Q87R7OCrkBUucnJNpmEzCLT9Wr8EzdEn4y0VwfQE/g==
X-Google-Smtp-Source: ACHHUZ5WzbcltoYcBGwDo35dpjPWGwvHa0MuRLE3dPu6YZ22z9zqTPIAYUi4zrb5SdoB93c/+P4gzQ0EWN1h0Eo2OfY=
X-Received: by 2002:a25:324a:0:b0:b9e:67ab:4f36 with SMTP id
 y71-20020a25324a000000b00b9e67ab4f36mr1299048yby.10.1684321506246; Wed, 17
 May 2023 04:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230515235713.232939-1-aford173@gmail.com> <20230515235713.232939-5-aford173@gmail.com>
In-Reply-To: <20230515235713.232939-5-aford173@gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 17 May 2023 16:34:54 +0530
Message-ID: <CAMty3ZAU3NG8yk1dFB4Y3QtCZ7j7XUTqKHkJVKhhOduc4V5XpQ@mail.gmail.com>
Subject: Re: [PATCH V6 4/6] drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, aford@beaconembedded.com,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Inki Dae <inki.dae@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Tue, May 16, 2023 at 5:27=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
>
> In order to support variable DPHY timings, it's necessary
> to enable GENERIC_PHY_MIPI_DPHY so phy_mipi_dphy_get_default_config
> can be used to determine the nominal values for a given resolution
> and refresh rate.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/gpu/drm/bridge/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kcon=
fig
> index f076a09afac0..82c68b042444 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -227,6 +227,7 @@ config DRM_SAMSUNG_DSIM
>         select DRM_KMS_HELPER
>         select DRM_MIPI_DSI
>         select DRM_PANEL_BRIDGE
> +       select GENERIC_PHY_MIPI_DPHY

Is it really required? phy is optional as it is not required for
imx8mm/n/p as of now. May be we can add it while supporting it.

Thanks,
Jagan.
