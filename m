Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957AF6A3DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjB0JIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjB0JIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:08:20 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4115C274BE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:59:45 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id ck15so22875879edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677488371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pl3dkRXMmAk1JBFimIqhpxnC6XsfsDXMDQ44PxTCQ/s=;
        b=MS+q4xP1VXhu1mYjPdVbAW69obQbF8iGm/4GKgrWDLhTIMul+XKz3cTfjMo5hamRBa
         eb19kEhcqvNBq4xI9URQUABKdMhwB1tP2Zr9nteXXzoQpBDK4R4BL31VJqyhr4rvboHu
         uv6QUFgeE54EIWPMUgbBd8Pe7xVmKSaULnoEpt0IH5CCkmXGXRKbyXm7W0AvmEhlnxcy
         mimqx26kqrO/JV1aQAWU6Kk5m46Sbqd4DPrLfDV8ZuFiAN2N57eMfeK2KRqLZN4xbvnt
         0U47+0PCy2Gxrtj4FBjRVfyzhDZjBhA+i6Xe/rCwpkwNiaJr0DR7ngmq3zxHXrtuth3O
         7iBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677488371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pl3dkRXMmAk1JBFimIqhpxnC6XsfsDXMDQ44PxTCQ/s=;
        b=FT883t2t2oEZKbMUY/pYVpemhCKaSqWtekTpAWteZCytvL2iWIuhWPl8QTl/ySrnfj
         GR6/ZeHnol3Yl238JByj5ljgGdpuva9Q048b2k0NL8lxz5DohOCo1GGTWq7UAurY3hhd
         PxboB4eM9EndpxoqzApcPX4aZbMo8OpQN3H5TKHhmqKwZNwF29BlGZSUD7vPRQBfO6kS
         OXEe+qiO6uIg7c6wB50L7Wnc1hAq8qAIE0CilLl4/glM/2f+Udg8c9L2gC2MC1E9Jr03
         NxdPbgS/iUdyVkGSV1X4ou1oiIK8qhDhfiEtjGMuDub1GkEb2KjoUAuo2tMFsvMpWtcO
         vMYA==
X-Gm-Message-State: AO0yUKVjJXbmDHN0UxdQukR3h6Mq0XGEa++ne5+MFi51nk4O8DgmgNxU
        eY0Mkq57ug3EVTaeQUP2cPGRZMH4WdJ9Y16l
X-Google-Smtp-Source: AK7set/Gvtsf5P7zOB+MC4cBLFFsUoGA6x+8HxOLVIaK3IY1MS+lDHx3oVzZik2heawiFH8nJ7qjMg==
X-Received: by 2002:a05:651c:2228:b0:295:9c2e:7324 with SMTP id y40-20020a05651c222800b002959c2e7324mr7173325ljq.4.1677487397220;
        Mon, 27 Feb 2023 00:43:17 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id i2-20020a05651c120200b002935305ff4asm643079lja.82.2023.02.27.00.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 00:43:16 -0800 (PST)
Message-ID: <3aa78b15-8e6c-9657-0d08-0d0452d51fbe@linaro.org>
Date:   Mon, 27 Feb 2023 09:43:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/6] dt-bindings: arm-smmu: Use qcom,smmu compatible
 for MMU500 adreno SMMUs
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, marijn.suijten@somainline.org,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230217111613.306978-1-konrad.dybcio@linaro.org>
 <20230226173706.GA60188-robh@kernel.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230226173706.GA60188-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.02.2023 18:37, Rob Herring wrote:
> On Fri, Feb 17, 2023 at 12:16:08PM +0100, Konrad Dybcio wrote:
>> qcom,smmu-500 was introduced to prevent people from adding new
>> compatibles for what seems to roughly be the same hardware. Use it for
>> qcom,adreno-smmu-compatible targets as well.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>> v1 -> v2:
>> - Add this patch, omitted previously (big oops)
>>
>>  .../devicetree/bindings/iommu/arm,smmu.yaml        | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> index 807cb511fe18..4d7f61700cae 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> @@ -75,9 +75,19 @@ properties:
>>                - qcom,sm8350-smmu-500
>>                - qcom,sm8450-smmu-500
>>            - const: arm,mmu-500
>> -
>> -      - description: Qcom Adreno GPUs implementing "arm,smmu-500"
>> +      - description: Qcom Adreno GPUs implementing "qcom,smmu-500" and "arm,smmu-500"
>> +        items:
>> +          - enum:
>> +              - qcom,sc7280-smmu-500
>> +              - qcom,sm8150-smmu-500
>> +              - qcom,sm8250-smmu-500
>> +          - const: qcom,adreno-smmu
>> +          - const: qcom,smmu-500
>> +          - const: arm,mmu-500
> 
> 4 compatibles seems excessive. Is adding one that helpful? Is 
> 'arm,mmu-500' useful on its own?
Yes.

per-soc compatible is there for per-soc quirks should there be any
qcom,adreno-smmu enabled per-process pagetables
qcom,smmu-500 matches the qcom smmu implementation
arm,mmu-500 matches the smmu driver as a whole

> 
>> +      - description: Qcom Adreno GPUs implementing "arm,smmu-500" (legacy binding)
> 
> Perhaps fix the existing typo: arm,mmu-500
Ack

Konrad
> 
>> +        deprecated: true
>>          items:
>> +          # Do not add additional SoC to this list. Instead use previous list.
>>            - enum:
>>                - qcom,sc7280-smmu-500
>>                - qcom,sm8150-smmu-500
>> -- 
>> 2.39.1
>>
