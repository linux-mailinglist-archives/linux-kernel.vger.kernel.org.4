Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512766B7E31
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjCMQzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjCMQzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:55:00 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5974CBDC4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:54:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x17so425409lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678726497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=95CYDuHHvTAJVFqvju6CvM9KhyIATAcbysxvdP4sDhM=;
        b=wBEx51nsMBegO5s4qogT8bwRqa33i8wzg6GbmIXP6YR9I7bd2uJYqWS/SoAkdesKrn
         Ees4bJeqBinRcVxUrPYBH0feAqpe8vsWzQ0MbtkLz9nYVJYpDuVBjXxTU1KMfcR4hIp0
         L3NZ3GQpwvtFxJN1QdZoAkKgi9eCqS/ozmItpVPu5zK9zkMJOnaEFMdMD7mIWoKbsOSg
         kdjnRLAoI20YN6R858Tyej0Rnlh/3cmz5TCXQ4EM6AUi6nvhPb0RVSpHi4areeD/rDnH
         LZ8dacWB/3AmOe4Mjw5E+7IQ9O3GA8hgB9qV3ToaHENr0yC5T2eATyeRs1NA7RsSoj6K
         d3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678726497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95CYDuHHvTAJVFqvju6CvM9KhyIATAcbysxvdP4sDhM=;
        b=Pg6UTPRIkLHxfmqnH3W4FSxWGfMcB1pOnQBEQyajBeNEAKHT4KRS04WMvTdj6ihnok
         g6CwJ/rxRDaRAVkJo6zH74CXvi41qjfkPfzJ2XLBVFGN297hjNYzHPvpWO4VKTENdTOm
         NSXPJGSEyvE08l/RnqNkqRoT1M9X5rhZ53v5S+VBKtZCDLLExFKC1QijdouCIO2wodXk
         Bj8DlOHPeyLAZmsuvdjt1ELibARuENEX/BsL87HENWtzwSeL6Vqup2V60U06CBFjmcsl
         2jVFtERlbsNOapHk5SIOnqajOt+fNWlJkK4vAe+Cv9g2D0x5A2ZkVKnbRE1QWPrCiN3M
         ixew==
X-Gm-Message-State: AO0yUKU3RPb3SOLFyrxkYLKHwas5aQmLLoJsTxZk0S1FTkEtYz8AV8Hh
        1+WHbkky1BYTIsYz9OkPxCHJSg==
X-Google-Smtp-Source: AK7set8TlLYFmTIqQsaFFyNmY7OCBJjH5uOIca39HAAucj+bcBCxhSYcL5RbfiRlpUG9u+LjMVejaQ==
X-Received: by 2002:ac2:4306:0:b0:4e8:41fc:b37 with SMTP id l6-20020ac24306000000b004e841fc0b37mr1536039lfh.10.1678726497648;
        Mon, 13 Mar 2023 09:54:57 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id q27-20020ac2529b000000b004da8168eba2sm18917lfm.237.2023.03.13.09.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 09:54:57 -0700 (PDT)
Message-ID: <8e9fc1c0-f74f-ba82-fade-31212637d6bb@linaro.org>
Date:   Mon, 13 Mar 2023 17:54:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Freedreno] [PATCH v3 4/7] drm/msm/a2xx: Implement .gpu_busy
To:     Jonathan Marek <jonathan@marek.ca>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230223-topic-opp-v3-0-5f22163cd1df@linaro.org>
 <20230223-topic-opp-v3-4-5f22163cd1df@linaro.org>
 <2f2467d1-f5f3-86dd-edba-fc26e60d142f@marek.ca>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <2f2467d1-f5f3-86dd-edba-fc26e60d142f@marek.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.02.2023 16:04, Jonathan Marek wrote:
> This won't work because a2xx freedreno userspace expects to own all the perfcounters.
> 
> This will break perfcounters for userspace, and when userspace isn't using perfcounters, this won't count correctly because userspace writes 0 to CP_PERFMON_CNTL at the start of every submit.

Rob, would you be willing to take this without the a2xx bits? It
should still be fine, except without devfreq. Not that we had
any significant sort of scaling on a2xx before.

Konrad
> 
> On 2/23/23 5:52 AM, Konrad Dybcio wrote:
>> Implement gpu_busy based on the downstream msm-3.4 code [1]. This
>> allows us to use devfreq on this old old old hardware!
>>
>> [1] https://github.com/LineageOS/android_kernel_sony_apq8064/blob/lineage-16.0/drivers/gpu/msm/adreno_a2xx.c#L1975
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/adreno/a2xx_gpu.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
>> index c67089a7ebc1..104bdf28cdaf 100644
>> --- a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
>> @@ -481,6 +481,31 @@ a2xx_create_address_space(struct msm_gpu *gpu, struct platform_device *pdev)
>>       return aspace;
>>   }
>>   +/* While the precise size of this field is unknown, it holds at least these three values.. */
>> +static u64 a2xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
>> +{
>> +    u64 busy_cycles;
>> +
>> +    /* Freeze the counter */
>> +    gpu_write(gpu, REG_A2XX_CP_PERFMON_CNTL, PERF_STATE_FREEZE);
>> +
>> +    busy_cycles = gpu_read64(gpu, REG_A2XX_RBBM_PERFCOUNTER1_LO);
>> +
>> +    /* Reset the counter */
>> +    gpu_write(gpu, REG_A2XX_CP_PERFMON_CNTL, PERF_STATE_RESET);
>> +
>> +    /* Re-enable the performance monitors */
>> +    gpu_rmw(gpu, REG_A2XX_RBBM_PM_OVERRIDE2,
>> +        A2XX_RBBM_PM_OVERRIDE2_DEBUG_PERF_SCLK_PM_OVERRIDE,
>> +        A2XX_RBBM_PM_OVERRIDE2_DEBUG_PERF_SCLK_PM_OVERRIDE);
>> +    gpu_write(gpu, REG_A2XX_RBBM_PERFCOUNTER1_SELECT, 1);
>> +    gpu_write(gpu, REG_A2XX_CP_PERFMON_CNTL, PERF_STATE_ENABLE);
>> +
>> +    *out_sample_rate = clk_get_rate(gpu->core_clk);
>> +
>> +    return busy_cycles;
>> +}
>> +
>>   static u32 a2xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
>>   {
>>       ring->memptrs->rptr = gpu_read(gpu, REG_AXXX_CP_RB_RPTR);
>> @@ -502,6 +527,7 @@ static const struct adreno_gpu_funcs funcs = {
>>   #if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
>>           .show = adreno_show,
>>   #endif
>> +        .gpu_busy = a2xx_gpu_busy,
>>           .gpu_state_get = a2xx_gpu_state_get,
>>           .gpu_state_put = adreno_gpu_state_put,
>>           .create_address_space = a2xx_create_address_space,
>>
