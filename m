Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812016DDC1D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjDKNc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjDKNcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:32:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81AF30C8;
        Tue, 11 Apr 2023 06:32:22 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BDRhR8022174;
        Tue, 11 Apr 2023 13:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HI26HJ+nhy557NuPmK18XT66TpCl4PjPLK6noy/iuYA=;
 b=YOFjgl5N2ifK5Pm6jToFJvHLPydYldHMoZPI82M/ei2+foAWOX9yQYCstSj94vsvl7HR
 7vx8zX3LqwYi4qUsO1BSmY7sULD3kEYVyoPXeQyXQlao4PWPzxbOFTufb/Cd7j3jNV20
 mbnB5q+D2UU4khElVCfRI/4le7V4cXIUkdEHTenKE8DZ8fijsIJ8s9li/KfjXUTAMO1Q
 YHVsWyXpebbEFjK/BMNBdhuvO4Y+cA+0SKzX9tY/OSOqrzVukux8r/+VGR9lO5imjz9t
 re0jyucfdiXCnXIMa8+AmuHWJD6R0kFePZ9rCOf4ohOazBeR9ZqyPUm2MpMPTKGlvWP8 Xw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pvu4sska3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 13:31:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33BDVFbY014469
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 13:31:15 GMT
Received: from [10.50.52.2] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 11 Apr
 2023 06:31:10 -0700
Message-ID: <2f9f9cdd-cfbe-ca22-7308-d6b1f0c1c455@quicinc.com>
Date:   Tue, 11 Apr 2023 19:01:07 +0530
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
 <d4a8054c-443e-d9ba-9641-ff721254d254@quicinc.com>
 <c70c1a4d-50c5-2b50-18c9-7c46c3803cd4@linaro.org>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <c70c1a4d-50c5-2b50-18c9-7c46c3803cd4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4v96hJRii58BNbYeF6F_35vEHW-IkOzl
X-Proofpoint-ORIG-GUID: 4v96hJRii58BNbYeF6F_35vEHW-IkOzl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_08,2023-04-11_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110125
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/11/2023 4:57 PM, Konrad Dybcio wrote:
> 
> 
> On 11.04.2023 06:56, Rajendra Nayak wrote:
>>
>>
>> On 4/8/2023 7:33 PM, Konrad Dybcio wrote:
>>>
>>>
>>> On 8.04.2023 15:48, Krzysztof Kozlowski wrote:
>>>> The GCC clock controller needs CX power domain, at least according to
>>>> DTS:
>>>>
>>>>     sc7180-trogdor-pompom-r3.dtb: clock-controller@100000: Unevaluated properties are not allowed ('power-domains' was unexpected)
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>> +CC Rajendra (author of 5d6fc6321db1 ("arm64: dts: qcom:
>>> sc7180: Add required-opps for USB"))
>>>
>>> Rajendra, shouldn't SC7180 GCC have PM ops to make sure a vote
>>> is only there when AP is active?
> So IIUC, CX is never supposed to be shut down?

Atleast sc7180 and sc7280 do not support full CX shutdown (or power
collapse as its called), it only transitions to a Retention state
and even that in the system-wide suspend path only

> 
> Konrad
>>
>> hmm, I am not quite sure why we would want the performance votes
>> from peripherals dropped when CPUs go down in idle?
>>
>>> Are all GDSCs powered by CX?
>>> If not, wouldn't this also need power-domain-names to
>>> facilitate e.g. potential MX-powered ones?
>>
>> For sc7180 GCC, yes.
>>
>>>
>>> Konrad
>>>>    .../devicetree/bindings/clock/qcom,gcc-sc7180.yaml         | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml
>>>> index 06dce0c6b7d0..8bf9b6f49550 100644
>>>> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml
>>>> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml
>>>> @@ -32,6 +32,10 @@ properties:
>>>>          - const: bi_tcxo_ao
>>>>          - const: sleep_clk
>>>>    +  power-domains:
>>>> +    items:
>>>> +      - description: CX domain
>>>> +
>>>>    required:
>>>>      - compatible
>>>>      - clocks
>>>> @@ -45,6 +49,8 @@ unevaluatedProperties: false
>>>>    examples:
>>>>      - |
>>>>        #include <dt-bindings/clock/qcom,rpmh.h>
>>>> +    #include <dt-bindings/power/qcom-rpmpd.h>
>>>> +
>>>>        clock-controller@100000 {
>>>>          compatible = "qcom,gcc-sc7180";
>>>>          reg = <0x00100000 0x1f0000>;
>>>> @@ -52,6 +58,7 @@ examples:
>>>>                   <&rpmhcc RPMH_CXO_CLK_A>,
>>>>                   <&sleep_clk>;
>>>>          clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
>>>> +      power-domains = <&rpmhpd SC7180_CX>;
>>>>          #clock-cells = <1>;
>>>>          #reset-cells = <1>;
>>>>          #power-domain-cells = <1>;
