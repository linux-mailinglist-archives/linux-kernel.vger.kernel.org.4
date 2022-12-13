Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584C064BB93
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 19:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbiLMSHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 13:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbiLMSG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:06:59 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5C6240B3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:06:47 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id p8so6193835lfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ADpodWKXROZu/3D+Zxer6l8IxEoAVXT4LlWfeI8NjbI=;
        b=QMwjkoir1ul5Xka1V9XDto/QZCV7qWabFkeYDzEs08Sz4QgXBTb4jSc9cV1CPDuyLV
         vY2O+dpeDflpgh5YtGadK9EZq5ssrGI35o0sEMYYG/0GMWeTaIB9I+IRC6FFsjYeHbBP
         q+bxHCtxCkgYU8XEjq4KswgR53edjv9dX8uI35aE8H+vfsqepB4WatzI3mMUidU3S45F
         /fH195BOCSnIN3we/1EfobW1JA5DnqCHAIiTbWSitLaqqy6XJwuUZy9v4/BBFx504nd/
         8Y2dGs5+idsYlxw5SjuAdIQunN607EQ00Gzk7p0AkawzRInKtShLO6VTe8ohqJxFsDDx
         ETbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADpodWKXROZu/3D+Zxer6l8IxEoAVXT4LlWfeI8NjbI=;
        b=4EODBKan2S565ZRaanyMdQEdo6WZT12x3KjfFVoidOL3ZOhjacjmNbh2KxDVt/SDdr
         tN32Ew6soqH3xlhpbURyfph/HwQUGLVTA5bK4zVCFPgoqDISBdZycx6q1H93aXiqjpaT
         KYY9gQ4r7/LNANJ8J9iegv3TsBaKaurtR7b/ZjmgTv6UMtGGGggSavRZalweq0WIAzuz
         WV3F0Nb6XGl4JILevcgI3Wbg84UZl3dWgC9fO/BIJOQtmp50Bpj3lUg1e0Z5/M8Nne6s
         LmkP8ChPuSRrfrapk7fvj6LRkTgM9HWhUWpuB7SE9pbvOEbvUf8PFuXWZ5TIUqJq7j1b
         k8cA==
X-Gm-Message-State: ANoB5pmMW3YIY+ClZBVM2MXJtJQlJ3TWsW0DYaCbqxshcQ9Xm3WyXm+Y
        8u14OUPqDQ7LfMr+kRkCef460g==
X-Google-Smtp-Source: AA0mqf7sUGungFI5a/97OKrQx5IbqK4ZIfMYj93YgT+DCO0eJ3Yh2Ot1uIneRrVv+5l1e8oxTpvp+g==
X-Received: by 2002:a05:6512:15a7:b0:4b6:e494:a98d with SMTP id bp39-20020a05651215a700b004b6e494a98dmr4223840lfb.44.1670954806151;
        Tue, 13 Dec 2022 10:06:46 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id v10-20020ac2560a000000b00497aa190523sm454543lfd.248.2022.12.13.10.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 10:06:45 -0800 (PST)
Message-ID: <1a950cde-6713-a14e-f899-3450dbad5312@linaro.org>
Date:   Tue, 13 Dec 2022 19:06:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/4] dt-bindings: i2c: qcom,i2c-cci: Fall back to common
 compatibles
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221213115628.105149-1-konrad.dybcio@linaro.org>
 <b8be66e0-f987-b3ec-b78e-5be8bf54b05e@linaro.org>
 <b289a9c5-54de-5ca4-b247-90751be05fa9@linaro.org>
In-Reply-To: <b289a9c5-54de-5ca4-b247-90751be05fa9@linaro.org>
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



On 13.12.2022 18:01, Konrad Dybcio wrote:
> 
> 
> On 13.12.2022 17:58, Krzysztof Kozlowski wrote:
>> On 13/12/2022 12:56, Konrad Dybcio wrote:
>>> Almost every compatible string in the CCI driver is a duplicate. Adjust
>>> the bindings to include a common (first-soc-implementing-vX) compatible
>>> to remove the need to keep adding superfluous compatible strings.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>  .../devicetree/bindings/i2c/qcom,i2c-cci.yaml | 25 +++++++++++++------
>>>  1 file changed, 17 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>> index cf9f8fda595f..65cf7860a9a0 100644
>>> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>> @@ -12,14 +12,23 @@ maintainers:
>>>  
>>>  properties:
>>>    compatible:
>>> -    enum:
>>> -      - qcom,msm8226-cci
>>> -      - qcom,msm8916-cci
>>> -      - qcom,msm8974-cci
>>> -      - qcom,msm8996-cci
>>> -      - qcom,sdm845-cci
>>> -      - qcom,sm8250-cci
>>> -      - qcom,sm8450-cci
>>> +    oneOf:
>>
>> Except missing test,
> Hm? I tested this locally with dt_binding_check and it passed..
Eh, looks like I didn't hit save before running it or something,
I see it now, sorry bout that..

Konrad
> 
> how about also adding a comment to the driver, that
>> list of compatibles should not grow when not needed?
> Sure.
> 
> Konrad
>>
>> Best regards,
>> Krzysztof
>>
