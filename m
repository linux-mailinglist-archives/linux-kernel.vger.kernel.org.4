Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8688262DFE1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbiKQPb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbiKQPbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:31:24 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2A3E0F3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:31:22 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id l12so3370301lfp.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ZDPP+aUXlZemByZePEOYfbPXmIJ7PrfAxeoclG9vKA=;
        b=Ls8lqLlbSmZ3nDW91wC00qBfwO+G/ZR0QKdhCiZD8afsSdScPioce3STIi1JipVF2h
         DWGPr8nO420ko9tRE9jVqbuwSEum10pccwYMckN6j/X6OyMuggrwlUX6grzEdhrftRDt
         28tuko8xJbX/FXa9eiUwiDWOdbKctULqli4Ax9mdPqQGdqnWaQNSvCovO50aV4mRIKqr
         8ZwPMo5nHmIqbTy6qK68XSBLNerWnPFtaBWC/64cOmcUs84ZYsH+xXJmxuA4+kdv3rlz
         +F1GqeQ9ZfqS4bI8SCQXmTaL7KjQoomNKY6C6NHPkqf5wvKTfiUl2S9aqH6txJTiLvAJ
         qiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZDPP+aUXlZemByZePEOYfbPXmIJ7PrfAxeoclG9vKA=;
        b=i20ybSU7GyPNQAlXvUjhTFoCw9FHjkDF3kycrMnZMnoxXJUwqkiUlQHHChobPgF8BC
         j3kNPlEzfIIh65HVzPHkmFHh2s6sBQChuN5p1dkydSKJQgJc6ajDT2pyk7zip++4c1Ff
         /Ie+vkxedOpKCYsXFmjVGbNSfSlV/pn049sEGdpXl2vte1M15TVTJKcrT71GbDkkpk8G
         TbPu1gCRqWQU8tm/kuZAXnAo3Lwtg535ECkWzFH8abif6h+qjG0J15MudikD/BRNTDzu
         b9QQfmVSX+9wiyDBbbYjpfrOoPegtBLs8iUN3PI8AHCOlsDnLB5xg26zxyj2caWDzEzh
         a+mQ==
X-Gm-Message-State: ANoB5pnW+QTcgaJDuui8foc9u6FWG1VMT1Lb2ZJjCr6LkBwSlyGh+uRy
        qrRdQNgD1wx9BnsU9OPHQ0nOGg==
X-Google-Smtp-Source: AA0mqf6RlDxCX7aqxKe4kbGzIpCYGdKKByTw5/epkfsWWgWGVUK44nQD0oz21XmFFBmgYhkCzfs8Tg==
X-Received: by 2002:ac2:4843:0:b0:4a2:1169:3934 with SMTP id 3-20020ac24843000000b004a211693934mr1140697lfy.279.1668699081228;
        Thu, 17 Nov 2022 07:31:21 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id x12-20020a19f60c000000b0048b26d4bb64sm200669lfe.40.2022.11.17.07.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 07:31:20 -0800 (PST)
Message-ID: <89e0f9b7-e06d-ea26-6e45-d22a74371f4b@linaro.org>
Date:   Thu, 17 Nov 2022 16:31:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: simplify if:then:
 clauses
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20221117130254.378109-1-krzysztof.kozlowski@linaro.org>
 <Y3ZFDRI6ypg18S27@gerhold.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y3ZFDRI6ypg18S27@gerhold.net>
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

On 17/11/2022 15:28, Stephan Gerhold wrote:
> On Thu, Nov 17, 2022 at 02:02:54PM +0100, Krzysztof Kozlowski wrote:
>> Most of the device-specific compatibles have generic fallbacks like
>> qcom,tsens-v1 or qcom,tsens-v2.  The if:then: block mentions these
>> fallbacks, so drop redundant entries for specific compatibles.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>  .../devicetree/bindings/thermal/qcom-tsens.yaml  | 16 ----------------
>>  1 file changed, 16 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> index f0bd4b979e28..c9949713f714 100644
>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> @@ -118,12 +118,7 @@ allOf:
>>            contains:
>>              enum:
>>                - qcom,ipq8064-tsens
>> -              - qcom,mdm9607-tsens
>> -              - qcom,msm8916-tsens
>>                - qcom,msm8960-tsens
>> -              - qcom,msm8974-tsens
>> -              - qcom,msm8976-tsens
>> -              - qcom,qcs404-tsens
>>                - qcom,tsens-v0_1
>>                - qcom,tsens-v1
>>      then:
> 
> FWIW: I submitted the same patch for this part a couple of months ago,
> it was never applied for some reason:
> https://lore.kernel.org/linux-arm-msm/20220627131415.2868938-2-stephan.gerhold@kernkonzept.com/

Indeed, somehow Daniel didn't take it. Your patch should go instead, if
you rebase and include new hunks (like my patch).

> 
>> @@ -140,17 +135,6 @@ allOf:
>>          compatible:
>>            contains:
>>              enum:
>> -              - qcom,msm8953-tsens
>> -              - qcom,msm8996-tsens
>> -              - qcom,msm8998-tsens
>> -              - qcom,sc7180-tsens
>> -              - qcom,sc7280-tsens
>> -              - qcom,sc8180x-tsens
>> -              - qcom,sdm630-tsens
>> -              - qcom,sdm845-tsens
>> -              - qcom,sm8150-tsens
>> -              - qcom,sm8250-tsens
>> -              - qcom,sm8350-tsens
>>                - qcom,tsens-v2
>>      then:
>>        properties:
>>
> 
> This part was not present back then though. Looks like this was
> introduced recently in "dt-bindings: thermal: tsens: Add ipq8074
> compatible".
> 
> I don't mind if you take this patch instead of mine. Feel free to add my
> 
> Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
> 
> Thanks,
> Stephan

Best regards,
Krzysztof

