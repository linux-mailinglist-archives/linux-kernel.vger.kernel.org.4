Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C8B68C03C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjBFOga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjBFOg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:36:27 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E8024C92;
        Mon,  6 Feb 2023 06:36:25 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316Bv47H017711;
        Mon, 6 Feb 2023 14:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TETDB0LeiUCmf0+tJvAW84Dy4wJip4Q7KldqyimddL8=;
 b=jmjneK2odiCS9U3rBC89UzPmUiZU8XKOXop+zUu5f4oXNMIB1LlhqoBLnA0NdhXbFF3S
 vuvBMnn5QCCpPWVSSnauE9de2A7ccgj70Xfvut2b6lIb0Ubx9Eab8CDJm0xXxbLXFgSO
 dC7jUo4wSZi8qJLq4tV+F6VJ7wzgLV7bx9qxJgoxF+inm2wSsz1V20yLnW4/I01Vjjad
 faqMJ4Vknfse+bgs2/34AVWUXskzH+mSDXBFE6ZDzGrMR6N4lsoFMhzyw/PhC1fHILmt
 INh8oh6tb6C5xn7M9V4fRXpcENLUMDqiF0JG8ZA3ijhFs0gBV8gCsNiyAuwtKxaBxCjb gA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhechby1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:36:22 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 316EaLaT016908
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Feb 2023 14:36:21 GMT
Received: from [10.216.55.169] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 06:36:17 -0800
Message-ID: <d1dc0c9b-eab2-0287-d0a2-ead44ecee5ce@quicinc.com>
Date:   Mon, 6 Feb 2023 20:06:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8450: Add IMEM and PIL info
 region
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1675443891-31709-1-git-send-email-quic_mojha@quicinc.com>
 <1675443891-31709-2-git-send-email-quic_mojha@quicinc.com>
 <cc30f686-dec7-db85-cf0d-c6c685a623ce@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <cc30f686-dec7-db85-cf0d-c6c685a623ce@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5iQp1wmX4FYfvQOq-vRbeKaEQ-GSUrc_
X-Proofpoint-ORIG-GUID: 5iQp1wmX4FYfvQOq-vRbeKaEQ-GSUrc_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=756 priorityscore=1501 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302060126
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/2023 3:07 AM, Konrad Dybcio wrote:
> 
> 
> On 3.02.2023 18:04, Mukesh Ojha wrote:
>> Add a simple-mfd representing IMEM on SM8450 and define the PIL
>> relocation info region, so that post mortem tools will be able
>> to locate the loaded remoteprocs.
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>  From XBL:
> 
> 0x14680000, 0x0002A000, "IMEM Base"
> 
> Is there anything in that wider address range that would interest
> us? I recall Alex once dug into that when diving into IPA, but
> I can not recall the conclusion..
Spec-wise, yes IPA do own these 0x146A8000 - 0x146AA000 .
But, not sure what they use it for.

-Mukesh
> 
> Konrad
>>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> index 5704750..474ea1b 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> @@ -3536,6 +3536,21 @@
>>   			};
>>   		};
>>   
>> +		sram@146aa000 {
>> +			compatible = "qcom,sm8450-imem", "syscon", "simple-mfd";
>> +			reg = <0 0x146aa000 0 0x1000>;
>> +
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +
>> +			ranges = <0 0 0x146aa000 0x1000>;
>> +
>> +			pil-reloc@94c {
>> +				compatible = "qcom,pil-reloc-info";
>> +				reg = <0x94c 0xc8>;
>> +			};
>> +		};
>> +
>>   		apps_rsc: rsc@17a00000 {
>>   			label = "apps_rsc";
>>   			compatible = "qcom,rpmh-rsc";
