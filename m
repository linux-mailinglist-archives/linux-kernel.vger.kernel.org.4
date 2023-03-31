Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADD36D1492
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 02:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCaA7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 20:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCaA7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:59:46 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1E9EF89
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:59:35 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id br6so26870037lfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680224374;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7LPxY9T1r45WTEaAAuLtJzPvrc06HSNsazSBaeqW1oQ=;
        b=ff+O28HjDPq8rFcPd4i8R3hAc8yJI2qZnQumAsyML72g1KuInWyRUMNCQ6PnwYmrk6
         zru17a0+1tO1A6BQQNE19VhP7IzjaiA4iukYytWNXuvX/rMnZgtyFf8JNOWWdfepz+JE
         EYj+aAtwhTgpP4VgzX0bTlvOdqr0y/tfgPze+xlQEpauVshPs8xXDrYM2ZiTvbTh1o98
         G1rWxkQpzZPtm02sKt5rbfLPQu7vfOh9pKt4jAwTm1KJ5Bp2sEDvzVu9STjrhS/QqKm3
         Vb7vNOVwwSYownEzux28ADc0x2m9wWF2oWw4f+XIrbh3jpWE7KjzZhQk9KVYYJJGxNu7
         PEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680224374;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7LPxY9T1r45WTEaAAuLtJzPvrc06HSNsazSBaeqW1oQ=;
        b=fazLJuJ4E8jcf4Sqh5lcxq1xQ6pqCiARSI83LrqewTS/OtgiheO82w/yLg8dt9/XO7
         teJODKO/rG4oItm11dW/UQ67nR1X6yzTjX92AQmR61wVov9Mi0VNNUbWHZE4MGdFOI85
         o3sq7cmqNBUprjlfXFJPZLr+QgX6l3vttA3WfgctCcPslZeT5qwlK/ol5XAAYPTiksXm
         cZRRvsCYQ7IiKjGnKbEcKK3fBUR0zEKiByhmq/tlZXEkLS0L2AQ2BXOiSLSyMPE7GJxn
         r6I3Y6BOzL9U+lECnPAkhrCo0Y3zhmTQUCSrjSKFRJUJmeN9/6x0JN+s95oSM83k6YdO
         E4lQ==
X-Gm-Message-State: AAQBX9f3xZ8frfA/iFNeLomWCbHZ2y8UsxhqKP2DJXzdL2bVEypXsdPP
        uF4Aq44JMzKaYicQWe4G8hGKGQ==
X-Google-Smtp-Source: AKy350bodBb/E3SCjT3zyYCxtrEgcQ1xNCVGeJpZDSqpEKe93vQNj9phHBQI5nNGA5jXQnbXPrLuEA==
X-Received: by 2002:a19:ee18:0:b0:4e9:da0:6e13 with SMTP id g24-20020a19ee18000000b004e90da06e13mr6574627lfb.57.1680224373846;
        Thu, 30 Mar 2023 17:59:33 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id d27-20020ac24c9b000000b004db2b54714bsm154245lfl.67.2023.03.30.17.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 17:59:33 -0700 (PDT)
Message-ID: <ff4e3f7a-04eb-2049-be49-e193a6ee2b2d@linaro.org>
Date:   Fri, 31 Mar 2023 03:59:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: sm8250: Add GPU speedbin support
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230120172233.1905761-1-konrad.dybcio@linaro.org>
 <20230120172233.1905761-6-konrad.dybcio@linaro.org>
 <df57f5c1-13aa-c328-57ac-de486d29e549@linaro.org>
In-Reply-To: <df57f5c1-13aa-c328-57ac-de486d29e549@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 31/03/2023 03:43, Dmitry Baryshkov wrote:
> On 20/01/2023 19:22, Konrad Dybcio wrote:
>> SM8250 has (at least) four GPU speed bins. With the support added on the
>> driver side, wire up bin detection in the DTS to restrict lower-quality
>> SKUs from running at frequencies they were not validated at.
>>
>> Tested-by: Marijn Suijten <marijn.suijten@somainline.org> # On Sony 
>> Xperia 5 II (speed bin 0x7)
>> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8250.dtsi | 23 ++++++++++++++++++++++-
>>   1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi 
>> b/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> index 059c83003fb6..95f1a6afcd43 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> @@ -981,6 +981,18 @@ ipcc: mailbox@408000 {
>>               #mbox-cells = <2>;
>>           };
>> +        qfprom: efuse@784000 {
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
>>               qcom,gmu = <&gmu>;
>> +            nvmem-cells = <&gpu_speed_bin>;
>> +            nvmem-cell-names = "speed_bin";
>> +
>>               status = "disabled";
>>               zap-shader {
>>                   memory-region = <&gpu_mem>;
>>               };
>> -            /* note: downstream checks gpu binning for 670 Mhz */
>>               gpu_opp_table: opp-table {
>>                   compatible = "operating-points-v2";
>>                   opp-670000000 {
>>                       opp-hz = /bits/ 64 <670000000>;
>>                       opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
>> +                    opp-supported-hw = <0x6>;
> 
> opp-supported-hw = <0xa>; /* 3 & 1 */

Konrad pointed out that vendor dtsi has pwrlevel #3 for speed-bin=2 and 
vice versa, so the patch is correct (it has mapped speed-bin to hw as 
1:1 instead of weird 2<->3 mapping).

Ideally there should be a comment regarding this.
Nevertheless:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
>>                   };
>>                   opp-587000000 {
>>                       opp-hz = /bits/ 64 <587000000>;
>>                       opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
>> +                    opp-supported-hw = <0x7>;
> 
> opp-supported-hw = <0xb>; /* 3, 1, 0 */
> 
> 
>>                   };
>>                   opp-525000000 {
>>                       opp-hz = /bits/ 64 <525000000>;
>>                       opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
>> +                    opp-supported-hw = <0xf>;
>>                   };
>>                   opp-490000000 {
>>                       opp-hz = /bits/ 64 <490000000>;
>>                       opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
>> +                    opp-supported-hw = <0xf>;
>>                   };
>>                   opp-441600000 {
>>                       opp-hz = /bits/ 64 <441600000>;
>>                       opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
>> +                    opp-supported-hw = <0xf>;
>>                   };
>>                   opp-400000000 {
>>                       opp-hz = /bits/ 64 <400000000>;
>>                       opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
>> +                    opp-supported-hw = <0xf>;
>>                   };
>>                   opp-305000000 {
>>                       opp-hz = /bits/ 64 <305000000>;
>>                       opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>> +                    opp-supported-hw = <0xf>;
>>                   };
>>               };
>>           };
> 

-- 
With best wishes
Dmitry

