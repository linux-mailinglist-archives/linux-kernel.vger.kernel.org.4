Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2496C70AEAF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 17:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjEUPvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 11:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjEUPvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 11:51:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CC1E4;
        Sun, 21 May 2023 08:51:42 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34LFmJBj020316;
        Sun, 21 May 2023 15:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ljMuxPaCpT5wa5tNE10UNsmBcvn2Lm9qekfcG5KgMlI=;
 b=g8lFVyci3fIdPnqlnfQ4QWWDaQC1F5RnFcjH4sJFBfEZVxd4jJ2zVV87ECXm1Ja34/Hc
 7yOt67S9oq/1Lvk1tpI7vwf6uwABVe8MbWlgg0j/thCPDMaWNS1X3/ySD/6qBUW5WxlB
 eQhmKavGeAo5TJBPJ5V4+yBHZWRB/PLl/scyqSVCTJdib/4M3IumQS6QYnMX1n6ZGsE5
 uAvPA93xyF2w+UUVJwHf2XMvwu+mb/hUrut21T8UMe+UUxL7LYa/KIz338rO2IzSsRDf
 aJw09WS3aztB5cTCZqdj+uQWJj3FcOmfaw5bBnl/6P2BU/C2WhtNBLp6rm29Cv6Uel8W lQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpkjuj5c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 15:51:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34LFpalh010803
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 15:51:36 GMT
Received: from [10.216.45.27] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 21 May
 2023 08:51:28 -0700
Message-ID: <4dc3dbe4-e560-0dae-bb25-69782df78cf1@quicinc.com>
Date:   Sun, 21 May 2023 21:21:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 05/11] dt-bindings: clock: qcom: gcc-ipq9574: Add Q6 gcc
 clock control
Content-Language: en-US
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <mathieu.poirier@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_gurus@quicinc.com>,
        <loic.poulain@linaro.org>, <quic_eberman@quicinc.com>,
        <robimarko@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-6-git-send-email-quic_mmanikan@quicinc.com>
 <95c57098-aa37-a203-2ed3-f36449abefea@linaro.org>
 <3d876a44-0145-09b8-0722-80f57d6c96ac@quicinc.com>
In-Reply-To: <3d876a44-0145-09b8-0722-80f57d6c96ac@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xaZDKvE2tSgsYPIiehCiu6PhZgjTd1jT
X-Proofpoint-ORIG-GUID: xaZDKvE2tSgsYPIiehCiu6PhZgjTd1jT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 mlxlogscore=889 priorityscore=1501 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305210140
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/8/2023 7:59 PM, Manikanta Mylavarapu wrote:
> 
> 
> On 3/7/2023 8:49 PM, Krzysztof Kozlowski wrote:
>> On 07/03/2023 05:41, Manikanta Mylavarapu wrote:
>>> Add support for the QDSP6 gcc clock control used on IPQ9574
>>> based devices. This would allow mpd remoteproc driver to control
>>> the required gcc clocks to bring the subsystem out of reset.
>>>
>>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>>> ---
>>>   include/dt-bindings/clock/qcom,ipq9574-gcc.h | 159 ++++++++++---------
>>>   1 file changed, 83 insertions(+), 76 deletions(-)
>>>
>>> diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h 
>>> b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
>>> index c89e96d568c6..8bd6350ecd56 100644
>>> --- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
>>> +++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
>>> @@ -138,80 +138,87 @@
>>>   #define WCSS_AHB_CLK_SRC                129
>>>   #define GCC_Q6_AHB_CLK                    130
>>>   #define GCC_Q6_AHB_S_CLK                131
>>> -#define GCC_WCSS_ECAHB_CLK                132
>>> -#define GCC_WCSS_ACMT_CLK                133
>>
>> That's an ABI break, if file was accepted. Or a very weird change
>> anyway, if it wasn't (why adding entry and immediately changing it?).
>>
>> Best regards,
>> Krzysztof
>>
> 
> I will add new macros at the end instead in middle.
> 
> Thanks & Regards,
> Manikanta.

Clocks in multipd architecture will be handled by QDSP6 firmware.
So i am going to remove clock macros and drop this patch.

Thanks & Regards,
Manikanta.
