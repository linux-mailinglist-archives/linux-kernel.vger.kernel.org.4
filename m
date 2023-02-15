Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52406972B8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 01:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjBOAjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 19:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBOAi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 19:38:58 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C302E0E5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 16:38:53 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id rp23so44302837ejb.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 16:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DErVdwsy+3xw2GwkFW/1jP8o0hXZca4+3mMVdiVqO0g=;
        b=FtXlYQuaQwjPUMXlRr1vGDA6uOOxl2acYjEpOiX8O/IfY6xybcVCbrja3quEX5WEtd
         tDeHcLl8KhQYNZrbaTtNmsbzAQ4RBqoLp0MotI/yT9Kfipkz8hYuXBrebCSzfsz22qn0
         gFyBBO3m9/akpjE25FysCAPzriP3+giUaD1ygSDLT7ppawyVwSnBAPfwCDK25AP5CSXg
         uR6zBQ/9/OQ+XFliSIdq/akdqN5t4K8LaBOE/EZVCpVOIh2GvDA7ohK69oPswRLu77fu
         FBCqnyckT1YSX6gRK1yvLk5viF97Zt2QxjlYRWH3k8VItf/0WGHY8NPK6hdbu5fhcele
         fFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DErVdwsy+3xw2GwkFW/1jP8o0hXZca4+3mMVdiVqO0g=;
        b=byXtTK1xDH7KYoYg+wTknDRhX0WUw3m3tO+4oBXyI50eRCxO0v4fg8+Lx+hUzj617w
         YRhT3H5+VYWbs9t8weA8TqBEtlvPUJo33Qu6YnI71kjjS0naHCRHoSzNdZMKwCkIYfnl
         4mBIaf8htiPwtaYpOAMQimsCHIEqd3WiVywVQJtwWqOI2IYu+GAVjRzcehU69JM2+jgR
         Q3p/eQdZMcicnf360LMNmG/QkMsWOyC36utoFo22jKw7ZDQ09RAeMC4NAFtzRn6CE4az
         /MiJtzwnzijWiou0FAp3n41qYWWeaGQA07CpJ4CJIQnp2Xf25THd4a5TqwKr6kCjoKLx
         9q6g==
X-Gm-Message-State: AO0yUKVTVmrrcvE5StDzD5U///V7KBdZMkV5TR0JRmTaYL8yfLyL+TqD
        rkJ9jV3Gjl7G3C33W4CzrH0d0w==
X-Google-Smtp-Source: AK7set/Pf8YmPNmxd7Fuo6gurGgDxLsWDmYD262e9PepNFs42+X34FypQ04DMvhoJpnxOin0grMz2A==
X-Received: by 2002:a17:907:2c65:b0:883:b1b4:e798 with SMTP id ib5-20020a1709072c6500b00883b1b4e798mr391411ejc.10.1676421531499;
        Tue, 14 Feb 2023 16:38:51 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id ci4-20020a170906c34400b0087873afb1b4sm8888438ejb.41.2023.02.14.16.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 16:38:51 -0800 (PST)
Message-ID: <1c57fcfd-8e94-649b-df6f-655626f94454@linaro.org>
Date:   Wed, 15 Feb 2023 01:38:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 10/14] drm/msm/a6xx: Fix up A6XX protected registers
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>
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
 <a4627ca5-46e6-2f32-c0e2-a85990e02f54@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <a4627ca5-46e6-2f32-c0e2-a85990e02f54@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.02.2023 01:10, Dmitry Baryshkov wrote:
> On 14/02/2023 23:56, Rob Clark wrote:
>> On Tue, Feb 14, 2023 at 9:32 AM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>
>>> One of the protected ranges was too small (compared to the data we
>>> have downstream). Fix it.
>>>
>>> Fixes: 408434036958 ("drm/msm/a6xx: update/fix CP_PROTECT initialization")
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>> index 503c750216e6..d6b38bfdb3b4 100644
>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>> @@ -690,7 +690,7 @@ static const u32 a6xx_protect[] = {
>>>          A6XX_PROTECT_NORDWR(0x00800, 0x0082),
>>>          A6XX_PROTECT_NORDWR(0x008a0, 0x0008),
>>>          A6XX_PROTECT_NORDWR(0x008ab, 0x0024),
>>> -       A6XX_PROTECT_RDONLY(0x008de, 0x00ae),
>>> +       A6XX_PROTECT_RDONLY(0x008d0, 0x00bc),
>>
>> Nak, this is intentional, we need userspace to be able to configure
>> the CP counters.  Otherwise this would break fdperf, perfetto, etc
>>
>> (although maybe we should comment where we diverge from downstream)
> 
> Yes, please. Otherwise it is extremely hard to understand the reason for diversion between the vendor driver and our one.
+1

I am content with dropping this patch from this series, so long
as you leave a clue for others to not scratch their heads on this!

Konrad
> 
>>
>> BR,
>> -R
>>
>>>          A6XX_PROTECT_NORDWR(0x00900, 0x004d),
>>>          A6XX_PROTECT_NORDWR(0x0098d, 0x0272),
>>>          A6XX_PROTECT_NORDWR(0x00e00, 0x0001),
>>> -- 
>>> 2.39.1
>>>
> 
