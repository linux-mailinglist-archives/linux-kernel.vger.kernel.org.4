Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DC469BA20
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 14:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjBRNEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 08:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjBRNEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 08:04:08 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9600113D7A
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 05:04:07 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b1so955255lfs.8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 05:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3N5WAzbRFEo6T4gVmAxjSh/Vc/Ea58u6XaJqPwHeVh4=;
        b=U4IXj5fZbsqDGnnIHvFZjApawI7qJL91IjBv5k4Klvpgh7GQl6AdaUil67EYPWWXgo
         5qzdpVEqeRX4xOzpvzc4pKf7InKG6AWHme+BkdAoMHe8B+nmo461rqY3zraL5on846DP
         gJOMYCVgu7xeuo1EPhlyvmP1+X4/D3pcaHvH0jr0X9A81wjmOXkFd2G3Hau5sbrLcsCY
         r09p4VrVglNWHtBAm4Mzs/dKh8VpV43bBvYLS9ymwCkaq0ZyLAdQTHOzrp0OnTUIFARl
         rrlN8H7+vUDN+jdo/2gUYb5KHNcW2oOCccSmZkDFRJ+QUwY82MuWqnjAJJtHH+BypEtW
         Nylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3N5WAzbRFEo6T4gVmAxjSh/Vc/Ea58u6XaJqPwHeVh4=;
        b=fQWAA0CQDE4HF6jl1dfy0EaRhNXmccu/ZJpdEJbVLwrUHqdjQJALnX/DPPBd/1JhvH
         s/JCxR6nXVPYpaeP4D+gRak2gOSef0tSLDneUk1Mw+t6gW8u3x822KcAenlHW+ZSL/PW
         OS6J4YfSKZlkWGqusIheM3JaUug04pFuHWucLl8v2CBZU8W8sN0pXgla0X6VQlPp7Fxa
         PN0IkhS8pbZUmBHb0/FpqJjWNvtnnpqK+ph1FJk4TbOCadJwLxDguqPWayOiSCVL19vm
         zlds37RZSvyxjuAI3xVQ117KENTITBnjpQ6q78irRrUeIZ1w7qklyAMGi3IOGPh5QVIL
         24gw==
X-Gm-Message-State: AO0yUKX2rn3V+9FqGpQRCRgwS65ALBGERFSvgxcBZCPukCdWVrbGawJs
        oY16jZ9XzYO+pyOZuvkxK/Cz6w==
X-Google-Smtp-Source: AK7set/gnKvtFmRzdwyC6P2wMI81d4vWwm6HjdeC7KtCbMNjaI4FGSQJ3mv5xfpjdnNPaUNiKYztuA==
X-Received: by 2002:ac2:561b:0:b0:4b5:7096:23ff with SMTP id v27-20020ac2561b000000b004b5709623ffmr1010457lfd.66.1676725445833;
        Sat, 18 Feb 2023 05:04:05 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id h18-20020ac250d2000000b004d865c781eesm980042lfm.24.2023.02.18.05.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Feb 2023 05:04:05 -0800 (PST)
Message-ID: <417fe51e-1f35-53d4-0dd7-bbb01d5bd164@linaro.org>
Date:   Sat, 18 Feb 2023 15:04:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 07/14] drm/msm/a6xx: Add support for A619_holi
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230214173145.2482651-1-konrad.dybcio@linaro.org>
 <20230214173145.2482651-8-konrad.dybcio@linaro.org>
 <8268b4c9-ca5e-4ff3-628c-7e9daaeb16b0@linaro.org>
 <9269c5dd-d97c-e29a-98a9-b42c598ebfc6@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <9269c5dd-d97c-e29a-98a9-b42c598ebfc6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2023 23:21, Konrad Dybcio wrote:
> 
> 
> On 17.02.2023 22:19, Dmitry Baryshkov wrote:
>> On 14/02/2023 19:31, Konrad Dybcio wrote:
>>> A619_holi is a GMU-less variant of the already-supported A619 GPU.
>>> It's present on at least SM4350 (holi) and SM6375 (blair). No mesa
>>> changes are required. Add the required kernel-side support for it.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>    drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 37 +++++++++++++++++-----
>>>    drivers/gpu/drm/msm/adreno/adreno_device.c | 13 ++++++++
>>>    drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  5 +++
>>>    3 files changed, 47 insertions(+), 8 deletions(-)

[...]


>>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
>>> index 82757f005a1a..71faeb3fd466 100644
>>> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
>>> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
>>> @@ -264,6 +264,19 @@ static const struct adreno_info gpulist[] = {
>>>            .gmem = SZ_512K,
>>>            .inactive_period = DRM_MSM_INACTIVE_PERIOD,
>>>            .init = a6xx_gpu_init,
>>> +    }, {
>>> +        .rev = ADRENO_REV(6, 1, 9, 1),
>>
>> I think this deserves a comment that GMU-enabled sm6350 has patch_id 0 (if I interpreted the vendor dtsi correctly).
>>
>> Another option might be to actually check for the qcom,gmu presense and add that to the selection conditional.
> We pass the GMU wrapper in qcom,gmu = <>, though perhaps setting
> the holi-ness based on whether it's "qcom,gmu-x.y.z.a" or
> "qcom,gmu-wrapper" would be wiser.. The patch ID is indeterminate
> and I *think* one GMU-wrapper A619 has patch id 0..

I was not aware that GMU-wrapper also adds a GMU device. In this case, 
checking the GMU's compatible strings sounds like a logical approach to me.

> 
> Konrad
>>
>>> +        .revn = 619,
>>> +        .name = "A619_holi",
>>> +        .fw = {
>>> +            [ADRENO_FW_SQE] = "a630_sqe.fw",
>>> +        },
>>> +        .gmem = SZ_512K,
>>> +        .inactive_period = DRM_MSM_INACTIVE_PERIOD,
>>> +        .quirks = ADRENO_QUIRK_GMU_WRAPPER,
>>> +        .init = a6xx_gpu_init,
>>> +        .zapfw = "a615_zap.mdt",
>>> +        .hwcg = a615_hwcg,
>>>        }, {
>>>            .rev = ADRENO_REV(6, 1, 9, ANY_ID),
>>>            .revn = 619,
>>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>>> index 7c5e0a90b5fb..16241368c2e4 100644
>>> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>>> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>>> @@ -252,6 +252,11 @@ static inline int adreno_is_a619(struct adreno_gpu *gpu)
>>>        return gpu->revn == 619;
>>>    }
>>>    +static inline int adreno_is_a619_holi(struct adreno_gpu *gpu)
>>> +{
>>> +    return adreno_is_a619(gpu) && adreno_has_gmu_wrapper(gpu);
>>> +}
>>> +
>>>    static inline int adreno_is_a630(struct adreno_gpu *gpu)
>>>    {
>>>        return gpu->revn == 630;
>>

-- 
With best wishes
Dmitry

