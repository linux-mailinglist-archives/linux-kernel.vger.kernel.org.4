Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC286AE7F5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjCGRKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjCGRJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:09:38 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31AD94397;
        Tue,  7 Mar 2023 09:04:30 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-176d93cd0daso6347761fac.4;
        Tue, 07 Mar 2023 09:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678208620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NdV+EIKQxSDfQkTVA63x343wU63G4KYaV0wPPzqV5/s=;
        b=Qq1SnZqYDYlz32YF5cGBN0zRyMORfuj70c5lZbdOxlSbUiqCrz/OL/WZ61RdSs5x4u
         dSlUqnDUmC3OfsgBzBcjVkJYKmO1WoG42sOuWNopYco/gqy6xxZRB+SKsgB9tTANXzJj
         gFAhiG1thN+NJw0wpqJbv7hlsq9uYOLvzNZonlt18ZDGzqA9oC+Uz8nI6pfj5HRRG853
         d6GH6ehaZgNjxW0DXR3OmTEmCbP3ZBOe2T0+RyV2HJsiZy4emhjEefVBy1RuvslUkkiS
         UVQ2x1oTzbg+x6NXUjk0Nkj1TKqEHP6ItfMkbsgwPqxWWNC0EL/mc8DsYilZoYw68qsU
         upYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678208620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NdV+EIKQxSDfQkTVA63x343wU63G4KYaV0wPPzqV5/s=;
        b=2q3TP7zErOB7/LjzCo6nUBrA9ZaK1+GfRXDMMORW3pi5eA+iG2IzsId7RXZY2EOFwz
         vzXFACmIaCuUrfsUr3K3D4cKlVd1wKcYZRsq3wDNnS7Bt2PiQLGrpI/K8GFEHrTCVNph
         +YXaxbPrVdPHrmpx3EA9eIa9tR3d667p9si7DNCXCujn2O3fmj+6xWvxv7C7nwWLbXO7
         r5RHLebhuxVUfFOpMZWeCRs7S+lZHjEKH3iFVVtt6wTbkGEeN/EXIdD6nNJsC7cAEBBV
         +XGnWMhnRDAYTw61gOtaj+k4qxk9hWcJgSIzFug6hNZokfQu5y5+KdcTK3nwyK8QfXZW
         5/Zw==
X-Gm-Message-State: AO0yUKUd+66611vLJfIhIBbfuWzrSzLdouwj2oy21K+24tczeX96J5PB
        xgXha0atiL5wTkcFay1jSPt15GyAzfNVgvLGw8FGEfpp
X-Google-Smtp-Source: AK7set8e4ffmspjqbs62Heo6QeGYD8SGZ/8HGEUTTT6k0/ZgoiL4JJ/0EmN4Vjlr+r18Sym9+ekVD4YHYA7rghycyeg=
X-Received: by 2002:a05:6871:6a81:b0:176:3e60:3269 with SMTP id
 zf1-20020a0568716a8100b001763e603269mr5192990oab.8.1678208619654; Tue, 07 Mar
 2023 09:03:39 -0800 (PST)
MIME-Version: 1.0
References: <20230306022427.437022-1-davidbtadokoro@gmail.com>
In-Reply-To: <20230306022427.437022-1-davidbtadokoro@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 7 Mar 2023 12:03:27 -0500
Message-ID: <CADnq5_OYT576v7ynfxiYE9xj2jQa58vVfyvpFS9k3saoGHMAuw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: add prefix to amdgpu_dm_plane.h functions
To:     David Tadokoro <davidbtadokoro@gmail.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, corbet@lwn.net, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        linux-kernel@vger.kernel.org,
        David Tadokoro <davidbtadokoro@usp.br>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 3:23 AM David Tadokoro <davidbtadokoro@gmail.com> wrote:
>
> From: David Tadokoro <davidbtadokoro@usp.br>
>
> The amdgpu_dm_plane.h functions didn't have names that indicated where
> they were declared.
>
> To better filter results in debug tools like ftrace, prefix these
> functions with 'amdgpu_dm_plane_'.
>
> Note that we may want to make this same change in other files like
> amdgpu_dm_crtc.h.
>
> Signed-off-by: David Tadokoro <davidbtadokoro@usp.br>

Applied.  Thanks!

Alex

