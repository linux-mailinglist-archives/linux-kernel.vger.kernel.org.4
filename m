Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08246FEB73
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbjEKF7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbjEKF7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:59:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A8930C7;
        Wed, 10 May 2023 22:59:30 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34B4GmGK009238;
        Thu, 11 May 2023 05:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FhEY+h/GhVElLpNz743SwbvsQx7kkloIQE75pbqZpsk=;
 b=XPo/DCKwzI2YsYURlcqNvMIYa8FN0iuPI/aksFoYidYV4OkJ4Zfo7/TjkoxXh73FrfyW
 L5jkAmulYvpYkQAY5C07XetRl2+G4hDqbhZt4zgyAeZcyGrENApdXTKpWydgVHfvB1XI
 CYspsOMms/fUJbb0bQ+oLZ8jPOl1wo4y2e1M2+Xa49QWA0I746i7jzn9jXgvNOQg0X4J
 3mipOhfVkOzkxcmYXvwy/D4CDbGpggxJRs3m84HAzzHdpnxJDLSw4ymghgM1RR+dZfX3
 BsAiLix7hzmC7Q6DpCOLH9YOKMNKN7xthKgL7qb3aH/860unQIpVSrVXY/xSsC/tPMad GQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qgett19c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 05:59:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34B5xInG007071
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 05:59:18 GMT
Received: from [10.79.141.17] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 10 May
 2023 22:59:15 -0700
Message-ID: <15042631-4012-61bd-11ef-dde378215fed@quicinc.com>
Date:   Thu, 11 May 2023 11:29:12 +0530
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
 <10fa20f9-33d9-a8a8-3fca-f5ff320a6574@quicinc.com>
 <CAA8EJprJfmtFs1dx0uJw0bi1ig2JsCYzH_4BncPop4aO16D2aA@mail.gmail.com>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <CAA8EJprJfmtFs1dx0uJw0bi1ig2JsCYzH_4BncPop4aO16D2aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gGsmcM4e1NmjRTwT613a-cBM5by8uNij
X-Proofpoint-GUID: gGsmcM4e1NmjRTwT613a-cBM5by8uNij
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305110050
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/9/2023 6:35 PM, Dmitry Baryshkov wrote:
> On Tue, 9 May 2023 at 15:21, Souradeep Chowdhury
> <quic_schowdhu@quicinc.com> wrote:
>>
>>
>>
>> On 5/9/2023 5:05 PM, Dmitry Baryshkov wrote:
>>> On Tue, 9 May 2023 at 13:53, Souradeep Chowdhury
>>> <quic_schowdhu@quicinc.com> wrote:
>>>>
>>>> All Qualcomm bootloaders log useful timestamp information related
>>>> to bootloader stats in the IMEM region. Add the child node within
>>>> IMEM for the boot stat region containing register address and
>>>> compatible string.
>>>
>>> I might have a minor vote here. Is there any reason why you have to
>>> instantiate the device from DT?
>>> It looks like a software interface. Ideally software should not be
>>> described in DT (e.g. this can be instantiated from imem
>>> driver-to-be).
>>> Or we can follow the RPM master-stats approach, where the device is a
>>> top-level device, having handle pointers to the sram regions.
>>
>> This is a dedicated region of IMEM reserved for storing stats related
>> information. So it is represented as a child of IMEM, please
>> refer to Documentation/devicetree/bindings/sram/sram.yaml which
>> follows a similar philosophy. Also since this is a child of IMEM with
>> a specific purpose, does it not warrant a dedicated driver?
> 
> I do not question a dedicated driver. I was asking about the DT node.
> Even the mentioned bindings file describes the SRAM regions inside the
> SRAM, rather than a proper device to be instantiated in the SRAM node.
> I'd point to the boot_stats discussions (present on the list in the
> last several months).
> 

Ack. Will instantiate the device from the parent node in the driver and
access the stats region to print the boot_stats information.


>>
>>>
>>>>
>>>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>    .../devicetree/bindings/sram/qcom,imem.yaml   | 22 +++++++++++++++++++
>>>>    1 file changed, 22 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>>> index 0548e8e0d30b..bb884c5c8952 100644
>>>> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>>> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>>> @@ -50,6 +50,28 @@ patternProperties:
>>>>        $ref: /schemas/remoteproc/qcom,pil-info.yaml#
>>>>        description: Peripheral image loader relocation region
>>>>
>>>> +  "^stats@[0-9a-f]+$":
>>>> +    type: object
>>>> +    description:
>>>> +      Imem region dedicated for storing timestamps related
>>>> +      information regarding bootstats.
>>>> +
>>>> +    additionalProperties: false
>>>> +
>>>> +    properties:
>>>> +      compatible:
>>>> +        items:
>>>> +          - enum:
>>>> +              - qcom,sm8450-bootstats
>>>> +          - const: qcom,imem-bootstats
>>>> +
>>>> +      reg:
>>>> +        maxItems: 1
>>>> +
>>>> +    required:
>>>> +      - compatible
>>>> +      - reg
>>>> +
>>>>    required:
>>>>      - compatible
>>>>      - reg
>>>> --
>>>> 2.17.1
>>>>
>>>
>>>
> 
> 
> 
