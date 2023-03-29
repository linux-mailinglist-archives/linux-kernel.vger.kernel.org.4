Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92556CED5A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjC2PtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjC2PtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:49:00 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974FB468B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:48:59 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a21so9449443ljq.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680104938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8jD8NVqtsPudciwhm8Tk75NT4wlLoElkTtYals9Zh3s=;
        b=PKp8ZyPYUiw16H1l/Agu1Uq/X0RhJ79mp3NP7m0jlPV/StUndLoQ357goARYFgOX4F
         QrlJRI8G2izmMQ/gHL21qr1I6bKibkBLgoNaNcIIJveQRYu5Xq5R/mgu+zTeA2ztD5G5
         6JSm8iy20Z5prXFolUXL8ZOsMtmdGrbabURIklMpJVYndk6txmfVSk4Ov2XBQ99X+iiB
         1CGIqAzaO7+S1XY2n4JMrmnp3vhjhroT6PX081yUUnqBul8g0L3mxoK0nzg8HhbfLsFg
         5MQEtKVlHQrk+luDabREpnLgOI/CLsO9jH96uEt2pTty3ZacA54NZi89k0HSzMYtKbvJ
         jPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680104938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8jD8NVqtsPudciwhm8Tk75NT4wlLoElkTtYals9Zh3s=;
        b=ZjQEr4PvxLHI/mbYNlvesyYYCLP9oKIjXZtBKLp+EBUYULzt6Rh3mASmmyxjZRzufX
         bCQVVsWCa37DQiZRcCOgMM+FaozFoj9hOcLYOjTF0qmEHW78vmhDlsztGDAuPEo5+uYT
         yJdrydV55GSMUGQViR/EyQnqaHBtc2f7Mcx2Uf70usN2/67Psi5KutPnvjhpnbkbHdxo
         Iv5OMuwYtKt4L4NVPPKcnZsmXw7KDn8Yx/WvfIKmG5hjA2DhL6LsdrwM/BZCWLGxNaFt
         TQhkj3f9plr+03mypULXCdUy3XB1OQWI607pt/C3sNbWDwZ6RMD4EXWZIJERwx3MdCWu
         7ECA==
X-Gm-Message-State: AAQBX9e/e/PGtQT3wTdHg4hTgqlMgBXoVV6J+G9bYe1Zoy4RT2kXr/9+
        Ab3SjJMLknSFo0rDENjs8YPdRw==
X-Google-Smtp-Source: AKy350bZwb0nN1eKm+plrJvvRh6qWAf4xzfzhIpDrFsv1Xnvma4OkZ7P9lJEitJzajVJLNdExNnbaw==
X-Received: by 2002:a2e:8604:0:b0:290:5166:7c28 with SMTP id a4-20020a2e8604000000b0029051667c28mr7077535lji.20.1680104937770;
        Wed, 29 Mar 2023 08:48:57 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id u14-20020a2e854e000000b00299ab2475ebsm5546763ljj.1.2023.03.29.08.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 08:48:57 -0700 (PDT)
Message-ID: <83986fa9-c9eb-ae5a-b239-584092f2cea5@linaro.org>
Date:   Wed, 29 Mar 2023 17:48:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/msm/adreno: adreno_gpu: Use suspend() instead of
 idle() on load error
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, marijn.suijten@somainline.org,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZCRNFitcrAeH27Pn@hovoldconsulting.com>
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



On 29.03.2023 16:37, Johan Hovold wrote:
> On Wed, Mar 29, 2023 at 04:04:44PM +0200, Konrad Dybcio wrote:
>> If we fail to initialize the GPU for whatever reason (say we don't
>> embed the GPU firmware files in the initrd), the error path involves
>> pm_runtime_put_sync() which then calls idle() instead of suspend().
>>
>> This is suboptimal, as it means that we're not going through the
>> clean shutdown sequence. With at least A619_holi, this makes the GPU
>> not wake up until it goes through at least one more start-fail-stop
>> cycle. Fix that by using pm_runtime_put_sync_suspend to force a clean
>> shutdown.
> 
> This does not sound right. If pm_runtime_put_sync() fails to suspend the
> device when the usage count drops to zero, then you have a bug somewhere
> else.
I was surprised to see that it was not called as well, but I wasn't able
to track it down before..

> 
> Also since commit 2c087a336676 ("drm/msm/adreno: Load the firmware
> before bringing up the hardware") the firmware is loaded before even
> hitting these paths so the above description does not sound right in
> that respect either (or is missing some details).
..but I did some more digging and I found that the precise "firmware"
that fails is the ZAP blob, which is not checked like SQE in the
commit you mentioned!

Now I don't think that we can easily check for it as-is since
zap_shader_load_mdt() does the entire find-load-authenticate
dance which is required with secure assets, but it's obviously
possible to rip out the find-load part of that and go on from
there.

Do you think that would be a better solution?

Konrad

> 
>> Test cases:
>> 1. firmware baked into kernel
>> 2. error loading fw in initrd -> load from rootfs at DE start
>>
>> Both succeed on A619_holi (SM6375) and A630 (SDM845).
>>
>> Fixes: 0d997f95b70f ("drm/msm/adreno: fix runtime PM imbalance at gpu load")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/gpu/drm/msm/adreno/adreno_device.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
>> index f61896629be6..59f3302e8167 100644
>> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
>> @@ -477,7 +477,7 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
>>  	return gpu;
>>  
>>  err_put_rpm:
>> -	pm_runtime_put_sync(&pdev->dev);
>> +	pm_runtime_put_sync_suspend(&pdev->dev);
>>  err_disable_rpm:
>>  	pm_runtime_disable(&pdev->dev);
> 
> Johan