> ---
>  .../gpu/amdgpu/display/display-manager.rst    |  2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++-------
>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 20 +++++++++----------
>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   | 12 +++++------
>  4 files changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/gpu/amdgpu/display/display-manager.rst b/Documentation/gpu/amdgpu/display/display-manager.rst
> index b7abb18cfc82..be2651ecdd7f 100644
> --- a/Documentation/gpu/amdgpu/display/display-manager.rst
> +++ b/Documentation/gpu/amdgpu/display/display-manager.rst
> @@ -173,7 +173,7 @@ The alpha blending equation is configured from DRM to DC interface by the
>  following path:
>
>  1. When updating a :c:type:`drm_plane_state <drm_plane_state>`, DM calls
> -   :c:type:`fill_blending_from_plane_state()` that maps
> +   :c:type:`amdgpu_dm_plane_fill_blending_from_plane_state()` that maps
>     :c:type:`drm_plane_state <drm_plane_state>` attributes to
>     :c:type:`dc_plane_info <dc_plane_info>` struct to be handled in the
>     OS-agnostic component (DC).
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 4217ebe6391b..f7111acd45cc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2923,7 +2923,7 @@ const struct amdgpu_ip_block_version dm_ip_block =
>
>  static const struct drm_mode_config_funcs amdgpu_dm_mode_funcs = {
>         .fb_create = amdgpu_display_user_framebuffer_create,
> -       .get_format_info = amd_get_format_info,
> +       .get_format_info = amdgpu_dm_plane_get_format_info,
>         .output_poll_changed = drm_fb_helper_output_poll_changed,
>         .atomic_check = amdgpu_dm_atomic_check,
>         .atomic_commit = drm_atomic_helper_commit,
> @@ -4948,7 +4948,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
>         if (ret)
>                 return ret;
>
> -       ret = fill_plane_buffer_attributes(adev, afb, plane_info->format,
> +       ret = amdgpu_dm_plane_fill_plane_buffer_attributes(adev, afb, plane_info->format,
>                                            plane_info->rotation, tiling_flags,
>                                            &plane_info->tiling_info,
>                                            &plane_info->plane_size,
> @@ -4957,7 +4957,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
>         if (ret)
>                 return ret;
>
> -       fill_blending_from_plane_state(
> +       amdgpu_dm_plane_fill_blending_from_plane_state(
>                 plane_state, &plane_info->per_pixel_alpha, &plane_info->pre_multiplied_alpha,
>                 &plane_info->global_alpha, &plane_info->global_alpha_value);
>
> @@ -4976,7 +4976,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
>         int ret;
>         bool force_disable_dcc = false;
>
> -       ret = fill_dc_scaling_info(adev, plane_state, &scaling_info);
> +       ret = amdgpu_dm_plane_fill_dc_scaling_info(adev, plane_state, &scaling_info);
>         if (ret)
>                 return ret;
>
> @@ -7882,7 +7882,7 @@ static void amdgpu_dm_commit_cursors(struct drm_atomic_state *state)
>          */
>         for_each_old_plane_in_state(state, plane, old_plane_state, i)
>                 if (plane->type == DRM_PLANE_TYPE_CURSOR)
> -                       handle_cursor_update(plane, old_plane_state);
> +                       amdgpu_dm_plane_handle_cursor_update(plane, old_plane_state);
>  }
>
>  static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
> @@ -7967,7 +7967,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>                         bundle->surface_updates[planes_count].gamut_remap_matrix = &dc_plane->gamut_remap_matrix;
>                 }
>
> -               fill_dc_scaling_info(dm->adev, new_plane_state,
> +               amdgpu_dm_plane_fill_dc_scaling_info(dm->adev, new_plane_state,
>                                      &bundle->scaling_infos[planes_count]);
>
>                 bundle->surface_updates[planes_count].scaling_info =
> @@ -9634,7 +9634,7 @@ static int dm_update_plane_state(struct dc *dc,
>                 if (!needs_reset)
>                         return 0;
>
> -               ret = dm_plane_helper_check_state(new_plane_state, new_crtc_state);
> +               ret = amdgpu_dm_plane_helper_check_state(new_plane_state, new_crtc_state);
>                 if (ret)
>                         return ret;
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 28fb1f02591a..dc23c788cdba 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -90,12 +90,12 @@ enum dm_micro_swizzle {
>         MICRO_SWIZZLE_R = 3
>  };
>
> -const struct drm_format_info *amd_get_format_info(const struct drm_mode_fb_cmd2 *cmd)
> +const struct drm_format_info *amdgpu_dm_plane_get_format_info(const struct drm_mode_fb_cmd2 *cmd)
>  {
>         return amdgpu_lookup_format_info(cmd->pixel_format, cmd->modifier[0]);
>  }
>
> -void fill_blending_from_plane_state(const struct drm_plane_state *plane_state,
> +void amdgpu_dm_plane_fill_blending_from_plane_state(const struct drm_plane_state *plane_state,
>                                bool *per_pixel_alpha, bool *pre_multiplied_alpha,
>                                bool *global_alpha, int *global_alpha_value)
>  {
> @@ -759,7 +759,7 @@ static int attach_color_mgmt_properties(struct amdgpu_display_manager *dm, struc
>  }
>  #endif
>
> -int fill_plane_buffer_attributes(struct amdgpu_device *adev,
> +int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
>                              const struct amdgpu_framebuffer *afb,
>                              const enum surface_pixel_format format,
>                              const enum dc_rotation_angle rotation,
> @@ -918,7 +918,7 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
>                         dm_plane_state_new->dc_state;
>                 bool force_disable_dcc = !plane_state->dcc.enable;
>
> -               fill_plane_buffer_attributes(
> +               amdgpu_dm_plane_fill_plane_buffer_attributes(
>                         adev, afb, plane_state->format, plane_state->rotation,
>                         afb->tiling_flags,
>                         &plane_state->tiling_info, &plane_state->plane_size,
> @@ -999,7 +999,7 @@ static void get_min_max_dc_plane_scaling(struct drm_device *dev,
>                 *min_downscale = 1000;
>  }
>
> -int dm_plane_helper_check_state(struct drm_plane_state *state,
> +int amdgpu_dm_plane_helper_check_state(struct drm_plane_state *state,
>                                        struct drm_crtc_state *new_crtc_state)
>  {
>         struct drm_framebuffer *fb = state->fb;
> @@ -1053,7 +1053,7 @@ int dm_plane_helper_check_state(struct drm_plane_state *state,
>                 state, new_crtc_state, min_scale, max_scale, true, true);
>  }
>
> -int fill_dc_scaling_info(struct amdgpu_device *adev,
> +int amdgpu_dm_plane_fill_dc_scaling_info(struct amdgpu_device *adev,
>                                 const struct drm_plane_state *state,
>                                 struct dc_scaling_info *scaling_info)
>  {
> @@ -1161,11 +1161,11 @@ static int dm_plane_atomic_check(struct drm_plane *plane,
>         if (!new_crtc_state)
>                 return -EINVAL;
>
> -       ret = dm_plane_helper_check_state(new_plane_state, new_crtc_state);
> +       ret = amdgpu_dm_plane_helper_check_state(new_plane_state, new_crtc_state);
>         if (ret)
>                 return ret;
>
> -       ret = fill_dc_scaling_info(adev, new_plane_state, &scaling_info);
> +       ret = amdgpu_dm_plane_fill_dc_scaling_info(adev, new_plane_state, &scaling_info);
>         if (ret)
>                 return ret;
>
> @@ -1229,7 +1229,7 @@ static int get_cursor_position(struct drm_plane *plane, struct drm_crtc *crtc,
>         return 0;
>  }
>
> -void handle_cursor_update(struct drm_plane *plane,
> +void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
>                                  struct drm_plane_state *old_plane_state)
>  {
>         struct amdgpu_device *adev = drm_to_adev(plane->dev);
> @@ -1314,7 +1314,7 @@ static void dm_plane_atomic_async_update(struct drm_plane *plane,
>         plane->state->crtc_w = new_state->crtc_w;
>         plane->state->crtc_h = new_state->crtc_h;
>
> -       handle_cursor_update(plane, old_state);
> +       amdgpu_dm_plane_handle_cursor_update(plane, old_state);
>  }
>
>  static const struct drm_plane_helper_funcs dm_plane_helper_funcs = {
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> index a4bee8528a51..930f1572f898 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> @@ -29,17 +29,17 @@
>
>  #include "dc.h"
>
> -void handle_cursor_update(struct drm_plane *plane,
> +void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
>                           struct drm_plane_state *old_plane_state);
>
> -int fill_dc_scaling_info(struct amdgpu_device *adev,
> +int amdgpu_dm_plane_fill_dc_scaling_info(struct amdgpu_device *adev,
>                          const struct drm_plane_state *state,
>                          struct dc_scaling_info *scaling_info);
>
> -int dm_plane_helper_check_state(struct drm_plane_state *state,
> +int amdgpu_dm_plane_helper_check_state(struct drm_plane_state *state,
>                                 struct drm_crtc_state *new_crtc_state);
>
> -int fill_plane_buffer_attributes(struct amdgpu_device *adev,
> +int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
>                                  const struct amdgpu_framebuffer *afb,
>                                  const enum surface_pixel_format format,
>                                  const enum dc_rotation_angle rotation,
> @@ -56,9 +56,9 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>                          unsigned long possible_crtcs,
>                          const struct dc_plane_cap *plane_cap);
>
> -const struct drm_format_info *amd_get_format_info(const struct drm_mode_fb_cmd2 *cmd);
> +const struct drm_format_info *amdgpu_dm_plane_get_format_info(const struct drm_mode_fb_cmd2 *cmd);
>
> -void fill_blending_from_plane_state(const struct drm_plane_state *plane_state,
> +void amdgpu_dm_plane_fill_blending_from_plane_state(const struct drm_plane_state *plane_state,
>                                     bool *per_pixel_alpha, bool *pre_multiplied_alpha,
>                                     bool *global_alpha, int *global_alpha_value);
>
> --
> 2.39.2
>
