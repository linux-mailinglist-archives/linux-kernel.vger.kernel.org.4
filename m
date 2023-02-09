Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB6A690C5F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjBIPFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjBIPE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:04:58 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106DFA0;
        Thu,  9 Feb 2023 07:04:56 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319EMrni002521;
        Thu, 9 Feb 2023 15:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9OrKmkk6BmbTqQW2DCd0q4+FOwIdncIiQkk33tlnuXw=;
 b=bUm6J208ufuJZE9Mwi5omEKy3z1z/jSH+BjCqfTFgbxb+HWiJUHBBrrH1L70TVKxREmG
 vMnYbF7ae9zaSOUbzhwl+Y1yuprURgb8OMRRkSzoTcWlIc7aZAXpas1OriERwPL4plMq
 FJAMoRfg5yFrt8eW3iHxSEnh/oeBZhuWI7vqUHfm1Jw6fw/yRB1YJjov6rbwOuePItcd
 LAMjEt025vVN2qZkSi3uELl59MkdkRWnTMSFuNRTWhgQpObIqwE0hDpqkmGkxd4mSZAc
 9aoA54aE7SocArN16mUpQSTcpKdjqa7rzM4XkaVk/LmMBdhyabmLMMVbEadRwLDGaEZM Ww== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nmww6rrqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 15:04:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 319F4mgC003296
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Feb 2023 15:04:48 GMT
Received: from [10.50.42.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 07:04:45 -0800
Message-ID: <f2ed9599-7d3a-600c-99f7-04f9962673f7@quicinc.com>
Date:   Thu, 9 Feb 2023 20:34:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/3] arm64: dts: qcom: ipq5332: enable the download mode
 support
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <agross@kernel.org>, <konrad.dybcio@linaro.org>, <lee@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230130170155.27266-1-quic_kathirav@quicinc.com>
 <20230130170155.27266-3-quic_kathirav@quicinc.com>
 <20230208233650.fcgsfyz6aegjsing@ripper>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <20230208233650.fcgsfyz6aegjsing@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Psx2jcO9VQARf1_WIXj77q6gujy0EuHF
X-Proofpoint-ORIG-GUID: Psx2jcO9VQARf1_WIXj77q6gujy0EuHF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_10,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 mlxlogscore=922
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090143
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/9/2023 5:06 AM, Bjorn Andersson wrote:
> On Mon, Jan 30, 2023 at 10:31:54PM +0530, Kathiravan T wrote:
>> Enable the support for download mode to collect the RAM dumps if
>> system crashes, to perform the post mortem analysis.
>>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> index 7f0ba2ec339c..6a1d0cc927ef 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> @@ -70,6 +70,7 @@
>>   	firmware {
>>   		scm {
>>   			compatible = "qcom,scm-ipq5332", "qcom,scm";
>> +			qcom,dload-mode = <&tcsr 0x0>;
>>   		};
>>   	};
>>   
>> @@ -142,6 +143,11 @@
>>   				 <0>;
>>   		};
>>   
>> +		tcsr: syscon@193d100 {
>> +			compatible = "qcom,tcsr-ipq5332", "syscon";
>> +			reg = <0x0193d100 0x4>;
> Please map the entire TCSR_REGS here, and use qcom,dload-mode to encode
> the offset within this.


Sure, will fix it in V2.


>
> Thanks,
> Bjorn
>
>> +		};
>> +
>>   		sdhc: mmc@7804000 {
>>   			compatible = "qcom,ipq5332-sdhci", "qcom,sdhci-msm-v5";
>>   			reg = <0x07804000 0x1000>, <0x07805000 0x1000>;
>> -- 
>> 2.17.1
>>
