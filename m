Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05686FCBDC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjEIQzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjEIQzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:55:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3633468B
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 09:55:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc4b88998so11102548a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 09:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=froggi.es; s=google; t=1683651311; x=1686243311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/1g+4eMUQS3INOkiL8CDyfH4191so1Mx1t/kOZzJ0Cw=;
        b=lgtQKezsYB4waisH0QZciPOfqE5mm1JIdkM65P/LRHL7KK+jV0B28eQ1GM491bwY0U
         sbSf6Fc1PPKCV8V7rSuxn7ePPfqxdV5Xp9ysklyf88hS1U7K1i4o5a/ZJwlLdKoauaFe
         wgpciblujFF4g3QfP4C5DQ+OrzSnU8EZJHWBY4Hykdz1MY3e6hdlu/ksmJQaXqq0ecB9
         XArNDqRuDKhbjzXM3hEEFUVh2LdBUBUTumdmyxNiXiH+LOXhH6hWJa3eFBfru5cemSoS
         bGoAY0+c/OMbpF8Y42Ft/470gxmp2m3n2U+WuFSS3NzikWavdEBNfOTSqnWjFIrRuwl5
         GWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683651311; x=1686243311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1g+4eMUQS3INOkiL8CDyfH4191so1Mx1t/kOZzJ0Cw=;
        b=a4QAwWj/LD+7jP/MZb3GvissZPlUV9Ru/AzJjiydVQltxpppYd5GzKexVsLB2RRdar
         rrNspqqPt4iZuGwPDBzlB1nunMwzoTUbIFp4LpsBAy0DRJzV3k0NOPxitL9QY21F1Gkv
         +J+rxoHJ1oGZ5g48Pfc7O8rXr4pii1neBh5gQEp8bgGhkhYVI6oGsyDpV222sjU8oW/J
         KGU882G6T7Q3Xu2YyI/JV+UD+7iuvhsgWnLD4sS1Ri06mZwNt4xeho1/8QsRnpF+mK/q
         nM3Abq3M/+kzG1nKsXUEuU2NTQW1pbZ9LE5QU0LVFWRLIydu3rkzmQ5KDZp+3VmguqP0
         mwlA==
X-Gm-Message-State: AC+VfDze1Neplcw8A1sj+v65cmo4kmgHkG645XUcESArauDS3w885/Iw
        8Q5LxPcb+aVyT97neEb9gfeGl8vNtrkK0zH97NlgWg==
X-Google-Smtp-Source: ACHHUZ7paBE6N4Q5f6TQXvVn0Diuxuea8iJybvFJ7x/r83fo7pmdfTW8eYJ5SNLBPnlfMwbt5Caiv9JutOQTBSK6QPM=
X-Received: by 2002:aa7:ce18:0:b0:50b:febd:3cde with SMTP id
 d24-20020aa7ce18000000b0050bfebd3cdemr10041515edv.42.1683651310933; Tue, 09
 May 2023 09:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230423141051.702990-1-mwen@igalia.com> <20230423141051.702990-8-mwen@igalia.com>
 <e931004a-e8e3-5c27-cee7-ec3bba23fb3e@amd.com> <20230509163434.6xk5geyabfjydie5@mail.igalia.com>
In-Reply-To: <20230509163434.6xk5geyabfjydie5@mail.igalia.com>
From:   Joshua Ashton <joshua@froggi.es>
Date:   Tue, 9 May 2023 16:55:00 +0000
Message-ID: <CAEZNXZCbbq80DEeqL-+6kXHQmnuqWR7RjyW5qJbvQo1TKrZFpA@mail.gmail.com>
Subject: Re: [RFC PATCH 07/40] drm/amd/display: add CRTC gamma TF to
 driver-private props
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

I am okay with us dropping the shaper + 3D LUT from crtc. It has
problems anyway wrt. atomicity.

