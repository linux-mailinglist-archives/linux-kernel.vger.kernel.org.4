Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3535F64F698
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 01:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiLQAyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 19:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiLQAxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 19:53:49 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE0EDDB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 16:53:21 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id i9so5882724edj.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 16:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N2BdpDmynsGLfYwZJze3eSzx6Qv1LTya1e+z5hUsqmE=;
        b=gBW5AQYO4rFsTaG3SVrW2wngY+SAI9LKsn1P5sKw/E6teVWPSifYOZZkoY7I3NSLZf
         kXM6oZVgsQ0VThAxEqHVMFLImdTnoYonfOUQHdEVMJwJgnxn01GyBz8kUbpoarUaKfwW
         IIdKP6j1tSanrdDC8Pssb68OC5XWnMjzbCaKeoxOj4Nk/zpSibzkgqCxPjleTJMbhXWV
         bZ2C+u/DNeDvM/AzCbGpIkTQaJMS4QVSQJl4/49CQ342Pi6OOvaxDzlB+IrfEkKnwM9t
         pbBlfe3HZubnBORrEv9bWjSypXYkRezxYm19E2zhN9FxMAbGM5bwh1kMc9ut1hghlxPv
         ExPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2BdpDmynsGLfYwZJze3eSzx6Qv1LTya1e+z5hUsqmE=;
        b=4Xd+DrEP5G/F/DwDER4JE0jSFBdEl7yBnw7d3zEfSTMnbnlrG2AM7S1srPocDV/cKh
         7xtPS/tP87KCjROwOxodZKHQj5dEu06QrFl0BDguI/EPrWvmyYUb8ALSVzZ4Ws8PBDdO
         MA1ZX/fEtn/YZ9lw2g2hZ6WkY7P5OP8TIFZswEMaycc69ne5ZG01y7MZJQxRqwY1hD0S
         +nlRlR7XR6p8OTeqdNgCnjY6Jk2nO1umwBxRrjJYOpTkjY4kKeQRMw7rLSaRWVsqhwMn
         lO4/EppDo663tco4h5Dfnf6OmRfMY8QfivXHJ6kZYM/eT0G2NBmhl38HgPxg2RFBPIBB
         Z2oA==
X-Gm-Message-State: ANoB5pmi6p2gmYXMi5m4Mk0PXj6IeLFYvEhULcTuQ+PiRzpeJAE4AiWd
        gS+inXXt3RrzxTNoHHg7etulCiiWCWpaDFhYKC0=
X-Google-Smtp-Source: AA0mqf6/LjB4O+EBhjbmWRKNkOG7rHY1f+Jadwiawdch/R0N6qxSY5O07jNJs01UiDhqUvS76Y3nY7cEbDqZaefSE7U=
X-Received: by 2002:a50:fc91:0:b0:46c:673b:93ac with SMTP id
 f17-20020a50fc91000000b0046c673b93acmr21013301edq.317.1671238399989; Fri, 16
 Dec 2022 16:53:19 -0800 (PST)
MIME-Version: 1.0
References: <20221216233355.542197-1-robdclark@gmail.com> <CAPaKu7RP281inKJKNWWTnETCU+giwU2YajzwH6AUVeTDXQoWWg@mail.gmail.com>
 <CAF6AEGv0w=iPW-25BEjmEoQyODyQU23sK_j2eNGV2jOQO+byCg@mail.gmail.com>
