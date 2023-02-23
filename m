Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C444E6A0635
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjBWK2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjBWK2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:28:07 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E56ACDF1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:28:03 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id s20so12913847lfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4KN3QHYebXNFQ1MR4lOhV0UH8In9lLiTgGDCFeMOKXc=;
        b=WMywVw8K3Py8G4VhmbwAutu+2p6v6TxkHwEsDYSsLJGyIquHRIFpNKkgAxgFKHpL4m
         hM1IdLkMkTSV3PhZvWb/Gk1x/sZvOfBfqDb3qpUDtvlu5lHCpZ9JPCwtzz1QwuifiKih
         sCdFX9navsCOByhG0cdIXsVyd4M9X8VP/YEQPi/zQsmmz+0YJy5j8ndY/NZeoZ+o/yRG
         mC7EL+alp/G8GhwkuNls0MAvuQ0hDeOgO1iUt3rvC0hC47+mOVmH/osqwxK6VwdQXMdp
         VsM4gXuTlY8CrXBIOIAtbpHIJWtHlYZyeFw2DvIYBcsHy5+9jL6iJk1H+lDM6ciacDi2
         RFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4KN3QHYebXNFQ1MR4lOhV0UH8In9lLiTgGDCFeMOKXc=;
        b=XDtHh8XT1+xIHzhPOFkcfH/0oySWmk8jLq2KZpeuFHBWwHemwFrRNsVUvbkWsYt6Sq
         EtQq1ojG6dfe6yj5moQNiZiZggsH1V6VYh0uO7+CSYoYJjzLv5L8rVOOPmkf0ZuBpYQE
         Io1JlnN8Hj2ft8lqAGimUrAfcXIIgX/iE97RMkasxcoKaBQR4x/nrL99Vv7CwST4w2pm
         WeHI4u1BYw48yMBLmYOdTVLnbZUMwQf4oTP/bckmVRgv51++YDY9TxhgzUTpZXAEKenw
         C6zcqpPnyMON5Quyrlc+Xg7zf2BFCaNedp6tEPZXanVYNV/ab12PgvDVClAk3cqEx1BJ
         7sCQ==
X-Gm-Message-State: AO0yUKX+nLbcCystMfNydehh+pOSoAdgqsYgUYyPOx4IfUV49oOy7EzF
        9CIY38eY9ntPYDBNniVfvRw7QQ==
X-Google-Smtp-Source: AK7set+/bXBe561KcXizDtJoY7mQSwDyRScTzV+2Y8APj0r3B+3RmXwofutdh3SF2HsU/WPCIxKn9A==
X-Received: by 2002:a19:7502:0:b0:4db:3cea:ef02 with SMTP id y2-20020a197502000000b004db3ceaef02mr4228612lfe.68.1677148081742;
        Thu, 23 Feb 2023 02:28:01 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id g16-20020a2eb5d0000000b002935354161bsm1161590ljn.106.2023.02.23.02.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 02:28:01 -0800 (PST)
Message-ID: <f6acca8c-6b07-426d-80c7-a10dad20ed7c@linaro.org>
Date:   Thu, 23 Feb 2023 11:27:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/6] drm/msm/a2xx: Implement .gpu_busy
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230223-topic-opp-v2-0-24ed24cd7358@linaro.org>
 <20230223-topic-opp-v2-3-24ed24cd7358@linaro.org>
 <CAA8EJprAxKCD_bJFdaMGhnwW56u+NLN_qxBV9aSzMTRdzsh07A@mail.gmail.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJprAxKCD_bJFdaMGhnwW56u+NLN_qxBV9aSzMTRdzsh07A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.02.2023 03:09, Dmitry Baryshkov wrote:
> On Thu, 23 Feb 2023 at 03:47, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> Implement gpu_busy based on the downstream msm-3.4 code [1]. This
>> allows us to use devfreq on this old old old hardware!
>>
>> [1] https://github.com/LineageOS/android_kernel_sony_apq8064/blob/lineage-16.0/drivers/gpu/msm/adreno_a2xx.c#L1975
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Small nit below
> 
>> ---
>>  drivers/gpu/drm/msm/adreno/a2xx_gpu.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
>> index c67089a7ebc1..6f9876b37db5 100644
>> --- a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
>> @@ -481,6 +481,29 @@ a2xx_create_address_space(struct msm_gpu *gpu, struct platform_device *pdev)
>>         return aspace;
>>  }
>>
>> +/* While the precise size of this field is unknown, it holds at least these three values.. */
>> +static u64 a2xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
>> +{
>> +       u64 busy_cycles;
>> +
>> +       /* Freeze the counter */
>> +       gpu_write(gpu, REG_A2XX_CP_PERFMON_CNTL, PERF_STATE_FREEZE);
>> +
>> +       busy_cycles = gpu_read64(gpu, REG_A2XX_RBBM_PERFCOUNTER1_LO);
>> +
>> +       /* Reset the counter */
>> +       gpu_write(gpu, REG_A2XX_CP_PERFMON_CNTL, PERF_STATE_RESET);
>> +
>> +       /* Re-enable the performance monitors */
>> +       gpu_rmw(gpu, REG_A2XX_RBBM_PM_OVERRIDE2, BIT(6), BIT(6));
> 
> It's DEBUG_PERF_SCLK_PM_OVERRIDE
> 
> See https://github.com/genesi/linux-legacy/blob/master/drivers/mxc/amd-gpu/include/reg/yamato/10/yamato_mask.h#L4428
I'll fix it up!

Konrad
> 
>> +       gpu_write(gpu, REG_A2XX_RBBM_PERFCOUNTER1_SELECT, 1);
>> +       gpu_write(gpu, REG_A2XX_CP_PERFMON_CNTL, PERF_STATE_ENABLE);
>> +
>> +       *out_sample_rate = clk_get_rate(gpu->core_clk);
>> +
>> +       return busy_cycles;
>> +}
>> +
>>  static u32 a2xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
>>  {
>>         ring->memptrs->rptr = gpu_read(gpu, REG_AXXX_CP_RB_RPTR);
>> @@ -502,6 +525,7 @@ static const struct adreno_gpu_funcs funcs = {
>>  #if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
>>                 .show = adreno_show,
>>  #endif
>> +               .gpu_busy = a2xx_gpu_busy,
>>                 .gpu_state_get = a2xx_gpu_state_get,
>>                 .gpu_state_put = adreno_gpu_state_put,
>>                 .create_address_space = a2xx_create_address_space,
>>
>> --
>> 2.39.2
>>
> 
> 
