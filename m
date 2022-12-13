Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AAD64B867
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbiLMP3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236165AbiLMP3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:29:10 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8504411154
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:29:08 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id c1so5485487lfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ubRrHG5XQsvaG2QHVMW1By0yKdv0rcUuQWkghfHeazE=;
        b=CG6+oNu2K7Ro4jtdFdfWrz3mm3eA9uMfDK1GzbBIJ71e3gFwuaXRJJEQcuk65tT5W6
         rV9WbRG2fmebI4GwSM0PrsYuirvIQVXXAwiDkabPBDJF4ZwPP2EBlNnY/Ymtifruf0SJ
         Q4a5XWu9YyWZ/uAGpLWk1MSQ6Xu7JklrohvYqXQ8VlfM2ZQQnBqpJvpV3giW676RNcns
         Tc7BuqBGjOq7EIYKUAW32RJknR4wIYqSEhYJLM+NBgO6Yc785rR6hAVNSZDhtgR0ISSt
         XR6mmhY54ObW1pwcuSrS7zu3rhlAgeh6U6rCwXt8rpx1+gpXtZihoZuQauZegbbYpWYV
         dUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ubRrHG5XQsvaG2QHVMW1By0yKdv0rcUuQWkghfHeazE=;
        b=zz7XBOM4ZhYWSN1QQGTbXUUDGWFzeCBvztu9rYBMrAeIm6z8FzKMmNtcs1Q5MSoHiI
         OrLQd/ehDKzaqx9guvFBb1eovASEPRZRf6AgSvNz/pR8J/FiaRWicJI28DK7Lae8LoM3
         2ZZk79t0A3nhSUvGgDduGYDl3dQ5y/N5CniW/4sbHgvdb8ObL7V0oo2sYlF4UqHuunuR
         GTtTsB5vJY0aY2aHNEGMxa/jnWw65W/W2vWI0ua5jf4svCnQJIBjhUHw8mYXow9Tv4p4
         pwh4dL0cK/cSTRpzAmvhelDWpIuf2+kqHONCtDTJvovWGRsNbuMdvzj9ffz+z59aownn
         ElyA==
X-Gm-Message-State: ANoB5pm5KZ7R0Nr0fWinDN9I+ez7gRQat59q9dbhiqs/6tsxhujp4SaH
        0fLCCyoTPyCcAVRa1/kjkBj+wg==
X-Google-Smtp-Source: AA0mqf7QC5WrnxCyhmqXGmkV27mxlxtMsUaV0wouto7wYKQQSnOQTXPYDzZZPcE/Bfi0ne+bRv3gXA==
X-Received: by 2002:a05:6512:38b1:b0:4ab:dcea:acdf with SMTP id o17-20020a05651238b100b004abdceaacdfmr4289064lft.21.1670945346931;
        Tue, 13 Dec 2022 07:29:06 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id k4-20020ac257c4000000b004a8f824466bsm408321lfo.188.2022.12.13.07.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 07:29:06 -0800 (PST)
Message-ID: <114e960f-3b63-8c8f-9d4a-87173049d730@linaro.org>
Date:   Tue, 13 Dec 2022 16:29:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc8280xp: rename i2c5 to i2c21
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>, Brian Masney <bmasney@redhat.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com, quic_shazhuss@quicinc.com
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-2-bmasney@redhat.com>
 <Y5iSDehp72mQPc+h@hovoldconsulting.com>
 <Y5iXjTQnEtMCZy7W@hovoldconsulting.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <Y5iXjTQnEtMCZy7W@hovoldconsulting.com>
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



On 13.12.2022 16:17, Johan Hovold wrote:
> On Tue, Dec 13, 2022 at 03:54:05PM +0100, Johan Hovold wrote:
>> On Mon, Dec 12, 2022 at 01:23:11PM -0500, Brian Masney wrote:
>>> According to the downstream 5.4 kernel sources for the sa8540p,
>>> i2c@894000 is labeled i2c bus 21, not 5. The interrupts and clocks
>>> also match. Let's go ahead and correct the name that's used in the
>>> three files where this is listed.
>>>
>>> Signed-off-by: Brian Masney <bmasney@redhat.com>
>>> Fixes: 152d1faf1e2f3 ("arm64: dts: qcom: add SC8280XP platform")
>>> Fixes: ccd3517faf183 ("arm64: dts: qcom: sc8280xp: Add reference device")
>>> Fixes: 32c231385ed43 ("arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s devicetree")
>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> index 109c9d2b684d..875cc91324ce 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> @@ -827,7 +827,7 @@ qup2_uart17: serial@884000 {
>>>  				status = "disabled";
>>>  			};
>>>  
>>> -			qup2_i2c5: i2c@894000 {
>>> +			qup2_i2c21: i2c@894000 {
>>
>> Note that the node is labelled qup2_i2c5 and not qup_i2c5.
>>
>> That is, the QUP nodes are labelled using two indices, and specifically
>>
>> 	qup2_i2c5
>>
>> would be another name for
>>
>> 	qup_i2c21
>>
>> if we'd been using such a flat naming scheme (there are 8 engines per
>> QUP).
>>
>> So there's nothing wrong with how these nodes are currently named, but
>> mixing the two scheme as you are suggesting would not be correct.
> 
> It appears sc8280xp is the only qcom platform using a qup prefix (even
> if some older platform use a blsp equivalent), and we're not even using
> it consistently as we, for example, have both
> 
> 	qup2_uart17, and
> 	qup2_i2c5
> 
> (where the former should have been qup2_uart1).
> 
> So either we fix up the current labels or just drop the qup prefixes and
> use a flat naming scheme (e.g. uart17 and i2c21).
Oh, I didn't notice that! I suppose sticking with i2cN as we've been
doing ever since i2c-geni was introduced sounds like the best option..

Konrad
> 
> Either way, there's no need for any Fixes tags as this isn't a bug.
> 
> Johan
