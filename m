Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAF25FBAB6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiJKSsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJKSsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:48:41 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E2A46845;
        Tue, 11 Oct 2022 11:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665514120; x=1697050120;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C+kiKfbWInTIcg6Wdy5JaE7KsrfAtowr8sm0rP930+I=;
  b=zQFr30mTByuSqvqX9ZhMHVPkPX25CPJNIjO0RL10pw9YGmFBZe9bzbnS
   X10gIattu4/AU9zNaIVKMP6IoMfnPcnN0hYZq+yhHnieeHD8z/CC5tlJb
   6EDuCDjH8mIiTI0FIMrc+pO0iZrPtWVgtUwHBM89/TZlpcdgB9MjTilfs
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Oct 2022 11:48:40 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 11:48:40 -0700
Received: from [10.110.3.66] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 11 Oct
 2022 11:48:39 -0700
Message-ID: <7674b756-75d5-6ca3-d4fe-c54bd92a3fd7@quicinc.com>
Date:   Tue, 11 Oct 2022 11:48:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 03/19] arm64: dts: qcom: qdru1000: Add tlmm nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221001030656.29365-1-quic_molvera@quicinc.com>
 <20221001030656.29365-4-quic_molvera@quicinc.com>
 <ad743621-8e2d-23f9-8c44-53f6681aa134@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <ad743621-8e2d-23f9-8c44-53f6681aa134@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/2022 2:14 AM, Krzysztof Kozlowski wrote:
> On 01/10/2022 05:06, Melody Olvera wrote:
>> Add tlmm node for the QDU1000 and QRU1000 SoCs and the uart pin
>> configuration.
> The patchset should be squashed with previous. There is no point in
> bringing support piece by piece. You can bring support in steps if you
> submissions are separate in time. But if you have everything ready -
> your patch must be complete and bisectable.
To be clear, does it make more sense to submit the base dt first, then submit each
driver with all the dt changes as one patchset?
>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/qdru1000.dtsi | 30 ++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qdru1000.dtsi b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
>> index 3610f94bef35..39b9a00d3ad8 100644
>> --- a/arch/arm64/boot/dts/qcom/qdru1000.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
>> @@ -235,6 +235,8 @@ uart7: serial@99c000 {
>>  				reg = <0x0 0x99c000 0x0 0x4000>;
>>  				clock-names = "se";
>>  				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_uart7_default>;
>>  				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
>>  				#address-cells = <1>;
>>  				#size-cells = <0>;
>> @@ -248,6 +250,34 @@ tcsr_mutex: hwlock@1f40000 {
>>  			#hwlock-cells = <1>;
>>  		};
>>  
>> +		tlmm: pinctrl@f000000 {
>> +			compatible = "qcom,qdu1000-tlmm", "qcom,qru1000-tlmm";
>> +			reg = <0x0 0xf000000 0x0 0x1000000>;
>> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>> +			gpio-controller;
>> +			#gpio-cells = <2>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +			gpio-ranges = <&tlmm 0 0 151>;
>> +			wakeup-parent = <&pdc>;
>> +
>> +			qup_uart7_default: qup-uart7-default {
> Suffix "-state"
Ack.
>
>> +				tx {
> Suffix "-pins"
Ack.
>
>> +					pins = "gpio134";
>> +					function = "qup0_se7_l2";
>> +					drive-strength = <2>;
>> +					bias-disable;
>> +				};
>> +
>> +				rx {
> Suffix "-pins"
Ack.
>
>
>> +					pins = "gpio135";
>> +					function = "qup0_se7_l3";
>> +					drive-strength = <2>;
>> +					bias-disable;
>> +				};
>> +			};
>> +		};
>> +
>>  		pdc: interrupt-controller@b220000 {
>>  			compatible = "qcom,pdc";
>>  			reg = <0x0 0xb220000 0x0 0x30000>, <0x0 0x174000f0 0x0 0x64>;
> Best regards,
> Krzysztof
>
Thanks,
Melody
