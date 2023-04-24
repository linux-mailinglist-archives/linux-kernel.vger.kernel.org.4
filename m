Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE326EC9DA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjDXKKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjDXKKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:10:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3550CE4C;
        Mon, 24 Apr 2023 03:10:09 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33O7UKVn009780;
        Mon, 24 Apr 2023 10:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BPim0Tod12N/FKdGRwHfV9Vpi1oMjhR8E79fnyjeGZs=;
 b=Iy03PV3WreQrVUdQyf3KjtkMMQ3j3if+19h+4TfTm3UGblbNo2y0yzXf0YQwCiSXASg8
 ad7vgAF0uL7UGnRcYW9lzvuVyaerlU2HUqc2T45CNsEPTxAlsyKKrypGNZwUPf6l3kl5
 xupxya6yrdBToEful6h5c9i0o61kTH479EFTPVbtJdt74UBIz22zu4hyPIbmBP98Pp3z
 O/PzIZDVMqktfzE7giu0P/HdiSr9EPMn6xOuIZ5Sq+EA8CTnCAp44qZKpz+Z0weJjxa9
 XAXH/S0fI0Fkl/I74/X3JG1PcVAbpD+9rRC/SqaLVvG9yAea2nM7vEmgKsSXPD4UCQBk 5Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q48h3b0xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 10:10:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33OAA3PJ028738
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 10:10:03 GMT
Received: from [10.216.49.0] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 24 Apr
 2023 03:09:57 -0700
Message-ID: <8b99108c-b3bf-e901-b2ff-95befa6308ce@quicinc.com>
Date:   Mon, 24 Apr 2023 15:39:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 3/4] arm64: dts: qcom: ipq9574: Drop
 bias_pll_ubi_nc_clk & update intc node
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
References: <20230417053355.25691-1-quic_devipriy@quicinc.com>
 <20230417053355.25691-4-quic_devipriy@quicinc.com>
 <fa84facd-9b13-388f-5f22-a287f7aa403f@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <fa84facd-9b13-388f-5f22-a287f7aa403f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hFEYcnXYqZDlHShSQPtLwVrYmmOmb1g6
X-Proofpoint-GUID: hFEYcnXYqZDlHShSQPtLwVrYmmOmb1g6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_06,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=921 mlxscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304240090
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/2023 4:24 PM, Konrad Dybcio wrote:
> 
> 
> On 17.04.2023 07:33, Devi Priya wrote:
>> Drop the unused backup source bias_pll_ubi_nc_clk.
>> Also, update the size of GICC and GICV region to 8kB and add target CPU
>> encoding.
> These things have too big and too distant consequences to go in
> a single patch and the GIC fix should have a fixes tag.
> 
>>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 13 +++----------
>>   1 file changed, 3 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> index 3bb7435f5e7f..f1f959b43180 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> @@ -16,12 +16,6 @@
>>   	#size-cells = <2>;
>>   
>>   	clocks {
>> -		bias_pll_ubi_nc_clk: bias-pll-ubi-nc-clk {
>> -			compatible = "fixed-clock";
>> -			clock-frequency = <353000000>;
>> -			#clock-cells = <0>;
>> -		};
>> -
>>   		sleep_clk: sleep-clk {
>>   			compatible = "fixed-clock";
>>   			#clock-cells = <0>;
>> @@ -131,7 +125,6 @@
>>   			reg = <0x01800000 0x80000>;
>>   			clocks = <&xo_board_clk>,
>>   				 <&sleep_clk>,
>> -				 <&bias_pll_ubi_nc_clk>,
> NAK, this is an ABI break. If you want to drop it, you'd need
> to leave a <0> here.
Okay, Got it.

Thanks,
Devi Priya
> 
> Konrad
>>   				 <0>,
>>   				 <0>,
>>   				 <0>,
>> @@ -172,14 +165,14 @@
>>   		intc: interrupt-controller@b000000 {
>>   			compatible = "qcom,msm-qgic2";
>>   			reg = <0x0b000000 0x1000>,  /* GICD */
>> -			      <0x0b002000 0x1000>,  /* GICC */
>> +			      <0x0b002000 0x2000>,  /* GICC */
>>   			      <0x0b001000 0x1000>,  /* GICH */
>> -			      <0x0b004000 0x1000>;  /* GICV */
>> +			      <0x0b004000 0x2000>;  /* GICV */
>>   			#address-cells = <1>;
>>   			#size-cells = <1>;
>>   			interrupt-controller;
>>   			#interrupt-cells = <3>;
>> -			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>>   			ranges = <0 0x0b00c000 0x3000>;
>>   
>>   			v2m0: v2m@0 {
