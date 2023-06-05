Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D2A721DB9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 07:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjFEF6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 01:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFEF6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 01:58:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDC6CA;
        Sun,  4 Jun 2023 22:58:38 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3555KKBq008241;
        Mon, 5 Jun 2023 05:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PKc25S5BPKFON2v+rQf7IrKdoRIMF8UjAUUXnQgIEfQ=;
 b=SMF/L9GervEzRhe/7+7+4NKF0QWcaznieCt2gDf2R1ztKatm/7ASMsPH5utrkK7b+ayA
 8ajF8R9wAi3fMMLJ/0c8AEufTFqv/KGSpKAnGcMm8lRhwnHoZWfP+tWkCJIQrKyWCTTc
 e/9aYTurl+mOr3RtgFDywZG+wUr9boVodMJk+WMWxOt90o+okq09W75aBXWLDKG27K7J
 5OYIZS3Q91jAN0YIms5kBzv6kgRV0aCgTTjqNhZXt+cX5WgoyWfIC9ZtlyVg21uv96aC
 XrmE0F7dUQxG6YcbymxDsLq5/Y1JUJLf1buWeF+UioQPWHOUDKuUsk4nhxFcaIjXxSCC Ww== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qyxq02mh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 05:58:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3555wVZ2011752
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Jun 2023 05:58:31 GMT
Received: from [10.201.206.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 4 Jun 2023
 22:58:23 -0700
Message-ID: <1ee8561f-22ea-b896-b2a6-041149524af6@quicinc.com>
Date:   Mon, 5 Jun 2023 11:28:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH V2 01/13] dt-bindings: remoteproc: qcom: Add support for
 multipd model
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <mathieu.poirier@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_eberman@quicinc.com>, <quic_mojha@quicinc.com>,
        <kvalo@kernel.org>, <loic.poulain@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_devipriy@quicinc.com>
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
 <20230521222852.5740-2-quic_mmanikan@quicinc.com>
 <b03dfbeb-dcc4-4dda-18dc-84243534d41a@linaro.org>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <b03dfbeb-dcc4-4dda-18dc-84243534d41a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0iZE6uYesMKC-KhMWFzXIZwhWtpM3bKT
X-Proofpoint-GUID: 0iZE6uYesMKC-KhMWFzXIZwhWtpM3bKT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 phishscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306050052
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/2023 4:16 PM, Krzysztof Kozlowski wrote:
> On 22/05/2023 00:28, Manikanta Mylavarapu wrote:
>> Add new binding document for multipd model remoteproc.
>> IPQ5018, IPQ9574 follows multipd model.
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>> Changes in V2:
>> 	- Fixed all comments and rebased for TOT.
>> 	- Changed to BSD-3-Clause based on internal open source team
>>            suggestion.
>> 	- Added firmware-name.
>>
>>   .../bindings/remoteproc/qcom,multipd-pil.yaml | 265 ++++++++++++++++++
>>   1 file changed, 265 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
>> new file mode 100644
>> index 000000000000..3257f27dc569
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
>> @@ -0,0 +1,265 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/remoteproc/qcom,multipd-pil.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Multipd Secure Peripheral Image Loader
>> +
>> +maintainers:
>> +  - Bjorn Andersson <andersson@kernel.org>
>> +  - Mathieu Poirier <mathieu.poirier@linaro.org>
>> +
>> +description:
>> +  Multipd Peripheral Image Loader loads firmware and boots Q6 pd, WCSS pd
>> +  remoteproc's on the Qualcomm IPQ5018, IPQ9574 SoC. Pd means protection
>> +  domain. It's similar to process in Linux. Here QDSP6 processor runs each
>> +  wifi radio functionality on a separate process. One process can't access
>> +  other process resources, so this is termed as PD i.e protection domain.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,ipq5018-q6-mpd
>> +      - qcom,ipq9574-q6-mpd
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  firmware-name:
>> +    $ref: /schemas/types.yaml#/definitions/string-array
>> +    description: Firmware name of the Hexagon core
>> +
>> +  interrupts-extended:
>> +    items:
>> +      - description: Watchdog interrupt
>> +      - description: Fatal interrupt
>> +      - description: Ready interrupt
>> +      - description: Handover interrupt
>> +      - description: Stop acknowledge interrupt
> 
> 
> interrupts instead. The same in required:. I replied also to your
> comment on your comment. :)
> 
> Best regards,
> Krzysztof
> 

I will use interrupts instead of interrupts-extended in dt-bindings.

Thanks & Regards,
Manikanta.
