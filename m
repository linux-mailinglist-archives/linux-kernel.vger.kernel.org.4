Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51066CBD7A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjC1LYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjC1LYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:24:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020A57D8A;
        Tue, 28 Mar 2023 04:24:37 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SAnGJj002538;
        Tue, 28 Mar 2023 11:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oN96+ARe1j8aRdsYtJdfn8/Aj1fKjFx7+fhMQDxXoUs=;
 b=j4H+sRVXl8p63vCyDxlGGz/x61yg6VeLHpxMyqZkxGM+LB9ol7/kVV7zpBBEUsgAxHtG
 qbYJzwuc1uTjCEeqsN3jXukGwefEVomG63J0DMRGQU+LF+s5bsDeoWBHzsoZK/Ii132q
 8TQTm/MgJvFK+qD6L+kCb9R2FNvuzUWaW21NdcorCYmGVHoiBi86om5yecy1C3AEuI3Z
 JaobL3F2zLDa7O3OjoPLQg6jT8BOV1HKAv8SB55wNMgVq/U0eqB0b8jGE/2FXiXrHORQ
 cDLWu/DjeIqq+knNf74WR/vcLuGP+gN5oGt3Pq4cYY2VmaQTjiugq9JWb05nREmL5YrL 7g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pk79bbcty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 11:24:26 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32SBNkfF010858
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 11:23:46 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Mar
 2023 04:23:42 -0700
Message-ID: <c9974f19-7c0a-dfae-1747-a3c73f41d4dd@quicinc.com>
Date:   Tue, 28 Mar 2023 19:23:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 01/11] dt-bindings: arm: Add support for DSB element
 size
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <1679551448-19160-1-git-send-email-quic_taozha@quicinc.com>
 <1679551448-19160-2-git-send-email-quic_taozha@quicinc.com>
 <e6ad7301-09ea-93e0-929e-86e0eb0a02e7@arm.com>
 <d4c133c1-38c7-93e3-deaf-b55161057409@quicinc.com>
 <fb5d55ba-8f7b-292e-e676-9423c36f4085@quicinc.com>
 <6da91d8c-6694-9041-2f2f-72a8e95c7df2@linaro.org>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <6da91d8c-6694-9041-2f2f-72a8e95c7df2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -IFHFVYTSHoJPYVAnVn14_SSP4Uc_-pm
X-Proofpoint-GUID: -IFHFVYTSHoJPYVAnVn14_SSP4Uc_-pm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 mlxlogscore=582 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280094
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 3/25/2023 7:35 PM, Krzysztof Kozlowski wrote:
> On 24/03/2023 10:15, Tao Zhang wrote:
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    minimum: 32
>>>>> +    maximum: 64
>>>> Shouldn't this be something like oneOf ? It is not a range, but one of
>>>> those two specific values ?
>>> Yes, "qcom,dsb-element-size" should be an optional option required in
>>> TPDM
>>>
>>> devicetree. Other properties like "qcom,cmb-element-size",
>>> "qcom,tc-element-size"
>>>
>>> and etc. will be added in a later patch series.
>>>
>>> I will update this doc according to your advice in the next version of
>>> the patch.
>>>
>>> Tao
>>>
>> Correct my misunderstanding in the mail above.
>>
>> You are right, DSB element size should be 32-bit or 64-bit. I will
>> update this in the next
> Then 'enum', not 'oneOf'.

Got it.


Tao

>
> Best regards,
> Krzysztof
>
