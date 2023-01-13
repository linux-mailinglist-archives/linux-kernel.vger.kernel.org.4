Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F48669ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjAMOlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjAMOkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:40:02 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B09884600;
        Fri, 13 Jan 2023 06:31:47 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DDFKcw006951;
        Fri, 13 Jan 2023 14:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cqj0Z+ztU0pkNZ48hYFvSFMXrtOoDDHl6jjBO0OdfBk=;
 b=IbLuye9SKHHQ49yDm3OmVNuuuHURwKIrYb24XRLGjo6dqQZvrAYI1nsv3cu198PIoTpd
 wWBvHcz1khmXAI6+go1NiNsxPyAPfYK1Em8gR6f/I9xRy4mYJ1cBkJALXumJwGoqtAzd
 Qsko4pYUeOApYzVCBxyTEh3TZOlCipyg5RuprirnBitqV0CD7YFA1uokhdKYAAxYFzkM
 hmrgHJ0S/qdUpYlIzj9O39aLTqBREeGKeBrVtPzOjaYPmzkKMIQUs5I4Dd0clgOfDBTT
 F7pmEcm/+U6nbOAt3QohxYG3KAhyVjiD4zh1Y/xVKv2H+olEgjvq+3aIjWnAnLgstFSR iw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2wqw1j24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 14:31:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DEV6Ck009259
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 14:31:06 GMT
Received: from [10.50.57.3] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 06:30:57 -0800
Message-ID: <5081e96b-5b6c-4a5d-56fc-76a26632cd86@quicinc.com>
Date:   Fri, 13 Jan 2023 20:00:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/7] dt-bindings: pinctrl: qcom: Add ipq9574 pinctrl
 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <tdas@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230110121316.24892-1-quic_devipriy@quicinc.com>
 <20230110121316.24892-4-quic_devipriy@quicinc.com>
 <b63600f9-82ef-83dc-1680-1df125b5d971@linaro.org>
 <a0db608a-2c65-e831-abc2-072609fd7a5a@quicinc.com>
 <06799086-1068-1288-b309-80c245f34ce8@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <06799086-1068-1288-b309-80c245f34ce8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: J1HYudvvvdyaSVOXzFhaeYyP3mw-zIP9
X-Proofpoint-ORIG-GUID: J1HYudvvvdyaSVOXzFhaeYyP3mw-zIP9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_06,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=794 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130095
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/2023 7:46 PM, Krzysztof Kozlowski wrote:
> On 13/01/2023 14:24, Devi Priya wrote:
>>>> +    properties:
>>>> +      pins:
>>>> +        description:
>>>> +          List of gpio pins affected by the properties specified in this
>>>> +          subnode.
>>>> +        items:
>>>> +          oneOf:
>>>> +            - pattern: "^gpio([0-9]|[1-5][0-9]|6[0-4])$"
>>>> +            - enum: [ sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk, sdc2_cmd,
>>>> +                      sdc2_data, qdsd_cmd, qdsd_data0, qdsd_data1, qdsd_data2,
>>>> +                      qdsd_data3 ]
>>>
>>> These are ordered by name.
>> The enum values seem to be ordered alphabetically.
>> could you please help us understand the ordering?
> 
> q goes before s
Oops! sorry. Will update
> 
>>>
>>>> +        minItems: 1
>>>> +        maxItems: 8
>>>> +
> 
> Best regards,
> Krzysztof
> 
Best Regards,
Devi Priya
