Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31906E115B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjDMPmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjDMPmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:42:33 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A880FA5DD;
        Thu, 13 Apr 2023 08:42:26 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-18779252f7fso6106782fac.12;
        Thu, 13 Apr 2023 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681400546; x=1683992546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvOwIt6zrh6qQP/JicH9P8YGOKCDxcWkEi/fkX5OxdY=;
        b=DZQPJy/M7D6+C30lu02m120iL+T6vp+vaS8myftqhYSEFMqshFhMy1XMtPH0E3djE7
         NHM7/n4ECSXGwKKl15MF4BukNnlqTcO+gujVR0gDpwTDsjaTmpIQ4O2goFrmK83zmBWr
         OGptPOA5KySMwGEkH/4W7DehC1+MuDtbHyU72eDCxDYFtFHPrSwlyu580g35WLeonjxg
         pORxFfPBUnQCqUIKPkq1dadINCHHNZEptaL0CmBAXcC75tLVavtEQn7/Ym/oMW6bJeVz
         mh0wJtLteVSJi81WGWRPcq4FzHldaNy514pHneGjC9MNq6I1yPtYPLBrIisCUDe+QgmN
         gJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681400546; x=1683992546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvOwIt6zrh6qQP/JicH9P8YGOKCDxcWkEi/fkX5OxdY=;
        b=HMVEAkDeRMpIH056mD2JaacPdC1qgPDaJVjVsUft3KP4KCBwzfhe5wTb8BMgShn5/I
         +C/Taph/XlwRihtE3bX3OpJyzJcWd0mOBUc6GeKKXO7cKi34jpi1zAeS1aSqTtg6qB6H
         u44p8+Dp2IeF6OMYP1NHulCwQF2VU5w3ZEx8c5WB9YFrJqe9Hi3D/YgP1FQbKhTE9xjT
         36cm8il+WUrKEzKsrOdsfc0hNl/TXB0OE8LiSDCKJZsCOa1+sX9+uCEBckRXx8C8j6Qp
         jG0fc7jYmXSJs8iTZEnTKll5RRM1Eq/BVGYZuPnEP613IJLfPanGsrWOsApKOWvXazmL
         zNSQ==
X-Gm-Message-State: AAQBX9ftRkPA1TpYI7UtD/lTYYSRyIZJCa2u7oehTaLnsKhjzV+r1xoI
        uEMmcNQz1KHALDIXYgCByY4usXIvZXw8ZH6TpG7T/VZx
X-Google-Smtp-Source: AKy350ZAgVzz5BXpDRoz4Vk0NnfWkifKhvoNjPgM4LHsIs0L+m4N8v2UKA5TVoIKsXmP3B/93dtTyfXxAlyBiTZSEXg=
X-Received: by 2002:a05:6870:8a22:b0:184:2097:e64f with SMTP id
 p34-20020a0568708a2200b001842097e64fmr1457122oaq.5.1681400545763; Thu, 13 Apr
 2023 08:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230412224311.23511-1-robdclark@gmail.com> <20230412224311.23511-5-robdclark@gmail.com>
 <76c836a3-30a8-a46e-5a1a-0e3dc5967459@linux.intel.com>
In-Reply-To: <76c836a3-30a8-a46e-5a1a-0e3dc5967459@linux.intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 13 Apr 2023 08:42:12 -0700
Message-ID: <CAF6AEGu7=fLYsA6sFSNJCB6kNBJLNg8b3Z6L-ROOa31zTeneFg@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] drm/i915: Switch to fdinfo helper
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        intel-gfx@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>
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

On Thu, Apr 13, 2023 at 6:07=E2=80=AFAM Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>
> On 12/04/2023 23:42, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
>
> There is more do to here to remove my client->id fully (would now be
> dead code) so maybe easiest if you drop this patch and I do it after you
> land this and it propagates to our branches? I'd like to avoid pain with
> conflicts if possible..

That is fine by me

BR,
-R

