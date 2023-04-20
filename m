Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0EE6E9736
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjDTOeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjDTOeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:34:12 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F4A7DB4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:33:56 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2a8c28158e2so5553801fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682001235; x=1684593235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ofr40ek0G9BZfkBPDY70rNqEWnYDL1CgRLdFieoxIVY=;
        b=HYlmKc71wctRPq+LnqBHZDTdPLQxNak+gf4Z3CQg+nrr7Enfl+wK3NGELZIRMEADQm
         RawxDawGU8X+/+fQWqFG7cLDeWsNGxWAKLCUwZRPe5xGhy8bGAgJ7Hwzu1EF0Nrf/ci2
         B8QCh9uvlnvV8/neIeQT553iVGTFWGdfb+DO5RCKrLU+G4xNpaypDYHv4fKMzboen+LA
         0VIue93TzAVMS4oi/D9sIpLB23bPLEEKpyrf9E8Etz2am/z74+9nrxq3YEhQBhAmJ3ia
         /TixsC2+Lp0UutrMjZ1bc1HAJRwHrnL8f2pNF3VLF625ud+qnCzSZPOtL5t498Y2Nu7Y
         YXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682001235; x=1684593235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ofr40ek0G9BZfkBPDY70rNqEWnYDL1CgRLdFieoxIVY=;
        b=d5xHvx92dg0EFZZD+ElGjfJ1GlC8QPiZcPz7N8PQEammd2RMU9gUQQNSIHuKeBRGcl
         GeRTFGeRRnguA+slQ+cnPE0mJqCFoe8eKOKI4Jwxyag26S03nkoBqUG/IYqbHwCEKJhW
         Ed76nU5fg6wmenzHNLXnqZ0pUEqlAeSwB/4TpDHhOI6WVDUdAdmDlts4St+XjDhN5iI2
         9Rkc+Y2oiHU3tNR66RBgteq61rDB4Mb4yBhJA104G6n1/Af6tWyuAUTAzEWvqtJnhhoF
         7CK+1prfskSdXXFOUYvFvvmItNJmhahy0EIx2FWrai8nVdTV07EHdMG3hiDhZwnpUjy5
         DGgA==
X-Gm-Message-State: AAQBX9fSwbIlAnEIP86tHhVfaV45kvQOVjwC2IZh9GrNI0NovcHyydNA
        HNTmk487ChlC/b5ObKN0XsiveA==
X-Google-Smtp-Source: AKy350a1RnFHhnCb4nDHDUFDZEK3G1dY2NlIYfiSjSWKmf67vTEDnztfUAcirZhbgAH7loNvBK2aGw==
X-Received: by 2002:a19:ae0a:0:b0:4d7:44c9:9f4b with SMTP id f10-20020a19ae0a000000b004d744c99f4bmr451467lfc.1.1682001235170;
        Thu, 20 Apr 2023 07:33:55 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id v3-20020a197403000000b004dda87ecae3sm233446lfe.246.2023.04.20.07.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 07:33:54 -0700 (PDT)
Message-ID: <7ad86cd9-4b30-e7f1-780f-2c1c7093087e@linaro.org>
Date:   Thu, 20 Apr 2023 17:33:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/3] drm/msm/dpu: Drop unused members from HW structs
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230418-dpu-drop-useless-for-lookup-v1-0-b9897ceb6f3e@somainline.org>
 <20230418-dpu-drop-useless-for-lookup-v1-1-b9897ceb6f3e@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230418-dpu-drop-useless-for-lookup-v1-1-b9897ceb6f3e@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 02:14, Marijn Suijten wrote:
> Some of these members were initialized while never read, while others
> were not even assigned any value at all.  Drop them to save some space,
> and above all confusion when looking at these members.
> 
> Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
> Fixes: 84a33d0fd921 ("drm/msm/dpu: add dpu_hw_wb abstraction for writeback blocks")

The fixes headers are slightly questionable, as unused fields are not a 
bug. Nevertheless:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 1 -
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h | 1 -
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c | 1 -
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h | 2 --
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c   | 1 -
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h   | 5 -----
>   6 files changed, 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> index 84ee2efa9c66..a9c90249a6ac 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> @@ -374,7 +374,6 @@ struct dpu_hw_intf *dpu_hw_intf_init(enum dpu_intf idx,
>   	 */
>   	c->idx = idx;
>   	c->cap = cfg;
> -	c->mdss = m;
>   	_setup_intf_ops(&c->ops, c->cap->features);
>   
>   	return c;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> index 643dd10bc030..e07b2e33af3e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> @@ -90,7 +90,6 @@ struct dpu_hw_intf {
>   	/* intf */
>   	enum dpu_intf idx;
>   	const struct dpu_intf_cfg *cap;
> -	const struct dpu_mdss_cfg *mdss;
>   
>   	/* ops */
>   	struct dpu_hw_intf_ops ops;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
> index cf70a9bd1034..bb3ddec5c7d7 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
> @@ -812,7 +812,6 @@ struct dpu_hw_sspp *dpu_hw_sspp_init(enum dpu_sspp idx,
>   	}
>   
>   	/* Assign ops */
> -	hw_pipe->catalog = catalog;
>   	hw_pipe->ubwc = catalog->ubwc;
>   	hw_pipe->idx = idx;
>   	hw_pipe->cap = cfg;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
> index 74b98b6b3bc3..5004a02fd61e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
> @@ -341,7 +341,6 @@ struct dpu_hw_sspp_ops {
>    * struct dpu_hw_sspp - pipe description
>    * @base: hardware block base structure
>    * @hw: block hardware details
> - * @catalog: back pointer to catalog
>    * @ubwc: ubwc configuration data
>    * @idx: pipe index
>    * @cap: pointer to layer_cfg
> @@ -350,7 +349,6 @@ struct dpu_hw_sspp_ops {
>   struct dpu_hw_sspp {
>   	struct dpu_hw_blk base;
>   	struct dpu_hw_blk_reg_map hw;
> -	const struct dpu_mdss_cfg *catalog;
>   	const struct dpu_ubwc_cfg *ubwc;
>   
>   	/* Pipe */
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
> index 2d28afdf860e..db5e6040017f 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
> @@ -262,7 +262,6 @@ struct dpu_hw_wb *dpu_hw_wb_init(enum dpu_wb idx,
>   	}
>   
>   	/* Assign ops */
> -	c->mdp = &m->mdp[0];
>   	c->idx = idx;
>   	c->caps = cfg;
>   	_setup_wb_ops(&c->ops, c->caps->features);
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h
> index 3ff5a48541e2..b91923f879f1 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h
> @@ -76,15 +76,12 @@ struct dpu_hw_wb_ops {
>   /**
>    * struct dpu_hw_wb : WB driver object
>    * @hw: block hardware details
> - * @mdp: pointer to associated mdp portion of the catalog
>    * @idx: hardware index number within type
>    * @wb_hw_caps: hardware capabilities
>    * @ops: function pointers
> - * @hw_mdp: MDP top level hardware block
>    */
>   struct dpu_hw_wb {
>   	struct dpu_hw_blk_reg_map hw;
> -	const struct dpu_mdp_cfg *mdp;
>   
>   	/* wb path */
>   	int idx;
> @@ -92,8 +89,6 @@ struct dpu_hw_wb {
>   
>   	/* ops */
>   	struct dpu_hw_wb_ops ops;
> -
> -	struct dpu_hw_mdp *hw_mdp;
>   };
>   
>   /**
> 

-- 
With best wishes
Dmitry

