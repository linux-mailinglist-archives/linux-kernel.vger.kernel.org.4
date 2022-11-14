Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF8A628463
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237166AbiKNPxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbiKNPxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:53:39 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0652DA96
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:53:37 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id c25so13755641ljr.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFWd2m5XWAIUBukAvtG87ESkORevoEKwbahoShbsHGs=;
        b=gHKpaujIP4yqkPLWSxP/u7oOLFIAUkdMqLmA2+M/QEBY4DUULV8ZWQ2SSHqq/xUBff
         MDdDnV5i+9H4tVU+S0gIms9A5gbbT9D5LNPkzWPLBIvyIud5QSkUDfiRf7T5V/bQbg50
         S8D1lkrwkdYQdzNx0CnkcRG08tvhfCEX/eV03FRz37df8u3eflXTgGKYBavc5XG33NCh
         Sk70zjtPZHMO/yD9ctcTLLx9yaKv3Gb45tf2kUu2zqFgDagTEsi1zZ/Y2ieLgaXbdSdO
         tROJy7mrxMIgPwvFUtuNbxW3Gx+a+Ar1iN8D4W3sDpbawFXw4JYQQsOtxNA7Mn1zoElR
         0hgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iFWd2m5XWAIUBukAvtG87ESkORevoEKwbahoShbsHGs=;
        b=NX/J/29pfELFaRn14qmFofur+vv+1rdK9EIGDmEu9UXUBG+w+WdIQbXbuNAkCmVLWm
         IHkdIHIZWVMLcyawwoE43dNmou2DonKwIQNOeX2WSE41fqDlXK4COXY+RtD+azRVICO0
         yp9UlGyBYN7D9uwsIhzfRjYgDQDgShY7FXRMWOEBmDciHpPHl0Z1rcUXvslcfSbYZNmj
         qzL6iQUn2KzFtr+QrgDLtPyGVC1607tS2uHxuge9JFhsszolJRiig98jh0ea4uyWauvG
         wnVzFAz9xVp+d5TxWcoeCmIjDjmIsxpgHcMejQg5cfWjmKyAoC18WQCjE2Zdudry6sXe
         rH6g==
X-Gm-Message-State: ANoB5pm0+Tifs6AgsFgPZ8XY+6H02RWJGdf+MJHg0GwttfLzQRAzsGL9
        RvfWXksXOdaCTWxd25A6QM/tTQ==
X-Google-Smtp-Source: AA0mqf7u3FO6mqMqL/O/9MD1mYQ8T/xRPY8vSC+lEwCmp+D+mRgb+hzX8+tpF096sntwINEzwHms9Q==
X-Received: by 2002:a2e:7310:0:b0:277:d86:a36d with SMTP id o16-20020a2e7310000000b002770d86a36dmr4258270ljc.288.1668441215396;
        Mon, 14 Nov 2022 07:53:35 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id h31-20020a0565123c9f00b00498f00420e9sm1857160lfv.194.2022.11.14.07.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 07:53:34 -0800 (PST)
Message-ID: <12578e05-ced9-e5f7-7922-0af2f2159333@linaro.org>
Date:   Mon, 14 Nov 2022 16:53:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/9] dt-bindings: arm-smmu: Allow up to 3 power-domains
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221114104222.36329-1-konrad.dybcio@linaro.org>
 <20221114104222.36329-2-konrad.dybcio@linaro.org>
 <6fa8e3ea-2113-d930-96bc-3726d53e5bcd@linaro.org>
 <a4b160d8-0faa-3f4c-a925-0beaf6ace721@linaro.org>
 <0121fc03-b027-7659-5e6e-b42089c9888d@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <0121fc03-b027-7659-5e6e-b42089c9888d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/11/2022 14:00, Krzysztof Kozlowski wrote:
> On 14/11/2022 12:17, Konrad Dybcio wrote:
>> On 14/11/2022 12:01, Krzysztof Kozlowski wrote:
>>> On 14/11/2022 11:42, Konrad Dybcio wrote:
>>>> Some SMMUs require that a vote is held on as much as 3 separate PDs
>>>> (hello Qualcomm). Allow it in bindings.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>> Changes since v1:
>>>> - Add minItems
>>>>
>>>>    Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>> index 9066e6df1ba1..82bc696de662 100644
>>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>> @@ -159,7 +159,8 @@ properties:
>>>>              through the TCU's programming interface.
>>>>    
>>>>      power-domains:
>>>> -    maxItems: 1
>>>> +    minItems: 0
>>> It cannot be 0.
>>>
>>> minItems: 1
>>>
>>> Anyway you still need to restrict it per variant, as I said in previous
>>> version.
>> Hm.. I'm not entirely sure what you mean.. Should I add a list of
>> compatibles
> Yes and limit it to maxItems: 1 for "else".

I tried adding:



   - if:
       properties:
         compatible:
           contains:
             enum:
               - qcom,sm6375-smmu-500
     then:
       properties:
         power-domains:
           minItems: 3
           maxItems: 3
     else:
       properties:
         power-domains:
           maxItems: 1


Right under the nvidia reg if-else in the allOf, but dtbs_check throws 
errors like:


/home/konrad/linux/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dtb: 
iommu@5040000: 'power-domains' does not match any of the regexes: 
'pinctrl-[0-9]+'


Any clues as to why?


Konrad

>
>> that are allowed to have 3 power-domains and leave it as it was before
>> in the
>> 'else' case?
> Best regards,
> Krzysztof
>
