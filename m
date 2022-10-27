Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8012D60FA0E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiJ0OEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbiJ0OEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:04:30 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF39E2BCA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:04:27 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id z30so921556qkz.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5utUQHOI85km1Rn7wRpir22VNDV9VAuObdujb/6by0M=;
        b=sDUPqP9my9QwpdQwr+sWEkNYGg5IWjGOcONCPu3iM447j8VKmE6r8LyCoX5Bd2hCXm
         cI2M2k0NSKxqP7p6EYdGB6/ON3VLlBpz3q8x8MDalZWcTCtAZIvmV7lChSEcw3BeHIkL
         zrozCxnzYVSsSsFuUJ/fVAw2FsDHqlKjS7gwyZUfEoSYcu7W4RJwRuFSUKSPa5UNkgi2
         zhDV95siPiVsfDEQsUL66+ZRHzyUDbPZIqhcWDXa8uVHd8yDbzVTpAv+T8lveHZ3lidm
         WiS7v9M9mBVcXfcMNtXiWr5qE2CI2vIv1/LxKSZpyf6gEH0gMZmWIazo1mWsqSiSuto1
         +5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5utUQHOI85km1Rn7wRpir22VNDV9VAuObdujb/6by0M=;
        b=c9fa+3gIu8osjJfGgJrOEzSrTXw/pua4Mzs43GtP1zDei7ZRYXIjrwgUPFGFv9CK4F
         ZLfjTj3T7a1aPhHkUBdML/NAPBwJk+tEoEKvTeE4ON6zLMIloYDrM9WsQYST/AmBCYZ4
         0WijSgGwpeD4sk8QfnAVRR6L5SQIPNqd4nGRjp24P3YHrZ//JXjA41g3iIPt3x0ZnunN
         sDFB2u8cjUh0TQOD27e+7xM4nR/1okh9oi7l6XRWbScvIB4BPtZWXZgnhnkRSHb1o4/J
         /3hF1SljVXdbtvOsaxNbCbd/QSaQD/Tq/iKuDICDSMiiS6K1+NvBJtNC206RQ3Y9h6pM
         4P1A==
X-Gm-Message-State: ACrzQf02a+gbz6NhCkLpYMgpbhuxyf2Fdr48aPhg0YMcLJkIK6rWirEy
        VMnBlhMrEvXkkoyGM6rKrEM2Jw==
X-Google-Smtp-Source: AMsMyM7E5w/+2hWEjgBBQvYEPeAOWuATrmH7GRdK/ODiD8K5kYfMmltQ6htzfohEAm//cY2NCXQ5+w==
X-Received: by 2002:a37:9544:0:b0:6f8:7c2b:4a1f with SMTP id x65-20020a379544000000b006f87c2b4a1fmr8279441qkd.563.1666879466284;
        Thu, 27 Oct 2022 07:04:26 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a444a00b006f9e103260dsm1026647qkp.91.2022.10.27.07.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 07:04:25 -0700 (PDT)
Message-ID: <1f1ecb2c-16d8-4530-9deb-7ef8861a128d@linaro.org>
Date:   Thu, 27 Oct 2022 10:04:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 08/11] arm64: dts: qcom: sc8280xp-x13s: Add PMK8280 VADC
 channels
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221027063006.9056-1-manivannan.sadhasivam@linaro.org>
 <20221027063006.9056-9-manivannan.sadhasivam@linaro.org>
 <0d4af50e-558a-e9cd-1d6f-54c77e0deb86@linaro.org>
In-Reply-To: <0d4af50e-558a-e9cd-1d6f-54c77e0deb86@linaro.org>
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

On 27/10/2022 10:03, Krzysztof Kozlowski wrote:
> On 27/10/2022 02:30, Manivannan Sadhasivam wrote:
>> Add VADC channels for measuring the on-chip die temperature and external
>> crystal osciallator temperature of PMK8280.
>>
>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> ---
>>  .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>> index 6aa8cf6d9776..9ac5d5c22832 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>> @@ -7,6 +7,7 @@
>>  /dts-v1/;
>>  
>>  #include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
>>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>  
>>  #include "sc8280xp.dtsi"
>> @@ -173,6 +174,23 @@ &pmk8280_pon_resin {
>>  	status = "okay";
>>  };
>>  
>> +&pmk8280_vadc {
>> +	status = "okay";
>> +
>> +	pmk8280-die-temp@3 {
> 
> die-temp@

Hm, wait, unless this is the die temperature of pmk8280? But then how
about pmic-die-temp?


Best regards,
Krzysztof

