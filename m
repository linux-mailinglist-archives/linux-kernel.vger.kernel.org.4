Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0035F458A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiJDOdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJDOdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:33:36 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099FE50507
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 07:33:35 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id f189so16962857yba.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 07:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LGoQJV02w4iq8tJZ7pASIKGBxBB5zzM6X73PQg/09U4=;
        b=XWmpQ6NdtndPazcwdRM+/KZyNu5YiOSsn0o8wbKtHbFpB2rowCamiNkTQetbFgKQpe
         4O3JicpHduyxxjP5c5O8ClEKusDIQuLxXSvGsd8Z9heeXc8shK6fv+8AQxcLMeGW7QG6
         ZGQkgukaJT39MJUMXdleFmT7MoEUVXYFlitososNYoR2eYv1GLsztpPqHym80KI4WzB4
         Tg9QKM46jrp5/92UDOATi2slMGywVoDUTXdXELd3p1Bs3z+Y/KKYklDh+asuGwYAQQEz
         nV3erBmxVCwcFHhJxj7Z1nr2fQFENE7LNN7EW9lPZH80sbh0NGLJGhMTGetjTkR6LskL
         btyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LGoQJV02w4iq8tJZ7pASIKGBxBB5zzM6X73PQg/09U4=;
        b=axzumAeO9NZBxJkOBb8sLZk+WfDx43LaNiiaSrFtHlSpUW3Prkch/bTbu8P9UcGPfO
         GiH+B8xhhnkImzUQM9aHT4Oku1zSJd5P3LxaKPb2URgbcrdgGWgq/ap1c/DuTGWLzZFw
         Csv3M5+b3jJ1KMP95i5aCAC6iJt8o5hpcDRnlTE8FOhCaV8nNXBOkLK9qZrHH2yozYU+
         Rx+FHJuwzKdBk4BUJL4/uYeksWsBa7tfxquanbOhUGi0HQis6c3s8CNNPDPcOsG2za63
         DVkxdmPuPqWZ5eDfYvunyWpPAxzeNj/4p0DWAvPt4mq5altwFcyaYg9TARpIzRMfi3uh
         jDsQ==
X-Gm-Message-State: ACrzQf3rt/JnWqSZv3gdTChi99Y89bppTOp64qSn6k+iJZtY7QJxYVue
        WqxABtNiAOM23c/dmm/W9uFK0/QGw7BJrBCBPEuS+Q==
X-Google-Smtp-Source: AMsMyM75EPHULZxxqlM56wQLz2Qa1jvgN80ONq72nOE4A2WXPotngv5/fBZEs18hq8+pmYfXkCCnem6MZ/JnhHNM/Xg=
X-Received: by 2002:a25:2e4e:0:b0:6bc:ac92:a4df with SMTP id
 b14-20020a252e4e000000b006bcac92a4dfmr26615182ybn.153.1664894014224; Tue, 04
 Oct 2022 07:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <1664680506-8336-1-git-send-email-quic_kalyant@quicinc.com>
