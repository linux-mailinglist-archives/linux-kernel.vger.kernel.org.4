Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94DA706C29
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjEQPGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjEQPGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:06:19 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184B49EE2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:05:47 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-966400ee79aso162502566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684335945; x=1686927945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7BOy4FSGNqefaEpSBoTmIV0Oe+hDmf74/cix89skF8=;
        b=BJZCX8+NQE8s8/ZcBGgtgef+UHaisFamgfUCi7Ak9j14S/duLsQcP+hyMrZMsjIlyB
         bJgySOeof8QfTn5HvbKtc3d8t7KMD8C3YcsXyeJAISP5+54s+wobch4kWzZ86pTXQgcc
         R5+rhxHT0GTkton0K7v3wpD+Rjjcb46LrOXDXETvtmtiZc/1QrD0JsqPP+Q+q8nSXSzG
         JLFzl5bXaajnKGoQF6UxI8cOyZbt58kIcfZ+jqXCl33kTpxoE7jHRhU3iPpUc1FmBZV5
         EW1TLzRtfD97AMMZyP3IM/0F6DjMKGc0BOl3WwolZLR/dpy2j/sn8egoKYg3rswzRji3
         Ui4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335945; x=1686927945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7BOy4FSGNqefaEpSBoTmIV0Oe+hDmf74/cix89skF8=;
        b=HVzSvhbSmLl/fvfuybLlnaCTd4fHJ+bBr0o3vP4UHHXJRt4gFztI+NrAYfkVeJC6ob
         1Se96X5tz2MtMRRh4XheCcFPLEPIa4NbwpXWi3sYBL8cRDg1nXhTJqzKjTUfuoxtO6sx
         3W6pjWzmSyXpD7o/yJgQfl2csWUSI6IuHWhEQWqn1XWQ7/D/PI4Cqu9nWSpZEzhu509m
         HRnAPq1jxvph5fn0CSoMhIE/yxkVoahOBwTPfwhpBihvSCzqUn8uWd4S2KzROshKrrNN
         jDr6phPvhODl744oI4nrLoAOUJfIoUP6McdDQnce0ZdCB8tIWmJphSCaS6tr+Wq7dlJv
         O73w==
X-Gm-Message-State: AC+VfDwIneZTh76MKkAVbK0igGmVzCM8egr7HOhNDmx8zbzflnV6aImJ
        1yGZE7hWCiFzDRDZdx3WD7wy9A==
X-Google-Smtp-Source: ACHHUZ4ykofwG6zQif9mweu8SLtYDXQ2+EtbWBnML7IrDjqNdvQtENrAs37ipaNaq1GCOTpc8m9u7w==
X-Received: by 2002:a17:906:ee82:b0:94f:1a23:2f1c with SMTP id wt2-20020a170906ee8200b0094f1a232f1cmr34270045ejb.50.1684335944712;
        Wed, 17 May 2023 08:05:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c9ff:4c84:dd21:568d? ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id n17-20020a170906725100b0096a6bf89259sm8932962ejk.167.2023.05.17.08.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 08:05:44 -0700 (PDT)
Message-ID: <8de36fc1-51f9-9c34-63c0-18700d90b95e@linaro.org>
Date:   Wed, 17 May 2023 17:05:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXTERNAL] Re: [PATCH v2 2/5] ASoC: dt-bindings: Add tas2781
 amplifier
Content-Language: en-US
To:     "Ding, Shenghao" <shenghao-ding@ti.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Shenghao Ding <13916275206@139.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Lu, Kevin" <kevin-lu@ti.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Baojun" <x1077012@ti.com>, "Gupta, Peeyush" <peeyush@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        "gentuser@gmail.com" <gentuser@gmail.com>,
        "Ryan_Chu@wistron.com" <Ryan_Chu@wistron.com>,
        "Sam_Wu@wistron.com" <Sam_Wu@wistron.com>
References: <20230508054512.719-1-13916275206@139.com>
 <ca9d45cf-8a84-4fbc-e1dd-c96eef36fe25@linaro.org>
 <ZFyBzHWo3ORKAskX@finisterre.sirena.org.uk>
 <ca2ed8e9-850a-56c5-e395-72e5861b9c71@linaro.org>
 <3c48d5e47aff478b8ce8998d7efe001b@ti.com>
 <3e62d34b-a439-ac42-83a1-deb26ade63ff@linaro.org>
 <26c335994d91492eb9439483ac98f61c@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <26c335994d91492eb9439483ac98f61c@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 14:24, Ding, Shenghao wrote:
> 
> 
> On 11/05/2023 15:19, Ding, Shenghao wrote:
>>
>> On 11/05/2023 07:49, Mark Brown wrote:
>>>> Missing minItems, but...
>>>
>>>>> +    items:
>>>>> +      minimum: 0x38
>>>>> +      maximum: 0x3f
>>>
>>>> ... So these are fixed? No need to encode them in such case...
>>>
>>> I'm not sure I understand your concern here, there's up to 4 possible 
>>> values from 0x38-0x3f which has more than 4 possible values.
>>
>> Aren't the addresses going to be incremented by one (up to 8 of devices in total)?
> 
> With your style of replies, it looks like you wrote it...
> 
> All the addresses of tas2781 are in range from 0x38 to 0x 3f, the order of them in the audio-slots item are up to the hardware connections.
> I have studied the reg item to save multiple i2c addresses for multiple pieces of tas2781 and found that "'#address-cells':     maximum: 3"
> that means "reg" store not more than three addresses, this can't support the more than 3 pieces of tas2781, 

No entirely. This determines the size of each address, not the number of
addresses.

> such as 4-slot TDM case or multiple dual-membrane speakers case, in such a case, one speaker will use
>  two pieces of tas2781 to boost, usually at least 6 pieces of tas2781 will be used in a laptop or other device.
> 
>>
>> No, the i2c address order is not always monotonic increase or decrease, sometime it would be disorder, according to the application.
>> Each device would have eight possible i2c address, the final address depends on the hardware connections.
> 
> OK, the question about the broadcast is still there - cannot it be deduced?
> 
> The reason to define this item and add it in dts is that tell tas2781 driver code to enable broadcast and its address. 
> Removing this item means disabling broadcast. Do you want to hardcode the global address in the code?
> And this item only used as a flag to enable or disable?
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof, nice to talk with you!

I really do not know what is here mine what's yours. I could guess, but
we are all a bit busy, so I would appreciate if reading your email was
easier for me.

Best regards,
Krzysztof

