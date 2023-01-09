Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1955A663330
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbjAIViN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238075AbjAIVha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:37:30 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139453B92B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:36:21 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id d30so10242759lfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 13:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZOGbn4FkDUhoI+21N8v8V6Uvoy2GG2mcs3+XQNUSBLs=;
        b=BJWuZJmaqjPGlmKuQdrNQZ2AVFgeaMD8DE5LX775Qla43f+Y6x6P86+ssOBkID7Lt3
         wYZOWquPpNPdolYFi3Kl09o+dvXxD223HJcU/2VZ/EcRNUwUe+utu1/X/F0q3o45C8C3
         cBReZyMG3pfsLNolUBusBArtUbSmMyuiNEiB5bu3h3X2qiNWrfZUaC1TqBtFI1C5Opr7
         Zh7S27UivL8akABB4/iD3yzXXY2IS1+72IirNuU8J55KojQZuxWhhYlOSHgMGumcTTVD
         QJqJ9MZAsufObtnhXBb7Ny9WUoI9wcOxqpvZOq52k1ibtHxAO3lpw3MW2MQT1B3M7lG4
         /axw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOGbn4FkDUhoI+21N8v8V6Uvoy2GG2mcs3+XQNUSBLs=;
        b=zHHwiXwJEtVC3LGBw/VV0D8qHldrRB6RnEWwKMVW9j5uSGihknYu4fiyBUSQm5TBzw
         II/ctZ7PfZgjYwHdtKOjuEOboPaVtLFBNSvRRVQN7l8B+1WgN2h9Sex3mmyVLpXhsGsy
         Zs9exQFmdLXrz5/8ZCGE5p2toMQOfUPB2qopKfwszukrrgMyatCOjxl0kx4qrBzdrkKa
         tuFfjhZ99OuL75Jzvsmedq4c/oKD6BeXEJi9sEyKXkYfDr+lv4Ean+QmWH39gJFdUz5k
         O9i/JghCLEjBr8PzhXIUg0/6BMzK2AYheSo6/aIiwMd0pbdb2zal/Mrz/taZoqux8PW9
         92+A==
X-Gm-Message-State: AFqh2kq1sO8iFYO2OJr2B0/9cwBU+TGDl637ZjhEAuYOx8x/jItCk9og
        yZFQWE+Fcpf+FrFnidvNIb2/Og==
X-Google-Smtp-Source: AMrXdXupFL2wOn7BpBtq86rXcX7M+0Ks0LIsOZsL5rEMJD3K8DDMrKgcabttHM4tJddgrdDyKPLVJg==
X-Received: by 2002:a05:6512:2356:b0:4b5:6417:43bb with SMTP id p22-20020a056512235600b004b5641743bbmr23871813lfu.51.1673300180085;
        Mon, 09 Jan 2023 13:36:20 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id o7-20020ac24e87000000b004cb23904bd9sm1795775lfr.144.2023.01.09.13.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 13:36:19 -0800 (PST)
Message-ID: <9f6bd192-2a42-0a23-0032-df8b01921bdc@linaro.org>
Date:   Mon, 9 Jan 2023 23:36:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: qcom: Document the sc7280 CRD
 Pro boards
Content-Language: en-GB
To:     Doug Anderson <dianders@chromium.org>, andersson@kernel.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221216112918.1243-1-quic_rjendra@quicinc.com>
 <Y5x+WEwTtpoV0gaR@google.com>
 <fd23e295-fea0-1b0a-752c-3cce26b57346@quicinc.com>
 <Y6HHCrl0q5BhrHOY@google.com>
 <e269300d-539e-9eb8-8b3c-d309f3abca1b@quicinc.com>
 <bbc3c257-0a49-4c80-4586-c179c8997b50@linaro.org>
 <CAD=FV=X3DyMrEWESV2cWvqg_TQYnj+VGFBQodAp+gfbhBz6X3Q@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAD=FV=X3DyMrEWESV2cWvqg_TQYnj+VGFBQodAp+gfbhBz6X3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 09/01/2023 23:00, Doug Anderson wrote:
