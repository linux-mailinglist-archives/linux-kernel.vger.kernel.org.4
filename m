Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7B9721E0A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjFEGXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFEGXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:23:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBA4B3;
        Sun,  4 Jun 2023 23:23:15 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3555vJGq030898;
        Mon, 5 Jun 2023 06:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RCBSXqnqd8SXWD2jLzPWHFxvq4Xzphwc5Yh9xwjmR7Y=;
 b=AUHzGkvz938gmjinpj0mExMp3t7PHkF2L0rRFidAcJ808MqMFrCJvC1ITDF4C4tlJY5W
 qR4QBlOTikXpl2A/vdFwdqKk1HWISks+/tniPKBYfKPNFrZhsSe2dsr8pmVKmd+5MlQl
 EdG60HsYHsohi6yOmzr7aDIuUvDWecalC88dL8umGCB8SL3Y7oyZVZBSfhpBOcuJ9U0z
 QfrxREdTdlYv26PNXHYTMCseeLUmMQo3oha2ls17urBzBHBBMqP0n/GXIOz281+R6yTM
 6Mo33vI59ULs8XD8OhTIILSAT9ypqYqeWSu3gpm4h6f3xBrdGSprRWkENUjwKfYvyDZD cw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qyw46aqvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 06:23:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3556N9EN019973
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Jun 2023 06:23:09 GMT
Received: from [10.201.206.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 4 Jun 2023
 23:23:00 -0700
Message-ID: <eda6ad87-5ae0-b62a-e877-541fcfe59718@quicinc.com>
Date:   Mon, 5 Jun 2023 11:52:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH V2 04/13] dt-bindings: clock: qcom: gcc-ipq5018: remove q6
 clocks macros
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
 <20230521222852.5740-5-quic_mmanikan@quicinc.com>
 <514a9e26-aeb9-ce05-1055-337646098ec1@linaro.org>
 <d64b9718-0c85-6e5d-7c5b-6ea617e36a32@gmail.com>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <d64b9718-0c85-6e5d-7c5b-6ea617e36a32@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WdW1Ji5aEIMWml-lCuoVBdN2GVj67_qN
X-Proofpoint-GUID: WdW1Ji5aEIMWml-lCuoVBdN2GVj67_qN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050056
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/2023 12:25 AM, Robert Marko wrote:
> On 30. 05. 2023. 13:01, Krzysztof Kozlowski wrote:
> 
>> On 22/05/2023 00:28, Manikanta Mylavarapu wrote:
>>> Since Q6 firmware takes care of bring up clocks in multipd
>>> model, remove bring up clock macros.
>>>
>>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>>> ---
>>>   include/dt-bindings/clock/qcom,gcc-ipq5018.h | 21 --------------------
>>>   1 file changed, 21 deletions(-)
>>>
>> I am fine with this if it still compiles... I have doubts about it,
>> unless of some depedencies (you mentioned three !)... but then it gets
>> complicated.
>>
>> Keep patches doing same logical change in same patchset. This dependency
>> dance in recent submissions is making things tricky and prolonging your
>> upstreaming process significantly.
> 
> Considering that the basic IPQ5018 patchset that this series depends on
> has not yet been merged, why not just drop these there instead?
> 
> Regards,
> Robert
> 
Yeah i agree. I will drop this patch in this series.

Thanks & Regards,
Manikanta.

>>
>> Best regards,
>> Krzysztof
>>
>>
>>
