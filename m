Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D0372FB51
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbjFNKkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243839AbjFNKkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:40:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E201732;
        Wed, 14 Jun 2023 03:40:17 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E8p7AH025738;
        Wed, 14 Jun 2023 10:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aSPEPhkL26kQnMN/deYraUMcKA9Wk7cPOyOJMBveEbU=;
 b=kCDn3krUfF9JJZeKIsXOucce5OeQFT2RUiysGUSfLI1omJ555HF3XJLXCfsG1g81cgqD
 aIeIbwUmGUAiMXcKeU73lwGllHjE2QEhc8e7suNxyxpgdLWoS38x5LVh8kQ8Q8L2D8PK
 YPjYjHykbggtTconQO/cQGufzvBeC3rHNmjqUIRWxqWcT+rYfl79lBctDd2LavEj3FtP
 bRJtApF5DLoaRoPutluAssdYnfulKWOS9Acje2zjnPJFDDDcH/yDDU1W7UFxUn2YJ18A
 2nXOLtFiSGPc3LlwaIfGkF/MjyJYgZKKLyoR+3Mk6GEyXYk5m9R5gm+osq8N2hFbM95A FQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r79dfrepk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 10:40:13 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35EAeCGa032389
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 10:40:12 GMT
Received: from [10.201.197.30] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 14 Jun
 2023 03:40:04 -0700
Message-ID: <9b13814e-fa3a-9e81-e444-93b566b3cb53@quicinc.com>
Date:   Wed, 14 Jun 2023 16:10:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: document MI04.1 board based
 on IPQ5332 family
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
References: <20230606095732.12884-1-quic_harihk@quicinc.com>
 <20230606095732.12884-2-quic_harihk@quicinc.com>
 <d4970017-86b5-884f-fe67-6fede30469b4@linaro.org>
 <20230613230416.flhnzaiuy4imzs2z@ripper>
From:   Hariharan K <quic_harihk@quicinc.com>
In-Reply-To: <20230613230416.flhnzaiuy4imzs2z@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 84drULy0wyvL2KWpXrHMLQl1eKDZpSDU
X-Proofpoint-ORIG-GUID: 84drULy0wyvL2KWpXrHMLQl1eKDZpSDU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_06,2023-06-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140091
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/2023 4:34 AM, Bjorn Andersson wrote:
> On Tue, Jun 06, 2023 at 01:28:27PM +0200, Krzysztof Kozlowski wrote:
>> On 06/06/2023 11:57, Hariharan K wrote:
>>> Document the MI04.1 (Reference Design Platform 446) board based on IPQ5332
>>> family of SoCs.
>>>
>>> Signed-off-by: Hariharan K <quic_harihk@quicinc.com>
>>> ---
>>>   Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> index 8302d1ee280d..165a815337f7 100644
>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> @@ -93,6 +93,7 @@ description: |
>>>           ap-mi01.2
>>>           ap-mi01.3
>>>           ap-mi01.6
>>> +        ap-mi04.1
>>
>> I think we need to stop adding them here... This was supposed to be
>> limited list for Qualcomm bootloader. Are you sure Qualcomm bootloader
>> requires such names with versions?
>>
> 
> Hariharan, can you please elaborate on what these numbers mean? Is this
> just a version of ap-mi04? Or do we have 5 different reference boards on
> IPQ5332, just with "cryptic" names?
> 
> Regards,
> Bjorn

Yes. These are different reference board designs based on IPQ5332.

Thanks,
Hariharan K
