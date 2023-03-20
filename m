Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D30F6C20DC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjCTTGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjCTTFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:05:52 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F613BD87
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:57:37 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id f16so13192600ljq.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679338648;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nleApilvt4seuieCelgHsaSTIO0I4XS6e296xQJeqbo=;
        b=Y8T/D4KhCrvWiGcvNzFU2A5tr+4RZs+9or1m4CE1Nxy1hZr5pQmIYn5xyuHLJ5bLqc
         p32Qe6uirnsXTT5nGZUDw86rqs5aJe9CHypXDJ26QEXC9iO9TiWKxRpLh/MXIBcltLlM
         ltRpwNUiyhlYFlHHMRXpc4cqEoPVSybrNoFM7U45foCbuMEIFjX0rVW6NDKy844hmu+N
         kZgMS4sJwZY0ZcqZ4aHpid8TrChnCmVzgMQx7IYcFVxRyaXMGnVASr0ZaRuKIs62ungt
         pUpkBJqVpDHiYCZ/A7PlT32jznHKkPdlPDM7m5OYRiERQZpHmyiDNVp0r/YEsuoXURVW
         T7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679338648;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nleApilvt4seuieCelgHsaSTIO0I4XS6e296xQJeqbo=;
        b=hzjyX+6Q7Q6v2huf8BeZjrrB25Q1Q9Na0S1hE8It0lxxeLerg2N3net6pBzuiQ6sWX
         iS2FXo1WWbcSVIG8QiuQbrGB1qC6jBvHQcvW1Bty6S6TZ0dUNksUpaDC8MzpR7f2x+L8
         Brl7CLdIJCAf2/4LFYDM2zclEFLT5Kl7wYhoYtnHOkL8F2ZZCbzRTUcw3+nHjm/flMZf
         skx7bYkFbznUG4EkXKBRSdacoXe51+btqNlJM3TlKsDdhBUXcWEjAU7XYyHl94HdhImh
         JClERyF5qQygVY9wQPjI8InziPfP1+sShP6G7YVeR2W5R71xG3ZAy6pl8dI/zT535OuM
         s1zA==
X-Gm-Message-State: AO0yUKXpDVwspFKw8bsV5ECejjtMmfRMirvw7IQiZ/JPJa/awMKBUt4M
        S9VrPaxC+kTYK7KxiNviZxjRxA==
X-Google-Smtp-Source: AK7set/yKyX3y77Kji7SlQfpq9YqoLL0zl8SS/79CJ7SJxvJND8O9+7pw8lP/fsaa7amAV7qB1hcUw==
X-Received: by 2002:a2e:8e84:0:b0:299:6e0e:3a2a with SMTP id z4-20020a2e8e84000000b002996e0e3a2amr59003ljk.49.1679338648422;
        Mon, 20 Mar 2023 11:57:28 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id d16-20020a2eb050000000b0029aa0b6b41asm1724672ljl.115.2023.03.20.11.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 11:57:28 -0700 (PDT)
Message-ID: <5a9e6cdb-f640-f070-6722-18e61c9f1136@linaro.org>
Date:   Mon, 20 Mar 2023 19:57:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] drm/msm/a6xx: Some reg64 conversion
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230320185416.938842-1-robdclark@gmail.com>
 <434caf75-eed1-ac35-f43c-da8c66cb99bc@somainline.org>
In-Reply-To: <434caf75-eed1-ac35-f43c-da8c66cb99bc@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.03.2023 19:56, Konrad Dybcio wrote:
> 
> 
> On 20.03.2023 19:54, Rob Clark wrote:
>> From: Rob Clark <robdclark@chromium.org>
>>
>> The next generated header update will drop the _LO/_HI suffix, now that
>> the userspace tooling properly understands 64b vs 32b regs (and the _LO/
>> _HI workarounds are getting cleaned up).  So convert to using the 64b
>> reg helpers in prep.
>>
>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index 89049094a242..f26e258c6021 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -1053,12 +1053,9 @@ static int hw_init(struct msm_gpu *gpu)
>>  	gpu_write(gpu, REG_A6XX_RBBM_PERFCTR_GPU_BUSY_MASKED, 0xffffffff);
>>  
>>  	/* Disable L2 bypass in the UCHE */
>> -	gpu_write(gpu, REG_A6XX_UCHE_WRITE_RANGE_MAX_LO, 0xffffffc0);
>> -	gpu_write(gpu, REG_A6XX_UCHE_WRITE_RANGE_MAX_HI, 0x0001ffff);
>> -	gpu_write(gpu, REG_A6XX_UCHE_TRAP_BASE_LO, 0xfffff000);
>> -	gpu_write(gpu, REG_A6XX_UCHE_TRAP_BASE_HI, 0x0001ffff);
>> -	gpu_write(gpu, REG_A6XX_UCHE_WRITE_THRU_BASE_LO, 0xfffff000);
>> -	gpu_write(gpu, REG_A6XX_UCHE_WRITE_THRU_BASE_HI, 0x0001ffff);
>> +	gpu_write64(gpu, REG_A6XX_UCHE_WRITE_RANGE_MAX_LO, 0x0001ffffffffffc0llu);
>> +	gpu_write64(gpu, REG_A6XX_UCHE_TRAP_BASE_LO, 0x0001fffffffff000llu);
>> +	gpu_write64(gpu, REG_A6XX_UCHE_WRITE_THRU_BASE_LO, 0x1fffffffff000llu);
> Any reason the last write dropped the leading zeroes?
> 
> Otherwise,
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Bah, thunderfox sent it from the wrong email. It still stands.

Konrad
> 
> Konrad
>>  
>>  	if (!adreno_is_a650_family(adreno_gpu)) {
>>  		/* Set the GMEM VA range [0x100000:0x100000 + gpu->gmem - 1] */
