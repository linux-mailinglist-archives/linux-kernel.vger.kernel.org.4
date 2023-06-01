Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BCC7193A4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjFAG40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjFAG4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:56:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E2CE7;
        Wed, 31 May 2023 23:56:23 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35156atg017482;
        Thu, 1 Jun 2023 06:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EJw5QADUPjJuj2wXC9AhNvugGkQHL3LzGSbRUneTASE=;
 b=UrZZTHZqYPYmLus7PzRAhyX+OONIjBwzTPDAJRaCdLi5f+rAieU67BvsrZLVEcTa/z9T
 akKj906Bty/wheI4gpgFPmsvCnWHwvOabbeVIohYKCUu3PpwlRx4ZaAI+kezBVFi0N3W
 f/tcfon9suyGTwxXX9a3pt5Tf4MH6jA9MdiWKEsWsvdWbXFMp4u0sUol3dcQgwhmsEvC
 ISSqkXoUxkfflb40Ix7F9/i/6zdj3L8wETIwzG2ULStA1nehTbfnxkcwR17pYPcV1OSO
 kHtYlYTM1JI2LAa5O0wbAo2a58+n+sZtkJh596Qg3roIAAVq0mnMlFddW8PLLkXIosxL zw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qx39d2jt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 06:56:19 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3516uITw021981
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 06:56:18 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 31 May
 2023 23:56:14 -0700
Message-ID: <37903a41-cee6-3ae6-9a98-4482942c0b50@quicinc.com>
Date:   Thu, 1 Jun 2023 12:26:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 2/4] arm: dts: qcom: qdu1000: Add SDHCI node
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
References: <20230523135733.3852-1-quic_kbajaj@quicinc.com>
 <20230523135733.3852-3-quic_kbajaj@quicinc.com>
 <20230525042709.czmuxdbshsneskrs@ripper>
Content-Language: en-US
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <20230525042709.czmuxdbshsneskrs@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ix3TS8HD0uRBxpGDGz3tTw9bTLL_ZTvu
X-Proofpoint-ORIG-GUID: ix3TS8HD0uRBxpGDGz3tTw9bTLL_ZTvu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_04,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 mlxscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010061
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/25/2023 9:57 AM, Bjorn Andersson wrote:
> On Tue, May 23, 2023 at 07:27:31PM +0530, Komal Bajaj wrote:
>> Add sdhc node for eMMC on QDU1000 and QRU1000 SoCs.
>>
> Please fix your $subject prefix, it should say arm64
>
> Regards,
> Bjorn

Noted.

>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qdu1000.dtsi | 47 +++++++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> index 734438113bba..6df07334f1d3 100644
>> --- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> @@ -842,6 +842,53 @@
>>   			#hwlock-cells = <1>;
>>   		};
>>
>> +		sdhc: mmc@8804000 {
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

