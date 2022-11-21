Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273A8632A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiKURHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiKURHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:07:11 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D50CB9F8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:07:07 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id u11so15194450ljk.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJQWLAZ4mdjMtlFjO7Mbh6mixzKo427eR1BTd1zJu8w=;
        b=xm7lgVvTD8LiKUqo3lDgCROpVlzaUp5xR5oj/uRiSHOTCPkwI4ffK97ZDk4rAoIAHu
         fVz6Lld5vc+StslDX8RTWnty/GGnaFYtvbJRFiPzzJ5l6tT7PfRlFKjNMcq4Qnuf+Oid
         dbsUBp92BrrHS4gsjNnaBqtxcpyNJQv1bYODwQ6DqeE/cy4x/sfwOmwVeNUqZlUkACsO
         Gr4GIZdS17SkCPci1YrZxAtXxJqTkk+gSJm99H92s4uJTlkg1OQ5o9MTpiGWoaSD6Xsf
         6LETMkR8MSmJ72+cpP9MGYtzd8x3+5/LZKtPqxzCcKk+L2NVJJMUNb8h0xX4hzo9Jggx
         hPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJQWLAZ4mdjMtlFjO7Mbh6mixzKo427eR1BTd1zJu8w=;
        b=st0hKs8dA58DZHKIjCg6EqV655OoJ+qgxHLnIGZc+eYvT2crvYwvsHzF2x55cBK506
         VLJHJOKHnWIvQVKcbDc+l1Jn8QWbj/cK6XmDDuT2TxzGsRcEYVXQKUZBE921iXJ+IXzj
         RUxHcps70w2biNrK+1F/qemP+6TSGzaW9Fsjjkid5ahRdM0O8Jtzo5jmIZXh3OwigoGu
         oc/JmMm4nCdpjHO7ldzv/7kiQ2e1oAiYoX4j2uphWYC1sOtVNUBixWZeCF8Tvf6X6Itk
         7zb0OVT+mbW3cLJPMlvxzNv5N4SuTr1LNZtKqfDVk0SfWx0jHHyY1DuudGtyrFTzG/XY
         ivSw==
X-Gm-Message-State: ANoB5pkycTkdMaJFhDzvYI62/MBbVWRcCWxi2vWEXXV0DAjI4g2WFMcu
        U6ZG39SZd9IKS5icg8pQvBWlUQ==
X-Google-Smtp-Source: AA0mqf6h+6xPI2dxU9CA3hVBJILkn7hxLyyKv1N7KNTixcKNfyb9AQn+ztPktj067WOaqKu+Ldpt/Q==
X-Received: by 2002:a05:651c:205:b0:26c:5e3a:44d7 with SMTP id y5-20020a05651c020500b0026c5e3a44d7mr6573052ljn.471.1669050426022;
        Mon, 21 Nov 2022 09:07:06 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v10-20020a2e87ca000000b0027712379ec8sm1552281ljj.28.2022.11.21.09.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 09:07:05 -0800 (PST)
Message-ID: <1419e9da-98f7-c477-9f07-4b54e82be4c4@linaro.org>
Date:   Mon, 21 Nov 2022 18:07:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/8] dt-bindings: power: supply: Add DT schema for
 Qualcomm SMBCHG
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1H1PLR.S9UFOHIJCU6S@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 11:36, Yassine Oudjana wrote:
> 
> On Mon, Nov 21 2022 at 09:26:59 +01:00:00, Krzysztof Kozlowski 
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 20/11/2022 16:46, Yassine Oudjana wrote:
>>>>>  +  interrupts:
>>>>>  +    items:
>>>>>  +      - description: Charger error
>>>>>  +      - description: Charger inhibited
>>>>>  +      - description: Charger precharge safety timer timeout
>>>>>  +      - description: Charger charge safety timer timeout
>>>>>  +      - description: Charger pre to fast charging switch 
>>>>> threshold reached
>>>>>  +      - description: Charger recharge threshold reached
>>>>>  +      - description: Charger taper threshold reached
>>>>>  +      - description: Charger charge termination threshold reached
>>>>>  +      - description: Battery hot
>>>>>  +      - description: Battery warm
>>>>>  +      - description: Battery cold
>>>>>  +      - description: Battery cool
>>>>>  +      - description: Battery overvoltage
>>>>>  +      - description: Battery low
>>>>>  +      - description: Battery missing
>>>>>  +      - description: Battery thermistor missing # unconfirmed
>>>>>  +      - description: USB input undervolt
>>>>>  +      - description: USB input overvolt
>>>>>  +      - description: USB input source detected
>>>>>  +      - description: OTG regulator failure
>>>>>  +      - description: OTG regulator overcurrent
>>>>>  +      - description: Automatic input current limiting done
>>>>>  +      - description: USB ID pin changed
>>>>>  +      - description: DC input undervolt
>>>>>  +      - description: DC input overvolt
>>>>>  +      - description: Power OK
>>>>>  +      - description: Temperature shutdown
>>>>>  +      - description: Watchdog timeout
>>>>>  +      - description: Flash failure
>>>>>  +      - description: OTST2 # unknown
>>>>>  +      - description: OTST3 # unknown
>>>>
>>>>  It seems you listed register interrupts, not physical pins. This 
>>>> should
>>>>  be interrupt lines.
>>>
>>>  I'm not sure what I'm supposed to do here. I couldn't find an 
>>> interrupt-lines
>>>  property used anywhere so that's not what you meant, right?
>>
>> Are these physical interrupt lines this device has, register offsets 
>> or
>> virtual interrupts (e.g. passed via irq_chip)? Definitely not the 
>> first
>> and rather offsets for qpnpint_irq_domain_translate. Devicetree is not
>> for describing register layout of devices. IOW, register layout does 
>> not
>> change on different boards, because the device is exactly the same, so
>> there is no point to put it into DTS.
>>
> 
> So how would I describe the interrupts then? Or if you are saying I 
> shouldn't have these interrupts in DT at all, how would I get them and 
> register handlers for them in the driver? the PMIC arbiter takes 4 
> interrupt cells, 3 of which are these offsets specifying the peripheral 
> and interrupt. All other PMIC peripherals currently described in DT 
> (examples being qcom,pm8916-wcd-analog-codec, qcom,pm8941-pwrkey and 
> qcom-wled) have their interrupts (if any) described this way, with the 
> only exceptions perhaps being the GPIO and MPP controllers which are 
> themselves interrupt controllers. Changing the way PMIC peripheral 
> interrupts are described would require changing PMIC arbiter bindings 
> and code which I believe is out of the scope of this patch series.

I don't think this would touch PMIC arbiter bindings, rather the PMIC
itself. Usually complex devices (like PMICs) have one few physical
interrupt lines and many registers related to some specific interrupts.
For example:
1. One IRQ line,
2. Register with bits for overvoltage, undervoltage, vharger error etc.

Now how the MFD child device accesses them. Since this is strictly
related to hardware programming model, it's not something you put to
Devicetree. Instead parent device (PMIC) registers IRQ chip for its one
interrupt line with several Linux (or virtual) interrupts. The children
then just get a virtual IRQ from the parent (PMIC) and setup a
handler(s) for them.

You will find some examples for this, just grep for regmap_irq_get_virq,
for the drivers using regmap_irq_chip (or irq_create_mapping for
non-regmaps).

Since it is *one* device - the PMIC and its child like charger - the
register layout is fixed thus I think these virtual (or Linux)
interrupts are fixed as well.

I don't know why Qualcomm PMIC for SPMI is done differently.

Best regards,
Krzysztof

