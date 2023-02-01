Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AA3686519
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjBALMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjBALMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:12:12 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E088746D43;
        Wed,  1 Feb 2023 03:12:11 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311B0Cxw030591;
        Wed, 1 Feb 2023 11:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=f+ay/XQ1m8efqa7jntDJ4D4LRxQl760jlgxohFYD660=;
 b=XW5cbKVd8M4+n/9G2wx6CXpR3DML1d+a8BMSa6AUr80Q3JpUThb4uDdV/mm5FmoGpb20
 EwpXgXisNIncm7vHZWOYkt1I1oaEjQvl6RRDGPueit45RUTX7zyNW77MyeKdWzMlOILl
 8+8ap8mxoQWLjppYKuOB9mwLg5fVLBQxlAXaJrbliq94XVdMTcBP3zJx098SN5cyu2rc
 aS3zF65nLKn8qDHGPCUr4c8A/61Yhf1w4n3UGU4IYk8UAaddPIdcw3Hr0luUydsPqpV1
 dQNlE83YEU9/ErlEtzQBY2wuiTYgXmN37ePIf8l+S9uU8NioyfJVR9abebhSiu7sDoaC vw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfnck06qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 11:11:52 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 311BBphM026192
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 11:11:51 GMT
Received: from [10.216.7.142] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 03:11:42 -0800
Message-ID: <4eefc7a5-9361-0147-b4e9-c70f25e9c7f2@quicinc.com>
Date:   Wed, 1 Feb 2023 16:41:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V2 5/5] dt-bindings: tcsr: Add compatible for IPQ9574
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <jassisinghbrar@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <robimarko@gmail.com>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_devipriy@quicinc.com>
References: <20230201090529.30446-1-quic_poovendh@quicinc.com>
 <20230201090529.30446-6-quic_poovendh@quicinc.com>
 <Y9o5onFcETRUmqGt@google.com>
From:   POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>
In-Reply-To: <Y9o5onFcETRUmqGt@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eOcIrUdIIFCdtF28N0cDtUjTwvkVtceX
X-Proofpoint-ORIG-GUID: eOcIrUdIIFCdtF28N0cDtUjTwvkVtceX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=888 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010097
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/1/2023 3:36 PM, Lee Jones wrote:
> On Wed, 01 Feb 2023, Poovendhan Selvaraj wrote:
>
>> Add the tcsr compatible string for IPQ9574 SoC
>>
>> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>>   1 file changed, 1 insertion(+)
> Nit: Subject should be "dt-bindings: mfd: ..."
Sure, Okay.

Regards,
Poovendhan S

>> diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
>> index d463fb47278f..8cd0005fc8c7 100644
>> --- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
>> @@ -30,6 +30,7 @@ properties:
>>             - qcom,tcsr-apq8084
>>             - qcom,tcsr-ipq6018
>>             - qcom,tcsr-ipq8064
>> +          - qcom,tcsr-ipq9574
>>             - qcom,tcsr-mdm9615
>>             - qcom,tcsr-msm8226
>>             - qcom,tcsr-msm8660
>> -- 
>> 2.17.1
>>
