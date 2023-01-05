Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58E365EAD2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjAEMkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjAEMk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:40:28 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9640E4103B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:40:26 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso1191467wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 04:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u72AB24+qa4e+mmlqHTng43rKK5tJgT0XJ4X1hFnOZY=;
        b=PQxfCtFMvTLRPftYbZmPlE8qhfBja8J3rxwqwsvaMY6MYMkhXLA8MdRbStUcxPiSfx
         aOn87eQmEvxv9cfm0z5Og6/KFKLOgXJUK64eWvMnzoQgQH0AUsefRfMqKrz5uzGBZ3pM
         4Rw8y2KgDs9h5GqjY0vXK866VcaannZlZS7Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u72AB24+qa4e+mmlqHTng43rKK5tJgT0XJ4X1hFnOZY=;
        b=wzRGpc7BhvvcGL9j7tMy8of6kUTjqw/R3ntU8iBGAqNWhYfUetla7H8vKxq1Addpkp
         2bQQY5yBw06P8TWD2Kj5w4ogjc+vg3UDYvb0Rdv6t1O5jsL1p42fkjoAGcz1eByKF0WE
         FDxQPuGL6wnBEEHSzo/kphSvr00WhvFHn42SL6rF1lBmd6e27+o60zqXmH4Hum0qHRQw
         KHkF+93Hkw9S31dAO/IecLyLBFpsnezv7fAq+Gj/4zjzWskXR1ExzmFM+JsW9cSSCC9C
         044JUP3bY2Opq0Gnxsf0qza3IGIppiRBa8R1UVviQlo+9WZ757/zXYEVlwQJFvGLTE2z
         3QFQ==
X-Gm-Message-State: AFqh2kroBnRw/dKc9tdkU4BADGblolSTYHacykzr7IQb2NyOpcnFO53P
        N4AGMTcsB8LYjYiMp99DeutLCA==
X-Google-Smtp-Source: AMrXdXsu5VxnTPAKKJBYcokTLsPEF/4yGSQsqnxh/kx+LZL+INiQeTim0IqPUr5XsEi9jpjChc526A==
X-Received: by 2002:a05:600c:3d91:b0:3d9:103d:9078 with SMTP id bi17-20020a05600c3d9100b003d9103d9078mr35017703wmb.22.1672922425144;
        Thu, 05 Jan 2023 04:40:25 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l10-20020a05600c1d0a00b003d9862ec435sm2466122wms.20.2023.01.05.04.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 04:40:24 -0800 (PST)
Date:   Thu, 5 Jan 2023 13:40:21 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     tzimmermann@suse.de,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Borislav Petkov <bp@suse.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Danilo Krummrich <dakr@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [RESEND PATCH linux-next v2 00/10] drm: Remove some obsolete
 drivers(tdfx, mga, i810, savage, r128, sis, via)
Message-ID: <Y7bFNQ5a+qAcxWj+@phenom.ffwll.local>
Mail-Followup-To: Cai Huoqing <cai.huoqing@linux.dev>, tzimmermann@suse.de,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>, Borislav Petkov <bp@suse.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Danilo Krummrich <dakr@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20221203102502.3185-1-cai.huoqing@linux.dev>
 <20221208124207.GA7628@chq-T47>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221208124207.GA7628@chq-T47>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 08:42:07PM +0800, Cai Huoqing wrote:
> On 03 12月 22 18:22:51, Cai Huoqing wrote:
> > Commit 399516ab0fee ("MAINTAINERS: Add a bunch of legacy (UMS) DRM drivers")
> > marked these drivers obsolete 7 years ago.
> > And the mesa UMD of these drm drivers already in deprecated list
> > in the link: https://docs.mesa3d.org/systems.html
> > 
> > 3dfx Glide-->driver/gpu/drm/tdfx
> > Matrox-->driver/gpu/drm/mga
> > Intel i810-->driver/gpu/drm/i810
> > S3 Savage-->drivers/gpu/drm/savage
> > ATI Rage 128->drivers/gpu/drm/r128
> > Silicon Integrated Systems->drivers/gpu/drm/sis
> > VIA Unichrome->drivers/gpu/drm/via
> > 
> > v1->v2:
> > 1.Add drm via driver to the patchset.
> > 2.Remove related drm_pciids.
> > 3.Remove related drm uapi header files.
> > 4.split to series avoid large patch email.
> Just ping these patch series.
> The v1 comments here,
> https://lore.kernel.org/lkml/39d8ac1a-d92f-7cdc-14cd-944342f78c1a@suse.de/

