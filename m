Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708D86123B3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 16:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiJ2OST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 10:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJ2ORj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 10:17:39 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D8F5FAE4;
        Sat, 29 Oct 2022 07:17:22 -0700 (PDT)
Received: from [192.168.1.101] (95.49.29.156.neoplus.adsl.tpnet.pl [95.49.29.156])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 645283EBA5;
        Sat, 29 Oct 2022 16:17:20 +0200 (CEST)
Message-ID: <6e5b1e5e-b10c-2a7f-7b32-c603db423f25@somainline.org>
Date:   Sat, 29 Oct 2022 16:17:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 05/12] arm64: dts: qcom: sc8280xp-pmics: Add PMK8280
 ADC7 block
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        johan+linaro@kernel.org, quic_jprakash@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org
References: <20221029051449.30678-1-manivannan.sadhasivam@linaro.org>
 <20221029051449.30678-6-manivannan.sadhasivam@linaro.org>
 <2842a802-3f5a-7f28-5e81-b46d7a3abca5@somainline.org>
In-Reply-To: <2842a802-3f5a-7f28-5e81-b46d7a3abca5@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.10.2022 16:15, Konrad Dybcio wrote:
> 
> 
> On 29.10.2022 07:14, Manivannan Sadhasivam wrote:
>> Add support for ADC7 block available in PMK8280 for reading the
>> temperature via the AMUX pins.
>>
>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
>> index 4a3464f5e6e9..3c56e4cb5b5b 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
>> @@ -75,6 +75,15 @@ pmk8280_pon_resin: resin {
>>  				status = "disabled";
>>  			};
>>  		};
>> +
>> +		pmk8280_vadc: adc@3100 {
>> +			compatible = "qcom,spmi-adc7";
>> +			reg = <0x3100>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
>> +			#io-channel-cells = <1>;
> Maybe having interrupts after reg and all the -cells below that would look better.
> 
> For the contents though:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> 
> Konrad
Sorry for double noise, I just noticed you didn't disable this by default. Was that intended?

Konrad
>> +		};
>>  	};
>>  
>>  	pmc8280_1: pmic@1 {
