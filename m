Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD126DA84F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 06:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbjDGEl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 00:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjDGElz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 00:41:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330219038;
        Thu,  6 Apr 2023 21:41:53 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3373Gt9S032501;
        Fri, 7 Apr 2023 04:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SHuMBtrEPaVhDQrWmSafzoeJPUJiJhAiORidzeGh2zo=;
 b=FzBqz9/zzEG4CEEujvMITWUHakswWWPMzsy1gm6e9vjWWzM0ISiT323DqznQfKc8lRc8
 o9kT9Pdd0gdgnMt6ahgeAI6PfkZ9ZBhkHifXfGiCEKF9mxbK2I/4VPF8GDXvgI1lHGLv
 hOb8n7F4Wl768RQ2NnyEPI7B5jNHOA1y+4MdkdQgubAKP1l4cLfZBuUuv0qSjlLHGuVH
 cieQ0JyMff+pWO8NOrdqgz/58lLuo6DBgizg+BNDzMt4ZeeuNOnmcEc3qhb/xG1b28Ma
 hTH8qu3+MboRz/ax1qmCCdecpeRxRAFd4O0zJ81ZW/hZAxRldLCKvU0uEwvl6gSwwOmn +w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3psr262r7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 04:41:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3374fm5h014792
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Apr 2023 04:41:48 GMT
Received: from [10.216.18.47] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 6 Apr 2023
 21:41:42 -0700
Message-ID: <0d61dfc8-27dc-2a69-c85d-7a4de17dd269@quicinc.com>
Date:   Fri, 7 Apr 2023 10:11:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V3 4/5] arm64: dts: qcom: ipq9574: Add SMPA1 regulator
 node
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
References: <20230406070032.22243-1-quic_devipriy@quicinc.com>
 <20230406070032.22243-5-quic_devipriy@quicinc.com>
 <8522a34c-de77-444b-159b-5b8732b52a9e@linaro.org>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <8522a34c-de77-444b-159b-5b8732b52a9e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GWlai3eeRGKr6B_vdagCHA1L4or6JfrI
X-Proofpoint-ORIG-GUID: GWlai3eeRGKr6B_vdagCHA1L4or6JfrI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_02,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070043
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/2023 1:17 AM, Konrad Dybcio wrote:
> 
> 
> On 6.04.2023 09:00, Devi Priya wrote:
>> Add support for SMPA1 regulator node in IPQ9574.
>>
>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   Changes in V3:
>> 	- Updated the regulator-min-microvolt with the SVS voltage 725000uV
>>
>>   arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> index 3ae38cf327ea..06f579b1c590 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> @@ -44,6 +44,25 @@
>>   	};
>>   };
>>   
>> +&rpm_requests {
>> +	regulators {
>> +		compatible = "qcom,rpm-mp5496-regulators";
>> +
>> +		ipq9574_s1: s1 {
>> +		/*
>> +		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
>> +		 * During regulator registration, kernel not knowing the initial voltage,
>> +		 * considers it as zero and brings up the regulators with minimum supported voltage.
> 
>> +		 * Updating the regulator-min-microvolt with SVS voltage of 725000uV so that
> s/Updating/Update
> s/725000uV/725mV here and below (for consistency with the first mention
> of 800mV)
> 
Sure, will update!
> Konrad
>> +		 * the regulators are brought up with 725000uV which is sufficient for all the
>> +		 * corner parts to operate at 800MHz
>> +		 */
>> +			regulator-min-microvolt = <725000>;
>> +			regulator-max-microvolt = <1075000>;
>> +		};
>> +	};
>> +};
>> +
>>   &pcie1_phy {
>>   	status = "okay";
>>   };
