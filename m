Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819EF671E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjARNjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjARNin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:38:43 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFC5B4E31
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:08:35 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r9so11087171wrw.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MhcLCYviwxqI/VsqmLVJgx9rPgKwghAfrMXFXyiVeMM=;
        b=hrOFDURWILT2DqGWyL9qinjOdyZ41Inq585N9fqjmq4tMiNrg+7Aha4q8ZHKBnX9lH
         alBoOGJvlNF7suTvXFO5bD/db6HrxjibcCiS9Cw+SJEyouu5KnZTrz3iyG2x+TKs0lhh
         sjVN6TTkMIsyLFeNopOryUUDuAh68zZC3gZjXgnOkGr7eTw43nAAgE5l3Le2fXwxAf6c
         1yZmRUp8LEeaexLfDKPMYGtnLXyM/DSwYPLZ7iGzOg9xrSCrjDsmdd8D+lBChVSYmpqN
         PYLT27AbnmuiIUNtvyNKhkyr9A2hV0+v1QtEO7YIeOCLLx/PrpO7T1wcnomtoVLSM2cX
         NT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MhcLCYviwxqI/VsqmLVJgx9rPgKwghAfrMXFXyiVeMM=;
        b=Qn5mt4ROEWdvBOXioZ7vpmJ9Lm5vVhBT5zDLaHEHyIcDOLl5d0f6afz09OWsbHxLWJ
         IbMbPx7NEsGAT4PQP/TXck2LX2UxrdA2utXkk6ws3KhZqq6yptk7KFbJSZvY6THz7kZP
         aOOWyxhtWUPQczInow0ET8Cc7JYU7fVpId4WKtQJx9kg2WeTpkNfeU/j/Y8pJm6aJ3Gg
         hqY6X80cD0l/AxYLNksbEfmHlqn6Zbdgn9RebFU1HgAjTCKmjBvEZHXV00sxCSi8yV2b
         sOj2WzfBIyTGUlhlG5njssXbKbooDb4NVbF5nIpXwzQ19PZBzyL8xAqlE5/EmR0K4r2y
         9Nzw==
X-Gm-Message-State: AFqh2kphy+2cBq4BKWQFzSemUlbpY8u+15gLIu7EZAig16DxlkDYFdth
        9lu/JCd7sk2iLiHl95wukdFiCw==
X-Google-Smtp-Source: AMrXdXsbEtOlMUXBm6MGE3A8haF9JqMc8uZ+r0UYeA5e8mgWxLZc5suwqnbcl0ee96wZ9yHrk+JVEQ==
X-Received: by 2002:a5d:50c9:0:b0:2b4:790e:32f3 with SMTP id f9-20020a5d50c9000000b002b4790e32f3mr5709204wrt.68.1674047310799;
        Wed, 18 Jan 2023 05:08:30 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f2-20020adff982000000b002bde537721dsm13362962wrr.20.2023.01.18.05.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 05:08:30 -0800 (PST)
Message-ID: <a4a39197-a58b-df5b-1dc8-fa9fd520bbc2@linaro.org>
Date:   Wed, 18 Jan 2023 14:08:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 3/6] dt-bindings: mailbox: qcom: correct the list of
 platforms using clocks
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230117223013.1545026-1-dmitry.baryshkov@linaro.org>
 <20230117223013.1545026-4-dmitry.baryshkov@linaro.org>
 <efd7df12-d94b-4850-728d-416bdbbc295a@linaro.org>
 <f575e888-b2ee-6568-7e63-708ad016ac5f@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f575e888-b2ee-6568-7e63-708ad016ac5f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 14:04, Dmitry Baryshkov wrote:
> On 18/01/2023 13:41, Krzysztof Kozlowski wrote:
>> On 17/01/2023 23:30, Dmitry Baryshkov wrote:
>>> Only three platforms require `pll' and `aux' clocks: msm8916, msm8939
>>> and qcs404. Correct the list of platforms in the corresponding clause.
>>>
>>> Fixes: 0d17014e9189 ("dt-bindings: mailbox: Add binding for SDX55 APCS")
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>   .../mailbox/qcom,apcs-kpss-global.yaml        | 33 ++++++++++++++-----
>>>   1 file changed, 25 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
>>> index ecc286ab49ef..7d8de7a16984 100644
>>> --- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
>>> +++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
>>> @@ -72,15 +72,8 @@ allOf:
>>>           compatible:
>>>             enum:
>>>               - qcom,msm8916-apcs-kpss-global
>>> -            - qcom,msm8994-apcs-kpss-global
>>> -            - qcom,msm8996-apcs-hmss-global
>>> -            - qcom,msm8998-apcs-hmss-global
>>> +            - qcom,msm8939-apcs-kpss-global
>>>               - qcom,qcs404-apcs-apps-global
>>> -            - qcom,sc7180-apss-shared
>>> -            - qcom,sdm660-apcs-hmss-global
>>> -            - qcom,sdm845-apss-shared
>>> -            - qcom,sm6125-apcs-hmss-global
>>> -            - qcom,sm8150-apss-shared
>>>       then:
>>>         properties:
>>>           clocks:
>>> @@ -124,6 +117,30 @@ allOf:
>>>             items:
>>>               - const: pll
>>>               - const: xo
>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          enum:
>>> +            - qcom,msm8953-apcs-kpss-global
>>> +            - qcom,msm8976-apcs-kpss-global
>>> +            - qcom,msm8994-apcs-kpss-global
>>> +            - qcom,msm8996-apcs-hmss-global
>>> +            - qcom,msm8998-apcs-hmss-global
>>> +            - qcom,qcm2290-apcs-hmss-global
>>> +            - qcom,sc7180-apss-shared
>>> +            - qcom,sc8180x-apss-shared
>>> +            - qcom,sdm660-apcs-hmss-global
>>> +            - qcom,sdm845-apss-shared
>>> +            - qcom,sm4250-apcs-hmss-global
>>> +            - qcom,sm6115-apcs-hmss-global
>>> +            - qcom,sm6125-apcs-hmss-global
>>> +            - qcom,sm8150-apss-shared
>>
>> Isn't this in multiple places now? This doesn't match what you remove
>> either.
> 
> Yes, I addsd several platforms. I can split this into two patches: one 
> moving the platforms and another one adding missing platforms. Would you 
> prefer it?

Yes, plus you now duplicated entries, didn't you? As I pointed - some of
them are in multiple places now.

Best regards,
Krzysztof

