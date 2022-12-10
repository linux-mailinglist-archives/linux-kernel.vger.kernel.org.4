Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6064E648E4C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 12:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiLJLCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 06:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLJLCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 06:02:05 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2C51C928
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 03:02:02 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 1so10927241lfz.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 03:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qtLsUqxObl5gNvozPidJotWpMooTYg5mjWrhCt6bCKc=;
        b=sa7G/COWN4N2/rdfMXhPIS4QNgjWvxGqmVy3Kc/nEw8P5EMBZI2C9N2iJ1ZOBf5Gtr
         CZEe6BLdgqFCsRv4qp0Itb+kxQeZOjuF3zHRFkTVbQTLgI3xStpWZ6cvud8cbontaloD
         b1S8+u79d2H5OY46sujlez8DAwRSB1znFSbOeFwavjs4T6j/5L6kw98dy9/vXPsWCZiX
         FUWpLR/Lxz66vOnSxEmcpnmfj/waImf3y9bzM89ybGBDcvPGUooZaJfS9Wm+vIpqDayj
         d5IlEvXfo1RR7jZ62abZyW1mZtdexBsNyUzRwZX6qTdWMe6fJb7HjXScpkRGzw0lDVmZ
         CAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtLsUqxObl5gNvozPidJotWpMooTYg5mjWrhCt6bCKc=;
        b=tTrineLwu5ZVDRXRz/0tcKcgEn57LtHKFvw/lBQ7oq11mtF/9REG4AIrPwliEM1CpZ
         HNVZeRbiVN5Q4ni81fHfDxWPxgYNLqX3ncHRw4UM0s20108vpBegr5vJoO2oecZOyxZg
         5GnG5s7LZNBz/CBFj/ZxAKketd9nbiIpfqwwjJFsUeqmmdAFUCPEz2sRaz7hZbaofwmo
         ux8GlCnJNi9Bgn/5aEM/2N4hiOuI6Fe+WVljhSKe7JSqJDfOyQUNc3tMhO0b8oBZCEuv
         CUvv+uDQdIoo6FtDx7UTnSMEwPgvPcagG8N32wkVMNjYTqC/eNKGmm3eUViBo+fZgM0p
         Z13A==
X-Gm-Message-State: ANoB5plczxXIhf30wHcx9pxUBl1M+29rDWNCJO1DeebYExzgoA1KnpsT
        yc//nLzibuSjeLnTGp1u9jcV3w==
X-Google-Smtp-Source: AA0mqf4ukIq8f55ZwoT5lfBoGPIv3vIjf6EYKWXJHuBG4yXo1R8WH7bHnid2bOObROuEjdX9eqdlcg==
X-Received: by 2002:ac2:569e:0:b0:4b5:9e59:8cdd with SMTP id 30-20020ac2569e000000b004b59e598cddmr1912500lfr.67.1670670120896;
        Sat, 10 Dec 2022 03:02:00 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s14-20020a056512202e00b004b5284a92f9sm674523lfs.208.2022.12.10.03.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 03:02:00 -0800 (PST)
Message-ID: <3c5aeda7-6773-0b41-9c02-5f423117c3b3@linaro.org>
Date:   Sat, 10 Dec 2022 12:01:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] dt-bindings: ufs: qcom: Add reg-names property for ICE
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Luca Weiss <luca.weiss@fairphone.com>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221209-dt-binding-ufs-v1-0-8d502f0e18d5@fairphone.com>
 <24fa41d2-87d1-be19-af44-337784b0f0a4@linaro.org>
 <COXDTKRPPU1J.373YHYKBQIN38@otso>
 <a527720e-d4d9-6c90-f991-a5b123c4559b@linaro.org>
 <Y5OOA2+OuwgZ1i7B@sol.localdomain>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y5OOA2+OuwgZ1i7B@sol.localdomain>
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

