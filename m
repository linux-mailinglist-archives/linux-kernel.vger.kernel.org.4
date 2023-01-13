Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458EC669701
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241096AbjAMM3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241221AbjAMM2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:28:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFCA1B9F3;
        Fri, 13 Jan 2023 04:25:32 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DAbvXY003163;
        Fri, 13 Jan 2023 12:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FLKDNmDTs22NYoQdmcaDLbxot9m4TNetlGOYrtzw2mQ=;
 b=nnJ0sV30so+/JEIQKgP/kW0G9rFAYGXq2FjM6Dd5OrtbHbuusoDFphJASUVUiQceWpe3
 IyMbPGjwM2bp1W9FvJYVwYJupYnFaFmM8slPpZ2PDQYStzebzMTElUQ1lzwAW71bjPkC
 u8PSPYuTRgvBhHIHOiuFHyKmdabTV+l1rl5vpMVz1Jh1pxxXhajcog70JGMNMATjigq5
 F4/1TRvGHhG961eWlyaSLx/wtr7oYCZHbEBTqv3KsoPr8RWrORF1EPtSYROMgOAFgHNw
 o/DSaOQW7cgcrmBp1n3b8rZ3J80bAFKcNPGtG2BFvk6SJoN6ASERYbGyfBqERZaRM7cN qA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n351f8j90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 12:24:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DCOetc001712
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 12:24:40 GMT
Received: from [10.50.57.3] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 04:24:31 -0800
Message-ID: <90484f63-bd72-f3a4-b1c5-d3830c2245d0@quicinc.com>
Date:   Fri, 13 Jan 2023 17:54:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/7] dt-bindings: arm64: ipq9574: Add binding descriptions
 for clock and reset
To:     Rob Herring <robh@kernel.org>
CC:     <tdas@codeaurora.org>, <quic_kathirav@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <quic_gokulsri@quicinc.com>,
        <nfraprado@collabora.com>, <linux-arm-msm@vger.kernel.org>,
        <quic_poovendh@quicinc.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <andersson@kernel.org>, <arnd@arndb.de>, <sboyd@kernel.org>,
        <broonie@kernel.org>, <will@kernel.org>,
        <quic_sjaganat@quicinc.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-clk@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <linux-gpio@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <catalin.marinas@arm.com>, <marcel.ziswiler@toradex.com>,
        <linus.walleij@linaro.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <shawnguo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <agross@kernel.org>
References: <20230110121316.24892-1-quic_devipriy@quicinc.com>
 <20230110121316.24892-2-quic_devipriy@quicinc.com>
 <167335661700.1967953.6789968437095688240.robh@kernel.org>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <167335661700.1967953.6789968437095688240.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EDSnF2RVtGWsYcqRMoJXvr-AVfLhZTKG
X-Proofpoint-ORIG-GUID: EDSnF2RVtGWsYcqRMoJXvr-AVfLhZTKG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_05,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1011 impostorscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130083
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/2023 6:59 PM, Rob Herring wrote:
> 
> On Tue, 10 Jan 2023 17:43:10 +0530, devi priya wrote:
>> Adding support for the global clock controller found on
>> IPQ9574 based devices
>>
>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> ---
>>   .../bindings/clock/qcom,gcc-other.yaml        |   4 +
>>   .../devicetree/bindings/clock/qcom,gcc.yaml   |   9 +-
>>   include/dt-bindings/clock/qcom,gcc-ipq9574.h  | 226 ++++++++++++++++++
>>   include/dt-bindings/reset/qcom,gcc-ipq9574.h  | 164 +++++++++++++
>>   4 files changed, 402 insertions(+), 1 deletion(-)
>>   create mode 100644 include/dt-bindings/clock/qcom,gcc-ipq9574.h
>>   create mode 100644 include/dt-bindings/reset/qcom,gcc-ipq9574.h
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,sm8550-gcc.example.dtb: clock-controller@100000: clocks: [[4294967295, 0], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295, 0], [4294967295, 1], [4294967295, 2], [4294967295]] is too long
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,sm8550-gcc.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,sm8550-gcc.example.dtb: clock-controller@100000: Unevaluated properties are not allowed ('#clock-cells', '#power-domain-cells', '#reset-cells', 'reg' were unexpected)
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,sm8550-gcc.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.example.dtb: clock-controller@100000: clocks: [[4294967295, 0], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295]] is too long
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.example.dtb: clock-controller@100000: Unevaluated properties are not allowed ('#clock-cells', '#power-domain-cells', '#reset-cells', 'reg' were unexpected)
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.example.dtb: clock-controller@100000: clocks: [[4294967295, 0], [4294967295, 1], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295]] is too long
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.example.dtb: clock-controller@100000: clock-names: ['bi_tcxo', 'bi_tcxo_ao', 'sleep_clk', 'pcie_0_pipe_clk', 'pcie_1_pipe_clk', 'ufs_phy_rx_symbol_0_clk', 'ufs_phy_rx_symbol_1_clk', 'ufs_phy_tx_symbol_0_clk', 'usb3_phy_wrapper_gcc_usb30_pipe_clk'] is too long
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.example.dtb: clock-controller@100000: Unevaluated properties are not allowed ('#clock-cells', '#power-domain-cells', '#reset-cells', 'reg' were unexpected)
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230110121316.24892-2-quic_devipriy@quicinc.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 
Sure, will check

Best Regards,
Devi Priya
