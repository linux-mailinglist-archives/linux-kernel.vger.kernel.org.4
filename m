Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECA86D1487
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 02:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCaA5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 20:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCaA5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:57:47 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DB212BD0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:57:35 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id b6so1409368ljr.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680224254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vZaMDq9dZew9R8a4yZBxEJWmvmP67z1j88DeAGmSTaI=;
        b=vZMTgndKf12QkvcBBR3Upd1OpDS5EV5fn7s03OBMy6DUiqfmmuBNQawRS9R0QACK/j
         FqGv3N/l64h09f5Zgaxg5VccA44cJyV4VRZS1msiiz1XzUzdHwDyxY3vdo1ozQ+KXnxU
         9ffWy+tAXohyAfz9wH0madGm/BtPwnTcSzaMGeWtxzcr++WqlVR7n6vFxRSp4F1BUyPD
         /+1DlyJT+OuEEikctTl2NVZqPqjA3G4dcwMU/511iBEcV+zLPntSHbjpC8euRgKdHa3I
         XYEGFx86gNmd2NwRyA5RvdD5vLzXMy33kgDjnGEQSTph5qcbx5BRc/aBSi+/QagVjv2M
         S9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680224254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZaMDq9dZew9R8a4yZBxEJWmvmP67z1j88DeAGmSTaI=;
        b=Sv0WeJCbds7WDU47Ka1CY/yVVUTvQ/kJxIFOpzuLC3AA537YG69SuSjZxN4GVboeI4
         T2h5abuX2KBe53vrQ46p5tlpvncjo4hwkLvQPjQyfwdCZtAIox+iupQseKfS/94DQxsh
         UidM+heqJjCFSZgTaDO+mjxDxtZFg2/yiLW9tHlX1N65eRDgbAHMZZTvqTYbFhQSLCgu
         BziEGiUE+w1NBsYhmAN5jvRtrf5BIn0OykIASZINzBCwqLGoZmEdLZ8UYZLiriOlfiA0
         EpqFb/v9qpH37XO6ej5Fioy4nY5O6HJS2ZOkhH60ehDT/IB75Mbj91SVgXiF2ndLxvcp
         uNtQ==
X-Gm-Message-State: AAQBX9e+TG2+lN7WnIhPTFPAEQ77S8Y1FLpzru+eIZqJzK8n3BNBvBwr
        6CifkprM6rZnZNpza/mpswvA/A==
X-Google-Smtp-Source: AKy350brZb+GGY3S7Y3PSzBguQoQB6oKAeypVRnGywSlfxLfnc4qqy143IHGEIkSeiA/646ZWSL8eQ==
X-Received: by 2002:a2e:3201:0:b0:2a4:1421:370c with SMTP id y1-20020a2e3201000000b002a41421370cmr6473058ljy.45.1680224253971;
        Thu, 30 Mar 2023 17:57:33 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id x10-20020a2e7c0a000000b0029ee7bc0114sm125331ljc.64.2023.03.30.17.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 17:57:33 -0700 (PDT)
Message-ID: <fa47f382-e1c7-cd75-0c33-e98fca02c383@linaro.org>
Date:   Fri, 31 Mar 2023 02:57:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: sm8250: Add GPU speedbin support
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230120172233.1905761-1-konrad.dybcio@linaro.org>
 <20230120172233.1905761-6-konrad.dybcio@linaro.org>
 <df57f5c1-13aa-c328-57ac-de486d29e549@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <df57f5c1-13aa-c328-57ac-de486d29e549@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.03.2023 02:43, Dmitry Baryshkov wrote:
> On 20/01/2023 19:22, Konrad Dybcio wrote:
>> SM8250 has (at least) four GPU speed bins. With the support added on the
>> driver side, wire up bin detection in the DTS to restrict lower-quality
>> SKUs from running at frequencies they were not validated at.
>>
>> Tested-by: Marijn Suijten <marijn.suijten@somainline.org> # On Sony Xperia 5 II (speed bin 0x7)
>> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8250.dtsi | 23 ++++++++++++++++++++++-
>>   1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> index 059c83003fb6..95f1a6afcd43 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> @@ -981,6 +981,18 @@ ipcc: mailbox@408000 {
>>               #mbox-cells = <2>;
>>           };
>>   +        qfprom: efuse@784000 {
>> +            compatible = "qcom,sm8250-qfprom", "qcom,qfprom";
>> +            reg = <0 0x00784000 0 0x8ff>;
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +
>> +            gpu_speed_bin: gpu_speed_bin@19b {
>> +                reg = <0x19b 0x1>;
>> +                bits = <5 3>;
>> +            };
>> +        };
>> +
>>           rng: rng@793000 {
>>               compatible = "qcom,prng-ee";
>>               reg = <0 0x00793000 0 0x1000>;
>> @@ -2576,49 +2588,58 @@ gpu: gpu@3d00000 {
>>                 qcom,gmu = <&gmu>;
>>   +            nvmem-cells = <&gpu_speed_bin>;
>> +            nvmem-cell-names = "speed_bin";
>> +
>>               status = "disabled";
>>                 zap-shader {
>>                   memory-region = <&gpu_mem>;
>>               };
>>   -            /* note: downstream checks gpu binning for 670 Mhz */
>>               gpu_opp_table: opp-table {
>>                   compatible = "operating-points-v2";
>>                     opp-670000000 {
>>                       opp-hz = /bits/ 64 <670000000>;
>>                       opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
>> +                    opp-supported-hw = <0x6>;
> 
> opp-supported-hw = <0xa>; /* 3 & 1 */
> 
>>                   };
>>                     opp-587000000 {
>>                       opp-hz = /bits/ 64 <587000000>;
>>                       opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
>> +                    opp-supported-hw = <0x7>;
> 
> opp-supported-hw = <0xb>; /* 3, 1, 0 */
The values here are correct, however I remapped the bins against
qcom logic.. will fix that in the next rev!

Konrad
> 
> 
>>                   };
>>                     opp-525000000 {
>>                       opp-hz = /bits/ 64 <525000000>;
>>                       opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
>> +                    opp-supported-hw = <0xf>;
>>                   };
>>                     opp-490000000 {
>>                       opp-hz = /bits/ 64 <490000000>;
>>                       opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
>> +                    opp-supported-hw = <0xf>;
>>                   };
>>                     opp-441600000 {
>>                       opp-hz = /bits/ 64 <441600000>;
>>                       opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
>> +                    opp-supported-hw = <0xf>;
>>                   };
>>                     opp-400000000 {
>>                       opp-hz = /bits/ 64 <400000000>;
>>                       opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
>> +                    opp-supported-hw = <0xf>;
>>                   };
>>                     opp-305000000 {
>>                       opp-hz = /bits/ 64 <305000000>;
>>                       opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>> +                    opp-supported-hw = <0xf>;
>>                   };
>>               };
>>           };
> 
