Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE63D6A561C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjB1Jsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjB1Jsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:48:40 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B590F86A7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:48:39 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id bd34so5310727pfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPddb0HDtF9d2o1OZFO2vc7qzozYm9cGO8ZIZD2N5lo=;
        b=Hj+f2ENp6WO4WsJRYAfufUCPyaAd32keia9MlPZGg0Xou3OJ2lU3YFnl46+qmEK+Mv
         S+USkkw8L7lFm+w8xJmojj8InjdS0d9sYDbmuQGEjTnyE6OVnpouM0FqM2yfrQOeI871
         4v4LANzC+qLcG5qvgfcyIeN4/Cc9ruYguOtB15BoFtpfLM1VbwbUyQgOf8r/YL2KlyeR
         kpEJCxNoUw6GmZxqTZNteySU6Z/g9bEwpZeX4njDDN2LLApDPPdGhmnLnYWTiyWZCehQ
         06wgOTHKvnaL+3Kkf5m0JaEbcERN3RRLxA8N3licfS1Yp1ESws/9bAL18aj2Rs5FKeF2
         3xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPddb0HDtF9d2o1OZFO2vc7qzozYm9cGO8ZIZD2N5lo=;
        b=miwHAulRSweXOZH3lIm8BKnKWc8oCUvi6oGekXjSoTs2EcdBTX4KcFn9EkUfSlfncj
         6LX2nKGefoDXJdCoP0m8oJByB/q5Otba6RRTaGpw84uUbyUirNnjmI4LENtkh45zozQ2
         vbvMdMLeAaod7SYKRJ09dFtSyKOwEmPkifB7lHZP38+0kTofPcqChP9rT1388JLewAVL
         wv3HMjPOdhKOCy3T9FbRYCUiU0sm3Hw3e5srQ+qOh/yNXINZ/5Cb+PRaeJCfsSxw6S0W
         q2BnUpmXmxsKSYMjtmxQxIjL4vv0pEr0sbNPqpbbXlMo2ArXjGfi8YAnGjfV/BciuWzs
         qnog==
X-Gm-Message-State: AO0yUKWHh9Bw/LwxBWYMKeFbl8iN4o56dQZO75Qv/jaejodpspOlS59t
        1ndo7YZ3iQGlMdmvVNkj024Z2WYL8zDzRFjSIfQ=
X-Google-Smtp-Source: AK7set/XV1Z9lnz2CrSQ2DN/jTG6ghKPsR3pFFITXMXczTKbs1kKa9TpXEwQ8EchaXFpz0DQ/WpqttGYkBc/gQ3OyG0=
X-Received: by 2002:a63:b513:0:b0:502:f46f:c7c6 with SMTP id
 y19-20020a63b513000000b00502f46fc7c6mr595842pge.1.1677577719146; Tue, 28 Feb
 2023 01:48:39 -0800 (PST)
MIME-Version: 1.0
References: <63fd57cb.620a0220.4e1b.8886@mx.google.com> <461f3a89-53d0-4a80-2d9b-0d3d648e1405@suse.de>
In-Reply-To: <461f3a89-53d0-4a80-2d9b-0d3d648e1405@suse.de>
From:   Luc Ma <onion0709@gmail.com>
Date:   Tue, 28 Feb 2023 17:48:27 +0800
Message-ID: <CAB3Z9RLCU1c1G_8Rus1f_37YvhHpuJgXQXainTxz+Q9qqTaOSw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/vram-helper: fix function names in vram helper doc
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023 at 16:11, Thomas Zimmermann <tzimmermann@suse.de> wrote=
:
>
> Hi
>
> Am 28.02.23 um 02:24 schrieb Luc Ma:
> > Refer to drmm_vram_helper_init() instead of the non-existent
> > drmm_vram_helper_alloc_mm().
> >
> > Fixes: a5f23a72355d ("drm/vram-helper: Managed vram helpers")
> > Signed-off-by: Luc Ma <luc@sietium.com>
>
> I didn't notice before: your sender email address has to match the
> signed-off-by address. I can fix that when I commit the patch. Which
> email address shall I use?

Hi, Thomas
please use Luc Ma <luc@sietium.com>, thank you

>
> Apart from that
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> Best regards
> Thomas
>
> > ---
> > v1 -> v2: improved commit message and add changelog
> >
> >   drivers/gpu/drm/drm_gem_vram_helper.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/dr=
m_gem_vram_helper.c
> > index d40b3edb52d0..f1539d4448c6 100644
> > --- a/drivers/gpu/drm/drm_gem_vram_helper.c
> > +++ b/drivers/gpu/drm/drm_gem_vram_helper.c
> > @@ -45,7 +45,7 @@ static const struct drm_gem_object_funcs drm_gem_vram=
_object_funcs;
> >    * the frame's scanout buffer or the cursor image. If there's no more=
 space
> >    * left in VRAM, inactive GEM objects can be moved to system memory.
> >    *
> > - * To initialize the VRAM helper library call drmm_vram_helper_alloc_m=
m().
> > + * To initialize the VRAM helper library call drmm_vram_helper_init().
> >    * The function allocates and initializes an instance of &struct drm_=
vram_mm
> >    * in &struct drm_device.vram_mm . Use &DRM_GEM_VRAM_DRIVER to initia=
lize
> >    * &struct drm_driver and  &DRM_VRAM_MM_FILE_OPERATIONS to initialize
> > @@ -73,7 +73,7 @@ static const struct drm_gem_object_funcs drm_gem_vram=
_object_funcs;
> >    *          // setup device, vram base and size
> >    *          // ...
> >    *
> > - *           ret =3D drmm_vram_helper_alloc_mm(dev, vram_base, vram_si=
ze);
> > + *           ret =3D drmm_vram_helper_init(dev, vram_base, vram_size);
> >    *          if (ret)
> >    *                  return ret;
> >    *          return 0;
> > @@ -86,7 +86,7 @@ static const struct drm_gem_object_funcs drm_gem_vram=
_object_funcs;
> >    * to userspace.
> >    *
> >    * You don't have to clean up the instance of VRAM MM.
> > - * drmm_vram_helper_alloc_mm() is a managed interface that installs a
> > + * drmm_vram_helper_init() is a managed interface that installs a
> >    * clean-up handler to run during the DRM device's release.
> >    *
> >    * For drawing or scanout operations, rsp. buffer objects have to be =
pinned
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev
