Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB347025B1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbjEOHJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbjEOHJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:09:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F137E60;
        Mon, 15 May 2023 00:09:20 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34F6b2xS016937;
        Mon, 15 May 2023 07:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ezrCAq5SGgSWhAp9SRpG6vrj+OTqUnkKuCr9XJhQ4O0=;
 b=n2JK+xqZ6dIz4xdmXCxXzfZLj8zHycxo+luyV5NVXyheEBSGAx8WY7qHw4GPCG8r4hMY
 5FJMujOLpLLN6afrhe8r+K5RJ5K8MC18zTBuFTjp1Rw9bcQxxM7cxDFKInCg7BRR5dcD
 jGbUv5kfDcGoPYDgsVwqQ/Txx5KkVqAvZMn+bjYXIlinBNmRXvGB23KRzzqxty5pPsPc
 iXtpOkrZ+dLLSfScrq0Li1/K9hI99+cqBpo1SATeMiPmePwWEK2cT9t5CvIz9fbs7R7n
 MrKN4CHe8q1C/XIBpqEZt0K49CUAfXV2TQwbG3eRnjhslXF/9TUa96y543z4Z0rsIqgV WA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qj2sb3002-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 07:09:17 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34F79BNP031427
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 07:09:11 GMT
Received: from [10.214.230.142] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 15 May
 2023 00:08:34 -0700
Message-ID: <ec2f0259-9d57-7125-7df8-c773b60e8c72@quicinc.com>
Date:   Mon, 15 May 2023 12:38:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 02/10] dt-bindings: nvmem: qfprom: Add compatible for
 QDU1000/QRU1000
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
 <20230512122134.24339-3-quic_kbajaj@quicinc.com>
 <4766aabc-9b03-3241-82e3-8c4799ea7978@linaro.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <4766aabc-9b03-3241-82e3-8c4799ea7978@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: I6ESg3VsdIqBlSYt16-dXym-YIxc5fF4
X-Proofpoint-ORIG-GUID: I6ESg3VsdIqBlSYt16-dXym-YIxc5fF4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=896
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305150064
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/2023 10:26 PM, Krzysztof Kozlowski wrote:
> On 12/05/2023 14:21, Komal Bajaj wrote:
>> Document the QFPROM on QDU1000/QRU1000 SOCs.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
>> index 8d8503dd934b..59082f6e8c9f 100644
>> --- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
>> +++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
>> @@ -26,6 +26,7 @@ properties:
>>             - qcom,msm8996-qfprom
>>             - qcom,msm8998-qfprom
>>             - qcom,qcs404-qfprom
>> +          - qcom,qdu1000-qfprom
> Above qcs, to keep alphabetical order.
qdu alphatecially comes after qcs, right? Did I misinterpret your comment?
>
> That's a new patch? Nothing in changelog suggested it...
Yes, that is a new patch from v2. Will mention in cover letter in the 
next patch.

Thanks,
Komal
>
> Best regards,
> Krzysztof
>

