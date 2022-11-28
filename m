Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1781A63A747
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiK1LkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiK1LkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:40:03 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8372012AC1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:39:59 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d6so16880255lfs.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q5/k763LzFoFuWo55mEOX4nHny09SXn5+85xs+SSYFM=;
        b=cndDVYR86+qxtjT4dYnGzL+SlcaUkjq5APaUECvdfxyde320Q604GGE1KZgdPjY3FN
         f8GP9/75+NYZm0mJQp53X6Ir93lNv4n1mVxpOkzguCy6LlFyZ3JxPgQ5o4gmV3YmwrrT
         uqzS41RWhxfLKNw0Kia7I+qO7+cAZpQvs0QC3sHU+iCI/Zc27Z3HcDjzjNQa5bDSYMEu
         CRE2oU8sBppy+mD8Kma0qWTmxvhkDg0rnhhTgk0mBn22FMKCps2RHEwUWYZch1B4KEF8
         zEOI4+aU0wmzVe7Ii+D93KIk2ZVy2lnMZ86wNB2sU9Wtol5lbkQM2wiiUL8CISV6iRmW
         l1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5/k763LzFoFuWo55mEOX4nHny09SXn5+85xs+SSYFM=;
        b=7naO6OnqkW3gUAtkfP0cqj5cGz5keSy8n3aBr/nG62xl0Lhw8wccD80nzySPJ8+3pu
         2pw5zfVqu/nfpazYHrQLwx5HzlQdVkTSmg6ylsL048QRE0Ntf2yMFIrjDqhqLCsYIuap
         nnlgT2TNrYTJgXZPPbP4TasIId4QVeuivwkKp7OsvmG8dS0yWKK0Fz04DZjCLTMAdvXz
         GHxcx+wGUFdIBtNfPiNxecZUdZkpT3/tYAIgOASeIVHQdoCHnzRDZBfErS92dgnwDUu7
         sX3seu4lwhKpuCxb6l8S74OZh6omPtIjhItYC6vXht31nVBYyt2G6BOYQnw3E2XRuaAm
         ZHTg==
X-Gm-Message-State: ANoB5plIh+LEsJ68Es9WDdIVTIOArSI3oYP8+dwenTXTdUM08UP0BPwX
        c5u6Wpk6s++2uwKB1zxPFVYraw==
X-Google-Smtp-Source: AA0mqf4X5IsiG+TfK09V/fgjLPWDISphWOF+HNbXb+lAquq7bCCoNsr0BUoerJZB3bbb6+nIXwYybQ==
X-Received: by 2002:ac2:4153:0:b0:4b0:f505:919b with SMTP id c19-20020ac24153000000b004b0f505919bmr16141581lfi.306.1669635597842;
        Mon, 28 Nov 2022 03:39:57 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id be20-20020a056512251400b00492f0f66956sm1695895lfb.284.2022.11.28.03.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 03:39:57 -0800 (PST)
Message-ID: <fdbdd905-c233-cf76-c16f-92fb59eb35ef@linaro.org>
Date:   Mon, 28 Nov 2022 12:39:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/8] dt-bindings: power: supply: Add DT schema for
 Qualcomm SMBCHG
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alejandro Tafalla <atafalla@dnyon.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
References: <20221120154625.57095-1-y.oudjana@protonmail.com>
 <795deac4-71fe-d40b-a3b6-855eb3875ad1@linaro.org>
 <1H1PLR.S9UFOHIJCU6S@gmail.com>
 <1419e9da-98f7-c477-9f07-4b54e82be4c4@linaro.org>
 <CAA8EJpor_LnxLGYy25i-D6RBBO+-G9MsVWw=Qfm1Emp88KRJzQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJpor_LnxLGYy25i-D6RBBO+-G9MsVWw=Qfm1Emp88KRJzQ@mail.gmail.com>
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

