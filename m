Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883327068D1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjEQNCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjEQNCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:02:18 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB13F10EB
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:02:17 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2533ed4f1dcso580227a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684328537; x=1686920537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5AxAeCdhuBvApaM2VNWNpR5KDUG0yf5YyED4YO+eQA=;
        b=oOzu2jaD9jkQxFp/C6pdw/65JxoJTdqqUn1IncbHbJJnSqOvS3XDF8ki9Bxc0VELhl
         2vu8ShEJFZcH3m7N5hIz9qxjX/JaCY5/b7wDutu+gWVtl+nO8sxU5PuHiCu564O+ZUw3
         1V5G2t5yUXe+MJNjdh/0vjOmhHHiMWVbrGaFs3IRQ8149RJWXVZQbLohaTIlNpgbylHK
         T+AMpbEIiejf0rj0KSkV7Zidngkxt08yJotwRxkO6m8HN7NB+pcb2BZIolkgCZNNnEls
         TN+VjPiaptl+3yYvtHH7gTESFvrLrOowhWtCtLWw/mO0H0munPE62+EUHplhSy8Dr3w+
         ComQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684328537; x=1686920537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5AxAeCdhuBvApaM2VNWNpR5KDUG0yf5YyED4YO+eQA=;
        b=GcBAHMIYGHLJ9KJpZM5Q6gdf1oY6TuZPTM3DUQUy+h/HmcuEeyoDzSnuw+nXsjdIIs
         n3R8Qc5GAQLSZ55c+kmrRpUJFj0Dvv6SmmpkaBttEDzxzwlQkvEFGTWuAhuBcLwClG5Y
         r6TGMqOgFBhzdsLITrRU7w5U7IxBhq8tgLfhYyqlT8PvcAlGXWDAzf+reNCaEr3ggwKL
         qwXTm4vm6WkLwW5bazfxyjh6OZihvRRHzKBhci5c0sMisibOoPJ4Koqi1J/TqEsApBtH
         Dih2TbCEonEv+GQL9LP9NWR9rwGu6UF46Hkom7uKCA5XE/n4sSM4BgOgZIS+IvbzkzVU
         ro9g==
X-Gm-Message-State: AC+VfDy9Dkur91AO/8m/6MHhVKenMgqOvBUCtRYp/+zgqRVgMGcSkJLx
        Oj4HatwSugFbiwFjjAm9lAKzR0y8FFmHtL21fzg=
X-Google-Smtp-Source: ACHHUZ7QNLHezJKKgugcDY76WqtFsyRDPUdrP3VNrAmxpGJnnItHVANA8FASckIlsufnD4WgvoVUwVdScRLgfreQMIw=
X-Received: by 2002:a17:90a:f30d:b0:253:2c9b:2523 with SMTP id
 ca13-20020a17090af30d00b002532c9b2523mr4971288pjb.46.1684328536918; Wed, 17
 May 2023 06:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230515235713.232939-1-aford173@gmail.com> <20230515235713.232939-5-aford173@gmail.com>
 <a0debcb9251aa99326aec44235d39f84c6086096.camel@pengutronix.de>
In-Reply-To: <a0debcb9251aa99326aec44235d39f84c6086096.camel@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 17 May 2023 08:02:05 -0500
Message-ID: <CAHCN7xJZMu2u2gydmL9gF16Sd6wVX62kJRpzvZnhQLCtRm-zrQ@mail.gmail.com>
Subject: Re: [PATCH V6 4/6] drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, aford@beaconembedded.com,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>
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

On Wed, May 17, 2023 at 7:58=E2=80=AFAM Lucas Stach <l.stach@pengutronix.de=
> wrote:
>
> Am Montag, dem 15.05.2023 um 18:57 -0500 schrieb Adam Ford:
> > In order to support variable DPHY timings, it's necessary
> > to enable GENERIC_PHY_MIPI_DPHY so phy_mipi_dphy_get_default_config
> > can be used to determine the nominal values for a given resolution
> > and refresh rate.
> >
> I would just squash this one into the patch introducing the dependency.

I thought Kconfig updates were supposed to be on their own.  Is that
not correct?

adam
>
> Regards,
> Lucas
>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  drivers/gpu/drm/bridge/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kc=
onfig
> > index f076a09afac0..82c68b042444 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -227,6 +227,7 @@ config DRM_SAMSUNG_DSIM
> >       select DRM_KMS_HELPER
> >       select DRM_MIPI_DSI
> >       select DRM_PANEL_BRIDGE
> > +     select GENERIC_PHY_MIPI_DPHY
> >       help
> >         The Samsung MIPI DSIM bridge controller driver.
> >         This MIPI DSIM bridge can be found it on Exynos SoCs and
>
