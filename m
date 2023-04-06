Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9946D9360
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 11:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbjDFJ42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 05:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbjDFJ4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:56:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80053A268;
        Thu,  6 Apr 2023 02:54:02 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3368Q17c022412;
        Thu, 6 Apr 2023 09:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jZgMGdmZaVAzkO0q+pB6WHfwcscuTH1O+8bqLAYLeyc=;
 b=Zwl4k/j1cjaHvl2by5ChTWp8ZGbwPG+BRgzzQxrt5OgN9o+Rr+X8SetOu7KKn8B5uC27
 aNd+0FJvUPZs0a52AVNkXZPQTh9j3150AsbL4IJqI/sKfU/mc+vE90prcN6dmtXAPOs6
 wD/lVXK0ruONC254vvN2wtugU3XIxfAOU3s7Qsy4J7z14QgXVhsJgu5DG2T+cjGPski8
 3Z7oZhkBTovHWicnpaDklaxbRe1m9bWva4k9UkGaHxBeOPK4pZzbUpcqRPGeZGeq6TRg
 WiIO8PH94//HnUeC+1EokYIzpwNqnVUvQVkp0F6CdN/CI3YAToirra3zgIjUmEZml5rt eg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3psnmj0uh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 09:52:47 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3369qlbP009820
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Apr 2023 09:52:47 GMT
Received: from [10.216.2.94] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 6 Apr 2023
 02:52:42 -0700
Message-ID: <d7d03e81-03d6-b643-a2e6-0867bab7e0ef@quicinc.com>
Date:   Thu, 6 Apr 2023 15:22:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/5] dt-bindings: arm: msm: Add bindings for multi
 channel DDR in LLCC
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20230313124040.9463-1-quic_kbajaj@quicinc.com>
 <20230313124040.9463-3-quic_kbajaj@quicinc.com>
 <2b3e39b9-ea70-db9b-89f7-09054df363c3@linaro.org>
 <20230315134814.GA98488@thinkpad>
 <c8f3499f-d927-6657-c7c6-732ed2222525@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <c8f3499f-d927-6657-c7c6-732ed2222525@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8zsLpEULLto8r0fDRQMYpqpfDWjio-uH
X-Proofpoint-ORIG-GUID: 8zsLpEULLto8r0fDRQMYpqpfDWjio-uH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_04,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 phishscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304060086
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/2023 2:49 PM, Komal Bajaj wrote:
> Didn't see my reply on the list, so sending it again.
> And also I see that the dt patch is already applied.

The reason why you are not seeing your replies at

https://lore.kernel.org/lkml/20230313124040.9463-1-quic_kbajaj@quicinc.com/

is because your reply cc-list contain some invalid domain 
(codeaurora.org) email id's and any list/email mentioned
after that would not be getting your emails.

-- Mukesh

> 
> Thanks Krzysztof and Manivannan for reviewing the patch.
> 
> 
> On 3/15/2023 7:18 PM, Manivannan Sadhasivam wrote:
>> On Wed, Mar 15, 2023 at 08:41:21AM +0100, Krzysztof Kozlowski wrote:
>>> On 13/03/2023 13:40, Komal Bajaj wrote:
>>>> Add description for additional nodes needed to support
>>>> mulitple channel DDR configurations in LLCC.
>>>>
>>>> Signed-off-by: Komal Bajaj<quic_kbajaj@quicinc.com>
>>> +Cc Mani,
>>>
>> Thanks, Krzysztof!
>>
>>> This will conflict with:
>>> https://lore.kernel.org/all/20230314080443.64635-3-manivannan.sadhasivam@linaro.org/
>>>
>>> Please rebase on top of Mani's patches (assuming they are not
>>> conflicting in principle)
>>>
>>>> ---
>>>>   Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 9 +++++++++
>>>>   1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
>>>> index 38efcad56dbd..9a4a76caf490 100644
>>>> --- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
>>>> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
>>>> @@ -37,15 +37,24 @@ properties:
>>>>       items:
>>> minItems: 2
>>>
>>>>         - description: LLCC base register region
>>>>         - description: LLCC broadcast base register region
>>>> +      - description: Feature register to decide which LLCC configuration
>>>> +                     to use, this is optional
>>>>   
>>>>     reg-names:
>>> minItems: 2
>>>
>>>>       items:
>>>>         - const: llcc_base
>>>>         - const: llcc_broadcast_base
>>>> +      - const: multi_channel_register
>> Is this the actual register region or a specific register offset? We generally
>> try to pass the base address of the region along with the size and use the
>> offset inside the driver to access any specific registers.
>>
>> Thanks,
>> Mani
> 
> This is a specific register offset outside the LLCC register region which has the
> information of number of DDR channel.
> 
>>>>   
>>>>     interrupts:
>>>>       maxItems: 1
>>>>   
>>>> +  multi-ch-bit-off:
>>>> +    items:
>>>> +      - description: Specifies the offset in bits into the multi_channel_register
>>>> +                     and the number of bits used to decide which LLCC configuration
>>>> +                     to use
>>> There are here few issues.
>>> First, I don't fully understand the property. What is an LLCC
>>> configuration? Like some fused values?
> 
> There are different configuration for LLCC based on the number of
> DDR channel it uses. Here, we are basically trying to get information
> about the same.
> 
>>> Second, don't make it a register specific, it will not scale easily to
>>> any new version of this interface. Although how this should look like
>>> depends on what is it.
> 
> LLCC driver can only get DDR channel information from the register.
> 
>>> Third, you need vendor prefix and type (unless this is a generic
>>> property, but does not look like). Then "items" is probably wrong. Line
>>> break after "description: "
> 
> Noted, will take care of this in the next patchset.
> 
> Thanks
> Komal
> 
>>> Best regards,
>>> Krzysztof
>>>
> 
