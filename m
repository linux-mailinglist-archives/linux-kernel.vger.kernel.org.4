Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D00723AFD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbjFFIHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjFFIHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:07:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CE0B1;
        Tue,  6 Jun 2023 01:07:29 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3565LdJt011096;
        Tue, 6 Jun 2023 08:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GmbQksY5LjsuP+/o0XAuMubNUkJYqYdsPCNjeqFxsyY=;
 b=Yj3zXg0c4kIirvfvkd9ymggEw/PLNp6DPr2hZ1WvAhrD3/nzwx4C/IjfYH+ntYifVrEx
 jhUWtbwF+g6KGgI9pkHy4MTh8vxQZZZKGQigoxAIiiPTjRtaIB6tSReUQKEXv2C65uyi
 SjduLEimraSJ/kWcP0TI8qIKFEWFQ+BXyccOul9yuNvtwg0g5PbcjUI9oQpvlijmohoY
 K6sNXuQqkST8R4deJH6HitvNAnGQl0hQ/B+kGZmMBUCW0+1zkTv+X8Jufu7jSaSJjEbt
 R0A+sf6zWxzCGLhavBTISOWpNraDa0JyNfYw/Kre5plNXFfgsmkqM4avly5cJf1f82aJ Yw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r1uvv0kmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 08:07:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3568708N006720
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Jun 2023 08:07:00 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 6 Jun 2023
 01:06:53 -0700
Message-ID: <327b8d8a-edc9-f0a6-6c7d-070b8bb86ed5@quicinc.com>
Date:   Tue, 6 Jun 2023 13:36:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 08/10] arm64: dts: qcom: Add QUPv3 UART console node
 for SDX75
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>, <mani@kernel.org>,
        <robimarko@gmail.com>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
References: <1685982557-28326-1-git-send-email-quic_rohiagar@quicinc.com>
 <1685982557-28326-9-git-send-email-quic_rohiagar@quicinc.com>
 <d8c9b229-47ab-cedd-3515-4faf3146e6f8@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <d8c9b229-47ab-cedd-3515-4faf3146e6f8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: G2z3kGFlJJ1RCZNoTkUurkFP1dv2JYQV
X-Proofpoint-GUID: G2z3kGFlJJ1RCZNoTkUurkFP1dv2JYQV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_04,2023-06-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060069
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/5/2023 11:47 PM, Konrad Dybcio wrote:
>
> On 5.06.2023 18:29, Rohit Agarwal wrote:
>> Add the debug uart console node in devicetree.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sdx75.dtsi | 49 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> index f83eef8..47170ae 100644
>> --- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> @@ -385,6 +385,34 @@
>>   			#power-domain-cells = <1>;
>>   		};
>>   
>> +		qupv3_id_0: geniqup@9c0000 {
>> +			compatible = "qcom,geni-se-qup";
>> +			reg = <0x0 0x009c0000 0x0 0x2000>;
>> +			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
>> +				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
>> +			clock-names = "m-ahb",
>> +				      "s-ahb";
>> +			iommus = <&apps_smmu 0xe3 0x0>;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
>> +			status = "disabled";
>> +
>> +			uart1: serial@984000 {
>> +				compatible = "qcom,geni-debug-uart";
>> +				reg = <0x0 0x00984000 0x0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
>> +				interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>;
>> +				pinctrl-0 = <&qupv3_se1_2uart_tx_active>,
>> +					    <&qupv3_se1_2uart_rx_active>;
>> +				pinctrl-1 = <&qupv3_se1_2uart_sleep>;
>> +				pinctrl-names = "default",
>> +						"sleep";
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>>   		tcsr_mutex: hwlock@1f40000 {
>>   			compatible = "qcom,tcsr-mutex";
>>   			reg = <0x0 0x01f40000 0x0 0x40000>;
>> @@ -413,6 +441,27 @@
>>   			interrupt-controller;
>>   			#interrupt-cells = <2>;
>>   			wakeup-parent = <&pdc>;
>> +
>> +			qupv3_se1_2uart_tx_active: qupv3-se1-2uart-tx-active-state {
>> +				pins = "gpio12";
>> +				function = "qup_se1_l2_mira";
>> +				drive-strength= <2>;
>> +				bias-disable;
>> +			};
> You can bunch these two up like this:
>
> qupv3_se1_2uart_active: qup.... {
> 	tx {
> 		pins = ...
> 		foo = ...
> 	};
>
> 	rx {
> 		pins = ...
> 		bar = ...
> 	};
> };
Sure will do this in the next version having all this in the single patch.

Thanks,
Rohit.
> Konrad
>> +
>> +			qupv3_se1_2uart_rx_active: qupv3-se1-2uart-rx-active-state {
>> +				pins = "gpio13";
>> +				function = "qup_se1_l3_mira";
>> +				drive-strength= <2>;
>> +				bias-disable;
>> +			};
>> +
>> +			qupv3_se1_2uart_sleep: qupv3-se1-2uart-sleep-state {
>> +				pins = "gpio12", "gpio13";
>> +				function = "gpio";
>> +				drive-strength = <2>;
>> +				bias-pull-down;
>> +			};
>>   		};
>>   
>>   		apps_smmu: iommu@15000000 {
