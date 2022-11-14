Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAD2627F91
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbiKNNAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237645AbiKNNA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:00:27 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E241B27B23
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:00:25 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bp15so19073775lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n2v6dXeivccfrn+WhZzJKqoLRW18Q+k95BcJxS2Nft8=;
        b=rl4Z7TiqBNvWPnhXh20wrOVuEE0wnCeMX6CSjyrdR3T1EEkoA1NKS/aVGWZYFtAZcr
         vLqkdcGuxLaLEfazCkIBb0gwRhCTBZD6F4IBBXheK5Re9GoiZ7Eut6vScYrrLU6W5ZgI
         EJEbQ54BV70qZwc6xuX3tq+j1Yuhtu6kON4IfDpQMB+cxsn9s2fYUW4V1LHvDj1b/eE9
         FCIWE5HsPKK8+Vmfo75AUev7GvEUZxC+HIVVbxw9fGbCgKY30b59b77YmaraD+v+SF+t
         odwE8AjsyIp5yRnRZ8V7oFyVtnOJVBH/941y61HKOBBsU1wLO9iOPs85TX4GnJbOvOnT
         0AhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n2v6dXeivccfrn+WhZzJKqoLRW18Q+k95BcJxS2Nft8=;
        b=ovMIIeY6H+9pCRDkLAYd19qnn9D+tiYFpSuARw2Jg9q4v1zxAhN98ipXTbEcsEnodV
         s8iuwFgvOdRywgUwQHjC5ccZAzyU7PzDpfW6mIlgC95NoCk/wS+zavB1CSG8dgyldkuP
         q8xVZ+ZPuQbct9YgJD7EavIBAzkcPkXnf9w0z21mvhmf3uVtrwCyZ+s7Lb+iZEs4Atwg
         l8z2VcvdkkCkRLmJIWr6HFX0P4kmUekdfRwLG96ITeVILrd+nyXadcUNbqCVT6zBgEtX
         diDLZoCXz31DBWtZ7F8PV6bBJogRikvVyO0POVhNE0fB8GcNljWlNHC9mlxYJlfq9irt
         iJsw==
X-Gm-Message-State: ANoB5pkxIfEbQnAGYQeFcHwRwBhCc/9kTm+EPzFmAeX7MlLXNv+8rC5q
        fjOu4aNEqLTVYZi18SO8/ZThRg==
X-Google-Smtp-Source: AA0mqf6Y/jRSNo3kplGT/QnTrZAPtMxVjojG2hI/OrS5/UtbcwQzGqM++6h36xwYu9aPAcYHLeGkkg==
X-Received: by 2002:ac2:5b9d:0:b0:4a2:19e0:1266 with SMTP id o29-20020ac25b9d000000b004a219e01266mr3679582lfn.264.1668430824179;
        Mon, 14 Nov 2022 05:00:24 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id l10-20020a056512110a00b004948b667d95sm1814784lfg.265.2022.11.14.05.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 05:00:23 -0800 (PST)
Message-ID: <0121fc03-b027-7659-5e6e-b42089c9888d@linaro.org>
Date:   Mon, 14 Nov 2022 14:00:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/9] dt-bindings: arm-smmu: Allow up to 3 power-domains
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a4b160d8-0faa-3f4c-a925-0beaf6ace721@linaro.org>
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

On 14/11/2022 12:17, Konrad Dybcio wrote:
> 
> On 14/11/2022 12:01, Krzysztof Kozlowski wrote:
>> On 14/11/2022 11:42, Konrad Dybcio wrote:
>>> Some SMMUs require that a vote is held on as much as 3 separate PDs
>>> (hello Qualcomm). Allow it in bindings.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>> Changes since v1:
>>> - Add minItems
>>>
>>>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>> index 9066e6df1ba1..82bc696de662 100644
>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>> @@ -159,7 +159,8 @@ properties:
>>>             through the TCU's programming interface.
>>>   
>>>     power-domains:
>>> -    maxItems: 1
>>> +    minItems: 0
>> It cannot be 0.
>>
>> minItems: 1
>>
>> Anyway you still need to restrict it per variant, as I said in previous
>> version.
> 
> Hm.. I'm not entirely sure what you mean.. Should I add a list of 
> compatibles

Yes and limit it to maxItems: 1 for "else".

> that are allowed to have 3 power-domains and leave it as it was before 
> in the
> 'else' case?

Best regards,
Krzysztof

