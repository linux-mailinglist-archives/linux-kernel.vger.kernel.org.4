Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7482364C4BD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbiLNIMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237460AbiLNILh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:11:37 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606231EAEE
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:09:10 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b3so9173529lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OpxduO24RNKiHe7qgJOcOcCob/2sJ/YLTZskR12FTNA=;
        b=BeVHY8eEoIKiIZpXg/sfmOQ4jlKDpPHhWyAhDMWNpXLZ4442OJXmgb6yfpAPrH/drL
         8dEtmBRLQ8VXtcNHcMarxqm7r+Cx01k+E+VRi3+9QgAVNO7DZIdKe90IQ6fmnLdxAWZS
         E9GIcv+tPgYLuoELD6C2awAYDxglz1nTg7ycrLqxfEQVV3Ufk1OJbSERfQn8o4kLuKLL
         GXVxRkrwx0akTCUZ4tIMx5yuRubk4T2aek4YXHywxdJpFmkqUvLmwbua5R75ii20vvfy
         gajh/9wzRxyKoKYiO8rjb7oT0RPxC97aZvjH8YPJ8xGTKLuLvBv2ESqOOJpUm2ZHDNFU
         YoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OpxduO24RNKiHe7qgJOcOcCob/2sJ/YLTZskR12FTNA=;
        b=LqGrzRBKcgNJVNOqaQ9bJPVhseCkNeeZd/vVe81MGyXT5akwrovFHyopu1lrl/QYY0
         ciRYZ92ahWfwAjv2dufU8jB9S3tu/FcPnx9FHcE52cjrcOu0eNBxZ5FN0GP8XrdB3g2K
         hSwMUTgtPgaGx6DgibX0noDD559bWx63ABr1bVW2J08AEsxCCLHoi885TGAbYGDSB9O9
         ImVvQPR6p3RFVQhLNOOFmAXbJNgFGgZNHWPrq8ZQtbd+98hH/tQauyfCpWPLofmQjY4y
         ENyLX9Eio0jh04flYRHNRY42CZkdeJRJ5rSuohImYyjTpumnEdyGpnUKIqRXXPBj4GJR
         lQxg==
X-Gm-Message-State: ANoB5pnhCsUkFCqt2qS2C3q4oMhSoXNQc+2clZVauyucfQ8ud7WCvv4L
        N+VSPLVbfgDNjicxYHXKMKOmOg==
X-Google-Smtp-Source: AA0mqf5ORcU2VhODrzF1Mr8QjolUDvL4SNlSAy9EI75Xqlqtp44H45VTH4pKT45haDrIPNCNoEki6A==
X-Received: by 2002:a05:6512:1329:b0:4b5:853c:ed30 with SMTP id x41-20020a056512132900b004b5853ced30mr9575872lfu.23.1671005348688;
        Wed, 14 Dec 2022 00:09:08 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id n13-20020a056512310d00b004b59c9b7fb4sm707250lfb.126.2022.12.14.00.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 00:09:08 -0800 (PST)
Message-ID: <c4ef3f7f-5b1d-5a11-f869-d1c61dd2c26e@linaro.org>
Date:   Wed, 14 Dec 2022 09:09:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/4] arm64: dts: qcom: Introduce a carveout for modem
 metadata
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        manivannan.sadhasivam@linaro.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, amit.pundir@linaro.org,
        regressions@leemhuis.info, sumit.semwal@linaro.org,
        will@kernel.org, catalin.marinas@arm.com, robin.murphy@arm.com
References: <20221213140724.8612-1-quic_sibis@quicinc.com>
 <20221213140724.8612-2-quic_sibis@quicinc.com>
 <7ea03855-4806-f4ca-e0c3-4044e1095d6b@linaro.org>
 <96c1e60d-de12-5e60-4c06-70ea4b9c49f8@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <96c1e60d-de12-5e60-4c06-70ea4b9c49f8@quicinc.com>
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

On 14/12/2022 07:49, Sibi Sankar wrote:
> Hey Krzysztof,
> 
> Thanks for taking time to review the series.
> 
> On 12/14/22 01:10, Krzysztof Kozlowski wrote:
>> On 13/12/2022 15:07, Sibi Sankar wrote:
>>> Introduce a new carveout for modem metadata. This will serve as a
>>> replacement for the memory region used by MSA to authenticate modem
>>> ELF headers.
>>>
>>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>>   
>>>   	aliases {
>>> @@ -865,7 +870,7 @@ hp_i2c: &i2c9 {
>>>   	clock-names = "iface", "bus", "nav", "snoc_axi", "mnoc_axi", "xo";
>>>   
>>>   	iommus = <&apps_smmu 0x461 0x0>, <&apps_smmu 0x444 0x3>;
>>> -	memory-region = <&mba_mem &mpss_mem>;
>>> +	memory-region = <&mba_mem>, <&mpss_mem>, <&mdata_mem>;
>>>   
>>>   	/* This gets overridden for SKUs with LTE support. */
>>>   	firmware-name = "qcom/sc7180-trogdor/modem-nolte/mba.mbn",
>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
>>> index bf522a64b172..bda0495aa0b5 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
>>> @@ -17,6 +17,11 @@
>>>   			reg = <0x0 0x9c700000 0x0 0x200000>;
>>>   			no-map;
>>>   		};
>>> +
>>> +		mdata_mem: memory@9d100000 {
>>> +			reg = <0x0 0x9d100000 0x0 0x4000>;
>>> +			no-map;
>>> +		};
>>>   	};
>>>   };
>>>   
>>> @@ -32,7 +37,7 @@
>>>   
>>>   	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
>>>   	interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
>>> -	memory-region = <&mba_mem>, <&mpss_mem>;
>>> +	memory-region = <&mba_mem>, <&mpss_mem>, <&mdata_mem>;
>>
>> Only two memory regions are allowed by bindings... unless you fix it in
>> further patchset. If so, please re-order to have the bindings first. It
>> helps reviewers not to have such questions. :)
> 
> I felt that Rob's dt_bindings check bot might report an error
> if the dt changes weren't placed before the bindings changes.
> But since you asked for the logical order I guess the bindings
> check are done only after the entire series is applied. I'll
> change the order in the next re-spin.

AFAIR, Rob's bot ignores DTS patches anyway.

Best regards,
Krzysztof

