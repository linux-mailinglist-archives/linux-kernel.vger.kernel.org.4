Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2071267E9F4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbjA0Pql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjA0PqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:46:13 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C74883275;
        Fri, 27 Jan 2023 07:45:43 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RFe3sS014988;
        Fri, 27 Jan 2023 15:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jw/pdfg7ganUSJNGxHljqeZbXL187Rr6P3gZUWxDpek=;
 b=all0PdFPnCLGrfjGcv0iNsbHa6vIAYli24+/duDv+5+WidMaNjwv6SY2ELFhuia/Z4de
 O2kSuPBC7cAnJVkr3nI0pi+JmiBVpchkWr25U7Qr+bMt9nesUJP/VY6c82A0hWpUW7cr
 f6FLrQzLqzknxFK9SUWlmJy2WznpfMrPTi1aUz1CztuuUPj9w1qrZVK2tXCDbSRLxOC0
 V7jHlFd8J6hRUTSVwbxSuCr2D+yFgs0p2pVZdeSDJqU/bEa6DS88qoWPAtk+xy2tKfMq
 cR+e8APUSs2YNH2OSvDq4SK4uONnb5T8Vbed1FsW4rHifiHTFBaafHGcP33pxuZU//tn 7Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncheyr0bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 15:45:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30RFjCfR030673
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 15:45:12 GMT
Received: from [10.50.41.100] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 27 Jan
 2023 07:45:05 -0800
Message-ID: <fd8f34fa-77d1-98c4-64f3-cc5ffeb7bd0e@quicinc.com>
Date:   Fri, 27 Jan 2023 21:15:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5/6] dt-bindings: mailbox: Add compatible for IPQ9574
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <jassisinghbrar@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230113143647.14961-1-quic_devipriy@quicinc.com>
 <20230113143647.14961-6-quic_devipriy@quicinc.com>
 <83718846-1c51-d102-d11a-a14860be8454@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <83718846-1c51-d102-d11a-a14860be8454@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cGHARq-d65gP1i2G3XdnzqN4GCnuAheS
X-Proofpoint-GUID: cGHARq-d65gP1i2G3XdnzqN4GCnuAheS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_09,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=990 spamscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270146
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/2023 8:43 PM, Konrad Dybcio wrote:
> 
> 
> On 13.01.2023 15:36, devi priya wrote:
>> Add the mailbox compatible string for IPQ9574 SoC
>>
>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> ---
> Binding changes should come before driver changes, so that
> you're not introducing an "illegal" compatible and only
> "legalize" it later - please reorder the patch.
> 
> Konrad
Understood, will reorder the patches in V2
>>   .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml     | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
>> index 943f9472ae10..9e076758a58a 100644
>> --- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
>> +++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
>> @@ -20,6 +20,7 @@ properties:
>>             - enum:
>>                 - qcom,ipq6018-apcs-apps-global
>>                 - qcom,ipq8074-apcs-apps-global
>> +              - qcom,ipq9574-apcs-apps-global
>>                 - qcom,msm8976-apcs-kpss-global
>>                 - qcom,msm8996-apcs-hmss-global
>>                 - qcom,msm8998-apcs-hmss-global
>> @@ -113,6 +114,7 @@ allOf:
>>             enum:
>>               - qcom,ipq6018-apcs-apps-global
>>               - qcom,ipq8074-apcs-apps-global
>> +            - qcom,ipq9574-apcs-apps-global
>>       then:
>>         properties:
>>           clocks:
>> @@ -129,6 +131,7 @@ allOf:
>>             enum:
>>               - qcom,ipq6018-apcs-apps-global
>>               - qcom,ipq8074-apcs-apps-global
>> +            - qcom,ipq9574-apcs-apps-global
>>       then:
>>         properties:
>>           '#clock-cells':
Best Regards,
Devi Priya
