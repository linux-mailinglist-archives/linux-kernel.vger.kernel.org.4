Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702FD71248A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 12:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242777AbjEZKYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 06:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236752AbjEZKYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 06:24:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1036610A;
        Fri, 26 May 2023 03:24:35 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q5G3xX010009;
        Fri, 26 May 2023 10:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tJ86j8pCL7ZgEQ3Z76DQmpr0X4ZCPhxEw1z94AsghfA=;
 b=Q6YH0K36djcvKG05L+IsQxHVYLnfWEAxSu/j+LsvG/g8lSVtdW5YvA2ypxE636S79ZYn
 H9YPLfnfCGumiTi6wkhSSfJ9Y2xXHLAqpeyGOXHEBaYgMxl9pwloMcf58ocnbugOlhe9
 /bQRkIfX0BmesX0D8LnB+9RCRYECCyIgyENtK6N6PiUWmLlvKlzj/xRlXt4vECnZ4Fr+
 y+rR0PU5W+cy7IcgQyjPCRM2yYLraD/yMggGb2t2WAuAHEhw9JGPF0rcSUTxAjG/hEQ6
 svupSuVbT/ZktdVtSZFl00xem4ZUXQoDbH0JOkwa87Y2bH07M00adeLthQoNHfQYS3V5 sg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qt27n364v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 10:24:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QAOEYb026782
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 10:24:14 GMT
Received: from [10.201.192.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 26 May
 2023 03:24:11 -0700
Message-ID: <97e06f9e-81cb-45ad-5b2a-d8de52d023f0@quicinc.com>
Date:   Fri, 26 May 2023 15:54:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: ipq9574: add QFPROM node
Content-Language: en-US
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
 <20230526070421.25406-5-quic_kathirav@quicinc.com>
 <7d14db71-2279-e9b9-012d-47dc50fe797b@linaro.org>
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <7d14db71-2279-e9b9-012d-47dc50fe797b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oIRaw4UUiGDZDTEEsHnTvtIDg4mqlI8d
X-Proofpoint-GUID: oIRaw4UUiGDZDTEEsHnTvtIDg4mqlI8d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxlogscore=986 adultscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260090
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/26/2023 2:49 PM, Konrad Dybcio wrote:
>
> On 26.05.2023 09:04, Kathiravan T wrote:
>> IPQ9574 has efuse region to determine the various HW quirks. Lets
>> add the initial support and the individual fuses will be added as they
>> are required.
>>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> index 1a2c813ffd43..715fe51ff567 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> @@ -117,6 +117,13 @@
>>   		#size-cells = <1>;
>>   		ranges = <0 0 0 0xffffffff>;
>>   
>> +		qfprom: efuse@a4000 {
>> +			compatible = "qcom,ipq9574-qfprom", "qcom,qfprom";
>> +			reg = <0x000a4000 0x5a1>;
> That's an odd size. Are you sure this is how long the corrected region is?


Yes, As per the HW document, this is the size.


>
> Konrad
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +		};
>> +
>>   		tlmm: pinctrl@1000000 {
>>   			compatible = "qcom,ipq9574-tlmm";
>>   			reg = <0x01000000 0x300000>;
