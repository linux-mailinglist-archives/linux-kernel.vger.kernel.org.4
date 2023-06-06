Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5365C7241D0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjFFMMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237449AbjFFMMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:12:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C031E78;
        Tue,  6 Jun 2023 05:12:13 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356Bu27l019072;
        Tue, 6 Jun 2023 12:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vL07l/foXbYW2GbPAvxRMO9aFR20+bjrFykzc+VGJOI=;
 b=obGN6yyyewnpP9Jhv3BaOBW01a7L92tfLOu5Yt9YeoMdaZFLNcG8mJAwJ7vm9GxZy4EC
 6P37WOI01pM9qO7iEpgMlqPfw0v56Icv3r1sP+NHixNHdZf0pxm5h7or/01HmPyy+4z+
 AmzqAcxi9rzymWKWHNQe3Nesz3RLaSk9ikLuHvuyOa/Rn6bCGnkFr0/ZMZPR1+vKVt5J
 2XgvoSdGAEB1t2MpJvdLHqUflE+S2VaXLaa3e5sOsfn9TmvqNx7oZI4t6ESFvnn56+Fb
 LWEwMK2rMMk7aGgV6w6IKIute22fH64WwB3PbxGkexL9QUNPe+ZbBaA5BtU3Puv9hfnD Nw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r1d4etwvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 12:11:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 356CBBvY022935
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Jun 2023 12:11:11 GMT
Received: from [10.216.9.253] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 6 Jun 2023
 05:11:03 -0700
Message-ID: <feb0d11d-0930-d0b8-ab6e-cf477bbf114b@quicinc.com>
Date:   Tue, 6 Jun 2023 17:41:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH V2 01/13] dt-bindings: remoteproc: qcom: Add support for
 multipd model
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <mathieu.poirier@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_eberman@quicinc.com>, <quic_mojha@quicinc.com>,
        <kvalo@kernel.org>, <loic.poulain@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_devipriy@quicinc.com>
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
 <20230521222852.5740-2-quic_mmanikan@quicinc.com>
 <7940c743-815f-f864-d015-43d7e916ecfa@linaro.org>
 <a1456f62-d0a7-d5ec-b379-db1b6035c89c@quicinc.com>
 <d187eafb-4a80-9479-d063-3a01b47d8efa@linaro.org>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <d187eafb-4a80-9479-d063-3a01b47d8efa@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PX85kbnB417PqgOd07TlNVd4HWUgoBA2
X-Proofpoint-GUID: PX85kbnB417PqgOd07TlNVd4HWUgoBA2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_08,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0
 mlxlogscore=895 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306060103
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/6/2023 11:44 AM, Krzysztof Kozlowski wrote:
> On 05/06/2023 14:02, Manikanta Mylavarapu wrote:
>>>> +  memory-region:
>>>> +    items:
>>>> +      - description: Q6 pd reserved region
>>>> +
>>>> +  glink-edge:
>>>> +    $ref: /schemas/remoteproc/qcom,glink-edge.yaml#
>>>> +    description:
>>>> +      Qualcomm G-Link subnode which represents communication edge, channels
>>>> +      and devices related to the Modem.
>>>> +
>>>> +patternProperties:
>>>> +  "^pd-1|pd-2|pd-3":
>>>> +    type: object
>>>> +    description:
>>>> +      In Multipd model, WCSS pd depends on Q6 pd i.e Q6 pd should be up before
>>>> +      WCSS. It can be achieved by keeping wcss pd node as subnode of Q6
>>>> +      device node.
>>>
>>> That's not enough. Your description does not say what is this, why you
>>> have two protection domains for same compatible. What's more, it a bit
>>> deviates from hardware description.
>>>
>> WCSS means 'wireless connectivity sub system', in simple words it's a
>> wifi radio block.
>>
>> IPQ5018 SOC has both internal (AHB) wifi radio/WCSS and external (PCIE)
>> wifi radio/WCSS. In Q6, Root protection domain will provide services to
>> both internal (AHB) and external (PCIE) wifi radio's protection domain.
>> So we have two protection domains for IPQ5018, one is for internal(AHB)
>> and other is for external(PCIE) wifi radio.
> 
> So it is now in email, but not in the code...
>>
I will add this info, corresponding block diagram in driver code.

>>>> +
>>>> +    properties:
>>>> +      compatible:
>>>> +        enum:
>>>> +          - qcom,ipq5018-wcss-ahb-mpd
>>>> +          - qcom,ipq9574-wcss-ahb-mpd
>>>> +          - qcom,ipq5018-wcss-pcie-mpd
>>>
>>> Keep rather alphabetical order (so both 5018 together).
>>>
>>> I also do not understand these at all. Why adding bus type to
>>> compatible? This rarely is allowed (unless it is PCIe controller within
>>> soc).
>>>
>> IPQ5018 SOC has in-built PCIE controller. Here QDSP6 will bring up
>> external(PCIE) and internal (AHB) wifi radio's. To separate AHB, PCIE
>> radio's properties, i have added bus type to compatible.
> 
> It's the same device - WCSS - right? We do not create multiple nodes and
> compatibles for the same devices. Bus suffixes are almost never parts of
> compatibles.
> 
> 
No it's not the same device. WCSS on inside IPQ5018 and WCSS attached 
via pcie to IPQ5018. Here QDSP6 managing both WCSS's.

So for better clarity i will use attached SOC ID in compatible.
Below are the new compatible's.

- qcom,ipq5018-wcss-mpd //IPQ5018 internal radio
- qcom,ipq9574-wcss-mpd	//IPQ9574 internal radio
- qcom,qcn6122-wcss-mpd //IPQ5018 attached radio

>>>
>>> Drop.
>>>
>>>> +
>>>> +unevaluatedProperties: false
>>>
>>> This changed... why?
>>>
>>>
>> 'unevaluatedProperties' is similar to 'additionalProperties' except
>> that it recognize properties declared in subschemas as well.
> 
> You don't have to explain me what are unevaluatedProperties or
> additionalProperties. Let's assume that I know them. What you should
> explain is why you changed it. Where is the reference to other schema?
> 
I will go with previously used 'additionalProperties' itself and add
'unevaluatedProperties' in glink-edge.

Thanks & Regards,
Manikanta.
> 
> Best regards,
> Krzysztof
> 
