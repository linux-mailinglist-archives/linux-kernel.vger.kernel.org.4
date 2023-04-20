Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FF36E96DB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjDTOSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjDTORu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:17:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE5D6E85
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:17:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id vc20so6652680ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682000221; x=1684592221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2wQNlD/zbZubVbAb6VQ4BMWQUxzOi/x1fP1cdt2Qu0U=;
        b=CEG9kZmAnGhpNiLQzNWUaanr8TDi+itdH6w6BGOHZV/L3Khz0ly4xEA6gOdmHxZAlb
         va83cflx0YB2yZcMQY9uMW0TpxNvxehn9oHGxtjCt4/9u4rUbiBuT0dVeY5NFlxvx2cB
         bRb8X6MSjNs20/5o9kMnm8w9QWTAWNu/kiwWEfMFRzuWhnfdPkPKFFdbmyPKcN3bDPtg
         z+oEVSu3+7bKJVVbhSwN+EsWcpG+NC9H7gWiTkQie0CUO2aN04WEHKB7JHuKsykGUrvn
         HJXGkYX+CUHMsushEYqon31xu4I6Q8lD8aeUhH3/dnEeMihCJoWmWeretCmKy+9Lrl42
         FSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682000221; x=1684592221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wQNlD/zbZubVbAb6VQ4BMWQUxzOi/x1fP1cdt2Qu0U=;
        b=A2WTZJ/k6TpLUH6wHlJ+aPGkGDwxvt3VLRGwknjtGHxm0DjIu0Em8IYx8oLrsnPkNi
         MOf3ftuKJ8D7HdA8Sv1AlWJfkmIot3M36DT9HvBWngHsvuci2ZpSicDwX273Ft4FEoTb
         u7e0sPfIgWuRZvqVInGXeSX1/EPlrwdC/BOH9L03RPTNQyFb++XDhG6fU8Yi5XxKNEGx
         sBang+OiOnIyc6Hu1koDnS3Pec7uSz0zsn/fQCOlzuKgReIjHQ9r/C0fiQlsla3NrGm8
         8n2vnvpLQ0xqzTMsQbezebb6gNW1Z5FF7BQVlcvBp4HyOTLxU7vNYwm7bCZR+Hxo82um
         HzJQ==
X-Gm-Message-State: AAQBX9fscQSEGb+DygQGMg6+2s3reC0lIhTISK3WHbbiSo21tZMeqhMk
        jdmbv5AWxUT++V4Fo+G4LuoRsw==
X-Google-Smtp-Source: AKy350aRuYn9h0pCNvXsQuwGrEtaGF1pLj3VELsUGLD94aFA63MGBQRcR7yq4IQshi2XqiqXYm/pqg==
X-Received: by 2002:a17:906:a9b:b0:94f:3521:394 with SMTP id y27-20020a1709060a9b00b0094f35210394mr1655353ejf.51.1682000220961;
        Thu, 20 Apr 2023 07:17:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bcb8:77e6:8f45:4771? ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id mb20-20020a170906eb1400b0094f432f2429sm773438ejb.109.2023.04.20.07.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 07:17:00 -0700 (PDT)
Message-ID: <3eb0cbb4-f6d9-db8a-031e-92627e70f41e@linaro.org>
Date:   Thu, 20 Apr 2023 16:16:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/6] ASoC: wcd938x: switch to using gpiod API
To:     Mark Brown <broonie@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Patrick Lai <quic_plai@quicinc.com>
References: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
 <20230420101617.142225-2-krzysztof.kozlowski@linaro.org>
 <6b355201-a957-4fca-a513-d5fa0742fb40@sirena.org.uk>
 <fe6202ee-2552-8b5c-c2d5-f2f7042b901d@linaro.org>
 <d746ee5f-283d-44ce-b72c-18c8955d38b1@sirena.org.uk>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d746ee5f-283d-44ce-b72c-18c8955d38b1@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2023 15:00, Mark Brown wrote:
> On Thu, Apr 20, 2023 at 02:30:17PM +0200, Krzysztof Kozlowski wrote:
>> On 20/04/2023 13:58, Mark Brown wrote:
>>> On Thu, Apr 20, 2023 at 12:16:12PM +0200, Krzysztof Kozlowski wrote:
> 
>>>> -	gpio_direction_output(wcd938x->reset_gpio, 0);
>>>> -	/* 20us sleep required after pulling the reset gpio to LOW */
>>>> +	gpiod_set_value_cansleep(wcd938x->reset_gpio, 1);
>>>> +	/* 20us sleep required after asserting the reset gpio */
> 
>>> This is inverting the sense of the GPIO in the API from active low to
>>> active high which will mean we're introducing a new reliance on having
>>> the signal described as active low in DT.  That's an ABI concern.
> 
>> It's bringing it to the correct level. Old code was not respecting the
>> DTS thus if such DTS came with inverted design, the driver would not work.
> 
> Sure, but OTOH if the user didn't bother specifying as active low it
> would work.  I suspect it's more likely that someone missed a flag that
> had no practical impact in DT than that someone would add an inverter to
> their design.
> 
>> We were already fixing the upstream DTS users and I thought all of them
>> are fixed since long time (half a year) or even correct from the
>> beginning. Now I found one more case with incorrect level, which I will fix.
> 
> That's just upstream, what about any downstream users?

Life of downstream. We all know the drill: merge your DTS or suffer. The
WCD938x codecs are moderately new, so I do not expect many downstream
users. They are in theory possible, because driver was merged in
v5.14-rc1 and for the newest products Qualcomm uses v5.15. Although now
it is v5.15, but the time driver was merged, maybe it was v5.10.

I could rework this patch to provide backwards compatible solution like
I did for WSA:
https://lore.kernel.org/all/20230102114152.297305-4-krzysztof.kozlowski@linaro.org/

There are downsides of it, but as you pointed out - it's actually very
rare to have the signal inverted in hardware.

> 
>>> I remain deeply unconvinced that remapping active low outputs like this
>>> in the GPIO API is helping.
> 
>> The code is mapping them to correct state. The previous state was
>> incorrect and did not allow to handle active high (which can happen).
>> This is the effort to make code correct - driver and DTS.
> 
> We could handle inversions through an explicit property if that were
> needed, that would be a less problematic transition and clearer in the
> consumer code.

I am not sure if it is worth. The DTS is supposed to describe hardware,
so even if reset pin flag was not effective, it is a mistake to describe
it as ACTIVE_HIGH. Do we care about keeping broken code happy? If yes,
then property is the way to go. If partially, then I can add
backwards-compatible approach like I mentioned above.

Best regards,
Krzysztof

