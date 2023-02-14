Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424F26966D5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjBNO2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjBNO2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:28:44 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F63D4EDF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:28:26 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id n2so6304255ili.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OC7OLIEjLzwlnn+8IHiaJZmpnrxZO4YxhVGP3rMedHI=;
        b=qYxzyY2kErVbwyTWu/K6QEyKHIO3/dlMlcNYDO4AlI6KhfZGzNipBtlwSRLdCzl/RB
         XiP6NsG2rpVCazElWSwD3tOamJXBZSNquGZg7bf45dCQ0L0BM3PcLysgdzp2akmV/Ct/
         jCPQ6Rmjsu+S5tqklRwmcQzmPLuBlwhdA/ZLe+N2smKioUC7ptl9wJT3X1r4rZC5z83M
         RNwAK42FLRr3vc1aNFgQeZb2WqOL7upnBWD5dsozoSVFk37toN3ayqFLq+MOaMDYgzfy
         3HPexZxyuQrWptf+geTqtb1HHCS51X2FwbJ3xxfaYdnBEm0g91jFp2crX5pzb683NVEs
         nUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OC7OLIEjLzwlnn+8IHiaJZmpnrxZO4YxhVGP3rMedHI=;
        b=PN0mgzCojbeqzBEN5rPGokNxKlpQUvcNAt0Su38IoRyFGi0/AjydWZe7Zz3LGv7T9c
         cM8+ffgk+00blq8tCwsvSIWY1C6Rg1RVZBNDmwMFjx/gy5foqVF4s4E8W/hMOUpJ+S9/
         3UKUnx8L9wO5vDswG6M0gEuHtxG6PcW9ZItbqdJ5U5Hlm305U63ASE+hVnTUEKdE1cnO
         rAo0BK/Wku5qGMd/vtLjVo8rIhKkuTMkCD3Z58kPM1Pibeod+5aHYH2t1DELXFwOS15Q
         Ex6ULEJARKq1bEOQOpmaaBb3mMo5QKmkBenAISGFc39xYyB+25yfEv/FRWlANVY+M7ak
         Lctg==
X-Gm-Message-State: AO0yUKXZ1Ad0ujjleSpdON3o/1psxE/uwYlr4QcUnZ0K9anKZ1ER814N
        ugqGVeqBakgmLiDIQv7CyHpyKA==
X-Google-Smtp-Source: AK7set++Rn0Fp5zH216z7M0t4anw+bCYk5cH+cbnFchQuoKPGQZKwWBPd9XzqxYZBAA0DXp2h8O+pg==
X-Received: by 2002:a05:6e02:1a22:b0:315:29ff:da85 with SMTP id g2-20020a056e021a2200b0031529ffda85mr2455232ile.6.1676384905752;
        Tue, 14 Feb 2023 06:28:25 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id t3-20020a92c903000000b0031535804125sm2524047ilp.88.2023.02.14.06.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 06:28:25 -0800 (PST)
Message-ID: <a139f921-0f82-4d4b-6407-e0ad6807bb55@linaro.org>
Date:   Tue, 14 Feb 2023 08:28:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8450: Add IMEM and PIL info
 region
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1675443891-31709-1-git-send-email-quic_mojha@quicinc.com>
 <1675443891-31709-2-git-send-email-quic_mojha@quicinc.com>
 <cc30f686-dec7-db85-cf0d-c6c685a623ce@linaro.org>
 <d1dc0c9b-eab2-0287-d0a2-ead44ecee5ce@quicinc.com>
 <20230206210455.xgrvtvknkor4nllx@ripper>
 <aac2b313-e4af-dc93-f177-0d0be9620e1b@quicinc.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <aac2b313-e4af-dc93-f177-0d0be9620e1b@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 6:34 AM, Mukesh Ojha wrote:
> +@alex,
> 
> Please comment.
> 
> -Mukesh
> 
> On 2/7/2023 2:34 AM, Bjorn Andersson wrote:
>> On Mon, Feb 06, 2023 at 08:06:13PM +0530, Mukesh Ojha wrote:
>>>
>>>
>>> On 2/4/2023 3:07 AM, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 3.02.2023 18:04, Mukesh Ojha wrote:
>>>>> Add a simple-mfd representing IMEM on SM8450 and define the PIL
>>>>> relocation info region, so that post mortem tools will be able
>>>>> to locate the loaded remoteprocs.
>>>>>
>>>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>>>> ---
>>>>   From XBL:
>>>>
>>>> 0x14680000, 0x0002A000, "IMEM Base"
>>>>
>>>> Is there anything in that wider address range that would interest
>>>> us? I recall Alex once dug into that when diving into IPA, but
>>>> I can not recall the conclusion..

So you're saying a boot loader defines "IMEM Base" as
a range of memory, size 0x2a000.

>>> Spec-wise, yes IPA do own these 0x146A8000 - 0x146AA000 .
>>> But, not sure what they use it for.

And a subset of that range (at offset 0x28000, size 0x2000) is
set aside for use by IPA.  IPA *does* use this memory area as
"fast" memory to hold certain frequently-accessed tables.
Details of that are under the modem's control, and I don't
have knowledge of that.

The IPA driver currently maps it's portion of this memory,
but does *not* reflect that use in DT.  (This is something
that will be corrected at some point, possibly soon.)


>> The DT should not reflect the organization structure. Let's see if Alex
>> have any input on this.

As I understand it there's an "imem" node in DT defined, but
it just defines the range of memory, and is something referred
to by other drivers (or other nodes in a DTS file).  This seems
reasonable, and it kind of matches the view I've seen in
documents.  IPA does *not* follow that pattern, and should.

I don't really have any strong input either way.  I can help
define the "problem" but I don't claim to know the correct
way to represent this.

It's a contiguous block of special memory.  By convention
(design) its range divided up, with portions intended to be
used for different purposes, by different hardware.  IPA is
one of the users.

					-Alex


>>
>> Thanks,
>> Bjorn
>>
>>> -Mukesh
>>>>
>>>> Konrad
>>>>>    arch/arm64/boot/dts/qcom/sm8450.dtsi | 15 +++++++++++++++
>>>>>    1 file changed, 15 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi 
>>>>> b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>>> index 5704750..474ea1b 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>>> @@ -3536,6 +3536,21 @@
>>>>>                };
>>>>>            };
>>>>> +        sram@146aa000 {
>>>>> +            compatible = "qcom,sm8450-imem", "syscon", "simple-mfd";
>>>>> +            reg = <0 0x146aa000 0 0x1000>;
>>>>> +
>>>>> +            #address-cells = <1>;
>>>>> +            #size-cells = <1>;
>>>>> +
>>>>> +            ranges = <0 0 0x146aa000 0x1000>;
>>>>> +
>>>>> +            pil-reloc@94c {
>>>>> +                compatible = "qcom,pil-reloc-info";
>>>>> +                reg = <0x94c 0xc8>;
>>>>> +            };
>>>>> +        };
>>>>> +
>>>>>            apps_rsc: rsc@17a00000 {
>>>>>                label = "apps_rsc";
>>>>>                compatible = "qcom,rpmh-rsc";

