Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E4F67E9A5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbjA0Pht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbjA0Phr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:37:47 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CE88240F;
        Fri, 27 Jan 2023 07:37:45 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RElq1x003993;
        Fri, 27 Jan 2023 15:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=s35fDMFuCDI7snKGOAqNIeD5EWEdWYcstsPeRIwrdA8=;
 b=ChXqT+ASEnz5yU1AO9NLHunpdfRwuRg+TgxmQH3fZLwTnlGMtn4Pzcre2q7/T9kVzl8l
 aVB5FqiuRwdXZ/5FUXeC9OL69HYGH4YhUYHC7jbtXU27IFyi3jaL/zpJRUU5naQf/oIz
 nLVLoF9L0sVYmTgrRNob4gJGlC3NlCLCBiS8y+U+4/yZeqrqQR/0A99pAnF+CUpM9pdL
 iXeddagZCRjFkXPhWiL/zRQgiYBGwYC3210il7JnCz5guRscOJoroy/DKCDttFdnKOyJ
 ywmRZYCVno5xjLXm3TvDumf91RM6TSEriv/rYC7T1h08QXnKAg2nLBINgLeXP7FgTlP2 iQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncavc0kw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 15:37:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30RFbSM2022803
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 15:37:28 GMT
Received: from [10.50.41.100] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 27 Jan
 2023 07:37:20 -0800
Message-ID: <410f1674-cda4-a1ac-e72d-eb32a3fead98@quicinc.com>
Date:   Fri, 27 Jan 2023 21:07:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/6] dt-bindings: clock: Add YAML schemas for QCOM A73 PLL
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <jassisinghbrar@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230113143647.14961-1-quic_devipriy@quicinc.com>
 <20230113143647.14961-2-quic_devipriy@quicinc.com>
 <0337e1ad-b8b4-8728-f5f1-be153b950fe6@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <0337e1ad-b8b4-8728-f5f1-be153b950fe6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 86bz_1uNXXO4otPIl1sMJ7bg24mAdj3v
X-Proofpoint-ORIG-GUID: 86bz_1uNXXO4otPIl1sMJ7bg24mAdj3v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_09,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301270144
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking time to review the patch!

On 1/13/2023 8:27 PM, Krzysztof Kozlowski wrote:
> On 13/01/2023 15:36, devi priya wrote:
>> Add schema for primary CPU PLL found on few Qualcomm platforms.
> 
> Subject: drop redundant "YAML schemas for"
> 
Sure, okay
> 
>>
>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> ---
>>   .../bindings/clock/qcom,a73pll.yaml           | 52 +++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/qcom,a73pll.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,a73pll.yaml b/Documentation/devicetree/bindings/clock/qcom,a73pll.yaml
>> new file mode 100644
>> index 000000000000..a0e81094db8d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,a73pll.yaml
>> @@ -0,0 +1,52 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/qcom,a73pll.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm A73 PLL clock
>> +
>> +maintainers:
>> +  - Bjorn Andersson <andersson@kernel.org>
>> +
>> +description:
>> +  The A73 PLL on few Qualcomm platforms is the main CPU PLL used for
>> +  frequencies above 1GHz.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,ipq9574-a73pll
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#clock-cells':
>> +    const: 0
>> +
>> +  clocks:
>> +    items:
>> +      - description: board XO clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: xo
>> +
>> +  operating-points-v2: true
> 
> Drop. I'll fix the other bindings.
> 
As suggested by konrad, will drop this file change and add the 
compatible in qcom,a53pll.yaml
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - '#clock-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    a73pll: clock@b116000 {
>> +            compatible = "qcom,ipq9574-a73pll";
> 
> Use 4 spaces for example indentation.
> 
>> +            reg = <0x0b116000 0x40>;
>> +            #clock-cells = <0>;
>> +            clocks = <&xo_board_clk>;
>> +            clock-names = "xo";
>> +    };
> 
> Best regards,
> Krzysztof
> 
Best Regards,
Devi Priya
