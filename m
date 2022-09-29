Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8615EF408
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiI2LMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbiI2LMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:12:08 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A3D2A264
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:12:04 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u18so1707677lfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ed9GW/QdKjJ735ISn6Av6rBi/urAjltD5XHbLc38vP0=;
        b=uB0lNti/jRz77uYMld3wQvI/gsJwhbHDzMhTBJz3ZpO0hVy5mZRkcVhH0mbnJtB4Hh
         s/tSyTd/qz7VUZPa+GNPBGovrwvf4ZzSB7vCqqMFWE50qh+uQqZeYNZ7tzGXjPg7kpUZ
         5/+4Kj2LowcPyy/L6J/q8n/X1XtOUti37izkS7KzvkMIuw6DPWtAJzoIhCdSmd1Ud1dV
         X7Si92/ZxX7wKJ4QwysnujSnEcy6NGoR2LY5tHcy3DMczMZmIi/rHdl4qQKPuMWZHpCv
         687XAZ5AyVXhBpM5+BZbrlRPZCDkYFoTnCFkweV0jl3gMzGp0ps+k8UWgubBGGeVGnoa
         6CoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ed9GW/QdKjJ735ISn6Av6rBi/urAjltD5XHbLc38vP0=;
        b=dj48k3tkRUO85crJC16zgCY1o7EU3BbTWMcRoWYkj8o5G3CgZHzfZRRPLL4YR2tnBe
         5lM9k2cgUmpP5jehYt6OtBJ7NxFNrWZi2prVK5/rNpBCm+r8aSz2TShYlMy0yvz1M4z6
         FHufvbHOwwIhGMwG4Q6y117WKc/sMqfSfa9tWKb4AdTWj4D3UCY+6co6U2W93Xiw2ANu
         0pY5vqNKLdXRR/KFioxULiDeBFkA8wVDXIUeUOwCABziqW2lvjUgJQz6/QbNGTKBYHgG
         jjcN1V8cOvEIal6Ou/bGwF1jDu5pGf10z5ctK7lv0XdoglVbWwPWugvMljFFryKAeOaN
         4C3A==
X-Gm-Message-State: ACrzQf1Z1R0rIJklMBoWCf0EgGXoZYVGBmnkJT2H1YuOIyjoV8TvkTjv
        uSNiT2HC+ALFPfI3mPL9wfKLKA==
X-Google-Smtp-Source: AMsMyM7JKCOSWnywYCGPQ3kBYSHmwH9C2y3r3niYpDDVKlgS3tH8vXCRmdUhsqt6WlIiq+mNIKP4SA==
X-Received: by 2002:ac2:58f8:0:b0:49e:da5c:1349 with SMTP id v24-20020ac258f8000000b0049eda5c1349mr1092132lfo.444.1664449922926;
        Thu, 29 Sep 2022 04:12:02 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v10-20020ac2558a000000b00492f1b2ac0bsm758682lfg.101.2022.09.29.04.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 04:12:02 -0700 (PDT)
Message-ID: <84cb8941-eb15-1bbf-59b7-bbcd6c15c30d@linaro.org>
Date:   Thu, 29 Sep 2022 13:12:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 5/7] arm: dts: qcom: mdm9615: remove invalid pmic
 subnodes compatibles
Content-Language: en-US
To:     neil.armstrong@linaro.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220928-mdm9615-dt-schema-fixes-v1-0-b6e63a7df1e8@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v1-5-b6e63a7df1e8@linaro.org>
 <0636d53f-508f-8a86-0973-2641c9020622@linaro.org>
 <6ed642ea-424d-49ed-eb30-e09588720373@linaro.org>
 <1a3c6766-9be5-1e55-95eb-bc9656e5c9a3@linaro.org>
 <7f8572ab-ff97-54bd-a5f3-fe0e179ee48e@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7f8572ab-ff97-54bd-a5f3-fe0e179ee48e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 12:56, Neil Armstrong wrote:
> On 29/09/2022 11:12, Krzysztof Kozlowski wrote:
>> On 29/09/2022 10:29, Neil Armstrong wrote:
>>> Hi,
>>>
>>> On 28/09/2022 20:03, Krzysztof Kozlowski wrote:
>>>> On 28/09/2022 11:14, Neil Armstrong wrote:
>>>>> The PMIC is an PM8018, but was compatible with the PM8921. Both compatibles
>>>>> was left but it makes no sense anymore the leave both.
>>>>
>>>> Why? It makes sense for backwards compatibility. If you think it does
>>>> not make sense, please say why.
>>>
>>> We had the same debate at submission 7y ago, some of the pm8018 new compatible
>>> were rejected in bindings & drivers so I left both...
>>>
>>> As of today only the pwrkey bindings is missing, so should I resubmit the pm8018-pwrkey bidings and
>>> drop the pm8921-pwrkey compatible ?
>>
>> ~7 years ago here:
>> https://lore.kernel.org/all/20160624220748.GB11719@dtor-ws/
>> you proposed to add something entirely different than we have here now
>> and than we talk about.
>>
>> In that thread you correctly wrote:
>> "My point of view is that the devicetree describes the hardware and need
>> to have SoC specific compatible string since it describes the actual
>> silicon, and drivers must make sure to handle all the SoC or family
>> variants using the compatible string and the match data."
> 
> And I'm happy this is still the policy! And I'm tried my best to follow this
> in all my DT & bindings submissions, while DT-Schema helped a lot here.
> 
>>
>> but implemented it entirely different. Maybe you refer to different mail
>> thread, I don't know, but that one is indeed wrong.
> 
> In the meantime things got much better, but at that time pushing a SoC bringup
> was a pain (I did 2 at the time, the other one is the OX810SE) and I even
> mentioned it in a talk ([1] slides 27 to 30).
> 
> So I added both to be sure that at some point a driver would probe against
> one of the compatible entries...
> 
>>
>> The DTS looks correct unless you have some real argument that it is not.
>>
>> How this should be fixed? First, drop bogus entries from drivers, then
>> document proper compatibles.
> 
> What do you mean ? There's no point to keep the PM8921 compatibles, the gpio

I asked at beginning - why? Why there is no point to keep them?

> and PMIC bindings already enforces to only have the PM8018 compatible.

That is just partial argument because binding does not match DTS. So
something is not correct. Why do you assume bindings are correct?

> 
> The only issue is about the PM8018 pwrkey, where the solution would be
> to actually re-submit [1] by documenting qcom,pm8018-pwrkey and adding the entry
> in the drivers/input/misc/pmic8xxx-pwrkey.c driver.
> 
> Or maybe I missed something.
> 
> [1] https://www.slideshare.net/superna/elce-2016-neil-armstrong-no-its-never-too-late-to-upstream-your-legacy-linux-based-platform
> [2] https://lore.kernel.org/all/1466759887-25394-3-git-send-email-narmstrong@baylibre.com/

So let's repeat again: the patch [2] looks wrong. The qcom,pm8018-pwrkey
and qcom,pm8921-pwrkey are compatible.

Best regards,
Krzysztof