> Regards,
>
> Tvrtko
>
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/gpu/drm/i915/i915_driver.c     |  3 ++-
> >   drivers/gpu/drm/i915/i915_drm_client.c | 18 +++++-------------
> >   drivers/gpu/drm/i915/i915_drm_client.h |  2 +-
> >   3 files changed, 8 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/=
i915_driver.c
> > index db7a86def7e2..0d91f85f8b97 100644
> > --- a/drivers/gpu/drm/i915/i915_driver.c
> > +++ b/drivers/gpu/drm/i915/i915_driver.c
> > @@ -1696,7 +1696,7 @@ static const struct file_operations i915_driver_f=
ops =3D {
> >       .compat_ioctl =3D i915_ioc32_compat_ioctl,
> >       .llseek =3D noop_llseek,
> >   #ifdef CONFIG_PROC_FS
> > -     .show_fdinfo =3D i915_drm_client_fdinfo,
> > +     .show_fdinfo =3D drm_show_fdinfo,
> >   #endif
> >   };
> >
> > @@ -1796,6 +1796,7 @@ static const struct drm_driver i915_drm_driver =
=3D {
> >       .open =3D i915_driver_open,
> >       .lastclose =3D i915_driver_lastclose,
> >       .postclose =3D i915_driver_postclose,
> > +     .show_fdinfo =3D i915_drm_client_fdinfo,
> >
> >       .prime_handle_to_fd =3D drm_gem_prime_handle_to_fd,
> >       .prime_fd_to_handle =3D drm_gem_prime_fd_to_handle,
> > diff --git a/drivers/gpu/drm/i915/i915_drm_client.c b/drivers/gpu/drm/i=
915/i915_drm_client.c
> > index b09d1d386574..4a77e5e47f79 100644
> > --- a/drivers/gpu/drm/i915/i915_drm_client.c
> > +++ b/drivers/gpu/drm/i915/i915_drm_client.c
> > @@ -101,7 +101,7 @@ static u64 busy_add(struct i915_gem_context *ctx, u=
nsigned int class)
> >   }
> >
> >   static void
> > -show_client_class(struct seq_file *m,
> > +show_client_class(struct drm_printer *p,
> >                 struct i915_drm_client *client,
> >                 unsigned int class)
> >   {
> > @@ -117,22 +117,20 @@ show_client_class(struct seq_file *m,
> >       rcu_read_unlock();
> >
> >       if (capacity)
> > -             seq_printf(m, "drm-engine-%s:\t%llu ns\n",
> > +             drm_printf(p, "drm-engine-%s:\t%llu ns\n",
> >                          uabi_class_names[class], total);
> >
> >       if (capacity > 1)
> > -             seq_printf(m, "drm-engine-capacity-%s:\t%u\n",
> > +             drm_printf(p, "drm-engine-capacity-%s:\t%u\n",
> >                          uabi_class_names[class],
> >                          capacity);
> >   }
> >
> > -void i915_drm_client_fdinfo(struct seq_file *m, struct file *f)
> > +void i915_drm_client_fdinfo(struct drm_printer *p, struct drm_file *fi=
le)
> >   {
> > -     struct drm_file *file =3D f->private_data;
> >       struct drm_i915_file_private *file_priv =3D file->driver_priv;
> >       struct drm_i915_private *i915 =3D file_priv->dev_priv;
> >       struct i915_drm_client *client =3D file_priv->client;
> > -     struct pci_dev *pdev =3D to_pci_dev(i915->drm.dev);
> >       unsigned int i;
> >
> >       /*
> > @@ -141,12 +139,6 @@ void i915_drm_client_fdinfo(struct seq_file *m, st=
ruct file *f)
> >        * **************************************************************=
****
> >        */
> >
> > -     seq_printf(m, "drm-driver:\t%s\n", i915->drm.driver->name);
> > -     seq_printf(m, "drm-pdev:\t%04x:%02x:%02x.%d\n",
> > -                pci_domain_nr(pdev->bus), pdev->bus->number,
> > -                PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
> > -     seq_printf(m, "drm-client-id:\t%u\n", client->id);
> > -
> >       /*
> >        * Temporarily skip showing client engine information with GuC su=
bmission till
> >        * fetching engine busyness is implemented in the GuC submission =
backend
> > @@ -155,6 +147,6 @@ void i915_drm_client_fdinfo(struct seq_file *m, str=
uct file *f)
> >               return;
> >
> >       for (i =3D 0; i < ARRAY_SIZE(uabi_class_names); i++)
> > -             show_client_class(m, client, i);
> > +             show_client_class(p, client, i);
> >   }
> >   #endif
> > diff --git a/drivers/gpu/drm/i915/i915_drm_client.h b/drivers/gpu/drm/i=
915/i915_drm_client.h
> > index 69496af996d9..ef85fef45de5 100644
> > --- a/drivers/gpu/drm/i915/i915_drm_client.h
> > +++ b/drivers/gpu/drm/i915/i915_drm_client.h
> > @@ -60,7 +60,7 @@ static inline void i915_drm_client_put(struct i915_dr=
m_client *client)
> >   struct i915_drm_client *i915_drm_client_add(struct i915_drm_clients *=
clients);
> >
> >   #ifdef CONFIG_PROC_FS
> > -void i915_drm_client_fdinfo(struct seq_file *m, struct file *f);
> > +void i915_drm_client_fdinfo(struct drm_printer *p, struct drm_file *fi=
le);
> >   #endif
> >
> >   void i915_drm_clients_fini(struct i915_drm_clients *clients);
