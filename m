Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BE06DC09D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 18:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjDIQAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 12:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIQAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 12:00:00 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5804C30FA;
        Sun,  9 Apr 2023 08:59:57 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id z16so1577583oib.9;
        Sun, 09 Apr 2023 08:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681055996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKSx+BThSiB9jUyMzJ/mVQaX8wNZeNkLCwm7ggA60Lo=;
        b=I8xNdWVHMLyxojtPZ7QS+y0Q1R2JpZ+SlKbyhW63/HECNN4q3aFFVyrBsT34WK2PmY
         HBx7SjD62wgjmgZJFZkMsAQEEOQLHXxrKhAiouSya3YduwrWOs11E8lB15a0JxxrR4zy
         C3RurE3rwJXewaN4A0bUyIpdrSMBgUyivBFKgw2Wp0yU3g04zgaXNyXgC7ULnXQBsg1m
         LiPKKgghnYhrrQeQXNaQy8yBT48bcskfxrNxFpD/87Tyehui3YeeU666M5x9R8y2CdTW
         XtJzjh5paWEJKLwyDeVIaHPcW60HeVtiuy6u6NlGnFyg/7l7H5tcRt+HuawSZwLwfYl1
         WFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681055996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKSx+BThSiB9jUyMzJ/mVQaX8wNZeNkLCwm7ggA60Lo=;
        b=Mhro+j0K9io2Tx91O9SB4J0S00aZbsfemiWXj0yaTEhQG3w+3qo6K3u5a13wjt9gTF
         x86TO6BU+msPNQ/8h1zHWZNgHkdh01TB9jL2TlLVJJANYNqlvC1YbGawQp+fDQCGHAno
         mI6F7BCQ/CRyoD8JZG67DfIX9NfHsgRWA7hAIO7AbhKEy2/IbVtYVv/DG2l8/pFeaLZL
         lISN3GP2NGy2E9wdya0SUJJRTaxBJR7rq8/ajR3wZCTiW2adW8p+UknJQ4+q359eqp2g
         VdVYUavwbwAHFjbw2x+uhd28oLMOVoCU/D5cKK+NEwGGZ2eltKb+TmRxvUeHm58nTrwu
         DN/w==
X-Gm-Message-State: AAQBX9dIMGdS5SFSHtgtqebYicwx91kfNvzMaI5x7VlPJLphyu2KCVMT
        0ypvxFE9Am2mviSgISW+61p00kpNXHvuvHGNKsk=
X-Google-Smtp-Source: AKy350ZaZjhvnKfo1yDx5wAVpP/ZXGLLNI1FUxzWsAm6DKPw50DEDVYlVUIM2GJ4EBeKyJ/M4yDf7ZYqzK/buWBmAs4=
X-Received: by 2002:aca:171a:0:b0:386:e7e7:d93d with SMTP id
 j26-20020aca171a000000b00386e7e7d93dmr2328119oii.5.1681055996599; Sun, 09 Apr
 2023 08:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230406215917.1475704-1-robdclark@gmail.com> <20230406215917.1475704-3-robdclark@gmail.com>
 <CACvgo50FEYhdpp3nqX-AyAvLK8hJnK2xynTtLnCb9A+GSeHCvg@mail.gmail.com>
In-Reply-To: <CACvgo50FEYhdpp3nqX-AyAvLK8hJnK2xynTtLnCb9A+GSeHCvg@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sun, 9 Apr 2023 08:59:45 -0700
Message-ID: <CAF6AEGuyu5AoCTneqZQLasTfb5YEotVr35hSBvYhRTMaTbYPUw@mail.gmail.com>
Subject: Re: [RFC 2/2] drm/msm: Add memory stats to fdinfo
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        linux-arm-msm@vger.kernel.org,
        Christopher Healy <healych@amazon.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 8, 2023 at 5:28=E2=80=AFAM Emil Velikov <emil.l.velikov@gmail.c=
om> wrote:
>
> On Thu, 6 Apr 2023 at 22:59, Rob Clark <robdclark@gmail.com> wrote:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Use the new helper to export stats about memory usage.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/msm/msm_drv.c | 26 +++++++++++++++++++++++++-
> >  drivers/gpu/drm/msm/msm_gpu.c |  2 --
> >  2 files changed, 25 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_dr=
v.c
> > index 9b6f17b1261f..385776f6a531 100644
> > --- a/drivers/gpu/drm/msm/msm_drv.c
> > +++ b/drivers/gpu/drm/msm/msm_drv.c
> > @@ -1043,17 +1043,40 @@ static const struct drm_ioctl_desc msm_ioctls[]=
 =3D {
> >         DRM_IOCTL_DEF_DRV(MSM_SUBMITQUEUE_QUERY, msm_ioctl_submitqueue_=
query, DRM_RENDER_ALLOW),
> >  };
> >
> > +enum drm_gem_object_status gem_status(struct drm_gem_object *obj)
> > +{
> > +       struct msm_gem_object *msm_obj =3D to_msm_bo(obj);
> > +       enum drm_gem_object_status status =3D 0;
> > +
> > +       if (!dma_resv_test_signaled(obj->resv, dma_resv_usage_rw(true))=
)
> > +               status |=3D DRM_GEM_OBJECT_ACTIVE;
> > +
> > +       if (msm_obj->pages)
> > +               status |=3D DRM_GEM_OBJECT_RESIDENT;
> > +
> > +       if (msm_obj->madv =3D=3D MSM_MADV_DONTNEED)
> > +               status |=3D DRM_GEM_OBJECT_PURGEABLE;
> > +
> > +       return status;
> > +}
> > +
> >  static void msm_fop_show_fdinfo(struct seq_file *m, struct file *f)
> >  {
> >         struct drm_file *file =3D f->private_data;
> >         struct drm_device *dev =3D file->minor->dev;
> >         struct msm_drm_private *priv =3D dev->dev_private;
> > +       struct msm_file_private *ctx =3D file->driver_priv;
> >         struct drm_printer p =3D drm_seq_file_printer(m);
> >
> >         if (!priv->gpu)
> >                 return;
> >
> > -       msm_gpu_show_fdinfo(priv->gpu, file->driver_priv, &p);
> > +       drm_printf(&p, "drm-driver:\t%s\n", dev->driver->name);
> > +       drm_printf(&p, "drm-client-id:\t%u\n", ctx->seqno);
> > +
> > +       msm_gpu_show_fdinfo(priv->gpu, ctx, &p);
> > +
> > +       drm_print_memory_stats(file, &p, gem_status);
> >  }
> >
> >  static const struct file_operations fops =3D {
> > @@ -1067,6 +1090,7 @@ static const struct drm_driver msm_driver =3D {
> >                                 DRIVER_RENDER |
> >                                 DRIVER_ATOMIC |
> >                                 DRIVER_MODESET |
> > +                               DRIVER_SYNCOBJ_TIMELINE |
>
> This line should probably be its own patch. AFAICT it was supported
> since ab723b7a992a19b843f798b183f53f7472f598c8, although explicitly
> kept disabled until there's userspace/turnip support.

ahh, yes, that wasn't intended to be part of this patch, just a local
thing I happened to be testing

BR,
-R

> With the above line removed, the patch is:
> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
>
> HTH
> Emil
