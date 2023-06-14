Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AF372FDC4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbjFNMCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbjFNMCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:02:03 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683ECA7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:02:02 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f6255ad8aeso8488982e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686744120; x=1689336120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=APFMvQ7ODanIJV/49mozRJR24EjLchmIY1aNYth0n0A=;
        b=cTE7StskKa1gOaN7Q4vGHXf7JziI+921scTA1Z61XuufieMoN+Trr9ZQ3pSAeRV9kQ
         fuWWvXmT8uxLNssEsSF0r6cJQE5YwKJX79SJAahFrtogD0kzcxNFvshgApQn1+He74TY
         NBAUeTr/VEIAq2IJ4OBAPpm1ijZIYWLtssBGvtnRXUyALHFQWAtwqQBw8z2NHDUe193U
         XAzCGOun/DCYIp2+uZ79CwN6kthVUm9oNNBZOyRoxkO6A/KFszlfmyfYpWDIlHsWjJGB
         qm6iE1owS5MD7z8NHdozhaCLxjreKzzcr3HB7murAFsjKmevtaYAxo4hRkA1lsmj4YHZ
         B41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686744120; x=1689336120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=APFMvQ7ODanIJV/49mozRJR24EjLchmIY1aNYth0n0A=;
        b=hR5Wsg+WhJQGccQLfbyY+4TuUwIxhoE2D0PsqROokf5sr4iDamu5gnT4NF+Ww6oZVK
         OZYYBt30C1qnVbcf4X8kjn4FhLIyQND3hBWJcAz3hxQ1T2wQEVdPzv/u2VoN9ag5m7Ao
         T8lNJqNQBxfzEKw1ILmrFHzEx2zXjB+Agpqbk/wCdRquNoBBYFi2fMNcbZ7rDx43E7SU
         E1RrXCgHYWC2BD1AN1MFzhZn/ItB6bS5So43esj6LvBPBSaWXS+CPxOMYvKGmEphXcLq
         AKA/RxZnIa/QHoIUvpBr1mGKz8ILF2iZqrb8TKXBXZWAGcAV3mGI9nXyIF8O4vAcSmNf
         0nlA==
X-Gm-Message-State: AC+VfDzIxG+00S92yWw4a6KiWSB5zbC02lCdmxdvpuGfUAJwzj6ix6ow
        CcBB/ZQmnvhKr3ewIIiseTyMZA==
X-Google-Smtp-Source: ACHHUZ4rNTYSmY8dJMj9rW18QV3jmWIGNjGK3rX385cmsN6Bsiry3yG0eLvhyGVb2+zuGkVHDiUiCQ==
X-Received: by 2002:ac2:4d9b:0:b0:4f3:a61d:19d2 with SMTP id g27-20020ac24d9b000000b004f3a61d19d2mr7414911lfe.36.1686744120599;
        Wed, 14 Jun 2023 05:02:00 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id f2-20020ac251a2000000b004f62229b6c1sm2099072lfk.252.2023.06.14.05.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 05:01:59 -0700 (PDT)
Message-ID: <f4fb042c-1458-6077-3c49-8cc02638b27c@linaro.org>
Date:   Wed, 14 Jun 2023 15:01:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] drm/msm/dpu: Add DPU_INTF_DATABUS_WIDEN feature flag
 for DPU >= 5.0
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, quic_abhinavk@quicinc.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230525-add-widebus-support-v1-0-c7069f2efca1@quicinc.com>
 <20230525-add-widebus-support-v1-1-c7069f2efca1@quicinc.com>
 <wpjxrnhbcanbc5iatxnff25yrrdfrtmgb24sgwyo457dz2oyjz@e2docpcb6337>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <wpjxrnhbcanbc5iatxnff25yrrdfrtmgb24sgwyo457dz2oyjz@e2docpcb6337>
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

On 14/06/2023 14:42, Marijn Suijten wrote:
> On 2023-06-13 18:57:11, Jessica Zhang wrote:
>> DPU 5.x+ supports a databus widen mode that allows more data to be sent
>> per pclk. Enable this feature flag on all relevant chipsets.
>>
>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 3 ++-
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 2 ++
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> index 36ba3f58dcdf..0be7bf0bfc41 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> @@ -103,7 +103,8 @@
>>   	(BIT(DPU_INTF_INPUT_CTRL) | \
>>   	 BIT(DPU_INTF_TE) | \
>>   	 BIT(DPU_INTF_STATUS_SUPPORTED) | \
>> -	 BIT(DPU_DATA_HCTL_EN))
>> +	 BIT(DPU_DATA_HCTL_EN) | \
>> +	 BIT(DPU_INTF_DATABUS_WIDEN))
> 
> This doesn't work.  DPU 5.0.0 is SM8150, which has DSI 6G 2.3.  In the
> last patch for DSI you state and enable widebus for DSI 6G 2.5+ only,
> meaning DPU and DSI are now desynced, and the output is completely
> corrupted.
> 
> Is the bound in dsi_host wrong, or do DPU and DSI need to communicate
> when widebus will be enabled, based on DPU && DSI supporting it?

I'd prefer to follow the second approach, as we did for DP. DPU asks the 
actual video output driver if widebus is to be enabled.

> 
> - Marijn
> 
>>   #define INTF_SC7280_MASK (INTF_SC7180_MASK | BIT(DPU_INTF_DATA_COMPRESS))
>>   
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
>> index b860784ade72..b9939e00f5e0 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
>> @@ -182,6 +182,7 @@ enum {
>>    *                                  than video timing
>>    * @DPU_INTF_STATUS_SUPPORTED       INTF block has INTF_STATUS register
>>    * @DPU_INTF_DATA_COMPRESS          INTF block has DATA_COMPRESS register
>> + * @DPU_INTF_DATABUS_WIDEN          INTF block has DATABUS_WIDEN register
>>    * @DPU_INTF_MAX
>>    */
>>   enum {
>> @@ -190,6 +191,7 @@ enum {
>>   	DPU_DATA_HCTL_EN,
>>   	DPU_INTF_STATUS_SUPPORTED,
>>   	DPU_INTF_DATA_COMPRESS,
>> +	DPU_INTF_DATABUS_WIDEN,
>>   	DPU_INTF_MAX
>>   };
>>   
>>
>> -- 
>> 2.40.1
>>

-- 
With best wishes
Dmitry

