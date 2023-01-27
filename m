Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2621267E33C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjA0L2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjA0L1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:27:47 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79227E6B9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:26:31 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id m199so5596516ybm.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d3211B/eqPpaLvmnXfm5OZXyP/JXrQPL6aGdcOSbhI0=;
        b=SUO4Rkf0N4JlWVY9u6ZmY1MiyOGmRkm4oFsGjy4gelCL+CXEH9XyqjgSgqo++wuC1i
         vl96+MCIqV3OqZAfRYcWl7K121co+PYixTpgk54kRPDrrclbh8s4lLY6wz9iwlgPIgWO
         F88Rn3r0LMU94VRnLFg5teeN5+zf/aVkTbrE8XVvwdGLb8z3X2LSvshg6dxC8OqI/E91
         ksrjkrnqJB5QxPhfhGB2+ITp9PfTYeth9lApEM9gh1oCF2B+u81cvHBR5BVWnvTz0UII
         hrJfike1zjnhdBIkPl9anFdzj3suBrCzYs8/tB9nlE9ZOcjZ9g+Y0/DEmnx3U7H1EGCo
         zoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d3211B/eqPpaLvmnXfm5OZXyP/JXrQPL6aGdcOSbhI0=;
        b=fo/Rl9Dol28KHNwmU2nd8glcuygBWF1LvhzEe8j4h/LI+Oi52Zrna9rGk3yS3OmhH1
         So45yFSo4peisapvF6iWWO7eSAulmaPEEspusMf8BbhXhZneFdOscK4fOZdoU0JobRQ+
         LntHuLWheXcYUww+VSgTtoGbBHcMGUmfx1r9kJNsqHzkidwi62DrPye5VOXf9RZlEsxr
         osVtm5vjrG+BkImi11Tz0VT7WIVZ6682Jxk9+f1Pja0vrjYmy8ya088MbDqJ27fQG1Pc
         mkdKmbZ4fvS0we/iRHpt5TN5Htk22OSNHyi7XbaK7sP+9pK3cgSw+BGGnUxu53azD2s3
         OtYA==
X-Gm-Message-State: AFqh2koCUvJtLkeCcZUD9KH7jQM8ePdBOkKCtHFhNMIGVellu7VW8yIw
        qHGh8PxJKG//pll/ylDPyz2wLMWBfs8tGdxKMdBKbg==
X-Google-Smtp-Source: AMrXdXvMLGXTfdJ5wQerD9NMyM5boTUQGKSksEjld4CH9OQIFaQZt7w3coaKOIg8fcjJnuRcWhKXfE2PgO9t278VAJ8=
X-Received: by 2002:a5b:592:0:b0:7ed:9cee:464 with SMTP id l18-20020a5b0592000000b007ed9cee0464mr4893677ybp.194.1674818789768;
 Fri, 27 Jan 2023 03:26:29 -0800 (PST)
MIME-Version: 1.0
References: <1674814545-9453-1-git-send-email-quic_kalyant@quicinc.com> <1674814545-9453-4-git-send-email-quic_kalyant@quicinc.com>
In-Reply-To: <1674814545-9453-4-git-send-email-quic_kalyant@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 27 Jan 2023 13:26:18 +0200
Message-ID: <CAA8EJpogp==gSQBj88r+yNcPzPviFv2dOQjckMATQ5H-NQDQqA@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/msm/disp/dpu1: reserve the resources on topology change
To:     Kalyan Thota <quic_kalyant@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com,
        marijn.suijten@somainline.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 at 12:15, Kalyan Thota <quic_kalyant@quicinc.com> wrote:
