Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D72620382
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 00:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbiKGXMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 18:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiKGXMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:12:23 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D58A252A2;
        Mon,  7 Nov 2022 15:12:20 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A7NB6U8012309;
        Mon, 7 Nov 2022 23:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rx9W3BIhzS5QtgEfhCcmVgNCP1dr8FiEALyBkoDsobA=;
 b=GJin8FMx9KMZYAiwXknNo8YnmW9GV07P8XHRsDdd6VEnVY0H5ku+sY8F6SI1YB5+0U7J
 8d+B9MW5ypZz9YdMpllHIbaZ77xBWqUz7wBPeWNWTJ5ErTufGIzHpa9qG3jumV6KV5Ma
 N91i4YxGhFRoMpYpKSVi9FXSHaYm7qJg6a/TTF7ezN5RrJOS9D1j1fpd7r3qo74qWk94
 Gu9IM8yjV9c8x8WSzKymeQd0W2y00t8YYoe4u477KfPHezWMueq0pHFZHvCFgwuCYqBu
 3brx+eSCLJyG1z47vXgaevl54K0lFTfd7UjX3lR03x1L05k8YaOek8zNECp0pdT5HqM2 Dg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kq5ftruay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 23:12:16 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A7NCFIu023855
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Nov 2022 23:12:15 GMT
Received: from [10.110.0.244] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 7 Nov 2022
 15:12:14 -0800
Message-ID: <bf9b6c4a-189e-b528-10e4-7660a098c648@quicinc.com>
Date:   Mon, 7 Nov 2022 15:12:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 1/5] dt-bindings: firmware: scm: Add QDU1000/QRU1000
 compatibles
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221026190549.4005703-1-quic_molvera@quicinc.com>
 <20221026190549.4005703-2-quic_molvera@quicinc.com>
 <20221107173842.6ct43x7wyuulqv33@builder.lan>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <20221107173842.6ct43x7wyuulqv33@builder.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YgknJlRt5q6lQXqs-efM9bJZdmtbyHNw
X-Proofpoint-ORIG-GUID: YgknJlRt5q6lQXqs-efM9bJZdmtbyHNw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2022 9:38 AM, Bjorn Andersson wrote:
> On Wed, Oct 26, 2022 at 12:05:45PM -0700, Melody Olvera wrote:
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
>> +        clocks: false
>> +        clock-names: false
>> +
>> +      required:
>> +        - '#reset-cells'
> Please document what this reset is expected to be wired to, and write a
> sentence or two in the commit message how the QDU differs from existing
> platforms supported by the binding.
>

Honestly, I can't remember what this is here for. Will remove from here and DT.
Will also add a quick blurb about not needing clocks.

Thanks,
Melody
>
>>    - if:
>>        properties:
>>          compatible:
>> -- 
>> 2.25.1
>>