> Hi,
> 
> On Tue, Dec 20, 2022 at 9:12 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> On 20/12/2022 18:20, Rajendra Nayak wrote:
>>>
>>>
>>> On 12/20/2022 8:00 PM, Matthias Kaehlcke wrote:
>>>> On Tue, Dec 20, 2022 at 10:30:32AM +0530, Rajendra Nayak wrote:
>>>>>
>>>>> On 12/16/2022 7:49 PM, Matthias Kaehlcke wrote:
>>>>>> On Fri, Dec 16, 2022 at 04:59:17PM +0530, Rajendra Nayak wrote:
>>>>>>> Add compatibles for the Pro SKU of the sc7280 CRD boards
>>>>>>> which come with a Pro variant of the qcard.
>>>>>>> The Pro qcard variant has smps9 from pm8350c ganged up with
>>>>>>> smps7 and smps8.
>>>>>>>
>>>>>>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>>>>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>>>>>>> ---
>>>>>>> v4 changes:
>>>>>>> Added the zoglin-sku1536 compatible along with hoglin-sku1536.
>>>>>>> Zoglin is same as the Hoglin variant, with the SPI Flash reduced
>>>>>>> from 64MB to 8MB
>>>>>>>
>>>>>>>     Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>>>>>>>     1 file changed, 6 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml
>>>>>>> b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>>>>> index 1b5ac6b02bc5..07771d4c91bd 100644
>>>>>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>>>>> @@ -558,6 +558,12 @@ properties:
>>>>>>>               - const: google,hoglin
>>>>>>>               - const: qcom,sc7280
>>>>>>> +      - description: Qualcomm Technologies, Inc. sc7280 CRD Pro
>>>>>>> platform (newest rev)
>>>>>>> +        items:
>>>>>>> +          - const: google,zoglin-sku1536
>>>>>>> +          - const: google,hoglin-sku1536
>>>>>>
>>>>>> Is there actually such a thing as a 'hoglin-sku1536', i.e. the Pro
>>>>>> qcard
>>>>>> with 64MB of SPI flash, or do they all have 8MB of flash?
>>>>>
>>>>> The SPI flash is on the CRD mother-board and not on the qcards, so if
>>>>> you replace
>>>>> the qcards on the CRDs with 64MB flash you would need the
>>>>> hoglin-sku1536 to
>>>>> boot on those.
>>>>
>>>> With such a configuration how does the bootloader know it should pass
>>>> the kernel
>>>> the device tree for 'hoglin-sku1536' (pro) and not the non-pro
>>>> variant? IIUC the
>>>> device tree is selected based on pin strappings on the mother-board,
>>>> not the
>>>> qcard.
>>>
>>> The device tree is selected based on the pin strappings _and_ additional
>>> logic
>>> to dynamically identify modem/non-modem(wifi) as well as pro/non-pro
>>> SKUs which
>>> was added in the bootloaders.
>>
>> Just to clarify things, when you mention pro SKU, is it a separate SoC
>> revision (like sc7280-pro vs bare sc7280), or is it a CRD revision (CRD
>> Pro vs bare CRD)?
> 
> I guess Rajendra never responded, but since I know the answer: it's a
> different SoC revision. ...but the SoC in this case is on a daughter
> card, so you could remove the daughter card containing the SoC and put
> a new daughtercard on. That would have the effect of making an old CRD
> revision have the new Pro SKU SoC.

So, this is a new SoC. Is it 100% compatible with the sc7280? In other 
words: does it require any additional customizations (in OPP tables, in 
frequences, speed bins, etc)?

> 
> Bjorn: I'd also note that I think this series (this patch and the next
> one) are ready to land.
> 
> -Doug

-- 
With best wishes
Dmitry

