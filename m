Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB53564CE49
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbiLNQp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238488AbiLNQpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:45:54 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3772C1ADB0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:45:53 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id p8so11382332lfu.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RRWASIa+62gB90taCgH38XNmbnY0IGXkKz42ekdHkC8=;
        b=jAAGbPTy++KAAsmhxh0DStHS8KA4dG5vvOWIhsKqYMw5HRtrcqNFtSbxIKqYafvpa5
         4y4gpbdQIxwoObYuDT6HrPFOaAsVEs7c88J8M9mV795+zXVNeRVyPI1e1GIyQAxNzTZM
         Eu2Hl8eYcoFiKB1eV/4GlX2gUh0b2FXtp2n4P4DXw+9GR+MRjKeOGtx1F0E4YgnT0Zcu
         2IMwk/RQQdCE7z/zfoeKXGpTHyH+y9sPP5QkLTmTNX0eTrX0Xr4XiXrpcc7/Op4g/jHc
         WL8862bK7laWpsAQ4zCCg6W81RMRdextNH/bUGfz96QGSqUXnzEkWIYdTrhCvvqPRj4p
         8TKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RRWASIa+62gB90taCgH38XNmbnY0IGXkKz42ekdHkC8=;
        b=4MrBa0NVjxJsF3Z8GV9mOUbRLCYXAjBGoQ6xbd5UsVAaF4tbLdamujPTMJXlV3DBca
         0eO7KQbK7HargPP8LU0K1c0I9WuSpEZ1BsEEL1v2Uf9fQtBm43hv2L5yTWjXGb1EkUJK
         Ff9N3G0n+KfUe0rhZfL3pQEDturA0ybGZAGjezwJU7JSLh+pwXHhkKZ5ygfVNtLhsUBJ
         KtpdZUpsAPqRYcnmDqcdd1vKo3fGpLa3vX8W5YvPw0ktpWNeGQa44AfUqL/juoF44J/u
         /HT1Pl5FPzMvx9bkstV35A+5P3kDNmq4FR3rN6D/eAzQqXCG0OwGpvoBnLYjdhRDZDfC
         Yq5g==
X-Gm-Message-State: ANoB5pnjn3ofpmmbQljM8DGoz1H+bsbOd3Im7ZXrUSzDgLHr0N5eI61X
        gP0zscF1Cjwin0CTh4MY/xZ18Q==
X-Google-Smtp-Source: AA0mqf6mEH7Kh/a6DQm4wbe5vmd7x1r9nWU0U76qIRLS6eUZ+BwnpSMqDv+zISaqINx24x9As9eKsg==
X-Received: by 2002:a05:6512:b10:b0:4a4:68b7:f878 with SMTP id w16-20020a0565120b1000b004a468b7f878mr11949015lfu.28.1671036351559;
        Wed, 14 Dec 2022 08:45:51 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a26-20020a194f5a000000b004b4930d53b5sm868909lfk.134.2022.12.14.08.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 08:45:51 -0800 (PST)
Message-ID: <65ccd0c9-8bd9-fc3c-ef33-78b905adf294@linaro.org>
Date:   Wed, 14 Dec 2022 17:45:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] dt-bindings: arm: qcom: add board-id/msm-id for MSM8956,
 SDM636 and SM4250
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221214150605.173346-1-krzysztof.kozlowski@linaro.org>
 <20221214152915.wshz4odyqcupo6xw@SoMainline.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221214152915.wshz4odyqcupo6xw@SoMainline.org>
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

On 14/12/2022 16:29, Marijn Suijten wrote:
> On 2022-12-14 16:06:05, Krzysztof Kozlowski wrote:
>> Allow qcom,board-id and qcom,msm-id leagcy properties on these older
>> platforms: MSM8956, SDM636 and SM4250.  Also mention more OnePlus
>> devices using modified qcom,board-id field.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> 
>> ---
>>  Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index d45e2129fce3..cfb7f5caf606 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -925,15 +925,18 @@ allOf:
>>                - qcom,apq8026
>>                - qcom,apq8094
>>                - qcom,apq8096
>> +              - qcom,msm8956
> 
> I am certain this (and msm8976) were added in [1] but it somehow got
> lost when that was merged as 05c0c38dc752 ("dt-bindings: arm: qcom:
> Document msm8956 and msm8976 SoC and devices")?
> 
> Should we also add qcom,msm8976 or only when a user for that board is
> added?

Bjorn,
You need to fix your scripts. It's not the first time when applied patch
is changed and its pieces are gone.

This is patchwork:
https://patchwork.kernel.org/project/linux-arm-msm/patch/20221111120156.48040-9-angelogioacchino.delregno@collabora.com/

This is git:
https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?h=arm64-for-6.2&id=05c0c38dc752eb9244e53d72ce1030f36153daf8

Two different patches.


> 
>>                - qcom,msm8992
>>                - qcom,msm8994
>>                - qcom,msm8996
>>                - qcom,msm8998
>>                - qcom,sdm630
>>                - qcom,sdm632
>> +              - qcom,sdm636
>>                - qcom,sdm845
>>                - qcom,sdx55
>>                - qcom,sdx65
>> +              - qcom,sm4250
> 
> qcom,sm6115 could be added as well unless you rather leave that to the
> person(s) adding the board compatible later on.

There is no board, I think, so I did not add compatible.

Best regards,
Krzysztof

