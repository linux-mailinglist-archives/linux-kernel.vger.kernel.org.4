Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D90E6A83BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 14:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCBNpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 08:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCBNpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 08:45:44 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252B3303C2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 05:45:42 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q16so16602706wrw.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 05:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677764740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BM0l+s6uNh8ujrLQdhKpUj2tUsRahju9wGyQPOkFRZI=;
        b=vQFlXb9PnW0B3GLtWxKLmK2Mw8JhqWFzmcTl4tRRMZPGiYIm9uwH8B02EVAggbrSJL
         tyJGAWX6qqZPeQ0FoMcmZKBTUeqk57ZYMO/JTOvohT5jUYU3/TUp7SiuikpjvWnomPC9
         GkQJ/s9toj6c1y08uGuglU8cLvDOrQdN8dht874IclIXUYfmhFtZ9VF/EQAbYl/NhueC
         h7r+bkAEpLSI4/DXghQRrQIDO9F8HEw9EaEtl1M0FesXFa94DDHpQzRmCpZFSBmYpIJX
         L1OYT92BzxSoHt7VJfuZkOxqwfAlBkhpPrCgwmTGpkkgJMYjPi8JSPft3AAUpdB4Qpxz
         OsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677764740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BM0l+s6uNh8ujrLQdhKpUj2tUsRahju9wGyQPOkFRZI=;
        b=QIh5yTk136UEGnkhsZuGT3nqSWC9RbrJM7pNwpM76X50oscCV78tPnNYCBiumz5E5L
         1S6rPCcJB2osL4FljY133FtwuRENLWNQACfX892VbQZYID4nUcPJxfCYjuTmHIDeo9Ji
         fYXX+nmGvZsvPLcIn+iAy4TlOurHiVFJSolSB80esb3eHOFIAMhRCMyPFVKdTCuC2Dc/
         RWGm4xZeZXjq+Oen0jzAa/XYCaBilPJvq0WH7fB9eSQOAdIPLhcXvMe5DElaD9x1WIS8
         k2/v1eBcDnf4X2LfiCCbdK5ZFsob0B2/wUPmZ9WhJwt7LYEQ0OjBc8ZNfZMy3EXm91JC
         j+3g==
X-Gm-Message-State: AO0yUKXSIg061LvBzUMZA8QxvxJ9y0b+jz/+h7ziA1En02YIUv7TjVMx
        BFFf0LeULhtvMAqcU34gQpPG9Q==
X-Google-Smtp-Source: AK7set/yUdNjILl9drkxcU+bma3yQLvF2CUOptYScpVcH+/Cx82pqRwSs92ECrWo4dFsqQALifXFcg==
X-Received: by 2002:a5d:4842:0:b0:2c7:1c4e:1d11 with SMTP id n2-20020a5d4842000000b002c71c4e1d11mr7018864wrs.63.1677764740646;
        Thu, 02 Mar 2023 05:45:40 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id n16-20020a5d4850000000b002c6e8cb612fsm15003619wrs.92.2023.03.02.05.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 05:45:39 -0800 (PST)
Message-ID: <812aa961-05a6-5ad5-7389-74a71a9c7e7d@linaro.org>
Date:   Thu, 2 Mar 2023 13:45:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sc8280xp-x13s: fix va dmic dai
 links and routing
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230302115741.7726-1-srinivas.kandagatla@linaro.org>
 <20230302115741.7726-5-srinivas.kandagatla@linaro.org>
 <f39890de-54a9-297b-68ee-41dedd7bdf27@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <f39890de-54a9-297b-68ee-41dedd7bdf27@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/03/2023 12:28, Konrad Dybcio wrote:
> 
> 
> On 2.03.2023 12:57, Srinivas Kandagatla wrote:
>> VA dmics 0, 1, 2 micbias on X13s are connected to WCD MICBIAS1, WCD MICBIAS1
>> and WCD MICBIAS3 respectively. Reflect this in dt to get dmics working.
> I'm far from good when it comes to sound, but is it expected that
> (VA DMICn) are are connected to both (MIC BIASn) and (VA MIC BIAS{1, 1, 3})?
> 
one DMIC data lane can be used to connect to two DMICs, for L and R 
data. So the MIC Bias line too, so for DMIC0, and DMIC1 which is 
connected to MICBIAS1 and DMIC2 is connected to BIAS3. Why its bias3 
line instead of bias2 is totally board dependent and how the wiring is done.

>> Also fix dmics to go via VA Macro instead of TX macro to fix device switching.
>>
>> Fixes: 8c1ea87e80b4 ("arm64: dts: qcom: sc8280xp-x13s: Add soundcard support")
> If that doesn't depend on any driver changes, please Cc stable
> so that distros will pick this up.
These patches are about to appear in rc1.. so I don't see any help 
adding stable.

--srini
> 
> Konrad
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>> index d18d405d1776..89230112e288 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>> @@ -933,9 +933,9 @@
>>   		"VA DMIC0", "MIC BIAS1",
>>   		"VA DMIC1", "MIC BIAS1",
>>   		"VA DMIC2", "MIC BIAS3",
>> -		"TX DMIC0", "MIC BIAS1",
>> -		"TX DMIC1", "MIC BIAS2",
>> -		"TX DMIC2", "MIC BIAS3",
>> +		"VA DMIC0", "VA MIC BIAS1",
>> +		"VA DMIC1", "VA MIC BIAS1",
>> +		"VA DMIC2", "VA MIC BIAS3",
>>   		"TX SWR_ADC1", "ADC2_OUTPUT";
>>   
>>   	wcd-playback-dai-link {
>> @@ -986,7 +986,7 @@
>>   	va-dai-link {
>>   		link-name = "VA Capture";
>>   		cpu {
>> -			sound-dai = <&q6apmbedai TX_CODEC_DMA_TX_3>;
>> +			sound-dai = <&q6apmbedai VA_CODEC_DMA_TX_0>;
>>   		};
>>   
>>   		platform {
