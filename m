Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCAB67D9A7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjAZXfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjAZXfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:35:42 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1771ABE7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:35:41 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v13so3310490eda.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hzo3sFEc0rrT2DBc4hVlM+1SiVGoPIKepFO94/n3CJk=;
        b=aDDZmr9bRaxGmTx/CMesBvr5efvVLQ0uNblfGbTc3A2Iouva3ybE7fa9mzo8ahJt3q
         AKlMLCSK2rE0YsfR6bHBeIfr2AKFXJQTH3+3GmlF2ueLU+UBelbYa6NgXDhlxAyHNDHD
         JE2oHu26ugxiubsGcOTcm6otAa5wXI4IugT/a1ixWzIErQLq616jjZlVkV/m+ZLmJ37S
         UwmCdok7WWsAbRgb7pfKCb8XFLFgUAgsRpLPcIvura2H69t3waXOvdOfz0L8WZ/IRqyK
         50w9av/3224OYgWLHBDCMY9flRToQiv9Ly/O1bi6yrXGNJpr5CWEyj00gvNh4qTS5hv0
         7IhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hzo3sFEc0rrT2DBc4hVlM+1SiVGoPIKepFO94/n3CJk=;
        b=MxtHJdLiF0JjJGpQGVih1IQLPNBciJEymirtu/c00ipEjJD1CUCaJl7qohFbFUj7gb
         8x5S8aMhc5fN8K4b3+kgv3mfPrlOY+0usFSEtbsVbt9rG4hiyhDr0kSrQiEU7oBaFrlA
         TnNu1nHE9ixOqTFJdUtp4Vmi3dBRLtkEn+4w4Ea9oa34bxARXs5xRVR05gO8Zo5SiLpu
         ctqE9lr1pV6janWTGyyvzv4tBcG4rUaiLqG2164w76c7Rvqg4YStdXO2NOD0e1ni3w9v
         3lgY1jDZfX1ykLsmG+jarMH4L6qJRzXHJ+rpEdlEuifKmMH7NporWhIkclgt67Qjdb97
         cXgw==
X-Gm-Message-State: AFqh2kolynFUYl9BlIHlokkhXoMX+7m+loO/8wqJ4Srt/glzTmf2BvlM
        2/SMeJCI7nocGbCzkp0vDSGmeg==
X-Google-Smtp-Source: AMrXdXvx27D+sTT4yn7XqkM6+ujwe2QR+RCFnO1b8ormrj04Pluko4Yf1pUSp7WHdEyfpbxBZoGVdA==
X-Received: by 2002:a05:6402:27cf:b0:488:e7ae:5cc4 with SMTP id c15-20020a05640227cf00b00488e7ae5cc4mr47577513ede.41.1674776139293;
        Thu, 26 Jan 2023 15:35:39 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id p11-20020a50cd8b000000b004972644b19fsm1424101edi.16.2023.01.26.15.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 15:35:38 -0800 (PST)
Message-ID: <5a638130-89c3-871b-c233-55048a162870@linaro.org>
Date:   Fri, 27 Jan 2023 00:35:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sa8295p-adp: Add max20411 on
 i2c12
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230124184440.1421074-1-quic_bjorande@quicinc.com>
 <20230124184440.1421074-4-quic_bjorande@quicinc.com>
 <20230126225446.rjckq5p35zeozphq@halaney-x13s>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230126225446.rjckq5p35zeozphq@halaney-x13s>
Content-Type: text/plain; charset=UTF-8
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



On 26.01.2023 23:54, Andrew Halaney wrote:
> On Tue, Jan 24, 2023 at 10:44:40AM -0800, Bjorn Andersson wrote:
>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>>
>> The SA8295P ADP has a Maxim max20411 step-down converter on i2c12.
>>
>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>> ---
>>
>> Changes since v1:
>> - i2c node had changed name
>>
>>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 41 ++++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
> 
> I realized today this has to do with the comment over at:
> 
>     https://lore.kernel.org/all/30166208-ba9d-e6e6-1cd2-807a80536052@quicinc.com/
> 
> and I just didn't realize that the schematic I've started looking at
> black boxes the SOM/SIP which holds this... darn I thought I could see
> more than I could :(
> 
> I took a similiar patch for a spin on sa8540p-ride (which I'll later
> submit), and things worked fine (I'm not really consuming the output of
> the regulator mind you).
> 
> Downstream devicetree indicates all of this looks ok except for possibly
> the below comment:
> 
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>> index bb4270e8f551..642000d95812 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>> @@ -266,6 +266,27 @@ &dispcc1 {
>>  	status = "okay";
>>  };
>>  
>> +&i2c12 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&i2c12_state>;
>> +
>> +	status = "okay";
>> +
>> +	vdd_gfx: regulator@39 {
>> +		compatible = "maxim,max20411";
>> +		reg = <0x39>;
>> +
>> +		regulator-name = "vdd_gfx";
>> +		regulator-min-microvolt = <800000>;
> 
> Is there a reason you chose this instead of the 500000 I see downstream?
> 
>> +		regulator-max-microvolt = <968750>;
> 
> Likewise, I see in this brief description of the regulator
> that the upper bound is higher than this (1.275 V). I am not sure if
> the values in the devicetree are supposed to describe the
> min/max of the regulator itself, or of what your board can really
> handle/needs (the latter I guess makes more sense since you wouldn't want to
> accidentally request a current draw that could melt something.. that can
> be fun). I do see you've got that min/max in the driver itself (now that
> I peaked at that patch).
Yes, your suspicions are correct and the DT sets the actual ranges
for the voltage regulators on this specific board while the
hardware reachable ranges are defined in the .c driver.

Konrad
> 
> https://www.analog.com/en/products/MAX20411.html#product-overview
> 
> For what it is worth, I also see a SIP document that states vdd_gfx min/max
> is 0.56/1.03 V, which is ultimately what you'd feed this into. The
> downstream devicetree uses the max value you provide though.
> 
> No idea how much faith I should put into the SIP document's bounds, or
> downstream, but I thought I should at least highlight them.
> 
> Thanks,
> Andrew
> 
