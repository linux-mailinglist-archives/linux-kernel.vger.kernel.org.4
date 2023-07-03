Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DAB746077
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjGCQKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjGCQKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:10:03 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076D2185
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 09:10:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51da8a744c4so5174428a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688400600; x=1690992600;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LjungVd0/xOT2xWI77bKySokcNnytRYgG5Uu2ldusX4=;
        b=DaRfPwmGCcCDWkMyZd/KzmzPJ3OwupWE4lG+U1qybpBT44GBgLEtjRv2xg8vK/u5uE
         FbXx2x4uQReVARA8YKrHMgHoCPthpHNfO+VSvBMjJbb2B9V8nZK8jsUFX75/g4eW1KJ2
         lra5ltykUJmKSyVy64Mg3x82exWymYwR2Xjpc7aozpmDgqq+DgG2jYKapWn64dO9ph2s
         9y+nT6vnsKL9P+G0qTq5x8TsNnH1fb8EMXINgasUvgmepm6J+m1syK+m1dUs9O0iNhu5
         l8RJJSZQCtGosV+TpPKn7Vp5PoSK89gbXfVfxOr6tYPlpiMwLfoa8JEemFVzE1QkROBq
         tz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688400600; x=1690992600;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjungVd0/xOT2xWI77bKySokcNnytRYgG5Uu2ldusX4=;
        b=fA9cfJHzxf79sXpKC0EsifBR/uL7ShjrASF8zpz2yHQFh+7C9T/r5KDyq2+o4VcQOe
         Q1YcPUGIo7Sz2iYR5B3vDSEVbxHQXhG1IzoD6s+9aysbQ9Vdag0867P997jw7dbmszUv
         HurHyHyuPbXQFYLlWkcRBC2PyBrBrlj8z5v3tMxIdAAbf6MUqEggCVxEn3ukCHKs4A8s
         LVLnEWgfsSzFWEHpPBe54GmuFtEexJ5bhFwLeSCpBFMujGKMS2k51LhOGSpdtgzEsluB
         Cskj/x5ntWijXDBqOLKEO9tlmTf0GH2RyZX3gbNjTk2q9ZMc6npEiLCdolo8NzUxzLTC
         LviQ==
X-Gm-Message-State: ABy/qLZYDQ9v14P7OOdb/+TWmv6c50TWf6B8K3rDuuKZvWsm8qVWQaOE
        oGi6638VbIenUYnAynXgfeYWtA==
X-Google-Smtp-Source: APBJJlEdQduU4Odvi7yNT3UQy9kDY+lEssXYe8tOu5yZp/tDGzHDh9gnWuSC4AfJT9ngt+m4qfWfnw==
X-Received: by 2002:a05:6402:8d8:b0:51e:e67:df4d with SMTP id d24-20020a05640208d800b0051e0e67df4dmr2925284edz.38.1688400600509;
        Mon, 03 Jul 2023 09:10:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p14-20020a05640243ce00b0051dd16f7e50sm6212725edc.44.2023.07.03.09.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 09:09:59 -0700 (PDT)
Message-ID: <8f859959-d0d7-8417-68c9-19105be1844d@linaro.org>
Date:   Mon, 3 Jul 2023 18:09:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: minor whitespace cleanup around '='
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230702185051.43867-1-krzysztof.kozlowski@linaro.org>
 <e09af830-d114-7ee6-0cab-e6812bc10fd4@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e09af830-d114-7ee6-0cab-e6812bc10fd4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2023 11:30, Konrad Dybcio wrote:
> On 2.07.2023 20:50, Krzysztof Kozlowski wrote:
>> The DTS code coding style expects exactly one space before and after '='
>> sign.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/ipq8074.dtsi         |   8 +-
>>  .../dts/qcom/msm8916-samsung-serranove.dts    |   6 +-
>>  arch/arm64/boot/dts/qcom/msm8939.dtsi         |  14 +-
>>  .../boot/dts/qcom/msm8953-xiaomi-daisy.dts    |   2 +-
>>  .../boot/dts/qcom/msm8953-xiaomi-vince.dts    |   2 +-
>>  arch/arm64/boot/dts/qcom/msm8996.dtsi         |   6 +-
>>  .../dts/qcom/msm8996pro-xiaomi-natrium.dts    |   2 +-
>>  arch/arm64/boot/dts/qcom/msm8998.dtsi         |  18 +-
>>  arch/arm64/boot/dts/qcom/qcm2290.dtsi         |   2 +-
>>  arch/arm64/boot/dts/qcom/qcs404.dtsi          |   8 +-
>>  arch/arm64/boot/dts/qcom/sa8540p.dtsi         |   2 +-
>>  .../sc7280-herobrine-audio-rt5682-3mic.dtsi   |   2 +-
>>  arch/arm64/boot/dts/qcom/sc7280.dtsi          |   2 +-
>>  arch/arm64/boot/dts/qcom/sc8180x.dtsi         |   2 +-
>>  arch/arm64/boot/dts/qcom/sdm630.dtsi          |  10 +-
>>  .../dts/qcom/sdm845-oneplus-enchilada.dts     |   2 +-
>>  arch/arm64/boot/dts/qcom/sdx75.dtsi           |   4 +-
>>  arch/arm64/boot/dts/qcom/sm6115.dtsi          |   2 +-
>>  arch/arm64/boot/dts/qcom/sm8250.dtsi          | 198 +++++++++---------
>>  arch/arm64/boot/dts/qcom/sm8350.dtsi          | 196 ++++++++---------
>>  arch/arm64/boot/dts/qcom/sm8450.dtsi          | 194 ++++++++---------
>>  arch/arm64/boot/dts/qcom/sm8550.dtsi          | 196 ++++++++---------
>>  22 files changed, 439 insertions(+), 439 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>> index 68839acbd613..00ed71936b47 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>> @@ -794,10 +794,10 @@ frame@b128000 {
>>  
>>  		pcie1: pci@10000000 {
>>  			compatible = "qcom,pcie-ipq8074";
>> -			reg =  <0x10000000 0xf1d>,
>> -			       <0x10000f20 0xa8>,
>> -			       <0x00088000 0x2000>,
>> -			       <0x10100000 0x1000>;
>> +			reg = <0x10000000 0xf1d>,
>> +			      <0x10000f20 0xa8>,
>> +			      <0x00088000 0x2000>,
>> +			      <0x10100000 0x1000>;
>>  			reg-names = "dbi", "elbi", "parf", "config";
>>  			device_type = "pci";
>>  			linux,pci-domain = <1>;
>> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
>> index 15dc246e84e2..126e8b5cf49f 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
>> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
>> @@ -219,9 +219,9 @@ magnetometer@2e {
>>  		compatible = "yamaha,yas537";
>>  		reg = <0x2e>;
>>  
>> -		mount-matrix =  "0",  "1",  "0",
>> -				"1",  "0",  "0",
>> -				"0",  "0", "-1";
>> +		mount-matrix = "0",  "1",  "0",
>> +			       "1",  "0",  "0",
>> +			       "0",  "0", "-1";
>>  	};
>>  };
>>  
>> diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
>> index 895cafc11480..c4209e2d4b4e 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
>> @@ -155,7 +155,7 @@ CPU7: cpu@3 {
>>  
>>  		idle-states {
>>  			CPU_SLEEP_0: cpu-sleep-0 {
>> -				compatible ="qcom,idle-state-spc", "arm,idle-state";
>> +				compatible = "qcom,idle-state-spc", "arm,idle-state";
> Will conflict with:
> 
> https://lore.kernel.org/linux-arm-msm/20230627-topic-more_bindings-v1-2-6b4b6cd081e5@linaro.org/
> 
> there are also a couple of entries with property =\n\t{n}[a-z]
> 
> Otherwise lgtm
> 
... and if I want to reply to this, I have to find and remove entire big
piece of unrelated quote. So you put this burden on me and you keep
insisting that everything is easy. No, it is not.

Anyway, the remaining =\t properties were done like this on purpose for
easier reading. What I am cleaning here are the cases where there are no
benefits of such style.

Best regards,
Krzysztof

