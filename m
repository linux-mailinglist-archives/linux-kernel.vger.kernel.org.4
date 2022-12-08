Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0DD646C98
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiLHKTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiLHKTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:19:52 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C8355C88
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:19:50 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id s10so1072413ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 02:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=10WJDlf9oJXsY4jAF05O11SmuT12shB47OS13dhPV0c=;
        b=qS5P611nurHFZ/TBYo4/yeBcl5q6l+7yiF0ZlegH5T4L4oeEY17pIPgd9TLTN0s6m4
         mwbebyCWTxp3cNS2UG7HTSZ7B36+/B9tk0Vcd+YRL2zLoyKg6C7cBwKj1LK22WcBMEpx
         a6IMw3DJ28lN7S3CNTCKnYU6C+1aSRz2n56FhYUhwKFFTAhr08HPsd0EHWN0rWqcooRt
         AYj90BxBXoJiZoYAURSQx1ltzD5qbFK2z3w8BPpiAOTSbCZIz1gvR29ioerurtYX2HSH
         w6x62FEmjRNRK7/Kz5tHdiqnWmPvBiseH8h0noK0xvOVPEXyZyjcGrVua0OqjZEf/PHy
         pDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10WJDlf9oJXsY4jAF05O11SmuT12shB47OS13dhPV0c=;
        b=QLyZ9l+C7wdJsHFwdzwgZKzlaUJz0EgdpLzpVwHg1R8hiLNdYTteBIhHrb1MBm1tts
         hEui2kVzRVi2HVvUNabjBNzOVECn/fi4tOrsbMWoc5DSsp2Z5gWaDeML5Lp4hywkX7Nc
         F1KXg2lOK+0pEr9PW0SHEt3QY2uKeqzHEm37CGbhAli/0KoqOC9fKsdBNkwHAh3WTSzP
         0woA4zdYOF0pJcj8zYG6RbMwOKu12n6JaXwWQtTz/6etUolFdY2TEa2CVnVRSd6VNYsh
         bimi73vLZag8Aa5lb8wLIbao2ibksHBePzdIDit0QmPeuRx4Nh/i35qXWo/5EcPehTEO
         eL/g==
X-Gm-Message-State: ANoB5pmXIac4EeW87As81EbyANSwYv/dnHZ2XCjmHJii2WSWJdSIKRZ3
        j24a/dt3clp2hRFrAj27OrAciw==
X-Google-Smtp-Source: AA0mqf7cJzJyg77TLLMG4YOqskS1oKHjZCq05qLNoCRTZ/OG9J3ILZVaKronu52vVGrgOp88I8meCQ==
X-Received: by 2002:a2e:7818:0:b0:279:bf32:34dd with SMTP id t24-20020a2e7818000000b00279bf3234ddmr12181221ljc.31.1670494789232;
        Thu, 08 Dec 2022 02:19:49 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c14-20020a19e34e000000b004949a8df775sm278484lfk.33.2022.12.08.02.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 02:19:48 -0800 (PST)
Message-ID: <947e47d3-4235-8f16-d3ef-c3ddd7d51acf@linaro.org>
Date:   Thu, 8 Dec 2022 11:19:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] leds: qcom,pm8058-led: Convert to DT schema
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20221201131505.42292-1-krzysztof.kozlowski@linaro.org>
 <20221202000858.GA1737135-robh@kernel.org> <Y5Dzamz6XRZudQzq@duo.ucw.cz>
 <Y5G30ttrf1RJa+sM@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y5G30ttrf1RJa+sM@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2022 11:09, Lee Jones wrote:
> On Wed, 07 Dec 2022, Pavel Machek wrote:
> 
>> On Thu 2022-12-01 18:08:58, Rob Herring wrote:
>>> On Thu, Dec 01, 2022 at 02:15:05PM +0100, Krzysztof Kozlowski wrote:
>>>> Convert the Qualcomm PM8058 PMIC LED bindings to DT schema.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>  .../devicetree/bindings/leds/leds-pm8058.txt  | 67 -------------------
>>>>  .../bindings/leds/qcom,pm8058-led.yaml        | 57 ++++++++++++++++
>>>>  .../devicetree/bindings/mfd/qcom-pm8xxx.yaml  |  4 ++
>>>>  3 files changed, 61 insertions(+), 67 deletions(-)
>>>>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-pm8058.txt
>>>>  create mode 100644 Documentation/devicetree/bindings/leds/qcom,pm8058-led.yaml
>>>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>
>>> Or should I apply it?
>>
>> Thanks for ACK, let me take it, I guess.
> 
> Did you see Krzysztof's replies to this patch?
> 
> Sounded like he was going to re-work it, which is why I left it.

The only rework needed was to add "dt-bindings:" prefix in the subject.
If you could add it while applying/amending commit, that would be great
and spare me resend. Otherwise, let me know if you dropped this patch
and expect a resend.

Best regards,
Krzysztof

