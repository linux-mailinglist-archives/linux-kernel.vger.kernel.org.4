Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1662C6655CC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjAKIQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjAKIQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:16:20 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCC764D2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:16:19 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id e3so5008923wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HIGwyVQacqiHb5bf3hpUUrqzBySRCldHEdV+xtBD5sA=;
        b=EKk9qUiQTIrBaOvEvy/s/zn+iaENgDwFbD3XwA1nXJV5sDoHVOMYJIR1vwT8CIly+v
         2fSciw+lxv3FdxmiykmSKVe74DTutWreBK0qvg1q1DvOv0ewSafJKeYe/GXCVHDsfRrX
         xZg2M/ATLQSZgRs3WzZ0/QdKOabiXm5uuhU4j5VWiyzR3IkGL4We+W2+wYwiz6PvxLZq
         +FJiGHSIjP2cXDjnvIq33rBRIQxXdnJ4FUOFjcslROnGh8k6tcSbyaqydDdSD05G86/c
         AwbqUH281aGBOQ83ij6k2iV8JBJEDCpqdivNAwLcZf24xvargjnKnnsMSo5iX/Tl/7qT
         xqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIGwyVQacqiHb5bf3hpUUrqzBySRCldHEdV+xtBD5sA=;
        b=Uh3wuAcMX1am1qnL6Lz15zvYM/bchg7FyYcHBVseEonUo8szgZwTdQIcY0j8rdrqZY
         tzi4vYkVCLL0jmLlN4+XbIjR2tRCGDFGWqmzczbc8aKnR1RnryOsK1WQhAsbGrgPU29y
         4c5QI/Bhi/N+Lw+EivUGNyXdW+VwU9ZUp6umTIOjP0pc9abdWLI/H5ld8Wh0/fAtNEDP
         BSF17NxvvRFOylsTMLRg9BEsnTZAwHIr8wOEBm5c6urbuCS/WsUgyiDP0Mo+RrL0Kk7e
         e7dnY4H0e7693vTLZ3ULk/bN1kFXX59yLC0cXlLrxCCb7kBonKHsx6Ha8j+4JrfxdORS
         TsKQ==
X-Gm-Message-State: AFqh2ko/8dS2v9PnK6mVrzYPrhcwG3FsFinzXCm6cfHmjBAHVRbfkFg0
        VWYvFdL+Jp569V3sU5DUJz8jSQ==
X-Google-Smtp-Source: AMrXdXtUpF24A+u0sOYmPxS/LiKCYBp0pEkJLZuU7KrwEwxgcZGkYFjo4y+fowz3eKAtReULW95HNw==
X-Received: by 2002:a5d:53cb:0:b0:27c:84c4:5913 with SMTP id a11-20020a5d53cb000000b0027c84c45913mr33014574wrw.30.1673424977839;
        Wed, 11 Jan 2023 00:16:17 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600001d100b00241d21d4652sm13035441wrx.21.2023.01.11.00.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 00:16:17 -0800 (PST)
Message-ID: <ebafbfd1-cd5a-2ef8-a0ee-685c67235816@linaro.org>
Date:   Wed, 11 Jan 2023 09:16:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: arm: qcom: add board-id/msm-id for MSM8956,
 SDM636 and SM4250
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221214150605.173346-1-krzysztof.kozlowski@linaro.org>
 <20221214152915.wshz4odyqcupo6xw@SoMainline.org>
 <65ccd0c9-8bd9-fc3c-ef33-78b905adf294@linaro.org>
 <20230111043000.6svnos6u4ynwxjgv@builder.lan>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230111043000.6svnos6u4ynwxjgv@builder.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2023 05:30, Bjorn Andersson wrote:
> On Wed, Dec 14, 2022 at 05:45:49PM +0100, Krzysztof Kozlowski wrote:
>> On 14/12/2022 16:29, Marijn Suijten wrote:
>>> On 2022-12-14 16:06:05, Krzysztof Kozlowski wrote:
>>>> Allow qcom,board-id and qcom,msm-id leagcy properties on these older
>>>> platforms: MSM8956, SDM636 and SM4250.  Also mention more OnePlus
>>>> devices using modified qcom,board-id field.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
>>>
>>>> ---
>>>>  Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> index d45e2129fce3..cfb7f5caf606 100644
>>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> @@ -925,15 +925,18 @@ allOf:
>>>>                - qcom,apq8026
>>>>                - qcom,apq8094
>>>>                - qcom,apq8096
>>>> +              - qcom,msm8956
>>>
>>> I am certain this (and msm8976) were added in [1] but it somehow got
>>> lost when that was merged as 05c0c38dc752 ("dt-bindings: arm: qcom:
>>> Document msm8956 and msm8976 SoC and devices")?
>>>
>>> Should we also add qcom,msm8976 or only when a user for that board is
>>> added?
>>
>> Bjorn,
>> You need to fix your scripts. It's not the first time when applied patch
>> is changed and its pieces are gone.
>>
> 
> I don't have any script that automagically solves merge conflicts, so if
> you prefer to avoid the occasional mistake I can start reject your
> patches as soon as they don't apply 100% cleanly.

I vote for this (unless for really trivial cases). The submitter should
know better how to resolve the conflict (through rebase) than you.

Best regards,
Krzysztof

