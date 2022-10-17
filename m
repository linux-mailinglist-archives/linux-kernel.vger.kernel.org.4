Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B00601558
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJQR26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJQR2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:28:53 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894D51F638
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:28:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sc25so26472717ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3NBiv3SPCH7/CkNwTixJben03xMbF+oIfMj6pGQk/gg=;
        b=jqHnGDESxBjTsf+Ch+SFxuDfGAvum/LPswoQ599JSljkR7pw9yh8K2kUGMxQnlvX0s
         Y/I+MmsH/89GHhFmozDkdfX5uIzH7stjvHbbdIWAOLYZIyPZxaKpuU86xOW4zm8AY4OF
         yyvHvHFKYJCZ3xNQIIhR4VZxzhjSS3ekJgOUoSA3jVtb4Myr9nUEmfG0A/bHiK/znZmV
         mpe4mQWEOqlpptkHqgP/vX+M9fnWfotmtx1909Hyc9n4uPFhOQ4pLVDjie2+bG3Q5HpO
         ytL5xhQE7C75T+zFbzTp7J/QSrv/exqpDZQhr8Vq0QXI+Rxkn2Da7S/ZVyyBWvT/KQln
         WoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NBiv3SPCH7/CkNwTixJben03xMbF+oIfMj6pGQk/gg=;
        b=m5kx3MhDOm0Os6MEKC/6/c06wKdFAX2btzzfKhk3uIFBqMQyz31zIlmJC6hfgRXIaF
         95por7CLLXdok7v0jH+/1OKBONmb9Vo5uXnvrpB9Oh2f46MAoanoIjA2aRFwqmgjVFOi
         LkwGo+4Nig9pjFxV5KZTTPC4fnRSwY85yQbNu7362rXwU5yoYDoyJj3XTo3GLBvKiLbp
         gunX1apdJaymCnO0SZ51sEi3kZc6jlmHIlpk6jWJBPc+kWRhGAdJGRaixmi3P0idLdtc
         SzlA2kYDyrCPBYCmN6EqcgsjSCpNjOOeny0N3WKJvAQy+ud5gPfob/8EFj/W1nEzjHJV
         JGJw==
X-Gm-Message-State: ACrzQf3B/gxdj3fC/RpdzXpFrmxQzGVmEtfMd72543MvUcKDE17GMuKn
        7DTxPUn1GLeAdYNK2jvoXiTzDnyHaDPVxzeWcXfbZg==
X-Google-Smtp-Source: AMsMyM7d+XDkGlnblLLh/HG6ol6NP9K5rplL7xXCeugXNCvA9cKSBAnnZdOUfFDgp/XWdQPkZOevlvMaJ+6hVXb8yuY=
X-Received: by 2002:a17:907:94c7:b0:78e:1c4f:51f9 with SMTP id
 dn7-20020a17090794c700b0078e1c4f51f9mr9839550ejc.200.1666027593725; Mon, 17
 Oct 2022 10:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221013-rpi-dpi-improvements-v1-0-8a7a96949cb0@cerno.tech>
 <20221013-rpi-dpi-improvements-v1-5-8a7a96949cb0@cerno.tech>
 <Y0rtVpMROELzbApj@pendragon.ideasonboard.com> <Y0ruTEuq1flo7/dt@pendragon.ideasonboard.com>
In-Reply-To: <Y0ruTEuq1flo7/dt@pendragon.ideasonboard.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Mon, 17 Oct 2022 18:26:18 +0100
Message-ID: <CAPY8ntAW56-17QmwVsOmtnvEbnq_OmgmM_naVGhLepR9T3BDyA@mail.gmail.com>
Subject: Re: [PATCH 5/7] drm/vc4: dpi: Support BGR666 formats
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Eric Anholt <eric@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>,
        Emma Anholt <emma@anholt.net>, dri-devel@lists.freedesktop.org,
        Joerg Quinten <aBUGSworstnightmare@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

Thanks for the review.

On Sat, 15 Oct 2022 at 18:31, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Sat, Oct 15, 2022 at 08:26:48PM +0300, Laurent Pinchart wrote:
> > Hi Maxime and Joerg,
> >
> > Thank you for the patch.
> >
> > On Thu, Oct 13, 2022 at 11:56:49AM +0200, Maxime Ripard wrote:
> > > From: Joerg Quinten <aBUGSworstnightmare@gmail.com>
> > >
> > > The VC4 DPI output can support multiple BGR666 variants, but they were
> > > never added to the driver. Let's add the the support for those formats.
> > >
> > > Signed-off-by: Joerg Quinten <aBUGSworstnightmare@gmail.com>
> > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> >
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >
> > > ---
> > >  drivers/gpu/drm/vc4/vc4_dpi.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/vc4/vc4_dpi.c b/drivers/gpu/drm/vc4/vc4_dpi.c
> > > index 7da3dd1db50e..ecbe4cd87036 100644
> > > --- a/drivers/gpu/drm/vc4/vc4_dpi.c
> > > +++ b/drivers/gpu/drm/vc4/vc4_dpi.c
> > > @@ -170,10 +170,16 @@ static void vc4_dpi_encoder_enable(struct drm_encoder *encoder)
> > >                             dpi_c |= VC4_SET_FIELD(DPI_ORDER_BGR,
> > >                                                    DPI_ORDER);
> > >                             break;
> > > +                   case MEDIA_BUS_FMT_BGR666_1X24_CPADHI:
> > > +                           dpi_c |= VC4_SET_FIELD(DPI_ORDER_BGR, DPI_ORDER);
> > > +                           fallthrough;
>
> Upon closer inspection of the code, I think you also need
>
> -                       dpi_c &= ~DPI_FORMAT_MASK;
> +                       dpi_c &= ~(DPI_ORDER_MASK | DPI_FORMAT_MASK);
>
> a few lines above.

Hmm, curious as there appears to be a difference between our vendor
tree and mainline in the contents of a patch with almost the same
commit text.

https://github.com/torvalds/linux/commit/7a70b0b97889a89f397913c971cadfc6db9b310a
vs https://github.com/raspberrypi/linux/commit/9d9dc236a9ee9021363b8601b6188e7be86d1971

Our tree leaves dpi_c effectively clear, and selects the default at
the end. Mainline sets the default first.


Even so, dpi_c gets initialised with
dpi_c = DPI_ENABLE;
dpi_c |= VC4_SET_FIELD(DPI_FORMAT_24BIT_888_RGB, DPI_FORMAT);
dpi_c &= ~DPI_FORMAT_MASK;
so at this point in the switch, the DPI_ORDER bits haven't changed
from the default of 0.

  Dave

> > >                     case MEDIA_BUS_FMT_RGB666_1X24_CPADHI:
> > >                             dpi_c |= VC4_SET_FIELD(DPI_FORMAT_18BIT_666_RGB_2,
> > >                                                    DPI_FORMAT);
> > >                             break;
> > > +                   case MEDIA_BUS_FMT_BGR666_1X18:
> > > +                           dpi_c |= VC4_SET_FIELD(DPI_ORDER_BGR, DPI_ORDER);
> > > +                           fallthrough;
> > >                     case MEDIA_BUS_FMT_RGB666_1X18:
> > >                             dpi_c |= VC4_SET_FIELD(DPI_FORMAT_18BIT_666_RGB_1,
> > >                                                    DPI_FORMAT);
> > >
>
> --
> Regards,
>
> Laurent Pinchart
