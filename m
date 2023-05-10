Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8E06FD9D3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbjEJIpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236793AbjEJIpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:45:01 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E819912B;
        Wed, 10 May 2023 01:45:00 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-24df161f84bso4932674a91.3;
        Wed, 10 May 2023 01:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683708300; x=1686300300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXEwn3jyGzbB6xYz7UmYCgugQ0Sv8yWibVgQQnQcvCg=;
        b=EwivrME5ItdF9HZICNz/8xqVqiW+sSK88CRqvpfhdTcKBbYMX0XgaQIhYZenmJDMFM
         YywlTFNk4hdbTdjOn/oeEePMuMX1ah/lhs1eqVOa9kiF37VWr3hUqMqbkNYkqVwKp2ub
         HTvz6Cu8UY01XTqUnmvgksYtz7Q9U10HRlPycwU7b6ad43neEpI7+wuhyBFasL+uUWA5
         NH2kM+n0gvA00GibwxzWTWeghn+TStnVYjX/eyPmbNvymaTIhgFv54Bj4EqV4t2vOLWt
         AfoP0839s4dfZnuccoBEAf2xyDOw2QVH1914xv/1KF+JZ6pxHzMW37sChgAdUPCHL6EN
         kzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683708300; x=1686300300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXEwn3jyGzbB6xYz7UmYCgugQ0Sv8yWibVgQQnQcvCg=;
        b=C/7J7QKfqUD0Batp4aA0R3Qfb8buZPSwn0NtlLxKhggtJGuwARKQyLklkWIhBxdmRA
         ZtaFpzoUgpJR9r+jHnHnScWLMHy5VmzWC8Ati93Sgh9a4V6vbRizZDs9ZltlDwgRclQF
         yJq+1Y7ujmExhb3f59WYfKfudwJYuCSy0x5dIBDcGt2MvvnakrWUen6LR0iyZ8Wzmfvf
         uVXOwiwGtxc/CiATCgeN0NEZMfPe9fUVwK/bKc3wS9iiWwL3TvTCMsYkXx0/GHR7ojzu
         T0xEMfAo2ApdGnjdMmpoDKo3UQefsytUVVLdx3hXhruNZRsSF+EGkGBt9pJeOA0wFNr4
         mJ9A==
X-Gm-Message-State: AC+VfDySsdEOm4kaTiwC6ZI41GZZ1EEdGE404h+AIgL++vgmSi6qfsc8
        XIvTrTOaKcbwUcebbuuRHmDQ3DUhK+0aE0jn7sw=
X-Google-Smtp-Source: ACHHUZ7cb8rT49XrD2BTwj4Dqb4Av57nsKqjAj79b7XQJ9wrgPMYVRPwOi9s/ri55BOm5r3DyzlScBTqp3AXU4+c93o=
X-Received: by 2002:a17:90a:c004:b0:247:3e0a:71cd with SMTP id
 p4-20020a17090ac00400b002473e0a71cdmr16976883pjt.6.1683708300294; Wed, 10 May
 2023 01:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230508055740.635256-1-victor.liu@nxp.com> <20230508055740.635256-6-victor.liu@nxp.com>
 <2ef8da6c-a16b-4396-1456-9a4d75ca5200@denx.de>
In-Reply-To: <2ef8da6c-a16b-4396-1456-9a4d75ca5200@denx.de>
From:   Ying Liu <gnuiyl@gmail.com>
Date:   Wed, 10 May 2023 16:44:48 +0800
Message-ID: <CAOcKUNXzyjK+xUp2an69ExsLhWDi8gZt0suZM88jrCc2M_BqNg@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] drm: lcdif: Add multiple encoders and first
 bridges support
To:     Marek Vasut <marex@denx.de>
Cc:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, conor+dt@kernel.org,
        alexander.stein@ew.tq-group.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, linux-imx@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, kernel@pengutronix.de,
        LW@karo-electronics.de
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

