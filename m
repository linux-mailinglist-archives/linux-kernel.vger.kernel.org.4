Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08BE697288
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 01:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjBOAKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 19:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjBOAKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 19:10:15 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B779B311C8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 16:10:05 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a3so10174985ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 16:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8azonh6JuDM6yxIBz+UeUT9A+K1dkd2wXajwtSP1wNo=;
        b=M81D30xtRjOeLl0/ENzu5hw5o44r66wXeRX9tMqeqWbvV5eTiAz6wRgQsVd4/yn6fe
         SAKjUk0EPFpyoa8Dvqn3ZvIakxe7sLp0X+nspxQ5cTfv2bidV27zMg6BUMRgSsZlcuuw
         TBTKWTzkzOJqsKkIc5C5wZDSGyhoyXGFeMz0RnLqa4VU8wgXO8Bd/iaewBWTWFYhhszM
         qWRWxprx/WJG87+hRrYuXOKHioz/3aXutio53bdNErHWICAYbdDPhYY5+QcqodOBSNjs
         b1iSINmG4DeIxZnvwm4Z0RhQVVE6oPERfmVh5tunqmLPIQP6j+OyF9f+jxHo04ct4LYM
         j3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8azonh6JuDM6yxIBz+UeUT9A+K1dkd2wXajwtSP1wNo=;
        b=IbsdO81s+fXV2AzOBdDs7DEYLxzLOvLCv6qLM5plS+BrbjZSFEG7arsa70H8TebcEv
         oyvtAVCggKsJ9dmdxh8K5SIve7gAbywp0VNc+zCa7cheOODpo7VVMxR9yvv3zXbZUTh2
         IgHvGsF7YSF2U/WP2RiktY+hr6hwkmTr/XdtGQfuzlkzJmh4Fxt4M4j3bJ7uD570k5d4
         w4ibhl29CzQHHBiTigZOhufI5jrpMlv6tmtwRNXDok27Y3YThOgEDJF/fLPDTb3xU6LR
         Q3iKvC5F9pF6SRgkk9fRiuomccWTKe946p7a6F2x91P6MhYMXwTfdXw/qS7Z1o8qYQVb
         FFqQ==
X-Gm-Message-State: AO0yUKUNOww517BzP/DhKvjcfBvZ8skWoSI51GCIFoCtMCSmN9EvG3qJ
        VNLrKuJlJXWl8PI6EIEN/YNqyw==
X-Google-Smtp-Source: AK7set/gKNIqLXNJwW+JD/xwd56nsFrvF97bkqwOd4DklH3lI/hfm72F9UxypL4PvkVMgtm0dKAn9w==
X-Received: by 2002:a17:906:9159:b0:866:6b08:946b with SMTP id y25-20020a170906915900b008666b08946bmr254841ejw.39.1676419804292;
        Tue, 14 Feb 2023 16:10:04 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id kg3-20020a17090776e300b0088a2aebb146sm8848566ejc.52.2023.02.14.16.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 16:10:03 -0800 (PST)
Message-ID: <a4627ca5-46e6-2f32-c0e2-a85990e02f54@linaro.org>
Date:   Wed, 15 Feb 2023 02:10:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 10/14] drm/msm/a6xx: Fix up A6XX protected registers
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, marijn.suijten@somainline.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230214173145.2482651-1-konrad.dybcio@linaro.org>
 <20230214173145.2482651-11-konrad.dybcio@linaro.org>
 <CAF6AEGva3ecxTOx3Yb+Wh-1K=jYA3tDo_aXg09jS9pzJupYExQ@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAF6AEGva3ecxTOx3Yb+Wh-1K=jYA3tDo_aXg09jS9pzJupYExQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 23:56, Rob Clark wrote:
> On Tue, Feb 14, 2023 at 9:32 AM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> One of the protected ranges was too small (compared to the data we
>> have downstream). Fix it.
>>
>> Fixes: 408434036958 ("drm/msm/a6xx: update/fix CP_PROTECT initialization")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index 503c750216e6..d6b38bfdb3b4 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -690,7 +690,7 @@ static const u32 a6xx_protect[] = {
>>          A6XX_PROTECT_NORDWR(0x00800, 0x0082),
>>          A6XX_PROTECT_NORDWR(0x008a0, 0x0008),
>>          A6XX_PROTECT_NORDWR(0x008ab, 0x0024),
>> -       A6XX_PROTECT_RDONLY(0x008de, 0x00ae),
>> +       A6XX_PROTECT_RDONLY(0x008d0, 0x00bc),
> 
> Nak, this is intentional, we need userspace to be able to configure
> the CP counters.  Otherwise this would break fdperf, perfetto, etc
> 
> (although maybe we should comment where we diverge from downstream)

Yes, please. Otherwise it is extremely hard to understand the reason for 
diversion between the vendor driver and our one.

> 
> BR,
> -R
> 
>>          A6XX_PROTECT_NORDWR(0x00900, 0x004d),
>>          A6XX_PROTECT_NORDWR(0x0098d, 0x0272),
>>          A6XX_PROTECT_NORDWR(0x00e00, 0x0001),
>> --
>> 2.39.1
>>

-- 
With best wishes
Dmitry