In-Reply-To: <CAF6AEGv0w=iPW-25BEjmEoQyODyQU23sK_j2eNGV2jOQO+byCg@mail.gmail.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Fri, 16 Dec 2022 16:53:08 -0800
Message-ID: <CAPaKu7QyJ0iYEyHt8VWk4ESL4EzzeT8xj0CcNuvg5mUWeBzpwg@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Fix GEM handle creation UAF
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        open list <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 4:20 PM Rob Clark <robdclark@gmail.com> wrote:
>
> On Fri, Dec 16, 2022 at 3:59 PM Chia-I Wu <olvaffe@gmail.com> wrote:
> >
> > On Fri, Dec 16, 2022 at 3:34 PM Rob Clark <robdclark@gmail.com> wrote:
> > >
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > Relying on an unreturned handle to hold a reference to an object we
> > > dereference is not safe.  Userspace can guess the handle and race us
> > > by closing the handle from another thread.  The _create_with_handle()
> > > that returns an object ptr is pretty much a pattern to avoid.  And
> > > ideally creating the handle would be done after any needed dererencing.
> > > But in this case creation of the mapping is tied to the handle creation.
> > > Fortunately the mapping is refcnt'd and holds a reference to the object,
> > > so we can drop the handle's reference once we hold a mapping reference.
> > >
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > >  drivers/gpu/drm/panfrost/panfrost_drv.c |  7 +++++++
> > >  drivers/gpu/drm/panfrost/panfrost_gem.c | 10 +++++++---
> > >  2 files changed, 14 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > > index 2fa5afe21288..aa5848de647c 100644
> > > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > > @@ -98,6 +98,13 @@ static int panfrost_ioctl_create_bo(struct drm_device *dev, void *data,
> > >                 return PTR_ERR(bo);
> > >
> > >         mapping = panfrost_gem_mapping_get(bo, priv);
> > > +
> > > +       /*
> > > +        * Now that the mapping holds a reference to the bo until we no longer
> > > +        * need it, we can safely drop the handle's reference.
> > > +        */
> > Not too familiar with panfrost, but I don't see
> > panfrost_gem_mapping_get hold a reference to the bo?
>
> It doesn't directly, but the mapping already holds a reference, taken
> before the handle reference is dropped
>
> It is all a bit too subtle for my taste.
Ack.
> > > +       drm_gem_object_put(&bo->base.base);
> > > +
> > >         if (!mapping) {
> > >                 drm_gem_object_put(&bo->base.base);
> > >                 return -EINVAL;
> > > diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> > > index 293e799e2fe8..e3e21c500d24 100644
> > > --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> > > +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> > > @@ -234,6 +234,10 @@ struct drm_gem_object *panfrost_gem_create_object(struct drm_device *dev, size_t
> > >         return &obj->base.base;
> > >  }
> > >
> > > +/*
> > > + * NOTE: if this succeeds, both the handle and the returned object have
> > > + * an outstanding reference.
> > > + */
> > I might suggest dropping the "_with_handle" suffix.
>
> Maybe _and_handle would be a better name (for this and other cases
> that return both a handle and obj)?
Sounds good.  We will want that for panfrost, qxl, and vmwgfx.

The other drivers and helpers only need the handle.  Their
_with_handle should be fixed to not return the pointer.

>
> > The naming convention is used in several drivers.  I think we should
> > make it the case that the _with_handle variants always return the
> > handle without the pointer.  (And with the change, it immediately
> > becomes clear that qxl and vmwgfx also have similar issues).
>
> ugg, yeah, qxl does have the issue in the qxl_mode_dumb_create path.
> I overlooked that it returns an obj pointer by reference.
>
> on the surface vmwgfx looked ok, but I could have overlooked something.
>
> BR,
> -R
>
> > >  struct panfrost_gem_object *
> > >  panfrost_gem_create_with_handle(struct drm_file *file_priv,
> > >                                 struct drm_device *dev, size_t size,
> > > @@ -261,10 +265,10 @@ panfrost_gem_create_with_handle(struct drm_file *file_priv,
> > >          * and handle has the id what user can see.
> > >          */
> > >         ret = drm_gem_handle_create(file_priv, &shmem->base, handle);
> > > -       /* drop reference from allocate - handle holds it now. */
> > > -       drm_gem_object_put(&shmem->base);
> > > -       if (ret)
> > > +       if (ret) {
> > > +               drm_gem_object_put(&shmem->base);
> > >                 return ERR_PTR(ret);
> > > +       }
> > >
> > >         return bo;
> > >  }
> > > --
> > > 2.38.1
> > >
