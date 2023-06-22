Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DA773A859
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjFVShS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjFVShN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:37:13 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5FB210E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:36:53 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-56ce61769b7so78604057b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687459012; x=1690051012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=//iH0bqfYBmUnbXo+bhKFynz91+0tnyWOGAyZ/SuDLM=;
        b=XxEQ8HCzJO+mzri75WwxEKPiNY5kG2RtruboMfgtewbqveU3SAFFShS6SHTkAdQ1xW
         3xtKe8pQOFCn4CQwLCbiP2kB+frF/fTQH3wKFo+uKJAGTfXdnOrQR95gVd5SyPl9Iu3s
         9o5w6rLAdqOjqvmnGu1PgtA9PCGntvp5TVw0F66JeXWu+UYS957UY1cAaRhxV5svnUNO
         HVt8eilZCZAexRjPolvmh9YvD2Em1lJvJxtBAqx5Ro550DhMUPxzkMa77uby89WPyCh/
         xFMNtwmD4HcfPWImPdxh9+94FrZADDBWaH21odtHYeQujJt42sePDHjPg7QPBvCtlc4L
         MO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687459012; x=1690051012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//iH0bqfYBmUnbXo+bhKFynz91+0tnyWOGAyZ/SuDLM=;
        b=DpGaIjf6eKXd5cKMs9PfolPAFjgB2VKUCn3O8RhNIahjg/ZXkAT/NDbESiyI0JHnwg
         UI97FfZCRy0CPlmfBo+UZOYw9eMAj47xFOmleyEREV9svV3GfsJVTLV/7emEXYWXKfCe
         AU/Q9q8ELdzHfmgXhe3dQY5jK+jrdRtA+TldlZEzJpHxOxg96SsNIJ6Z/nHoGiRAFObD
         rBLvPNr8RbxEl84XOwWtJzh1VHiZAn/6uh3iR/TF74Ht6eTjhjVRCY9DKShgafzoxSnJ
         37lVHzuW8vFGUVLz/G2JJNUpQ9CULph/+V95RqPCGXogFHM3FpJDefepM0gpjBxR6eW/
         yoXw==
X-Gm-Message-State: AC+VfDzgPIb3pWH8z7nBPTkJPlBIBwjYSAdz7WlZ3Fbpkw7OK+9HOHBB
        +z9O27LfSKSnq1FXe4bHXlqcF4xLYQDlG3XmkbghKg==
X-Google-Smtp-Source: ACHHUZ5HNiMJ1Au5OefxiYLzEEMpQCofd1JWFFf+nN3NSuiVIJTfvj/ZBGvWRBMTkqryEHgFWcKy+KeXN9K8zkMQUZY=
X-Received: by 2002:a25:7dc1:0:b0:c01:2f64:27ec with SMTP id
 y184-20020a257dc1000000b00c012f6427ecmr2910620ybc.21.1687459012553; Thu, 22
 Jun 2023 11:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <1687454686-10340-1-git-send-email-quic_khsieh@quicinc.com> <1687454686-10340-2-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1687454686-10340-2-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 22 Jun 2023 21:36:41 +0300
Message-ID: <CAA8EJpoc+4Hx221Zf0i8yhRxFQ9BhgZ5H5QQ5EvwpAarXFu8Gg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] drm/msm/dpu: retrieve DSI DSC struct through priv->dsi[0]
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 at 20:25, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> Currently struct drm_dsc_config for DSI is populated at display
> setup during system boot up. This mechanism works fine with
> embedded display but not for pluggable displays as the
> struct drm_dsc_config will become stale once external display
> is unplugged.
>

Nit: "In preparation of adding support for DP DSC..."

If you don't mind, I'll append this phrase while applying the patch.

