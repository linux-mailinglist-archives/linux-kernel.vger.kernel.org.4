Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F1467FE5C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 11:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjA2KzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 05:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjA2KzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 05:55:16 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD99721A36
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 02:55:13 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso7476557wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 02:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oaz79ZDVJS2xEIGpS2k1SEdhnwOm02zjQ4lWcUyp8UU=;
        b=xldb5xqWjPFCCjZGiG8c3P2Ih66FBZxhANd7eM9nLWsJ58dgfulz8HCvh+2jcr7mxd
         1dibfhz72qfr6cXFG0rznplDOEuK9iwschVIOlQYRLHsCYWCNZjL/xJT+Ia1Timbk3DR
         9jsPO3BNKv76L6515odfRiCg/PdbbPZeb1z3qS5bWtlCwY/ObNZZLFZako+ZRC7UngTO
         6IS6AgK8QqGq7vdv1rOx0B+IlhG3UCUsS80I+jr5ZY8mtiieIQ9UjC4RKl5UC3eTVmde
         Oe1KUBDIhTL6u/HqMcr44xtP6XgWvWe5uLYdJlAEuc7VTjZlK6x8r4v3XjrjgzR88wRh
         S64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oaz79ZDVJS2xEIGpS2k1SEdhnwOm02zjQ4lWcUyp8UU=;
        b=Qn8qb/Y+yXzS1na9/ISZA9JLpVieLxVVGhPrw50pwKBM4akGuCUZGhD0OaBIYhJJFk
         IhSUIDahp9B2kL20iPQNI9uhuOEs2+iaX9Gbf/zbiE+YuZxpCfx7dRRYST8gpxThS6X7
         oTCKFd7kUkWAWxoLekBLpsPMY6zRxZohtYeX74jx8RqZziI9ADrJ72wWsGeGnMeM1xBJ
         3vw1kOYouutI2DmyDDPn5b6ZKOtWtmBZiroVk+qauO5gxwlyYmC9N6nWebUMAnBqNf8l
         T7xjma2vmuCA5eYwHZ9hJiklZjZoAcz1/eq8NTIb5RChjq/nVEI+/jVIbEyqVBRopYjr
         nM6g==
X-Gm-Message-State: AFqh2kretZpRGI1JkQVIdo+qMX1FXTEZOZ6ylJkmj5Yx//cmLgdcltWC
        pIM1ChbrLVIrThJu6PgzlhgBRA==
X-Google-Smtp-Source: AMrXdXuzfKrAY6Cb0Myev83sk/T6yVXFL6vmIRVqNDkqsGBT7N9BS3wdhZId4eNF16fKoV6pr5SpUw==
X-Received: by 2002:a05:600c:4e0f:b0:3db:3695:11b4 with SMTP id b15-20020a05600c4e0f00b003db369511b4mr34387048wmq.33.1674989712357;
        Sun, 29 Jan 2023 02:55:12 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i20-20020a1c5414000000b003dc3f3d77e3sm6538299wmb.7.2023.01.29.02.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 02:55:11 -0800 (PST)
Message-ID: <4b2de180-046b-cf9b-7b8c-f36241beb226@linaro.org>
Date:   Sun, 29 Jan 2023 11:55:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/3] dt-bindings: arm: qcom: Add MSM8926 and Samsung
 Galaxy Tab 4 10.1 LTE
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>,
        Stefan Hansson <newbyte@postmarketos.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     phone-devel@vger.kernel.org, matti.lehtimaki@gmail.com
References: <20230122144749.87597-1-newbyte@postmarketos.org>
 <7c69e654-fe57-ad5c-9b41-15aaeaa73102@postmarketos.org>
 <05a6f073-7002-0156-1225-cd838e482307@linaro.org> <1938307.usQuhbGJ8B@g550jk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1938307.usQuhbGJ8B@g550jk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2023 22:43, Luca Weiss wrote:
> On Montag, 23. Jänner 2023 19:08:03 CET Krzysztof Kozlowski wrote:
>> On 23/01/2023 18:41, Stefan Hansson wrote:
>>>>> 2. You base on other SoC but you do not include its compatibles. Why? Is
>>>>> it intended? None of the properties applicable to other SoC will match
>>>>> here, thus I actually wonder if you run dtbs_check...
>>>
>>> Sorry, I forgot about running dtbs_check. However, I'm not sure I
>>> understand the question. What do you mean by that I don't include its
>>> compatibles?
>>
>> I understood you include the msm8226.dtsi which is a different SoC. If
>> you include it, you get all of its content. We do it only for compatible
>> devices, but your device does not indicate compatibility with msm8226.
> 
> Hi Krzysztof,
> 
> the way the earlier Qualcomm SoCs work, especially regarding naming scheme is 
> the following.
> 
> There's for example the msm8x74 family which includes msm8974, msm8674, 
> msm8274, and the a bit differently named apq8074 where the significant 
> different are the RF capabilities, I think with those only 8974 had LTE, 8674 
> and 8274 only 3G but different band support, and the apq8074 has no mobile 
> radio.
> 
> The same exists for sure also for 8x16 and 8x26, probably a bunch of other 
> SoCs as well.
> 
> So from software side (apart from modem firmware of course) it can be treated 
> in practise as the same SoC so that's why we included the dtsi in this case in 
> msm8226 but also msm8926 and apq8026.

First, there is distinction between SoC having and not having modem. I
guess small enough that we just include the DTSI.

Second, there is distinction between different families, even if they
share a lot. All of the SoCs here share something, because Qualcomm has
versionable IP blocks which they re-use.

> 
> But the compatible on board-level is in practise (to my knowledge) not really 
> used for anything important other than having a nice string in the dts file. I 
> know some software uses compatible from user space but there for 
> differentiating between different devices and ignoring the SoC compatibles.

It's not only about board, but about all devices in the SoC.

> 
> But while they are software-compatible for the most part, they *are* distinct 
> SoCs with different capabilities and I just don't see the point in trying to 
> establish some kinds of relationships between different SoCs that are somewhat 
> or very similar (msm8226 and msm8974 also share many components but are 
> obviously different SoCs).

You don't have to create such relationships. You don't have to include
other DTSI, either. What yo have to is - quoting Linux docs:
"DO make 'compatible' properties specific. DON'T use wildcards in
compatible strings. DO use fallback compatibles when devices are the
same as or a subset of prior implementations. DO add new compatibles in
case there are new features or bugs."

> 
> And also e.g. (nearly) all apq* dts files we already have in mainline only 
> have apq compatible and not the corresponding msm* compatible. And I think 
> that's totally legitimate.

We do not talk here about apq, actually, at all. We talk about one
msm8xxx including other msm8xxx...


Best regards,
Krzysztof

