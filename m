Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCAD68BB3B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjBFLUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjBFLU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:20:26 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70DECC07
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:20:24 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id m8so11249950edd.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 03:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uhqMPSXHkvCWfILufq4Ld5aNdSejDT2hVXfv3Ko2CUk=;
        b=raPqjNh3bznGcgDJNpjJBoLmU9KWkSOkMrFpN7R1Hgnir1F0Uqs123HqifgHra8qQi
         EAMz90ugLBZPLTZ3LmsJD1AT4+N6KRqgbdAoxb+oL860KL+oHsW60dI90Tspq5hhBVcF
         jgbIJ9LO4oabGBLUewmdyw5AxF+uY634xAsdogI/47oL2guzk4+kGzQePDmJjZCUf1s9
         qnJjRHiFVMR4FmFqXG5KiLfYDhJZh11oQngLr6eoKjqSnPaCR9T3/yYJHws6sqOpQEQT
         MniwC2wyCE+o/0l/HWIJPV4rpLL6rSBr/KPhIiqwuL3M6dZZFy0Y6SV7egdvEjH4vrPL
         Suaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uhqMPSXHkvCWfILufq4Ld5aNdSejDT2hVXfv3Ko2CUk=;
        b=V9/7ERFDYUe4DG/JOjlAmL3bE+gxE+h0Ci2st1scBYXsBXtH/40X6ebR/98BFbT8eb
         OalKyd8fnjD/631IdqymxEpwIkV5+slFRecmu2E68YYSZgEPAVU8rjMvsa1eYdFKksVD
         M8hZ1AqlvZYx5HPbd9kzSfOfRgPBeF5iuVagjEBlzcHtS/g/0InWgxoTCFhCVeyabnN/
         TvKTOGqq974lahBhRFzoJXTM/b6eqdF6SFebsnxk0v0jZJxN4jjEuffffXa3Hps8uRcz
         WzlS7Refsz7VRvwwYHpPtJfuthzcrJojKJopADfE1AvQc4aXo5b809w+EURUItVNC9rN
         2zxQ==
X-Gm-Message-State: AO0yUKXeEKkqUPfYiq/1kFHTxONylwgj5qprVbx2r6Oeo37L3rdJqFyY
        tLbx8BBu6IbblhduzemgKORIKg==
X-Google-Smtp-Source: AK7set/hlkKx+T8IiESp6Csj2ct0GVBLugzKhydhbyw/fPZb4IlnO73KtOwKu/XBQbnVKeR1sPtxPw==
X-Received: by 2002:a05:6402:3603:b0:4a0:e237:2cef with SMTP id el3-20020a056402360300b004a0e2372cefmr20831204edb.4.1675682423357;
        Mon, 06 Feb 2023 03:20:23 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id v17-20020aa7dbd1000000b004a249a97d84sm4903348edt.23.2023.02.06.03.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 03:20:23 -0800 (PST)
Message-ID: <a2ad7b78-d848-df9d-2646-476cb306c505@linaro.org>
Date:   Mon, 6 Feb 2023 13:20:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/5] dt-bindings: display: msm: dp-controller: document
 SM8450 compatible
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230206-topic-sm8450-upstream-dp-controller-v1-0-f1345872ed19@linaro.org>
 <20230206-topic-sm8450-upstream-dp-controller-v1-1-f1345872ed19@linaro.org>
 <f1665a8f-5b5b-7d98-a94e-d1b1df04afdf@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <f1665a8f-5b5b-7d98-a94e-d1b1df04afdf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 12:33, Krzysztof Kozlowski wrote:
> On 06/02/2023 11:17, Neil Armstrong wrote:
>> The SM8450 & SM350 shares the same DT TX IP version, use the
>> SM8350 compatible as fallback for SM8450.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> index 0e8d8df686dc..98bae326e655 100644
>> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> @@ -25,6 +25,10 @@ properties:
>>         - qcom,sc8280xp-edp
>>         - qcom,sdm845-dp
>>         - qcom,sm8350-dp
>> +      - items:
>> +          - enum:
>> +            - qcom,sm8450-dp
> 
> Indentation looks wrong here. Testing should fail, did you test it?

Moreover it also breaks dt-schema, see 
https://github.com/devicetree-org/dt-schema/issues/98

> 
> Best regards,
> Krzysztof
> 

-- 
With best wishes
Dmitry

