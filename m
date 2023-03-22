Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4F06C4BE3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCVNeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjCVNer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:34:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A981F1C7C2;
        Wed, 22 Mar 2023 06:34:46 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MAqXta016074;
        Wed, 22 Mar 2023 13:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=YgVZtbUR9p2k85+G8QC4fqCb8I2QJV0Myy+6LpBaJ1o=;
 b=dtuVHfOXuCuS939os10u+epPm9NBN3oVRXg8tUU5bnZTRZkN0IZ6AuIJrNQB1kpDFKlX
 zq52YVW6F7Cen+xZGb9x0g09FfZU36TRVDbHmxRAlbZ6cNRFN2C0ywPe2V7mhAXQoP81
 ippKpSi3b338N1Fg3gjGPtblmLJHEcDAHqwoy7Jp6upFDWWToNINJOjMAsuwTm7CRLpE
 CiAwaDUMVR3qIvp/iZ+jnXOVxrglFXe0fV4x7z+QdRhR4mJYusnb5bReBtas3TMSx9kM
 13ImDxDqB/twa6PwvhiyK2K7gyILnjIngaonK5j86RT0ThqCPvf4/jiUvDOX+8k1onrR qA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfhntj7y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 13:34:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32MDYNOR015936
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 13:34:23 GMT
Received: from [10.50.8.113] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Mar
 2023 06:34:19 -0700
Message-ID: <260cf3ae-1acd-c4ac-a42d-4ca848ec5664@quicinc.com>
Date:   Wed, 22 Mar 2023 19:04:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V1 1/4] dt-bindings: sram: qcom,imem: Add Boot Stat region
 within IMEM
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1679403696.git.quic_schowdhu@quicinc.com>
 <1589f33deda07cb9f9e6c3c26bce6e02e53c168e.1679403696.git.quic_schowdhu@quicinc.com>
 <c0c6c79b-ac77-cdbf-5b08-38b89e4fe481@linaro.org>
Content-Language: en-US
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <c0c6c79b-ac77-cdbf-5b08-38b89e4fe481@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kGOUVGme2fb9q39K6jMWZNO8b2mzgs2Z
X-Proofpoint-ORIG-GUID: kGOUVGme2fb9q39K6jMWZNO8b2mzgs2Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_11,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=971 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220099
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/2023 11:01 PM, Krzysztof Kozlowski wrote:
> On 21/03/2023 14:51, Souradeep Chowdhury wrote:
>> All Qualcomm bootloaders log useful timestamp information related
>> to bootloader stats in the IMEM region. Add the child node within
>> IMEM for the boot stat region containing register address and
>> compatible string.
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   .../devicetree/bindings/sram/qcom,imem.yaml          | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>> index 665c06e..c8c3890 100644
>> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>> @@ -48,6 +48,26 @@ patternProperties:
>>       $ref: /schemas/remoteproc/qcom,pil-info.yaml#
>>       description: Peripheral image loader relocation region
>>   
>> +  "^boot-stat@[0-9a-f]+$":
>> +    type: object
>> +    description:
>> +      node for boot stat.
> 
> This basically copies the name of node, so not really helpful. Describe
> what's this.

Ack
> 
>> +
> 
> additionalProperties: false
> 
>> +    properties:
>> +      compatible:
>> +        items:
> 
> Drop items.
> 
>> +          - const: qcom,imem-boot_stats
> 
> No underscores in compatibles. Why this is not SoC specific compatible?

Ack. The boot_stats module is not specific to a device. It is written to
read some values from this imem region which is present for almost all 
QCOM SoCs. So SoC specific compatible is not given in this case.

> 
>> +
>> +      reg:
>> +        maxItems: 1
>> +        description:
>> +          The base address of the register region in case of
>> +          imem boot stats.
> 
> Drop description, it's obvious.

Ack
>> +
>> +    required:
>> +      - compatible
>> +      - reg
>> +
> Best regards,
> Krzysztof
> 
