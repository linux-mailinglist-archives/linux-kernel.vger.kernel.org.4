Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49010725701
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbjFGIKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbjFGIKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:10:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5095095;
        Wed,  7 Jun 2023 01:10:46 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3573hgoH013040;
        Wed, 7 Jun 2023 08:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zNC49izImKDUwPg+4hUyOkDmU+KHJ1XdXUa8gCnXKX8=;
 b=fR6PmIelCrJjxOqw26q5umZ0gfPqa19W0Dvc+0TBtPRKn2H2MidblHCV1ALy+t3tLsaw
 jqEvfLilrQte9w1Ry25t96K8eiNPMBotNIoVniguqCfL5Nm1kdfLaQQIYwFWJhz/GQH5
 x1CxIFBtna6+EbGc3kDDuNYCeYyG6wU/ch9VhRKdgQAtnuQHXobFrdLoELEuZUIAfsaq
 XXRRA6sjFFRbvADO0PCSN1XBN1NBS5TYAHTxyUYXBo8ws2wkxGg7TXR4Z/+v1DekzDKO
 ufwEBvr9EnDGHJ8WNaFuuua60IJnG6+2G5gSKACHoQqeGQaURHm9R1JYwB6LXQetgzc5 Hw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a7699yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 08:10:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3578AYhs030018
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 08:10:34 GMT
Received: from [10.216.18.190] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 7 Jun 2023
 01:10:26 -0700
Message-ID: <0555c089-9d0d-7d19-9646-f0f9b8630d12@quicinc.com>
Date:   Wed, 7 Jun 2023 13:40:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH V2 01/13] dt-bindings: remoteproc: qcom: Add support for
 multipd model
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <mathieu.poirier@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_eberman@quicinc.com>, <quic_mojha@quicinc.com>,
        <loic.poulain@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_devipriy@quicinc.com>
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
 <20230521222852.5740-2-quic_mmanikan@quicinc.com>
 <7940c743-815f-f864-d015-43d7e916ecfa@linaro.org>
 <a1456f62-d0a7-d5ec-b379-db1b6035c89c@quicinc.com>
 <d187eafb-4a80-9479-d063-3a01b47d8efa@linaro.org>
 <feb0d11d-0930-d0b8-ab6e-cf477bbf114b@quicinc.com>
 <87edmoitu3.fsf@kernel.org>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <87edmoitu3.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gqe4xl4c4R0xB_rjn82FRVjAJ6tko9eF
X-Proofpoint-GUID: gqe4xl4c4R0xB_rjn82FRVjAJ6tko9eF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_04,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=758
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306070066
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/6/2023 7:19 PM, Kalle Valo wrote:
> Manikanta Mylavarapu <quic_mmanikan@quicinc.com> writes:
> 
>>>>>> +
>>>>>> +    properties:
>>>>>> +      compatible:
>>>>>> +        enum:
>>>>>> +          - qcom,ipq5018-wcss-ahb-mpd
>>>>>> +          - qcom,ipq9574-wcss-ahb-mpd
>>>>>> +          - qcom,ipq5018-wcss-pcie-mpd
>>>>>
>>>>> Keep rather alphabetical order (so both 5018 together).
>>>>>
>>>>> I also do not understand these at all. Why adding bus type to
>>>>> compatible? This rarely is allowed (unless it is PCIe controller within
>>>>> soc).
>>>>>
>>>> IPQ5018 SOC has in-built PCIE controller. Here QDSP6 will bring up
>>>> external(PCIE) and internal (AHB) wifi radio's. To separate AHB, PCIE
>>>> radio's properties, i have added bus type to compatible.
>>>
>>> It's the same device - WCSS - right? We do not create multiple nodes and
>>> compatibles for the same devices. Bus suffixes are almost never parts of
>>> compatibles.
>>
>>
>> No it's not the same device. WCSS on inside IPQ5018 and WCSS attached
>> via pcie to IPQ5018. Here QDSP6 managing both WCSS's.
>>
>> So for better clarity i will use attached SOC ID in compatible.
>> Below are the new compatible's.
>>
>> - qcom,ipq5018-wcss-mpd //IPQ5018 internal radio
>> - qcom,ipq9574-wcss-mpd	//IPQ9574 internal radio
>> - qcom,qcn6122-wcss-mpd //IPQ5018 attached radio
> 
> What mandates that there's just one QCN6122 device attached to PCI?
> Assuming fixed PCI configurations like that makes me worried.
> 

IPQ5018 always has one internal radio, attached pcie radio's depends on 
no of pcie ports. IPQ5018 has 2 pcie ports, so it supports max two 
qcn6122 devices. One compatible (qcom,qcn6122-wcss-mpd) itself support's 
number of pcie devices controlled by QDSP6.

Thanks & Regards,
Manikanta.
