Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E34D6B0BD7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjCHOvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjCHOun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:50:43 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFB12D6C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:49:39 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id bj30so12346829oib.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 06:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678286977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uLhu4VDWuhDITR7pDIdvDs914qCYY0KVPjuW2/ZUXaw=;
        b=AU0aXB+AM5HnP3sF8EM6IXmyr4wdn5tiWx0/ihZQcIJDZlXqyJ3hfB9VtqKsQQttUY
         9ftx+/ceDf1W1wO525RR7jxhpvVDpQYQNqkx0dYljAPocuSijswq/eGzDKg6Gdakz6uE
         dnBETnlwhc0qhWGvt/bfWmrZLf15d1C9uw+2XaQ7ZOtXmhd0OEWdY3tsWi0/FPg0EFpk
         30m3DtYBg9BqUkNbGvcIBRw31NjjDzukG+wJHwqHbHSnIPS+OLEZGmH9hMVIR3hkEfrg
         Ux6P99nnP0oyJ+apfAeO1wLcRA6GUubP7XiBCX6WowcMDmU/UtehsVJBGso7oCZzK04w
         W2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678286977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLhu4VDWuhDITR7pDIdvDs914qCYY0KVPjuW2/ZUXaw=;
        b=ubeCChBF/vv1eECqUbrUmFroo4L6UI27uK5izkhBVxPg7dG7DYkBNZnoBRlIya03qa
         5gLL7PwV1OfoBbq9Fzu/pLPXQcgqdUA5z6ekEnX8P/uHWLUqP2buzqqu9qBlvpP+/mgn
         zplrsJJFygCmfqZgkiy21butlr4Y8l2pu/1hV6ZIm/AV0wr8BwUHmr/Ut/6dZOjcQPqn
         mEDUDPSNwrQx2HHcbZtrxIT46PUeoYb5L7MzaonMKEHnlOxcbda2bIMFigWJj8+TYQEn
         KpeuB39B5bnW9VUQef/iYtGHxj7M66znP6Rpzb2GGbmcy6Gr1lsnseMK+3WkFY3xDEVf
         tCxA==
X-Gm-Message-State: AO0yUKXu3giaDENBU7SORiNLGHThKvxPgnm85oP9yEu+b1LgmTNzFFOA
        98+dD/YuVh6clPV/0/WtUN418lvTiSF9DRNftPo=
X-Google-Smtp-Source: AK7set+rhJlBDUbFW5lHZoXx6RKpyVs1+kmeF2SApU1AHsllLbyN7vcfsvwIhkiKsw+XpSnFKr54dyL2AHdkaE53lQM=
X-Received: by 2002:a05:6808:8f7:b0:36e:f6f5:5cf0 with SMTP id
 d23-20020a05680808f700b0036ef6f55cf0mr5445514oic.3.1678286977514; Wed, 08 Mar
 2023 06:49:37 -0800 (PST)
MIME-Version: 1.0
References: <20230307191417.150823-1-davidbtadokoro@usp.br>
In-Reply-To: <20230307191417.150823-1-davidbtadokoro@usp.br>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 8 Mar 2023 09:49:25 -0500
Message-ID: <CADnq5_NU0SzNg9ogx_ebCk_wpaBoz_ZXW+h7UK6JnmZ-DspqXA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: add prefix to amdgpu_dm_crtc.h functions
To:     David Tadokoro <davidbtadokoro@usp.br>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied.  Thanks!

