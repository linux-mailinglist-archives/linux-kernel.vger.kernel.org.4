Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BE974191A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjF1Ty3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjF1TyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:54:24 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69561FD8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:54:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbac9dd8ebso3537495e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687982061; x=1690574061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/1WCRqInbEQkf2duMLeRlZtPpMeZ3I2eJEdWnZJEsE=;
        b=wiPuQnqHresP/hP0AhH1LIlgDRlJXchiEYdcoJEDzHt+UEmeFgraxKndgHVw2OY4aR
         4HUeN7Jck9SA3LDs7HeM7rY382ov4iowO5DNF9tkJk8C0LAfThHl2opwboerfshAvRcy
         iTVg/XJEfYET1X0VT8BFLN73IoV0I0h9W4VNlxOEApz0pU9MYDaS+dXuWtGLPG2YkKtA
         cQWE+2GWR4RbF7YmvjlnJ6+yd9RzhRVt+buHpFXgq8o78DUxox9bdD3kPJPvRDScCYrf
         pjoi1g3TTAJlC8Q9ufWLwix5Vek1E+ehCKgCB/y/cXspQICa+BVJAxHFblMY3rh8nBch
         c3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687982061; x=1690574061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/1WCRqInbEQkf2duMLeRlZtPpMeZ3I2eJEdWnZJEsE=;
        b=AIV1fXEQbUc+jG3c/G7y5XB9Z3B3FHelK4kGD3GtEs/DjvRpnWQt+UWrgEVwAeogZI
         d8RFdO3wEbN2LJR6DGj+X275h6uqvkASLkifsDgokQQTtQU4W09dQwe3GjRebyssFtqo
         UoDpqf9snKXTYIP8L2WbLT48+ufezmJgSOyifnkslECpIBGPAfchg1ScdfaG/RvDxW8g
         OT7yZiPaP/g4gult1rMDgNAA5d4vTDTTjqzz4+4vloFjDpDyqGObv7W4QzkRgT1xII2d
         H6NxBaExyTHetcoie6RX2jrBBifQc9Duz6N5itdktHuN98EM1RMtcWXamHhoRK7R+4hG
         dcqA==
X-Gm-Message-State: AC+VfDz8X1PUtZ4q9uxL/6g4TSdGpcSImtI+7qJD+yoEsUOQWiBNUJZQ
        aznq3O0WYtOyYNHlwzg2ElHRjg==
X-Google-Smtp-Source: ACHHUZ4W+0A/p+ZwDwpOl46I6quIlwSWSeRsQ9uhmc+nS4yPI9mGFeGKCLwc1djZ2BtqVpoSvJ2zRQ==
X-Received: by 2002:a05:600c:2041:b0:3fa:7808:3e16 with SMTP id p1-20020a05600c204100b003fa78083e16mr12935716wmg.29.1687982061246;
        Wed, 28 Jun 2023 12:54:21 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x9-20020a05600c21c900b003fb41491670sm7241386wmj.24.2023.06.28.12.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 12:54:20 -0700 (PDT)
Message-ID: <ef074384-1eee-ec88-b02f-c4ada72037a4@linaro.org>
Date:   Wed, 28 Jun 2023 22:54:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/msm/adreno: Assign revn to A635
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230628-topic-a635-v1-1-5056e09c08fb@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230628-topic-a635-v1-1-5056e09c08fb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2023 22:05, Konrad Dybcio wrote:
> Recently, a WARN_ON() was introduced to ensure that revn is filled before
> adreno_is_aXYZ is called. This however doesn't work very well when revn is
> 0 by design (such as for A635). Fill it in as a stopgap solution for
> -fixes.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

I'd have probably added:

Fixes: cc943f43ece7 ("drm/msm/adreno: warn if chip revn is verified 
before being set")

or

Fixes: 192f4ee3e408 ("drm/msm/a6xx: Add support for Adreno 7c Gen 3 gpu")


> ---
>   drivers/gpu/drm/msm/adreno/adreno_device.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index cb94cfd137a8..8ea7eae9fc52 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -345,6 +345,7 @@ static const struct adreno_info gpulist[] = {
>   		.address_space_size = SZ_16G,
>   	}, {
>   		.rev = ADRENO_REV(6, 3, 5, ANY_ID),
> +		.revn = 635,
>   		.fw = {
>   			[ADRENO_FW_SQE] = "a660_sqe.fw",
>   			[ADRENO_FW_GMU] = "a660_gmu.bin",
> 
> ---
> base-commit: 5c875096d59010cee4e00da1f9c7bdb07a025dc2
> change-id: 20230628-topic-a635-1b3c2c987417
> 
> Best regards,

-- 
With best wishes
Dmitry

