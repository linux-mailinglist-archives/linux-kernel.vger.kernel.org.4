Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A2E643E36
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbiLFIOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiLFIOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:14:37 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A8615808
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:14:35 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id x6so16334954lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 00:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wGkwdjXxA/UibVKElprkJap+8YaDjj1jRQTjyxca2j4=;
        b=b46/H9iOGQWYl9MXybeqi4jlV01URf3DW4+uIFathuyA4E0h6puiYJCmbMo8gyEHsf
         IPmiaV7h9gJdSkVPINQ0NWZXnhQc4bVtm+sckICXxR0zqgeQZclHq3g4yKa1ZOQEnCbN
         lSxPI0/1OIDlWxH0lU8aNmGMeCBcGPLFwY0zH0KO+h4/4Mn8XwHgxm+Osh+c4kdWpXuU
         294H0CK6E7sxwhmHOZ0Hwr3ypCvoQKqW1GISe37acd1FG+YShNLl1mrMSTpubOoY13Hf
         LpGVAQGXLAOUnQyVQMw6RV8x2JTHaIku7A6bVh1ewEk3fVhZQBgYnp3F+EA3YvVGiCQ/
         CoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGkwdjXxA/UibVKElprkJap+8YaDjj1jRQTjyxca2j4=;
        b=fbRnv+kUFhful4jZjzr7iBZwhqMI8vJ9Rg83kKQsivoNLKqDYiYy/kt5KW1nPo4tLo
         2DPzjITgbb8gFzPvxfVzLCt51gJD6KzcEKAdrKX8XnudN+Tbn/5qpSB9RjqeR+7KvjFp
         PR5J48YO9FCnMMW1JnwezfLzLbEqJY4DJYH4MeMPKUY81SrMtg68LtFtrpQ90SffJmG8
         5PZcfWTXUf/wr75ZKzZeabDJRiFTd13uAxL7cMgLL73+tOdgNV+rtMz8rRo7kQnN76XZ
         lHhMYbcJxwm1sMu6c9W5V5A3m/xgxUo45c2XigSMfT8TPgBt7xm5uqo49P32NiRlPjQS
         uMwQ==
X-Gm-Message-State: ANoB5pn6ZFLqteYbEWSE8MApSoiSoyF63sdEHl2kg/bFwT4hBwQGySGH
        YM5SpXoGUh6zGjH5Vshi512qYA==
X-Google-Smtp-Source: AA0mqf7DkArHc3+Jp0hft7OZMFdJ27VfMrq0GoLAULvcOAxkR/qL0EyWsto7DdFQZGTZvQ1Y1TFovQ==
X-Received: by 2002:a2e:9e11:0:b0:26e:3292:12ad with SMTP id e17-20020a2e9e11000000b0026e329212admr22970707ljk.271.1670314473735;
        Tue, 06 Dec 2022 00:14:33 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id r23-20020a2e8e37000000b00279a7266874sm1585405ljk.98.2022.12.06.00.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 00:14:32 -0800 (PST)
Message-ID: <2699840b-9746-473b-fa17-900258db555d@linaro.org>
Date:   Tue, 6 Dec 2022 09:14:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] dt-bindings: ufs: qcom: allow 'dma-coherent' property
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221205100837.29212-1-johan+linaro@kernel.org>
 <20221205100837.29212-2-johan+linaro@kernel.org>
 <20221205115906.GA20192@thinkpad> <Y43e9KRDsTCS5VI4@hovoldconsulting.com>
 <20221205122018.GC20192@thinkpad> <Y43jtpHqlyiIEZ0S@hovoldconsulting.com>
 <20221205130048.GD20192@thinkpad> <Y43uUA2X4Vzn+VLF@hovoldconsulting.com>
 <20221205133712.GE20192@thinkpad>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221205133712.GE20192@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2022 14:37, Manivannan Sadhasivam wrote:
> On Mon, Dec 05, 2022 at 02:12:48PM +0100, Johan Hovold wrote:
>> On Mon, Dec 05, 2022 at 06:30:48PM +0530, Manivannan Sadhasivam wrote:
>>> On Mon, Dec 05, 2022 at 01:27:34PM +0100, Johan Hovold wrote:
>>>> On Mon, Dec 05, 2022 at 05:50:18PM +0530, Manivannan Sadhasivam wrote:
>>>>> On Mon, Dec 05, 2022 at 01:07:16PM +0100, Johan Hovold wrote:
>>>>>> On Mon, Dec 05, 2022 at 05:29:06PM +0530, Manivannan Sadhasivam wrote:
>>>>>>> On Mon, Dec 05, 2022 at 11:08:36AM +0100, Johan Hovold wrote:
>>>>>>>> UFS controllers may be cache coherent and must be marked as such in the
>>>>>>>> devicetree to avoid data corruption.
>>>>>>>>
>>>>>>>> This is specifically needed on recent Qualcomm platforms like SC8280XP.
>>>>>>>>
>>>>>>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>
>>>>>> Yes, it would be a valid, but it will only be added to the DTs of SoCs
>>>>>> that actually require it. No need to re-encode the dtsi in the binding.
>>>>>>
>>>>>
>>>>> But if you make a property valid in the binding then it implies that anyone
>>>>> could add it to DTS which is wrong. You should make this property valid for
>>>>> SoCs that actually support it.
>>>>
>>>> No, it's not wrong.
>>>>
>>>> Note that the binding only requires 'compatible' and 'regs', all other
>>>> properties are optional, and you could, for example, add a
>>>> 'reset' property to a node for a device which does not have a reset
>>>> without the DT validation failing.

Optional properties are optional primarily looking at one variant. It
means that on different boards with the same SoC, things can be routed a
bit differently and some property can be skipped. E.g. sometimes
regulators come from PMIC and sometimes are wired to some VBATT, so we
do not have regulator in DTS for them. Or some interrupt/pin is not
connected.

Now between variants of devices - different SoCs: I don't think that
"optional" should be used in such context, except special cases or lack
of knowledge about hardware. For given SoC/variant, the property is either:
1. valid and possible (can be required or optional),
2. not valid, not possible.
And this we should express in constraints, if doable with reasonable
complexity.

Therefore the question is: is dma-coherent not valid for other SoCs?

If it is "not needed" for other SoCs, then I would leave it like this.
Consider also what Rob said, that otherwise we would create DTS from the
bindings.

Also, too many allOf:if:then: constraints in the bindings make them
trickier to read.

>>>>
>>>
>>> Then what is the point of devicetree validation using bindings?
>>
>> You're still making sure that no properties are added that are not
>> documented, number of clocks, names of clocks, etc.
>>
>>> There is also a comment from Krzysztof: https://lkml.org/lkml/2022/11/24/390
>>
>> Speaking of Krzysztof:
>>
>> 	https://lore.kernel.org/lkml/20221204094717.74016-5-krzysztof.kozlowski@linaro.org/

That's not the best example, because I just do not know where
dma-coherent is applicable and where it is not, thus I added it as valid
for all variants. Also, I think that all variants are capable of using
IOMMU - it isn't restricted per variant. If they are capable of IOMMU,
then dma-coherent is a possible choice.


Best regards,
Krzysztof