On Tue, Mar 7, 2023 at 2:34 PM David Tadokoro <davidbtadokoro@usp.br> wrote:
>
> Some amdgpu_dm_crtc.h functions didn't have names that indicated where
> they were declared.
>
> To better filter results in debug tools like ftrace, prefix these
> functions with 'amdgpu_dm_crtc_'.
>
> Signed-off-by: David Tadokoro <davidbtadokoro@usp.br>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 +++++++++----------
>  .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 26 +++++++--------
>  .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    | 14 ++++----
>  3 files changed, 36 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b472931cb7ca..b3e874589617 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -342,7 +342,7 @@ static inline bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
>  {
>         if (new_state->freesync_config.state ==  VRR_STATE_ACTIVE_FIXED)
>                 return true;
> -       else if (amdgpu_dm_vrr_active(old_state) != amdgpu_dm_vrr_active(new_state))
> +       else if (amdgpu_dm_crtc_vrr_active(old_state) != amdgpu_dm_crtc_vrr_active(new_state))
>                 return true;
>         else
>                 return false;
> @@ -436,7 +436,7 @@ static void dm_pflip_high_irq(void *interrupt_params)
>
>         WARN_ON(!e);
>
> -       vrr_active = amdgpu_dm_vrr_active_irq(amdgpu_crtc);
> +       vrr_active = amdgpu_dm_crtc_vrr_active_irq(amdgpu_crtc);
>
>         /* Fixed refresh rate, or VRR scanout position outside front-porch? */
>         if (!vrr_active ||
> @@ -510,7 +510,7 @@ static void dm_vupdate_high_irq(void *interrupt_params)
>         acrtc = get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VUPDATE);
>
>         if (acrtc) {
> -               vrr_active = amdgpu_dm_vrr_active_irq(acrtc);
> +               vrr_active = amdgpu_dm_crtc_vrr_active_irq(acrtc);
>                 drm_dev = acrtc->base.dev;
>                 vblank = &drm_dev->vblank[acrtc->base.index];
>                 previous_timestamp = atomic64_read(&irq_params->previous_timestamp);
> @@ -534,7 +534,7 @@ static void dm_vupdate_high_irq(void *interrupt_params)
>                  * if a pageflip happened inside front-porch.
>                  */
>                 if (vrr_active) {
> -                       dm_crtc_handle_vblank(acrtc);
> +                       amdgpu_dm_crtc_handle_vblank(acrtc);
>
>                         /* BTR processing for pre-DCE12 ASICs */
>                         if (acrtc->dm_irq_params.stream &&
> @@ -574,7 +574,7 @@ static void dm_crtc_high_irq(void *interrupt_params)
>         if (!acrtc)
>                 return;
>
> -       vrr_active = amdgpu_dm_vrr_active_irq(acrtc);
> +       vrr_active = amdgpu_dm_crtc_vrr_active_irq(acrtc);
>
>         DC_LOG_VBLANK("crtc:%d, vupdate-vrr:%d, planes:%d\n", acrtc->crtc_id,
>                       vrr_active, acrtc->dm_irq_params.active_planes);
> @@ -586,7 +586,7 @@ static void dm_crtc_high_irq(void *interrupt_params)
>          * to dm_vupdate_high_irq after end of front-porch.
>          */
>         if (!vrr_active)
> -               dm_crtc_handle_vblank(acrtc);
> +               amdgpu_dm_crtc_handle_vblank(acrtc);
>
>         /**
>          * Following stuff must happen at start of vblank, for crc
> @@ -2483,11 +2483,11 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
>                                          enable ? "enable" : "disable");
>
>                         if (enable) {
> -                               rc = dm_enable_vblank(&acrtc->base);
> +                               rc = amdgpu_dm_crtc_enable_vblank(&acrtc->base);
>                                 if (rc)
>                                         DRM_WARN("Failed to enable vblank interrupts\n");
>                         } else {
> -                               dm_disable_vblank(&acrtc->base);
> +                               amdgpu_dm_crtc_disable_vblank(&acrtc->base);
>                         }
>
>                 }
> @@ -7746,7 +7746,7 @@ static void update_freesync_state_on_stream(
>                         &vrr_params);
>
>                 if (adev->family < AMDGPU_FAMILY_AI &&
> -                   amdgpu_dm_vrr_active(new_crtc_state)) {
> +                   amdgpu_dm_crtc_vrr_active(new_crtc_state)) {
>                         mod_freesync_handle_v_update(dm->freesync_module,
>                                                      new_stream, &vrr_params);
>
> @@ -7864,8 +7864,8 @@ static void update_stream_irq_parameters(
>  static void amdgpu_dm_handle_vrr_transition(struct dm_crtc_state *old_state,
>                                             struct dm_crtc_state *new_state)
>  {
> -       bool old_vrr_active = amdgpu_dm_vrr_active(old_state);
> -       bool new_vrr_active = amdgpu_dm_vrr_active(new_state);
> +       bool old_vrr_active = amdgpu_dm_crtc_vrr_active(old_state);
> +       bool new_vrr_active = amdgpu_dm_crtc_vrr_active(new_state);
>
>         if (!old_vrr_active && new_vrr_active) {
>                 /* Transition VRR inactive -> active:
> @@ -7876,7 +7876,7 @@ static void amdgpu_dm_handle_vrr_transition(struct dm_crtc_state *old_state,
>                  * We also need vupdate irq for the actual core vblank handling
>                  * at end of vblank.
>                  */
> -               WARN_ON(dm_set_vupdate_irq(new_state->base.crtc, true) != 0);
> +               WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, true) != 0);
>                 WARN_ON(drm_crtc_vblank_get(new_state->base.crtc) != 0);
>                 DRM_DEBUG_DRIVER("%s: crtc=%u VRR off->on: Get vblank ref\n",
>                                  __func__, new_state->base.crtc->base.id);
> @@ -7884,7 +7884,7 @@ static void amdgpu_dm_handle_vrr_transition(struct dm_crtc_state *old_state,
>                 /* Transition VRR active -> inactive:
>                  * Allow vblank irq disable again for fixed refresh rate.
>                  */
> -               WARN_ON(dm_set_vupdate_irq(new_state->base.crtc, false) != 0);
> +               WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, false) != 0);
>                 drm_crtc_vblank_put(new_state->base.crtc);
>                 DRM_DEBUG_DRIVER("%s: crtc=%u VRR on->off: Drop vblank ref\n",
>                                  __func__, new_state->base.crtc->base.id);
> @@ -7926,7 +7926,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>         int planes_count = 0, vpos, hpos;
>         unsigned long flags;
>         u32 target_vblank, last_flip_vblank;
> -       bool vrr_active = amdgpu_dm_vrr_active(acrtc_state);
> +       bool vrr_active = amdgpu_dm_crtc_vrr_active(acrtc_state);
>         bool cursor_update = false;
>         bool pflip_present = false;
>         bool dirty_rects_changed = false;
> @@ -8476,7 +8476,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>                  * aconnector as needed
>                  */
>
> -               if (modeset_required(new_crtc_state, dm_new_crtc_state->stream, dm_old_crtc_state->stream)) {
> +               if (amdgpu_dm_crtc_modeset_required(new_crtc_state, dm_new_crtc_state->stream, dm_old_crtc_state->stream)) {
>
>                         DRM_DEBUG_ATOMIC("Atomic commit: SET crtc id %d: [%p]\n", acrtc->crtc_id, acrtc);
>
> @@ -9301,7 +9301,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>                 if (modereset_required(new_crtc_state))
>                         goto skip_modeset;
>
> -               if (modeset_required(new_crtc_state, new_stream,
> +               if (amdgpu_dm_crtc_modeset_required(new_crtc_state, new_stream,
>                                      dm_old_crtc_state->stream)) {
>
>                         WARN_ON(dm_new_crtc_state->stream);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index dc4f37240beb..1d924dc51a3e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -34,7 +34,7 @@
>  #include "amdgpu_dm_trace.h"
>  #include "amdgpu_dm_debugfs.h"
>
> -void dm_crtc_handle_vblank(struct amdgpu_crtc *acrtc)
> +void amdgpu_dm_crtc_handle_vblank(struct amdgpu_crtc *acrtc)
>  {
>         struct drm_crtc *crtc = &acrtc->base;
>         struct drm_device *dev = crtc->dev;
> @@ -54,14 +54,14 @@ void dm_crtc_handle_vblank(struct amdgpu_crtc *acrtc)
>         spin_unlock_irqrestore(&dev->event_lock, flags);
>  }
>
> -bool modeset_required(struct drm_crtc_state *crtc_state,
> +bool amdgpu_dm_crtc_modeset_required(struct drm_crtc_state *crtc_state,
>                              struct dc_stream_state *new_stream,
>                              struct dc_stream_state *old_stream)
>  {
>         return crtc_state->active && drm_atomic_crtc_needs_modeset(crtc_state);
>  }
>
> -bool amdgpu_dm_vrr_active_irq(struct amdgpu_crtc *acrtc)
> +bool amdgpu_dm_crtc_vrr_active_irq(struct amdgpu_crtc *acrtc)
>
>  {
>         return acrtc->dm_irq_params.freesync_config.state ==
> @@ -70,7 +70,7 @@ bool amdgpu_dm_vrr_active_irq(struct amdgpu_crtc *acrtc)
>                        VRR_STATE_ACTIVE_FIXED;
>  }
>
> -int dm_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
> +int amdgpu_dm_crtc_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
>  {
>         enum dc_irq_source irq_source;
>         struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
> @@ -89,7 +89,7 @@ int dm_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
>         return rc;
>  }
>
> -bool amdgpu_dm_vrr_active(struct dm_crtc_state *dm_state)
> +bool amdgpu_dm_crtc_vrr_active(struct dm_crtc_state *dm_state)
>  {
>         return dm_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE ||
>                dm_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED;
> @@ -159,11 +159,11 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>
>         if (enable) {
>                 /* vblank irq on -> Only need vupdate irq in vrr mode */
> -               if (amdgpu_dm_vrr_active(acrtc_state))
> -                       rc = dm_set_vupdate_irq(crtc, true);
> +               if (amdgpu_dm_crtc_vrr_active(acrtc_state))
> +                       rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, true);
>         } else {
>                 /* vblank irq off -> vupdate irq off */
> -               rc = dm_set_vupdate_irq(crtc, false);
> +               rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, false);
>         }
>
>         if (rc)
> @@ -199,12 +199,12 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>         return 0;
>  }
>
> -int dm_enable_vblank(struct drm_crtc *crtc)
> +int amdgpu_dm_crtc_enable_vblank(struct drm_crtc *crtc)
>  {
>         return dm_set_vblank(crtc, true);
>  }
>
> -void dm_disable_vblank(struct drm_crtc *crtc)
> +void amdgpu_dm_crtc_disable_vblank(struct drm_crtc *crtc)
>  {
>         dm_set_vblank(crtc, false);
>  }
> @@ -300,8 +300,8 @@ static const struct drm_crtc_funcs amdgpu_dm_crtc_funcs = {
>         .verify_crc_source = amdgpu_dm_crtc_verify_crc_source,
>         .get_crc_sources = amdgpu_dm_crtc_get_crc_sources,
>         .get_vblank_counter = amdgpu_get_vblank_counter_kms,
> -       .enable_vblank = dm_enable_vblank,
> -       .disable_vblank = dm_disable_vblank,
> +       .enable_vblank = amdgpu_dm_crtc_enable_vblank,
> +       .disable_vblank = amdgpu_dm_crtc_disable_vblank,
>         .get_vblank_timestamp = drm_crtc_vblank_helper_get_vblank_timestamp,
>  #if defined(CONFIG_DEBUG_FS)
>         .late_register = amdgpu_dm_crtc_late_register,
> @@ -381,7 +381,7 @@ static int dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
>         dm_update_crtc_active_planes(crtc, crtc_state);
>
>         if (WARN_ON(unlikely(!dm_crtc_state->stream &&
> -                       modeset_required(crtc_state, NULL, dm_crtc_state->stream)))) {
> +                       amdgpu_dm_crtc_modeset_required(crtc_state, NULL, dm_crtc_state->stream)))) {
>                 return ret;
>         }
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
> index 1ac8692354cf..17e948753f59 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
> @@ -27,21 +27,21 @@
>  #ifndef __AMDGPU_DM_CRTC_H__
>  #define __AMDGPU_DM_CRTC_H__
>
> -void dm_crtc_handle_vblank(struct amdgpu_crtc *acrtc);
> +void amdgpu_dm_crtc_handle_vblank(struct amdgpu_crtc *acrtc);
>
> -bool modeset_required(struct drm_crtc_state *crtc_state,
> +bool amdgpu_dm_crtc_modeset_required(struct drm_crtc_state *crtc_state,
>                       struct dc_stream_state *new_stream,
>                       struct dc_stream_state *old_stream);
>
> -int dm_set_vupdate_irq(struct drm_crtc *crtc, bool enable);
> +int amdgpu_dm_crtc_set_vupdate_irq(struct drm_crtc *crtc, bool enable);
>
> -bool amdgpu_dm_vrr_active_irq(struct amdgpu_crtc *acrtc);
> +bool amdgpu_dm_crtc_vrr_active_irq(struct amdgpu_crtc *acrtc);
>
> -bool amdgpu_dm_vrr_active(struct dm_crtc_state *dm_state);
> +bool amdgpu_dm_crtc_vrr_active(struct dm_crtc_state *dm_state);
>
> -int dm_enable_vblank(struct drm_crtc *crtc);
> +int amdgpu_dm_crtc_enable_vblank(struct drm_crtc *crtc);
>
> -void dm_disable_vblank(struct drm_crtc *crtc);
> +void amdgpu_dm_crtc_disable_vblank(struct drm_crtc *crtc);
>
>  int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
>                         struct drm_plane *plane,
> --
> 2.39.2
>
