Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76936696267
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjBNLZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjBNLZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:25:06 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194CC4C1B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:25:05 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id n10so12288826ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5TGkTb84xWLMG/13fJRvA7TRiYPYi0w1Swy3fYZHFmQ=;
        b=qrsYnscwV52Y0VUk71OYY1ldy21oHOaKQ5RlMrj9BazqS2SQShekW4a4HfU+4rB3VN
         eKjZz4661I5EKvhJhXeNNHvUBorw47RrH6T2cX+AhC/+FsxwmccjjJo1nTlPZljHzuQl
         vJWw7CxaSf7GPUq0t1yy1Ypq8LBirVW77n1O3KsIBugDnWfQGKA889w4mpV+EHm81dTV
         K+2ID04MgeDLrZV4vl0evUgnGrGYqsZS7i0kKLBj05BL2e7f6GUg43RFYXoxfkLhV83Q
         YWiQ8yJJQZd5mTEiYl4eFprQhgxIRGOKPlE/yDnX7YTvryxn+SBRGFd1s7/xvZP+P5yo
         Zxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5TGkTb84xWLMG/13fJRvA7TRiYPYi0w1Swy3fYZHFmQ=;
        b=wg2APA151uMszGGVAntmLAPjkHD4CRaSUdfbsBQUiODhCM54XY7i5bMl06K0VY7eBN
         yh+/3kyBWd+ZFv3TILr4NhwXDJfwECQLt9u8aY877pBskYOv53I38fYHnThaj3yxMGCa
         mVTW/WDyA8Ehv8NCfb0mxuwqAMtmIfR0ZDjY/HWNpP2sj+SMOULx4Vwk3+qlOdTxN7rx
         xkf6Ys4DsedWoafCnQVb72Q86SY2tNIWOOQLTdmVR3p0msO4x94EFR3NJxMVtkZnlOub
         QGpOWK5VbIvN6/ZV0NCep4FPL0WIFtjvgvChErs3qtbgi3XuZ6SHTEHNcJBsXV8w3P68
         suvw==
X-Gm-Message-State: AO0yUKW4Galq5E5TAARM23gNXB5pGm1/SP79FFaq8s7tSTyc4PmSZkPj
        Hq8YzFfIQxXY+V+xB45XHApbvQ==
X-Google-Smtp-Source: AK7set8d4qwwJ3IKiKndtYvjo+bLtM6RA5dfulIstN4IPGmyQeW5ECkuHkFFF5kRAariNWsOgwnDYg==
X-Received: by 2002:a17:907:2087:b0:8ae:e876:ea68 with SMTP id pv7-20020a170907208700b008aee876ea68mr2544984ejb.74.1676373903653;
        Tue, 14 Feb 2023 03:25:03 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906210200b00888f92f0708sm8229934ejt.15.2023.02.14.03.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 03:25:03 -0800 (PST)
Message-ID: <48364c3f-699d-ce14-37c4-53bf4a90bc23@linaro.org>
Date:   Tue, 14 Feb 2023 12:25:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Freedreno] [PATCH 09/14] drm/msm/a6xx: Fix some A619 tunables
Content-Language: en-US
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        freedreno@lists.freedesktop.org,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        David Airlie <airlied@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        marijn.suijten@somainline.org, Sean Paul <sean@poorly.run>,
        Chia-I Wu <olvaffe@gmail.com>, linux-kernel@vger.kernel.org
References: <20230126151618.225127-1-konrad.dybcio@linaro.org>
 <20230126151618.225127-10-konrad.dybcio@linaro.org>
 <20230208182101.53ykatzah6zvpy76@amazon.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230208182101.53ykatzah6zvpy76@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.02.2023 19:21, Jordan Crouse wrote:
> On Thu, Jan 26, 2023 at 04:16:13PM +0100, Konrad Dybcio wrote:
>> Adreno 619 expects some tunables to be set differently. Make up for it.
>>
>> Fixes: b7616b5c69e6 ("drm/msm/adreno: Add A619 support")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index 7a480705f407..f34ab3f39f09 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -1171,6 +1171,8 @@ static int hw_init(struct msm_gpu *gpu)
>>                 gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00200200);
>>         else if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu))
>>                 gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00300200);
>> +       else if (adreno_is_a619(adreno_gpu))
>> +               gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00018000);
>>         else if (adreno_is_a610(adreno_gpu))
>>                 gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00080000);
>>         else
>> @@ -1188,7 +1190,9 @@ static int hw_init(struct msm_gpu *gpu)
>>         a6xx_set_ubwc_config(gpu);
>>
>>         /* Enable fault detection */
>> -       if (adreno_is_a610(adreno_gpu))
>> +       if (adreno_is_a619(adreno_gpu))
>> +               gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x3fffff);
>> +       else if (adreno_is_a610(adreno_gpu))
>>                 gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x3ffff);
>>         else
>>                 gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x1fffff);
> 
> The number appended to the register is the number of clock ticks to wait
> before declaring a hang. 0x3fffff happens to be the largest value that
> can be set for the a6xx family (excepting the 610 which, IIRC, used older
> hardware that had a smaller field for the counter).
Makes sense!

Downstream the
> number would creep up over time as unexplained hangs were discovered and
> diagnosed or covered up as "just wait longer".
lol..

> 
> So in theory you could leave this with the "default value" or even bump
> up the default value to 0x3fffff for all targets if you wanted to. An
> alternate solution (that downstream does) is to put this as a
> pre-defined configuration in gpulist[].
I'm not sure it's a good idea to let things loose, as that may let some
bugs slip through.. Perhaps let's leave that as-is until we have a seriously
otherwise-unresolvable situation..

Konrad
> 
> Jordan
