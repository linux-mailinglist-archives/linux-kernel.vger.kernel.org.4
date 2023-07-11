Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F2F74EADF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjGKJkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjGKJjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:39:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F2F173D;
        Tue, 11 Jul 2023 02:39:31 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B93kDu005223;
        Tue, 11 Jul 2023 09:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2avxJUP+4HyvxRssNsSEI120gBiBgsaffbOZA3w7hDI=;
 b=I+MFNCnfTX3N3SVS48BhWKtef6ZyVJvPsvMTLNlfp+peVLEXScfB2A1hJu+zHtJTVMMB
 JE1U1snQWwviiNfEOTL8ga3L9f86r/5a8wQiJEZAOLs3BDTYZfUQNx1CfELmaKp6ZOMM
 ymjJ7FPQuftl3d2jWdT36ppuWcDb12OmAw/H29mTjUOjRlBCDMVHyl4CkSQ1IsXC2mg9
 czieFF8ZoYxi7pnjzfSdJWOe5y6MQJNK0TjuQ2LTcnrsDv3OIOYRlpES1/ioxEk4oTmh
 62DszA1uRX3I9lPqWGWpjnfahQkYmjRm0uq050fTMQBRTteUuX33T7xxiU00M7Eti+c2 yQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs442g23j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 09:39:25 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36B9dOPL005017
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 09:39:24 GMT
Received: from [10.201.3.91] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 11 Jul
 2023 02:39:19 -0700
Message-ID: <59ea653e-c5da-71cb-eb85-1aa3c72e2089@quicinc.com>
Date:   Tue, 11 Jul 2023 15:09:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/6] dt-bindings: thermal: tsens: Add nvmem cells for
 calibration data
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
References: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
 <20230710103735.1375847-2-quic_ipkumar@quicinc.com>
 <09e33a89-c060-69b1-b94f-b21c45d1d249@linaro.org>
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <09e33a89-c060-69b1-b94f-b21c45d1d249@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cOXwsqatvLm-DqG7cHYCTI0oX7ajyobY
X-Proofpoint-GUID: cOXwsqatvLm-DqG7cHYCTI0oX7ajyobY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110085
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/11/2023 1:40 AM, Krzysztof Kozlowski wrote:
> On 10/07/2023 12:37, Praveenkumar I wrote:
>> Add TSENS V2 calibration nvmem cells for IPQ5332
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
>>   .../bindings/thermal/qcom-tsens.yaml          | 26 +++++++++++++++++--
>>   1 file changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> index 27e9e16e6455..8b7863c3989e 100644
>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> @@ -91,7 +91,7 @@ properties:
>>       maxItems: 2
>>   
>>     nvmem-cells:
>> -    oneOf:
>> +    anyOf:
>>         - minItems: 1
>>           maxItems: 2
>>           description:
>> @@ -106,9 +106,13 @@ properties:
>>           description: |
>>             Reference to nvmem cells for the calibration mode, two calibration
>>             bases and two cells per each sensor, main and backup copies, plus use_backup cell
>> +      - maxItems: 17
>> +        description: |
>> +          V2 of TSENS, reference to nvmem cells for the calibration mode, two calibration
>> +          bases and one cell per each sensor
> I think this is already included in one of the previous entries.
> Otherwise, are you sure that all new devices will have exactly 17 entries?
Previous entries does not support TSENS version 2.X.X QFPROM. TSENS V2 
QFPROM has mode, base0, base1 and s[0-15]+_offset.
Ideally it should be like,
- minItems: 4
- maxItems: 19
But dt binding check fails in oneOf / anyOf condition. So added the 
IPQ5332 properties which is exactly 17.
>
>>   
>>     nvmem-cell-names:
>> -    oneOf:
>> +    anyOf:
>>         - minItems: 1
>>           items:
>>             - const: calib
>> @@ -205,6 +209,24 @@ properties:
>>             - const: s9_p2_backup
>>             - const: s10_p1_backup
>>             - const: s10_p2_backup
>> +      - items:
>> +          - const: mode
>> +          - const: base0
>> +          - const: base1
>> +          - const: s0_offset
>> +          - const: s3_offset
>> +          - const: s4_offset
>> +          - const: s5_offset
>> +          - const: s6_offset
>> +          - const: s7_offset
>> +          - const: s8_offset
>> +          - const: s9_offset
>> +          - const: s10_offset
>> +          - const: s11_offset
>> +          - const: s12_offset
>> +          - const: s13_offset
>> +          - const: s14_offset
>> +          - const: s15_offset
> Don't introduce new naming style. Existing uses s[0-9]+, without offset
> suffix. Why this should be different?
As I mentioned above, s[0-9]+_p1 / s[0-9]+p2 is for TSENS V1. TSENS V2 
QFPROM layout is different from the existing one.
I would like to add mode, base0, base1 and 16 patterns 
'^s[0-15]+_offset$'. But DT binding check is failing in oneOf/ anyOf 
condintion.

--
Thanks,
Praveenkumar
>
>>   
>>     "#qcom,sensors":
>>       description:
> Best regards,
> Krzysztof
>
