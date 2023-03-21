Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA07F6C34D3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjCUOy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjCUOy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:54:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0052683
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:54:54 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bi9so19442060lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679410493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ogeDtQxSnugT0CZDT5b7rsm/nGwv+3iZej0+faCrhgc=;
        b=qndJwjvRKfP1GJepXrzReRb1vab2cTNz5YnEt1TC/Tg/PbnpqZhsfvbJxvG5wCgMrx
         RkEwJnIiciSh3KcgX4mufCfsUkCH+ARU/fPnn/4xb3orIZDKj7srsep5BooM+vTMvxqp
         K5AgKQYcpRMJOuARYHeX1fPBLIJi3jmD1XT3V0bIMzrlSEvQNn9npdSfz8ZCQh2+dEDT
         8zsJBxxhQjOIUpNsA6HMNUrLAfAVRFNr1hucfEaxnOWD/CbMzmolY46VK1rsMV+Lvv6V
         RN4iy1+9oJBgv+Dn2Gtf1XKMB/RNwEG4FmNwbLW4QBLTkUIo2zXl8mz9x+eHps1cI0+m
         fyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679410493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ogeDtQxSnugT0CZDT5b7rsm/nGwv+3iZej0+faCrhgc=;
        b=SZViEI4o7N0+qoy2FS2mkWyAtgg9HfnaMqRuMNoAsRfnmaz8NpvqHU1RoHaGwHSn26
         84h+kY9pk2KXVv6MTzsOs3ycUzsWI0ISUBfflbL+nskQFEEfwwLdZ3wUB+UyNZQSuSVW
         tmDKhaEinwvl4rI0HsDpetcOXB/K4oxKJpPNsKDs5TvPjF/rNWBG6uQWCdm6FaH0fL1T
         YEPIhdwMWnnddqIidY8celN+UaFqPjfHE6zBZ8NsRAMThs3IMkSj/hM80fC4iO3UyF0s
         oVgqDgye+74llkU3pAEtdZUZmIBPKwoMWEhqUwrU1j30DM6jY6oc3ZVcttBsvn9NdqaQ
         LFsw==
X-Gm-Message-State: AO0yUKUNSJ3gs7nx8pM0ULvB6hHG3TRcXWfWk9fKRw/UczqwNWUAIjM9
        F2KBIcj3nmJt+Oa30pE00G1LpQ==
X-Google-Smtp-Source: AK7set+/WVYm+A8eXtH36OMEaLnPPDDi8Ho/QLT8GgYmP7FzUIPufQLjoc+9Pj51zOpwDSMZl/HLCg==
X-Received: by 2002:ac2:5f16:0:b0:4dd:a4e1:4869 with SMTP id 22-20020ac25f16000000b004dda4e14869mr928315lfq.43.1679410492792;
        Tue, 21 Mar 2023 07:54:52 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id j19-20020a19f513000000b004e84b79de9bsm2205925lfb.254.2023.03.21.07.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 07:54:52 -0700 (PDT)
Message-ID: <90264695-131e-46b7-46db-822b0aee9801@linaro.org>
Date:   Tue, 21 Mar 2023 16:54:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 05/10] drm/msm: fix drm device leak on bind errors
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230306100722.28485-1-johan+linaro@kernel.org>
 <20230306100722.28485-6-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230306100722.28485-6-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 12:07, Johan Hovold wrote:
> Make sure to free the DRM device also in case of early errors during
> bind().
> 
> Fixes: 2027e5b3413d ("drm/msm: Initialize MDSS irq domain at probe time")
> Cc: stable@vger.kernel.org      # 5.17
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Can we migrate to devm_drm_dev_alloc instead() ? Will it make code 
simpler and/or easier to handle?

> ---
>   drivers/gpu/drm/msm/msm_drv.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 2f2bcdb671d2..89634159ad75 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -444,12 +444,12 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
>   
>   	ret = msm_init_vram(ddev);
>   	if (ret)
> -		return ret;
> +		goto err_put_dev;
>   
>   	/* Bind all our sub-components: */
>   	ret = component_bind_all(dev, ddev);
>   	if (ret)
> -		return ret;
> +		goto err_put_dev;
>   
>   	dma_set_max_seg_size(dev, UINT_MAX);
>   
> @@ -544,6 +544,12 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
>   
>   err_msm_uninit:
>   	msm_drm_uninit(dev);
> +
> +	return ret;
> +
> +err_put_dev:
> +	drm_dev_put(ddev);
> +
>   	return ret;
>   }
>   

-- 
With best wishes
Dmitry

