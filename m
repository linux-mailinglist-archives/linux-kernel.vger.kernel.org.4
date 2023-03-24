Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935A86C79AC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjCXIZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjCXIZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:25:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B7525291;
        Fri, 24 Mar 2023 01:25:41 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32O21nl6009116;
        Fri, 24 Mar 2023 08:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fVpCNVtZFfH87DRlptURT/buGO6SxHnjLASX+7OFy/Q=;
 b=WDijNTEuW0pag+a5E3ZvjUCjiWuBK7sJrMOsl16JMuifBv0nThwIJ5XLKlpuRfGcv7zg
 d50qf5VoKySi+i0JqGlEezsbv0KvXj6KwDK1BC4Y66iCy/rdDb+s9Nxq9sivjZ36yTjT
 aFBB8ZcPKJzSXUsxwkHbjsvS/iTN6656ErxfvxpHC4+/aYS+kC/GdwD0eiWgq2hOoNdE
 RXQx6RTpyHpN7Lt1vQ2y5Q4ThU/pM8HttHXMK2ZCT2F0Ck43Bq5EhIoyLEptzp26TDzO
 Y/U+Zb7sowFm14ch4+2MFzcJKsfXugIW3rL6XvyRUEKNRGow1B1Bq9j9iI8IuqqE208X VA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pgxr899d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 08:25:24 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32O8PNxr031524
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 08:25:23 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Mar
 2023 01:25:19 -0700
Message-ID: <d4c133c1-38c7-93e3-deaf-b55161057409@quicinc.com>
Date:   Fri, 24 Mar 2023 16:25:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 01/11] dt-bindings: arm: Add support for DSB element
 size
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <1679551448-19160-1-git-send-email-quic_taozha@quicinc.com>
 <1679551448-19160-2-git-send-email-quic_taozha@quicinc.com>
 <e6ad7301-09ea-93e0-929e-86e0eb0a02e7@arm.com>
Content-Language: en-US
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <e6ad7301-09ea-93e0-929e-86e0eb0a02e7@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: smh7XMFPpWpEVOyQGTYe-rnu54zoYy_Z
X-Proofpoint-GUID: smh7XMFPpWpEVOyQGTYe-rnu54zoYy_Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_04,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 mlxlogscore=984 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303240068
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

在 3/23/2023 7:18 PM, Suzuki K Poulose 写道:
> On 23/03/2023 06:03, Tao Zhang wrote:
>> Add property "qcom,dsb-elem-size" to support DSB(Discrete Single
>> Bit) element for TPDM. The associated aggregator will read this
>> size before it is enabled. DSB element size currently only
>> supports 32-bit and 64-bit.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   .../devicetree/bindings/arm/qcom,coresight-tpdm.yaml | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml 
>> b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
>> index 5c08342..d9b6b613 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
>> @@ -44,6 +44,15 @@ properties:
>>       minItems: 1
>>       maxItems: 2
>
>
>>   +  qcom,dsb-element-size:
>> +    description:
>> +      Specifies the DSB(Discrete Single Bit) element size supported by
>> +      the monitor. The associated aggregator will read this size 
>> before it
>> +      is enabled. DSB element size currently only supports 32-bit 
>> and 64-bit.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 32
>> +    maximum: 64
>
> Shouldn't this be something like oneOf ? It is not a range, but one of
> those two specific values ?

Yes, "qcom,dsb-element-size" should be an optional option required in TPDM

devicetree. Other properties like "qcom,cmb-element-size", 
"qcom,tc-element-size"

and etc. will be added in a later patch series.

I will update this doc according to your advice in the next version of 
the patch.

Tao

>
> Suzuki
>
>
