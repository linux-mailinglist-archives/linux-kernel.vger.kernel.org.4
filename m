Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5284262586D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbiKKKdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbiKKKc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:32:57 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6929129;
        Fri, 11 Nov 2022 02:32:56 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AB6gTTg017248;
        Fri, 11 Nov 2022 10:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UVW83uNwLIz1Mi4pSF9epFsA/KL1JmbnVhQWU6UQZSE=;
 b=ka0ha5nLJZVDXOaT49rcK0nRdLmdj9qXsTkLqEzVYxSiA5pytfvZCTMmz67ZMJMlYEVB
 XDGxnMR616ebT6uwwfy28DKWR29BLAIWlQ7I1MPcRpH0la/yzVJ1XdX6AcnKO+JD3o/R
 v+oUOtJJTD0Zaj0SghDqBp7j/mNc4ttACspInI4C8BeI3SqDFgkw7V8JzJ0HDJ28NfCS
 zgsLLW9cl/EBgQ4ragnWl6Y/3gIp8uJ3+K+lp1ZYyqjKbwH6Qr1xcZpadVvkueAYyW6u
 d2BGPBmj+q5nKVZ83Xklzy4INxDD+GuxMnHc0acKX2kGl/xPqwogYB+cJYmRk/BtBhGq nw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kshc1grrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 10:32:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ABAWnB3031323
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 10:32:49 GMT
Received: from [10.79.43.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 11 Nov
 2022 02:32:45 -0800
Message-ID: <d738cdd8-1963-78d4-2c6f-6597b3b02d0f@quicinc.com>
Date:   Fri, 11 Nov 2022 16:02:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 05/10] dt-bindings: interconnect: Add sm8350, sc8280xp
 and generic OSM L3 compatibles
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221111032515.3460-1-quic_bjorande@quicinc.com>
 <20221111032515.3460-6-quic_bjorande@quicinc.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20221111032515.3460-6-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -xfTtZ6u85J9IdOvGTXHvvI4SVBHI_H9
X-Proofpoint-ORIG-GUID: -xfTtZ6u85J9IdOvGTXHvvI4SVBHI_H9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_05,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211110069
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/22 08:55, Bjorn Andersson wrote:
> Add EPSS L3 compatibles for sm8350 and sc8280xp, but while at it also
> introduce generic compatible for both qcom,osm-l3 and qcom,epss-l3.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Tested-by: Steev Klimaszewski <steev@kali.org>
> ---
> 
> Changes since v1:
> - Fixed oneOf to be valid schema
> - Fixed example to follow schema
> 
>   .../bindings/interconnect/qcom,osm-l3.yaml    | 24 ++++++++++++-------
>   1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> index bf538c0c5a81..aadae4424ba9 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> @@ -16,13 +16,21 @@ description:
>   
>   properties:
>     compatible:
> -    enum:
> -      - qcom,sc7180-osm-l3
> -      - qcom,sc7280-epss-l3
> -      - qcom,sc8180x-osm-l3
> -      - qcom,sdm845-osm-l3
> -      - qcom,sm8150-osm-l3
> -      - qcom,sm8250-epss-l3
> +    oneOf:
> +      - items:
> +          - enum:
> +              - qcom,sc7180-osm-l3
> +              - qcom,sc8180x-osm-l3
> +              - qcom,sdm845-osm-l3
> +              - qcom,sm8150-osm-l3
> +          - const: qcom,osm-l3
> +      - items:
> +          - enum:
> +              - qcom,sc7280-epss-l3
> +              - qcom,sc8280xp-epss-l3
> +              - qcom,sm8250-epss-l3
> +              - qcom,sm8350-epss-l3
> +          - const: qcom,epss-l3

isn't it incorrect to describe qcom,epss-l3 as a working
backup compatible for sc7280-epss-l3 and sm8250-epss-l3?
Shouldn't we just add another items list with those 2 as
enums?

>   
>     reg:
>       maxItems: 1
> @@ -56,7 +64,7 @@ examples:
>       #define RPMH_CXO_CLK        0
>   
>       osm_l3: interconnect@17d41000 {
> -      compatible = "qcom,sdm845-osm-l3";
> +      compatible = "qcom,sdm845-osm-l3", "qcom,osm-l3";
>         reg = <0x17d41000 0x1400>;
>   
>         clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
