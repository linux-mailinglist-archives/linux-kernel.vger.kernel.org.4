Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911366540BD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbiLVMKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbiLVMJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:09:48 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CEE1181C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 04:01:00 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bf43so2402357lfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 04:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jr93GRiv8zFTGVwdKaWWdP/rCgXEzY7p4qCIYZGnLfM=;
        b=FN6z/5+WJ07qNhWvRYLnvEFgtHeY1SkBG2hvJZt30jwaLVBvaD93NHIM6ZurG9Vmen
         WgzVu80TO7eLnHBtlahamERsF7KAa8uGF7guVIOl9t42dYPfhjSGDmShxKkxZzQPuDrt
         Vh8j/uoCNsndk3WC3Higoml+sjK2GbzvGVuqdHkGAn+JQvGOlcwqzQ7NuPwGQmNiRtTA
         Wca8TNlCviV/BEDyK0H3jIJZW/vZBHbbCCUv70JSomqEgnfK9TRljR3eR3ZlhVqePUAM
         CL5psF1Zu6Wk8xClT13iDsaKHeQIFLGXV28oEMvDOf9qR+QSR/XU5oGypwnBr9b23kRQ
         PhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jr93GRiv8zFTGVwdKaWWdP/rCgXEzY7p4qCIYZGnLfM=;
        b=nIOSBS0FY8XIIszW1p3ywDdMc9bAixFA3am9imTuHNsgCYkl7jNXtjPzjHpRHCRJY3
         ESVRuxkunWGYGPskMY/5r6T19oIvJC4iqR8NujP7J2sQrETfwJ0JWlfU/zQAMpRs3++7
         Z4SMBTW+gXbWhuV7awrjLPaEAtWjosxMXuEyGqLKDil4Iaz548n/Fj57thoYSlk+9gOZ
         oxaL6V6NepeTsltrIG62mRtJEaq9lIX2bRrreO2SrqPpeJcYz/VpkXX2cAJBa3Fo7B3n
         /8adHDVek3F72NNQ5QKLzbK0+nJXEqgNJSDNas5B9JC7q8px5qwJ4RyXF93yCYz/FGZj
         PbHg==
X-Gm-Message-State: AFqh2kqAU+U51USnR+rCDRI+UNR+NmisKEmLGIiEOeYM08KyOxm4v1FS
        wU+G0s8krOst9xAWGZKuWPbuRg==
X-Google-Smtp-Source: AMrXdXsa7gd9mAxB0uidyGFcGlcWHsQeOAdmZhOtakH0fxlnj08ydDgdyfT9lPxHvNonGOblktb7xA==
X-Received: by 2002:ac2:5982:0:b0:4b5:5b36:28b8 with SMTP id w2-20020ac25982000000b004b55b3628b8mr1410265lfn.1.1671710458265;
        Thu, 22 Dec 2022 04:00:58 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q6-20020ac25fc6000000b00498fc3d4cfdsm47672lfg.189.2022.12.22.04.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 04:00:57 -0800 (PST)
Message-ID: <eec41318-70ea-6c1a-a5a4-394045b70850@linaro.org>
Date:   Thu, 22 Dec 2022 13:00:56 +0100
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
        kristo@kernel.org, nm@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
References: <20221220101249.46450-1-b-kapoor@ti.com>
 <ff5b09db-4900-0b5b-e821-fa05b8d907a4@linaro.org>
 <a4d11974-eb97-bfa2-790f-3016950ea961@ti.com>
 <79ffe459-3827-ea67-e854-8eef3d9b630b@linaro.org>
 <a22a2c32-3b52-8bdf-f959-c95554125c64@ti.com>
 <5e8d7388-1b2b-cebb-fd09-38b4364c00e1@linaro.org>
 <f89a1758-7cf5-3bb1-e28e-bb01fd6de9d3@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f89a1758-7cf5-3bb1-e28e-bb01fd6de9d3@ti.com>
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

On 22/12/2022 12:53, Bhavya Kapoor wrote:
> 
> On 22/12/22 16:16, Krzysztof Kozlowski wrote:
>> On 22/12/2022 11:39, Bhavya Kapoor wrote:
>>> On 21/12/22 13:24, Krzysztof Kozlowski wrote:
>>>> On 21/12/2022 06:42, Bhavya Kapoor wrote:
>>>>> On 20/12/22 16:20, Krzysztof Kozlowski wrote:
>>>>>> On 20/12/2022 11:12, Bhavya Kapoor wrote:
>>>>>>> J721s2 has two instances of 8 channel ADCs in MCU domain. Add DT nodes
>>>>>>> for 8 channel ADCs for J721s2 SoC.
>>>>>>>
>>>>>>> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
>>>>>>> ---
>>>>>>>     .../dts/ti/k3-j721s2-common-proc-board.dts    | 14 +++++++
>>>>>>>     .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 42 ++++++++++++++++++-
>>>>>>>     2 files changed, 55 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>>>>>>> index a7aa6cf08acd..67593aa69327 100644
>>>>>>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>>>>>>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>>>>>>> @@ -309,3 +309,17 @@ &mcu_mcan1 {
>>>>>>>     	pinctrl-0 = <&mcu_mcan1_pins_default>;
>>>>>>>     	phys = <&transceiver2>;
>>>>>>>     };
>>>>>>> +
>>>>>>> +&tscadc0 {
>>>>>>> +	status = "okay";
>>>>>>> +	adc {
>>>>>>> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
>>>>>>> +	};
>>>>>>> +};
>>>>>>> +
>>>>>>> +&tscadc1 {
>>>>>>> +	status = "okay";
>>>>>>> +	adc {
>>>>>>> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
>>>>>>> +	};
>>>>>>> +};
>>>>>>> \ No newline at end of file
>>>>>> This is a friendly reminder during the review process.
>>>>>>
>>>>>> It seems my previous comments were not fully addressed. Maybe my
>>>>>> feedback got lost between the quotes, maybe you just forgot to apply it.
>>>>>> Please go back to the previous discussion and either implement all
>>>>>> requested changes or keep discussing them.
>>>>>>
>>>>>> Thank you.
>>>>>>
>>>>>> Best regards,
>>>>>> Krzysztof
>>>>> Hi , I thought i did addressed the feedback since tscadc is just a
>>>>> wrapper node.
>>>>>
>>>>> The actual adc node is inside of tscadc node.
>>>> Read the feedback, from all emails.
>>>> Best regards,
>>>> Krzysztof
>>>
>>> Hi , i have gone through all earlier mails but can't find anything else.
>>> Can you point out again whats the issue.
>> "And this is a v2? Or resend? Or something else?"
>>
>> You miss proper versioning and changelog.
>>
>> Additionally - I commented just before error in your patch. You must fix
>> it, not ignore it, even though I did not point it out before.
>>
>> Best regards,
>> Krzysztof
> 
> Hi, i had replied to that as well earlier. You can check that out 
> https://lore.kernel.org/all/89ce3639-e979-e369-657a-20aea4295970@ti.com/ .

BTW, there is nothing there about the patch error I wrote here. If not,
please point me to the quote which addresses this patch error.

Best regards,
Krzysztof

