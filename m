Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7415632E0F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 21:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiKUUia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 15:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiKUUi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 15:38:28 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0C12B638;
        Mon, 21 Nov 2022 12:38:27 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALJwB53013099;
        Mon, 21 Nov 2022 20:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2s7pXi2xUsgbOBd1b9tQo4sZBnUzWsGimUNCwDl4Zpk=;
 b=CMBzv5WxP0ts7Aiw3eVevRMbmVBwu03PHXZ24mTxGjAnv7n+MALAkfudj/LZEHW8/Brr
 iZXlmJVHfE9alXlIZqMqn7OFwYRTnTyr9mYAccgUN6eX0e7U1P/em//HPGEtgzSNaa6T
 QrSN3TxfsBx2lccqiPG2O5C6CuWSiPtolJ3j574VNFAGMCTQB5hZ+l3OrQBENVOi6K+k
 vnVDFxcImTH0SCSLLayAGFsda/0bHUXsya0qsKuAgyr2xl1QkoUJ/t7+Ww/K9Wux1Nc7
 GY1QYZNajwk59TtMBm1vzgs5I47bBIzN8Obk3TUStFD4g0giaYJ150DcxO0/2J7vHfoF fQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxreanp27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 20:38:24 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ALKcNwW021435
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 20:38:23 GMT
Received: from [10.110.33.239] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 21 Nov
 2022 12:38:22 -0800
Message-ID: <faf2d137-efab-93ab-f325-1fa507f166a7@quicinc.com>
Date:   Mon, 21 Nov 2022 14:38:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 1/2] dt-bindings: pinctrl: qcom: Add QDU1000 and
 QRU1000 pinctrl
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221118182039.29236-1-quic_molvera@quicinc.com>
 <20221118182039.29236-2-quic_molvera@quicinc.com>
 <528648f2-17df-ab19-8ad4-76423bbc0ae4@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <528648f2-17df-ab19-8ad4-76423bbc0ae4@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VOVa4yK0u1eg-27HiKTjzsWHhre2rJWS
X-Proofpoint-ORIG-GUID: VOVa4yK0u1eg-27HiKTjzsWHhre2rJWS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_16,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210155
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/2022 4:58 AM, Krzysztof Kozlowski wrote:
> On 18/11/2022 19:20, Melody Olvera wrote:
>> Add device tree bindings for QDU1000 and QRU1000 TLMM devices.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  .../bindings/pinctrl/qcom,qdu1000-tlmm.yaml   | 134 ++++++++++++++++++
>>  1 file changed, 134 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
>> new file mode 100644
>> index 000000000000..cb0c496d8666
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
>> @@ -0,0 +1,134 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pinctrl/qcom,qdu1000-tlmm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies, Inc. QDU1000/QRU1000 TLMM block
>> +
>> +maintainers:
>> +  - Melody Olvera <quic_molvera@quicinc.com>
>> +
>> +description: |
>> +  This Top Level Mode Multiplexer block (TLMM) is found in the QDU1000 and
>> +  QRU1000 platforms.
> It's better to keep consistent style which allows to do easy
> search/replace, than to have new files using their own sentences. So
> keep it the same as was unified in few recent commits.

Ok... Just making sure that's what you want. Last PS you gave comments to change
the wording of this description to remove "This binding describes..." as we've done
in all the other qcom pinctrl/tlmm bindings. I can change the wording back to the
original, just want to be clear here.

>
>> +allOf:
>> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,qdu1000-tlmm
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts: true
>> +  interrupt-controller: true
>> +  "#interrupt-cells": true
>> +  gpio-controller: true
>> +
>> +  gpio-reserved-ranges:
>> +    minItems: 1
>> +    maxItems: 75
> Technically you can have up to 76 separate ranges (151 GPIOs).

Fair enough. I can fix this.

Thanks,
Melody
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
>
> Best regards,
> Krzysztof
>