On 09/12/2022 20:35, Eric Biggers wrote:
> On Fri, Dec 09, 2022 at 04:19:20PM +0100, Krzysztof Kozlowski wrote:
>> On 09/12/2022 16:11, Luca Weiss wrote:
>>> On Fri Dec 9, 2022 at 4:05 PM CET, Krzysztof Kozlowski wrote:
>>>> On 09/12/2022 15:29, Luca Weiss wrote:
>>>>> The code in ufs-qcom-ice.c needs the ICE reg to be named "ice". Add this
>>>>> in the bindings so the existing dts can validate successfully.
>>>>>
>>>>> Also sm8450 is using ICE since commit 276ee34a40c1 ("arm64: dts: qcom:
>>>>> sm8450: add Inline Crypto Engine registers and clock") so move the
>>>>> compatible to the correct if.
>>>>>
>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>>> ---
>>>>> (no cover subject)
>>>>>
>>>>> The only remaining validation issues I see is the following on sc8280xp-crd.dtb
>>>>> and sa8540p-ride.dtb:
>>>>>
>>>>>   Unevaluated properties are not allowed ('required-opps', 'dma-coherent' were unexpected)
>>>>>
>>>>> Maybe someone who knows something about this can handle this?
>>>>>
>>>>> And the patch adding qcom,sm6115-ufshc hasn't been applied yet.
>>>>> ---
>>>>>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 8 +++++++-
>>>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>>>>> index f2d6298d926c..58a2fb2c83c3 100644
>>>>> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>>>>> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>>>>> @@ -102,7 +102,6 @@ allOf:
>>>>>                - qcom,sc8280xp-ufshc
>>>>>                - qcom,sm8250-ufshc
>>>>>                - qcom,sm8350-ufshc
>>>>> -              - qcom,sm8450-ufshc
>>>>>      then:
>>>>>        properties:
>>>>>          clocks:
>>>>> @@ -130,6 +129,7 @@ allOf:
>>>>>                - qcom,sdm845-ufshc
>>>>>                - qcom,sm6350-ufshc
>>>>>                - qcom,sm8150-ufshc
>>>>> +              - qcom,sm8450-ufshc
>>>>>      then:
>>>>>        properties:
>>>>>          clocks:
>>>>> @@ -149,6 +149,12 @@ allOf:
>>>>>          reg:
>>>>>            minItems: 2
>>>>>            maxItems: 2
>>>>> +        reg-names:
>>>>
>>>> There are no reg-names in top-level, so it's surprising to see its
>>>> customized here. It seems no one ever documented that usage...
>>>
>>> From what I can tell, from driver side all devices not using ICE don't
>>> need reg-names, only the "ice" reg is referenced by name in the driver.
>>>
>>> I didn't add it top-level because with only one reg I think we're not
>>> supposed to use reg-names, right?
>>
>> And you still won't need to use. Yet property should be rather described
>> in top-level which also will unify the items here (so no different
>> 2-item reg-names in variants).
>>
>> Just add it to top-level with minItems: 1 and per variant customize:
>> 1. maxItems: 1
>> 2. minItems: 2 + required
>>
>> The "required" is a bit questionable... this was never added by Eric to
>> the bindings. Driver support and DTS were added completely skipping
>> bindings...
>>
> 
> Sorry about that.  At the time
> (https://lore.kernel.org/linux-scsi/20200722051143.GU388985@builder.lan/T/#t)
> I didn't know there was a Documentation file that should have been updated.

Any change regarding bindings (so adding/changing compatibles,
properties, nodes) a driver is using must be followed by... change in
the bindings.

> 
> The UFS core assumes that the reg at index 0 is the UFS standard registers.
> It is not referenced by name.
> 
> ufs-qcom already had an optional reg at index 1.  I needed to add another
> optional reg.  So I made the regs at index 1 and later be optional named regs:
> dev_ref_clk_ctrl_mem and ice.  That seemed better than hardcoding the indices.
> 
> Is it causing a problem that the UFS standard reg at index 0 is being mixed with
> named regs in the same list?

The indexes should be ordered (hard-coded), not flexible. If there is
already second IO address at index 1, then the patch does not look
correct. When fixing, please fix it completely.

Best regards,
Krzysztof

