Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18FF6D3740
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 12:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjDBKXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 06:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjDBKWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 06:22:49 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1079765
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 03:22:46 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id cu36so22910491vsb.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 03:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680430965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cqt+0LvMfoOorBMYDQIvk68awcF7EkMGpn308vi5jnw=;
        b=brx3cOmlB4NB4+SUVwPr+emDg5TQr/ONpS5B8DUZRYWlO1uvY/dKBcOb7pC2LbmKWe
         JbOFn5/rn+y5GXpqkkCUcI/6nWhm0kWBW6d8MZACls2lIs7NR1HPalwiewRK4PGEGLa+
         bepbf/yicz9/7OStMoiM1JKU/a5Vdl9qivte0gAx/ibgZyzR2y/rilZIBypec4i5T6C/
         FEutBpVI2gaSupLDpdEJHTgP4z4wW7j4X3qg3C2xz2ZDCzUhoJ8qQ0eftwGWr8CJhIL+
         aFHVsuebelAYLOuZBpQ4HIIMU7mm3oiy0DGlI4JMHnPO2d5yxsc8QQTl6xaIaZlkCJ8E
         62tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680430965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cqt+0LvMfoOorBMYDQIvk68awcF7EkMGpn308vi5jnw=;
        b=eiWIEikavUjKEQV5wx2fVoYu2tCbEHUAGDyx1PaIH4fjvpXd+mFE+GGv1JgIU65p0S
         fuA2VZ9gV3mlDfKcqoBgrDFvlX3OtcVVaTmVulalElKGLtNEKc24MznbOubAudgh0LcJ
         tyb1DOI8tGAEWcx4GsGtZ0fFqV4ZtWNa40J8YbG3GdGv1V2Pl1sCEMPxGRDDfTidprfv
         wJb3x5G8rR0QXUdHvvpazLYVCyBmvkzqcNqAVh7YdXjN5g23P4WSrL2jpw/JvBh9WCyT
         CL9dyhv0ug3/KX3J4D4BoEQ7r4VFo/kGlfodeCKh/+G3uCEI54SwvOJSjRPrn+tJopfh
         b4yw==
X-Gm-Message-State: AAQBX9frwLvjyADa7vhGxUaD5znbt1kLYS8QqALBfZOxsZW3M+5JNFFw
        Uus1ljpOQfdjQ6vjpQ1UeMKfjxKDNCtl1JgeD90=
X-Google-Smtp-Source: AKy350YzdAw3jPa3CDdSsbjfA/b0tMJpyuWevQVxE21HvuJBKce7SK45DmepJXZm1Jg8tIkEDKwYyHK2M++Y5gNzzXY=
X-Received: by 2002:a67:e116:0:b0:426:df00:9b12 with SMTP id
 d22-20020a67e116000000b00426df009b12mr6160727vsl.1.1680430965370; Sun, 02 Apr
 2023 03:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230312233052.21095-1-nunes.erico@gmail.com> <CAKGbVbs2ZRGyYOy9yYUMJ+apQm=NaXXb58C-97CaoTe5KPNqgw@mail.gmail.com>
In-Reply-To: <CAKGbVbs2ZRGyYOy9yYUMJ+apQm=NaXXb58C-97CaoTe5KPNqgw@mail.gmail.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Sun, 2 Apr 2023 18:22:34 +0800
Message-ID: <CAKGbVbtb-cKv2Fb1x91vZssZxayxciSp3RLJeVsn0z1JhvT6QQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/lima: expose usage statistics via fdinfo
To:     Erico Nunes <nunes.erico@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, lima@lists.freedesktop.org,
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

On Mon, Mar 13, 2023 at 11:09=E2=80=AFAM Qiang Yu <yuq825@gmail.com> wrote:
>
> Patch set is:
> Reviewed-by: Qiang Yu <yuq825@gmail.com>
>
> Looks like drm-misc-next does not contain "df622729ddbf drm/scheduler:
> track GPU active time per entity" yet.
> Will apply later.
>
> Regards,
> Qiang
>
> On Mon, Mar 13, 2023 at 7:31=E2=80=AFAM Erico Nunes <nunes.erico@gmail.co=
m> wrote:
> >
> > Expose lima gp and pp usage stats through fdinfo, following
> > Documentation/gpu/drm-usage-stats.rst.
> > Borrowed from these previous implementations:
> >
> > "df622729ddbf drm/scheduler: track GPU active time per entity" added
> > usage time accounting to drm scheduler, which is where the data used
> > here comes from.
> >
> > Then the main implementation is based on these etnaviv commits:
> > "d306788b6e1b drm/etnaviv: allocate unique ID per drm_file" and
> > "97804a133c68 drm/etnaviv: export client GPU usage statistics via
> > fdinfo"
> >
> > Also "874442541133 drm/amdgpu: Add show_fdinfo() interface" since lima
> > has a context manager very similar to amdgpu and all contexts created
> > (and released) at the ctx_mgr level need to be accounted for.
> >
> > Tested with the generic "gputop" tool currently available as patches to
> > igt, a sample run with this patchset looks like this:
> >
> > DRM minor 128
> >     PID               NAME             gp                        pp
> >     4322   glmark2-es2-way |=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=
=88=E2=96=8A                  ||=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=
=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=
=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88      |
> >     3561            weston |=E2=96=8E                       ||=E2=96=88=
=E2=96=88=E2=96=88=E2=96=8C                    |
> >     4159          Xwayland |=E2=96=8F                       ||=E2=96=89=
                       |
> >     4154          glxgears |=E2=96=8F                       ||=E2=96=8E=
                       |
> >     3661           firefox |=E2=96=8F                       ||=E2=96=8F=
                       |
> >
> >
> > Erico Nunes (3):
> >   drm/lima: add usage counting method to ctx_mgr
> >   drm/lima: allocate unique id per drm_file
> >   drm/lima: add show_fdinfo for drm usage stats
> >
> >  drivers/gpu/drm/lima/lima_ctx.c    | 30 ++++++++++++++++++++-
> >  drivers/gpu/drm/lima/lima_ctx.h    |  3 +++
> >  drivers/gpu/drm/lima/lima_device.h |  3 +++
> >  drivers/gpu/drm/lima/lima_drv.c    | 43 +++++++++++++++++++++++++++++-
> >  drivers/gpu/drm/lima/lima_drv.h    |  1 +
> >  5 files changed, 78 insertions(+), 2 deletions(-)
> >
> > --
> > 2.39.2
> >
