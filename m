Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C12D620391
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 00:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbiKGXOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 18:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiKGXOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:14:47 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07D427142;
        Mon,  7 Nov 2022 15:14:43 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A7MQcQm022859;
        Mon, 7 Nov 2022 23:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lNxErk04K4OaaYsp9XOQ8PIihndtEF1NzdzJY7i350w=;
 b=DG5w6SD/zX4fPVIS2Yo9nsvmR+vXZkJXGDlPwJot4dPt2hvcbwC2q839BRBEeiN9L4fh
 M4/2tb5QzY2ULiNf3woV9Qkhw4P5sX/8AtHriwCU0MK7tAIbCzpWNOBeVYMns5wDo8z9
 Ae2IuxPqJB2tLlG5cFLceyWityJfCK4Ifvm0sQMFFBI+y2Kb+NQRpZOHXHlWNS9Mjxuy
 hvD82qTOqAt0vViBPpCaOsBGv5f6x8LXavUkrO1biMjp66xcL/WKuoAYyWzILATG3PMi
 gq1MHfF5YF3UplXitLcHoZCv0voS7r6+qz1MiXAwZ5O8729sKc/J4wG7ytA4LMe2Q/LB Rw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kq7g4gmw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 23:14:35 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A7NEYJA009699
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Nov 2022 23:14:34 GMT
Received: from [10.110.0.244] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 7 Nov 2022
 15:14:34 -0800
Message-ID: <a1c8aa27-5c67-6cfc-39fd-15157c91bedb@quicinc.com>
Date:   Mon, 7 Nov 2022 15:14:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 1/5] dt-bindings: firmware: scm: Add QDU1000/QRU1000
 compatibles
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221026190549.4005703-1-quic_molvera@quicinc.com>
 <20221026190549.4005703-2-quic_molvera@quicinc.com>
 <e607fe3a-b243-fbd4-51a3-d10738d456c4@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <e607fe3a-b243-fbd4-51a3-d10738d456c4@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cm7niuOJB24jkE3yvEijKxx33JWiDqBV
X-Proofpoint-GUID: cm7niuOJB24jkE3yvEijKxx33JWiDqBV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211070174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/2022 8:24 AM, Krzysztof Kozlowski wrote:
> On 26/10/2022 15:05, Melody Olvera wrote:
>> Add compatibles for scm driver for QDU1000 and QRU1000 platforms.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  .../devicetree/bindings/firmware/qcom,scm.yaml    | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> index be1b5746eddb..5352181aa393 100644
>> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> @@ -38,6 +38,7 @@ properties:
>>            - qcom,scm-msm8994
>>            - qcom,scm-msm8996
>>            - qcom,scm-msm8998
>> +          - qcom,scm-qdu1000
>>            - qcom,scm-sc7180
>>            - qcom,scm-sc7280
>>            - qcom,scm-sc8280xp
>> @@ -81,6 +82,20 @@ properties:
>>      description: TCSR hardware block
>>  
>>  allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: qcom,scm-qdu1000
>> +    then:
>> +      properties:
>> +        '#reset-cells':
>> +          maxItems: 1
> This is wrong... how can you have here more items?

Being removed anyways.

>
>> +        clocks: false
>> +        clock-names: false
>> +
>> +      required:
>> +        - '#reset-cells'
> Missing blank line.

Ack.

Thanks,
Melody
>
>>    - if:
>>        properties:
>>          compatible:
> Best regards,
> Krzysztof
>

