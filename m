Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8FF7035CD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243576AbjEORCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243479AbjEORC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:02:26 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8474A9001
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:00:25 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f00d41df22so67528407e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684170019; x=1686762019;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GYDwAxBjxKaXqirWOJFxiCv8QGm8k3OjcSxYqeRJPfI=;
        b=YOnY7USwDtFpLdcfcnjLDXxR3Rzemt5HfA95dOoQzZszqRGaiWd1Nh2ZdcpX3NLYGs
         ikS4HhOTrLSC3eqx5bJNlWMJ38p3duPgFYy84YImiuHN9UL2CtQ524UBEjo4ul1n2mcI
         kweMJRMKAOrP2QX/TWshabbDDGyJmldHK+FeRDwypPOM6Z5U2ErvEpm2VyO84FzNHrJr
         xwhG5b1EfprPc86YWG5Kumi6X60VIpQM07snIXkkvUIS4qjMPGBNvDnlNJeRZy1n17SM
         s7Z7M+puRDKzrjItuogDhpOao3H+WRXY9TBZVJ4YMFhGvZd4t/YfXLDOqvVivQABDkyE
         HcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684170019; x=1686762019;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GYDwAxBjxKaXqirWOJFxiCv8QGm8k3OjcSxYqeRJPfI=;
        b=fnledsSMWMRKQMYeU9xW0VFwMaXF6WEpapoV2RgO2jsiYxaUgjzix8F7s5j2Kh+OKc
         2bBYNjA0JSpiLsh7nFDaAszM8feAoCtjheanuJNqq37pid55xiqhD97wCM6PqLNE5FEt
         zsGNLVaZZs3hc0XEzo5uI/CIXuxRWcgMcSZfhNsD/G6w+z1IUjXWCsiac0ac+wFOB7Cl
         F6gVbTU1wVqRX05CW5qJ1KKqy1bNXj9wXQlCMUtU9TvwH6W/6T7Z5NXLYi6EA2uOvsd3
         8uTeTT8rsAVmdpQSxEP4QTSG0/bhmCBXikvtCED/r0hPMr8/wb148Xkk5gu6RCrjKACA
         /4/Q==
X-Gm-Message-State: AC+VfDxGDkUmG95BrpdUi3/CQZEoV1To31FqBM8ZyrTKEtJYua6UYRKF
        gbBhYOalAS16dOt+Vhu6MB8SMw==
X-Google-Smtp-Source: ACHHUZ5p/F4cQAqLEz7OU0T2Q8kbCZQCyAysDd2OXRAyAEd+2o0ur2AykpobhzcwlPiRwmA5VFiqmg==
X-Received: by 2002:a2e:b4a6:0:b0:2ac:7fc5:e4a9 with SMTP id q6-20020a2eb4a6000000b002ac7fc5e4a9mr5957561ljm.16.1684170018863;
        Mon, 15 May 2023 10:00:18 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id c24-20020a05651c015800b002a9ebff8431sm3856802ljd.94.2023.05.15.10.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 10:00:18 -0700 (PDT)
Message-ID: <b0cf5634-60e4-adba-92df-73f05451cd9f@linaro.org>
Date:   Mon, 15 May 2023 19:00:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/5] arm64: dts: qcom: qrb4210-rb2: Enable display out
Content-Language: en-US
To:     Caleb Connolly <caleb.connolly@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230515-topic-rb2-bits-v1-0-a52d154a639d@linaro.org>
 <20230515-topic-rb2-bits-v1-2-a52d154a639d@linaro.org>
 <fd4276f6-f54b-3455-1263-8a8d534f0bda@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <fd4276f6-f54b-3455-1263-8a8d534f0bda@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.05.2023 17:57, Caleb Connolly wrote:
> 
> 
> On 15/05/2023 13:04, Konrad Dybcio wrote:
>> The RB2 has a HDMI output via an LT9611UXC bridge. Set it up.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 88 +++++++++++++++++++++++++++++++-
>>  1 file changed, 87 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
>> index 80c6b59c8ff6..9b539720f05d 100644
>> --- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
>> +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> 
> [...]
>> @@ -312,11 +385,24 @@ &sleep_clk {
>>  };
>>  
>>  &tlmm {
>> -	gpio-reserved-ranges = <37 5>, <43 2>, <47 1>,
>> +	gpio-reserved-ranges = <43 2>, <47 1>,
> 
> Is this intentional?
Yes, notice how this included the reset pin. These pins are
not even really reserved, there's no FPC on this board..

Konrad
>>  			       <49 1>, <52 1>, <54 1>,
>>  			       <56 3>, <61 2>, <64 1>,
>>  			       <68 1>, <72 8>, <96 1>;
>>  
>> +	lt9611_rst_pin: lt9611-rst-state {
>> +		pins = "gpio41";
>> +		function = "gpio";
>> +		input-disable;
>> +		output-high;
>> +	};
>> +
>> +	lt9611_irq_pin: lt9611-irq-state {
>> +		pins = "gpio46";
>> +		function = "gpio";
>> +		bias-disable;
>> +	};
>> +
>>  	sdc2_card_det_n: sd-card-det-n-state {
>>  		pins = "gpio88";
>>  		function = "gpio";
>>
> 
