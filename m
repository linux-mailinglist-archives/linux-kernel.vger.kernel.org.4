Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A3C717979
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbjEaIDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbjEaIDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:03:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD411C5;
        Wed, 31 May 2023 01:03:41 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V4bmxB008944;
        Wed, 31 May 2023 08:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FE/xNyfXngUE6RIpgQf/LdhPjnunaGuWMjkUuo9lnDY=;
 b=gNJYbFDq+nspv5a14z4rPXbYa8ahwLbGCKF3zhMEogdnWqU8IlwsHrFq2lByE0vE+wFT
 205+DiU07xh/7doJiC45l12eZEi0/OkPKUtQ0gsp95sGKRnDMurVMV/zZTZ87RKWAOYg
 U4qhftOR8DVla7LMZkeO84SqVeWeJ/VC/vkjSz+ZCgk5zpbhLGSLCb/zc3284JAvIlX9
 ZxnnA7+QB2lw2nMl5hXGuIks3RM8S8/wM8L12fX8jZ8/eLaNBDXIwcTl0hbqd76weVn4
 i/Bs685Ap9Mo4hnaY9/PsQwePV3BQgpfrMqhyGFo9zJ7pODzof951F/0GKZqtsN8vtra 9A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qwnhf1ft6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 08:03:38 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34V83ZTf016320
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 08:03:35 GMT
Received: from [10.201.206.212] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 31 May
 2023 01:03:31 -0700
Message-ID: <e1ea1f6c-ea13-0766-b946-accb801c9f84@quicinc.com>
Date:   Wed, 31 May 2023 13:33:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] arm64: dts: qcom: ipq5332: enable GPIO based LEDs and
 Buttons
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230531065619.9181-1-quic_sridsn@quicinc.com>
 <20230531065619.9181-2-quic_sridsn@quicinc.com>
 <46639d7e-95ed-35a6-a9ab-d802af4470ce@linaro.org>
From:   Sridharan S N <quic_sridsn@quicinc.com>
In-Reply-To: <46639d7e-95ed-35a6-a9ab-d802af4470ce@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5B4Kth4L8JgA9ZvqYtCFchd2pROSvHKo
X-Proofpoint-GUID: 5B4Kth4L8JgA9ZvqYtCFchd2pROSvHKo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_04,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=892 mlxscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 clxscore=1011
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305310070
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/31/2023 12:45 PM, Krzysztof Kozlowski wrote:
> On 31/05/2023 08:56, Sridharan S N wrote:
>> Add support for wlan-2g LED on GPIO 36 and wps buttons on GPIO 35.
>>
>> Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts | 43 +++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts | 43 +++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts | 43 +++++++++++++++++++++
>>   3 files changed, 129 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts b/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
>> index 3af1d5556950..ba733b6cab06 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
>> @@ -7,6 +7,8 @@
>>   
>>   /dts-v1/;
>>   
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>>   #include "ipq5332.dtsi"
>>   
>>   / {
>> @@ -20,6 +22,33 @@
>>   	chosen {
>>   		stdout-path = "serial0";
>>   	};
>> +
>> +	gpio_keys {
> No underscores in node names.
Will address it in V2
>
>> +		compatible = "gpio-keys";
>> +		pinctrl-0 = <&gpio_keys_default>;
>> +		pinctrl-names = "default";
>> +		status = "okay";
> It's by default, why do you need it?
Will address it in V2
>
>
>
> Best regards,
> Krzysztof
>