On 22/11/2022 14:30, Dmitry Baryshkov wrote:
> Hi,
> 
> On Mon, 21 Nov 2022 at 19:07, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 21/11/2022 11:36, Yassine Oudjana wrote:
>>>
>>> On Mon, Nov 21 2022 at 09:26:59 +01:00:00, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>> On 20/11/2022 16:46, Yassine Oudjana wrote:
>>>>>>>  +  interrupts:
>>>>>>>  +    items:
>>>>>>>  +      - description: Charger error
>>>>>>>  +      - description: Charger inhibited
>>>>>>>  +      - description: Charger precharge safety timer timeout
>>>>>>>  +      - description: Charger charge safety timer timeout
>>>>>>>  +      - description: Charger pre to fast charging switch
>>>>>>> threshold reached
>>>>>>>  +      - description: Charger recharge threshold reached
>>>>>>>  +      - description: Charger taper threshold reached
>>>>>>>  +      - description: Charger charge termination threshold reached
>>>>>>>  +      - description: Battery hot
>>>>>>>  +      - description: Battery warm
>>>>>>>  +      - description: Battery cold
>>>>>>>  +      - description: Battery cool
>>>>>>>  +      - description: Battery overvoltage
>>>>>>>  +      - description: Battery low
>>>>>>>  +      - description: Battery missing
>>>>>>>  +      - description: Battery thermistor missing # unconfirmed
>>>>>>>  +      - description: USB input undervolt
>>>>>>>  +      - description: USB input overvolt
>>>>>>>  +      - description: USB input source detected
>>>>>>>  +      - description: OTG regulator failure
>>>>>>>  +      - description: OTG regulator overcurrent
>>>>>>>  +      - description: Automatic input current limiting done
>>>>>>>  +      - description: USB ID pin changed
>>>>>>>  +      - description: DC input undervolt
>>>>>>>  +      - description: DC input overvolt
>>>>>>>  +      - description: Power OK
>>>>>>>  +      - description: Temperature shutdown
>>>>>>>  +      - description: Watchdog timeout
>>>>>>>  +      - description: Flash failure
>>>>>>>  +      - description: OTST2 # unknown
>>>>>>>  +      - description: OTST3 # unknown
>>>>>>
>>>>>>  It seems you listed register interrupts, not physical pins. This
>>>>>> should
>>>>>>  be interrupt lines.
>>>>>
>>>>>  I'm not sure what I'm supposed to do here. I couldn't find an
>>>>> interrupt-lines
>>>>>  property used anywhere so that's not what you meant, right?
>>>>
>>>> Are these physical interrupt lines this device has, register offsets
>>>> or
>>>> virtual interrupts (e.g. passed via irq_chip)? Definitely not the
>>>> first
>>>> and rather offsets for qpnpint_irq_domain_translate. Devicetree is not
>>>> for describing register layout of devices. IOW, register layout does
>>>> not
>>>> change on different boards, because the device is exactly the same, so
>>>> there is no point to put it into DTS.
>>>>
>>>
>>> So how would I describe the interrupts then? Or if you are saying I
>>> shouldn't have these interrupts in DT at all, how would I get them and
>>> register handlers for them in the driver? the PMIC arbiter takes 4
>>> interrupt cells, 3 of which are these offsets specifying the peripheral
>>> and interrupt. All other PMIC peripherals currently described in DT
>>> (examples being qcom,pm8916-wcd-analog-codec, qcom,pm8941-pwrkey and
>>> qcom-wled) have their interrupts (if any) described this way, with the
>>> only exceptions perhaps being the GPIO and MPP controllers which are
>>> themselves interrupt controllers. Changing the way PMIC peripheral
>>> interrupts are described would require changing PMIC arbiter bindings
>>> and code which I believe is out of the scope of this patch series.
>>
>> I don't think this would touch PMIC arbiter bindings, rather the PMIC
>> itself. Usually complex devices (like PMICs) have one few physical
>> interrupt lines and many registers related to some specific interrupts.
>> For example:
>> 1. One IRQ line,
>> 2. Register with bits for overvoltage, undervoltage, vharger error etc.
>>
>> Now how the MFD child device accesses them. Since this is strictly
>> related to hardware programming model, it's not something you put to
>> Devicetree. Instead parent device (PMIC) registers IRQ chip for its one
>> interrupt line with several Linux (or virtual) interrupts. The children
>> then just get a virtual IRQ from the parent (PMIC) and setup a
>> handler(s) for them.
> 
> Unfortunately this is not how SPMI PMICs work (at least on the
> Qualcomm platforms). Access to interrupt registers is handled via the
> SPMI bus arbiter writes, not through the GPIO pin or typical spmi's
> bus interface (in the other words, not through the PMIC's SPMI
> regmap). 

I am not sure how this is related... Just because they do not use same
regmap/interface does not mean that child device should have register
bits as interrupt sources. Do you model I2C PMICs devices the same way?
No. They get the interrupts from the parent and how the parent handles
them (same or different regmap) is separate problem.

The charger node does not make SPMI bus as interrupt parent, so these
interrupts are going to the SPMI PMIC don't they? or is it mistake in
DTS - lack of interrupt-parent?


> I guess we can add an intermediate irq chip to automatically
> handle the USID, etc. However I doubt that it will really bring a lot
> in our case.

The charger node defines all interrupts with SID=2, which is also not
really correct. The parent device is SID=2. The child - does not matter.
DT is a tree for some reason...

Best regards,
Krzysztof

