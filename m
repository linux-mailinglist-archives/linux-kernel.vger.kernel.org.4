Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBD46DD140
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjDKE4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDKE4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:56:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A85173E;
        Mon, 10 Apr 2023 21:56:40 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33B4M6Il026832;
        Tue, 11 Apr 2023 04:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CPnsQXa10tpoYv4jCyjrL4WFQ2AlyQmNvURMMyN3zqM=;
 b=aWLQ3+kY3lktc3angB+yKKmuiQMcXiBwq1m4PwcCzaMASh7cfSsNAthOhQ+RO6Z+1Jka
 usetRinXfV30iHgLAJPMafygaLB9UtYHLZG5U4O7fo/gAZM44TD736V4JD+b65Z/WKg2
 MZ/eD2SkJmsMZNibaaZvLDNpNdPudOKp9Mn2KYvFZg//ZB8M6Pu2AHChrNrCj4U5rMKl
 VGGMdY8YvIX+tTGbks4x9RAv1AbzFqb0hW8FcCX3qGxwY2mslAU7XZW/BWV9Ya88Gp7z
 gK9zZtnxwaskbFgCOg8Fr06zMfYBMaRAflkUu+xd9BMth5/DQqPV/I1v0j6zFL/w32vv IQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pvvux0fst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 04:56:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33B4uAuH014550
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 04:56:10 GMT
Received: from [10.50.52.2] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 10 Apr
 2023 21:56:06 -0700
Message-ID: <d4a8054c-443e-d9ba-9641-ff721254d254@quicinc.com>
Date:   Tue, 11 Apr 2023 10:26:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/3] dt-bindings: clock: qcom,gcc-sc7180: document CX
 power domain
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230408134820.76050-1-krzysztof.kozlowski@linaro.org>
 <20230408134820.76050-2-krzysztof.kozlowski@linaro.org>
 <4757c33c-7e71-262d-a51a-c5f9fb53ff41@linaro.org>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <4757c33c-7e71-262d-a51a-c5f9fb53ff41@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i6c5O3ZhfELru_es5pv8z-TwzCwHevvA
X-Proofpoint-ORIG-GUID: i6c5O3ZhfELru_es5pv8z-TwzCwHevvA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_02,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110045
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/2023 7:33 PM, Konrad Dybcio wrote:
> 
> 
> On 8.04.2023 15:48, Krzysztof Kozlowski wrote:
>> The GCC clock controller needs CX power domain, at least according to
>> DTS:
>>
>>    sc7180-trogdor-pompom-r3.dtb: clock-controller@100000: Unevaluated properties are not allowed ('power-domains' was unexpected)
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
> +CC Rajendra (author of 5d6fc6321db1 ("arm64: dts: qcom:
> sc7180: Add required-opps for USB"))
> 
> Rajendra, shouldn't SC7180 GCC have PM ops to make sure a vote
> is only there when AP is active?

hmm, I am not quite sure why we would want the performance votes
from peripherals dropped when CPUs go down in idle?

> Are all GDSCs powered by CX?
> If not, wouldn't this also need power-domain-names to
> facilitate e.g. potential MX-powered ones?

For sc7180 GCC, yes.

> 
> Konrad
>>   .../devicetree/bindings/clock/qcom,gcc-sc7180.yaml         | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml
>> index 06dce0c6b7d0..8bf9b6f49550 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml
>> @@ -32,6 +32,10 @@ properties:
>>         - const: bi_tcxo_ao
>>         - const: sleep_clk
>>   
>> +  power-domains:
>> +    items:
>> +      - description: CX domain
>> +
>>   required:
>>     - compatible
>>     - clocks
>> @@ -45,6 +49,8 @@ unevaluatedProperties: false
>>   examples:
>>     - |
>>       #include <dt-bindings/clock/qcom,rpmh.h>
>> +    #include <dt-bindings/power/qcom-rpmpd.h>
>> +
>>       clock-controller@100000 {
>>         compatible = "qcom,gcc-sc7180";
>>         reg = <0x00100000 0x1f0000>;
>> @@ -52,6 +58,7 @@ examples:
>>                  <&rpmhcc RPMH_CXO_CLK_A>,
>>                  <&sleep_clk>;
>>         clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
>> +      power-domains = <&rpmhpd SC7180_CX>;
>>         #clock-cells = <1>;
>>         #reset-cells = <1>;
>>         #power-domain-cells = <1>;
