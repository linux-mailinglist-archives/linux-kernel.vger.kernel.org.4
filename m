Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EBB74A088
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjGFPL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjGFPL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:11:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B424B2;
        Thu,  6 Jul 2023 08:11:55 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366Dal9L019446;
        Thu, 6 Jul 2023 15:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jN0iR259ckPJdoT6y2gSZBDtuULZgboI5+8qTA0VQZc=;
 b=hBmsU/quEiwrRVA+ofRLBz14TPbSZWFK0tPyjTuf5ZCegjqOSSJtIApjAeqNGjJbyeHQ
 AZJhYm2PBltowgYEv9ZWDWwJxQb/W4HouSXK+bzsSVLIdGCBCY3cYivo+4uscKV4IWAa
 XdLUakTX1su2o6Tqp1TMQZNz0//VftkmlQOFzw/LRFkFYLo1N1wwCESIdBQ7FhGmgtWM
 R7ZTVOXhzivGRNColioZy2k+OSWhrSyp71T3O0m6lldqrAYTPxAWNjyhjBm7vvoUprPd
 8L985ljxlfWeqXnGSn4Xxv4rBWf27SWXA6ntPlqJF2DJ82FLYF/EPiOjLrWxcTMzBbkl iQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rnvaa8hya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 15:11:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366FBo7f025870
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 15:11:50 GMT
Received: from [10.216.13.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 6 Jul
 2023 08:11:45 -0700
Message-ID: <a50921ca-c858-dacc-6849-4898fdf7683c@quicinc.com>
Date:   Thu, 6 Jul 2023 20:41:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/4] dt-bindings: pinctrl: qcom-pmic-gpio: Add pm7550ba
 support
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
References: <1688650209-25119-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688650209-25119-2-git-send-email-quic_rohiagar@quicinc.com>
 <4042fa22-8948-49c9-6e5c-dc8926ed5f99@linaro.org>
 <6d067262-d8af-f6f3-4ef7-870eafa15f46@quicinc.com>
 <8b04d830-4710-7f26-09e8-326b69d72396@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <8b04d830-4710-7f26-09e8-326b69d72396@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lzasmjBCY-PX2tD0BY71I3rVHJCCIeEI
X-Proofpoint-ORIG-GUID: lzasmjBCY-PX2tD0BY71I3rVHJCCIeEI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=917 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060136
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/6/2023 8:34 PM, Konrad Dybcio wrote:
> On 6.07.2023 16:45, Rohit Agarwal wrote:
>> On 7/6/2023 8:05 PM, Krzysztof Kozlowski wrote:
>>> On 06/07/2023 15:30, Rohit Agarwal wrote:
>>>> Add support for the pm7550ba GPIO support to the Qualcomm PMIC GPIO
>>>> binding.
>>>>
>>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 3 +++
>>> I doubt that all your patches here and other patchsets are v1. Otherwise
>>> how did you get my Acks and Rbs? Please use proper versioning and
>>> provide changelog.
>>>
>>> What changed here?
>> Actually this is part of the original bigger series [1] that as per Bjorn's suggestion need to be broken
>> down according to the subsystem/maintainer.
>> Since it got broken down into multiple smaller series, I didnt include the versioning.
> All of that information should be included in the cover letter, to
> limit confusion both for maintainers and patch workflow tools.
>
> Since these patches all come from a separate series, it would be
> good for you to version this one as v(BIG_SERIES_REVISION)+1 because
> they've already been on LKML at least once. That would especially hold
> true if this revision included any changes.
Understood. Will send all the smaller series again with v2 as version 
with changelog.

Thanks,
Rohit.
> Konrad
>> [1] https://lore.kernel.org/all/9de424ca-271a-8ed2-5550-658a828c4ea5@quicinc.com/
>>
>>> Best regards,
>>> Krzysztof
>>>
