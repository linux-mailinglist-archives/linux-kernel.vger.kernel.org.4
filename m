Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B0569CDE2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjBTNxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjBTNxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:53:45 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4FB1D939;
        Mon, 20 Feb 2023 05:53:44 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31K5lK4r024899;
        Mon, 20 Feb 2023 13:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VSrgrBI6RIVXdQ/o6ds5pU2Je9koaFxO9gAerXBClhk=;
 b=P1azorMgTYNIv+dKzrYXF4A62+9xdk/4NA96tCJkWTjhPf514AwAU6mpnNEb79HsVZZ5
 kyutyDruqC8bqoUjk2BdY+243YxzVEkePckRrPl2KV+merguNjpbdIFNpKI4/J1ZAloD
 RbWYefluiXMIZl9jvrcMXNPZcHZsuyHyk2NSdfQjOV8vAe6iKoz0/uRRdA9+IJ+gFn+y
 VUJ+j4djQX539bcxO0v+VbCpkvkq9otnV/HNafFUktL1v6nkMiLyBDFtPZVzIAEm//vc
 YP1kVtCoN8uXDuVtKlUbmpjK1zGnecg0eqFKfCVlkci/KEVm64cl31sZt3zmA0zEnymG TQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ntnpgdagk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 13:53:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31KDrdZi002223
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 13:53:39 GMT
Received: from [10.216.11.20] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Feb
 2023 05:53:30 -0800
Message-ID: <fb576665-7983-d09a-06a6-bfde5793816e@quicinc.com>
Date:   Mon, 20 Feb 2023 19:23:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V2 5/6] arm64: dts: qcom: ipq9574: Add RPM related nodes
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_ipkumar@quicinc.com>
References: <20230217142030.16012-1-quic_devipriy@quicinc.com>
 <20230217142030.16012-6-quic_devipriy@quicinc.com>
 <12d23d88-6f42-09ea-3f26-e1b7a0878767@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <12d23d88-6f42-09ea-3f26-e1b7a0878767@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aMljqqO3tcUTdf-tK7utapdcpnnWYECN
X-Proofpoint-GUID: aMljqqO3tcUTdf-tK7utapdcpnnWYECN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_11,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=878 adultscore=0 spamscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200126
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

Thanks for taking time to review the patch!

On 2/17/2023 8:20 PM, Konrad Dybcio wrote:
> 
> 
> On 17.02.2023 15:20, Devi Priya wrote:
>> Add RPM Glink, RPM message RAM and SMPA1 regulator
>> nodes to support frequency scaling on IPQ9574
>>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   Changes in V2:
>> 	- Splitted the RPM and CPU Freq changes to individual patches
>> 	- Moved the regulators node to Board DT
>> 	- Dropped the regulator-always-on property
>> 	- Updated the compatible in regulators node with the existing
>> 	  mp5496 compatible
>>
>>   arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts | 11 +++++++++++
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi        | 17 +++++++++++++++++
>>   2 files changed, 28 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>> index 21b53f34ce84..8a6caaeb0c4b 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>> @@ -57,6 +57,17 @@
>>   	status = "okay";
>>   };
>>   
>> +&rpm_requests {
>> +	regulators {
>> +		compatible = "qcom,rpm-mp5496-regulators";
>> +
>> +		ipq9574_s1: s1 {
>> +			regulator-min-microvolt = <587500>;
>> +			regulator-max-microvolt = <1075000>;
>> +		};
>> +	};
>> +};
> This belongs in a separate patch.
> 
Do you recommend to move this change to the below patch in the next spin?
[PATCH V2 6/6]arm64: dts: qcom: ipq9574: Add cpufreq support
>> +
>>   &sdhc_1 {
>>   	pinctrl-0 = <&sdc_default_state>;
>>   	pinctrl-names = "default";
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> index d20f3c7383f5..2f300cbab93e 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> @@ -133,6 +133,11 @@
>>   		#size-cells = <2>;
>>   		ranges;
>>   
>> +		rpm_msg_ram: rpm@60000 {
> Since this is a part of the MMIO region and not a part of DRAM,
> we generally put this node under /soc with the compatible of
> qcom,rpm-msg-ram and without no-map.
> 
> And the node name then should be sram@.
Sure, okay. Will update this in V3
> 
>> +			reg = <0x0 0x00060000 0x0 0x6000>;
>> +			no-map;
>> +		};
>> +
>>   		tz_region: tz@4a600000 {
>>   			reg = <0x0 0x4a600000 0x0 0x400000>;
>>   			no-map;
>> @@ -768,6 +773,18 @@
>>   		};
>>   	};
>>   
>> +	rpm-glink {
> Alphabetically this should come before /soc.
Okay
> 
> Konrad
>> +		compatible = "qcom,glink-rpm";
>> +		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
>> +		qcom,rpm-msg-ram = <&rpm_msg_ram>;
>> +		mboxes = <&apcs_glb 0>;
>> +
>> +		rpm_requests: glink-channel {
>> +			compatible = "qcom,rpm-ipq9574";
>> +			qcom,glink-channels = "rpm_requests";
>> +		};
>> +	};
>> +
>>   	timer {
>>   		compatible = "arm,armv8-timer";
>>   		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
Best Regards,
Devi Priya
