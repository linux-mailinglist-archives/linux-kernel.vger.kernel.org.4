Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAC467DCBF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 04:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjA0Dzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 22:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjA0Dz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 22:55:28 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E8361D6A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 19:55:27 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id tz11so10594801ejc.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 19:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ocwlvVVRwbuYPWxcE07iTDqSaV/OyweQxO5lM24FLrg=;
        b=JR6e/ZUvBcVeqhG6fnc+zYKDWAhSlViQ7SBV+T34Wn7KIThgieQBvXEN/NkOF8CjX4
         c9qUgJDrGdWvP/ktrRjss5iiciB9cRdjI3pTQD56ZGf396wRWBtBUZf7Mhfh5oZ28LIh
         9P3F7TALrIFRYkyU+QRFTZ2o/psJ3Mo0GBAdhIMEPeB640SzgjUfu/dSqcGMyVhvUx9Z
         xpF+/XrNxuC0zljqM5I9Bvw7e3uUJoPn0nIdQmymtLk51hxuhir2ZgXFCQ2dY9GBvlPI
         B6j7w2t0PzqAQpJUCarlENo/6Q6NyBU2rWywpEVlcXho1RF9cBEkT32/gG/muTKBq94u
         OjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ocwlvVVRwbuYPWxcE07iTDqSaV/OyweQxO5lM24FLrg=;
        b=jBQ19ffbMkfA24dYvlZBytTVXhs/qvORcsqUDnv1eWgaP5qtlg/P6PzQuYTpEpNjTk
         Pp7DLxwO1YY+qqVLvj+ibCew7JXpdEs4zNXKcvhj5EnnEKbJQzHhhv6FmSL04GQbJzIY
         TJJpWz57hZLhl73ovKbOOfoMBvk9qE71OBuCCauV2VEVsagJbZnjdiT2E1UWlE03C9Go
         /QfSXdon8kkjpSYPM0nlCnCSo2kYEhNBvSNA571EqnvQ446fVxW1JU//P43Pics0iFtb
         8FqiLdeHzI30/DSjoKM6mKUrSZFWJteZKb3ob+hpKuOx2kYAL4aMHlATHI7owXOWWFD1
         iM+Q==
X-Gm-Message-State: AFqh2kpY8I87SLrgCnhgyIrtlRgZm9RDzLlusvqpVlT20KOf7KuGPNIo
        NmByLP9aLL1bQ0oEl5zs2hEzxytRl4Zak7bNhzlPj6l9
X-Google-Smtp-Source: AMrXdXsS68fiCxg4Ak+9N/1iWAU6p9z/wehS+2LyShiGBRRDnGpRNDONi6/u3qcSksMZq6E5nq2kwabPITng8+2D5QE=
X-Received: by 2002:a17:906:ce43:b0:84d:6f4a:3b15 with SMTP id
 se3-20020a170906ce4300b0084d6f4a3b15mr5259881ejb.48.1674791726033; Thu, 26
 Jan 2023 19:55:26 -0800 (PST)
MIME-Version: 1.0
References: <20230126163605.3524630-1-arnd@kernel.org> <5ad53f8f-155a-d1e8-68e3-c82577816c76@amd.com>
In-Reply-To: <5ad53f8f-155a-d1e8-68e3-c82577816c76@amd.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 27 Jan 2023 13:55:13 +1000
Message-ID: <CAPM=9ty76NiuhUyk=AA75YUx=LXBU26OX4hCUFL=M7exh=eSRw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display/mst: fix an unused-variable warning
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, Roman Li <roman.li@amd.com>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        hersen wu <hersenxs.wu@amd.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Wayne Lin <Wayne.Lin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Fri, 27 Jan 2023 at 07:06, Hamza Mahfooz <hamza.mahfooz@amd.com> wrote:
>
> On 1/26/23 11:35, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The newly added code is in an #ifdef, so the variables that
> > are only used in there cause a warning if CONFIG_DRM_AMD_DC_DCN
> > is disabled:
> >
> > drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function 'amdgpu_dm_atomic_check':
> > drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9698:43: error: unused variable 'mst_state' [-Werror=unused-variable]
> >   9698 |         struct drm_dp_mst_topology_state *mst_state;
> >        |                                           ^~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9697:41: error: unused variable 'mgr' [-Werror=unused-variable]
> >   9697 |         struct drm_dp_mst_topology_mgr *mgr;
> >        |                                         ^~~
> >
> > Fixes: c689e1e362ea ("drm/amdgpu/display/mst: Fix mst_state->pbn_div and slot count assignments")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Applied, thanks!
>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index be1232356f9e..c966bb05f6c7 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -9694,8 +9694,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
> >       struct drm_connector_state *old_con_state, *new_con_state;
> >       struct drm_crtc *crtc;
> >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > +#if defined(CONFIG_DRM_AMD_DC_DCN)
> >       struct drm_dp_mst_topology_mgr *mgr;
> >       struct drm_dp_mst_topology_state *mst_state;
> > +#endif
> >       struct drm_plane *plane;
> >       struct drm_plane_state *old_plane_state, *new_plane_state;
> >       enum dc_status status;
>

I've pushed an alternate fix to drm-fixes as I pulled in a tree this
morning and it failed to build on arm here.

Dave.
