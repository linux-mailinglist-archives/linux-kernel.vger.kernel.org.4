Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D92E6D0866
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjC3Oes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjC3Oer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:34:47 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7725BA0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:34:45 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j11so24765303lfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680186884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2NO2kQrj7E3whQn36YJgoHX6xML1nFzG26j2cCHVyO4=;
        b=sdGdurYgtgDBx5tLVMmY+gEMW+qqgVF6YDSZmfNeziHGdaDC/stXYHbpj/7bfHG4UA
         2EqO0+gwDGkolx4o+j46o+DtRD2iZN49g7Eb8ylPfey1tJzVD89zMrTMpf81X1YQDxmS
         /ZUQsQlTt5I4bcQMt00lepEgCnf8bJXnu+lHhY/nShsVNKOv5dd+n7M34fyf8b63xL0K
         NfAezGDe6vvv+aBzSv1Xhb+5ldHh1nmBVFIX28f0yO86F3AR2dNRfu16AXM90SZ2gDfL
         ERwYpCAPTdahMU3DlWzYJEPCWwMk4zF0QWLIPGoG6ITGGVcpr2GL7FwRKnDojk4Ffg5p
         4uQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680186884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2NO2kQrj7E3whQn36YJgoHX6xML1nFzG26j2cCHVyO4=;
        b=YBp2mDfV4RsMEGYyCNNbrdDq5UIoAyJZB1qwrhp9MByxrqX96/65guK6HY7cpn1S+u
         T9O7i3aaY1ER44IAA9jaj3sysKXwRQM7JggKT+IMnyRPUlWI3XtNw4UM+GD6oFN5fgdO
         TxTNnvEhtSrhcKtWzVBg2UHjKLSufEmxhvnRgfgXCsWTI2OL0zcUvqScz+k0epkYjDht
         gk4jcH2rhEXYctPKn7VVRLv9QD1aBqXQdVKfb7aXXgRayn5tCkDeJufRqsrw2OzYTvfe
         pdE3PTPVN0l0hq/yroHTr/eWMYkkwacjlrwlh/2tROZcNzWZVP7b2vgrwH7wtw91n6YN
         0XiQ==
X-Gm-Message-State: AAQBX9daa/GMGqjdiAseY801+rUBudQjTTGNEzGM+OUX899dZoCGRuuQ
        aHjayZ1vwva6nKB+s55YDEWq+Q==
X-Google-Smtp-Source: AKy350ZEWGsNomZS724GjcMJTZnNBaTPFYO57SxiPJScbOy2pKJwktNH4/mfctfS9UOUv0uuY9RWSQ==
X-Received: by 2002:a05:6512:49c:b0:4e9:cb57:8fdc with SMTP id v28-20020a056512049c00b004e9cb578fdcmr6836457lfq.46.1680186884146;
        Thu, 30 Mar 2023 07:34:44 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id l16-20020a19c210000000b004dc4becfcd6sm5939188lfc.54.2023.03.30.07.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 07:34:43 -0700 (PDT)
Message-ID: <b985e536-227d-df86-0f23-b58882e9654b@linaro.org>
Date:   Thu, 30 Mar 2023 16:34:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/msm/adreno: adreno_gpu: Use suspend() instead of
 idle() on load error
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        andersson@kernel.org, agross@kernel.org,
        marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Johan Hovold <johan+linaro@kernel.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nathan Chancellor <nathan@kernel.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230329140445.2180662-1-konrad.dybcio@linaro.org>
 <ZCRNFitcrAeH27Pn@hovoldconsulting.com>
 <83986fa9-c9eb-ae5a-b239-584092f2cea5@linaro.org>
 <CAA8EJpohEo+kMw7fx5112m+z7JHSLDmsqOL4T7hmyvr2fPP8vQ@mail.gmail.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJpohEo+kMw7fx5112m+z7JHSLDmsqOL4T7hmyvr2fPP8vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.03.2023 21:45, Dmitry Baryshkov wrote:
> On Wed, 29 Mar 2023 at 18:48, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 29.03.2023 16:37, Johan Hovold wrote:
>>> On Wed, Mar 29, 2023 at 04:04:44PM +0200, Konrad Dybcio wrote:
>>>> If we fail to initialize the GPU for whatever reason (say we don't
>>>> embed the GPU firmware files in the initrd), the error path involves
>>>> pm_runtime_put_sync() which then calls idle() instead of suspend().
>>>>
>>>> This is suboptimal, as it means that we're not going through the
>>>> clean shutdown sequence. With at least A619_holi, this makes the GPU
>>>> not wake up until it goes through at least one more start-fail-stop
>>>> cycle. Fix that by using pm_runtime_put_sync_suspend to force a clean
>>>> shutdown.
>>>
>>> This does not sound right. If pm_runtime_put_sync() fails to suspend the
>>> device when the usage count drops to zero, then you have a bug somewhere
>>> else.
>> I was surprised to see that it was not called as well, but I wasn't able
>> to track it down before..
> 
> Could you please check that it's autosuspend who kicks in? In other
> words, if we disable autosuspend, the pm_runtime_put_sync is enough()?
> 
> That would probably mean that we lack some kind of reset in the hw_init path.
> 
> On the other hand, I do not know how the device will react to the
> error-in-the-middle state. Modems for example, can enter the state
> where you can not properly turn it off once it starts the boot
> process.
> 
> And if we remember the efforts that Akhil has put into making sure
> that the GPU is properly reset in case of an _error_, it might be
> nearly impossible to shut it down in a proper way.
> 
> Thus said, I think that unless there is an obvious way to restart the
> init process, Korad's pm_runtime_put_sync_suspend() looks like a
> correct fix to me.
On the GPU side, when you cut GX and CX GDSCs, the hardware is off.
Some clock / gdsc logic may be retained, but the GPU itself gets
cut off. Parking the clocks and shuttting down VDD_GX (if exists)
only makes that stronger.

> 
>>> Also since commit 2c087a336676 ("drm/msm/adreno: Load the firmware
>>> before bringing up the hardware") the firmware is loaded before even
>>> hitting these paths so the above description does not sound right in
>>> that respect either (or is missing some details).
>> ..but I did some more digging and I found that the precise "firmware"
>> that fails is the ZAP blob, which is not checked like SQE in the
>> commit you mentioned!
>>
>> Now I don't think that we can easily check for it as-is since
>> zap_shader_load_mdt() does the entire find-load-authenticate
>> dance which is required with secure assets, but it's obviously
>> possible to rip out the find-load part of that and go on from
>> there.
> 
> Yes, I think we should load all firmware early. ZAP shader is a bit
> unique since the DT can override the name, but it might be nice to
> check for its presence earlier.
> 
> At the same time it probably should not stop us from fixing the idle()
> vs suspend() bug.
I'm open to both solutions, as long as it can unblock me from
resubmitting the (hopefully) final version of GMU wrapper!

Konrad
> 
>>
>> Do you think that would be a better solution?
>>
>> Konrad
>>
>>>
>>>> Test cases:
>>>> 1. firmware baked into kernel
>>>> 2. error loading fw in initrd -> load from rootfs at DE start
>>>>
>>>> Both succeed on A619_holi (SM6375) and A630 (SDM845).
>>>>
>>>> Fixes: 0d997f95b70f ("drm/msm/adreno: fix runtime PM imbalance at gpu load")
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>  drivers/gpu/drm/msm/adreno/adreno_device.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
>>>> index f61896629be6..59f3302e8167 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
>>>> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
>>>> @@ -477,7 +477,7 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
>>>>      return gpu;
>>>>
>>>>  err_put_rpm:
>>>> -    pm_runtime_put_sync(&pdev->dev);
>>>> +    pm_runtime_put_sync_suspend(&pdev->dev);
>>>>  err_disable_rpm:
>>>>      pm_runtime_disable(&pdev->dev);
>>>
>>> Johan
> 
> 
> 
