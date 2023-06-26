Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B1173D98E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjFZIXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFZIXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:23:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E77D7;
        Mon, 26 Jun 2023 01:23:35 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35Q6pOIf001973;
        Mon, 26 Jun 2023 08:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BNz4G5BH6tX8wyzLuN7oxLPV0Krz4GEmzLQ/lZ7vTz0=;
 b=AtPquTSITjmNebtz6FEHAtqDjbaVYB8aqEnOskFE2t/3CV2JgneDDz/yXCmyBbZHs4rb
 IYT1slYCfajiwUwRu3wjQddtJeVizolv+DSI1Y1qQEpUx/bUW4KuIk845Fd7cXrA2vm5
 tOoe4APwy++6Jbo4pnKy8IkNSs5Nlm8h86DO8QxMBxf+Ab5yD512PTcvUcCjbevlGGHv
 gQeB1KS+8E93D5z2eLVRgZ78Kkfe65ZSaZZ3V3jsBBu/B2KeXUw+aUsuw03QDtRVitok
 WSDSQ4bA8iImWVkoF5l882crPwbvfUZTepi2x+FeDq6CiCNpGiUP39enLhIbxrAdRAA+ sA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rds8nb8bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 08:23:25 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35Q8NOe6003237
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 08:23:25 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 26 Jun
 2023 01:22:52 -0700
Message-ID: <d9cde55b-fc96-b024-8048-1de1fa1bd89e@quicinc.com>
Date:   Mon, 26 Jun 2023 13:52:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 1/6] dt-bindings: nvmem: sec-qfprom: Add bindings for
 secure qfprom
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20230623141806.13388-1-quic_kbajaj@quicinc.com>
 <20230623141806.13388-2-quic_kbajaj@quicinc.com>
 <cea67754-6bc0-f8ee-3cba-8713b10b0c69@linaro.org>
Content-Language: en-US
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <cea67754-6bc0-f8ee-3cba-8713b10b0c69@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lbaGG1675zQprUANcWxEyByIUVZK-ek9
X-Proofpoint-ORIG-GUID: lbaGG1675zQprUANcWxEyByIUVZK-ek9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_05,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxlogscore=992 suspectscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260075
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/23/2023 10:06 PM, Krzysztof Kozlowski wrote:
> On 23/06/2023 16:18, Komal Bajaj wrote:
>> This patch adds bindings for secure qfprom found in QCOM SOCs.
>> SECURE QFPROM driver is based on simple nvmem framework.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   .../bindings/nvmem/qcom,sec-qfprom.yaml       | 58 +++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
>> new file mode 100644
>> index 000000000000..675e27918c7b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
>> @@ -0,0 +1,58 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/nvmem/qcom,sec-qfprom.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies Inc, SECURE QFPROM Efuse
> SECURE is not acronym, so "Secure".

Noted.

>
>> +
>> +maintainers:
>> +  - Komal Bajaj <quic_kbajaj@quicinc.com>
> Add description: with explanation what is this.  Specifically it should
> be quite clear what is here different than regular QFPROM

Sure, will add description the next patch set.

>
>> +
>> +allOf:
>> +  - $ref: nvmem.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - qcom,qdu1000-sec-qfprom
>> +      - const: qcom,sec-qfprom
>> +
>> +  reg:
>> +    items:
>> +      - description: The secure qfprom corrected region.
>> +
>> +  # Needed if any child nodes are present.
>> +  "#address-cells":
>> +    const: 1
>> +  "#size-cells":
>> +    const: 1
> Drop both, they are not needed.

I didn't get it. Can you please explain why these are not needed as this
node will have child nodes which will use single value for address and size.

>
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,gcc-sc7180.h>
>> +
>> +    soc {
>> +      #address-cells = <2>;
>> +      #size-cells = <2>;
>> +
>> +      efuse@221c8000 {
>> +        compatible = "qcom,qdu1000-sec-qfprom", "qcom,sec-qfprom";
>> +        reg = <0 0x221c8000 0 0x1000>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +
>> +        multi_chan_ddr: multi_chan_ddr@12b {
> No underscores in node names.

Noted.

>
>
> Best regards,
> Krzysztof
>

