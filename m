Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6E9613A32
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiJaPgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiJaPg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:36:29 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B5A11805
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:36:21 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id p127so13122481oih.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NZ9svVcqEpoCn/DRJRtqGJnzFfLnvgvZgnnPVTMjw9w=;
        b=LppIxaq+KxX4U647wlKAZCyxF03zXuJNg1ni4I2k2e8rpayHjUK+wZ3YxWl7pUcOvk
         xBa8PBokMuuYaZ9DTovzP1y4UV4vLCS0vAUffMLEXZdMHCbrpkPjv0LrcsNEpO3cHpyH
         AGXvBWE7uM0TDg26hKlpAqEJBAitI77xH1AZWH7LY/OqIA7qwoQ4o+0mgiKpYvoyWFVh
         /SJKdO3bSfLJzt4gGGrXTLIfJg10qqe023mBgY2uA5I1bTHcOT4pak8bG6wM7dnUNqFw
         Q4iWYA4zrS4zdDGOCzMMlM+px0g8tgN6ge7Vw6d7+4VRPmKDkvRL0d2WFiZD9IoWG3ag
         I16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZ9svVcqEpoCn/DRJRtqGJnzFfLnvgvZgnnPVTMjw9w=;
        b=op73arBM8Qh1S8bvnIxpblI5pXYSYW5sAkDZKDtU3V9AsneEdoCbY11wKe9sfzORh9
         R94iNgw0mUVhNloXyBLDx+Ed0UTHvZr4WfCZD8tQh7kh8vTE6e2hQy9MHCTaOzRTVB0x
         DA+tbjVWCdA+RANMpsagCl5JpDc47QzOHRqsE5Fi7qhhT/xWdEuhl+BtLEY9GAoGrU4J
         behFKPRPE4bec/5vBaNtEXtSXmQoauJhaAnNCfWKo/wG0cL9vBylgJnJfLpOa0Ol/xbN
         TOLQtOpBESnX741Kwu5tUHRxILFcfy2AmGabpxVLblM9yAYdsQi5h2VHWzWvRytAHTPw
         5sSQ==
X-Gm-Message-State: ACrzQf1zyCIYrguAOfV66rZGX8Iz4MhzNP0SZAyy1E3bzvO6iDYFmAmE
        CYR0OFM2hxGura2oVZNp/VdZY/fhbK85RSzGdB9GFPdU
X-Google-Smtp-Source: AMsMyM7B0fndfG6nvizJp5E8j9Eh9Le4tnJvOWEdVadHUUjC2xmpwJzBNVXw9O/HZO/DkEoWrnPYXbaklDdIYB7rCT4=
X-Received: by 2002:a05:6808:998:b0:359:c7f3:1ef8 with SMTP id
 a24-20020a056808099800b00359c7f31ef8mr11258816oic.46.1667230580537; Mon, 31
 Oct 2022 08:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <Y117XNaSP6/8bH+3@moc6.cz>
In-Reply-To: <Y117XNaSP6/8bH+3@moc6.cz>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 31 Oct 2022 11:36:09 -0400
Message-ID: <CADnq5_Muegi+dvmrg5U=Cau_oeXQFjv_h2Pdn_j9AG0mRgE4=g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: add parameter backlight_min
To:     Filip Moc <dev@moc6.cz>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
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

On Sun, Oct 30, 2022 at 5:26 AM Filip Moc <dev@moc6.cz> wrote:
>
> There are some devices on which amdgpu won't allow user to set brightness
> to sufficiently low values even though the hardware would support it just
> fine.
>
> This usually happens in two cases when either configuration of brightness
> levels via ACPI/ATIF is not available and amdgpu falls back to defaults
> (currently 12 for minimum level) which may be too high for some devices or
> even the configuration via ATIF is available but the minimum brightness
> level provided by the manufacturer is set to unreasonably high value.
>
> In either case user can use this new module parameter to adjust the
> minimum allowed backlight brightness level.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203439
> Signed-off-by: Filip Moc <dev@moc6.cz>

Does your system require an override and if so, what is it?  It would
be good to add a quirk for your system as well so that other users of
the same system wouldn't need to manually figure out an apply the
settings.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h               |  3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           | 15 +++++++++++++++
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 +++++++++++++++
>  3 files changed, 33 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 0e6ddf05c23c..c5445402c49d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -200,6 +200,9 @@ extern uint amdgpu_dc_debug_mask;
>  extern uint amdgpu_dc_visual_confirm;
>  extern uint amdgpu_dm_abm_level;
>  extern int amdgpu_backlight;
> +#ifdef CONFIG_DRM_AMD_DC
> +extern int amdgpu_backlight_override_min[];
> +#endif
>  extern struct amdgpu_mgpu_info mgpu_info;
>  extern int amdgpu_ras_enable;
>  extern uint amdgpu_ras_mask;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 16f6a313335e..f2fb549ac52f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -43,6 +43,7 @@
>  #include "amdgpu_irq.h"
>  #include "amdgpu_dma_buf.h"
>  #include "amdgpu_sched.h"
> +#include "amdgpu_dm.h"
>  #include "amdgpu_fdinfo.h"
>  #include "amdgpu_amdkfd.h"
>
> @@ -853,6 +854,20 @@ int amdgpu_backlight = -1;
>  MODULE_PARM_DESC(backlight, "Backlight control (0 = pwm, 1 = aux, -1 auto (default))");
>  module_param_named(backlight, amdgpu_backlight, bint, 0444);
>
> +/**
> + * DOC: backlight_min (array of int)
> + * Override minimum allowed backlight brightness signal (per display).
> + * Must be less than the maximum brightness signal.
> + * Negative value means no override.
> + *
> + * Defaults to all -1 (no override on any display).
> + */
> +#ifdef CONFIG_DRM_AMD_DC
> +int amdgpu_backlight_override_min[AMDGPU_DM_MAX_NUM_EDP] = {[0 ... (AMDGPU_DM_MAX_NUM_EDP-1)] = -1};
> +MODULE_PARM_DESC(backlight_min, "Override minimum backlight brightness signal (0..max-1, -1 = no override (default))");
> +module_param_array_named(backlight_min, amdgpu_backlight_override_min, int, NULL, 0444);
> +#endif
> +
>  /**
>   * DOC: tmz (int)
>   * Trusted Memory Zone (TMZ) is a method to protect data being written
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index eb4ce7216104..e2c36ba93d05 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3911,6 +3911,21 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
>         dm->backlight_caps[bl_idx].min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
>         dm->backlight_caps[bl_idx].max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
>  #endif
> +
> +       if (amdgpu_backlight_override_min[bl_idx] >= 0) {
> +               if (amdgpu_backlight_override_min[bl_idx] < dm->backlight_caps[bl_idx].max_input_signal) {
> +                       DRM_INFO("amdgpu: backlight[%i]: overriding minimum brightness from %i to %i\n",
> +                                 bl_idx,
> +                                 dm->backlight_caps[bl_idx].min_input_signal,
> +                                 amdgpu_backlight_override_min[bl_idx]);
> +                       dm->backlight_caps[bl_idx].min_input_signal = amdgpu_backlight_override_min[bl_idx];
> +               } else {
> +                       DRM_ERROR("amdgpu: backlight[%i]: minimum brightness override (%i) is not below maximum (%i)\n",
> +                                 bl_idx,
> +                                 amdgpu_backlight_override_min[bl_idx],
> +                                 dm->backlight_caps[bl_idx].max_input_signal);
> +               }
> +       }
>  }
>
>  static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
>
> base-commit: d8c03bfe146fd5e081a252cd34f3f12ca0255357
> --
> 2.30.2
>