>
> Some features like ctm can be enabled dynamically. Release and reserve
> the dpu resources whenever a topology change occurs such that
> required hw blocks are allocated appropriately.
>
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h    |  1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 41 ++++++++++++++++++++++++++---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  4 ++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      |  4 ---
>  5 files changed, 42 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
> index 539b68b..89afe04 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
> @@ -225,6 +225,7 @@ struct dpu_crtc_state {
>
>         enum dpu_crtc_crc_source crc_source;
>         int crc_frame_skip_count;
> +       struct msm_display_topology topology;
>  };
>
>  #define to_dpu_crtc_state(x) \
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 8d76cb3..db417f5 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -217,6 +217,18 @@ static u32 dither_matrix[DITHER_MATRIX_SZ] = {
>         15, 7, 13, 5, 3, 11, 1, 9, 12, 4, 14, 6, 0, 8, 2, 10
>  };
>
> +static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
> +                                            struct drm_crtc_state *crtc_state,
> +                                            struct drm_connector_state *conn_state);
> +
> +static bool _dpu_enc_is_topology_changed(struct drm_crtc_state *crtc_state,
> +       struct msm_display_topology topology)
> +{
> +       struct dpu_crtc_state *cstate = to_dpu_crtc_state(crtc_state);
> +
> +       return !!memcmp(&cstate->topology,
> +               &topology, sizeof(struct msm_display_topology));
> +}
>
>  bool dpu_encoder_is_widebus_enabled(const struct drm_encoder *drm_enc)
>  {
> @@ -650,12 +662,16 @@ static int dpu_encoder_virt_atomic_check(
>                  * Release and Allocate resources on every modeset
>                  * Dont allocate when active is false.
>                  */
> -               if (drm_atomic_crtc_needs_modeset(crtc_state)) {
> +               if (drm_atomic_crtc_needs_modeset(crtc_state) ||
> +                       _dpu_enc_is_topology_changed(crtc_state, topology)) {
>                         dpu_rm_release(global_state, drm_enc);
>
> -                       if (!crtc_state->active_changed || crtc_state->active)
> +                       if (crtc_state->enable) {
>                                 ret = dpu_rm_reserve(&dpu_kms->rm, global_state,
>                                                 drm_enc, crtc_state, topology);
> +                               if (!ret)
> +                                       dpu_enc->topology = topology;
> +                       }
>                 }
>         }
>
> @@ -1089,7 +1105,7 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
>         }
>
>         cstate->num_mixers = num_lm;
> -
> +       cstate->topology = dpu_enc->topology;

There is one part of the story that I do not quite like here. The crtc
state now gets the encoder-level information (regarding the num_intf,
num_enc, etc).
Just to clarify, I find it particularly bad that we have to actively
poke into the crtc state from the dpu_encoder.c. I hope to get to it
at some point, most probably while reworking the encoder code to
support  using a single CTL for all the operations.

>         dpu_enc->connector = conn_state->connector;
>
>         for (i = 0; i < dpu_enc->num_phys_encs; i++) {
> @@ -2076,11 +2092,14 @@ void dpu_encoder_helper_phys_cleanup(struct dpu_encoder_phys *phys_enc)
>         ctl->ops.clear_pending_flush(ctl);
>  }
>
> -void dpu_encoder_prepare_commit(struct drm_encoder *drm_enc)
> +void dpu_encoder_prepare_commit(struct drm_encoder *drm_enc,
> +       struct drm_crtc_state *crtc_state)
>  {
>         struct dpu_encoder_virt *dpu_enc;
>         struct dpu_encoder_phys *phys;
>         int i;
> +       struct list_head *connector_list;
> +       struct drm_connector *conn = NULL, *conn_iter;
>
>         if (!drm_enc) {
>                 DPU_ERROR("invalid encoder\n");
> @@ -2088,6 +2107,20 @@ void dpu_encoder_prepare_commit(struct drm_encoder *drm_enc)
>         }
>         dpu_enc = to_dpu_encoder_virt(drm_enc);
>
> +       connector_list = &drm_enc->dev->mode_config.connector_list;
> +       list_for_each_entry(conn_iter, connector_list, head)
> +               if (conn_iter->state->best_encoder == drm_enc)
> +                       conn = conn_iter;

I don't think we can poke at conn_iter->state here.

> +
> +       /*
> +        * In case of modeset, DRM kernel will trigger a atomic_mode_set
> +        * call back, for usecases where there is no mode change but a topology
> +        * change, update the resources from here.
> +        */
> +       if (!drm_atomic_crtc_needs_modeset(crtc_state) &&
> +               _dpu_enc_is_topology_changed(crtc_state, dpu_enc->topology))
> +               dpu_encoder_virt_atomic_mode_set(drm_enc, crtc_state, conn->state);

And this is a complete pain. I think it would be easier to set the
crtc_state->mode_changed if we detect the change in the CTM
enablement.
Please start from that and then fill in the necessary bits (in other
words if we need to store the topology or just a boolean flag
`ctm_enabled' / `need_dspp').

> +
>         for (i = 0; i < dpu_enc->num_phys_encs; i++) {
>                 phys = dpu_enc->phys_encs[i];
>                 if (phys->ops.prepare_commit)
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> index 9e7236e..4cbe20c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> @@ -150,8 +150,10 @@ int dpu_encoder_setup(struct drm_device *dev, struct drm_encoder *enc,
>   * dpu_encoder_prepare_commit - prepare encoder at the very beginning of an
>   *     atomic commit, before any registers are written
>   * @drm_enc:    Pointer to previously created drm encoder structure
> + * @crtc_state: Pointer to drm crtc state
>   */
> -void dpu_encoder_prepare_commit(struct drm_encoder *drm_enc);
> +void dpu_encoder_prepare_commit(struct drm_encoder *drm_enc,
> +               struct drm_crtc_state *crtc_state);
>
>  /**
>   * dpu_encoder_set_idle_timeout - set the idle timeout for video
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 7a5fabc..f111120 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -455,7 +455,7 @@ static void dpu_kms_prepare_commit(struct msm_kms *kms,
>         for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
>                 drm_for_each_encoder_mask(encoder, crtc->dev,
>                                           crtc_state->encoder_mask) {
> -                       dpu_encoder_prepare_commit(encoder);
> +                       dpu_encoder_prepare_commit(encoder, crtc_state);
>                 }
>         }
>  }
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> index 718ea0a..341c3af 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> @@ -586,10 +586,6 @@ int dpu_rm_reserve(
>         struct dpu_rm_requirements reqs;
>         int ret;
>
> -       /* Check if this is just a page-flip */
> -       if (!drm_atomic_crtc_needs_modeset(crtc_state))
> -               return 0;
> -
>         if (IS_ERR(global_state)) {
>                 DPU_ERROR("failed to global state\n");
>                 return PTR_ERR(global_state);
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
