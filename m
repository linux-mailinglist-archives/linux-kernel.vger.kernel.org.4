Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5731F620281
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbiKGWqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiKGWql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:46:41 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9174DCEF;
        Mon,  7 Nov 2022 14:46:40 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A7MUKUZ002053;
        Mon, 7 Nov 2022 22:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DmVPoVJk6NKOL9HvVxYamgAu6Y3jQwuDHC3VEZfVP4M=;
 b=ZmOb61x04nWT9LCCUNPvxvxgk51TZh7amGQc/ut4SPxpExCkG4RvKfrN9/eFW8sQMYLs
 +cdoXofGg7WIhcY0T9+Bj30HZUz8y5r/ybHo4Ep6q6fC8mDjP1AZcnXKKpi0O5iXkWPW
 K+s9k4hRTJUPGhXv5hoOXpwbPtSL/3H+xHmP0tud5Hyt4nM0+UF2gRaOZg8uCWPPj9Ko
 39rvN3b9H6pBTVktCYbRtec0OVPJZT5sa/2t71UUlURk3+V18w43qBmBmLQwn1/XzeHU
 TtGGUKFlrKyjFtZhwk8iz4Ifig8Bvz1TVBY9DrCe6xK2aUjUf9vLUA3anD4e8WNaL9Qu DQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kq7g4gk2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 22:46:37 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A7Mkbqs016401
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Nov 2022 22:46:37 GMT
Received: from [10.110.0.244] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 7 Nov 2022
 14:46:36 -0800
Message-ID: <aa22ab8e-903d-07bb-f390-9ca32752af71@quicinc.com>
Date:   Mon, 7 Nov 2022 14:46:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 1/3] dt-bindings: interconnect: Remove required reg
 field
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221026190520.4004264-1-quic_molvera@quicinc.com>
 <20221026190520.4004264-2-quic_molvera@quicinc.com>
 <a214f513-fe28-2096-c2b0-2107e97f3ce2@linaro.org>
 <64d0e5ef-fd36-6f25-2c39-00e8e1346af7@quicinc.com>
 <1a7fd1fd-4f0d-bec3-ddd5-7c6a99a2ab01@linaro.org>
 <7d2c43b7-1507-7c30-27f7-3081c6ec77ba@kernel.org>
 <225f3ff2-62cb-7f11-3eb1-f677360b4359@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <225f3ff2-62cb-7f11-3eb1-f677360b4359@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: b0rFN1LLLfOwGg6vKwBRSowRvvdtDHjP
X-Proofpoint-GUID: b0rFN1LLLfOwGg6vKwBRSowRvvdtDHjP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=773 bulkscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211070171
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2022 10:28 AM, Krzysztof Kozlowski wrote:
> On 07/11/2022 15:36, Georgi Djakov wrote:
>> Hi,
>>
>> On 2.11.22 23:11, Krzysztof Kozlowski wrote:
>>> On 31/10/2022 19:29, Melody Olvera wrote:
>>>>
>>>> On 10/27/2022 8:29 AM, Krzysztof Kozlowski wrote:
>>>>> On 26/10/2022 15:05, Melody Olvera wrote:
>>>>>> Many of the *-virt compatible devices do not have a reg field
>>>>>> so remove it as required from the bindings.
>>>>> and some virt have it... This should be probably separate binding or if
>>>>> the list is small - allOf:if:then.
>>>> I attempted this; however I'm still seeing failures in dtb_check. I've added this
>>>> to the binding; does this look correct?
>>>>   allOf:
>>>>     - $ref: qcom,rpmh-common.yaml#
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            enum:
>>>> +              - qcom,qdu1000-clk-virt
>>>> +              - qcom,qdu1000-mc-virt
>>>> +
>>>> +    then:
>>>> +      required:
>>>> +        - compatible
>>> No, because we talk about reg, not compatible. You should not require
>>> reg instead for some compatibles... but then the schema is getting
>>> complicated.
>>>
>>> It's difficult to give you recommendation because I do not know what are
>>> all these "virt" interconnects. Why some have unit address, why some do not?
>> My understanding is that the "reg" property is required for the NoCs that have
>> registers for controlling the QoS settings for the ports from Linux side.
>> Other NoCs might be controlled by some remote processor and direct access from
>> Linux may not be possible, so they do not have unit address and are outside of
>> the soc DT node.
>> Do we need to strictly define when exactly the "reg" property is required,
>> can't we just mark it as optional?
> It's preferred to make it strictly required or not allowed, so the
> bindings are specific. This also allows to validate for mistakes. It
> would be a bit different case if such test for req would make the
> bindings complicated. I think it's not the case because we could just
> split the bindings into two files:
> 1. One for controlled by AP, with reg.
> 2. One for controller by remote processors, without reg.
>
Sounds good. Will drop this change and add a new binding document.

Thanks,
Melody

