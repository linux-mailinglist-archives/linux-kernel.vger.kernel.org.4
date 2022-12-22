Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A71C653E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiLVKqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbiLVKqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:46:16 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A376C1F2FA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 02:46:14 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id a19so1534025ljk.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 02:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dyarJ5c7H5K4w/5iPj5Y1u1ARcmMhxdFR6wMTGtvYlQ=;
        b=iOeDoeF7DYCqPIwidMsIqbuZwFQMl5zDegDjvysdGE54QPpaY2feXLxU+fYQSAZebn
         a41ITxO7CYgyC6LCqZEp4LOD41YTMP0TM7G1R3HoUmsBUG5M7d4uRkFPe5l1v88EaoAJ
         L+8C2G5IwaAEEV+GVsjH17WaYXnLJs9rOWKUmTrqVPDJnbc8idCMRpnbZCxTp4aEB+e2
         bH3Uk24V83xCtRHgG+GvFISMBiPXZ/daYd4r758A4ZsVc1O5qVea2bC0TEEkwI9Ng/K8
         U9PqL4531+WiF7CQyU/eBcg1n4QISHpqw3zlD8DOo9FwvDZ4mjd8C37VJxpaE3yhhKWq
         gYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyarJ5c7H5K4w/5iPj5Y1u1ARcmMhxdFR6wMTGtvYlQ=;
        b=6K11tz5RCImslAIrrh4gnSWc9z3bjPG7+KCHzI18yiIgLiatB9eNlrg31LhQFrvmK6
         xJNgTjBogC2gkOI9xSDGtfBZ8iImmbeygDht+th19ZXfIyVlp27looYYtnyJ0gcDoqxO
         EWs8Ct+bBAFehN/+5JYM1w9T0kaP6h+JZeHUuqnvhS2Aqg7LqLOZnY8A1AQEorvUuUcf
         OiHbiWd03sEyGgaCz9ODCo+rKjNAiHkSGLwmjIaQYFv/jWMIs747tZYJomjA0enIciaY
         Y1BmWKnYTscpjOnQIvXTrMi0L6DoiQFOuXV4zZhJWIOUKhR1fKv1BlkwFoLbLyhhOyY9
         YN+A==
X-Gm-Message-State: AFqh2kpvihkgsoJ+wInqa3P8QnedFD8yrYDLInjLRNeo2BscGXs4hAm4
        kOa4ZPKf2N4AAnXnX/Uhe4uGoRRONcNUfmys
X-Google-Smtp-Source: AMrXdXstgUhJPwscBbllB/JamD5vSP8dpvL3OXHGcxmIXLUnk5vte7UKRACZZW5iCgpVHwngF7EtGg==
X-Received: by 2002:a2e:b004:0:b0:279:e1ba:8c6a with SMTP id y4-20020a2eb004000000b00279e1ba8c6amr1196396ljk.44.1671705973043;
        Thu, 22 Dec 2022 02:46:13 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h21-20020a2ea495000000b00279e41de7e6sm14385lji.3.2022.12.22.02.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 02:46:12 -0800 (PST)
Message-ID: <5e8d7388-1b2b-cebb-fd09-38b4364c00e1@linaro.org>
Date:   Thu, 22 Dec 2022 11:46:11 +0100
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
 <79ffe459-3827-ea67-e854-8eef3d9b630b@linaro.org>
 <a22a2c32-3b52-8bdf-f959-c95554125c64@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a22a2c32-3b52-8bdf-f959-c95554125c64@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 11:39, Bhavya Kapoor wrote:
> 
> On 21/12/22 13:24, Krzysztof Kozlowski wrote:
>> On 21/12/2022 06:42, Bhavya Kapoor wrote:
>>> On 20/12/22 16:20, Krzysztof Kozlowski wrote:
>>>> On 20/12/2022 11:12, Bhavya Kapoor wrote:
>>>>> J721s2 has two instances of 8 channel ADCs in MCU domain. Add DT nodes
>>>>> for 8 channel ADCs for J721s2 SoC.
>>>>>
>>>>> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
>>>>> ---
>>>>>    .../dts/ti/k3-j721s2-common-proc-board.dts    | 14 +++++++
>>>>>    .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 42 ++++++++++++++++++-
>>>>>    2 files changed, 55 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>>>>> index a7aa6cf08acd..67593aa69327 100644
>>>>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>>>>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>>>>> @@ -309,3 +309,17 @@ &mcu_mcan1 {
>>>>>    	pinctrl-0 = <&mcu_mcan1_pins_default>;
>>>>>    	phys = <&transceiver2>;
>>>>>    };
>>>>> +
>>>>> +&tscadc0 {
>>>>> +	status = "okay";
>>>>> +	adc {
>>>>> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
>>>>> +	};
>>>>> +};
>>>>> +
>>>>> +&tscadc1 {
>>>>> +	status = "okay";
>>>>> +	adc {
>>>>> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
>>>>> +	};
>>>>> +};
>>>>> \ No newline at end of file
>>>> This is a friendly reminder during the review process.
>>>>
>>>> It seems my previous comments were not fully addressed. Maybe my
>>>> feedback got lost between the quotes, maybe you just forgot to apply it.
>>>> Please go back to the previous discussion and either implement all
>>>> requested changes or keep discussing them.
>>>>
>>>> Thank you.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>> Hi , I thought i did addressed the feedback since tscadc is just a
>>> wrapper node.
>>>
>>> The actual adc node is inside of tscadc node.
>> Read the feedback, from all emails.
>> Best regards,
>> Krzysztof
> 
> 
> Hi , i have gone through all earlier mails but can't find anything else. 
> Can you point out again whats the issue.

"And this is a v2? Or resend? Or something else?"

You miss proper versioning and changelog.

Additionally - I commented just before error in your patch. You must fix
it, not ignore it, even though I did not point it out before.

Best regards,
Krzysztof

