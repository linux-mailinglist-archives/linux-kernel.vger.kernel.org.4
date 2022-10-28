Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864B461115F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiJ1M3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJ1M3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:29:35 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B0E60E3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 05:29:29 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a15so8155911ljb.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 05:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xhh2GfNPqccqHt9z7S0/T4lVRI1pm6I0GIyqBlDEE6Q=;
        b=Gv3mhdHv4vTqTawNHz1Bsh6DyvFILad7+MCdXJ/Kg9Hu8zE08m6fZ8RGYRwg76Qt7h
         xiVKcxSf9tQQxNOF007MpB2BTQUVbn3dCwuaS2V+PFtS2nPi0x0fe7DPKouC0o8+IPtF
         aKKWJX/UxIDkAf7/FTMYLYItVomf7DtW17XMYNjmxuMmB6cerpTlO1ofsONDt2eJoXSR
         peDoWokbyIryddPi1EUHNAj8obcrkfrzSmbmaEYDSy8nNcGWxisgLP0d77xdEaUIfyjX
         AC5eXEc1PmLjCOg7c3rOVB0LocXqV6ephnuD692n+5j0VW3Kfs6fluKoG3wpY47ezLvl
         cluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xhh2GfNPqccqHt9z7S0/T4lVRI1pm6I0GIyqBlDEE6Q=;
        b=MQQv0rYqFtdUA4njlImqdnu4wi5yro32S067TFKPLDsWjCHrzfH4rILZfHxJTyKCu6
         w/1eE89EczrBKbukMkk1kebk230UeEZ3cEZ160mN4aWeGG8o3srYpRWRg+yYErIlz4dQ
         5CoiXSJ8eRU9MXVt7MiN10Y9PEFKRkYiS8x7kR4KfyL1ij7zdYFi8u/M2Cv0U8YnBmUs
         kRNRrrPaQAl2ie0ug5ccwjZ3AA3yvinIQyGix3Kl9XaIlWlxPRg8+7IYxEZOBvIGsLkW
         BKRa4H0b+4jL1x6wg9agmPnsqLG8DyuBbaJ+hxjVeJJ3HpCW60MKByoYR3takvkqmTkS
         Sstg==
X-Gm-Message-State: ACrzQf04ze0EWKbP410Fy/UhsFgp9Nkim2QP70bnGwnR+g1bXcxs/NpT
        QDIvxA2SRIDZtuRP/myrDWtTdQ==
X-Google-Smtp-Source: AMsMyM4cqflCH7VKbXl6GhfGyt9BzQJBZMw3rl9thrFiCIpESo5T+Xin/zo7hOdtAxup19xhLpLF2w==
X-Received: by 2002:a05:651c:111:b0:277:2451:816c with SMTP id a17-20020a05651c011100b002772451816cmr4467514ljb.17.1666960167619;
        Fri, 28 Oct 2022 05:29:27 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id z10-20020a05651c11ca00b00277074c12ddsm621018ljo.125.2022.10.28.05.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 05:29:27 -0700 (PDT)
Message-ID: <09a049cc-0514-2db3-0e8b-ff3dfa61d585@linaro.org>
Date:   Fri, 28 Oct 2022 15:29:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v1 1/9] drm/msm: Add compatibles for SM8350 display
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Robert Foss <robert.foss@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        airlied@linux.ie, daniel@ffwll.ch, quic_kalyant@quicinc.com,
        swboyd@chromium.org, angelogioacchino.delregno@somainline.org,
        loic.poulain@linaro.org, quic_vpolimer@quicinc.com,
        vkoul@kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Jonathan Marek <jonathan@marek.ca>, vinod.koul@linaro.org,
        quic_jesszhan@quicinc.com
References: <20221028120812.339100-1-robert.foss@linaro.org>
 <20221028120812.339100-2-robert.foss@linaro.org>
 <0f8e73f6-d005-7e0b-ba38-c4d0161c1acd@linaro.org>
In-Reply-To: <0f8e73f6-d005-7e0b-ba38-c4d0161c1acd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2022 15:19, Dmitry Baryshkov wrote:
> On 28/10/2022 15:08, Robert Foss wrote:
>> Add compatible string for "qcom,sm8350-dpu" and
>> "qcom,sm8350-mdss".
>>
>> Signed-off-by: Robert Foss <robert.foss@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 1 +
>>   drivers/gpu/drm/msm/msm_mdss.c          | 1 +
>>   2 files changed, 2 insertions(+)
> 
> [skipped]
> 
>> diff --git a/drivers/gpu/drm/msm/msm_mdss.c 
>> b/drivers/gpu/drm/msm/msm_mdss.c
>> index e13c5c12b775..fd5a95cace16 100644
>> --- a/drivers/gpu/drm/msm/msm_mdss.c
>> +++ b/drivers/gpu/drm/msm/msm_mdss.c
>> @@ -447,6 +447,7 @@ static const struct of_device_id mdss_dt_match[] = {
>>       { .compatible = "qcom,sc8180x-mdss" },
>>       { .compatible = "qcom,sm8150-mdss" },
>>       { .compatible = "qcom,sm8250-mdss" },
>> +    { .compatible = "qcom,sm8350-mdss" },
>>       {}
>>   };
>>   MODULE_DEVICE_TABLE(of, mdss_dt_match);
> 
> 
> BTW: you probably also have to update the msm_mdss_enable() function 
> with the 8350-specific code.
> 

For mdss changes you can depend on [1], I plan to merge this patch in 
this window.

[1] https://patchwork.freedesktop.org/patch/489578/?series=105162&rev=1

Also with the mdss changes, it would be good to split this patch into 
dpu and mdss parts.

-- 
With best wishes
Dmitry

