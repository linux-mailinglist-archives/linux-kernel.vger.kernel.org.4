Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B61A688B13
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjBBXqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbjBBXqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:46:12 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF9480157
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:45:53 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id mc11so10736681ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 15:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p7JE+gPpsu3PeppuOjAm6wJ3zvzLvO/TFsK3LVPhrwA=;
        b=Xrio21vv2fzSQE/6eyDRHI1+Ed++kclLsWHvKOGzma7sEdgflNvU2xu5Hl4ZGVxdUS
         8kO/wTtNe9aQWPGBfBgjd3/PYjUXs5ApuY7hqVUkNfezx1WVN1+x264q5oiEoTAp6bQn
         EAoRtSTc13baM9xzQvQW0RAa9mIuN2+1bQSWjY7n5Xk9/u/M+kEYs1kRXep0506B/tAJ
         AQNL+Ebqc6in7CAfYBw2SFLt3idCCtSA29/Iv6METHFRy98X/LqhGopMXqJMj4Pnv145
         fmC1XHV2S16Wxe1IVHYiofH4lYbK6YQtzYM+tvFyABcSZd63pzwpUgdA5uLdhfi4VruC
         a7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p7JE+gPpsu3PeppuOjAm6wJ3zvzLvO/TFsK3LVPhrwA=;
        b=3vOT4J0H8fLsVbgMXF1S+VT96naxXSk0InXvNwFwTjvfcbuHvm9fSK7vUCbLbKPjVF
         ltpOhWV0sl3M8F4qrBoHRkj5Ryft0GFFleLP3squYqWYW0dWqiHl83/aVxoX785hB/MV
         nZ4KHkdY4/nYIKsIe8FpwluXQL4/b3znRTwD5tErtcpmwfZLvUU3z4gn46+glmSPlHKE
         yiUGAjZWJw3Maqs/44qRpTMrIFRUJdn0rVkigvaWxIeD/DP/Klod5lQjtQ8Yozo35SHN
         ZuKBnwFH6ZnBwi4yuH1WsDMwnpWQGZc3vBhRZOHGbFoWIDh0WbDZgIAND8c36cdi3ZhX
         eaJQ==
X-Gm-Message-State: AO0yUKVzmsDR0e/7YYKS4lx+RakujNKdIHbyLNRfBNk5XZPMefmBovPs
        03aBDumQGKcLE/xlfQtX7KkulA==
X-Google-Smtp-Source: AK7set+5GSXpbEFfipGFy7AaGe8F4GDTTdDTG8KviZBbg8YpaDmooz4Af3KugzKkldwBxXx/k9hAZw==
X-Received: by 2002:a17:906:cf83:b0:887:6c23:193f with SMTP id um3-20020a170906cf8300b008876c23193fmr7869480ejb.44.1675381551564;
        Thu, 02 Feb 2023 15:45:51 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id t13-20020a170906268d00b00888fddc4eb2sm464379ejc.164.2023.02.02.15.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 15:45:51 -0800 (PST)
Message-ID: <25f5a750-b51c-7d7b-0d50-5b2f78de8512@linaro.org>
Date:   Fri, 3 Feb 2023 00:45:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [RFT PATCH 05/14] arm64: dts: qcom: sc8280xp: correct TLMM
 gpio-ranges
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230201155105.282708-1-krzysztof.kozlowski@linaro.org>
 <20230201155105.282708-6-krzysztof.kozlowski@linaro.org>
 <Y9xAEoc0QXe222D0@x1>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <Y9xAEoc0QXe222D0@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.02.2023 23:58, Brian Masney wrote:
> On Wed, Feb 01, 2023 at 04:50:56PM +0100, Krzysztof Kozlowski wrote:
>> Correct the number of GPIOs in TLMM pin controller.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> index fa2d0d7d1367..17e8c26a9ae6 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> @@ -3533,7 +3533,7 @@ tlmm: pinctrl@f100000 {
>>  			#gpio-cells = <2>;
>>  			interrupt-controller;
>>  			#interrupt-cells = <2>;
>> -			gpio-ranges = <&tlmm 0 0 230>;
>> +			gpio-ranges = <&tlmm 0 0 228>;
Won't that kill the UFS pins?


>>  		};
> 
> I verified that this count matches what's in downstream.
> 
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> 
> 
> However, I noticed in upstream that we're using this reg property:
> 
>    reg = <0 0x0f100000 0 0x300000>;
> 
> Downstream has a different base address and a wider size. Note: I added
> spaces for easy comparison.
> 
>    reg = <  0x0F000000   0x1000000>;
> 
> I don't have access to the appropriate documents to see which is
> correct. I assume the base address in upstream is at least correct since
> pinctrl is working on this platform.
Downstream offsets things in the driver

https://git.codelinaro.org/clo/la/kernel/msm-5.4/-/blob/LV.AU.1.2.3.r1-03600-gen3meta.0/drivers/pinctrl/qcom/pinctrl-direwolf.c#L20

Notice how UFS/QDSD pins addresses differ by 0x1000... up- and downstream too.
I'd imagine Bjorn/Johan/whoever did that used magic PDFs instead of not-very-
tested downstream sources.

Another note, the downstream driver may be incomplete/wrong, as Linux was
not exactly the main usecase of 8280xp so the testing there was most likely
only basic.

Konrad
> 
> Brian
> 
