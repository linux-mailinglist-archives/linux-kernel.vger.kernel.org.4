Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFF16B781F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjCMM43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjCMM4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:56:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5A7664C7;
        Mon, 13 Mar 2023 05:56:23 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DBBCGZ019475;
        Mon, 13 Mar 2023 12:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uGlf6UJeXzxaum40kVyYfLhOaD7KSGqofEz/PO0SxI4=;
 b=QJirBTkY3Y9knKdrsIFxhaHxrqWM/IblLR3cWG+k8pfoIqaVZPwXOEoJTclGnH9CUbgy
 MHdxfPsK7cHEr/JBS2JomM/N8CjQDqsrRjdhRHnkDhTiQa6s7OHBoipncV4qGa4SzENP
 iet4BefXftpjlaI/a2h3USmrSA547xrEzxZdvhZlr6BcGAI19S0dkkVaXqQUfbR5sMMG
 9FcAWuS7SANllRMOBobMQsIp8Yo/sqWmvkcZq3AbBNpcsLPnUVkr0LXdR1GxEoLqzPdR
 flB6qU7qskp/HEOCgeE2MWaO4+LZKidUGONJgcwrO3tdKJ/ylly/O6l0rn6kz7JLInYB qw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p8jtwvv2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 12:56:18 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32DCuHc1028773
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 12:56:17 GMT
Received: from [10.216.8.170] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 13 Mar
 2023 05:56:15 -0700
Message-ID: <185de2d5-8d5d-4991-1157-f30799b5f963@quicinc.com>
Date:   Mon, 13 Mar 2023 18:26:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] arm64: dts: qcom: qdu1000: Add
 LLCC/system-cache-controller node
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230313071757.31533-1-quic_kbajaj@quicinc.com>
 <5441450e-be39-1033-b3d5-c3eb10950d34@linaro.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <5441450e-be39-1033-b3d5-c3eb10950d34@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: almB87FFgTgc6KuU97HdPvtUR-6AI8OQ
X-Proofpoint-GUID: almB87FFgTgc6KuU97HdPvtUR-6AI8OQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_05,2023-03-13_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130105
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/13/2023 2:02 PM, Konrad Dybcio wrote:
>
> On 13.03.2023 08:17, Komal Bajaj wrote:
>> Add a DT node for Last level cache (aka. system cache) controller
>> which provides control over the last level cache present on QDU1000
>> and QRU1000 SoCs.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qdu1000.dtsi | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> index 801f090335a3..a4816a862344 100644
>> --- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> @@ -1321,6 +1321,16 @@ gem_noc: interconnect@19100000 {
>>   			qcom,bcm-voters = <&apps_bcm_voter>;
>>   			#interconnect-cells = <2>;
>>   		};
>> +
>> +		system-cache-controller@19200000 {
>> +			compatible = "qcom,qdu1000-llcc";
>> +			reg = <0 0x19200000 0 0xd80000>,
>> +			      <0 0x1a200000 0 0x80000>,
>> +			      <0 0x221c8128 0 0x4>;
>> +			reg-names = "llcc_base", "llcc_broadcast_base", "multi_channel_register";
> Please turn this into a vertical list, like you did with reg
>
>> +			multi-ch-bit-off = <24 2>;
> driver-specific properties generally go after the generic ones,
> so swap this one with interrupts
>
> Konrad

Thanks for your comments, will address these in the next version.

Thanks,
Komal

>> +			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
>> +		};
>>   	};
>>   
>>   	arch_timer: timer {

