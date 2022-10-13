Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC1C5FD935
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJMMaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJMMav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:30:51 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A2AD258B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:30:49 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id o67so1130712qvo.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=390wRPD9oe0xd/uU6WvHiSqS/MuVjNl5zczVPfqBsBg=;
        b=yNPj4OaJGCY11Uif7Ct3WjVbag7S3DlIvdhknbtIL6sUVINs6EKBi46FfRYAhsLrdN
         X1crCWv0aa80GCQdmRyjSdvzQM1U5utSgYP6yIPukzj7myYEfhm6UsBnizr+hJ2ibEPA
         2mEcEU4miIkLLuHJg5It4JvUIdEXEAT5bV7FoF98N8w1gCXN8pegmEDvKkk/CoUhD4Jm
         QadoMCni0eNEzRxie4ReRhY8fiD5cRsEW9SDw/UwKj2u+BT1gDEY9HjoC8uVqy9HN85O
         2pitzE3eElslji7v1gfRy4RhqoccuD4LaWdPi/Z/O3J8s8kzEQUP4YgSaiyK2xmCwlhT
         tSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=390wRPD9oe0xd/uU6WvHiSqS/MuVjNl5zczVPfqBsBg=;
        b=5ju7ffoMq9i0h0Xf9NbZqQ4Acx8UwsQiTHThaJgnS1X3B3uv+sBtixXCjxITIhd96q
         nZjlFCPQl6j/2MOBnoeAEcB1l6A1Ice22nS8crq/K3+E4mbiwmBUPunCm7xCYRs97uu6
         jDB6g4PHONTXls2OvweO4FYZaeloMjvdEOSvYzovTqZHiA8aqW5/DM48legETyQRiqvS
         vEO6rwGquvx6sI92SoYCLseqC5eoy3M6V1gOHPzyzum4+5Y9nVdmQiR3IlENalThvk4A
         18jwAkhs8zSSEhXx2tmxwIrZ68XarHPnMnq4sydHAIiPsggZl9g7XT3rPpHRYCcaKnuG
         baFQ==
X-Gm-Message-State: ACrzQf2XlAJKKho/cKhH1DJP398kjU6KzQPGQwcuYbt+IjhmleJGfWtf
        FcWrhrSmBbfL2BCVCh6yOz/oWQ==
X-Google-Smtp-Source: AMsMyM7i9FnSn4FHPOjamLwitqnVbZj6hoNBEAuS60cFFO20v9rF1UmJBF12yB2i3drGw2XYFsFnlw==
X-Received: by 2002:a05:6214:1d24:b0:4b1:8acb:b3bc with SMTP id f4-20020a0562141d2400b004b18acbb3bcmr26794446qvd.126.1665664248312;
        Thu, 13 Oct 2022 05:30:48 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id dt39-20020a05620a47a700b006ec59941acasm13206478qkb.11.2022.10.13.05.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 05:30:47 -0700 (PDT)
Message-ID: <84dee7a6-f8f7-75ee-b0a2-5c1516e7c0fd@linaro.org>
Date:   Thu, 13 Oct 2022 08:28:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 2/3] arm64: dts: qcom: msm8996: align TLMM pin
 configuration with DT schema
Content-Language: en-US
To:     konrad.dybcio@somainline.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221012151545.39061-1-krzysztof.kozlowski@linaro.org>
 <20221012151545.39061-2-krzysztof.kozlowski@linaro.org>
 <99ae66c725776f110272cdc2359241f7@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <99ae66c725776f110272cdc2359241f7@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2022 14:32, konrad.dybcio@somainline.org wrote:
> On 2022-10-12 17:15, Krzysztof Kozlowski wrote:
>> DT schema expects TLMM pin configuration nodes to be named with
>> '-state' suffix and their optional children with '-pins' suffix.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/apq8096-db820c.dts   |  96 ++++------
>>  arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts  |  68 ++------
>>  .../dts/qcom/msm8996-sony-xperia-tone.dtsi    |  26 +--
>>  .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  |  10 +-
>>  .../boot/dts/qcom/msm8996-xiaomi-gemini.dts   |   8 +-
>>  .../boot/dts/qcom/msm8996-xiaomi-natrium.dts  |   4 +-
>>  .../boot/dts/qcom/msm8996-xiaomi-scorpio.dts  |   8 +-
>>  arch/arm64/boot/dts/qcom/msm8996.dtsi         | 164 +++++++++---------
>>  8 files changed, 153 insertions(+), 231 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
>> b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
>> index 5cdc7ac1a9c0..a3d1ff1aba8f 100644
>> --- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
>> +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
>> @@ -422,82 +422,46 @@ &tlmm {
>>  		"NC", /* GPIO_148 */
>>  		"NC"; /* GPIO_149 */
>>
>> -	sdc2_cd_on: sdc2_cd_on {
>> -		mux {
>> -			pins = "gpio38";
>> -			function = "gpio";
>> -		};
>> -
>> -		config {
>> -			pins = "gpio38";
>> -			bias-pull-up;		/* pull up */
>> -			drive-strength = <16>;	/* 16 MA */
>> -		};
>> +	sdc2_cd_on: sdc2-cd-on-state {
>> +		pins = "gpio38";
>> +		function = "gpio";
>> +		bias-pull-up;
>> +		drive-strength = <16>;
> How about drive-strength before bias- properties? I think most DTs have 
> it like that.

Sure, I can move it.

> 
> Other than that,
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>


Best regards,
Krzysztof