In-Reply-To: <1664680506-8336-1-git-send-email-quic_kalyant@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 4 Oct 2022 17:33:23 +0300
Message-ID: <CAA8EJpoLeo9EQnuOMhDh=SvYiRZsw-L-9L+62O39GAv8=6SaLw@mail.gmail.com>
Subject: Re: [v6] drm/msm/disp/dpu1: add support for dspp sub block flush in sc7280
To:     Kalyan Thota <quic_kalyant@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Oct 2022 at 06:15, Kalyan Thota <quic_kalyant@quicinc.com> wrote:
>
> Flush mechanism for DSPP blocks has changed in sc7280 family, it
> allows individual sub blocks to be flushed in coordination with
> master flush control.
>
> Representation: master_flush && (PCC_flush | IGC_flush .. etc )
>
> This change adds necessary support for the above design.
>
> Changes in v1:
> - Few nits (Doug, Dmitry)
> - Restrict sub-block flush programming to dpu_hw_ctl file (Dmitry)
>
> Changes in v2:
> - Move the address offset to flush macro (Dmitry)
> - Seperate ops for the sub block flush (Dmitry)
>
> Changes in v3:
> - Reuse the DPU_DSPP_xx enum instead of a new one (Dmitry)
>
> Changes in v4:
> - Use shorter version for unsigned int (Stephen)
>
> Changes in v5:
> - Spurious patch please ignore.
>
> Changes in v6:
> - Add SOB tag (Doug, Dmitry)
>
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c       |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c |  5 +++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h |  4 +++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c     | 35 ++++++++++++++++++++++++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h     | 10 ++++++--
>  5 files changed, 50 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 601d687..4170fbe 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -766,7 +766,7 @@ static void _dpu_crtc_setup_cp_blocks(struct drm_crtc *crtc)
>
>                 /* stage config flush mask */
>                 ctl->ops.update_pending_flush_dspp(ctl,
> -                       mixer[i].hw_dspp->idx);
> +                       mixer[i].hw_dspp->idx, DPU_DSPP_PCC);
>         }
>  }
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 27f029f..0eecb2f 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -65,7 +65,10 @@
>         (PINGPONG_SDM845_MASK | BIT(DPU_PINGPONG_TE2))
>
>  #define CTL_SC7280_MASK \
> -       (BIT(DPU_CTL_ACTIVE_CFG) | BIT(DPU_CTL_FETCH_ACTIVE) | BIT(DPU_CTL_VM_CFG))
> +       (BIT(DPU_CTL_ACTIVE_CFG) | \
> +        BIT(DPU_CTL_FETCH_ACTIVE) | \
> +        BIT(DPU_CTL_VM_CFG) | \
> +        BIT(DPU_CTL_DSPP_SUB_BLOCK_FLUSH))
>
>  #define MERGE_3D_SM8150_MASK (0)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index 38aa38a..8148e91 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -161,10 +161,12 @@ enum {
>   * DSPP sub-blocks
>   * @DPU_DSPP_PCC             Panel color correction block
>   * @DPU_DSPP_GC              Gamma correction block
> + * @DPU_DSPP_IGC             Inverse Gamma correction block
>   */
>  enum {
>         DPU_DSPP_PCC = 0x1,
>         DPU_DSPP_GC,
> +       DPU_DSPP_IGC,
>         DPU_DSPP_MAX
>  };
>
> @@ -191,6 +193,7 @@ enum {
>   * @DPU_CTL_SPLIT_DISPLAY:     CTL supports video mode split display
>   * @DPU_CTL_FETCH_ACTIVE:      Active CTL for fetch HW (SSPPs)
>   * @DPU_CTL_VM_CFG:            CTL config to support multiple VMs
> + * @DPU_CTL_DSPP_BLOCK_FLUSH: CTL config to support dspp sub-block flush
>   * @DPU_CTL_MAX
>   */
>  enum {
> @@ -198,6 +201,7 @@ enum {
>         DPU_CTL_ACTIVE_CFG,
>         DPU_CTL_FETCH_ACTIVE,
>         DPU_CTL_VM_CFG,
> +       DPU_CTL_DSPP_SUB_BLOCK_FLUSH,
>         DPU_CTL_MAX
>  };
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> index a35ecb6..f26f484 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> @@ -33,6 +33,7 @@
>  #define   CTL_INTF_FLUSH                0x110
>  #define   CTL_INTF_MASTER               0x134
>  #define   CTL_FETCH_PIPE_ACTIVE         0x0FC
> +#define   CTL_DSPP_n_FLUSH(n)          ((0x13C) + ((n - 1) * 4))
>
>  #define CTL_MIXER_BORDER_OUT            BIT(24)
>  #define CTL_FLUSH_MASK_CTL              BIT(17)
> @@ -287,8 +288,9 @@ static void dpu_hw_ctl_update_pending_flush_merge_3d_v1(struct dpu_hw_ctl *ctx,
>  }
>
>  static void dpu_hw_ctl_update_pending_flush_dspp(struct dpu_hw_ctl *ctx,
> -       enum dpu_dspp dspp)
> +       enum dpu_dspp dspp, u32 dspp_sub_blk)
>  {
> +
>         switch (dspp) {
>         case DSPP_0:
>                 ctx->pending_flush_mask |= BIT(13);
> @@ -307,6 +309,31 @@ static void dpu_hw_ctl_update_pending_flush_dspp(struct dpu_hw_ctl *ctx,
>         }
>  }
>
> +static void dpu_hw_ctl_update_pending_flush_dspp_subblocks(
> +       struct dpu_hw_ctl *ctx, enum dpu_dspp dspp, u32 dspp_sub_blk)
> +{
> +       u32 flushbits = 0, active;
> +
> +       switch (dspp_sub_blk) {
> +       case DPU_DSPP_IGC:
> +               flushbits = BIT(2);
> +               break;
> +       case DPU_DSPP_PCC:
> +               flushbits = BIT(4);
> +               break;
> +       case DPU_DSPP_GC:
> +               flushbits = BIT(5);
> +               break;
> +       default:
> +               return;
> +       }
> +
> +       active = DPU_REG_READ(&ctx->hw, CTL_DSPP_n_FLUSH(dspp));
> +       DPU_REG_WRITE(&ctx->hw, CTL_DSPP_n_FLUSH(dspp), active | flushbits);
> +
> +       ctx->pending_flush_mask |= BIT(29);
> +}
> +
>  static u32 dpu_hw_ctl_poll_reset_status(struct dpu_hw_ctl *ctx, u32 timeout_us)
>  {
>         struct dpu_hw_blk_reg_map *c = &ctx->hw;
> @@ -675,7 +702,11 @@ static void _setup_ctl_ops(struct dpu_hw_ctl_ops *ops,
>         ops->setup_blendstage = dpu_hw_ctl_setup_blendstage;
>         ops->update_pending_flush_sspp = dpu_hw_ctl_update_pending_flush_sspp;
>         ops->update_pending_flush_mixer = dpu_hw_ctl_update_pending_flush_mixer;
> -       ops->update_pending_flush_dspp = dpu_hw_ctl_update_pending_flush_dspp;
> +       if (cap & BIT(DPU_CTL_DSPP_SUB_BLOCK_FLUSH))
> +               ops->update_pending_flush_dspp = dpu_hw_ctl_update_pending_flush_dspp_subblocks;
> +       else
> +               ops->update_pending_flush_dspp = dpu_hw_ctl_update_pending_flush_dspp;
> +
>         if (cap & BIT(DPU_CTL_FETCH_ACTIVE))
>                 ops->set_active_pipes = dpu_hw_ctl_set_fetch_pipe_active;
>  };
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> index 96c012e..1743572 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> @@ -149,12 +149,18 @@ struct dpu_hw_ctl_ops {
>
>         /**
>          * OR in the given flushbits to the cached pending_flush_mask
> -        * No effect on hardware
> +        *
> +        * If the hardware supports dspp sub block flush, then sub-block
> +        * flushes are written to the hardware and main dspp flush will
> +        * be cached in the pending_flush_mask.

Ok, this changes the semantic of the update_pending_FOO_mask.
Can we cache the pending DSPP blocks instead and flush them together
with the rest of pending flushes?

> +        *
>          * @ctx       : ctl path ctx pointer
>          * @blk       : DSPP block index
> +        * @dspp_sub_blk : DSPP sub-block index
>          */
>         void (*update_pending_flush_dspp)(struct dpu_hw_ctl *ctx,
> -               enum dpu_dspp blk);
> +               enum dpu_dspp blk,  u32 dspp_sub_blk);
> +
>         /**
>          * Write the value of the pending_flush_mask to hardware
>          * @ctx       : ctl path ctx pointer
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
