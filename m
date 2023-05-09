Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE466FCBD8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjEIQyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjEIQyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:54:43 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0C559C8
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 09:54:16 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bc22805d3so9521762a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 09:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=froggi.es; s=google; t=1683651254; x=1686243254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wdv0Hvt23cBP3kgFwrDtJva8h58arVNJiVb7/RW+Ytc=;
        b=Vb36Lsakl8uSK/JBWleY9cf4JwpBICqLd9quOjO50HRqAdkSd8upjCqxUCF7EZL4U4
         Cy/7tPrnD5OK+ewFlX0jYfKaihTZgu1JVE1y0KKdeTxB3Q8TC3ZnGUwHMlbWBiDghHU2
         INgbq3x/xD6si3L/U7+dx0Sczd1/gItDj4uYiw6I7XsHDQ95RRZUYZzQcF17xX+iKfJK
         JsiIaU+cwORra45IwrwX85vYLuQ1tdUy7Bz/gYck7AAUE8YzqvrL7rZHC70a8i4aW19p
         72eTNtgWXKa2F1ET/WAkNR4Oox7FX5Rc+SbaNQ1G0Momga2HDG+tLdJVzinjEwkUNnpV
         irwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683651254; x=1686243254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdv0Hvt23cBP3kgFwrDtJva8h58arVNJiVb7/RW+Ytc=;
        b=PyaDSdN1aY13Xiug8OxScq7Gkh39yJ1xKN202dsyTZBlmXmali1yAcJTGHWJfyadiZ
         ztfE9tvHEMrh4kkl8/b0EFUPpidOfTSzjeruwYRvKHAjHBIgo9qY2vkJ7dO8on2kgLD4
         IWMWub4fn4kf7tD4TD7dlKVj3Z1Fm4Q3ithaZuD4MlmpUUkX2MkUsQToN+SQv+OYSTpj
         tG/ii/hQfddontiVTwLLWh6Ni39EQazxOzHQpVpPtoK6nD6tld3MLTCTALPN/4rSDx7G
         DljrYn1YIrStuW9sf/RZSgWiZsDq0iAti4bWIl2Ni4W7ZxZ8CmVITDtdjAmI7dXlhsQa
         1GwA==
X-Gm-Message-State: AC+VfDxvpNajTQrvXDWjYgJ9h5svBi+bbwB/xAkahks0vXS/X3gk2TFf
        ODls+S3GNIhSX4+su3OlhbnL3Z16Ld5uv9Rj4Bh6ng==
X-Google-Smtp-Source: ACHHUZ6jecIicj6C1JfaOhiAI5QVDr/zlRX0pmCFy1M0UUvG0VknNkJyOZ2qWaQPpIfcCCCIjBOr39cdjEXX4exPv8s=
X-Received: by 2002:a50:fe8c:0:b0:506:ba8d:c317 with SMTP id
 d12-20020a50fe8c000000b00506ba8dc317mr11015954edt.40.1683651254321; Tue, 09
 May 2023 09:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230423141051.702990-1-mwen@igalia.com> <20230423141051.702990-13-mwen@igalia.com>
 <5bbd49b6-ad09-607f-521d-96f9d8eb3b20@amd.com> <20230509163701.57lf22phumicqv37@mail.igalia.com>
In-Reply-To: <20230509163701.57lf22phumicqv37@mail.igalia.com>
From:   Joshua Ashton <joshua@froggi.es>
Date:   Tue, 9 May 2023 16:54:03 +0000
Message-ID: <CAEZNXZAfq_6EZHBhBXjMPwOuU10rwKe3SPJpz1hetux=HRF4CQ@mail.gmail.com>
Subject: Re: [RFC PATCH 12/40] drm/amd/display: add plane HDR multiplier
 driver-private property
To:     Melissa Wen <mwen@igalia.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        amd-gfx@lists.freedesktop.org,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        sunpeng.li@amd.com, Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Sebastian Wick <sebastian.wick@redhat.com>,
        Xaver Hugl <xaver.hugl@gmail.com>,
        Shashank Sharma <Shashank.Sharma@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        sungjoon.kim@amd.com, Alex Hung <alex.hung@amd.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently do not have a use for this as we settled on per-plane 3D
LUT + Shaper, but we might end up wanting to use in our scRGB stack
someday so I would like to keep it.

