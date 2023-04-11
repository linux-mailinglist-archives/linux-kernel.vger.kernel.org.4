Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144C16DE71D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 00:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjDKWRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 18:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDKWRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 18:17:21 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FF44493
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 15:17:20 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id r27so12328956lfe.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 15:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681251439; x=1683843439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZyUOASgExhF30LjNQ41eGkCS/vfjzdSaSnhxhM63Ck=;
        b=lcvg1vWS/bkdJlOWf8z6hh5bj/Yu9IFc5rBB2HZ4EcdOWmSBi1qepkWi+zVad/LQKx
         E50NrOUdnoXoPbrWK0/4ji5eBoH4RJCfKrhORZnFVp1h0nAqldt04QZS4WqeQ6/wicww
         LwHNnB3fi3NcOIhg4n6VD1mL01c9M32Xc6yApX8akulyI3b+aklUynPu1124W1qOzIlD
         NLbNFWVac8pZjaxqvhPTvWhANWtBlt4EdexU6Eur0CrqluwNLj370L/jVL7IKfqGqjLg
         DIsY6358PgeDbx/rntImSIywdOQyaNSMD1ITbNfLGOnIH7BRUbNsufWgpAjdFDnU0VOy
         WgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681251439; x=1683843439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZyUOASgExhF30LjNQ41eGkCS/vfjzdSaSnhxhM63Ck=;
        b=7UTh8DLuQkiDiE+FbqzFjN6FF9b53ACRvaflAzml9c1/7MqQiRO74x8+w/T3u68O/q
         agEPt/lst0M0wCSDNTNLrUYkh7gFhzyfGA1lOc3+SJWIAOSTiwLB5k0ChvLowtKqGcLX
         sYzF3cIVmwbysbqA8+ht84NS3oNaZbGFrCR2i220mwzhPvO0ckewr5IXLrHbKqxm46qY
         ZMb+GfAkrxKMDygrYXSNcOJ80q+4+NP4/O9K46SWt5eixtlfVUavI779mVhxKiwCXE+m
         QwtZfIoN4jYvaigGdetpjqmaunTVLjsXNVP3fL0DMZxuUhosyXr8+hIhaRYqofEp6049
         j1hQ==
X-Gm-Message-State: AAQBX9dvCSUmpL7DmfG6A1tAK2FdZqwbVxTajaw7P+RrXSBWqsVekqi/
        ZKNX0BKrjaYjR0VWXUvkQckIfw==
X-Google-Smtp-Source: AKy350ZBOK0SaKJPGnFnIZHsueajzDe6qTwVnM7E1/+6bHqNmgIm8oaBqfNP7Q6f05CXQ1eplHfRAQ==
X-Received: by 2002:ac2:55a4:0:b0:4ec:857d:9c94 with SMTP id y4-20020ac255a4000000b004ec857d9c94mr36989lfg.15.1681251439037;
        Tue, 11 Apr 2023 15:17:19 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id o28-20020ac2495c000000b004eb0eafaa02sm2709428lfi.243.2023.04.11.15.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 15:17:18 -0700 (PDT)
Message-ID: <30585d08-88ca-e3a9-6f83-128d49d1d1fc@linaro.org>
Date:   Wed, 12 Apr 2023 01:17:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/msm/dpu: always program dsc active bits
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1681247095-1201-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1681247095-1201-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 00:04, Kuogee Hsieh wrote:
> In current code, the dsc active bits are set only if the cfg->dsc is set.
> However, for displays which are hot-pluggable, there can be a use-case
> of disconnecting a DSC supported sink and connecting a non-DSC sink.
> 
> For those cases we need to clear DSC active bits during teardown.

Please correct me if I'm wrong here, shouldn't we start using 
reset_intf_cfg() during teardown / unplug?

> 
> Fixes: ede3c6bb00c ("drm/msm/disp/dpu1: Add DSC support in hw_ctl")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> index bbdc95c..88e4efe 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> @@ -541,10 +541,9 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
>   	if (cfg->merge_3d)
>   		DPU_REG_WRITE(c, CTL_MERGE_3D_ACTIVE,
>   			      BIT(cfg->merge_3d - MERGE_3D_0));
> -	if (cfg->dsc) {
> -		DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, DSC_IDX);
> -		DPU_REG_WRITE(c, CTL_DSC_ACTIVE, cfg->dsc);
> -	}
> +
> +	DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, DSC_IDX);
> +	DPU_REG_WRITE(c, CTL_DSC_ACTIVE, cfg->dsc);
>   }
>   
>   static void dpu_hw_ctl_intf_cfg(struct dpu_hw_ctl *ctx,

-- 
With best wishes
Dmitry

