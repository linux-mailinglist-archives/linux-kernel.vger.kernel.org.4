Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9708B72DADC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239808AbjFMH3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237689AbjFMH3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:29:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D9410DA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:29:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30fcde6a73cso111235f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686641379; x=1689233379;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SWcv2KbrVkYfhLRQFgFKlaFWH34hYYx6W1r/9LcWNfU=;
        b=QmKKD4LMjD9i+Quf/rolLMOd4eqr0DS/nQA2gx5UzbHAwy89+M7DsAeiYF0aB8nPWq
         Rz2TpEEEyooJBlrmYwbifewPMFmSXCo1O/czW4AYUG3V3OzM2ZA7Io2ACgcsdVRk2hhW
         jWK7bV5zeLMRIazLGvBouWMWMfeFilvhdE0gps+G6UzAGlk7PqR+Sv68stYcDXwbIjJS
         BMGnVuYB+TJTj8inkXdSpxLbVJCN5Cg59hKLUQKgLBY8Fe1Dco9OLTB31a+vAoyPWGMh
         8eFoOWK6HXaCc8F7JxR5xkTbVeUMfSrG6pp4JlEUOW7yXfEPtkqHamfCWJ7YfU3ME5RN
         LlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686641379; x=1689233379;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWcv2KbrVkYfhLRQFgFKlaFWH34hYYx6W1r/9LcWNfU=;
        b=fsG94+/ptsGcnsqXYtebPbwLBn1cLZc2BW44SGPlD5qjkLiIzvAwfQqhDAMoP9Pwgk
         SPZO6+G/8usLLYCd809sBbmbbmTLpuMb+HcogOeKb86t0X0T9sHcmSbwbcOttpUYqXRk
         EzjihSJt+9nz04Q9iLI27L5dAcGqmr98mnKHaGzVWW8pOit/Zj7+oYvToOcsWFHBK/yM
         KqDu4kUpV7yzQbqxmdDnFu0tOlyKOpSpkBQ58ijUZEukFUGV9FrOfyFz4vERFqi54KoA
         UZ/v2hrQsfo9iDAhpVKZEl6pKU/Wf4FXsbOb2sRUYn4tq6wjnfoWO2b+ceVipUKZYVx/
         0oKQ==
X-Gm-Message-State: AC+VfDx5xJLyW6BcZZtWP8CBw6SWe+bnZZhe0l61F+NPGz0hZbvsVeTR
        G62TRQet2h6/tZMn150ARNVM/g==
X-Google-Smtp-Source: ACHHUZ4llERySH8FvtsxtkPBf3YLvy/r2xMKHTUzrkPF382Oj3Rb5ZncCciA46/buotoosZubkrCGg==
X-Received: by 2002:adf:e3c5:0:b0:30f:bbd6:1efe with SMTP id k5-20020adfe3c5000000b0030fbbd61efemr4099802wrm.57.1686641379388;
        Tue, 13 Jun 2023 00:29:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:48b:b939:c60e:e1ba? ([2a01:e0a:982:cbb0:48b:b939:c60e:e1ba])
        by smtp.gmail.com with ESMTPSA id h14-20020adff4ce000000b0030c40e2cf42sm14367826wrp.116.2023.06.13.00.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 00:29:38 -0700 (PDT)
Message-ID: <1b3e86a7-352c-de2f-aaa0-51fe878b8462@linaro.org>
Date:   Tue, 13 Jun 2023 09:29:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: sm8550: fix low_svs RPMhPD
 labels
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230601-topic-sm8550-upstream-dp-v3-0-5f9ffdcb8369@linaro.org>
 <20230601-topic-sm8550-upstream-dp-v3-1-5f9ffdcb8369@linaro.org>
 <ce7c4402-b58e-b5df-c864-9f1a959132d0@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <ce7c4402-b58e-b5df-c864-9f1a959132d0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 12/06/2023 18:50, Konrad Dybcio wrote:
> 
> 
> On 12.06.2023 17:26, Neil Armstrong wrote:
>> "low" was written "lov", fix this.
>>
>> Fixes: 99d33ee61cb0 ("arm64: dts: qcom: sm8550: Add missing RPMhPD OPP levels")
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> https://lore.kernel.org/linux-arm-msm/1d3c05f5-c1bd-6844-1788-8df0b863a02e@linaro.org/
> 
> somebody forgot to run `b4 trailers -u` :P

Damn, resending a v4 now :-)

Thanks,
Neil

> 
> Konrad
>>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> index 75cd374943eb..972df1ef86ee 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> @@ -3649,15 +3649,15 @@ rpmhpd_opp_min_svs: opp-48 {
>>   						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
>>   					};
>>   
>> -					rpmhpd_opp_lov_svs_d2: opp-52 {
>> +					rpmhpd_opp_low_svs_d2: opp-52 {
>>   						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
>>   					};
>>   
>> -					rpmhpd_opp_lov_svs_d1: opp-56 {
>> +					rpmhpd_opp_low_svs_d1: opp-56 {
>>   						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
>>   					};
>>   
>> -					rpmhpd_opp_lov_svs_d0: opp-60 {
>> +					rpmhpd_opp_low_svs_d0: opp-60 {
>>   						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
>>   					};
>>   
>>

