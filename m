Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FF7704751
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjEPIFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjEPIFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:05:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB64469F;
        Tue, 16 May 2023 01:05:34 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34G6WjNS030536;
        Tue, 16 May 2023 08:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=E4kETU/bgdAp48Vc9CYxxz7aGuqStSJykDGqUXfAonI=;
 b=aRygt18pL6e80ousW2e+32Ap9xA54kxrdsps4c7NBrdNfLVXcxi/Q+EMO1Ti7CInRhnI
 Dr9Lzz87NCvDmgQR74G2HfnX/YW/oDXjxpZSgT+cO66KcF/JSEjkAKDTplAm56/aWfAH
 QvwFSnRYEBJlTFxcFVqBUnxqCkSiZCPEabA4aQKcgL06YfX6x/q+KEOct2HcRWAUJXKz
 1gPEYwZfD4r+RnXjnF2fwnOvCB7BV6HcrvsW5fSRPw+pEsoRK35JaBX5ejblTYJwxMLp
 wlIHLN2gAPeP7dqDCYdl3iQXbrR/ByaR1rc+N2TUjWnHmD8B0WLaUGzdr3w4t3wkfbaU nA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qkt9w15ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 08:05:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34G85Epx027068
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 08:05:14 GMT
Received: from [10.216.33.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 16 May
 2023 01:05:06 -0700
Message-ID: <99213d31-c0a1-e0ce-d58d-36f392ad9095@quicinc.com>
Date:   Tue, 16 May 2023 13:35:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 1/4] dt-bindings: clock: Add crypto clock and reset
 definitions
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <thara.gopinath@gmail.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-arm-msm@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_poovendh@quicinc.com>
References: <20230515150722.12196-1-quic_anusha@quicinc.com>
 <20230515150722.12196-2-quic_anusha@quicinc.com>
 <4f68a71f-b9ea-7240-8d82-5578b9a94fbc@linaro.org>
From:   Anusha Canchi <quic_anusha@quicinc.com>
In-Reply-To: <4f68a71f-b9ea-7240-8d82-5578b9a94fbc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4k1sACSEcNOzNnaTTx6WQDLgcRvAss42
X-Proofpoint-ORIG-GUID: 4k1sACSEcNOzNnaTTx6WQDLgcRvAss42
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_02,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160069
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/2023 1:15 PM, Bhupesh Sharma wrote:
>
> On 5/15/23 8:37 PM, Anusha Rao wrote:
>> Add crypto clock and reset ID definitions for ipq9574.
>>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> ---
>>   Changes in V2:
>>     - Separated out the clock/reset binding changes to a new patch.
>>
>>   include/dt-bindings/clock/qcom,ipq9574-gcc.h | 4 ++++
>>   include/dt-bindings/reset/qcom,ipq9574-gcc.h | 1 +
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h 
>> b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
>> index 5a2961bfe893..86790efa10f0 100644
>> --- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
>> +++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
>> @@ -210,4 +210,8 @@
>>   #define GCC_SNOC_PCIE1_1LANE_S_CLK            201
>>   #define GCC_SNOC_PCIE2_2LANE_S_CLK            202
>>   #define GCC_SNOC_PCIE3_2LANE_S_CLK            203
>> +#define CRYPTO_CLK_SRC                    204
>
> For uniformity, please use GCC_ prefix int the above define as well.
> Also make the similar changes at the places where this CLOCK_SRC macro 
> is used.
Sure, will update in the next spin.

Thanks,
Anusha
>
> Thanks,
> Bhupesh
>
>> +#define GCC_CRYPTO_CLK 205
>> +#define GCC_CRYPTO_AXI_CLK                206
>> +#define GCC_CRYPTO_AHB_CLK                207
>>   #endif
>> diff --git a/include/dt-bindings/reset/qcom,ipq9574-gcc.h 
>> b/include/dt-bindings/reset/qcom,ipq9574-gcc.h
>> index d01dc6a24cf1..c709d103673d 100644
>> --- a/include/dt-bindings/reset/qcom,ipq9574-gcc.h
>> +++ b/include/dt-bindings/reset/qcom,ipq9574-gcc.h
>> @@ -160,5 +160,6 @@
>>   #define GCC_WCSS_Q6_BCR                        151
>>   #define GCC_WCSS_Q6_TBU_BCR                    152
>>   #define GCC_TCSR_BCR                        153
>> +#define GCC_CRYPTO_BCR                        154
>>     #endif