> Move storing of DSI DSC struct to atomic_enable() so that same
> mechanism will work for both embedded display and pluggable
> displays.
>
> Changes in v4:
> -- fix checkpatch.pl warning
>
> Changes in v5:
> -- delete dpu_encoder_get_dsc_config() from atomic_mode_set

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 42 ++++++++++++++++++++---------
>  1 file changed, 30 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 2e1873d..edc559d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -543,11 +543,24 @@ bool dpu_encoder_use_dsc_merge(struct drm_encoder *drm_enc)
>         return (num_dsc > 0) && (num_dsc > intf_count);
>  }
>
> +static struct drm_dsc_config *dpu_encoder_get_dsc_config(struct drm_encoder *drm_enc)
> +{
> +       struct msm_drm_private *priv = drm_enc->dev->dev_private;
> +       struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
> +       int index = dpu_enc->disp_info.h_tile_instance[0];
> +
> +       if (dpu_enc->disp_info.intf_type == INTF_DSI)
> +               return msm_dsi_get_dsc_config(priv->dsi[index]);
> +
> +       return NULL;
> +}
> +
>  static struct msm_display_topology dpu_encoder_get_topology(
>                         struct dpu_encoder_virt *dpu_enc,
>                         struct dpu_kms *dpu_kms,
>                         struct drm_display_mode *mode,
> -                       struct drm_crtc_state *crtc_state)
> +                       struct drm_crtc_state *crtc_state,
> +                       struct drm_dsc_config *dsc)
>  {
>         struct msm_display_topology topology = {0};
>         int i, intf_count = 0;
> @@ -579,7 +592,7 @@ static struct msm_display_topology dpu_encoder_get_topology(
>
>         topology.num_intf = intf_count;
>
> -       if (dpu_enc->dsc) {
> +       if (dsc) {
>                 /*
>                  * In case of Display Stream Compression (DSC), we would use
>                  * 2 DSC encoders, 2 layer mixers and 1 interface
> @@ -605,6 +618,7 @@ static int dpu_encoder_virt_atomic_check(
>         struct drm_display_mode *adj_mode;
>         struct msm_display_topology topology;
>         struct dpu_global_state *global_state;
> +       struct drm_dsc_config *dsc;
>         int i = 0;
>         int ret = 0;
>
> @@ -640,7 +654,9 @@ static int dpu_encoder_virt_atomic_check(
>                 }
>         }
>
> -       topology = dpu_encoder_get_topology(dpu_enc, dpu_kms, adj_mode, crtc_state);
> +       dsc = dpu_encoder_get_dsc_config(drm_enc);
> +
> +       topology = dpu_encoder_get_topology(dpu_enc, dpu_kms, adj_mode, crtc_state, dsc);
>
>         /*
>          * Release and Allocate resources on every modeset
> @@ -1072,14 +1088,12 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
>                 dpu_enc->hw_pp[i] = i < num_pp ? to_dpu_hw_pingpong(hw_pp[i])
>                                                 : NULL;
>
> -       if (dpu_enc->dsc) {
> -               num_dsc = dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
> -                                                       drm_enc->base.id, DPU_HW_BLK_DSC,
> -                                                       hw_dsc, ARRAY_SIZE(hw_dsc));
> -               for (i = 0; i < num_dsc; i++) {
> -                       dpu_enc->hw_dsc[i] = to_dpu_hw_dsc(hw_dsc[i]);
> -                       dsc_mask |= BIT(dpu_enc->hw_dsc[i]->idx - DSC_0);
> -               }
> +       num_dsc = dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
> +                                               drm_enc->base.id, DPU_HW_BLK_DSC,
> +                                               hw_dsc, ARRAY_SIZE(hw_dsc));
> +       for (i = 0; i < num_dsc; i++) {
> +               dpu_enc->hw_dsc[i] = to_dpu_hw_dsc(hw_dsc[i]);
> +               dsc_mask |= BIT(dpu_enc->hw_dsc[i]->idx - DSC_0);
>         }
>
>         dpu_enc->dsc_mask = dsc_mask;
> @@ -1187,6 +1201,8 @@ static void dpu_encoder_virt_atomic_enable(struct drm_encoder *drm_enc,
>
>         dpu_enc = to_dpu_encoder_virt(drm_enc);
>
> +       dpu_enc->dsc = dpu_encoder_get_dsc_config(drm_enc);
> +
>         mutex_lock(&dpu_enc->enc_lock);
>         cur_mode = &dpu_enc->base.crtc->state->adjusted_mode;
>
> @@ -2109,8 +2125,10 @@ void dpu_encoder_helper_phys_cleanup(struct dpu_encoder_phys *phys_enc)
>                                         phys_enc->hw_pp->merge_3d->idx);
>         }
>
> -       if (dpu_enc->dsc)
> +       if (dpu_enc->dsc) {
>                 dpu_encoder_unprep_dsc(dpu_enc);
> +               dpu_enc->dsc = NULL;
> +       }
>
>         intf_cfg.stream_sel = 0; /* Don't care value for video mode */
>         intf_cfg.mode_3d = dpu_encoder_helper_get_3d_blend_mode(phys_enc);
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
