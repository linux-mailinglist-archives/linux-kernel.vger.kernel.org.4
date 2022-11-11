Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A043625897
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbiKKKov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiKKKos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:44:48 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258A365E5C;
        Fri, 11 Nov 2022 02:44:47 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AB9vA9C019022;
        Fri, 11 Nov 2022 10:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oJdYxWuonUMkD49NmmkSxl5hIkspUmwaa1mPxqCCwxY=;
 b=o5MI+Xz0CV49qhWcBf2MnCcYoI/XaMKpmh0OkiWgZncflZnPQy2qHyp+wUISMPFLT5ZW
 36ubDjigWT726UhQ3KS/NMHtrWK0KjZTdZ7yi6v2bzWE/XMGsQJdthXTMgLkH85fHu3b
 JXGLgSKECRdmbS+g5fpVvj+R8VnMNdS5VXCS8HLR9ecHlXS3AdihHYUCb/nvpTB9EvNF
 CjqIyp8rSD156xmh86+zGgtwHWVAwSvBGDoGAV8J5iZ/RN1s58wgJR9JMLdzZc5PmjmO
 o2jxZIcBm89gp4ajOrHlPWYqjziExBB6Mnq67Op7fKXkq2VBOR0noV+bukkmcxRcET57 pg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kshc1gsgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 10:44:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ABAid9n013850
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 10:44:39 GMT
Received: from [10.79.43.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 11 Nov
 2022 02:44:35 -0800
Message-ID: <93ee30cc-0a9c-df77-0ad3-1c35fc04a01b@quicinc.com>
Date:   Fri, 11 Nov 2022 16:14:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 06/10] arm64: dts: qcom: Align with generic
 osm-l3/epss-l3
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Georgi Djakov <djakov@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221111032515.3460-1-quic_bjorande@quicinc.com>
 <20221111032515.3460-7-quic_bjorande@quicinc.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20221111032515.3460-7-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b0thF9S4Aop_ZFlWALpvnNk1Kd68STjk
X-Proofpoint-ORIG-GUID: b0thF9S4Aop_ZFlWALpvnNk1Kd68STjk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_06,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211110071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/22 08:55, Bjorn Andersson wrote:
> Update all references to OSM or EPSS L3 compatibles, to include the
> generic compatible, as defined by the updated binding.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Tested-by: Steev Klimaszewski <steev@kali.org>
> ---
> 
> Changes since v1:
> - None
> 
>   arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
>   arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
>   arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index ea886cf08b4d..f71cf21a8dd8 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -3558,7 +3558,7 @@
>   		};
>   
>   		osm_l3: interconnect@18321000 {
> -			compatible = "qcom,sc7180-osm-l3";
> +			compatible = "qcom,sc7180-osm-l3", "qcom,osm-l3";
>   			reg = <0 0x18321000 0 0x1400>;
>   
>   			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 07334e19be99..ad9c61768016 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -5359,7 +5359,7 @@
>   		};
>   
>   		epss_l3: interconnect@18590000 {
> -			compatible = "qcom,sc7280-epss-l3";
> +			compatible = "qcom,sc7280-epss-l3", "qcom,epss-l3";
>   			reg = <0 0x18590000 0 0x1000>;
>   			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
>   			clock-names = "xo", "alternate";
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 1a257f672887..9c7d484ce72f 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -5302,7 +5302,7 @@
>   		};
>   
>   		osm_l3: interconnect@17d41000 {
> -			compatible = "qcom,sdm845-osm-l3";
> +			compatible = "qcom,sdm845-osm-l3", "qcom,osm-l3";
>   			reg = <0 0x17d41000 0 0x1400>;
>   
>   			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 18bf51ce8b13..8409fb5ea532 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -3958,7 +3958,7 @@
>   		};
>   
>   		osm_l3: interconnect@18321000 {
> -			compatible = "qcom,sm8150-osm-l3";
> +			compatible = "qcom,sm8150-osm-l3", "qcom,osm-l3";
>   			reg = <0 0x18321000 0 0x1400>;
>   
>   			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 27b507f3632b..351c232b8dc6 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -4884,7 +4884,7 @@
>   		};
>   
>   		epss_l3: interconnect@18590000 {
> -			compatible = "qcom,sm8250-epss-l3";
> +			compatible = "qcom,sm8250-epss-l3", "qcom,epss-l3";

if we do change sc7280, sm8250 epss compatible in the bindings, you'll
no longer need to list the qcom,epss-l3 here. With ^^ done.

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>


>   			reg = <0 0x18590000 0 0x1000>;
>   
>   			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
