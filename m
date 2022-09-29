Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DE05EF474
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbiI2LjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbiI2LjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:39:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E97914F8D0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:39:06 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bk15so1713870wrb.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:reply-to:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=1PRN1zzVAaMSHN20dZQSu82ZWzj092eeFRPND9W3hso=;
        b=jRGy14KqPH+L5s2X3NOli1XbC51EMAQpDYGRK2P4PoL/Xf8QlHOiGmbOjJS3kWB2O/
         Tr4MlQf5FpgUSSoVKnREH8WW7Zr9bfEMaW1c0VHiVSryp+9o/n+4Ul/c/ddRx2CFDBq9
         rLcEFGps3AU51bAyF1GcvBAg7lJ64N/xxC0eAVULN3T2+w7DxL+Y+jSAFX6+F38bpUdG
         fz6uMFtTdqa6N4sWW78FO0AWxvIqjnU7HdGxk4vWbP1+vRDdQqgKtj3uq34kle4YPGlK
         Uw1ZaFX3UPnpJYYRrfYBY24JN7/lHC6HHwiIDMWa+XeO3gc4sOXlQxMojh1g4wenM5Ep
         ttzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:reply-to:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=1PRN1zzVAaMSHN20dZQSu82ZWzj092eeFRPND9W3hso=;
        b=5ta9g1WAfYVPJnsqubKrMteq/pTII2AoGtGvTDE60DxuUufBF0FczZ5tNbFejjov5m
         BdcleFLAswJU+UrAd0gVAuwTpM2kgnQP5VnKdDV7MlZW92aTmo+dUWmLUd4Kd1xiESwU
         oPELLB7a3k/GBiqx2Jrb/x3pJWoLwGCjjEhcJKKv3CnC1yfMiyYlXYUbxRa0kworkX1u
         Ep8FuRgIvlUaGXJaNe/y+1Me3tgFv2Q+EQcBP5YoemfqLVukMT+P5Vznj+yfjNzIO6fE
         aGEDse2oGWzV7j+0fpoUmn+OUikIaGFWTfJMZhieKdnTuh6GsWWPgxccnCih2HK2/r7d
         XOzQ==
X-Gm-Message-State: ACrzQf0C7+Ug4KyODzayw3aazWQyQ0zaNmet9m9mhybtktG4jz/Os3ZW
        palXRp+xvKXLf1lvUPCtA6w5cg==
X-Google-Smtp-Source: AMsMyM7dZ8qcD+O7lmFAyw07woE1FenoJWad93RnG6drtVYO2aSkgT8ImmgIt45K1K0auHayeijmog==
X-Received: by 2002:a05:6000:168e:b0:22a:4e45:7469 with SMTP id y14-20020a056000168e00b0022a4e457469mr1811414wrd.681.1664451544680;
        Thu, 29 Sep 2022 04:39:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:1f17:3ea3:4e46:dff? ([2a01:e0a:982:cbb0:1f17:3ea3:4e46:dff])
        by smtp.gmail.com with ESMTPSA id q6-20020adff506000000b0022a839d053csm6419432wro.98.2022.09.29.04.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 04:39:04 -0700 (PDT)
Message-ID: <07405d0d-8534-6470-21d1-26b85dbd7de0@linaro.org>
Date:   Thu, 29 Sep 2022 13:39:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 5/7] arm: dts: qcom: mdm9615: remove invalid pmic
 subnodes compatibles
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
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
 <84cb8941-eb15-1bbf-59b7-bbcd6c15c30d@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Organization: Linaro Developer Services
In-Reply-To: <84cb8941-eb15-1bbf-59b7-bbcd6c15c30d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 13:12, Krzysztof Kozlowski wrote:
> On 29/09/2022 12:56, Neil Armstrong wrote:
>> On 29/09/2022 11:12, Krzysztof Kozlowski wrote:
>>> On 29/09/2022 10:29, Neil Armstrong wrote:
>>>> Hi,
>>>>
>>>> On 28/09/2022 20:03, Krzysztof Kozlowski wrote:
>>>>> On 28/09/2022 11:14, Neil Armstrong wrote:
>>>>>> The PMIC is an PM8018, but was compatible with the PM8921. Both compatibles
>>>>>> was left but it makes no sense anymore the leave both.
>>>>>
>>>>> Why? It makes sense for backwards compatibility. If you think it does
>>>>> not make sense, please say why.
>>>>
>>>> We had the same debate at submission 7y ago, some of the pm8018 new compatible
>>>> were rejected in bindings & drivers so I left both...
>>>>
>>>> As of today only the pwrkey bindings is missing, so should I resubmit the pm8018-pwrkey bidings and
>>>> drop the pm8921-pwrkey compatible ?
>>>
>>> ~7 years ago here:
>>> https://lore.kernel.org/all/20160624220748.GB11719@dtor-ws/
>>> you proposed to add something entirely different than we have here now
>>> and than we talk about.
>>>
>>> In that thread you correctly wrote:
>>> "My point of view is that the devicetree describes the hardware and need
>>> to have SoC specific compatible string since it describes the actual
>>> silicon, and drivers must make sure to handle all the SoC or family
>>> variants using the compatible string and the match data."
>>
>> And I'm happy this is still the policy! And I'm tried my best to follow this
>> in all my DT & bindings submissions, while DT-Schema helped a lot here.
>>
>>>
>>> but implemented it entirely different. Maybe you refer to different mail
>>> thread, I don't know, but that one is indeed wrong.
>>
>> In the meantime things got much better, but at that time pushing a SoC bringup
>> was a pain (I did 2 at the time, the other one is the OX810SE) and I even
>> mentioned it in a talk ([1] slides 27 to 30).
>>
>> So I added both to be sure that at some point a driver would probe against
>> one of the compatible entries...
>>
>>>
>>> The DTS looks correct unless you have some real argument that it is not.
>>>
>>> How this should be fixed? First, drop bogus entries from drivers, then
>>> document proper compatibles.
>>
>> What do you mean ? There's no point to keep the PM8921 compatibles, the gpio
> 
> I asked at beginning - why? Why there is no point to keep them?

Because the HW is an PM8018 and the addition of the PM8921 was for policy/organization/struggling-to-make-dt-merged-before-clear-dt-policy/...
so you say I should modify the Bindings to reflect the actual "pm8018", "pm8921" situation instead of changing the DT even if incorrect ?

> 
>> and PMIC bindings already enforces to only have the PM8018 compatible.
> 
> That is just partial argument because binding does not match DTS. So
> something is not correct. Why do you assume bindings are correct?

Because bindings accurately reflects HW and DT doesn't.

> 
>>
>> The only issue is about the PM8018 pwrkey, where the solution would be
>> to actually re-submit [1] by documenting qcom,pm8018-pwrkey and adding the entry
>> in the drivers/input/misc/pmic8xxx-pwrkey.c driver.
>>
>> Or maybe I missed something.
>>
>> [1] https://www.slideshare.net/superna/elce-2016-neil-armstrong-no-its-never-too-late-to-upstream-your-legacy-linux-based-platform
>> [2] https://lore.kernel.org/all/1466759887-25394-3-git-send-email-narmstrong@baylibre.com/
> 
> So let's repeat again: the patch [2] looks wrong. The qcom,pm8018-pwrkey
> and qcom,pm8921-pwrkey are compatible.

Ok, I need time to understand, I'm highly confused now.

> 
> Best regards,
> Krzysztof
> 

