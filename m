Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494FD6BE8F1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCQMMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCQMMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:12:38 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8714FC5AF3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:12:31 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id r27so6191770lfe.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679055149;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZ+vK+6WO1WDejh5ev7ilG9z4FY98vw2pL/2j3yWkWs=;
        b=fhfp6y8itcvatybT//bpiYJnAU1M+WXrvddBjQGZHSaDmb8QBRVUGYcvkO34NpmvQH
         qiwrbYjL951RqY6zaSLAOTEc80G0V1SXgLTjc6xYSCJiWlDmm3XLriX8t56w6Dro2LWf
         GYhU2zmVopE/jMczRVK++pP/BR9BIsQqvY6KQXbViOQ13dnPhiz6vJrlcJBetuhtNJUw
         rSAx0emdoK9BMlWLuL+psSg+qDeWY8WM9NjMonpMRT0RzT5os1umjdHJvIxZjsAU7RJu
         ckJFF1kVdLh0QEKsBTe5a+gUFjsu23B/L0Jw13e7wXIhqskImB6jpXvbqA+4ZvBljvbx
         56JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679055149;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZ+vK+6WO1WDejh5ev7ilG9z4FY98vw2pL/2j3yWkWs=;
        b=5YsZwGnX3Z+0Kn0bYfx4+Z8XvRQSCgwQ7Qcilvcez5oIzSu/+/1a3XMP8BRJWH+muF
         gXY3M3cNrzJacIacdDXkIMyo2ezGLSxkBKbgvIJZAOPpdqZjChqATxwJaHOYJNIBDiD/
         yBWB03VaRu4rc3J4C5bt9EvwI0V05mCbuOTiEnaBscJb+EwzDTgeEIzteRCCTEKbtsi3
         EPa6X6IYkIbN+70xLlwmsRpyuwdftzDppbU7+W1/FTT/Zzsyrn/+lpCwSxbCAAEzpyKO
         J1feJ5d6Zph63cqgZUWOevlObwzJVNd9QA5JEFpCgLPf/1RKR0pcuMf4t9smqLte8agS
         oM6Q==
X-Gm-Message-State: AO0yUKV61VFXT4f72n5RB2jQhYiVzPPGAZS4nT2CpvlNwo1N+2pkG/PK
        xJ0yY5xPr0ue4l2ggHiG0A40fg==
X-Google-Smtp-Source: AK7set++/DawecZHkwBeKS86YHeRSjzF2Dwq3PiSStzZRtya7+0OEEjIF4DsMBPGukH/+x4Sp8yp4g==
X-Received: by 2002:a05:6512:70:b0:4b5:a207:8d70 with SMTP id i16-20020a056512007000b004b5a2078d70mr4187251lfo.5.1679055149357;
        Fri, 17 Mar 2023 05:12:29 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id d8-20020ac25448000000b004d093d60f50sm343325lfn.215.2023.03.17.05.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 05:12:28 -0700 (PDT)
Message-ID: <985c5e15-17a0-d54a-bac2-c33a265ca3c9@linaro.org>
Date:   Fri, 17 Mar 2023 13:12:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/5] arm64: dts: qcom: sm6350: Add QFPROM node
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20230315-topic-lagoon_gpu-v1-0-a74cbec4ecfc@linaro.org>
 <20230315-topic-lagoon_gpu-v1-3-a74cbec4ecfc@linaro.org>
 <CR8J37NBHHRY.2S8LQ5O7IQ9PU@otso>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CR8J37NBHHRY.2S8LQ5O7IQ9PU@otso>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.03.2023 09:50, Luca Weiss wrote:
> On Thu Mar 16, 2023 at 12:16 PM CET, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@somainline.org>
>>
>> Add a node for the QFPROM NVMEM hw and define the GPU fuse.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
>> index 523c7edfa4b3..60b68d305e53 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
>> @@ -637,6 +637,18 @@ ipcc: mailbox@408000 {
>>  			#mbox-cells = <2>;
>>  		};
>>  
>> +		qfprom: qfprom@784000 {
>> +			compatible = "qcom,sm6350-qfprom", "qcom,qfprom";
>> +			reg = <0 0x00784000 0 0x3000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +
>> +			gpu_speed_bin: gpu_speed_bin@2015 {
> 
> gpu-speed-bin@2015 ?
Ack
Konrad
> 
> With that fixed:
> 
> Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
> 
>> +				reg = <0x2015 0x1>;
>> +				bits = <0 8>;
>> +			};
>> +		};
>> +
>>  		rng: rng@793000 {
>>  			compatible = "qcom,prng-ee";
>>  			reg = <0 0x00793000 0 0x1000>;
>>
>> -- 
>> 2.39.2
> 