On Tue, May 9, 2023 at 10:14=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 5/8/23 07:57, Liu Ying wrote:
> > The single LCDIF embedded in i.MX93 SoC may drive multiple displays
> > simultaneously.  Look at LCDIF output port's remote port parents to
> > find all enabled first bridges.  Add an encoder for each found bridge
> > and attach the bridge to the encoder.  This is a preparation for
> > adding i.MX93 LCDIF support.
> >
> > Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
> > v4->v5:
> > * Rebase upon v6.4-rc1 and resolve a trivial conflict.
> > * Add Alexander's A-b and T-b tags.
> >
> > v3->v4:
> > * Improve warning message when ignoring invalid LCDIF OF endpoint ids.
> >    (Alexander)
> >
> > v2->v3:
> > * No change.
> >
> > v1->v2:
> > * Split from patch 2/2 in v1. (Marek, Alexander)
> > * Drop '!remote ||' from lcdif_attach_bridge(). (Lothar)
> > * Drop unneeded 'bridges' member from lcdif_drm_private structure.
> >
> >   drivers/gpu/drm/mxsfb/lcdif_drv.c | 68 +++++++++++++++++++++++++++---=
-
> >   drivers/gpu/drm/mxsfb/lcdif_drv.h |  4 +-
> >   drivers/gpu/drm/mxsfb/lcdif_kms.c | 21 ++--------
> >   3 files changed, 66 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/=
lcdif_drv.c
> > index e816f87828fb..cf27b63b1899 100644
> > --- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
> > +++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> > @@ -9,13 +9,16 @@
> >   #include <linux/dma-mapping.h>
> >   #include <linux/io.h>
> >   #include <linux/module.h>
> > +#include <linux/of.h>
> >   #include <linux/of_device.h>
> > +#include <linux/of_graph.h>
> >   #include <linux/platform_device.h>
> >   #include <linux/pm_runtime.h>
> >
> >   #include <drm/drm_atomic_helper.h>
> >   #include <drm/drm_bridge.h>
> >   #include <drm/drm_drv.h>
> > +#include <drm/drm_encoder.h>
> >   #include <drm/drm_fbdev_dma.h>
> >   #include <drm/drm_gem_dma_helper.h>
> >   #include <drm/drm_gem_framebuffer_helper.h>
> > @@ -38,19 +41,68 @@ static const struct drm_mode_config_helper_funcs lc=
dif_mode_config_helpers =3D {
> >       .atomic_commit_tail =3D drm_atomic_helper_commit_tail_rpm,
> >   };
> >
> > +static const struct drm_encoder_funcs lcdif_encoder_funcs =3D {
> > +     .destroy =3D drm_encoder_cleanup,
> > +};
> > +
> >   static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
> >   {
> > -     struct drm_device *drm =3D lcdif->drm;
> > +     struct device *dev =3D lcdif->drm->dev;
> > +     struct device_node *ep;
> >       struct drm_bridge *bridge;
> >       int ret;
> >
> > -     bridge =3D devm_drm_of_get_bridge(drm->dev, drm->dev->of_node, 0,=
 0);
> > -     if (IS_ERR(bridge))
> > -             return PTR_ERR(bridge);
> > -
> > -     ret =3D drm_bridge_attach(&lcdif->encoder, bridge, NULL, 0);
> > -     if (ret)
> > -             return dev_err_probe(drm->dev, ret, "Failed to attach bri=
dge\n");
> > +     for_each_endpoint_of_node(dev->of_node, ep) {
> > +             struct device_node *remote;
> > +             struct of_endpoint of_ep;
> > +             struct drm_encoder *encoder;
> > +
> > +             remote =3D of_graph_get_remote_port_parent(ep);
> > +             if (!of_device_is_available(remote)) {
> > +                     of_node_put(remote);
> > +                     continue;
> > +             }
> > +             of_node_put(remote);
> > +
> > +             ret =3D of_graph_parse_endpoint(ep, &of_ep);
> > +             if (ret < 0) {
> > +                     dev_err(dev, "Failed to parse endpoint %pOF\n", e=
p);
> > +                     of_node_put(ep);
> > +                     return ret;
> > +             }
> > +
> > +             if (of_ep.id >=3D MAX_DISPLAYS) {
>
> Can we make the maximum number of displays, or really bridge, specific
> to IP instance instead (1 for mx8mp, 3 for mx93) ? If so, then I think
> we need to track a list of bridges in some linked list or some such
> dynamic structure, which would allow us to get rid of MAX_DISPLAYS macro.

I don't think we need to track bridges, since bridges can be found
through connector's encoder, like  lcdif_crtc_atomic_check() does
in patch 4/6.  Instead, MAX_DISPLAYS and the encoder member
in struct lcdif_drm_private can be dropped if we call devm_kzalloc()
to allocate encoders in this function.

>
> > +                     dev_warn(dev, "ingoring invalid endpoint id %u\n"=
, of_ep.id);
>
> s@ingoring@ignoring@

Right.  But the endpoint id check is not mandatory and is better
to be dropped together with MAX_DISPLAYS.  I mean the driver
doesn't have to validate the endpoint id set in device tree.

Regards,
Liu Ying

>
> [...]