On Tue, 9 May 2023 at 16:34, Melissa Wen <mwen@igalia.com> wrote:
>
> On 05/08, Harry Wentland wrote:
> >
> >
> > On 4/23/23 10:10, Melissa Wen wrote:
> > > From: Joshua Ashton <joshua@froggi.es>
> > >
> > > Add predefined transfer function property to DRM CRTC gamma to convert
> > > to wire encoding with or without gamma LUT.
> > >
> >
> > Are all these new CRTC properties used by gamescope? I would be reluctant
> > to merge them if they're currently not needed.
>
> The regamma TF yes. The shaper and 3D LUT not yet.
>
> I'll double check with Joshie and drop from the series what we don't
> have a short-term perspective of usage.
>
> >
> > > Co-developed-by: Melissa Wen <mwen@igalia.com>
> > > Signed-off-by: Melissa Wen <mwen@igalia.com>
> > > Signed-off-by: Joshua Ashton <joshua@froggi.es>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 22 ++++++++++++++++++
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  4 ++++
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 23 +++++++++++++++++++
> > >  .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 13 +++++++++++
> > >  4 files changed, 62 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > > index 2abe5fe87c10..1913903cab88 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > > @@ -1248,6 +1248,19 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
> > >  }
> > >
> > >  #ifdef CONFIG_STEAM_DECK
> > > +static const struct drm_prop_enum_list drm_transfer_function_enum_list[] = {
> > > +   { DRM_TRANSFER_FUNCTION_DEFAULT, "Default" },
> > > +   { DRM_TRANSFER_FUNCTION_SRGB, "sRGB" },
> > > +   { DRM_TRANSFER_FUNCTION_BT709, "BT.709" },
> > > +   { DRM_TRANSFER_FUNCTION_PQ, "PQ (Perceptual Quantizer)" },
> > > +   { DRM_TRANSFER_FUNCTION_LINEAR, "Linear" },
> > > +   { DRM_TRANSFER_FUNCTION_UNITY, "Unity" },
> > > +   { DRM_TRANSFER_FUNCTION_HLG, "HLG (Hybrid Log Gamma)" },
> > > +   { DRM_TRANSFER_FUNCTION_GAMMA22, "Gamma 2.2" },
> > > +   { DRM_TRANSFER_FUNCTION_GAMMA24, "Gamma 2.4" },
> > > +   { DRM_TRANSFER_FUNCTION_GAMMA26, "Gamma 2.6" },
> > > +};
> > > +
> >
> > Would it be better to prefix things with AMD_/amd_ to avoid confusion? On the other
> > hand, these will likely just move into DRM core once we get the generic color uAPI.
> >
> > Harry
> >
> > >  static int
> > >  amdgpu_display_create_color_properties(struct amdgpu_device *adev)
> > >  {
> > > @@ -1281,6 +1294,15 @@ amdgpu_display_create_color_properties(struct amdgpu_device *adev)
> > >             return -ENOMEM;
> > >     adev->mode_info.lut3d_size_property = prop;
> > >
> > > +   prop = drm_property_create_enum(adev_to_drm(adev),
> > > +                                   DRM_MODE_PROP_ENUM,
> > > +                                   "GAMMA_TF",
> > > +                                   drm_transfer_function_enum_list,
> > > +                                   ARRAY_SIZE(drm_transfer_function_enum_list));
> > > +   if (!prop)
> > > +           return -ENOMEM;
> > > +   adev->mode_info.gamma_tf_property = prop;
> > > +
> > >     return 0;
> > >  }
> > >  #endif
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> > > index 205fa4f5bea7..76337e18c728 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> > > @@ -368,6 +368,10 @@ struct amdgpu_mode_info {
> > >      * LUT as supported by the driver (read-only).
> > >      */
> > >     struct drm_property *lut3d_size_property;
> > > +   /**
> > > +    * @gamma_tf_property: Transfer function for CRTC regamma.
> > > +    */
> > > +   struct drm_property *gamma_tf_property;
> > >  #endif
> > >  };
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> > > index 09c3e1858b56..1e90a2dd445e 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> > > @@ -699,6 +699,23 @@ static inline void amdgpu_dm_set_mst_status(uint8_t *status,
> > >
> > >  extern const struct amdgpu_ip_block_version dm_ip_block;
> > >
> > > +#ifdef CONFIG_STEAM_DECK
> > > +enum drm_transfer_function {
> > > +   DRM_TRANSFER_FUNCTION_DEFAULT,
> > > +
> > > +   DRM_TRANSFER_FUNCTION_SRGB,
> > > +   DRM_TRANSFER_FUNCTION_BT709,
> > > +   DRM_TRANSFER_FUNCTION_PQ,
> > > +   DRM_TRANSFER_FUNCTION_LINEAR,
> > > +   DRM_TRANSFER_FUNCTION_UNITY,
> > > +   DRM_TRANSFER_FUNCTION_HLG,
> > > +   DRM_TRANSFER_FUNCTION_GAMMA22,
> > > +   DRM_TRANSFER_FUNCTION_GAMMA24,
> > > +   DRM_TRANSFER_FUNCTION_GAMMA26,
> > > +   DRM_TRANSFER_FUNCTION_MAX,
> > > +};
> > > +#endif
> > > +
> > >  struct dm_plane_state {
> > >     struct drm_plane_state base;
> > >     struct dc_plane_state *dc_state;
> > > @@ -751,6 +768,12 @@ struct dm_crtc_state {
> > >      * &struct drm_color_lut.
> > >      */
> > >     struct drm_property_blob *lut3d;
> > > +        /**
> > > +    * @gamma_tf:
> > > +    *
> > > +    * Pre-defined transfer function for converting internal FB -> wire encoding.
> > > +    */
> > > +   enum drm_transfer_function gamma_tf;
> > >  #endif
> > >  };
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > > index 0e1280228e6e..79324fbab1f1 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > > @@ -272,6 +272,7 @@ static struct drm_crtc_state *dm_crtc_duplicate_state(struct drm_crtc *crtc)
> > >  #ifdef CONFIG_STEAM_DECK
> > >     state->shaper_lut = cur->shaper_lut;
> > >     state->lut3d = cur->lut3d;
> > > +   state->gamma_tf = cur->gamma_tf;
> > >
> > >     if (state->shaper_lut)
> > >             drm_property_blob_get(state->shaper_lut);
> > > @@ -336,6 +337,11 @@ dm_crtc_additional_color_mgmt(struct drm_crtc *crtc)
> > >                                        adev->mode_info.lut3d_size_property,
> > >                                        MAX_COLOR_3DLUT_ENTRIES);
> > >     }
> > > +
> > > +   if(adev->dm.dc->caps.color.mpc.ogam_ram)
> > > +           drm_object_attach_property(&crtc->base,
> > > +                                      adev->mode_info.gamma_tf_property,
> > > +                                      DRM_TRANSFER_FUNCTION_DEFAULT);
> > >  }
> > >
> > >  static int
> > > @@ -398,6 +404,11 @@ amdgpu_dm_atomic_crtc_set_property(struct drm_crtc *crtc,
> > >                                     &replaced);
> > >             acrtc_state->base.color_mgmt_changed |= replaced;
> > >             return ret;
> > > +   } else if (property == adev->mode_info.gamma_tf_property) {
> > > +           if (acrtc_state->gamma_tf != val) {
> > > +                   acrtc_state->gamma_tf = val;
> > > +                   acrtc_state->base.color_mgmt_changed |= 1;
> > > +           }
> > >     } else {
> > >             drm_dbg_atomic(crtc->dev,
> > >                            "[CRTC:%d:%s] unknown property [PROP:%d:%s]]\n",
> > > @@ -424,6 +435,8 @@ amdgpu_dm_atomic_crtc_get_property(struct drm_crtc *crtc,
> > >     else if (property == adev->mode_info.lut3d_property)
> > >             *val = (acrtc_state->lut3d) ?
> > >                     acrtc_state->lut3d->base.id : 0;
> > > +   else if (property == adev->mode_info.gamma_tf_property)
> > > +           *val = acrtc_state->gamma_tf;
> > >     else
> > >             return -EINVAL;
> > >
> >
> >
