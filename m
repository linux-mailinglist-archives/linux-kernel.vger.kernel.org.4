Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A989363A104
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 06:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiK1F6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 00:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiK1F6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 00:58:04 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D458462D0;
        Sun, 27 Nov 2022 21:58:03 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AS5q49p021247;
        Mon, 28 Nov 2022 05:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=y5/ncHheL1o1gobhmEVQuzWuUcGwoYEQWC5+lWTUqwU=;
 b=IokTAgjnV4yNaOV6RJFvXL0itoheGd6+YfFdngFuDF8Gj/e9xkwjhnWZCfJkIz9Z07ys
 bceGMY5Q8LNX2hmTN99XqJpG6T9pwG5Bz74jSMwcZimm0TOZLJPTF31ORQ1KmPix995c
 qa3b9rFSCCQCNyogN7/hmLwnAQ1Uhirf3vkVd3YU7TeOnMYrf1U8Arkq1sZ9zaMF2ZSI
 Fmsqt5xmoZ0XUz+RnmShl+/7Q65AVIuc7d6kFfnVLPT0Y9pBFzNfKJ2ueyMDnbFfghX5
 yFEjAWQL0AXnIrlD47L1pxmrcoBs3Anbel4Q8sKe7raMD476P797PXqH7Kkvem4E4DHR 7Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m38gq39qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 05:57:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AS5vnvD022578
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 05:57:49 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 27 Nov
 2022 21:57:45 -0800
Message-ID: <7b6ffbb4-80fb-610a-c839-e3bf1668d4ed@quicinc.com>
Date:   Mon, 28 Nov 2022 11:27:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V5 1/2] dt-bindings: firmware: qcom-scm: Add optional
 interrupt
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <quic_rjendra@quicinc.com>
References: <20221123204615.25358-1-quic_sibis@quicinc.com>
 <20221123204615.25358-2-quic_sibis@quicinc.com>
 <3cda9005-d7a5-56f0-d1d2-fd6c1cb36fc3@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <3cda9005-d7a5-56f0-d1d2-fd6c1cb36fc3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SCeeMyhlpibqW61-ummGvW7yrK3HfJnq
X-Proofpoint-ORIG-GUID: SCeeMyhlpibqW61-ummGvW7yrK3HfJnq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_04,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211280046
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Krzysztof,

Thanks for taking time to review the series.

On 11/24/22 16:43, Krzysztof Kozlowski wrote:
> On 23/11/2022 21:46, Sibi Sankar wrote:
>> From: Guru Das Srinagesh <quic_gurus@quicinc.com>
>>
>> Add an interrupt specification to the bindings to support the wait-queue
>> feature.
> 
> Subject - this is qcom,scm, not qcom-scm.

ack

> 
> 
>>
>> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>
>> v5:
>> - Pick up R-b
>>
>> v4:
>> - Qualify bindings [Krzysztoff]
>>
>>   Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> index 25688571ee7c..aea6e0c86a89 100644
>> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> @@ -73,6 +73,12 @@ properties:
>>     '#reset-cells':
>>       const: 1
>>   
>> +  interrupts:
>> +    description:
>> +      The wait-queue interrupt that firmware raises as part of handshake
>> +      protocol to handle sleeping SCM calls.
>> +    maxItems: 1
> 
> Which devices have interrupts?
> 
> We talked about it here:
> https://lore.kernel.org/all/2464d90f-64e9-5e3c-404b-10394c3bc302@quicinc.com/
> and here:
> https://lore.kernel.org/all/c20edd0d-7613-5683-60e7-54317cac6e0b@linaro.org/
> 
> But I still don't get which devices support it and which do not.

lol, I thought we reached a consensus earlier because of the "ok" and
R-b. Like I explained earlier the bootloader would be adding interrupt
on the fly, wouldn't such cases cause binding check failure if we list
all the devices supporting it? Also some of the SM8450 devices in the
wild would be running firmware not having the feature but I guess
eventually most of the them will end up supporting the feature in the
end.

> 
> 
> BTW: > 
https://lore.kernel.org/all/20221122092345.44369-2-krzysztof.kozlowski@linaro.org/

Yup had a look at ^^, IIRC there are additional SoCs that can have the
interconnects specified in their device tree.

> 
> 
> Best regards,
> Krzysztof
> 
