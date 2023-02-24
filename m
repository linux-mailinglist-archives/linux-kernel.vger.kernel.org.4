Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B5D6A1B0B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 12:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjBXLDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 06:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjBXLCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 06:02:46 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3ED6ADF8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:01:01 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p3-20020a05600c358300b003e206711347so1514810wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YQXdthJWktVg+AfZN3EoP9jJpFIjhltnajA7ETUKP00=;
        b=IF92FQ4Yrs/99XAN+aqzcbXp4q8ualq5rHhtoMYPBPlGl+yLUC1qMVQp1MDew/kI5W
         dyucBtwA4rU7jqF9GMi8YqoVxBlp5+mmjE1fNgQ1XqogirLvoMlzMA1u8vJWL2mlm9O5
         dvtqdu8v6Qbjnsczl1sAnAfmy7qNcMAo+Yk8Oy41pceC5k6mDReHfciIhqWCR1CYKQwx
         haS1KGir4qcCazCkrw5yF1C/MAiEbn1FFaReSc1D1kehH7TB0/aCrwkK5nqZ87xNirsz
         sNYC5iAFoqnZU8koEuYwjKku4tgWtVgQBBQiVYXZjWvRgRu84yvqpy9i/ME2jxgbz0FJ
         AdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQXdthJWktVg+AfZN3EoP9jJpFIjhltnajA7ETUKP00=;
        b=acYuyUPN5Kn4yUe3YND4KFQusgeagIr0s4hnieOPLaXLGEwOX25bWKFMfUYkV2v2Ki
         GgAySuXg0uadpHl/y9c3WOk4366sQgfKhyGtCjOu5M0fnZExKZbd8VOSr9eJm/jkbD9D
         i/ObZrM/F12723ZFaDPycFSi+qtxSfe/OWBkKUyur3YYCUbh8ZHgfq2BI/qunXaUkTiR
         lkh8CH2sV5RbOHGXuO5Pj6jSHj7osGv46v/7eRmhUU4xwA+cQYt6EzmWXZDYvH9TtWY8
         p5vQqFV09DPZJhiPUTtPyxlumXOGijje+bRp70oWHHxCSRkD/2h4EbtsT+YhtUHd7gwq
         COuA==
X-Gm-Message-State: AO0yUKUlWo/Pc780JAtfT6Fm5NX+zGYYMujGbvo/o/6lpcCCGbOkYI0H
        tUi6xgJhhudyghirPiyOg740+w==
X-Google-Smtp-Source: AK7set9dHj9kLkZPaISJBsJ10O8wJ3m2rq4+MiUJiAJbe2kWTXSiXT1NDaqULWv9AGtBmE4CHqkD5Q==
X-Received: by 2002:a05:600c:3b1e:b0:3ea:e5fc:a5a4 with SMTP id m30-20020a05600c3b1e00b003eae5fca5a4mr2599117wms.1.1677236457750;
        Fri, 24 Feb 2023 03:00:57 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id fm19-20020a05600c0c1300b003e22508a343sm2535437wmb.12.2023.02.24.03.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 03:00:57 -0800 (PST)
Message-ID: <c4ee1a7b-a500-5fa5-6a97-93b1eba2c852@linaro.org>
Date:   Fri, 24 Feb 2023 12:00:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/4] ASoC: dt-bindings: wlf,wm8524: Add a property to
 specify power up sequency time
Content-Language: en-US
To:     Chancel Liu <chancel.liu@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20230222113945.3390672-1-chancel.liu@nxp.com>
 <20230222113945.3390672-2-chancel.liu@nxp.com>
 <506f92cd-7cf5-4fd5-a930-9af086732f84@linaro.org>
 <VI1PR04MB42221B1708BA02B1FA2149D9E3A89@VI1PR04MB4222.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <VI1PR04MB42221B1708BA02B1FA2149D9E3A89@VI1PR04MB4222.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2023 11:54, Chancel Liu wrote:
>> On 22/02/2023 12:39, Chancel Liu wrote:
>>> This property specifies power up to audio out time. It's necessary
>>> beacause this device has to wait some time before ready to output audio
>>
>> typo... run spellcheck, also on the subject
>>
>>> after MCLK, BCLK and MUTE=1 are enabled. For more details about the
>>> timing constraints, please refer to WTN0302 on
>>>
>>>
>>> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
>>> ---
>>>  .../devicetree/bindings/sound/wlf,wm8524.yaml          | 10
>> ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8524.yaml
>> b/Documentation/devicetree/bindings/sound/wlf,wm8524.yaml
>>> index 09c54cc7de95..54b4da5470e4 100644
>>> --- a/Documentation/devicetree/bindings/sound/wlf,wm8524.yaml
>>> +++ b/Documentation/devicetree/bindings/sound/wlf,wm8524.yaml
>>> @@ -21,6 +21,15 @@ properties:
>>>      description:
>>>        a GPIO spec for the MUTE pin.
>>>
>>> +  wlf,power-up-delay-ms:
>>> +    maximum: 1500
>>
>> maximum is 1003. Where do you see 1500?
>>
>> minimum: 82
>>
> 
> Yes, you are absolutely right. From the power up to audio out timing table in
> WTN0302, the minimum number is 82 and the maximum is 1003.
> 
> Consider the following possibilities:
> 1. These timings may depend on the system design
> 2. These timings may be simulated results
> 3. These timings may be the minimum values
> 
> I set a larger value trying to extend the time. The larger value of course
> introduces unwanted time delay but it benefits on avoiding beginning audio
> lost.
> 
> I also did some tests on a board. If I want to work on 48KHZ sample rate and
> 512FS, the recommended value is 143. But the test result showed 143ms is not
> enough. I increased the value to 500ms and could hear the beginning sound.

Maybe you miss proper regulator ramp-up?

> 
> Maybe it's a better choice to let DT set the suitable value? Is there a similar
> situation before?

That's not really good argument. DT should describe hardware and if this
property does not match hardware, it means you mix this with something
else. Something not for DT.


Best regards,
Krzysztof

