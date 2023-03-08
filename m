Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5A86B0628
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCHLkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjCHLj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:39:58 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1616BB9516;
        Wed,  8 Mar 2023 03:39:52 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328ALAcT003303;
        Wed, 8 Mar 2023 11:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XL6sBXUdI8fO6TdzSnsuYZBf6t10PbWpM6nPzLYjPpQ=;
 b=k35uiSFyWXiHMYgceNjU4BmhTgxMtAanjwFEkbFPIS82MK9zqrVdeReKL4PRjpvH1DLG
 Z0nDyO3g4mmQ9Hx+tCPc0+A+9vuqOXVHCgQ6p9+JP3WvsBbGQ2JHdm9Kts0EJE+DeMI6
 /HfnLU3MNaDEF2TvThAD6PX8U4BpvFHNL0wdEXC0DA68U34wjkAPnCl6ug9j/xUUQhi6
 1K+vS1PJgDntZni8l4ZbS2R3nSE7B+U/CgQbWxQsXA3P9EBqlyORxZqkG+UWILalogYc
 tQXYiLfsh+x+PsI+oIjLOrTGfLZWoKBFoXmWZ4+RDQqBh9krl29QxX+g8rqfLG5xF/Vq Cg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6fgh1g0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 11:39:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 328Bdl7s015680
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Mar 2023 11:39:47 GMT
Received: from [10.131.117.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 8 Mar 2023
 03:39:43 -0800
Message-ID: <ecc7309e-792a-0a2b-f8ba-2ea25fbec2cb@quicinc.com>
Date:   Wed, 8 Mar 2023 17:09:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 10/11] arm64: dts: qcom: sc7280: fix EUD port properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230305125954.209559-1-krzysztof.kozlowski@linaro.org>
 <20230305125954.209559-10-krzysztof.kozlowski@linaro.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <20230305125954.209559-10-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZVLhtDAIUMVgFIyC8fwQ34iEqa4CVrtK
X-Proofpoint-GUID: ZVLhtDAIUMVgFIyC8fwQ34iEqa4CVrtK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_06,2023-03-08_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=737 spamscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/5/2023 6:29 PM, Krzysztof Kozlowski wrote:
> Nods with unit addresses must have also 'reg' property:

Nit: Should be "Nodes"

> 
>    sc7280-herobrine-crd.dtb: eud@88e0000: ports:port@0: 'reg' is a required property
> 
> Fixes: 0b059979090d ("arm64: dts: qcom: sc7280: Add EUD dt node and dwc3 connector")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>

>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index bdcb74925313..71179182c3b8 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3593,12 +3593,17 @@ eud: eud@88e0000 {
>   			      <0 0x088e2000 0 0x1000>;
>   			interrupts-extended = <&pdc 11 IRQ_TYPE_LEVEL_HIGH>;
>   			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
>   				port@0 {
> +					reg = <0>;
>   					eud_ep: endpoint {
>   						remote-endpoint = <&usb2_role_switch>;
>   					};
>   				};
>   				port@1 {
> +					reg = <1>;
>   					eud_con: endpoint {
>   						remote-endpoint = <&con_eud>;
>   					};
> @@ -3609,7 +3614,11 @@ eud_con: endpoint {
>   		eud_typec: connector {
>   			compatible = "usb-c-connector";
>   			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
>   				port@0 {
> +					reg = <0>;
>   					con_eud: endpoint {
>   						remote-endpoint = <&eud_con>;
>   					};
