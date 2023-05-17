Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1ED70667C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjEQLSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjEQLSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:18:18 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB495FE4
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:18:03 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-561d249f045so2852017b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1684322276; x=1686914276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WCELhKKHIosJqimbc1keXrYAK+9jP7I652VYp3oomc=;
        b=Sr9bMRUCBLk/cK5Y7vzL4ws/XWFokZJidhi87yFG15dr/w+u5nV4QmLODp5NEJWKNC
         CeHP1/f250JUltkvHI7jQwbt/S2BQ+NqyFXz6rusUXTqnT45YM0SfMjQvtueDZ61c/he
         fcGVN/It/8I3WPEBWy7fTmxpT3TgphO4/+y6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684322276; x=1686914276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WCELhKKHIosJqimbc1keXrYAK+9jP7I652VYp3oomc=;
        b=c8fsY0sxaVoaTcEjYVjDGnEuK0s3ZPg0TwGAGwmO49FV9YIkOAVnrm8iT+EXUNyuI1
         wkcRmABcM2GXGZloZc4aUvcYmlnasvTKCwVmFm6t3g88O9Vg9rGGyyYQs/aid65xjvwy
         FZgsd22CWSU8ejCTxewmFhPZRanFPOecDZo2JkXFX/2Q8C3geihPCxoGUE2WSD/D1che
         E9XbZ4EgnAB7Ke4iJaMfJjO2gila59f/A9bMRwGc9fInYzh2KwKbhcczcCBr/fLNO8Cw
         zKHAsPFWIuA1ZAYJdNaNr1af/3bK2GvJXS6sHeknuVbvYLzxJbSfw766EGG4FbPCXqtF
         Ezhw==
X-Gm-Message-State: AC+VfDxovpjSzOtr1HiwcgHNJ2EOfbeEG0SdVM0qlZ5bXQhNg7s+Sph1
        QeUWnTZYKzBZGCmkqmCt1OrJhdtrEXheYpoHCmLelA==
X-Google-Smtp-Source: ACHHUZ7ho45fN+FqzJuMIFp6n4beIoWDVJzPSkpc/MqVOHha2wui277QosfgqSZKcOiFyTT21OZ00RXZ08i0odI/RxE=
X-Received: by 2002:a0d:d54d:0:b0:55a:7722:1401 with SMTP id
 x74-20020a0dd54d000000b0055a77221401mr36177609ywd.31.1684322276576; Wed, 17
 May 2023 04:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230515235713.232939-1-aford173@gmail.com> <20230515235713.232939-5-aford173@gmail.com>
 <CAMty3ZAU3NG8yk1dFB4Y3QtCZ7j7XUTqKHkJVKhhOduc4V5XpQ@mail.gmail.com>
In-Reply-To: <CAMty3ZAU3NG8yk1dFB4Y3QtCZ7j7XUTqKHkJVKhhOduc4V5XpQ@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 17 May 2023 16:47:44 +0530
Message-ID: <CAMty3ZAd1EWAfZ6d3TndapSLp7CgY8XRc8JfYt532gsGrgUNiQ@mail.gmail.com>
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

On Wed, May 17, 2023 at 4:34=E2=80=AFPM Jagan Teki <jagan@amarulasolutions.=
com> wrote:
>
> Hi Adam,
>
> On Tue, May 16, 2023 at 5:27=E2=80=AFAM Adam Ford <aford173@gmail.com> wr=
ote:
> >
> > In order to support variable DPHY timings, it's necessary
> > to enable GENERIC_PHY_MIPI_DPHY so phy_mipi_dphy_get_default_config
> > can be used to determine the nominal values for a given resolution
> > and refresh rate.
> >
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
> >         select DRM_KMS_HELPER
> >         select DRM_MIPI_DSI
> >         select DRM_PANEL_BRIDGE
> > +       select GENERIC_PHY_MIPI_DPHY
>
> Is it really required? phy is optional as it is not required for
> imx8mm/n/p as of now. May be we can add it while supporting it.

Haa, look like the next patch is using it. sorry.

Thanks,
Jagan.
