Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808C070957B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjESKzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjESKzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:55:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9D2113;
        Fri, 19 May 2023 03:55:46 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34J9VBrB029503;
        Fri, 19 May 2023 10:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VwV3eQCsaztxL8cJGw6wSDphKgHYrjvOQCOiIcxEsUY=;
 b=IiZHnz55enVviH7tb5dm0mzMF+7SDRQQFPWLudUUotdzUGQSps4jMa8m3TLO2iY9g3XS
 HsF9sHlQwzpvoGnDTUA5MvFI4FkSAUBRAjF2kGZ3WGLHb0itwSP54NGC6U7Ydy0cbtPN
 QXJpxBoUCSD4C1hhaWniI5t335IUbm081OMukxzkbO0yDIck8kLWcS4hS/Pzez4AOEO3
 s5zNRfxqyu7KRQpPDTzjX2sh67GH1ooDvWEMdoSnj+K4TTtrfBFEUvijDLp8XPp76C/B
 nuQHY3SGOX6WsYnZ1cgxWX10rR9XHlNyVgFDP2sIIPwReuLQyRSuRmSdunGvb41BXBLF 3Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnfpw37n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 10:55:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JAtdhT020174
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 10:55:39 GMT
Received: from [10.216.31.56] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 19 May
 2023 03:55:34 -0700
Message-ID: <19eef429-1fca-c603-f97d-16424a10d9b7@quicinc.com>
Date:   Fri, 19 May 2023 16:25:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V4 1/3] dt-bindings: clock: qcom: Add SM8450 video clock
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_skakitap@quicinc.com>, <quic_jkona@quicinc.com>
References: <20230509172148.7627-1-quic_tdas@quicinc.com>
 <20230509172148.7627-2-quic_tdas@quicinc.com>
 <603c177d-07c7-4cb4-da53-0e1a11ee8828@linaro.org>
From:   Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <603c177d-07c7-4cb4-da53-0e1a11ee8828@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Wn1Or5TqzG34kXGeN-tYyZ7K-6n2tQ2P
X-Proofpoint-GUID: Wn1Or5TqzG34kXGeN-tYyZ7K-6n2tQ2P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_06,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190091
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review.

On 5/10/2023 12:42 PM, Krzysztof Kozlowski wrote:
> On 09/05/2023 19:21, Taniya Das wrote:
>> Add device tree bindings for the video clock controller on Qualcomm
>> SM8450 platform.
>>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>> Changes since V3:
>>   - None.
>>
>> Changes since V2:
>>   - As per Stephen's comments drop clock-names to match how newer
>>     qcom clk bindings are being done.
>>   - Change the header file name as qcom,sm8450-videocc.h to match
>>     latest upstream header files.
>>
>> Changes since V1:
>>   - Change the properties order to keep reg after the compatible
>>     property.
>>
>>   .../bindings/clock/qcom,sm8450-videocc.yaml   | 77 +++++++++++++++++++
>>   .../dt-bindings/clock/qcom,sm8450-videocc.h   | 38 +++++++++
>>   2 files changed, 115 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>>   create mode 100644 include/dt-bindings/clock/qcom,sm8450-videocc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>> new file mode 100644
>> index 000000000000..58e59065bb2a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>> @@ -0,0 +1,77 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/qcom,sm8450-videocc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Video Clock & Reset Controller on SM8450
>> +
>> +maintainers:
>> +  - Taniya Das <quic_tdas@quicinc.com>
>> +
>> +description: |
>> +  Qualcomm video clock control module provides the clocks, resets and power
>> +  domains on SM8450.
>> +
>> +  See also:: include/dt-bindings/clock/qcom,videocc-sm8450.h
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,sm8450-videocc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: Video AHB clock from GCC
>> +      - description: Board XO source
> 
> Why the order is different than all other devices? Board XO is always first.
> 
>

Yes, will be fixed in the next patch set.


> Best regards,
> Krzysztof
> 

-- 
Thanks & Regards,
Taniya Das.
