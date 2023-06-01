Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563B8719C9A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjFAMwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjFAMwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:52:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F07D123;
        Thu,  1 Jun 2023 05:52:14 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35157lhU005135;
        Thu, 1 Jun 2023 12:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=a2vHoLo4nXwBfvsNLu+0pjcRYz50PyEOUYJXc0Ctxz4=;
 b=WNJqhzeGPOvvJSWuHcTFLSA/fnFSSROg2XYXuu4JXB8tK+roD/WU/BS2Psn0mGslAr+x
 JSOjM+oX6jq6/jLgt9AgCXweIKqErRpGpBLIMBUyGHEg1CE/XROzeSbdja5z0C2Lba0l
 +FdllnNypUaH+j2CItfuIbKnqeDnimXH9viIT0lFaSjSIg0+q7dxYpV3iAvtR8ZcEKGN
 LG5LGTgwtnUae13Gwk56OTOvE3+chKrx85Q+eoPGnqyb4rPJGZZvFnRmliNBAYmWe+Uj
 Rmx8knzUhcwLQ1o8P2kYaotG4nmFy6kq6dVKVi9cJ4QnaLgW/pK76ElGRCTaowiQS2c5 Ig== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxjk2sd38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 12:52:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351Cq8lh021539
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 12:52:08 GMT
Received: from [10.50.0.39] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 05:52:03 -0700
Message-ID: <d726e36d-8a43-7605-9afa-fde3845e1b19@quicinc.com>
Date:   Thu, 1 Jun 2023 18:21:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] arm64: dts: qcom: ipq6018: correct the qrng node name
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230526161138.25497-1-quic_kathirav@quicinc.com>
 <fdfc568e-703e-6e74-953e-742c00f0b5fe@linaro.org>
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <fdfc568e-703e-6e74-953e-742c00f0b5fe@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jq_ZvkrXmh4i72NUDpPwMSPGdLIEn7rI
X-Proofpoint-ORIG-GUID: jq_ZvkrXmh4i72NUDpPwMSPGdLIEn7rI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=630 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010114
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/30/2023 8:14 PM, Krzysztof Kozlowski wrote:
> On 26/05/2023 18:11, Kathiravan T wrote:
>> qrng node address is mentioned incorrectly. Lets fix it.
>>
>> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
>> Note: Only compilation and dtbs_check is checked. Also dependent on the
>> below series, no functional dependencies
>> https://lore.kernel.org/linux-arm-msm/20230526125305.19626-1-quic_kathirav@quicinc.com/T/#t
>>
>>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> index 0f6d6c6daed2..5d2cc0caf5a1 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> @@ -309,7 +309,7 @@
>>   			#size-cells = <1>;
>>   		};
>>   
>> -		prng: qrng@e1000 {
>> +		prng: qrng@e3000 {
> This was fixed some time ago:
>
> https://lore.kernel.org/all/20230419211856.79332-1-krzysztof.kozlowski@linaro.org/


Thanks, I didn't notice your patch.


>
> Best regards,
> Krzysztof
>