Are we really sure that all users of these are gone? Also, I'm not really
seeing the benefit of this, we've managed to split out the legacy code
quite well, so carrying around isn't hurting anything afaics?
-Daniel

> 
> Thanks,
> Cai
> > 
> > Cai Huoqing (10):
> >   drm: Remove the obsolete driver-i810
> >   drm: Remove the obsolete driver-mga
> >   drm: Remove the obsolete driver-r128
> >   drm: Remove the obsolete driver-savage
> >   drm: Remove the obsolete driver-sis
> >   drm: Remove the obsolete driver-tdfx
> >   drm: Remove the obsolete driver-via
> >   drm: Add comments to Kconfig
> >   drm: Remove some obsolete drm pciids(tdfx, mga, i810, savage, r128,
> >     sis, via)
> >   MAINTAINERS: Remove some obsolete drivers info(tdfx, mga, i810,
> >     savage, r128, sis)
> > 
> >  MAINTAINERS                           |   29 -
> >  drivers/gpu/drm/Kconfig               |   59 +-
> >  drivers/gpu/drm/Makefile              |    7 -
> >  drivers/gpu/drm/i810/Makefile         |    8 -
> >  drivers/gpu/drm/i810/i810_dma.c       | 1266 ---------
> >  drivers/gpu/drm/i810/i810_drv.c       |  101 -
> >  drivers/gpu/drm/i810/i810_drv.h       |  246 --
> >  drivers/gpu/drm/mga/Makefile          |   11 -
> >  drivers/gpu/drm/mga/mga_dma.c         | 1168 --------
> >  drivers/gpu/drm/mga/mga_drv.c         |  104 -
> >  drivers/gpu/drm/mga/mga_drv.h         |  685 -----
> >  drivers/gpu/drm/mga/mga_ioc32.c       |  197 --
> >  drivers/gpu/drm/mga/mga_irq.c         |  169 --
> >  drivers/gpu/drm/mga/mga_state.c       | 1099 --------
> >  drivers/gpu/drm/mga/mga_warp.c        |  167 --
> >  drivers/gpu/drm/r128/Makefile         |   10 -
> >  drivers/gpu/drm/r128/ati_pcigart.c    |  228 --
> >  drivers/gpu/drm/r128/ati_pcigart.h    |   31 -
> >  drivers/gpu/drm/r128/r128_cce.c       |  944 -------
> >  drivers/gpu/drm/r128/r128_drv.c       |  116 -
> >  drivers/gpu/drm/r128/r128_drv.h       |  544 ----
> >  drivers/gpu/drm/r128/r128_ioc32.c     |  199 --
> >  drivers/gpu/drm/r128/r128_irq.c       |  118 -
> >  drivers/gpu/drm/r128/r128_state.c     | 1641 -----------
> >  drivers/gpu/drm/savage/Makefile       |    9 -
> >  drivers/gpu/drm/savage/savage_bci.c   | 1082 --------
> >  drivers/gpu/drm/savage/savage_drv.c   |   91 -
> >  drivers/gpu/drm/savage/savage_drv.h   |  580 ----
> >  drivers/gpu/drm/savage/savage_state.c | 1169 --------
> >  drivers/gpu/drm/sis/Makefile          |   10 -
> >  drivers/gpu/drm/sis/sis_drv.c         |  143 -
> >  drivers/gpu/drm/sis/sis_drv.h         |   80 -
> >  drivers/gpu/drm/sis/sis_mm.c          |  363 ---
> >  drivers/gpu/drm/tdfx/Makefile         |    8 -
> >  drivers/gpu/drm/tdfx/tdfx_drv.c       |   90 -
> >  drivers/gpu/drm/tdfx/tdfx_drv.h       |   47 -
> >  drivers/gpu/drm/via/Makefile          |    8 -
> >  drivers/gpu/drm/via/via_3d_reg.h      | 1771 ------------
> >  drivers/gpu/drm/via/via_dri1.c        | 3630 -------------------------
> >  include/drm/drm_pciids.h              |  112 -
> >  include/uapi/drm/i810_drm.h           |  292 --
> >  include/uapi/drm/mga_drm.h            |  429 ---
> >  include/uapi/drm/r128_drm.h           |  336 ---
> >  include/uapi/drm/savage_drm.h         |  220 --
> >  include/uapi/drm/sis_drm.h            |   77 -
> >  include/uapi/drm/via_drm.h            |  282 --
> >  46 files changed, 1 insertion(+), 19975 deletions(-)
> >  delete mode 100644 drivers/gpu/drm/i810/Makefile
> >  delete mode 100644 drivers/gpu/drm/i810/i810_dma.c
> >  delete mode 100644 drivers/gpu/drm/i810/i810_drv.c
> >  delete mode 100644 drivers/gpu/drm/i810/i810_drv.h
> >  delete mode 100644 drivers/gpu/drm/mga/Makefile
> >  delete mode 100644 drivers/gpu/drm/mga/mga_dma.c
> >  delete mode 100644 drivers/gpu/drm/mga/mga_drv.c
> >  delete mode 100644 drivers/gpu/drm/mga/mga_drv.h
> >  delete mode 100644 drivers/gpu/drm/mga/mga_ioc32.c
> >  delete mode 100644 drivers/gpu/drm/mga/mga_irq.c
> >  delete mode 100644 drivers/gpu/drm/mga/mga_state.c
> >  delete mode 100644 drivers/gpu/drm/mga/mga_warp.c
> >  delete mode 100644 drivers/gpu/drm/r128/Makefile
> >  delete mode 100644 drivers/gpu/drm/r128/ati_pcigart.c
> >  delete mode 100644 drivers/gpu/drm/r128/ati_pcigart.h
> >  delete mode 100644 drivers/gpu/drm/r128/r128_cce.c
> >  delete mode 100644 drivers/gpu/drm/r128/r128_drv.c
> >  delete mode 100644 drivers/gpu/drm/r128/r128_drv.h
> >  delete mode 100644 drivers/gpu/drm/r128/r128_ioc32.c
> >  delete mode 100644 drivers/gpu/drm/r128/r128_irq.c
> >  delete mode 100644 drivers/gpu/drm/r128/r128_state.c
> >  delete mode 100644 drivers/gpu/drm/savage/Makefile
> >  delete mode 100644 drivers/gpu/drm/savage/savage_bci.c
> >  delete mode 100644 drivers/gpu/drm/savage/savage_drv.c
> >  delete mode 100644 drivers/gpu/drm/savage/savage_drv.h
> >  delete mode 100644 drivers/gpu/drm/savage/savage_state.c
> >  delete mode 100644 drivers/gpu/drm/sis/Makefile
> >  delete mode 100644 drivers/gpu/drm/sis/sis_drv.c
> >  delete mode 100644 drivers/gpu/drm/sis/sis_drv.h
> >  delete mode 100644 drivers/gpu/drm/sis/sis_mm.c
> >  delete mode 100644 drivers/gpu/drm/tdfx/Makefile
> >  delete mode 100644 drivers/gpu/drm/tdfx/tdfx_drv.c
> >  delete mode 100644 drivers/gpu/drm/tdfx/tdfx_drv.h
> >  delete mode 100644 drivers/gpu/drm/via/Makefile
> >  delete mode 100644 drivers/gpu/drm/via/via_3d_reg.h
> >  delete mode 100644 drivers/gpu/drm/via/via_dri1.c
> >  delete mode 100644 include/uapi/drm/i810_drm.h
> >  delete mode 100644 include/uapi/drm/mga_drm.h
> >  delete mode 100644 include/uapi/drm/r128_drm.h
> >  delete mode 100644 include/uapi/drm/savage_drm.h
> >  delete mode 100644 include/uapi/drm/sis_drm.h
> >  delete mode 100644 include/uapi/drm/via_drm.h
> > 
> > -- 
> > 2.25.1
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
