Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F5374FC4B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 02:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjGLAmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 20:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjGLAmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 20:42:50 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E473410D4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 17:42:48 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b6f52e1c5cso100958691fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 17:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689122567; x=1691714567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1rGc1tm7GtQ9oseOAmnScr9Dmh0EaIn4ENjW72qzptE=;
        b=y90DZR/OYavpJ7AB3SkumVvJlwJb9hEwYEA1Nq1lYP5Atfc2POukJYrs/EqaC2czKk
         ujMk1cEhcmQhP/ddcDSFN1e0nePB7wRK2UlCyJMfBEUYtqT/4f9eCvEwUjFrejSnYLNd
         dh3MwhsYrK+A1Ag1srNbMeWLdF3J0YsLxBzIEdXoLmWjMIS1001UbyN/qKSIeIfDoYM1
         NXxmqYUl8wVfYmRcIrJUqB0FWhKZv/n3dMlrR/ee+A5uUHIkiuo+lciwMp/1MEaIB2wX
         f5vd8teQhlaCbdNxbtd/XeuVMdm11KhY1vtMBl9Uf4Gdqcb3upKRlrPtp/Dd2tuquSNP
         C4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689122567; x=1691714567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1rGc1tm7GtQ9oseOAmnScr9Dmh0EaIn4ENjW72qzptE=;
        b=XRiX15TrUYVwHYT+KY64RrtfsozsnXr860CUSJ+Xb+V2WByaTLuq6gaqqQ6BYXJl5V
         UYQiacsfuiMFDQW40HFv449oeeSYDM+NjFlxYH4kGmof7QXFbTcM/W+P5tn+h1/hRpkn
         e3NFluGPvge3gXHap2Ob6EyFyn7H557aFo8X/EzPb2mseNBP4yhcr7IF3jWvYBceF6/q
         QiSNi4iVLhLyZ+X+O1y79R5azNgHU8+nU/oCWfWR7nIAf+iS5W9OWipkoG/YzpvwOGEa
         yW/EayY85pCAafZOvTK88Hhg/DES6MfUAcwS8emYMgwLIrSOKSF967ydB3WOsJp26M+V
         fZyw==
X-Gm-Message-State: ABy/qLYdtoZR41MP81lDahGTqtWXn5xrATtEo0wifAl4ZxUDRBM1ELdt
        r7gIQEyvvA39lm+XY4Rlij3afyRfvOwBwUVEiMY=
X-Google-Smtp-Source: APBJJlGsKz9klozJT9LbRFQsti8avzmEUmUVowzw9G+BQT1Ec+22gyxCh5g6h/EZzI200AJJIC68Ng==
X-Received: by 2002:a2e:9188:0:b0:2b6:cdfb:fe36 with SMTP id f8-20020a2e9188000000b002b6cdfbfe36mr16334928ljg.39.1689122567186;
        Tue, 11 Jul 2023 17:42:47 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id q7-20020a2e8747000000b002b6ea4ed1f0sm678818ljj.14.2023.07.11.17.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 17:42:46 -0700 (PDT)
Message-ID: <b834fc46-80c8-b75d-d7e9-e525ac27077e@linaro.org>
Date:   Wed, 12 Jul 2023 03:42:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 3/4] drm/msm/dpu: rename enable_compression() to
 program_intf_cmd_cfg()
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230712003310.31961-1-quic_abhinavk@quicinc.com>
 <20230712003310.31961-4-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230712003310.31961-4-quic_abhinavk@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 03:33, Abhinav Kumar wrote:
