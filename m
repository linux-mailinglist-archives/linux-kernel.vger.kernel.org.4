Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731EF74E72B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjGKGWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjGKGWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:22:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C79AE51;
        Mon, 10 Jul 2023 23:22:42 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B6Fvpb016852;
        Tue, 11 Jul 2023 06:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9th3Yn9+UmkvDmdmjhff8pvOb+OMrDIo2KZKn7m0G2A=;
 b=N+lXOHrnu0Gh7DFOxWm8zi2Wk8CvkKdvpBC98PRflbk2eCZSuuxmIJkFJNu5bunJzNA2
 CRh4Oucw0d9XM1HkfbasayevaUxBNtphOFjb6TfSZn7zRYlVfMF+W+mziMYiVGE6U371
 skYca2TMWS6g47cwNXVBJMW7VO0/O1J6qN81iBpSl6GaFJfMe7j/UNhVyFkBfGXmxosO
 bGTXskBvs9MgiAZsBRXAjQcYj1vmI6L0DjJuIBg16x1rq0kWh6jlP+nqUC/QM60eSiMk
 Y1z/dY2XdbAL5Lu8KZfWO58Z8f/8hhlXRu3z4SScq04EUp3esIG/Qsa1dPNfoqL6Vzpb Yg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs1mnr0gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 06:22:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36B6Mbii019094
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 06:22:37 GMT
Received: from [10.214.27.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 10 Jul
 2023 23:22:34 -0700
Message-ID: <fc054877-52c6-9e61-8572-3068c53a86de@quicinc.com>
Date:   Tue, 11 Jul 2023 11:52:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: Add PMX75 compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1689054415-11281-1-git-send-email-quic_rohiagar@quicinc.com>
 <1689054415-11281-2-git-send-email-quic_rohiagar@quicinc.com>
 <8eb986f2-3268-65cd-9210-ef1fca4f8259@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <8eb986f2-3268-65cd-9210-ef1fca4f8259@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hxXpgoypPTEAbrga6xhN49GTxiiWPo4v
X-Proofpoint-GUID: hxXpgoypPTEAbrga6xhN49GTxiiWPo4v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_03,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110054
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/11/2023 11:35 AM, Krzysztof Kozlowski wrote:
> On 11/07/2023 07:46, Rohit Agarwal wrote:
>> Add PMX75 compatibles for PMIC found in SDX75 platform.
>> While at it, update the entry for SDX65 as well.
> Everything is an update...
>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   .../bindings/regulator/qcom,rpmh-regulator.yaml    | 22 +++++++++++++++++++++-
>>   1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
>> index b949850..72b533c 100644
>> --- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
>> +++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
>> @@ -53,6 +53,7 @@ description: |
>>         For PMR735A, smps1 - smps3, ldo1 - ldo7
>>         For PMX55, smps1 - smps7, ldo1 - ldo16
>>         For PMX65, smps1 - smps8, ldo1 - ldo21
>> +      For PMX75, smps1 - smps10, ldo1 - ldo21
>>   
>>   properties:
>>     compatible:
>> @@ -84,6 +85,7 @@ properties:
>>         - qcom,pmr735a-rpmh-regulators
>>         - qcom,pmx55-rpmh-regulators
>>         - qcom,pmx65-rpmh-regulators
>> +      - qcom,pmx75-rpmh-regulators
>>   
>>     qcom,pmic-id:
>>       description: |
>> @@ -424,10 +426,28 @@ allOf:
>>           vdd-l11-l13-supply: true
>>         patternProperties:
>>           "^vdd-l[1347]-supply$": true
>> -        "^vdd-l1[0245789]-supply$": true
>> +        "^vdd-l1[024579]-supply$": true
> Why? Does not look related at all.
This update is because sdx65 does not have vdd-l18-supply separately and 
its
already part of vdd-l2-l18-supply property mentioned in the properties 
field.

Thanks,
Rohit.
>
> Best regards,
> Krzysztof
>
