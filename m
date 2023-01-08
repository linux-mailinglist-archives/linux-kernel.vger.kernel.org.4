Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E676615F3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 15:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjAHOzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 09:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjAHOzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 09:55:49 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCFDF59C
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 06:45:48 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso7133338wms.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 06:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Mpmz+UXTscBPJqkv/dsExuqIz2qYdum1EIzJT1D6w8=;
        b=JgXnBo7vPrw+9v3Sq2TJ04hPA5lgdh+yWMSKE8gs+pK37WAqW3MhLRbdIKE0M+QehT
         QRQ5bbjgszn5W8nHbUBYwVm5y3m/sHmE9dv2ZBZdtKtNS1m5GIxr0R+H5BlOAAVbzTic
         exdrXCwZfWeZ+bXiEN0C2e9F2j3lC1xZMmd/rl7bpJ0LmfpD1OaLNRod8m82f9pGRUEU
         Ua1kCrarKi/dGGDxrgTy5NDH7FNu4IeQsgwR/PPBdGD0PX19i8ao28Bv7nAacXvRRyrZ
         aDezgpThskETJ0eptiAisTJdWVyf/opqdKuPVn9077odA4L7yvQG4WOYrxVTsUupt9J1
         vEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Mpmz+UXTscBPJqkv/dsExuqIz2qYdum1EIzJT1D6w8=;
        b=hbUP0VxOpEQr7RpwNontk9W5XNg0uJ9GGvCIQU8fGpwnEZZFzvdM4AuMLE6cbgX6Aq
         h72WLzdX8zw2kEfl0uuQiroZLjwpOOUUrec6J9UnpAE1mh/09yLqVgmt6eFfVAPISVAJ
         eyOXRX7foTCoetWFt15WwBHSB1Z7vGR9noBTcRaXcl7XvfI1yhiAr4rX7Q/ASI5eNsi7
         0m6l+n8zsFWvPI+a0nx7nYWhhv054V24870AO9maIVaEeB4LV7/DP6bc9AnDI/i29teF
         Vqk+XabBzUQqhv4J9a1GjENdcU+28vMvKx26iwJIDQn1Tpl8UkYlMGskIhfE6pcd2JiP
         J8NQ==
X-Gm-Message-State: AFqh2kq969v1zTRT5brqN0FRjR5nBFACFaJ8lb841q3obB54chxlz4wC
        a8zYBWQ7sSYCs9dOsXjv3wTqnQ==
X-Google-Smtp-Source: AMrXdXsl5eYxlz8wqdth9/xC2bBbckKnezMmPEGbx8Vo8cCpKEWLDq4D2k7aN0yE4ZJA6Pw+irCKAQ==
X-Received: by 2002:a05:600c:4f54:b0:3d9:f04c:f58f with SMTP id m20-20020a05600c4f5400b003d9f04cf58fmr63157wmq.40.1673189146870;
        Sun, 08 Jan 2023 06:45:46 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y7-20020a7bcd87000000b003d997e5e679sm9449765wmj.14.2023.01.08.06.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 06:45:46 -0800 (PST)
Message-ID: <70474070-404b-2fbe-2575-4810f6fbda91@linaro.org>
Date:   Sun, 8 Jan 2023 15:45:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: allow more compatible
 combinations
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230105213856.1828360-1-andreas@kemnade.info>
 <d7c407dc-0a6c-97d5-a06f-b432a923d74d@linaro.org>
 <20230106203358.14878660@aktux>
 <967cc7b7-f0bb-de37-52b9-7bfab05eadd7@linaro.org>
 <20230107144336.2ecff4f9@aktux>
 <123d1a56-8134-dc75-8b2a-b3836e727d4a@linaro.org>
 <20230107150740.0ba34aa1@aktux>
 <0ab84fb8-6173-54e0-abad-a0e0e4ba82e7@linaro.org>
 <20230107160105.66df4136@aktux>
 <e1b1450b-9421-3732-2d74-50c47b5afb0e@linaro.org>
 <20230107165457.30f4dddf@aktux>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230107165457.30f4dddf@aktux>
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

On 07/01/2023 16:54, Andreas Kemnade wrote:
> On Sat, 7 Jan 2023 16:07:35 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 07/01/2023 16:01, Andreas Kemnade wrote:
>>> On Sat, 7 Jan 2023 15:09:24 +0100
>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>   
>>>> On 07/01/2023 15:07, Andreas Kemnade wrote:  
>>>>> On Sat, 7 Jan 2023 15:00:56 +0100
>>>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>>>
>>>>> [...]    
>>>>>>>> I asked to remove half-compatible. Not to enforce.
>>>>>>>>      
>>>>> so you are saying that allowing
>>>>> compatible = "A", "B" 
>>>>> is not ok, if B is not fully compatible. I agree with that
>>>>> one.    
>>>>
>>>> I did not say that. It's not related to this problem.
>>>>  
>>> You said "I asked to remove half-compatible" that means to me
>>> remove "B" if not fully compatible with A which sounds sane to me.
>>>   
>>>> Again - you cannot have device which is and is not compatible with
>>>> something else. It's not a Schroedinger's cat to be in two states,
>>>> unless you explicitly document the cases (there are exception). If this
>>>> is such exception, it requires it's own documentation.
>>>>  
>>> so conclusion:
>>> If having A and B half-compatible with A:
>>>
>>> compatible = "A" only: is allowed to specifiy it the binding (status quo),
>>>   but not allowed to make the actual dtsi match the binding documentation
>>>   https://lore.kernel.org/linux-devicetree/72e1194e10ccb4f87aed96265114f0963e805092.camel@pengutronix.de/
>>>   and
>>>   https://lore.kernel.org/linux-devicetree/20210924091439.2561931-5-andreas@kemnade.info/
>>>
>>> compatible = "A", "B" in the binding definition: is not allowed ("I asked to remove
>>>    half-compatible" (= removing B))  
>>
>> No, half compatible is the A in such case.
>>
> I think that there is some misunderstanding in here. I try once again.
> 
> Define compatible with "X" here:
> To me it means:
> 
> device fully works with flags defined in:
> 
> static const struct esdhc_soc_data usdhc_X_data = { ... };
> 
> with usdhc_X_data referenced in
>         { .compatible = "X", .data = &usdhc_X_data, },
> 
> 
> So if there is only "A" matching with above definition of compatibility
>   compatible = "A" would sound sane to me.
> 
> And scrutinizing the flags more and not just wanting to achieve error-free
> dtbs_check, I think is this in most cases where there is only "A". 
> 
> If there is "A" and "B" which match that compatibility definition, you
> say that only compatible = "A", "B" is allowed, but not compatible = "A".
> In that case I would have no problem with that.
> 
> But if there is only "A" but no "B" matching the above definition, I would expect
> that only compatible = "A" is allowed but *not* compatible = "A", "B".

Sorry, I don't follow. I also do not understand what "matching" means in
these terms (binding driver? of_match?) and also I do not know what is
the "above definition".

Devicetree spec defines the compatibility - so this is the definition.
There will be differences when applying it to different cases.

Best regards,
Krzysztof

