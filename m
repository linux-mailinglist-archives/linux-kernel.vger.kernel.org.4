Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1116B6E6110
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjDRMTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjDRMTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:19:46 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FD119B4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:19:44 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ec9c7c6986so2098710e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681820383; x=1684412383;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K++As7i154zwy5IfL3jSAA+dS+SNhRonUKRKEBDZdQo=;
        b=GBNnT2+EtV8AGVfQXoStAHMhcq6vQHNGBuNRiGlipr+QXcMxV5CK6FbJlFQzvgPSkh
         i0b3FbYhA+oUa2fbANSUyMopARHbAQI70pQI52R8IM9YTs/1EGUd1PDy1L84vnTB952e
         ot0hGQQJpg88huZFyxCwK0ZfAZfu9QbhwWDkS1ckS4II20yWHtIcFI67zqrpTCdcIX1O
         OlRLTTTmv9QAiL1JnXmGiKDaryBgPrjtK6zLXunEohOYj/M25Xr2TVUVroGEj2aqRotW
         B51J3Rdx6htFe/QMo8Tl5K+DzLW7DCgq2oOw8+8kTWIBLfa8uTpKkekQEaRh1mRBKvoQ
         0wxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681820383; x=1684412383;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K++As7i154zwy5IfL3jSAA+dS+SNhRonUKRKEBDZdQo=;
        b=SbhGLYxdSaALv1BMzrGLxWDT8E0XNFQpvLADUZV5LSI8OZsPHUJCixvAA4Pn/BxT2S
         7C1dyWpQxSHfj7oNVckmnqFWDdXFrGAPsB0QzfFYybVZL2so9TzhPuNZTQItgLOSrEkC
         +HLJFKbD5HJ7mZJjN3ZkKyq/+MJOCa2RbOO9BSM06TRqhqlJzsR4bST7Xyin+nfLP//i
         /5hGkzETSNApidjF9bJ37buBNlMPHD2hGbjn9AJ8zzkGM0PPhobahmFH3NAo7byWVHsB
         eJc88ag83hy8xFjqQ++wEDrAyj5k6EdLJb9XYBIbSTPItBFnS3OZmfZhTJgTB7cGG8W8
         joTg==
X-Gm-Message-State: AAQBX9cMHi8Ozv4HD09hLT++CvLAQgKf6n38KgfP6b9ClvXmV93xbrNa
        LeUiIc8E1ZDf3VtLMFmu8jbCwA==
X-Google-Smtp-Source: AKy350YFhqTX/v70GkNmfk43WzugSNGIvy7NEj5Czhf3tsNe3Jr27fQf5XWxWxVoVhNiYZMv41h2gw==
X-Received: by 2002:ac2:5e83:0:b0:4eb:2643:c6c6 with SMTP id b3-20020ac25e83000000b004eb2643c6c6mr2836780lfq.53.1681820383155;
        Tue, 18 Apr 2023 05:19:43 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id s15-20020ac25fef000000b004ec8b638115sm2355741lfg.193.2023.04.18.05.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 05:19:42 -0700 (PDT)
Message-ID: <8fa0d582-8c1d-5436-ca53-c31badd2f459@linaro.org>
Date:   Tue, 18 Apr 2023 14:19:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 08/17] drm/msm/dpu: Drop unused poll_timeout_wr_ptr
 PINGPONG callback
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Adam Skladowski <a39.skl@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Archit Taneja <architt@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>
References: <20230411-dpu-intf-te-v2-0-ef76c877eb97@somainline.org>
 <20230411-dpu-intf-te-v2-8-ef76c877eb97@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230411-dpu-intf-te-v2-8-ef76c877eb97@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.04.2023 22:21, Marijn Suijten wrote:
> This callback was migrated from downstream when DPU1 was first
> introduced to mainline, but never used by any component.  Drop it to
> save some lines and unnecessary confusion.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c | 18 ------------------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h |  6 ------
>  2 files changed, 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> index 0fcad9760b6f..b18efd640abd 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> @@ -144,23 +144,6 @@ static bool dpu_hw_pp_get_autorefresh_config(struct dpu_hw_pingpong *pp,
>  	return !!((val & BIT(31)) >> 31);
>  }
>  
> -static int dpu_hw_pp_poll_timeout_wr_ptr(struct dpu_hw_pingpong *pp,
> -		u32 timeout_us)
> -{
> -	struct dpu_hw_blk_reg_map *c;
> -	u32 val;
> -	int rc;
> -
> -	if (!pp)
> -		return -EINVAL;
> -
> -	c = &pp->hw;
> -	rc = readl_poll_timeout(c->blk_addr + PP_LINE_COUNT,
> -			val, (val & 0xffff) >= 1, 10, timeout_us);
> -
> -	return rc;
> -}
> -
>  static int dpu_hw_pp_enable_te(struct dpu_hw_pingpong *pp, bool enable)
>  {
>  	struct dpu_hw_blk_reg_map *c;
> @@ -280,7 +263,6 @@ static void _setup_pingpong_ops(struct dpu_hw_pingpong *c,
>  	c->ops.get_vsync_info = dpu_hw_pp_get_vsync_info;
>  	c->ops.setup_autorefresh = dpu_hw_pp_setup_autorefresh_config;
>  	c->ops.get_autorefresh = dpu_hw_pp_get_autorefresh_config;
> -	c->ops.poll_timeout_wr_ptr = dpu_hw_pp_poll_timeout_wr_ptr;
>  	c->ops.get_line_count = dpu_hw_pp_get_line_count;
>  	c->ops.setup_dsc = dpu_hw_pp_setup_dsc;
>  	c->ops.enable_dsc = dpu_hw_pp_dsc_enable;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
> index c00223441d99..cf94b4ab603b 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
> @@ -107,12 +107,6 @@ struct dpu_hw_pingpong_ops {
>  	bool (*get_autorefresh)(struct dpu_hw_pingpong *pp,
>  				u32 *frame_count);
>  
> -	/**
> -	 * poll until write pointer transmission starts
> -	 * @Return: 0 on success, -ETIMEDOUT on timeout
> -	 */
> -	int (*poll_timeout_wr_ptr)(struct dpu_hw_pingpong *pp, u32 timeout_us);
> -
>  	/**
>  	 * Obtain current vertical line counter
>  	 */
> 
