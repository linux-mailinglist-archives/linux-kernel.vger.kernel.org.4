Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD34712482
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 12:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242742AbjEZKWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 06:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjEZKWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 06:22:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B17FB;
        Fri, 26 May 2023 03:22:33 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q54I14015529;
        Fri, 26 May 2023 10:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BCZdJLgyzoUWtckTjzKVsODsMMoSqMvXbxJUDyuiLSw=;
 b=bhnMpU41mPa3jL6ldREepaQ05fRssxDlw5bsXNA9LPm9CKrHYaUPcwLNClWVt08BAahu
 jjWrOYuLSbXMYDQOflOkD/0U3T6P5iiMSf523XYdqteZbYVov59XP9jy4vcbv41XhVjQ
 4COe2qiTT/ZdTRNWD3PV8fUVmlsOS2qbZPE69t7yNGK0yzlcpRofq96tWdqXoW6Cvv+5
 0enxVCDJMUV3AcUlW9ReyVmf3wHDDQZ+IfogMFnghqYN1Ce9REkmqpaYYMzoTcW8Ux80
 tLg6qVnKNbQwfPvc2zvgl36LFNVcBrTQMuI/BcwA8XjGKPVaW4af5VQJZurH9jds2uOZ ZQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qt47etugw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 10:22:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QAMTuX018835
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 10:22:29 GMT
Received: from [10.201.192.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 26 May
 2023 03:22:25 -0700
Message-ID: <c546d126-3a20-4682-28da-ae401caefab0@quicinc.com>
Date:   Fri, 26 May 2023 15:52:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 3/4] arm64: dts: qcom: ipq6018: add QFPROM node
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230526070421.25406-1-quic_kathirav@quicinc.com>
 <20230526070421.25406-4-quic_kathirav@quicinc.com>
 <4e226295-e19f-9518-6dda-7f96665ada65@linaro.org>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <4e226295-e19f-9518-6dda-7f96665ada65@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0KSHUQDbgrPKNQlRESLYKm2w4lsFw1Pf
X-Proofpoint-ORIG-GUID: 0KSHUQDbgrPKNQlRESLYKm2w4lsFw1Pf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=874 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260089
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/26/2023 2:54 PM, Konrad Dybcio wrote:
>
> On 26.05.2023 09:04, Kathiravan T wrote:
>> IPQ6018 has efuse region to determine the various HW quirks. Lets
>> add the initial support and the individual fuses will be added as they
>> are required.
>>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> index f531797f2619..856879fd0207 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> @@ -206,6 +206,13 @@
>>   		dma-ranges;
>>   		compatible = "simple-bus";
>>   
>> +		qfprom: efuse@a4000 {
> This should be a bit lower down (0xa4000 > 0x59000)


Sorry, missed this. Will address in V2.


>
> Konrad
>> +			compatible = "qcom,ipq6018-qfprom", "qcom,qfprom";
>> +			reg = <0x0 0x000a4000 0x0 0x2000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +		};
>> +
>>   		qusb_phy_1: qusb@59000 {
>>   			compatible = "qcom,ipq6018-qusb2-phy";
>>   			reg = <0x0 0x00059000 0x0 0x180>;
