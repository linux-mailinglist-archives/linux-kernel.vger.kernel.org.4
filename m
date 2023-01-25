Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A3D67B709
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbjAYQjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbjAYQjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:39:08 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D5D61A5;
        Wed, 25 Jan 2023 08:39:07 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PEtdYr004745;
        Wed, 25 Jan 2023 16:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0ChATrYgcfVnq2ClzhGONhr89tnKCzl70FzK8Pg20BM=;
 b=e0/79e0jA8L10hDoEVKfMt8gkwQhGNNSw/Ye/tuim4XbbMJ/9Ggl4/Q308n2ckwTDq8q
 PSMBpBJ+2hTtm4vtYMUnHj6aXgKpL+H9rhohozT0FocDYnsI8UdSJil1IdNZHAGkQDHO
 n/06XcjiLQx3W2zyR0uLzeKORS2GzyhXQGurEe9bqk7pnz1S0MMhzxVgO6bpzSLsBTEi
 3wV6wFHydqr2f1T5b12bb+5wV5bxXbV/fxRl3Hh/fSFXJ9OeTDfe/K6iP5wH/lyAmTCB
 r5QDMTKKomX9rb9AQtr8J/NQanJjanI2sZkbaPdMyTuewLgtRTu1FX2fm55ba8JSqe3v /A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3najkha952-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 16:38:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30PGcpVQ002212
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 16:38:51 GMT
Received: from [10.50.40.254] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 08:38:42 -0800
Message-ID: <d9b3390a-f207-4c5c-8613-0566c2435f6c@quicinc.com>
Date:   Wed, 25 Jan 2023 22:08:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 01/10] dt-bindings: pinctrl: qcom: add IPQ5332 pinctrl
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <robimarko@gmail.com>, <quic_gurus@quicinc.com>,
        <bhupesh.sharma@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230125104520.89684-1-quic_kathirav@quicinc.com>
 <20230125104520.89684-2-quic_kathirav@quicinc.com>
 <50ec54ba-3468-3448-3fab-f28e97549ad2@linaro.org>
 <0b28f4a3-c445-7473-501b-39cbcfdb9889@quicinc.com>
 <d6512673-a232-c8e5-45f7-e903fc1a01a7@linaro.org>
Content-Language: en-US
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <d6512673-a232-c8e5-45f7-e903fc1a01a7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iFOss_yTPbpiDPY2u0W_fozjyZmtcGv3
X-Proofpoint-GUID: iFOss_yTPbpiDPY2u0W_fozjyZmtcGv3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_10,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=827 clxscore=1015
 lowpriorityscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250147
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/25/2023 9:50 PM, Krzysztof Kozlowski wrote:
> On 25/01/2023 16:49, Kathiravan Thirumoorthy wrote:
>>>> @@ -0,0 +1,134 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/pinctrl/qcom,ipq5332-pinctrl.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Qualcomm IPQ5332 TLMM pin controller
>>>> +
>>>> +maintainers:
>>>> +  - Bjorn Andersson <andersson@kernel.org>
>>>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> +
>>>> +description: |
>>>> +  Top Level Mode Multiplexer pin controller in Qualcomm IPQ5332 SoC.
>>>> +
>>>> +allOf:
>>>> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: qcom,ipq5332-tlmm
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  interrupts: true
>>> missing maxItems
>>>
>>> Rebase your patches on latest next and use the latest bindings and
>>> drivers as starting point.
>>
>> Changes are based on v6.2-rc1.  I see the maxItems changes in
>> linux-next. Will update this in V2.
> Your patches cannot be based on v6.2-rc1. They won't even apply. You
> miss entire development of last month.


Hmmm, Will use linux-next/master as base hereafter.


>>
>>>> +  interrupt-controller: true
>>>> +  "#interrupt-cells": true
>>>> +  gpio-controller: true
>>>> +  "#gpio-cells": true
>>>> +  gpio-ranges: true
>>>> +  wakeup-parent: true
>>>> +
>>>> +  gpio-reserved-ranges:
>>>> +    minItems: 1
>>>> +    maxItems: 27
>>>> +
>>>> +  gpio-line-names:
>>>> +    maxItems: 53
>>> You have 54 GPIOs.
>>
>> Sorry, GPIO ranges are from 0-52, will update it in all places in V2.
> Ah, then the gpio pattern needs a fix.


Yup, will take care of that as well in V2.


>
>
> Best regards,
> Krzysztof
>
