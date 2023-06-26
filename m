Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CFA73DC08
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjFZKJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjFZKJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:09:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B10211C;
        Mon, 26 Jun 2023 03:09:06 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35Q8KZVg002100;
        Mon, 26 Jun 2023 10:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eOpCYF6zAWuabH0/d/IYnQA8vhrFtttjs0v+cTd4l6Q=;
 b=OqXxbCuCZkhW78nXztG6+xOR+hxlTM6vTXJSqZhTVvyI/cIBPTFX1nA6yIbR/plKTz8x
 7NKVvCO7o1aI57nx9lM2b9wZlfWLAhx3MKpSHqlMC0kloO5L9+jzjRmBZCOJ38hEp0Ib
 DAS3ebQ29g81JfYDunI95zll9ZZlKATtvTRYSp4uGu/KKDKokqX6qajv3FG8BOMJecNV
 8EgN1OPBYMY8/dsgwhA7Ac2KtmfKO7yfhmClSIL43Zwa3zQT/QGsdaq/8QqLHX66nj6E
 MOT8BpiWSgzr48f5LdMdj361DkIZL6MHRi52NqadGJTMtAzJ0pJwzEjN6e3cks2w6Lxm aw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rdqgdbquk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 10:09:02 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35QA8xQ9015589
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 10:08:59 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 26 Jun
 2023 03:08:55 -0700
Message-ID: <23a7f281-ccd3-a00e-0667-dd86673d2f9f@quicinc.com>
Date:   Mon, 26 Jun 2023 15:38:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 1/6] dt-bindings: nvmem: sec-qfprom: Add bindings for
 secure qfprom
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
References: <20230623141806.13388-1-quic_kbajaj@quicinc.com>
 <20230623141806.13388-2-quic_kbajaj@quicinc.com>
 <cea67754-6bc0-f8ee-3cba-8713b10b0c69@linaro.org>
 <d9cde55b-fc96-b024-8048-1de1fa1bd89e@quicinc.com>
 <d0b6f2c9-8e85-a38b-e2b1-14f197ca1ea0@linaro.org>
 <c8909dcb-143c-c2d7-513d-625e9ce00c0c@quicinc.com>
 <9f9afa24-ecfc-2fb2-3d47-80c250fcb8fe@linaro.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <9f9afa24-ecfc-2fb2-3d47-80c250fcb8fe@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aBFTNpPV875pUutWXteeG-pEG8KJj_DS
X-Proofpoint-GUID: aBFTNpPV875pUutWXteeG-pEG8KJj_DS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_06,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=674 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260090
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/26/2023 3:16 PM, Krzysztof Kozlowski wrote:
> On 26/06/2023 11:02, Komal Bajaj wrote:
>>
>> On 6/26/2023 2:00 PM, Krzysztof Kozlowski wrote:
>>> On 26/06/2023 10:22, Komal Bajaj wrote:
>>>>>> +
>>>>>> +allOf:
>>>>>> +  - $ref: nvmem.yaml#
>>>>>> +
>>>>>> +properties:
>>>>>> +  compatible:
>>>>>> +    items:
>>>>>> +      - enum:
>>>>>> +          - qcom,qdu1000-sec-qfprom
>>>>>> +      - const: qcom,sec-qfprom
>>>>>> +
>>>>>> +  reg:
>>>>>> +    items:
>>>>>> +      - description: The secure qfprom corrected region.
>>>>>> +
>>>>>> +  # Needed if any child nodes are present.
>>>>>> +  "#address-cells":
>>>>>> +    const: 1
>>>>>> +  "#size-cells":
>>>>>> +    const: 1
>>>>> Drop both, they are not needed.
>>>> I didn't get it. Can you please explain why these are not needed as this
>>>> node will have child nodes which will use single value for address and size.
>>> I suspect they are already defined. Do other bindings (for cases with
>>> children) have them? If not, why here it would be different?
>> Yes, I see there are bindings that has these properties, listed a few of
>> them below -
>>
>> [1]
>> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> Please work on current development. It's a bit of waste of time to
> review old code...

Okay sorry for that, will work on this.

Thanks
Komal
>
> https://lore.kernel.org/all/20230611140330.154222-16-srinivas.kandagatla@linaro.org/
>
>> [2]
>> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> That's not a nvmem provider.
>
>> [3]
>> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> That's not a nvmem provider.
>
>
> Best regards,
> Krzysztof
>

