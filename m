Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4AE6BDB34
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCPWAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCPV76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 17:59:58 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840036B978
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 14:59:55 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b10so3000356lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 14:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679003993;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4WnuH0tDUQQiCiidSW3pVthhXMOkg/CiHZeKLgJRDi8=;
        b=mzKXqXEprAJxkA/4iwBC4eey4i+THlJstnm9u9xDmRjyjKsWq+c+28426DRxwbHEv3
         0ivz8AQaJmSsdcZP8LKSf+MePjciu1g4MMd50V4zFWhf6kFadF/EVcGjKylW0+kTJQor
         F1jP/U5u5k+TuDlLVFc39comjUIEIPVbBP81skbNVwp2pCqwDFsrHpHsUGOU3eMPB/Cl
         NerxyE1eAV47ctqI5ZYs1ykyRLjoXOoPk/wOgQhLaRa4qBJHIACkpJSsHzmsAsX+OIof
         VeOVRAtwr2f3W5CS9/XVY0Dx5JY5anU3nsD9zRJ6J6FDxWXpouy8OvgdNzeVuH9/3Wpl
         iZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679003993;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4WnuH0tDUQQiCiidSW3pVthhXMOkg/CiHZeKLgJRDi8=;
        b=V0kQP3F6gtV6vC6UI6MJ7FcciOCaiiL5nqWRd1ZJBSFLkUYltkJqxo8dzD5sdzXbhk
         96zTWNj3J1pvM6/i5lzh8n2XZjkVlyOJ/Ubkht8gH6LmFf9KCU0MPfSuk4FZ/B6Z7Vl9
         rXZs4kWuDs8PkGdYozgKeJVU3j58NCpR6r786m+ynaXc0495H6h1PtoxLQ6F3kwlt5VW
         aCZwh8h/RPafi/8VzzPlJmZFPTIELWzR8UBE3GG+Dylw2+EVrSQUYn6R2P3ZZWk7bW4H
         yEOjVsgouvZGigESOBG+CBhc+OVZqFNj5kkvYwhZTyYEqK+rCapBX1c5fyv+nCitEl3L
         VGwQ==
X-Gm-Message-State: AO0yUKXAOU4Aqs/QFq6yXcq/kA50wvWLBGNOgj/+scTMomSZohLhwpGQ
        Ohey7khn94veDkPeuBk0ogNIy9FeY1sKfw/7yGc=
X-Google-Smtp-Source: AK7set99CIYF1Pv6CeuPL1oexcu5fMRViDQnG1Yr2+FSi/X30ppXKy3KB91K86Jvi//hx/Vp1Jwr0A==
X-Received: by 2002:ac2:4314:0:b0:4d5:a689:7f9d with SMTP id l20-20020ac24314000000b004d5a6897f9dmr3276370lfh.57.1679003993293;
        Thu, 16 Mar 2023 14:59:53 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id c26-20020ac244ba000000b004dc4feeb7c6sm60070lfm.65.2023.03.16.14.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 14:59:52 -0700 (PDT)
Message-ID: <d260b390-f6f2-493a-071c-f88c36582881@linaro.org>
Date:   Thu, 16 Mar 2023 22:59:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Document SM61[12]5 GPU SMMU
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230315-topic-kamorta_adrsmmu-v1-0-d1c0dea90bd9@linaro.org>
 <20230315-topic-kamorta_adrsmmu-v1-1-d1c0dea90bd9@linaro.org>
 <f09e93e1-235a-ea0a-902d-4f41a8c90ee5@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <f09e93e1-235a-ea0a-902d-4f41a8c90ee5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.03.2023 20:29, Krzysztof Kozlowski wrote:
> On 15/03/2023 11:52, Konrad Dybcio wrote:
>> Both of these SoCs have a Qualcomm MMU500 implementation of SMMU
>> in front of their GPUs that expect 3 clocks. Both of them also have
>> an APPS SMMU that expects no clocks. Remove qcom,sm61[12]5-smmu-500
>> from the "no clocks" list (intentionally 'breaking' the schema checks
>> of APPS SMMU, as now it *can* accept clocks - with the current
>> structure of this file it would have taken a wastefully-long time to
>> sort this out properly..) and add necessary yaml to describe the
>> clocks required by the GPU SMMUs.
> 
> 
>> +      properties:
>> +        compatible:
>> +          items:
>> +            - enum:
>> +                - qcom,sm6115-smmu-500
>> +                - qcom,sm6125-smmu-500
>> +            - const: qcom,adreno-smmu
>> +            - const: qcom,smmu-500
>> +            - const: arm,mmu-500
> 
> If you drop the hunk later (from allOf:if), then what clocks do you
> expect for non-GPU SMMU?
Both 6115 and 6125 require no clocks under the APPS (non-GPU) SMMU.
However, the list below uses a `contains:` which means I'd have
to add a whole another hunk like

	- items:
            - enum:
                - qcom,sm6115-smmu-500
                - qcom,sm6125-smmu-500
            - const: qcom,smmu-500
            - const: arm,mmu-500

and add another level of indentation to the previous one

I figured skipping that was less messy (I think we discussed this
once as well), but if you prefer to keep it strict, I can.

Konrad
	
> 
>> +    then:
>> +      properties:
>> +        clock-names:
>> +          items:
>> +            - const: mem
>> +            - const: hlos
>> +            - const: iface
>> +
>> +        clocks:
>> +          items:
>> +            - description: GPU memory bus clock
>> +            - description: Voter clock required for HLOS SMMU access
>> +            - description: Interface clock required for register access
>> +
>>    # Disallow clocks for all other platforms with specific compatibles
>>    - if:
>>        properties:
>> @@ -394,8 +420,6 @@ allOf:
>>                - qcom,sdm845-smmu-500
>>                - qcom,sdx55-smmu-500
>>                - qcom,sdx65-smmu-500
>> -              - qcom,sm6115-smmu-500
>> -              - qcom,sm6125-smmu-500
>>                - qcom,sm6350-smmu-500
>>                - qcom,sm6375-smmu-500
>>                - qcom,sm8350-smmu-500
>>
> 
> Best regards,
> Krzysztof
> 
