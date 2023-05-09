Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158006FC628
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbjEIMWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEIMWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:22:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEA919A9;
        Tue,  9 May 2023 05:22:05 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34997NEF026683;
        Tue, 9 May 2023 12:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0lNTCbS7rvx4PJAKtw4AU366VO4Oe1kdqpuxiXwHoL0=;
 b=nF4wo8XI/hhlBBXvl/4mFhHRA1t6mvVo6HWcDM4Ha/73/IGgCRD+FLJNaaONeudoHU2O
 oA58RnBo0w3LDZz71NYN9MRvluindAEBMBWkQ8vOH/y4iQc6ZwV3Q9IjsuuNMLgUJiGX
 e2+wOvGCqR1A0XGnr0wY4oGSn+0yTR9R6Pt0jK6ZfXdnX8jvXE4sfF3HUNbrC8fqYhoW
 LMuGMBfQJasj0d9jYq/PVJ96XgskZj/PCbOlb5AtZm6FAu+8dVNt0n8L9zuJHodZYg41
 72DbNh5xUb+XW6SNdmKCiOM6v+MWO4FJn6mmhy07CmZ7RKfxHuFjtdKKaBahJQw4UGo8 MA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf77g1qrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 12:21:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 349CLrCR001841
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 12:21:53 GMT
Received: from [10.50.37.86] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 9 May 2023
 05:21:50 -0700
Message-ID: <10fa20f9-33d9-a8a8-3fca-f5ff320a6574@quicinc.com>
Date:   Tue, 9 May 2023 17:51:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V6 1/3] dt-bindings: sram: qcom,imem: Add Boot Stat region
 within IMEM
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>
References: <cover.1683628357.git.quic_schowdhu@quicinc.com>
 <343182748e12b6a4ac57d336405c50e36fc5520c.1683628357.git.quic_schowdhu@quicinc.com>
 <CAA8EJpp2x2OEB2sg+caKmjkDYJp_NJ9mXo85FxTZr-9zRXHNhw@mail.gmail.com>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <CAA8EJpp2x2OEB2sg+caKmjkDYJp_NJ9mXo85FxTZr-9zRXHNhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qu5gSk9OIPJiJm02zBFbEmYtJLuwuN2R
X-Proofpoint-ORIG-GUID: qu5gSk9OIPJiJm02zBFbEmYtJLuwuN2R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305090099
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/9/2023 5:05 PM, Dmitry Baryshkov wrote:
> On Tue, 9 May 2023 at 13:53, Souradeep Chowdhury
> <quic_schowdhu@quicinc.com> wrote:
>>
>> All Qualcomm bootloaders log useful timestamp information related
>> to bootloader stats in the IMEM region. Add the child node within
>> IMEM for the boot stat region containing register address and
>> compatible string.
> 
> I might have a minor vote here. Is there any reason why you have to
> instantiate the device from DT?
> It looks like a software interface. Ideally software should not be
> described in DT (e.g. this can be instantiated from imem
> driver-to-be).
> Or we can follow the RPM master-stats approach, where the device is a
> top-level device, having handle pointers to the sram regions.

This is a dedicated region of IMEM reserved for storing stats related 
information. So it is represented as a child of IMEM, please
refer to Documentation/devicetree/bindings/sram/sram.yaml which
follows a similar philosophy. Also since this is a child of IMEM with
a specific purpose, does it not warrant a dedicated driver?

> 
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   .../devicetree/bindings/sram/qcom,imem.yaml   | 22 +++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>> index 0548e8e0d30b..bb884c5c8952 100644
>> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>> @@ -50,6 +50,28 @@ patternProperties:
>>       $ref: /schemas/remoteproc/qcom,pil-info.yaml#
>>       description: Peripheral image loader relocation region
>>
>> +  "^stats@[0-9a-f]+$":
>> +    type: object
>> +    description:
>> +      Imem region dedicated for storing timestamps related
>> +      information regarding bootstats.
>> +
>> +    additionalProperties: false
>> +
>> +    properties:
>> +      compatible:
>> +        items:
>> +          - enum:
>> +              - qcom,sm8450-bootstats
>> +          - const: qcom,imem-bootstats
>> +
>> +      reg:
>> +        maxItems: 1
>> +
>> +    required:
>> +      - compatible
>> +      - reg
>> +
>>   required:
>>     - compatible
>>     - reg
>> --
>> 2.17.1
>>
> 
> 
