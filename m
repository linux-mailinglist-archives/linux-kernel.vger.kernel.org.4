Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674807469EE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjGDGrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjGDGrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:47:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EDC1729;
        Mon,  3 Jul 2023 23:47:16 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3645UYQl001127;
        Tue, 4 Jul 2023 06:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LADTz5KFksR3v4SZaVmK8Y3HhLsFpalC3H2cpMc/Fk4=;
 b=ZHY3XRGSNC//Ypc9Xq7ouQf7jVXito/HFjaCgxlEA5ajCOzYYfQLJhsMHEM7MHfB4EWT
 YrxG5tZsj9UrDls5VGbkXXyLZuvx70IUshg/zdjOtTL19KS7BYW6PN76AYxACU1QTXtC
 4EcBHuAohg5IxdLHThBwnnvkHE7p8FGY+XsUP3bpjrM1rmT72AcxZNhRKwwCBv75BD1h
 lkViYECW9bR/scHgYaPjP5ba5OyhekHBxhuvqXgMNwAPUEOFX657pIaD8BOdJEjuaPz3
 wkHk6+7IJJPKL+OU0PRLdc6iIj/ujWfBnRRMSxYahKiSRkPo9uLWOOFPbM24J8wBD9/I mA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rm0061fus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 06:46:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3646kZAP024247
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jul 2023 06:46:35 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Mon, 3 Jul 2023
 23:45:59 -0700
Message-ID: <23832e02-880a-4f7d-2580-7889ede61171@quicinc.com>
Date:   Tue, 4 Jul 2023 12:15:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 01/10] dt-bindings: regulator: Add PMX75 compatibles
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <sboyd@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
References: <1688395346-3126-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688395346-3126-2-git-send-email-quic_rohiagar@quicinc.com>
 <9412f498-64ad-5f08-7184-b7ff4403afdd@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <9412f498-64ad-5f08-7184-b7ff4403afdd@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VbQ7Pl4cb-OxL8FQSIprJiYorry3reeG
X-Proofpoint-GUID: VbQ7Pl4cb-OxL8FQSIprJiYorry3reeG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_03,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=934 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040056
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/4/2023 11:51 AM, Krzysztof Kozlowski wrote:
> On 03/07/2023 16:42, Rohit Agarwal wrote:
>> Add PMX75 compatibles for PMIC found in SDX75 platform.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
>> index b949850..cc72144 100644
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
> You miss the update to the if:then: parts.
Thanks for your time. Will add that part as well.

Thanks,
Rohit.
>
> Best regards,
> Krzysztof
>
