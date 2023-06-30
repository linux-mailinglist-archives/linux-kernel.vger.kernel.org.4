Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7EE743189
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 02:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjF3AUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 20:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjF3AU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:20:29 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5882D70
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:20:28 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b6994a8ce3so19981901fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688084426; x=1690676426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wzB898hHM+aZkD7AnMsERnbM9ENa0UWDPXWVzCorU+w=;
        b=xMSaNqNNJiUU3i2hlVAQ1yHI/9PDxiGYo78RDik+mNXkcHErS/JthFkXRwxLnx8MCG
         3+fgao7LDA/R3gRUSfIUd9g6R+vFQJFN97ypfZXMmvWtDJVsx80wmTC1DOv8+/X8A2n8
         9T2zsDsendliyW9v/YEQifwKPtQnGfN87t+fmx9U4VsCCK3FDFc7ihaZeRaNm/x+FTkX
         uFTSjjuY3zZJsEbk6Do35r2NjwOBc1VUWQGRfAqPL4fAHbLNQQQFQD6DR6OJqYBoA8BM
         MXcJCOq50xxPQPTGihZs1B8ozzGwIUVkcIsLHb+sbHg452SYTk+kCUFT9+fXOCc7JUHg
         K9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688084426; x=1690676426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wzB898hHM+aZkD7AnMsERnbM9ENa0UWDPXWVzCorU+w=;
        b=Ez+VnTJjSkimfg3N3GXjsIJWrG8dun9fLxeviozUzG4p2rD0A+KxINK8ZpQcWfYf+h
         AFeYjG/EktcdraldqFN+GuQCnsePcrp6bw3D7tTtmqBPol8pWfK39rrSzxTSuWeXGYlr
         KrPsVIeMJfZn14buvoStA+L3SBxXShe8jEikgJNaZ8ghq7SSzMOkg3PXGeI6BtGi5IZu
         s+In1gC6Uu4j/CidLET3RonBMF80COMhu0m1GhB2777ByU6if4AMa5tkZ6pYgIdHskRX
         /JXZ9YeboRfTlO/deVgYe9tUi8phmh20Q2ICb/W3y0t7m2+y9cWkmVidnNwYYtH+PtGu
         XW1g==
X-Gm-Message-State: ABy/qLYQf9rcFQM2osAppFO5zwHkkBUqP8RLa4Q/r6GxwaqkQ0FfuYIr
        97n93pmPRW4OJGbA4R54K2+19w==
X-Google-Smtp-Source: APBJJlFfU+R5Jp9Jfrz0wvf4NLeeRzURxjVBtmx8kya8g1+ffAInTDI9dJvKpoBJt5SyeLs7dpRknw==
X-Received: by 2002:a05:6512:20c7:b0:4fb:978e:95b8 with SMTP id u7-20020a05651220c700b004fb978e95b8mr952484lfr.59.1688084426131;
        Thu, 29 Jun 2023 17:20:26 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id v15-20020ac2592f000000b004ec6252aa37sm2533353lfi.116.2023.06.29.17.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 17:20:25 -0700 (PDT)
Message-ID: <17b3b652-194c-99c2-e460-21663040c398@linaro.org>
Date:   Fri, 30 Jun 2023 03:20:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/3] drm/msm/dpu: use dpu core's major version to
 enable data compress
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
References: <20230629193001.22618-1-quic_abhinavk@quicinc.com>
 <20230629193001.22618-2-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230629193001.22618-2-quic_abhinavk@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2023 22:29, Abhinav Kumar wrote:
> Instead of using a feature bit to decide whether to enable data
> compress or not for DSC use-cases, use dpu core's major version instead.
> This will avoid defining feature bits for every bit level details of
> registers.
> 
> Also, rename the intf's enable_compression() op to program_datapath()
> and allow it to accept a struct intf_dpu_datapath_cfg to program
> all the bits at once. This can be re-used by widebus later on as
> well as it touches the same register.

Two separate commits please, because...

> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c |  9 +++++++--
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c      |  9 +++++----
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h      | 16 ++++++++++++++--
>   3 files changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> index b856c6286c85..f4e15b4c4cc9 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> @@ -50,6 +50,7 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
>   			to_dpu_encoder_phys_cmd(phys_enc);
>   	struct dpu_hw_ctl *ctl;
>   	struct dpu_hw_intf_cfg intf_cfg = { 0 };
> +	struct dpu_kms *dpu_kms = phys_enc->dpu_kms;
>   
>   	ctl = phys_enc->hw_ctl;
>   	if (!ctl->ops.setup_intf_cfg)
> @@ -68,8 +69,12 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
>   				phys_enc->hw_intf,
>   				phys_enc->hw_pp->idx);
>   
> -	if (intf_cfg.dsc != 0 && phys_enc->hw_intf->ops.enable_compression)
> -		phys_enc->hw_intf->ops.enable_compression(phys_enc->hw_intf);
> +	if (intf_cfg.dsc != 0 && dpu_kms->catalog->core_major_version >= 0x7) {

... because this becomes incorrect. The datapath should be programmed in 
all the cases, if there is a corresponding callback. intf_cfg.dsc should 
be used as a condition to set datapath_cfg.


> +		struct intf_dpu_datapath_cfg datapath_cfg = { 0 };

No need for `0' in the init, empty braces would be enough.

> +
> +		datapath_cfg.data_compress = true;
> +		phys_enc->hw_intf->ops.program_datapath(phys_enc->hw_intf, &datapath_cfg);
> +	}
>   }
>   
>   static void dpu_encoder_phys_cmd_pp_tx_done_irq(void *arg, int irq_idx)
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> index 5b0f6627e29b..85333df08fbc 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> @@ -513,11 +513,13 @@ static void dpu_hw_intf_disable_autorefresh(struct dpu_hw_intf *intf,
>   
>   }
>   
> -static void dpu_hw_intf_enable_compression(struct dpu_hw_intf *ctx)
> +static void dpu_hw_intf_program_datapath(struct dpu_hw_intf *ctx,
> +					 struct intf_dpu_datapath_cfg *datapath_cfg)
>   {
>   	u32 intf_cfg2 = DPU_REG_READ(&ctx->hw, INTF_CONFIG2);
>   
> -	intf_cfg2 |= INTF_CFG2_DCE_DATA_COMPRESS;
> +	if (datapath_cfg->data_compress)
> +		intf_cfg2 |= INTF_CFG2_DCE_DATA_COMPRESS;
>   
>   	DPU_REG_WRITE(&ctx->hw, INTF_CONFIG2, intf_cfg2);
>   }
> @@ -543,8 +545,7 @@ static void _setup_intf_ops(struct dpu_hw_intf_ops *ops,
>   		ops->disable_autorefresh = dpu_hw_intf_disable_autorefresh;
>   	}
>   
> -	if (cap & BIT(DPU_INTF_DATA_COMPRESS))
> -		ops->enable_compression = dpu_hw_intf_enable_compression;
> +	ops->program_datapath = dpu_hw_intf_program_datapath;

The `core_major_version >= 7' should either be here or in the callback 
itself.

>   }
>   
>   struct dpu_hw_intf *dpu_hw_intf_init(const struct dpu_intf_cfg *cfg,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> index 99e21c4137f9..f736dca38463 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> @@ -48,6 +48,11 @@ struct intf_status {
>   	u32 line_count;		/* current line count including blanking */
>   };
>   
> +struct intf_dpu_datapath_cfg {
> +	u8 data_compress;	/* enable data compress between dpu and dsi */
> +	/* can be expanded for other programmable bits */
> +};

I'd say, dpu_datapath is too generic. What about  intf_cmd_mode_cfg?

> +
>   /**
>    * struct dpu_hw_intf_ops : Interface to the interface Hw driver functions
>    *  Assumption is these functions will be called after clocks are enabled
> @@ -70,7 +75,7 @@ struct intf_status {
>    * @get_autorefresh:            Retrieve autorefresh config from hardware
>    *                              Return: 0 on success, -ETIMEDOUT on timeout
>    * @vsync_sel:                  Select vsync signal for tear-effect configuration
> - * @enable_compression:         Enable data compression
> + * @program_datapath:           Program the DPU to interface datapath for relevant chipsets
>    */
>   struct dpu_hw_intf_ops {
>   	void (*setup_timing_gen)(struct dpu_hw_intf *intf,
> @@ -108,7 +113,14 @@ struct dpu_hw_intf_ops {
>   	 */
>   	void (*disable_autorefresh)(struct dpu_hw_intf *intf, uint32_t encoder_id, u16 vdisplay);
>   
> -	void (*enable_compression)(struct dpu_hw_intf *intf);
> +	/**
> +	 * Program the DPU to intf datapath by specifying
> +	 * which of the settings need to be programmed for
> +	 * use-cases which need DPU-intf handshake such as
> +	 * widebus, compression etc.

This is not a valid kerneldoc.

> +	 */
> +	void (*program_datapath)(struct dpu_hw_intf *intf,
> +				 struct intf_dpu_datapath_cfg *datapath_cfg);
>   };
>   
>   struct dpu_hw_intf {

-- 
With best wishes
Dmitry