> Rename the intf's enable_compression() op to program_intf_cmd_cfg()
> and allow it to accept a struct intf_cmd_mode_cfg to program
> all the bits at once. This can be re-used by widebus later on as
> well as it touches the same register.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c |  8 ++++++--
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c          |  8 +++++---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h          | 11 +++++++++--
>   3 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> index b856c6286c85..052824eac9f3 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> @@ -50,6 +50,7 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
>   			to_dpu_encoder_phys_cmd(phys_enc);
>   	struct dpu_hw_ctl *ctl;
>   	struct dpu_hw_intf_cfg intf_cfg = { 0 };
> +	struct intf_cmd_mode_cfg cmd_mode_cfg = {};
>   
>   	ctl = phys_enc->hw_ctl;
>   	if (!ctl->ops.setup_intf_cfg)
> @@ -68,8 +69,11 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
>   				phys_enc->hw_intf,
>   				phys_enc->hw_pp->idx);
>   
> -	if (intf_cfg.dsc != 0 && phys_enc->hw_intf->ops.enable_compression)
> -		phys_enc->hw_intf->ops.enable_compression(phys_enc->hw_intf);
> +	if (intf_cfg.dsc != 0)
> +		cmd_mode_cfg.data_compress = true;
> +
> +	if (phys_enc->hw_intf->ops.program_intf_cmd_cfg)
> +		phys_enc->hw_intf->ops.program_intf_cmd_cfg(phys_enc->hw_intf, &cmd_mode_cfg);
>   }
>   
>   static void dpu_encoder_phys_cmd_pp_tx_done_irq(void *arg, int irq_idx)
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> index d766791438e7..7323c713dad1 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> @@ -513,11 +513,13 @@ static void dpu_hw_intf_disable_autorefresh(struct dpu_hw_intf *intf,
>   
>   }
>   
> -static void dpu_hw_intf_enable_compression(struct dpu_hw_intf *ctx)
> +static void dpu_hw_intf_program_intf_cmd_cfg(struct dpu_hw_intf *ctx,
> +					     struct intf_cmd_mode_cfg *cmd_mode_cfg)
>   {
>   	u32 intf_cfg2 = DPU_REG_READ(&ctx->hw, INTF_CONFIG2);
>   
> -	intf_cfg2 |= INTF_CFG2_DCE_DATA_COMPRESS;
> +	if (cmd_mode_cfg->data_compress)
> +		intf_cfg2 |= INTF_CFG2_DCE_DATA_COMPRESS;
>   
>   	DPU_REG_WRITE(&ctx->hw, INTF_CONFIG2, intf_cfg2);
>   }
> @@ -544,7 +546,7 @@ static void _setup_intf_ops(struct dpu_hw_intf_ops *ops,
>   	}
>   
>   	if (mdss_rev->core_major_ver >= 7)
> -		ops->enable_compression = dpu_hw_intf_enable_compression;
> +		ops->program_intf_cmd_cfg = dpu_hw_intf_program_intf_cmd_cfg;
>   }
>   
>   struct dpu_hw_intf *dpu_hw_intf_init(const struct dpu_intf_cfg *cfg,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> index 3b5f18dbcb4b..c15f4973de5e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> @@ -48,6 +48,11 @@ struct intf_status {
>   	u32 line_count;		/* current line count including blanking */
>   };
>   
> +struct intf_cmd_mode_cfg {

My first reaction was that usually all DPU structure names start with 
dpu_. Then I discovered that dpu_hw_intf.h diverges from this useful 
custom. Could you please: fix existing structure struct intf_* names to 
bear the dpu_ prefix. Then this structure can also be named as struct 
dpu_intf_cmd_mode_cfg.

> +	u8 data_compress;	/* enable data compress between dpu and dsi */
> +	/* can be expanded for other programmable bits */

Please drop this comment.

> +};
> +
>   /**
>    * struct dpu_hw_intf_ops : Interface to the interface Hw driver functions
>    *  Assumption is these functions will be called after clocks are enabled
> @@ -70,7 +75,7 @@ struct intf_status {
>    * @get_autorefresh:            Retrieve autorefresh config from hardware
>    *                              Return: 0 on success, -ETIMEDOUT on timeout
>    * @vsync_sel:                  Select vsync signal for tear-effect configuration
> - * @enable_compression:         Enable data compression
> + * @program_intf_cmd_cfg:       Program the DPU to interface datapath for command mode
>    */
>   struct dpu_hw_intf_ops {
>   	void (*setup_timing_gen)(struct dpu_hw_intf *intf,
> @@ -108,7 +113,9 @@ struct dpu_hw_intf_ops {
>   	 */
>   	void (*disable_autorefresh)(struct dpu_hw_intf *intf, uint32_t encoder_id, u16 vdisplay);
>   
> -	void (*enable_compression)(struct dpu_hw_intf *intf);
> +	// Program the datapath between DPU and intf for command mode

We have been using c99 comments in the code, Moreover, there is already 
description for this field in the comment above, so it can be dropped too.

> +	void (*program_intf_cmd_cfg)(struct dpu_hw_intf *intf,
> +				     struct intf_cmd_mode_cfg *cmd_mode_cfg);
>   };
>   
>   struct dpu_hw_intf {

-- 
With best wishes
Dmitry

