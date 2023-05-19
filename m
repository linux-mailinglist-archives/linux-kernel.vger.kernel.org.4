Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD2F7096F6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjESL6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjESL6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:58:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B0DE1;
        Fri, 19 May 2023 04:58:33 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JBiPsq026698;
        Fri, 19 May 2023 11:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+fX3WrloTcPg+Nga+D8INYObLCjqPG9wOmoTWaCuhTQ=;
 b=lEJCzEk5lj/mdzdKqJYobOfCVK5fmyhq6+hpiYArWuL844iSNh1ngjsxOgakRe5DnOAd
 Q+AT4rw5Dr1oGPCpIhA+yM8fHAzjUCElqVGB7gI14gAy9R9vJJF5BLy2N224AvhWireT
 gpbor8d6TtmgG2fiowFVY0Bc+3ASlQm8ErH59bBN9AYkdfKuRkiO5qtf4eNUDLFmWhbx
 nq6YAjrkaXi2V6B3u1F1xkpoVNZ6hpXX5qQwwU37Zz3TvJUUWgIginnkz5ngSKkoLQJq
 XbVHinXnXF1RsCWv7T0dfFUsyUhIaBHfhLxMZgE4UEYwTsxmLGDWw+vy13lWEuGfHGvS Xw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qp4nt8fb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 11:58:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JBwSpR006684
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 11:58:28 GMT
Received: from [10.217.216.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 19 May
 2023 04:58:24 -0700
Message-ID: <da68d3eb-300c-a1e8-6085-1bce1641b664@quicinc.com>
Date:   Fri, 19 May 2023 17:28:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/4] dt-bindings: clock: qcom: Add SM8550 video clock
 controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230509161218.11979-1-quic_jkona@quicinc.com>
 <20230509161218.11979-3-quic_jkona@quicinc.com>
 <d48ded3e-7a14-e859-f330-dfffe103eb56@linaro.org>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <d48ded3e-7a14-e859-f330-dfffe103eb56@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lhf2JImYOXEknb_QtN7JOR_DGi5tRCk9
X-Proofpoint-GUID: lhf2JImYOXEknb_QtN7JOR_DGi5tRCk9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_08,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011 phishscore=0
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190101
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks Krzysztof for your review!

On 5/10/2023 12:43 PM, Krzysztof Kozlowski wrote:
> On 09/05/2023 18:12, Jagadeesh Kona wrote:
>> Add device tree bindings for the video clock controller on Qualcomm
>> SM8550 platform.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> ---
>>   .../bindings/clock/qcom,sm8550-videocc.yaml   | 77 +++++++++++++++++++
>>   .../dt-bindings/clock/qcom,sm8550-videocc.h   | 38 +++++++++
>>   2 files changed, 115 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-videocc.yaml
>>   create mode 100644 include/dt-bindings/clock/qcom,sm8550-videocc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-videocc.yaml
>> new file mode 100644
>> index 000000000000..107af5e9af89
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-videocc.yaml
>> @@ -0,0 +1,77 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/qcom,sm8550-videocc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Video Clock & Reset Controller on SM8550
>> +
>> +maintainers:
>> +  - Jagadeesh Kona <quic_jkona@quicinc.com>
>> +  - Taniya Das <quic_tdas@quicinc.com>
>> +
>> +description: |
>> +  Qualcomm video clock control module provides the clocks, resets and power
>> +  domains on SM8550.
>> +
>> +  See also:: include/dt-bindings/clock/qcom,videocc-sm8550.h
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,sm8550-videocc
> 
> Nope, looks 100% the same as sm8450, put it there.
> 
> https://lore.kernel.org/all/20230509172148.7627-2-quic_tdas@quicinc.com/
> 
Yes, will take care of this in next series.

> Best regards,
> Krzysztof
> 

Thanks & Regards,
Jagadeesh
