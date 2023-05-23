Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84AC70DE0C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbjEWNyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbjEWNyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:54:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1618C4;
        Tue, 23 May 2023 06:53:59 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NDra7S023638;
        Tue, 23 May 2023 13:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6Bf6Nab4P0ZIFTKoqEbVsOz1YX/KfvGrMuZiQWpcNZI=;
 b=Le/vmLSGhclJyNQkTpxKcpsVmrQ2csLPWkaSv0lXpIX0z9ii+DsI2jQDJBhkeY9VGCR3
 f9jf8YAOGu2gZXntSJIiZItnlZ5vdcKBaUh3f5QBHPPknajltv8JGXz31yxHMvJQeT8F
 /01JpwwVu5iPXMDcXY+NbQWeZqH+itVkFe83gcoWEbVa04QYmR6juUD2toK14UcRoORf
 H5iEuRPVAFxP/wiYT9vJGbrke6FnDKZMgymiNHlLhWQfEbtPtZuLWgAn4XbkAH39IRHZ
 icLoU4FY9yzukMYE8JkdQStgZnfGs7vN0Ejqkgk4hseRdeVJfDOz4wccBCOfr0K7vnsv DA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qrc38ab1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 13:53:54 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34NDrr1S018460
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 13:53:53 GMT
Received: from [10.216.34.130] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 23 May
 2023 06:53:47 -0700
Message-ID: <751606e3-99e0-9384-d749-605281922f94@quicinc.com>
Date:   Tue, 23 May 2023 19:23:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 2/4] arm: dts: qcom: qdu1000: Add SDHCI node
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20230522093620.3568-1-quic_kbajaj@quicinc.com>
 <20230522093620.3568-3-quic_kbajaj@quicinc.com>
 <20230522150105.3i7zeucna7kh5waz@ripper>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <20230522150105.3i7zeucna7kh5waz@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FwMmEkTCTLcmp3t6soYrlNWyI-HAuFT3
X-Proofpoint-ORIG-GUID: FwMmEkTCTLcmp3t6soYrlNWyI-HAuFT3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_09,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230108
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/2023 8:31 PM, Bjorn Andersson wrote:
> On Mon, May 22, 2023 at 03:06:18PM +0530, Komal Bajaj wrote:
>
> Path says arch/arm64/, so $subject should start "arm64: dts: qcom: ..."
>
>> Add sdhc node for eMMC on QDU1000 and QRU1000 SoCs.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qdu1000.dtsi | 51 +++++++++++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> index 734438113bba..38ee7115a35f 100644
>> --- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> @@ -19,6 +19,10 @@
>>   
>>   	chosen: chosen { };
>>   
>> +	aliases {
>> +		mmc0 = &sdhc_1; /* eMMC */
> Don't we just have a single SDC instance on this platform? If so you
> don't need aliases.
Sure, will remove aliases.
>
>> +	};
>> +
>>   	cpus {
>>   		#address-cells = <2>;
>>   		#size-cells = <0>;
>> @@ -842,6 +846,53 @@
>>   			#hwlock-cells = <1>;
>>   		};
>>   
>> +		sdhc_1: mmc@8804000 {
> And you can skip the "_1" suffix...
Sure

Thanks
Komal
>
> Regards,
> Bjorn
>
>> +			compatible = "qcom,qdu1000-sdhci", "qcom,sdhci-msm-v5";
>> +			reg = <0x0 0x08804000 0x0 0x1000>,
>> +			      <0x0 0x08805000 0x0 0x1000>;
>> +			reg-names = "hc", "cqhci";
>> +
>> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "hc_irq", "pwr_irq";
>> +
>> +			clocks = <&gcc GCC_SDCC5_AHB_CLK>,
>> +				 <&gcc GCC_SDCC5_APPS_CLK>,
>> +				 <&rpmhcc RPMH_CXO_CLK>;
>> +			clock-names = "iface",
>> +				      "core",
>> +				      "xo";
>> +
>> +			resets = <&gcc GCC_SDCC5_BCR>;
>> +
>> +			interconnects = <&system_noc MASTER_SDCC_1 0 &mc_virt SLAVE_EBI1 0>,
>> +					<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_SDCC_2 0>;
>> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
>> +			power-domains = <&rpmhpd QDU1000_CX>;
>> +			operating-points-v2 = <&sdhc1_opp_table>;
>> +
>> +			iommus = <&apps_smmu 0x80 0x0>;
>> +			dma-coherent;
>> +
>> +			bus-width = <8>;
>> +
>> +			qcom,dll-config = <0x0007642c>;
>> +			qcom,ddr-config = <0x80040868>;
>> +
>> +			status = "disabled";
>> +
>> +			sdhc1_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				opp-384000000 {
>> +					opp-hz = /bits/ 64 <384000000>;
>> +					required-opps = <&rpmhpd_opp_nom>;
>> +					opp-peak-kBps = <6528000 1652800>;
>> +					opp-avg-kBps = <400000 0>;
>> +				};
>> +			};
>> +		};
>> +
>>   		pdc: interrupt-controller@b220000 {
>>   			compatible = "qcom,qdu1000-pdc", "qcom,pdc";
>>   			reg = <0x0 0xb220000 0x0 0x30000>, <0x0 0x174000f0 0x0 0x64>;
>> -- 
>> 2.17.1
>>

