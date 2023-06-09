Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D497294E3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241527AbjFIJYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjFIJXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:23:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B9349F6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:18:04 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f6370ddd27so1877222e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 02:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686302230; x=1688894230;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cdOMZOFFK46XMQWHJQR/JNKfoVWF5Xuwowhgn1zGCvg=;
        b=Mm8gNGYpStPF+iQ4QjxKSa39Z4C7KdUmTYszNraI0kz4arWFCaIRAnq3VhMvXAQ/0D
         PHhpTweQN70rwWxlAzsyhhnrIKryeGmB0ndZi7/9me0OYJO4oM3SdCMrSuiDNIQ7iUJs
         Gr3iDmjY03z8cErtzS8upas+avQS2iyGcw5iOP4FfbnICHGwCBIrFy6pE5vR+V5LYKtL
         06mOqO4O56AA5UklVoDStlMbxqVsTBmIPRyD155Lyj8m0DLTya3JadOnuYbMKQfh3rI/
         w4qRF1xkFRVa8olthy96IVSyUB1mDa+fTsnd7CEQZEHrWOqia4i8lIiTekY0mFEsuZxC
         Psmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686302230; x=1688894230;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cdOMZOFFK46XMQWHJQR/JNKfoVWF5Xuwowhgn1zGCvg=;
        b=J9FpAPv7R7ecIji0gXrfRDB9f9BpRHk/97M3YgHLVLOZJtLGunx+Ss3CcYrOS7Laev
         yaJTAdtE8etzcqOoJt4zyWJ21n6UfPaot9kIGa+VDxIGIWO77RZLdaMo33GH7/8aSf7H
         eJLFHlqMpih8oofIAFcYZHqBaTqB4tEUL7QDGjh1Wrfrz5sn2fAa3kYE0FhTTVRsfG3V
         7ZNwAkCuVBRC6uJM8V1hdS5i5WdlDzsoXLI5DjWlidC2MMST6ertOdH0YU4C/w/0ZfLP
         Jbb7UaeWtwsRBvug/1Jw+njM26YdaBhDogPOmf1UGEWWwyybpmxQbsexQ6Kh42wi78s6
         Tukw==
X-Gm-Message-State: AC+VfDxVAyfOkoC6llk0Qq1gfhvd92wzbCBkYF3VsyJ03fQE6STOProG
        gK4bQkY+KdE/fdVxWhBTnXBzWg==
X-Google-Smtp-Source: ACHHUZ5z73R2zFNnCer+RMV1zZqn9H/fLIsIv+bZQWOcA7XTkZ3bXhfJq9Jda7zGqPuFoVUM9SDfNQ==
X-Received: by 2002:a05:6512:521:b0:4f3:bbe1:34fc with SMTP id o1-20020a056512052100b004f3bbe134fcmr565962lfc.38.1686302230232;
        Fri, 09 Jun 2023 02:17:10 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id j8-20020ac25508000000b004eb44c2ab6bsm477216lfk.294.2023.06.09.02.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 02:17:09 -0700 (PDT)
Message-ID: <f44293c7-fce9-e7a3-2a02-7ad5f7980e81@linaro.org>
Date:   Fri, 9 Jun 2023 11:17:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 4/5] dt-bindings: cpufreq: cpufreq-qcom-hw: Add SDX75
 compatible
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, tglx@linutronix.de,
        maz@kernel.org, mani@kernel.org, robimarko@gmail.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <1686138469-1464-1-git-send-email-quic_rohiagar@quicinc.com>
 <1686138469-1464-5-git-send-email-quic_rohiagar@quicinc.com>
 <20230609050052.GA472607@hu-pkondeti-hyd.qualcomm.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230609050052.GA472607@hu-pkondeti-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.06.2023 07:00, Pavan Kondeti wrote:
> On Wed, Jun 07, 2023 at 05:17:48PM +0530, Rohit Agarwal wrote:
>> Add compatible for EPSS CPUFREQ-HW on SDX75.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
>> index a6b3bb8..866ed2d 100644
>> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
>> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
>> @@ -36,6 +36,7 @@ properties:
>>                - qcom,sa8775p-cpufreq-epss
>>                - qcom,sc7280-cpufreq-epss
>>                - qcom,sc8280xp-cpufreq-epss
>> +              - qcom,sdx75-cpufreq-epss
>>                - qcom,sm6375-cpufreq-epss
>>                - qcom,sm8250-cpufreq-epss
>>                - qcom,sm8350-cpufreq-epss
> 
> This is a very basic question, not completely related to this patch.
> Apologies in advance.
> 
> What is the rationale for adding a new soc string under compatible and
> using it in the new soc device tree? Is it meant for documentation purpose?
> i.e one know what all SoCs / boards supported by this device node.
It's two-fold:

1. The device tree describes the hardware, and for lack of better terms (e.g.
   an SoC-specific version number of the block that is identical to all other
   implementations of that revision on all SoCs that use it), we tend to
   associate it with the SoC it's been (first) found on.

2. In case we ever needed to introduce a SoC-specific quirk, we can just add
   an of_is_compatible-sorta check to the driver and not have to update the
   device trees. This is very important for keeping backwards compatibility,
   as it's assumed that not everybody may be running the latest one. This
   means we have to avoid ABI breaks (unless we have *very* good reasons, like
   "this would have never worked anyway" or "it was not described properly
   and worked on this occasion by pure luck")

Konrad
> 
> I ask this because, we don't add these compatible strings in the driver
> [1] which means there is not SoC specific handling and there is no
> module load assist (module alias matching by user space based on device
> presence).
> 
> Thanks,
> Pavan
