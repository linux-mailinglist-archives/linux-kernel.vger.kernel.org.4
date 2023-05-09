Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20F36FC40A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbjEIKfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbjEIKfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:35:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D595DDD9A;
        Tue,  9 May 2023 03:35:21 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3495GCcF015664;
        Tue, 9 May 2023 10:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7rAJVFbOA/qLEVTAdfdN8+mkHBM9gPh2AaEOJvYGnm4=;
 b=ILW79M/6Nrxlkh0H98IGbFPKcgyhYGfSc+HWIN4Yatm6wTJSQD3zROsurZIFeF8Efhyt
 OxMG9diTx39C7qtfk/rbzhb7GUZq3NpjF6Thxk6Ryv+Ke2bJ7KY/+SOn64TpqC7grsjl
 PjHqtXaJqi0LTjguBgurfYSVcByBi6touFjiCPNKpJ8bQzpStZQjt6yJFBDkEDVj08kZ
 +M4k1yOFrKZaFi+sp4F/lxAqSeWVjwkYJRYYY+IvTKyeXHKPk9d9pwyx5W4gHqWR3xBt
 TjWjgAdwKa9KD9kLBGK4BpojQx6wVYdS31Py5J2KqcbqrBmQ0/zRTHp41M3/XRmUCfU2 Ag== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf7851e7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 10:35:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 349AYxNM016069
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 10:35:00 GMT
Received: from [10.242.242.190] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 9 May 2023
 03:34:52 -0700
Message-ID: <b8b30b77-31df-15c3-3914-1198f90299e6@quicinc.com>
Date:   Tue, 9 May 2023 16:04:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 01/11] dt-bindings: remoteproc: qcom: Add support for
 multipd model
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <mathieu.poirier@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_gurus@quicinc.com>,
        <loic.poulain@linaro.org>, <quic_eberman@quicinc.com>,
        <robimarko@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-2-git-send-email-quic_mmanikan@quicinc.com>
 <38a5a268-7d8a-6e61-4272-8e9155df0034@linaro.org>
 <790496d7-98dc-c92e-dedc-1c89395a1ad8@quicinc.com>
 <e63a3e34-1f73-3661-8655-e34e1e955804@linaro.org>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <e63a3e34-1f73-3661-8655-e34e1e955804@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XkErmhbDB5Hgp_TKZN_KEbnzhATsuSLj
X-Proofpoint-GUID: XkErmhbDB5Hgp_TKZN_KEbnzhATsuSLj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_06,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090083
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/9/2023 12:38 PM, Krzysztof Kozlowski wrote:
> On 08/05/2023 15:45, Manikanta Mylavarapu wrote:
>>
>>
>> On 3/7/2023 8:47 PM, Krzysztof Kozlowski wrote:
>>> On 07/03/2023 05:41, Manikanta Mylavarapu wrote:
>>>> Add new binding document for multipd model remoteproc.
>>>> IPQ5018, IPQ9574 follows multipd model.
>>>>
>>>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>>>> ---
>>>>    .../bindings/remoteproc/qcom,multipd-pil.yaml | 282 ++++++++++++++++++
>>>>    1 file changed, 282 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
>>>> new file mode 100644
>>>> index 000000000000..b788607f5abd
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
>>>> @@ -0,0 +1,282 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/remoteproc/qcom,multipd-pil.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Qualcomm Multipd Secure Peripheral Image Loader
>>>> +
>>>> +maintainers:
>>>> +  - Bjorn Andersson <andersson@kernel.org>
>>>> +  - Mathieu Poirier <mathieu.poirier@linaro.org>
>>>> +
>>>> +description:
>>>> +  Multipd Peripheral Image Loader loads firmware and boots Q6 pd, WCSS pd
>>>> +  remoteproc's on the Qualcomm IPQ5018, IPQ9574 SoC.
>>>
>>> What is a "pd"?
>>>
>> Pd means protection domain.
>> It's similar to process in Linux. Here QDSP6 processor runs each wifi
>> radio functionality on a separate process. One process can't access
>> other process resources, so this is termed as PD i.e protection domain.
>> Here we have two pd's called root and user pd. We can correlate Root pd
>> as root and user pd as user in linux. Root pd has more privileges than
>> user pd.
>>   From remoteproc driver perspective, root pd corresponds to QDSP6
>> processor bring up and user pd corresponds to Wifi radio (WCSS) bring up.
> 
> Parts of it should be in description. And definitely "pd" should be
> explained.
> 
Sure, i will add it in cover page.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - qcom,ipq5018-q6-mpd
>>>> +      - qcom,ipq9574-q6-mpd
>>>> +
>>>> +  '#address-cells': true
>>>> +
>>>> +  '#size-cells': true
> 
> ...
> 
>>>
>> Sure, will add.
>>>> +    description:
>>>> +      Qualcomm G-Link subnode which represents communication edge, channels
>>>> +      and devices related to the Modem.
>>>> +
>>>> +patternProperties:
>>>> +  "^remoteproc_pd1|remoteproc_pd2|remoteproc_pd3":
>>>
>>> No, underscores are not allowed. Also, what is pd?
>>>
>> Sure, will remove underscores.
> 
> Shouldn't this be just pd-1?
> 
> 
I think 'pd-1' not enough. Because child's i.e userpd's also considered
as remote processor's, so name should be like "remoteproc-pd1".
>>>> +    type: object
>>>> +    description:
>>>> +      In Multipd model, WCSS pd depends on Q6 pd i.e Q6 pd should be up before
>>>> +      WCSS. It can be achieved by keeping wcss pd node as subnode of Q6
>>>> +      device node.
>>>> +
>>>> +    properties:
>>>> +      compatible:
>>>> +        enum:
>>>> +          - "qcom,ipq5018-wcss-ahb-mpd"
>>>> +          - "qcom,ipq9574-wcss-ahb-mpd"
>>>> +          - "qcom,ipq5018-wcss-pcie-mpd"
> 
> 
> 
> Best regards,
> Krzysztof
> 

Thanks & Regards,
Manikanta.
