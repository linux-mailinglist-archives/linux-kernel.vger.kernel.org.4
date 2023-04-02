Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68676D373E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 12:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjDBKWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 06:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjDBKWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 06:22:22 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316E29005
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 03:22:19 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id ay14so18913804uab.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 03:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680430938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78mvPGTViVosqxILCdJJz132sdgbqpWpHt2BoCSXMOg=;
        b=FXXe+tnLNKmwBvuPN64jwW3rt7Sp6xpz7AtyFrnebOcNSaiEZOEPIudklrQfMO3HDf
         5/AP6zumg5kylxg8cq3VlXDN5HOcJqRuopMp8fCKm41MKD6r41sFZNpG/nWd2/OplnRM
         JWqcsVwkqqxpPYedeLbMOwsu69eIhn/qfeqVG1F2/I7i9CGOa/VEbvW+kKIwzZJV4oBq
         CAUr1vRhdKK9JWmFqVm336Q0/crRS5WeCkxmiFezRrFF4CTzUqClkMO89Moih1GcAls7
         vfhdF+A/YMwQZIPWG18JeIYKzlfpid/qraz3+mI5p+1U+xkd7p1gh2aEqi8zN56jIFVE
         h/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680430938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78mvPGTViVosqxILCdJJz132sdgbqpWpHt2BoCSXMOg=;
        b=IJWHqexAwJSwuHe/qH41+PV1DFKBIQPimBFBOFolV1N/u2sugStFLdCbTDTfDzOuKm
         RTM4QSnxMJkbIeXVSt7vRA13AKHXh0/bACDbgjPS0WJj61c+rGbDcl6nNffpQkl/2zTV
         /2regUuWeduqAStkNF2bs3MNh2vPmZHaBRS95g+mprLoar9VFYdoukc4zDCOKrp79xma
         QyF1QyFqWHZ/RB4UDMtCYo9bADGkJPtst9kYnSAg5RgJKQTHc+JU2o9pJPTEJ/GhuEar
         dOzorYQb+YFeCQaLOQ6y6twDYxX5jXlG8WuG8+PEBh0C0vauYRxLYdzdExJ1eD8mvFg9
         uq7A==
X-Gm-Message-State: AAQBX9fEK0HKkKwx9aiXbqSg/aV9FJE9fu3ue1sLWfzQ1i83ftxsCiBt
        sLp5diqI6bz8XkDRrpoV9Dj4xx4qISMKVRsBbJbFdNmFmiV6zg==
X-Google-Smtp-Source: AKy350Zs0K8eGXtCBH4dIdNatjLteJ3QzMaSN+mH3XnRzETLN6JjDCKJI9Dj5Qa9ERUouU/dFyPa/4wE0ZxQBfcJiT4=
X-Received: by 2002:a1f:ad4b:0:b0:432:90b6:e626 with SMTP id
 w72-20020a1fad4b000000b0043290b6e626mr17524175vke.3.1680430938182; Sun, 02
 Apr 2023 03:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230314052711.4061652-1-harshit.m.mogalapalli@oracle.com> <CAKGbVbsh4AXo+E4=T0eHeHS_ZuY4QYgRBF+Nbt+BFFMoJOMo0g@mail.gmail.com>
In-Reply-To: <CAKGbVbsh4AXo+E4=T0eHeHS_ZuY4QYgRBF+Nbt+BFFMoJOMo0g@mail.gmail.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Sun, 2 Apr 2023 18:22:07 +0800
Message-ID: <CAKGbVbvCk04h1y99o-uqZLnzjZBFzS6fzXzopnwH=sXKzBNRtQ@mail.gmail.com>
Subject: Re: [PATCH] drm/lima/lima_drv: Add missing unwind goto in lima_pdev_probe()
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        Andreas Baierl <ichgeh@imkreisrum.de>,
        Simon Shields <simon@lineageos.org>,
        Heiko Stuebner <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next.

On Tue, Mar 14, 2023 at 2:22=E2=80=AFPM Qiang Yu <yuq825@gmail.com> wrote:
>
> Reviewed-by: Qiang Yu <yuq825@gmail.com>
>
> On Tue, Mar 14, 2023 at 1:27=E2=80=AFPM Harshit Mogalapalli
> <harshit.m.mogalapalli@oracle.com> wrote:
> >
> > Smatch reports:
> > drivers/gpu/drm/lima/lima_drv.c:396 lima_pdev_probe() warn:
> >         missing unwind goto?
> >
> > Store return value in err and goto 'err_out0' which has
> > lima_sched_slab_fini() before returning.
> >
> > Fixes: a1d2a6339961 ("drm/lima: driver for ARM Mali4xx GPUs")
> > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > ---
> > Only compile tested.
> > ---
> >  drivers/gpu/drm/lima/lima_drv.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lim=
a_drv.c
> > index 7b8d7178d09a..39cab4a55f57 100644
> > --- a/drivers/gpu/drm/lima/lima_drv.c
> > +++ b/drivers/gpu/drm/lima/lima_drv.c
> > @@ -392,8 +392,10 @@ static int lima_pdev_probe(struct platform_device =
*pdev)
> >
> >         /* Allocate and initialize the DRM device. */
> >         ddev =3D drm_dev_alloc(&lima_drm_driver, &pdev->dev);
> > -       if (IS_ERR(ddev))
> > -               return PTR_ERR(ddev);
> > +       if (IS_ERR(ddev)) {
> > +               err =3D PTR_ERR(ddev);
> > +               goto err_out0;
> > +       }
> >
> >         ddev->dev_private =3D ldev;
> >         ldev->ddev =3D ddev;
> > --
> > 2.38.1
> >
