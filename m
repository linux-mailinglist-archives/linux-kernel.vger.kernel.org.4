Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D6C5B684E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiIMHBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiIMHBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:01:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B7314D0B;
        Tue, 13 Sep 2022 00:01:23 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D6KGPX013655;
        Tue, 13 Sep 2022 07:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eOuIRQbfvzC+vc/Wz4LlLQjHPuOjG/kNI+Kv7NJoMQo=;
 b=FuzgIGxx9+R2lIbpyJ/4kxsFdWOsW1PHZnpKcLyu3b3CBI/LdrcQuy+TNrmmOuBz++7n
 hsCDbUteV+yTm4KloQKEDApPnZExUtoyZt0JFPFNbGDPO4EOL69AlUzHSko0tMjLIy5n
 iubVL9dK3PBcLzSuXY0JlZF5FmWt3GTBDVhhnHY+oecBN2QRLNa5nn2XH01lGBUg2q4u
 k531myx2V+yctPenx+gDaNtZtoTgpsBaMvXOLbjbm1OyRfkZYzXt6eew3uzV9IzcRM6h
 g09UL6591IpV4MLtuaOgRrU+8lMRMBlZB93s7cILyCOxgYfK13ATJ7nhHz4YoIMvfCG4 /w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgk6kec2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 07:01:04 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28D713wd001973
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 07:01:03 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 13 Sep
 2022 00:00:58 -0700
Message-ID: <05c64748-6a3b-fb0b-e6b7-3715f77de14f@quicinc.com>
Date:   Tue, 13 Sep 2022 15:00:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 1/9] dt-bindings: arm: Add support for DSB element
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
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
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>
References: <1662626705-13097-1-git-send-email-quic_taozha@quicinc.com>
 <1662626705-13097-2-git-send-email-quic_taozha@quicinc.com>
 <e015754f-2f33-ab7d-4f18-e1bef39a8390@linaro.org>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <e015754f-2f33-ab7d-4f18-e1bef39a8390@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HTVfxTT71ja7NDdty1FdRkDielKuYFQo
X-Proofpoint-ORIG-GUID: HTVfxTT71ja7NDdty1FdRkDielKuYFQo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_02,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130030
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 9/8/2022 6:54 PM, Krzysztof Kozlowski 写道:
> On 08/09/2022 10:44, Tao Zhang wrote:
>> Add property "qcom,dsb-elem-size" to support DSB element for TPDA.
>> Specifies the DSB element size supported by each monitor connected
>> to the aggregator on each port. Should be specified in pairs (port,
>> dsb element size).
>>
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
> So it is rather uint32-matrix (need to describe the items subschema).
> What about maxItems?
>
> Best regards,
> Krzysztof

Yes, indeed it should be uint32-matrix here. I will update in the next 
release.

The "maxItems" cannot be known explicitly because it depends on how many 
DSB subunit TPDMs are connected to the TPDA input ports.

Usually the number of the items is 1 to several, but there is no limit 
to its maximum value.


Best regards,

Tao

