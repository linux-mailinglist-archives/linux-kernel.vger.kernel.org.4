Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC40E652D87
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 08:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiLUHy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 02:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbiLUHyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 02:54:54 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8B620F48
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 23:54:52 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id j4so22355602lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 23:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cd4NlwVfDDcizKG3XwDkBaypBKyNBzdCvZsOkaiYGc0=;
        b=dbx0OXlU/beOCbWbFfaOtnDaeEFGca8kNTAdOPFMJUPcctJnA7qwGsGBaZsmBmgR7P
         rkpnPJOvi0/FwW4DvcmmMrB3TkcnnAyP2YudANOsXMMsJ9miumjyz48uJVMDMMfV+FcF
         cCdbNv+qQTaIQvkh+y9IWrmWFgKFVqFNeUfa+rqXZoEFl4nUOiTXBSCZwaaXvM0DVWYd
         7YPVEWTDnUiNP/3pOgMW109zmtEtDu0wYbzcKtT8yDX9mpS/NNJ5fr5lp6H+sb4x5ob5
         LJDF9V4PYX2veRhf+0s21M2UoO9wt5D1/Ka2p4bWeHPDl444zOQMs7Y5h8RBifJwGqZS
         uNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cd4NlwVfDDcizKG3XwDkBaypBKyNBzdCvZsOkaiYGc0=;
        b=NWWTGoKzQEV1d7nprW51mBysKqqVP+fxZS8T9YIDLfAuKYpAQcquwgpABTKbtBU3XV
         /INgIwWHmUTe7Xr0ZjywbdHunndTktrsM8f64LJ5UYiickSjL0jBPKOCbqih2O85yFGj
         z83jx+TKjsqc/9pUfl7C5VaptT5p35/JNnJj4WZlgvl8swoipdNZXZ+kuX9rAK/MomH0
         3iWbDDKYwo1LMNHaIVAgSRsXaUAumvKQVq3vzXIfWk0km6tZOk5Bo7IN/5cMHPDDPgj4
         Vd4QuaqUuZMe68ESTNYsGsI8i/Fgj9r3puLisY9rPc0aVaQQGaCThLQhoMjiGdVxmzOS
         vi8g==
X-Gm-Message-State: AFqh2kp/GtnP/4B67otTfT+fOKOdEzDKqVKD5mPeR1fzyL+8GpQE8Jfu
        lQqIDYOGW0/iRslB1/Jx1g89kg==
X-Google-Smtp-Source: AMrXdXtBM1Gf9AUc4Z7pCqi61fr4zmdhQ+Weqf5tlehKIBjc/4e7HB24prxfvyQPfYRgcN0Q/Ju5IA==
X-Received: by 2002:ac2:4435:0:b0:4b5:90bb:e565 with SMTP id w21-20020ac24435000000b004b590bbe565mr333068lfl.36.1671609291070;
        Tue, 20 Dec 2022 23:54:51 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 9-20020ac25f09000000b004a6f66eed7fsm1754646lfq.165.2022.12.20.23.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 23:54:50 -0800 (PST)
Message-ID: <79ffe459-3827-ea67-e854-8eef3d9b630b@linaro.org>
Date:   Wed, 21 Dec 2022 08:54:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [EXTERNAL] Re: [PATCH] arm64: dts: ti: k3-j721s2: Add support for
 ADC nodes
Content-Language: en-US
To:     Bhavya Kapoor <b-kapoor@ti.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        kristo@kernel.org, nm@ti.com
References: <20221220101249.46450-1-b-kapoor@ti.com>
 <ff5b09db-4900-0b5b-e821-fa05b8d907a4@linaro.org>
 <a4d11974-eb97-bfa2-790f-3016950ea961@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a4d11974-eb97-bfa2-790f-3016950ea961@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 06:42, Bhavya Kapoor wrote:
> 
> On 20/12/22 16:20, Krzysztof Kozlowski wrote:
>> On 20/12/2022 11:12, Bhavya Kapoor wrote:
>>> J721s2 has two instances of 8 channel ADCs in MCU domain. Add DT nodes
>>> for 8 channel ADCs for J721s2 SoC.
>>>
>>> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
>>> ---
>>>   .../dts/ti/k3-j721s2-common-proc-board.dts    | 14 +++++++
>>>   .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 42 ++++++++++++++++++-
>>>   2 files changed, 55 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>>> index a7aa6cf08acd..67593aa69327 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>>> @@ -309,3 +309,17 @@ &mcu_mcan1 {
>>>   	pinctrl-0 = <&mcu_mcan1_pins_default>;
>>>   	phys = <&transceiver2>;
>>>   };
>>> +
>>> +&tscadc0 {
>>> +	status = "okay";
>>> +	adc {
>>> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
>>> +	};
>>> +};
>>> +
>>> +&tscadc1 {
>>> +	status = "okay";
>>> +	adc {
>>> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
>>> +	};
>>> +};
>>> \ No newline at end of file
>> This is a friendly reminder during the review process.
>>
>> It seems my previous comments were not fully addressed. Maybe my
>> feedback got lost between the quotes, maybe you just forgot to apply it.
>> Please go back to the previous discussion and either implement all
>> requested changes or keep discussing them.
>>
>> Thank you.
>>
>> Best regards,
>> Krzysztof
> 
> Hi , I thought i did addressed the feedback since tscadc is just a 
> wrapper node.
> 
> The actual adc node is inside of tscadc node.

Read the feedback, from all emails.
Best regards,
Krzysztof

