Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13A865255E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiLTRN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbiLTRM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:12:57 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449501D317
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 09:12:00 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bf43so19580170lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 09:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bHMQ7o8eMU9c/W6JAUVkthhn92ri9PS9bvR89gJhYW0=;
        b=oqXE3WMw5xmjv7O4/bkwH7QptqCYI/kWwy4E8Uoov9yyhZF6ClwmSnOJXNFSQjawjx
         M/ob29kZY2axdVVcDcBebhLFaGi/gltBvA4W8mv583HTF21KYsMZ76bCyaD8IxKC2Gv+
         dP/AT/wWYyp/5V6wsIzRITynJZwpl7hc3nZy9X0h83FYbAEgtMdPePy0zLNkqrtr9Pr0
         xBXDCK0fq6Yhkd1lneTqu5Qde1+YM5fgI1EBS9W2lOJLfdu60R0J8xN+p+rbGH306mRJ
         0pO5vEuggrwQpcDPRCeivBnCR0wBIat9K1NUNR9Uu/dDqj1rjhPGjttQ/Ukx5Qidyx0e
         Kjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHMQ7o8eMU9c/W6JAUVkthhn92ri9PS9bvR89gJhYW0=;
        b=weNkV6e5YRW+T0oicH0wzuwlhik5iPMwmIGGQpBKG/v/6HPfnQBxIcaI0nvQIA5pIe
         BxO83YhTCTzNQMiGgq//OjZYnVSybLFVOBRTRN0diZ/W3XhUOpDTfnEXb6X/KIb8kHYS
         Hvbe4ly+5zAaxI/VpyqvDEQ9SsRw/dRcEO6IVH0qdRaF0/FPTs8CNGr7C08a6cJNSrh/
         GEcG6ctW4t3vQa9oWjJhQ550pNgYOOYe9eogTsL/jiievV3V+D+mCi5nUKgD+WPOyFr1
         zIC4mCmkI5AK7WfqDR4iMXPIJ/8OPLsMbv7Q9zeOL12bV48vBD//c6okiSUPTj4P6KUC
         rtyQ==
X-Gm-Message-State: AFqh2kqUKO8xZOg1G3z4dotYIvaGK9aKNxM/S3y5Y5EVmG6yOF4kjqUn
        tkXB3TTm9k7aPtuiB1O2r6YgGQ==
X-Google-Smtp-Source: AMrXdXu4rLo9oESCQEthwo+rk34sDJyHbF21HZEqdrTtDTXhrPTSeeK6MZxsKNQDA8S/E9+JOtWvDw==
X-Received: by 2002:a05:6512:2805:b0:4b5:f925:52a7 with SMTP id cf5-20020a056512280500b004b5f92552a7mr1113308lfb.27.1671556318573;
        Tue, 20 Dec 2022 09:11:58 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c2-20020a056512074200b0048aee825e2esm1522120lfs.282.2022.12.20.09.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 09:11:58 -0800 (PST)
Message-ID: <bbc3c257-0a49-4c80-4586-c179c8997b50@linaro.org>
Date:   Tue, 20 Dec 2022 19:11:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: qcom: Document the sc7280 CRD
 Pro boards
Content-Language: en-GB
To:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org
References: <20221216112918.1243-1-quic_rjendra@quicinc.com>
 <Y5x+WEwTtpoV0gaR@google.com>
 <fd23e295-fea0-1b0a-752c-3cce26b57346@quicinc.com>
 <Y6HHCrl0q5BhrHOY@google.com>
 <e269300d-539e-9eb8-8b3c-d309f3abca1b@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <e269300d-539e-9eb8-8b3c-d309f3abca1b@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 18:20, Rajendra Nayak wrote:
> 
> 
> On 12/20/2022 8:00 PM, Matthias Kaehlcke wrote:
>> On Tue, Dec 20, 2022 at 10:30:32AM +0530, Rajendra Nayak wrote:
>>>
>>> On 12/16/2022 7:49 PM, Matthias Kaehlcke wrote:
>>>> On Fri, Dec 16, 2022 at 04:59:17PM +0530, Rajendra Nayak wrote:
>>>>> Add compatibles for the Pro SKU of the sc7280 CRD boards
>>>>> which come with a Pro variant of the qcard.
>>>>> The Pro qcard variant has smps9 from pm8350c ganged up with
>>>>> smps7 and smps8.
>>>>>
>>>>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>>>>> ---
>>>>> v4 changes:
>>>>> Added the zoglin-sku1536 compatible along with hoglin-sku1536.
>>>>> Zoglin is same as the Hoglin variant, with the SPI Flash reduced
>>>>> from 64MB to 8MB
>>>>>
>>>>>    Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>>>>>    1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml 
>>>>> b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>>> index 1b5ac6b02bc5..07771d4c91bd 100644
>>>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>>> @@ -558,6 +558,12 @@ properties:
>>>>>              - const: google,hoglin
>>>>>              - const: qcom,sc7280
>>>>> +      - description: Qualcomm Technologies, Inc. sc7280 CRD Pro 
>>>>> platform (newest rev)
>>>>> +        items:
>>>>> +          - const: google,zoglin-sku1536
>>>>> +          - const: google,hoglin-sku1536
>>>>
>>>> Is there actually such a thing as a 'hoglin-sku1536', i.e. the Pro 
>>>> qcard
>>>> with 64MB of SPI flash, or do they all have 8MB of flash?
>>>
>>> The SPI flash is on the CRD mother-board and not on the qcards, so if 
>>> you replace
>>> the qcards on the CRDs with 64MB flash you would need the 
>>> hoglin-sku1536 to
>>> boot on those.
>>
>> With such a configuration how does the bootloader know it should pass 
>> the kernel
>> the device tree for 'hoglin-sku1536' (pro) and not the non-pro 
>> variant? IIUC the
>> device tree is selected based on pin strappings on the mother-board, 
>> not the
>> qcard.
> 
> The device tree is selected based on the pin strappings _and_ additional 
> logic
> to dynamically identify modem/non-modem(wifi) as well as pro/non-pro 
> SKUs which
> was added in the bootloaders.

Just to clarify things, when you mention pro SKU, is it a separate SoC 
revision (like sc7280-pro vs bare sc7280), or is it a CRD revision (CRD 
Pro vs bare CRD)?

-- 
With best wishes
Dmitry

