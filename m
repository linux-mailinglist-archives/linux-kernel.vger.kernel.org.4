Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547F86FEAEF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 06:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbjEKEtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 00:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbjEKEtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 00:49:33 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6059230E5
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 21:49:32 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2ac88d9edf3so76697021fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 21:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683780570; x=1686372570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bZ9AhqKlVvzatdS2kcgWF/IaWlcFPC4v3tJjLb2boYI=;
        b=nEvNWB8B7X/36cLkVIoBoXpfEo6kJh0NVVtYCUiVQJqbE6RuoQWAf3wDgAeRpWx9Up
         jVobxFlnDGZo8Ij3mkI8DnURZ4kxmrpSXjBQSGgQeh8E+ABR9f3qbXfz/2HZik3SsH1Z
         fXG1JEmu12fuetkE+NYKl/PFcceUOCavhaMsTZgU3sbjNMqYkd3C/BwsclNfltsY+SA9
         7Q7bjn9pNvnJbdq2Z09nAeusTAc8upZfw6XNy5NuDfYA3IMPtCQ6G2JWOJm8chP7ssZU
         ePGp1PHzYEfuSUExePcRulnRrGOoepVfQDs0O0wk++boEYDch/QKr68+2Ibmz2bmmW1w
         KJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683780570; x=1686372570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZ9AhqKlVvzatdS2kcgWF/IaWlcFPC4v3tJjLb2boYI=;
        b=GbTgsykVUFG8kY5bILef1aTbXlgVw2qnV4Op5LfziXx7OJZNuMh8HYx5qWuVc8X9cH
         3474rW5EcumROv/uhk/0DHDjzH5PdgrbPewjQifkGb+oWjAdXu1Qpx366QJ+egqjhuxL
         xyUwG06nmhEIh60sqy2rSrWhqlb5nj+2OEBgX5POl/R5BnNXDziEE01M5vkJwxsBxgE+
         qpDZmViW/gNVQVBueccSzmc6FLt6ITFfNr4tPsQi+lFk+XI4u3INvzak52i21QBrqIo0
         v2w2DCvr+v11jE75nRtA1/PyDZTnbHbm8kCF5W0J2D6KtYU+Gxmc+1R6QI1M4+xKoaFq
         qpaQ==
X-Gm-Message-State: AC+VfDy+rVWygxMWJYbvTefLykzUeCBHJK7z1dgfRocrb1t8WaF0TDJb
        Dsdj+XTTmNyuPzHBkP07OvAiTw==
X-Google-Smtp-Source: ACHHUZ5qVfCYkX9lmLG1FWFiEjchXdtKT1t8ljth+JrKg+JUwNKJoOcWuAcaLO7MYxRP5c1C/Z7tdA==
X-Received: by 2002:a2e:b0cc:0:b0:2ac:8486:e318 with SMTP id g12-20020a2eb0cc000000b002ac8486e318mr2898519ljl.35.1683780570666;
        Wed, 10 May 2023 21:49:30 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id v4-20020a197404000000b004f01ae1e63esm961363lfe.272.2023.05.10.21.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 21:49:30 -0700 (PDT)
Message-ID: <575d9fb6-15c4-1faf-8457-c5ae3f99895c@linaro.org>
Date:   Thu, 11 May 2023 07:49:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 2/8] drm/msm/dpu: add DPU_PINGPONG_DSC feature bit for
 DPU < 7.0.0
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1683756453-22050-1-git-send-email-quic_khsieh@quicinc.com>
 <1683756453-22050-3-git-send-email-quic_khsieh@quicinc.com>
 <b4438422-f24b-7fc1-18cf-3cebdd777530@linaro.org>
 <1a6109ae-7c83-c04e-60c9-dfca6b83d662@quicinc.com>
 <a6146d03-18d1-b1c6-cdbb-d3527cb9021a@linaro.org>
 <ff0a7628-b9e2-d5f5-cb1e-678ea25ec1cb@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <ff0a7628-b9e2-d5f5-cb1e-678ea25ec1cb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 07:42, Abhinav Kumar wrote:
> 
> 
> On 5/10/2023 9:39 PM, Dmitry Baryshkov wrote:
>> On 11/05/2023 07:38, Abhinav Kumar wrote:
>>>
>>>
>>> On 5/10/2023 9:29 PM, Dmitry Baryshkov wrote:
>>>> On 11/05/2023 01:07, Kuogee Hsieh wrote:
>>>>> DPU < 7.0.0 requires the PINGPONG block to be involved during
>>>>> DSC setting up. Since DPU >= 7.0.0, enabling and starting the DSC
>>>>> encoder engine moved to INTF with the help of the flush mechanism.
>>>>
>>>> Nit: was moved.
>>>>
>>>>> Add a DPU_PINGPONG_DSC feature bit to restrict the availability of
>>>>> dpu_hw_pp_setup_dsc() and dpu_hw_pp_dsc_{enable,disable}() on the
>>>>> PINGPONG block to DPU < 7.0.0 hardware, as the registers are not
>>>>> available [in the PINGPONG block] on DPU 7.0.0 and higher anymore.
>>>>
>>>> this looks good
>>>>
>>>>> Existing call-sites to these callbacks already skip calling into
>>>>> them if the function pointer is NULL.
>>>>
>>>> This is more relevant for patch 3 commit message.
>>>>
>>>>> Add DPU_PINGPONG_DSC feature
>>>>> bit to all chipset with DPU < 7.0.0.
>>>>
>>>> This is incorrect, as we do not change the catalog in this patch.
>>>>
>>>
>>> Sorry but why not? The changes done to dpu_hw_catalog.c do exactly that.
>>
>> Because the patch does not add this feature bit to any of the 
>> chipsets. I think the relevant patch was lost somewhere during the 
>> rework/rebase.
>>
>>
>>
> 
> This is adding it right?
> 
>    #define PINGPONG_SDM845_MASK \
> -    (BIT(DPU_PINGPONG_DITHER) | BIT(DPU_PINGPONG_TE))
> +    (BIT(DPU_PINGPONG_DITHER) | BIT(DPU_PINGPONG_TE) | 
> BIT(DPU_PINGPONG_DSC))
>    #define PINGPONG_SDM845_TE2_MASK \


Ah, I see now. I was expecting changes to the actual catlog files. 
Please excuse me.

As we are using PINGPONG_SDM845_MASK only up to and including DPU 6.x, 
this is correct.

I'd then suggest rephrasing this sentence to be more explicit:

Add DPU_PINGPONG_DSC to PINGPONG_SDM845_MASK, which is used for all DPU 
< 7.0 chipsets.

-- 
With best wishes
Dmitry

