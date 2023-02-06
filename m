Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7CD68B860
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjBFJMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjBFJMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:12:50 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5872738;
        Mon,  6 Feb 2023 01:12:47 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3168wI3P023613;
        Mon, 6 Feb 2023 09:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kPU4LanfrxPAVcvEHDqTZjjEa6nsK0fd0Y86O7cOPEE=;
 b=I0J+4W2JXAvplValyVxgvI14IrvSX+wXsYwC7dT6KziQvorYoqeXg+KByLl6HWel3EJr
 sdosU0IjGkyePGrlPJ0FLPiFW2NKtfWI7yL/IZxX17iksU9tjrKir0eWmzjfIo8jN6FY
 zsaKZblTQKRCWdG9fWfa5W9rFjSK55BZL+fnwStaqHC+EGyCUjvUpxxurfTwqqaIF6f6
 oda5r/eMvQCqiIU4I3QNH6CbF+KZEUmotWuTl0bYdtxWWYgIc2pRWA2R0zC10YG16bad
 eJWJJ45xz1xmBKbo/jQsPIqyymPP1mnrDLQH8rUFR+42FEJg6SML/VFgOUc3/S8Ls83q xg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhfreu9f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 09:12:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3169CgPi000927
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Feb 2023 09:12:42 GMT
Received: from [10.50.19.98] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 01:12:38 -0800
Message-ID: <eea6beee-7867-137c-2124-08d81b2ec989@quicinc.com>
Date:   Mon, 6 Feb 2023 14:42:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 4/6] dt-bindings: mailbox: qcom: add compatible for the
 IPQ5332 SoC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230202145208.2328032-1-quic_kathirav@quicinc.com>
 <20230202145208.2328032-5-quic_kathirav@quicinc.com>
 <3a346606-576b-ab89-78f5-5bbaca729090@linaro.org>
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <3a346606-576b-ab89-78f5-5bbaca729090@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NLlgrOX80IamRhbfQX-QKQ3--HDFHR6u
X-Proofpoint-GUID: NLlgrOX80IamRhbfQX-QKQ3--HDFHR6u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_03,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302060081
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/2/2023 9:05 PM, Krzysztof Kozlowski wrote:
> On 02/02/2023 15:52, Kathiravan T wrote:
>> Add the mailbox compatible for the IPQ5332 SoC.
>>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
>>   .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml     | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
>> index 943f9472ae10..8d8cd1bbe67e 100644
>> --- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
>> +++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
>> @@ -18,6 +18,7 @@ properties:
>>       oneOf:
> - items:
>      - enum:
>          - qcom,ipq5332-apcs-apps-global
>      - const: qcom,ipq6018-apcs-apps-global
>
> and drop the next patch


Hi Krzysztof,

I'm planning to post the V2 of this series. How do you want me to 
proceed? I see you posted separate series[1]. May be I can follow the 
suggestion which you shared above, starting with IPQ?

[1] 
https://lore.kernel.org/linux-arm-msm/20230202161856.385825-1-krzysztof.kozlowski@linaro.org/


Thanks,

>
>
> Best regards,
> Krzysztof
>
