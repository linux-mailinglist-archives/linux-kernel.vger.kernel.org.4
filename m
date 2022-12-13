Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498A564B884
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbiLMPfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbiLMPfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:35:05 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5879A21825
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:35:00 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id g7so5516343lfv.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y8vVbjqanYrGCXOfeKuV4b4So0udrFNnXHVcrF7wyxU=;
        b=rejw52LTgB29C7W/cCkFInXwaYdOjKdIK/Dyp68WRtGnifK/FvgmyyWIiajyX8D5eE
         itpYE1WGMWzthGAI0xKSktWLWeGCAIalpFgVRA+N/tzQ+XKbbbPRRhbjwCGAgNh4d5mi
         ZznfVnd0NAG8gQO7Tn1KgDb42WwK1OWauMTT1kMzpcMOkIZ/2lgERnbD3UyCtqOvmf/M
         8UbSK7Q1T7EIYfcMv0kkRnAKMk9Srj60NyyMM2QeyyAPxdN5MNNmbsLcCJRgia8CIENL
         FSDTeOUHMXIqEjgfEG59YRFJ0HsMrnZKgV/wXW+fHxUFzU32J4dY/jF4ohlfvunp7YM7
         GXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8vVbjqanYrGCXOfeKuV4b4So0udrFNnXHVcrF7wyxU=;
        b=515hsVvDCxWeYzM3tHkfDLJ9paotbbpu/N3JyaApZG3TpCXWj2hEkVwpGa8rw0J+Ym
         WOmDGgu2wwe6t0+0Lz9NpmllAM8XxbxhpWlsPMqTWdj2H83tYOLia5VdGdn/aRymlol5
         lYvl0kVyRwoyvWfkk2tqKr0P9MDMik3+Dpe96HyCrrTe/X7twtLcrrVTzUloPa+BqDNw
         HZpGIMwM92pKt9WeBx+LH2JxKszvbPrgsJYR5FPKaI6hLLscpVZmS559H3kNtZoAk494
         9dGlotjKKWcMw4tA8cx6PjqmHNSyclIMjlRuGeLT1NfNHzSnukun0PnrcuWOBvIp/w01
         sDHw==
X-Gm-Message-State: ANoB5pkoefxmZbrilxT033PZnb6TvvN/j9xGWi137upgnP6XrKbAlaZF
        f5TRw44nSZxBXEb+bb0Dp9GTGg==
X-Google-Smtp-Source: AA0mqf5WlSauCJELuZCcs4LWl3+VRfp8Lq0O7eAOrC7PK3kPa1vZKkiqpgeCSdbQu75jdV5vdi2Nug==
X-Received: by 2002:a19:ad49:0:b0:4b5:c489:8cf8 with SMTP id s9-20020a19ad49000000b004b5c4898cf8mr3108286lfd.61.1670945698746;
        Tue, 13 Dec 2022 07:34:58 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id v7-20020a056512348700b004a2511b8224sm413426lfr.103.2022.12.13.07.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 07:34:58 -0800 (PST)
Message-ID: <7df05698-0aef-7c9c-4577-3d400c631da8@linaro.org>
Date:   Tue, 13 Dec 2022 16:34:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/7] drm/msm/a6xx: Add support for A650 speed binning
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221213002423.259039-1-konrad.dybcio@linaro.org>
 <20221213002423.259039-5-konrad.dybcio@linaro.org>
 <CAD=FV=U+prbiaQfWRcqp17oRgxFV=JvmweNFoK0+xYcnfoJr=A@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAD=FV=U+prbiaQfWRcqp17oRgxFV=JvmweNFoK0+xYcnfoJr=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.12.2022 16:23, Doug Anderson wrote:
> Hi,
> 
> On Mon, Dec 12, 2022 at 4:24 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> Add support for matching QFPROM fuse values to get the correct speed bin
>> on A650 (SM8250) GPUs.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index 2c1630f0c04c..f139ec57c32d 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -1887,6 +1887,20 @@ static u32 a640_get_speed_bin(u32 fuse)
>>         return UINT_MAX;
>>  }
>>
>> +static u32 a650_get_speed_bin(u32 fuse)
>> +{
>> +       if (fuse == 0)
>> +               return 0;
>> +       else if (fuse == 1)
>> +               return 1;
>> +       else if (fuse == 2)
>> +               return 2;
>> +       else if (fuse == 3)
>> +               return 3;
>> +
>> +       return UINT_MAX;
> 
> Unlike some of the other functions, you don't need any complexity. Just do:
> 
> if (fuse <= 3)
>   return fuse;
> 
> return UINT_MAX;
I'd prefer to keep it open-coded, it's just 8150 and 8250 that have
these simple fuse values, other SoCs have random numbers (check A618/
619 above, for example).. Plus the returned values might as well be
made-up, as it's just for opp matching.


> 
> 
> I'd also suggest that perhaps "UINT_MAX" isn't exactly the right
> return value for when we have an unrecognized fuse. The return type
> for the function is "u32" which is a fixed size type. UINT_MAX,
> however, is a type that is automatically sized by the compiler. Though
> it's unlikely, theoretically a compiler could be configured such that
> "unsigned int" was something other than 32 bits. Ideally either the
> return type would be changed to "unsigned int" or you'd return
> 0xffffffff as the sentinel value.
That's out of the scope of this patch, as it concerns all the
speedbin-supported GPUs. The returned value feeds 1<<ret, which
should be capped a bit lower than UINT_MAX, anyway. But I can
look into that in a separate patchset.

Konrad
> 
> -Doug
