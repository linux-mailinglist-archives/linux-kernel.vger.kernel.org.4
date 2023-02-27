Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CD16A393C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 04:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjB0DHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 22:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjB0DHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 22:07:53 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321902123;
        Sun, 26 Feb 2023 19:07:52 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31R1wDw4008623;
        Mon, 27 Feb 2023 03:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vVQMUnb5nCb+l0hbsq9e0mKlnRDnhcHRKKza1v8iLX8=;
 b=D76N4XGHffNjKacCH27aegt4Hkjo1b1N4gmTwAYEU0aB4DAna5+92i8WYKs1RjpspqTg
 wsLQEJnSfFGhMmZJK68p6WA9zYl8PGrGtHRkq7zAScgF6kkMaRnSD1UFIpsjYdT6CX34
 ydcqnzjS7G5jTUvRjy9Z2JNITnjYJD4ckDzfkIN5M9XJYdEKPLdrYjG4Za3HecOoDm8s
 3XkMpT9SMv/OBGScGL0SRB3fxKJj0wofz1SZ8pHxOOTExCYPk7u0HaV3fI+15Gd9FWmA
 lqbQP5d1scJnJvksvd+82SY3NpkLBWdZM2e0O3yR/xY9BskULB+iD/2txIyGoRa6Qo3q Lw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ny9a0umd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 03:07:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31R37dMH010745
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 03:07:39 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 26 Feb
 2023 19:07:34 -0800
Message-ID: <7195d3dd-8c39-00c5-5037-5d6d01698cf5@quicinc.com>
Date:   Mon, 27 Feb 2023 11:07:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 1/9] dt-bindings: arm: Add support for DSB element
Content-Language: en-US
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
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>,
        Tao Zhang <taozha@qti.qualcomm.com>
References: <1674114105-16651-1-git-send-email-quic_taozha@quicinc.com>
 <1674114105-16651-2-git-send-email-quic_taozha@quicinc.com>
 <c55483da-8fa7-67d3-041d-930607768a2a@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <c55483da-8fa7-67d3-041d-930607768a2a@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Bpv98UJjTMZCXXQHmtuiNC8bOtGl5n6H
X-Proofpoint-GUID: Bpv98UJjTMZCXXQHmtuiNC8bOtGl5n6H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-26_22,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302270023
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

在 2/22/2023 2:11 AM, Suzuki K Poulose 写道:
> On 19/01/2023 07:41, Tao Zhang wrote:
>> Add property "qcom,dsb-elem-size" to support DSB(Discrete Single
>> Bit) element for TPDA. Specifies the DSB element size supported
>> by each monitor connected to the aggregator on each port. Should
>> be specified in pairs (port, dsb element size).
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Tao Zhang <taozha@qti.qualcomm.com>
>> ---
>>   .../bindings/arm/qcom,coresight-tpda.yaml          | 22 
>> ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml 
>> b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
>> index 2ec9b5b..298db7f 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
>> @@ -58,6 +58,26 @@ properties:
>>       minItems: 1
>>       maxItems: 2
>>   +  qcom,dsb-element-size:
>> +    description: |
>> +      Specifies the DSB(Discrete Single Bit) element size supported by
>> +      each monitor connected to the aggregator on each port. Should be
>> +      specified in pairs <port, dsb element size>.
>
> Isn't this a property of the TPDM connected to the port ? i.e. the DSB 
> size ? Thus shouldn't this be part of the TPDM device (and the TPDA 
> will be able to find it from the TPDM device) ?
>
Since  the port number is about the input port of TPDA, this property 
needs to be configured in the TPDA-related settings.

In our current design, TPDM doesn't have a register to record the DSB 
size, and TPDA cannot actively know the TPDM DSB size from the TPDM device.

>
> Suzuki

Best,

Tao

