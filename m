Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FC05F465D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJDPQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJDPQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:16:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0713474C6;
        Tue,  4 Oct 2022 08:16:52 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294F8UGK003116;
        Tue, 4 Oct 2022 15:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XFEvDe0O3v7gwItvJVTiZ4zJCqwGX5S3opVkXW1SG+w=;
 b=Eq/NQgde0oMpHWxw5MMNlMl0/8yBZzVPTvRcx7/ppUucmaxAvPb1Jj4x+nLq3F8znPS7
 q67G18wnSlsnCIsApEDcY2GjUjAUInjXr0gkqx5GFu3IqNYUI+/UPanf/tWQgapG6tg5
 992aeRKWf+i30UCIngOvNrF3QjLhICgq2eT3LvwFyI35JU2eiJNnuQirWwS3TH38AMGD
 twjFXawBldQm9wJ6nFLob5qwS5g731m67DBYQeaR1/69Z+epfO4rEHm47ryVL/ru+ync
 va3hwJo6GOrnF+Uq5y20zqoBLppsovR7llcmjEv3IZpF6J7aqq6f0e+01wle/K2byfkc DQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0escs09a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 15:16:49 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 294FGnGA026498
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Oct 2022 15:16:49 GMT
Received: from [10.110.73.50] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 08:16:48 -0700
Message-ID: <19a54de8-d769-ab65-6332-6a8ff68e1437@quicinc.com>
Date:   Tue, 4 Oct 2022 10:16:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/5] dt-bindings: arm: qcom: Document QDU1000/QRU1000 SoCs
 and boards
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221001030641.29354-1-quic_molvera@quicinc.com>
 <20221001030641.29354-3-quic_molvera@quicinc.com>
 <59d306a6-989a-ecf8-0262-7562d110bf0e@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <59d306a6-989a-ecf8-0262-7562d110bf0e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8LkLVw7seFC1JepF5_AU6A7Za_6fIRx0
X-Proofpoint-GUID: 8LkLVw7seFC1JepF5_AU6A7Za_6fIRx0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 mlxlogscore=830 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040099
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/1/2022 4:26 AM, Krzysztof Kozlowski wrote:
> On 01/10/2022 05:06, Melody Olvera wrote:
>> Document the QDU1000 and QRU1000 SoC bindings and the boards that use
>> them.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/arm/qcom.yaml | 16 ++++++++++++++++
> This patch goes with DT.
Will move to the dt PS.
>
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index fb1d00bcc847..1cfd92f4ab5d 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -61,6 +61,8 @@ description: |
>>          sm8250
>>          sm8350
>>          sm8450
>> +        qdu1000
>> +        qru1000
>>  
>>    The 'board' element must be one of the following strings:
>>  
>> @@ -76,6 +78,7 @@ description: |
>>          mtp
>>          qrd
>>          sbc
>> +        x100
>>  
>>    The 'soc_version' and 'board_version' elements take the form of v<Major>.<Minor>
>>    where the minor number may be omitted when it's zero, i.e.  v1.0 is the same
>> @@ -718,6 +721,19 @@ properties:
>>                - qcom,sm8450-qrd
>>            - const: qcom,sm8450
>>  
>> +      - description: Qualcomm Technologies, Inc. Distributed Unit 1000 platform
>> +          - items:
>> +              - enum:
>> +                  - qcom,qdu1000-idp
>> +                  - qcom,qdu1000-x100
>> +              - const: qcom,qdu1000
> Wrong order - you put it in some odd place.
Will put in alphabetical order.
>
>> +
>> +      - description: Qualcomm Technologies, Inc. Radio Unit 1000 platform
>> +          - items:
>> +              - enum:
>> +                  -qcom,qru1000-idp
> Missing space.
Whoops; will fix.
>
>> +              - const: qcom,qru1000
>> +
>>  additionalProperties: true
>>  
>>  ...
> Best regards,
> Krzysztof

Thanks,

Melody

