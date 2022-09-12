Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B545B611A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiILShe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiILShN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:37:13 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73A45FF0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 11:34:02 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id q21so16374965lfo.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 11:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=WBFC0enl7Kdm3LxkDybDNDvUcyCzmqG0ZR1rnJp8nzs=;
        b=xEr+wqs5d6LvcAz1810yjYdeBJeAzely+lM5quRFvED357xG88HBbvGHfhsd70zxRF
         VzYo3rnnsOnAXbvg/+KrU3BDD6Uj8702ccqO/IWmn7gcY0D1x4yGYaVL3h36lNM7fnNi
         Wj/aM39uba2ujmMKM+yGJNhIBsFAFy0V3uF6G75Cs5QEfRCVpNzyVk3Hl6vUHGFK9z5r
         Ch37h+MMqrkLoGovx4c4LWTzDIz2ZPuZhCJrHcPwkCfigsW9BM5VuYWxuaxjXG+W4NAC
         rTGZWppSDYHR9qxOa1M/hCw9prcnYXaG/TPNR33Sf/sRlazbCaqDQDwn6xBf5n1NItPX
         UmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WBFC0enl7Kdm3LxkDybDNDvUcyCzmqG0ZR1rnJp8nzs=;
        b=5w2itPhwTkbDZMcjdvW1RsKntfwAEaCW8ChoWD7twYrHGyAHuHeNdoQMH3fab7LNJU
         P8fraxL27FPKSu7xizYLYPqNfZJDppiHwIi4k1MyNh7E7rrPIekxpnY5Is+QUHGKCQ78
         rg3A/9bBZREXQmYn2gevnerID2eswUyxrJKk7Bm4JCBWFaeMvYTWGbHFJgSVit6vyL6J
         0i/a5Eowii4eqGiWutOFpKBaacnPN6uYYb0OLeVAdJI2uMDWBclSR8HtjriE7rZQ3Edw
         Q2ZHBGzQI6giaeJ3Mb53n1PeQTSu1JtsxbfKMmcLhh06GWUXBCIJmNr4IZZ0iYztaj+E
         R5FA==
X-Gm-Message-State: ACgBeo12e/0Fkgrk6TpzoKMz3Y9OJ2tv2YMbSl2iEe/GY2dRsow2lftL
        /5tKUNdsTpBidfe03Z9p9biLXg==
X-Google-Smtp-Source: AA6agR415pD+2UMDTHMqn8fWv/iakaLYMeVs19lx32S1epWhy4JjbpnN4r6gArVoI9OVNjcLy+gB2Q==
X-Received: by 2002:a05:6512:3b20:b0:498:d7bc:28af with SMTP id f32-20020a0565123b2000b00498d7bc28afmr7212017lfv.65.1663007641266;
        Mon, 12 Sep 2022 11:34:01 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id m5-20020a056512358500b0049482adb3basm1213636lfr.63.2022.09.12.11.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 11:34:00 -0700 (PDT)
Message-ID: <2656127d-383f-a359-3f34-b2f9053d1f2b@linaro.org>
Date:   Mon, 12 Sep 2022 21:34:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v5 2/3] drm/msm/dp: replace variable err with len at
 dp_aux_link_power_up()
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1662999830-13916-1-git-send-email-quic_khsieh@quicinc.com>
 <1662999830-13916-3-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1662999830-13916-3-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2022 19:23, Kuogee Hsieh wrote:
> drm_dp_dpcd_readb() will return 1 to indicate one byte had been read
> successfully. This patch replace variable "err" with "len" have more
> correct meaning.
> 
> changes in v5:
> -- split into 3 patches
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/dp/dp_link.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
> index 36f0af0..9d5381d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_link.c
> +++ b/drivers/gpu/drm/msm/dp/dp_link.c
> @@ -49,21 +49,21 @@ static int dp_aux_link_power_up(struct drm_dp_aux *aux,
>   					struct dp_link_info *link)
>   {
>   	u8 value;
> -	int err;
> +	ssize_t len;
>   
>   	if (link->revision < 0x11)
>   		return 0;
>   
> -	err = drm_dp_dpcd_readb(aux, DP_SET_POWER, &value);
> -	if (err < 0)
> -		return err;
> +	len = drm_dp_dpcd_readb(aux, DP_SET_POWER, &value);
> +	if (len < 0)
> +		return len;
>   
>   	value &= ~DP_SET_POWER_MASK;
>   	value |= DP_SET_POWER_D0;
>   
> -	err = drm_dp_dpcd_writeb(aux, DP_SET_POWER, value);
> -	if (err < 0)
> -		return err;
> +	len = drm_dp_dpcd_writeb(aux, DP_SET_POWER, value);
> +	if (len < 0)
> +		return len;
>   
>   	usleep_range(1000, 2000);
>   

-- 
With best wishes
Dmitry

