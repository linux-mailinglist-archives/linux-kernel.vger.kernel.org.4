Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F054677701
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjAWJFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjAWJFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:05:19 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA4A1C33C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:05:18 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so10069936wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oS+QWfp3BJjZmstAo6/SyLcAAsRePrkk9Wn91q5sync=;
        b=ruhLYAnWhcJjwAr7+Y5mqFP0EHOa1LACnjVbqMO8RKIK9MyF10T8UYQXaLO3VIcsxZ
         FcQh6qrbEEs6KIrxHVEmOsOpO3rxvMbnmJGtf8qBXmg5nYi53L0IhidAYtGMv7ZyFzwz
         ArsaFRgp1OF514NSGbzx1OivfnQybUIoBydcxuEl6BMfLr+2qRxVxZQ0Zhe7XtqEU56B
         f4fQNCIFALcUgN8ps7rFbsX0Vw2SFB90uFMfpO07Yvh4v4yrHUEBJwNBVaFn8O0mUvuz
         rJTaJS/MIipfdGirESoVqTbXhEnyKBIfs3h/OfEpUEIvcJi6uiuU2uKBOebuO/nReDGY
         oHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oS+QWfp3BJjZmstAo6/SyLcAAsRePrkk9Wn91q5sync=;
        b=tULHRRfz8yG19hMcVCeeHzBX7Vg/Y/Bk0A6S/4KznGukO4grWaW1XUmzfEvMlEL8T8
         kj52I0HR1YKPOsEHAQ2+9ttL5ZXpWTAZuIu5epZikyYRKtMeQMNN4jaPQKwE2FZ5jGv9
         mTnXMwZurgNCBdn3Oj8iTLnFkeThU60+zc/5DdBcRKgw0wLmLsGaBPYh6ZNsIrTHdwRN
         tG1/Ny2EquqbMIz1vKvgHtNLDc6I6vExhi8HPWMhSRgZJzfb4wxPdvF4kQ2d1xt5Trq3
         0FkPp1DLhSJVLAEnyg3zqeod/PHMXD6BMZDVr+N4V3QLvqgIyd37YqvdIJ1KjKlYCViM
         yNsQ==
X-Gm-Message-State: AFqh2kq/1wewAgKSY134jiQSi5RSGf/y7fVs49biuNWByi2XH4U1du6q
        M5OU/68znpux/fplheiaQxOy/w==
X-Google-Smtp-Source: AMrXdXvRDqDdYwOHNXOOo8g1OWFCe7j9cuIEARBMVi7yJFZEF0/n0LpZJuTVRkvWPjLj6mUzTuJItQ==
X-Received: by 2002:a05:600c:1d8e:b0:3d9:f9ef:3d23 with SMTP id p14-20020a05600c1d8e00b003d9f9ef3d23mr23398735wms.23.1674464716684;
        Mon, 23 Jan 2023 01:05:16 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b003db315d4d02sm10430487wmq.33.2023.01.23.01.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 01:05:16 -0800 (PST)
Message-ID: <21ea0402-c4f3-1344-d084-9f3138713abb@linaro.org>
Date:   Mon, 23 Jan 2023 10:05:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 4/4] ASoC: dt-bindings: ti,ts3a227e.yaml: add jack-type
Content-Language: en-US
To:     Astrid Rost <astridr@axis.com>, Astrid Rost <astrid.rost@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dylan Reid <dgreid@chromium.org>
Cc:     kernel@axis.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230120102555.1523394-1-astrid.rost@axis.com>
 <20230120102555.1523394-5-astrid.rost@axis.com>
 <2d05a943-3510-5ee9-9906-247a6344190a@linaro.org>
 <0b0c0030-3587-5501-c7b2-eccbbe4551e0@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0b0c0030-3587-5501-c7b2-eccbbe4551e0@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 09:39, Astrid Rost wrote:
> Hello Krzysztof,
> 
> On 1/22/23 15:16, Krzysztof Kozlowski wrote:
>> On 20/01/2023 11:25, Astrid Rost wrote:
>>> Add jack-type: Bitmap value of snd_jack_type to allow combining
>>> card drivers to create a jack for it.
>>
>> Subject: drop "yaml". We do not filename extensions to subject prefix.
>> Nowhere.
>>
> 
> yes, true.
> 
>>>
>>> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
>>> ---
>>>   Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
>>> index 785930658029..1d949b805f98 100644
>>> --- a/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
>>> +++ b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
>>> @@ -27,6 +27,14 @@ properties:
>>>     interrupts:
>>>       maxItems: 1
>>>   
>>> +  jack-type:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: Bitmap value of snd_jack_type to allow combining
>>> +      card drivers to create a jack for it. Supported is
>>
>> Why the device would once support (allow) headphone and once not? Device
>> either always supports them or never...
>>
> 
> If a device has two connectors (pink and green), one for the microphone 
> and one for the headset. 

We talk about "ts3a227" here, which has always two connectors (pins)...
unless you refer to the case when these are e.g. grounded?


> It would be easier to see from the available 
> events, which is which. But of course it is possible to give it good names.
> My first approach was, that it returned all supported types, so no 
> devicetree change needed. But by colleges agreed that it would be nice
> to remove unused flags. I am happy to remove it and someone who requires 
> it can add it.
> 
>>> +        1 SND_JACK_HEADPHONE
>>> +        2 SND_JACK_MICROPHONE
>>
>> minimum and maximum
> 
> I do not understand this? It is a bitmap. I can put it as an
> enum:
>   - 1 # SND_JACK_HEADPHONE
>   - 2 # SND_JACK_MICROPHONE
>   - 3 # SND_JACK_HEADPHONE | SND_JACK_MICROPHONE


Then maximum is OR of them, isn't it?

Best regards,
Krzysztof

