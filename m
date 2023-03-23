Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEDC6C69F5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjCWNwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjCWNwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:52:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7A93599;
        Thu, 23 Mar 2023 06:52:01 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N86q2v021150;
        Thu, 23 Mar 2023 13:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NlVdZ9nLQmvQl7BXjEHStDcD+x9JoHAKNiHr8EHjfW4=;
 b=hKvJLtNjj5TpDoQ8dRpOOAB4yA0ejPsxaj0xnKP1n7IvMEHh/fZKrwAwWenuYaxFp9jA
 Y5jTKgqDwFnjCt5085LqZOd+lWKEdzGLuAhlktEtSd0JiY2jP0v+nXBby5SHj8Z7onYt
 fFjPz0DDR/a49fqTnWpSTJaAd7uOfzgYTKzX7lUZWyYSpKbZpbzVpknHGKmJx3fHxwgb
 yKO/DlXe0S7iE7xyfwIIBsOdF6iyrYPckq11Z5nBp5FrDhynLqUrJHqB7IMu19JNBwQL
 RvTz8vklsWt8hH4+6KiQAk0y1fFl1XaxUbWKAJ1KrEHaqvPOVzmglhuXfnPS5an99Tww kQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pgfaxh9eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 13:51:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32NDpoW9018017
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 13:51:50 GMT
Received: from [10.50.6.215] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Mar
 2023 06:51:46 -0700
Message-ID: <9467586f-4fda-7fb9-2752-35a9e1147ad8@quicinc.com>
Date:   Thu, 23 Mar 2023 19:21:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V1 2/4] dt-bindings: soc: qcom,mpm-sleep-counter: Add the
 dtschema
Content-Language: en-US
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
 <576e53a1d0ef218536da976102b4cc207436ec1d.1679403696.git.quic_schowdhu@quicinc.com>
 <e845b412-9afa-3d9e-54fc-7f9f04d25c05@linaro.org>
 <8efa2296-7136-690a-6e6b-c9b41562ba84@quicinc.com>
 <855b64ea-ccd3-4925-29a8-ebb8d0734adc@linaro.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <855b64ea-ccd3-4925-29a8-ebb8d0734adc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aECxtBJgfDAqk5qEqYto4prmuEjtXv3r
X-Proofpoint-ORIG-GUID: aECxtBJgfDAqk5qEqYto4prmuEjtXv3r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230105
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/2023 10:01 PM, Krzysztof Kozlowski wrote:
> On 22/03/2023 15:02, Souradeep Chowdhury wrote:
>>
>>
>> On 3/21/2023 11:09 PM, Krzysztof Kozlowski wrote:
>>> On 21/03/2023 14:51, Souradeep Chowdhury wrote:
>>>> Add the device tree bindings for the module power manager sleep
>>>> counter.
>>>>
>>>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>>>> ---
>>>>    .../bindings/soc/qcom/qcom,mpm-sleep-counter.yaml  | 40 ++++++++++++++++++++++
>>>>    1 file changed, 40 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml
>>>> new file mode 100644
>>>> index 0000000..f9f46b7
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml
>>>
>>> Your code a bit explains this... this is not a device but some memory
>>> region. Does not look like suitable for bindings as separate device.
>>
>> Ack. Can you let me know the suitable place to put the bindings for this?
> 
> Reserved memory region? Or drop from bindings entirely.

Ack. Will drop this for now.
> 
> Best regards,
> Krzysztof
> 