On Tue, 9 May 2023 at 16:37, Melissa Wen <mwen@igalia.com> wrote:
>
> On 05/08, Harry Wentland wrote:
> >
> >
> > On 4/23/23 10:10, Melissa Wen wrote:
> > > From: Joshua Ashton <joshua@froggi.es>
> > >
> > > Multiplier to 'gain' the plane. When PQ is decoded using the fixed func
> > > transfer function to the internal FP16 fb, 1.0 -> 80 nits (on AMD at
> > > least) When sRGB is decoded, 1.0 -> 1.0.  Therefore, 1.0 multiplier = 80
> > > nits for SDR content. So if you want, 203 nits for SDR content, pass in
> > > (203.0 / 80.0).
> > >
> >
> > Is gamescope intending to use this?
>
> I don't think so. Again, I'll double check and drop it accordingly.
>
> Melissa
>
> >
> > Harry
> >
> > > Co-developed-by: Melissa Wen <mwen@igalia.com>
> > > Signed-off-by: Melissa Wen <mwen@igalia.com>
> > > Signed-off-by: Joshua Ashton <joshua@froggi.es>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  6 +++++
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  4 +++
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 12 +++++++++
> > >  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 25 ++++++++++++++-----
> > >  4 files changed, 41 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > > index 24595906dab1..dd658f162f6f 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > > @@ -1326,6 +1326,12 @@ amdgpu_display_create_color_properties(struct amdgpu_device *adev)
> > >             return -ENOMEM;
> > >     adev->mode_info.plane_degamma_tf_property = prop;
> > >
> > > +   prop = drm_property_create_range(adev_to_drm(adev),
> > > +                                    0, "AMD_PLANE_HDR_MULT", 0, UINT_MAX);
> > > +   if (!prop)
> > > +           return -ENOMEM;
> > > +   adev->mode_info.plane_hdr_mult_property = prop;
> > > +
> > >     return 0;
> > >  }
> > >  #endif
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> > > index ab9ce6f26c90..65a9d62ffbe4 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> > > @@ -387,6 +387,10 @@ struct amdgpu_mode_info {
> > >      * linearize content with or without LUT.
> > >      */
> > >     struct drm_property *plane_degamma_tf_property;
> > > +   /**
> > > +    * @plane_hdr_mult_property:
> > > +    */
> > > +   struct drm_property *plane_hdr_mult_property;
> > >  #endif
> > >  };
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> > > index 005632c1c9ec..bb7307b9cfd5 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> > > @@ -51,6 +51,7 @@
> > >
> > >  #define AMDGPU_DMUB_NOTIFICATION_MAX 5
> > >
> > > +#define AMDGPU_HDR_MULT_DEFAULT (0x100000000LL)
> > >  /*
> > >  #include "include/amdgpu_dal_power_if.h"
> > >  #include "amdgpu_dm_irq.h"
> > > @@ -736,6 +737,17 @@ struct dm_plane_state {
> > >      * linearize.
> > >      */
> > >     enum drm_transfer_function degamma_tf;
> > > +   /**
> > > +    * @hdr_mult:
> > > +    *
> > > +    * Multiplier to 'gain' the plane.  When PQ is decoded using the fixed
> > > +    * func transfer function to the internal FP16 fb, 1.0 -> 80 nits (on
> > > +    * AMD at least). When sRGB is decoded, 1.0 -> 1.0, obviously.
> > > +    * Therefore, 1.0 multiplier = 80 nits for SDR content.  So if you
> > > +    * want, 203 nits for SDR content, pass in (203.0 / 80.0).  Format is
> > > +    * S31.32 sign-magnitude.
> > > +    */
> > > +   __u64 hdr_mult;
> > >  #endif
> > >  };
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > > index 5b458cc0781c..57169dae8b3d 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > > @@ -1321,8 +1321,10 @@ static void dm_drm_plane_reset(struct drm_plane *plane)
> > >             __drm_atomic_helper_plane_reset(plane, &amdgpu_state->base);
> > >
> > >  #ifdef CONFIG_STEAM_DECK
> > > -   if (amdgpu_state)
> > > +   if (amdgpu_state) {
> > >             amdgpu_state->degamma_tf = DRM_TRANSFER_FUNCTION_DEFAULT;
> > > +           amdgpu_state->hdr_mult = AMDGPU_HDR_MULT_DEFAULT;
> > > +   }
> > >  #endif
> > >  }
> > >
> > > @@ -1424,11 +1426,11 @@ static void dm_drm_plane_destroy_state(struct drm_plane *plane,
> > >  #ifdef CONFIG_STEAM_DECK
> > >  int
> > >  amdgpu_dm_replace_property_blob_from_id(struct drm_device *dev,
> > > -                                          struct drm_property_blob **blob,
> > > -                                          uint64_t blob_id,
> > > -                                          ssize_t expected_size,
> > > -                                          ssize_t expected_elem_size,
> > > -                                          bool *replaced)
> > > +                                   struct drm_property_blob **blob,
> > > +                                   uint64_t blob_id,
> > > +                                   ssize_t expected_size,
> > > +                                   ssize_t expected_elem_size,
> > > +                                   bool *replaced)
> > >  {
> > >     struct drm_property_blob *new_blob = NULL;
> > >
> > > @@ -1482,6 +1484,10 @@ dm_plane_attach_color_mgmt_properties(struct amdgpu_display_manager *dm,
> > >                                        dm->adev->mode_info.plane_degamma_tf_property,
> > >                                        DRM_TRANSFER_FUNCTION_DEFAULT);
> > >     }
> > > +   /* HDR MULT is always available */
> > > +   drm_object_attach_property(&plane->base,
> > > +                              dm->adev->mode_info.plane_hdr_mult_property,
> > > +                              AMDGPU_HDR_MULT_DEFAULT);
> > >  }
> > >
> > >  static int
> > > @@ -1507,6 +1513,11 @@ dm_atomic_plane_set_property(struct drm_plane *plane,
> > >                     dm_plane_state->degamma_tf = val;
> > >                     dm_plane_state->base.color_mgmt_changed = 1;
> > >             }
> > > +   } else if (property == adev->mode_info.plane_hdr_mult_property) {
> > > +           if (dm_plane_state->hdr_mult != val) {
> > > +                   dm_plane_state->hdr_mult = val;
> > > +                   dm_plane_state->base.color_mgmt_changed = 1;
> > > +           }
> > >     } else {
> > >             drm_dbg_atomic(plane->dev,
> > >                            "[PLANE:%d:%s] unknown property [PROP:%d:%s]]\n",
> > > @@ -1533,6 +1544,8 @@ dm_atomic_plane_get_property(struct drm_plane *plane,
> > >                     dm_plane_state->degamma_lut->base.id : 0;
> > >     } else if (property == adev->mode_info.plane_degamma_tf_property) {
> > >             *val = dm_plane_state->degamma_tf;
> > > +   } else if (property == adev->mode_info.plane_hdr_mult_property) {
> > > +           *val = dm_plane_state->hdr_mult;
> > >     } else {
> > >             return -EINVAL;
> > >     }
> >
> >
