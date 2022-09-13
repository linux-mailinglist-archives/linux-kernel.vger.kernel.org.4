Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076405B6919
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiIMH5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiIMH5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:57:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3015A2EC;
        Tue, 13 Sep 2022 00:57:18 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D5mn6S013452;
        Tue, 13 Sep 2022 07:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GKj6ih5b4bSDldgBsJdILwo+2pncPzrqaNG+PnLdZ+U=;
 b=OiXi4yawRJOw54FcxAr+//GfHo8MzXMUiyghnZRUSKV97hJqU8j5zbnZOe2COmgXKAck
 1MH3avv4ZSUtMQxVnXfNc3yjeBLEaWRHZ8z4phF4N6qNjHgaqhzRQ2ZfhAszNGf6qr0d
 +e/jQqq7kEaOHMM0kRYqO4+fQD9zWUm9+JNDYNRyphZgFjVWcLH4VRdAj9p5LFX/Uuac
 +4zZfMJ45KhOipw8xDlLSfIMXXqVhcQ34jqODelK0pX7S6UoP1jSqr0GO2x3JIQhe/Ph
 Vh50T+EWb5rW5Kk/ruJVwokd5DKHVmmQI6ppvLwpFhsEBgUq7q744LrREM+qdw3cehYO Dg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjm1wrb2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 07:56:52 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28D7upYv001704
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 07:56:51 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 13 Sep
 2022 00:56:47 -0700
Message-ID: <2d2e53f5-38fd-3636-9f91-a5e2de3833eb@quicinc.com>
Date:   Tue, 13 Sep 2022 15:56:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 1/9] dt-bindings: arm: Add support for DSB element
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>
References: <1662626705-13097-1-git-send-email-quic_taozha@quicinc.com>
 <1662626705-13097-2-git-send-email-quic_taozha@quicinc.com>
 <20220913004859.GA1948424-robh@kernel.org>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <20220913004859.GA1948424-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9NQju0724izUmCBMHy0WNFf550q9cDWm
X-Proofpoint-ORIG-GUID: 9NQju0724izUmCBMHy0WNFf550q9cDWm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_02,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130035
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 9/13/2022 8:48 AM, Rob Herring 写道:
> On Thu, Sep 08, 2022 at 04:44:57PM +0800, Tao Zhang wrote:
>> Add property "qcom,dsb-elem-size" to support DSB element for TPDA.
>> Specifies the DSB element size supported by each monitor connected
>> to the aggregator on each port. Should be specified in pairs (port,
>> dsb element size).
> What is DSB?

The full name of DSB is "Discrete Single Bit".

The DSB element size supported by different DSB subunit TPDMs is 
different, so TPDA needs to be informed through configuration in device 
tree.

>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
>> index eb9bfc5..1bb3fdf 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
>> @@ -40,6 +40,13 @@ properties:
>>       minItems: 1
>>       maxItems: 2
>>   
>> +  qcom,dsb-elem-size:
>> +    description: |
>> +      Specifies the DSB element size supported by each monitor
>> +      connected to the aggregator on each port. Should be specified
>> +      in pairs (port, dsb element size).
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> The binding (not yet upstream) says there is just 1 port (port 0). So
> why do you need more than a single uint32?
>
> Rob

TPDA(Trace, Profiling and Diagnostics Aggregator) is to provide 
packetization, funneling and timestamping of TPDM data.

Multiple monitors are connected to different input ports of TPDA.

  - - - -                 - - - -                 - - - -
| TPDM 0|      | TPDM 1 |     | TPDM 2|
  - - - -                 - - - -                 - - - -
     |                       |                       |
     |_ _ _ _ _ _     |         _ _ _ _  |
                         |   |        |
                         |   |        |
                       ------------------
                      |        TPDA      |
                       ------------------

There may be multiple DSB subunit TPDMs connected to different input 
ports of the same TPDA, so we need to use port here to define the 
distinction in device tree.


Best regards,

Tao
