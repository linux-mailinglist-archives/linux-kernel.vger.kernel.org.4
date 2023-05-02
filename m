Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8B06F4C0A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 23:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjEBVUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 17:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjEBVUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 17:20:16 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85251735
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 14:19:50 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f0108a7d20so5053926e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 14:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683062389; x=1685654389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YL0HTP2hogruEK5o6822RwsE/FsRfHqk/sZ5fYBkYpY=;
        b=qkxU8X69WCmYeF26b5A6eJHBpvj9iG5fHaRF07ui9uPjUJiuoCJeXA4Nmx5nnfbFS2
         OzMme+hOaQjL0WjgbUnLjvfFKC214yPVZ3J/k8meWEGph4ZFHHD6rW8WIFnbb3bBLwCg
         7xsWgZcCE9rDFVs6nJKvU5gUjGNbZhJtiQqY4B1tZqkNaRibRC3EN3dL39etfGKaimUL
         cwyPP/Y06buZzkR77qMWwRXyZCLqtjFcCbT/vah9b6ilQ/Y79rfZVMtuI7HbwlUhMWKY
         aWv1KOGd1/kHuSvkrcR9Uv0hQ/AJbmhTqT/Oww0djRU2p+E005cQaBuBj/74jaQtxD1+
         wlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683062389; x=1685654389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YL0HTP2hogruEK5o6822RwsE/FsRfHqk/sZ5fYBkYpY=;
        b=j5nKqNe3DGr1yXf75YtkEmQryU1hP5wqlk0NDYYuES5VFZbs9yxuk20OZp2NI0+cVD
         xHX7lNx8zlzmG1ejlIm68SQZ9eLuO6c9dTQ9cbQXKNmJNwSFIBrVxMuXhBbYH9mv/uZp
         96R0iWDC2q4BAmBlhYkMb9R3tyEld2yth0cT+XFyzrqZcZEevyJZH1mPEroJL+A3qlPD
         z0AId3DQR4kExIOqA4iROLCnpByaAQoD3/B8nis0MhQiteXN2mQzrnDjznuBLy6winta
         bpBosNMDDCAXwNHou5O9LeIWoIz4Iet2ex14nk+MfL+zxaOB9zc12ynucmN0gq95alf7
         oStA==
X-Gm-Message-State: AC+VfDyIJCQX33tS4QQL5qTZLeKHaYy6vj93pgViFLyADUXKr0cGHbOP
        tWVvLzQ7kRirY6pvyYYkzHXnrQ==
X-Google-Smtp-Source: ACHHUZ7K353thxP/m/nJc6hXiu7I5BesEV/LnUXH2Py/TJOLlivtli2tg/ZZSu2NGgk22wQz0FACJw==
X-Received: by 2002:a05:6512:3750:b0:4ed:bf01:3ff3 with SMTP id a16-20020a056512375000b004edbf013ff3mr284376lfs.43.1683062388893;
        Tue, 02 May 2023 14:19:48 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id o8-20020ac24948000000b004f121c8beddsm1158666lfi.124.2023.05.02.14.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 14:19:48 -0700 (PDT)
Message-ID: <0aba48f3-b877-3d67-85a6-f71ba0a56495@linaro.org>
Date:   Wed, 3 May 2023 00:19:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/7] drm/msm/dpu: add DPU_PINGPONG_DSC feature bit
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1683061382-32651-1-git-send-email-quic_khsieh@quicinc.com>
 <1683061382-32651-3-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1683061382-32651-3-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2023 00:02, Kuogee Hsieh wrote:
> Legacy DPU requires PP block to be involved during DSC setting up.
> This patch adds DDPU_PINGPONG_DSC feature bit to indicate that both

DPU_PINGPONG_DSC

> dpu_hw_pp_setup_dsc() and dpu_hw_pp_dsc_enable() pingpong ops
> functions are required to complete DSC data path set up and start
> DSC engine.

Nit: as these ops were already present, I'd say that the lack of the 
flag means that these operations are not supported and must not be 
called for DSC setup/teardown.

Nevertheless:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> Reported-by : Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h  | 2 ++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c | 9 ++++++---
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index 71584cd..c07a6b6 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -144,6 +144,7 @@ enum {
>    * @DPU_PINGPONG_SPLIT      PP block supports split fifo
>    * @DPU_PINGPONG_SLAVE      PP block is a suitable slave for split fifo
>    * @DPU_PINGPONG_DITHER,    Dither blocks
> + * @DPU_PINGPONG_DSC,	    PP ops functions required for DSC
>    * @DPU_PINGPONG_MAX
>    */
>   enum {
> @@ -152,6 +153,7 @@ enum {
>   	DPU_PINGPONG_SPLIT,
>   	DPU_PINGPONG_SLAVE,
>   	DPU_PINGPONG_DITHER,
> +	DPU_PINGPONG_DSC,
>   	DPU_PINGPONG_MAX
>   };
>   
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> index 3822e06..f255a04 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> @@ -264,9 +264,12 @@ static void _setup_pingpong_ops(struct dpu_hw_pingpong *c,
>   	c->ops.get_autorefresh = dpu_hw_pp_get_autorefresh_config;
>   	c->ops.poll_timeout_wr_ptr = dpu_hw_pp_poll_timeout_wr_ptr;
>   	c->ops.get_line_count = dpu_hw_pp_get_line_count;
> -	c->ops.setup_dsc = dpu_hw_pp_setup_dsc;
> -	c->ops.enable_dsc = dpu_hw_pp_dsc_enable;
> -	c->ops.disable_dsc = dpu_hw_pp_dsc_disable;
> +
> +	if (features & BIT(DPU_PINGPONG_DSC)) {
> +		c->ops.setup_dsc = dpu_hw_pp_setup_dsc;
> +		c->ops.enable_dsc = dpu_hw_pp_dsc_enable;
> +		c->ops.disable_dsc = dpu_hw_pp_dsc_disable;
> +	}
>   
>   	if (test_bit(DPU_PINGPONG_DITHER, &features))
>   		c->ops.setup_dither = dpu_hw_pp_setup_dither;

-- 
With best wishes
Dmitry

