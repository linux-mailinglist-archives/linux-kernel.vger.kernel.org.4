Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857DF718A10
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjEaTVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjEaTVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:21:05 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A130124
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:21:04 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-514924ca903so185684a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685560863; x=1688152863;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lz1nG2B3q0llv6deAIMIjSEMvsrQuQ3uKlNlDgfU5wU=;
        b=DvSDgeuRNVRc8TL9mrIG3iWEzc8MrZLyaNSP/JQxFELc38pYKUWja2yVsCJ/cLylkK
         vEC47lS9oNgkqcKMZs/FZgHJowNhBLhNvkHJ40isYf3g0WyhF+DUNnCLXo3+6gjHTa0w
         oLm8Xa69uEAyeRhU395izpWOeLSeQhhkgxOVsh0S9N4+kvu5SAyf2AnTBKzcm6uqw+D4
         7hHVZ8ysTESRDxZPDIX3Z25qomuOQBysCWfrJnNPkCwW5+sEI4ZGgiGoIeRfbiem7gZX
         qIaCtoUxYF/Gxd4zaa5YZV0QRImRI9Ki4dp12nSYjIIYDW2AtyYsZa+J+buibw/NRRXc
         mbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685560863; x=1688152863;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lz1nG2B3q0llv6deAIMIjSEMvsrQuQ3uKlNlDgfU5wU=;
        b=WVRGQ0Aqv/GgEOhApIpX4Rkdcs82oYUf+1+n/9lTJq0L2b/A1GiVcdRXHTtaeCL6Mx
         oZ4BREadglzIoJbmnAc64TNcw7ico7GYSDl1Xrm3oM0LmI4fpD0ULd64b2tXV4V8p/2B
         f7LIeUXKa8nLVSU7Jix+u44sRgr2p0Zan9bAXOKlDBA+qEgrMFfeNpGGVJ2YnxtYyyah
         UKwDJX6Rog87njcirvHkP8UvI+bN/y8Lsgw2uH6z8vw0sLppt5tVYZbRAKQW0HPzvaj+
         QdVyW695b8BkiSkPZ9ZI8mdgxAQIMYZmG4/7WAYzObCtU5ACqw888/WPXFPiJ473a/bO
         2XyA==
X-Gm-Message-State: AC+VfDy44GU0B3VlEy5qLt3ZfFXNANdALTI85VvH3/e4NBUrP2vV9LTv
        mFbt2fTufpPWHVMFydsNqYXS8tf7IevOM8cfLZs=
X-Google-Smtp-Source: ACHHUZ4d3/SnLt9Jvl5J0vVomD8iecQJLFMVGA7ToDhrEvJzS2tN8jTV37tKer0T748WigaTQU6f6A==
X-Received: by 2002:a17:907:26ca:b0:969:f433:9b54 with SMTP id bp10-20020a17090726ca00b00969f4339b54mr6317786ejc.39.1685560862913;
        Wed, 31 May 2023 12:21:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id s7-20020a170906c30700b0094f410225c7sm9397440ejz.169.2023.05.31.12.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 12:21:02 -0700 (PDT)
Message-ID: <0cb1d679-9e5b-8030-368e-69c3fc54511f@linaro.org>
Date:   Wed, 31 May 2023 21:20:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 1/6] dt-bindings: clock: qcom: Add SM8550 camera clock
 controller
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230525172142.9039-1-quic_jkona@quicinc.com>
 <20230525172142.9039-2-quic_jkona@quicinc.com>
 <546876ba-970d-5cd5-648e-723698ca74fd@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <546876ba-970d-5cd5-648e-723698ca74fd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2023 14:29, Bryan O'Donoghue wrote:
> On 25/05/2023 18:21, Jagadeesh Kona wrote:
>> Add device tree bindings for the camera clock controller on
>> Qualcomm SM8550 platform.
>>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> ---
>> Changes since V1:
>>   - Removed new YAML file and reused SM8450 CAMCC YAML file for SM8550
>>
>>   .../bindings/clock/qcom,sm8450-camcc.yaml     |   8 +-
>>   include/dt-bindings/clock/qcom,sm8550-camcc.h | 187 ++++++++++++++++++
>>   2 files changed, 193 insertions(+), 2 deletions(-)
>>   create mode 100644 include/dt-bindings/clock/qcom,sm8550-camcc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
>> index 87ae74166807..8dbc9004202f 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
>> @@ -13,11 +13,15 @@ description: |
>>     Qualcomm camera clock control module provides the clocks, resets and power
>>     domains on SM8450.
>>   
>> -  See also:: include/dt-bindings/clock/qcom,sm8450-camcc.h
>> +  See also::
>> +    include/dt-bindings/clock/qcom,sm8450-camcc.h
>> +    include/dt-bindings/clock/qcom,sm8550-camcc.h
>>   
>>   properties:
>>     compatible:
>> -    const: qcom,sm8450-camcc
>> +    enum:
>> +      - qcom,sm8450-camcc
>> +      - qcom,sm8550-camcc
> 
> Hmm,
> 
> So looking at Documentation/devicetree/bindings/clock/*camcc*.yaml we 
> seem to be repeating yaml over and over again with no substantial 
> difference between one description and another.
> 
> You've picked at the thread here by adding sm8550 into sm8450.
> 
> I think sm8250, sm8450, sm8550, sc7280 and ... probably sm6350 should 
> live in the one yaml description 
> Documentation/devicetree/bindings/clock/qcom,camcc.yaml
> 
> sm6350 looks a bit sparse/incomplete to me so perhaps leave that out. 
> The others sc7280, sm8250, sm8450 and sm8550 can/should all be moved 
> into the same yaml file with a list of compatibles.

Clocks are different. The ones with same clocks should be together, but
in other cases better to have separate schemas. It gets trickier to read
with multiple if:then:

Best regards,
Krzysztof

