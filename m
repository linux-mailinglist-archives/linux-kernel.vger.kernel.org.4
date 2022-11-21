Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8D463293C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiKUQRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiKUQRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:17:16 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C031D39D2;
        Mon, 21 Nov 2022 08:17:15 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALGFrUU003901;
        Mon, 21 Nov 2022 16:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=d1bj0Jd0Qilb/tCfeYP9/FCeyYOKVwD2wEDhQR02Kpo=;
 b=XWhkiSVSVkJ+BUqp+nXk0F9fE7yKYu8GGwndn3ARW+K+r/na9D6npxWHtY1jNOaEXnd3
 /JfWtWOtlp67SA8Wb//mseZC98NPlQ1++A6RGrdlARkKemq/OPj6mO/b20IthoGdmg+S
 NZj0iQRuj+KjcYs36pDjLvSEdAFrPHVCvh6gQU+wspFzbfv+H9Uw+aPJMJ/LdkGPkuSl
 lDc3sSlkt6rCeZrhytUkdQTTMuTW4F0qPrIU5uyDStHJHBVREDlC0/T+aY/8j6HIWRps
 3oC91CrGwsLxdDR4Kt8WJzvjDkKRxc6vQmsBQXwT3OKLS1sB2KLtwCXXw8ADs4j5c3/a dQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrut4tyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 16:17:11 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ALGHALG018094
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 16:17:10 GMT
Received: from [10.110.36.88] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 21 Nov
 2022 08:17:09 -0800
Message-ID: <2f63c7df-f220-ad80-1ec8-a5d13e866be8@quicinc.com>
Date:   Mon, 21 Nov 2022 10:17:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] dt-bindings: firmware: scm: Add QDU1000/QRU1000
 compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
CC:     "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221118182614.11774-1-quic_molvera@quicinc.com>
 <94f23d11-dfa3-fd86-32ed-937c78592f20@linaro.org>
Content-Language: en-US
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <94f23d11-dfa3-fd86-32ed-937c78592f20@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YYrcvIAfbPxWjMDOUV3fcKjfXA-NUxY_
X-Proofpoint-ORIG-GUID: YYrcvIAfbPxWjMDOUV3fcKjfXA-NUxY_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_14,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 clxscore=1011 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211210126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/2022 4:45 AM, Krzysztof Kozlowski wrote:
> On 18/11/2022 19:26, Melody Olvera wrote:
>> Add compatible for scm driver for QDU1000 and QRU1000 platforms. These drivers
>> only require the compatible field, so update the bindings accordingly for
>> these platforms.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>> This patch is separated out from [1] and includes
>> changes addressing comments from that patch set.
>>
>> [1] https://lore.kernel.org/all/20221026190549.4005703-2-quic_molvera@quicinc.com/
> Then this is a v4. Please always include the changelog.

Apologies.

>
> Did you implement the changes requested? If they are no changes, then
> review would stay the same as before.

Yes the changes requested are implemented; this document is different from the
one originally submitted.

Thanks,
Melody
>
>>  .../devicetree/bindings/firmware/qcom,scm.yaml        | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> index 25688571ee7c..71012d43a32f 100644
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
>> @@ -82,6 +83,16 @@ properties:
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
>> +        clocks: false
>> +        clock-names: false
>> +
>>    - if:
>>        properties:
>>          compatible:
>>
>> base-commit: 147307c69ba4441ee90c1f8ce8edf5df4ea60f67
> Best regards,
> Krzysztof
>

