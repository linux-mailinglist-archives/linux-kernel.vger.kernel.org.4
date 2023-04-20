Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6716E9470
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbjDTMc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbjDTMcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:32:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA21810CE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:32:35 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so3849316a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681993954; x=1684585954;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=53J0OnnwTTvP3fEiCKzAu0mdWJJtadmQyC8IMtn5GfY=;
        b=OIoKuGGijqyWw4bJYWhYgr9uuEf0oWAOGkW7aBrODsmZWuHO3V4uchC7+TTQhxL9uj
         N+o6GX3yZomqIWPoVU8xl8+n1NvsLN/XY0EduU22cTeIyY9U4KIlz1O+SAjfHUVU1cfL
         XETLDBe9ZqrMvaxfS3NQjXRf5Xetme2B4n9g5ykRxhShiVEI5L2hf7a7oqpmx+cUNnT8
         uKlL9aYYxwjyFpsGvtiiLfOdk6Ubc9vqfOaVkSxyPSgZPxQpZYnjX/lW4ZE/Sbli7nia
         ulLNs1kuN/aGCTIWfNiiklBsGOuFOrzcaopqLIaBOAHLq6hwM2L/xP7aAoY1AUaSLIL6
         INNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681993954; x=1684585954;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53J0OnnwTTvP3fEiCKzAu0mdWJJtadmQyC8IMtn5GfY=;
        b=aINCC4nShoQ2TeUqOmoxUlzfVpKTTVTAWP7DZSP5nmSE9+MH7gwQN/vtG/At63zEMR
         Y/OXvCwxzqPvLpHr37cdVBt7WHHZZGzZyZ6rqPxqqJHtAWAiTWifdrchrR+7wwIUYSw5
         Xkm6DqgrThIGtpkI2YTXIorHFXL+w3jY+GVOHcf7zwRtjgyOgEbDFsUsmJikNI6cLAwY
         gta0KYQLbotV2Buzb10hbMLuTh4EyiGqEBC7aMDe/K8DcanXSy+C5bFt/rnYLWnPu+ue
         LicN2IZJ1QDkJA/KSvfedyC6EKTwFYSC0T43azDJw4hOFJ9l5DeXZjB3kXkyhJ829Hat
         RGRw==
X-Gm-Message-State: AAQBX9ds7qmRMsF6X8hH4tHoXiNi+m4qmNzWJY6fsphlcgEQ6ueuy6RP
        sO68d4di+rooz2hUMEvr51cEBw==
X-Google-Smtp-Source: AKy350bv1wfr1ZJ4XXmpodBIBbP1QCVtJLNuvfULoIwjZ8rzdQgW4efe5Z2wJ9xDI4AyZKxIj8vLsA==
X-Received: by 2002:a05:6402:d1:b0:506:c238:4067 with SMTP id i17-20020a05640200d100b00506c2384067mr1451932edu.8.1681993954366;
        Thu, 20 Apr 2023 05:32:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bcb8:77e6:8f45:4771? ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id p19-20020a05640210d300b005067d089aafsm707694edu.11.2023.04.20.05.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 05:32:34 -0700 (PDT)
Message-ID: <090a1baf-ba2e-669f-7e31-cd97d1d5a970@linaro.org>
Date:   Thu, 20 Apr 2023 14:32:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/6] ASoC: wcd938x: switch to using gpiod API
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <fe6202ee-2552-8b5c-c2d5-f2f7042b901d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2023 14:30, Krzysztof Kozlowski wrote:
> On 20/04/2023 13:58, Mark Brown wrote:
>> On Thu, Apr 20, 2023 at 12:16:12PM +0200, Krzysztof Kozlowski wrote:
>>
>>> -	gpio_direction_output(wcd938x->reset_gpio, 0);
>>> -	/* 20us sleep required after pulling the reset gpio to LOW */
>>> +	gpiod_set_value_cansleep(wcd938x->reset_gpio, 1);
>>> +	/* 20us sleep required after asserting the reset gpio */
>>
>> This is inverting the sense of the GPIO in the API from active low to
>> active high which will mean we're introducing a new reliance on having
>> the signal described as active low in DT.  That's an ABI concern.
> 
> It's bringing it to the correct level. Old code was not respecting the
> DTS thus if such DTS came with inverted design, the driver would not work.
> 
> We were already fixing the upstream DTS users and I thought all of them
> are fixed since long time (half a year) or even correct from the
> beginning. Now I found one more case with incorrect level, which I will fix.

No, my bad - all upstream DTSes are corrected since half year.

> 
>>
>> I remain deeply unconvinced that remapping active low outputs like this
>> in the GPIO API is helping.
> 
> The code is mapping them to correct state. The previous state was
> incorrect and did not allow to handle active high (which can happen).
> This is the effort to make code correct - driver and DTS.

Best regards,
Krzysztof

