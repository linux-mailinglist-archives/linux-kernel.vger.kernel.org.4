Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD80712491
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 12:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242844AbjEZKZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 06:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242816AbjEZKY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 06:24:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E699134;
        Fri, 26 May 2023 03:24:54 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q8q9oD019816;
        Fri, 26 May 2023 10:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tY2p0Kk1cG8WtbdC89HRJ3XFuoN21IGPNtPYuX7csSU=;
 b=NtGiERDndU2KiG4PbyYThx9CcF7QtUZeesUKA4xl+7LGgUOCk++4cgMblrI3p4kbzfVF
 LmlwYsxIJ9i5X+rGgHH6gcTCrd2Ux1rXlSk4rvdDdu75Ccp4zcDnWe3NuQZrcba9sqnr
 pFhe00HcctLBtEtxukT88Q9Tc19sAXkd/Snd7bCOnurzeQWKkz7N7uFv9mEXQ99JD5EB
 5o++jm8RRKG4WqoSlrBw2zjvRoEaKoOfvFgvEF/7ilNWMfCbzeFjpzNB/bKImBIPlnz7
 6HDsFPnChKgdnucamdUjitvn9zjTVFhktzPym439k+kNKeSBaIy9C2RHWxYEaxYaWt+8 4Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qtrev8acq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 10:24:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QAOnxR022028
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 10:24:49 GMT
Received: from [10.201.192.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 26 May
 2023 03:24:46 -0700
Message-ID: <bf0cef36-8286-df96-8c58-82aa6d1a02ad@quicinc.com>
Date:   Fri, 26 May 2023 15:54:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/4] arm64: dts: qcom: ipq5332: add QFPROM node
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
 <20230526070421.25406-3-quic_kathirav@quicinc.com>
 <55200328-735d-6571-fcad-735cc9d1568b@linaro.org>
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <55200328-735d-6571-fcad-735cc9d1568b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: u6jptsCANb8nvBZstZSiiZN_9Kwi1AX7
X-Proofpoint-GUID: u6jptsCANb8nvBZstZSiiZN_9Kwi1AX7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=986
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260089
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/26/2023 2:49 PM, Konrad Dybcio wrote:
>
> On 26.05.2023 09:04, Kathiravan T wrote:
>> IPQ5332 has efuse region to determine the various HW quirks. Lets
>> add the initial support and the individual fuses will be added as they
>> are required.
>>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> index af4d97143bcf..c2d6cc65a323 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> @@ -135,6 +135,13 @@
>>   		#size-cells = <1>;
>>   		ranges = <0 0 0 0xffffffff>;
>>   
>> +		qfprom: efuse@a4000 {
>> +			compatible = "qcom,ipq5332-qfprom", "qcom,qfprom";
>> +			reg = <0x000a4000 0x721>;
> That's an odd size. Are you sure this is how long the corrected region is?


Yes, As per the HW document, this is the size.


>
> Konrad
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +		};
>> +
>>   		rng: rng@e3000 {
>>   			compatible = "qcom,prng-ee";
>>   			reg = <0x000e3000 0x1000>;
