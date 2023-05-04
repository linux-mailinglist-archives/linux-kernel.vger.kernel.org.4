Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1216C6F6FD2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 18:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjEDQWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 12:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEDQWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 12:22:09 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE69359F
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 09:22:07 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ac831bb762so2119671fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 09:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683217326; x=1685809326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0//78+uXYFr6PUUQe4KmtdkJ/mFw3NuDFvW5FcRoZQ=;
        b=b2PPRS393qwzfXujkfb1itL3HU4nmRZ2GeFjtSbxbb4B5LWfmP2u/7SUg3VP6ZfnId
         JuSqBYz9XknIcLBR5BSO2b+0duwUwM6ypEiA3aRpz5wbdWz9R1ricHxiKK4T2KEmbbEY
         ok27nLjU0jqjlBkP5hxLkRSPXDJeJgFdP4Trcaecy4XbcnrZfB+3zH2CavTN2tAw+Pon
         8iFEHWgBI3j0XanI+EcsXcaFZlZ2hf5NiG47XY6zSAJ1wqtVBW58mT+QrBuWKw5dLsrY
         YloQuSMGfNajcySaziY/1qubxqI6oztOMv4Iw0Ue8pZEt89v6IbF4iQeFhe5uL+NYcYO
         T9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683217326; x=1685809326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0//78+uXYFr6PUUQe4KmtdkJ/mFw3NuDFvW5FcRoZQ=;
        b=Vp3eXSHRi8dfHF0Di6X+NVRuUy0vZ9YNhYAshKanUkSX0LTdeKgUHUV/Bkrjvnn4n7
         ki4ULAKGuwCaEyYvDHbA8tbr00C6A0PVhif6I993O/wkeIokDR+OTDLh45eBXrdAU9eb
         v/JFwfBh27soT10bCHdDutWy5A98EmOOoupRUedOeyefLsyi6xnrMcR0YevEIz4Tk83p
         7fcVfh2a5gb5yOJqu/XgVhaFb6GA06X13OTQg5wgslZeX2htz1Aa+PxLV7BO10fiJZ3L
         wplpEujD+6xbvfGKYRlpS8JdnlJnzVORZAJEkgO/F90QS0am0VJCwf7FlPlrPg0CwwS4
         muoA==
X-Gm-Message-State: AC+VfDxIkxJrvHIkMNUo8pl34ty5ESAb5KsBiijWCyo49ETn6RLpXAWf
        3IvSYx0f8IkHgeODM1rUf0tZUA==
X-Google-Smtp-Source: ACHHUZ7nzyVmwttPurr+ePQF0cmLpk+IMorprUHkikxMLmIjeifJSsAylHxffCQRQTHoMTrpLLc5bA==
X-Received: by 2002:a2e:a30b:0:b0:2aa:af16:5c55 with SMTP id l11-20020a2ea30b000000b002aaaf165c55mr1105267lje.44.1683217326048;
        Thu, 04 May 2023 09:22:06 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id p16-20020a2e8050000000b002a8c409f1f5sm6658915ljg.110.2023.05.04.09.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 09:22:05 -0700 (PDT)
Message-ID: <4d6568cd-3678-f3ec-36b3-0b4b474d9871@linaro.org>
Date:   Thu, 4 May 2023 19:22:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V4 1/3] dt-bindings: sram: qcom,imem: Add Boot Stat region
 within IMEM
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1681742910.git.quic_schowdhu@quicinc.com>
 <NO2MhqhxQqjQ33CVOtaXXxo2iBfl6Ugz1lE5oJAl-mjUyrRu4l9vCBWV8AVJZoCrVF0Cw0j49t44Bn5yEAv3mA==@protonmail.internalid>
 <bd3350e3b0b02669cffa4bdaf9a0a1d8ae9072d1.1681742910.git.quic_schowdhu@quicinc.com>
 <9da030c6-6a9f-6766-7120-94aaa8fcd8ab@linaro.org>
 <3ef818c8-1ee4-5bee-6b37-20658b2e4637@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <3ef818c8-1ee4-5bee-6b37-20658b2e4637@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 09:26, Krzysztof Kozlowski wrote:
> On 04/05/2023 00:10, Caleb Connolly wrote:
>>
>>
>> On 17/04/2023 16:08, Souradeep Chowdhury wrote:
>>> All Qualcomm bootloaders log useful timestamp information related
>>> to bootloader stats in the IMEM region. Add the child node within
>>> IMEM for the boot stat region containing register address and
>>> compatible string.
>>>
>>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>>> ---
>>>   .../devicetree/bindings/sram/qcom,imem.yaml        | 22 ++++++++++++++++++++++
>>>   1 file changed, 22 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>> index ba694ce..d028bed 100644
>>> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>> @@ -49,6 +49,28 @@ patternProperties:
>>>       $ref: /schemas/remoteproc/qcom,pil-info.yaml#
>>>       description: Peripheral image loader relocation region
>>>
>>> +  "^stats@[0-9a-f]+$":
>>> +    type: object
>>> +    description:
>>> +      Imem region dedicated for storing timestamps related
>>> +      information regarding bootstats.
>>> +
>>> +    additionalProperties: false
>>> +
>>> +    properties:
>>> +      compatible:
>>> +        items:
>>> +          - enum:
>>> +              - qcom,sm8450-bootstats
>>
>> This region isn't exclusive to sm8450, it exists also on sdm845 and
>> presumably other platforms. Is there any need for an SoC specific
>> compatible?
> 
> Yes.
> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42
> 
> Also see many discussions on LKML about this.


I checked the closest relative: qcom_stats.c driver. It defines several 
platform-specific overrides and also a generic "qcom,rpm-stats" / 
"qcom,rpmh-stats" drivers.

-- 
With best wishes
Dmitry

