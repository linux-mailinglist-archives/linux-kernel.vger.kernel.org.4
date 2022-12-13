Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58BE64B041
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 08:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbiLMHQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 02:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbiLMHQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 02:16:36 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424F216489;
        Mon, 12 Dec 2022 23:16:34 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD58oeT006912;
        Tue, 13 Dec 2022 07:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5zPcSIpw+Sw7EjI2RMem4yVGrs+JS1DweOzIyxC1zYQ=;
 b=AeyF2aCtZe132uEyFSy61BYw2+lM/fvC4RgJva1vhY1uQVC2WuZiDLgf/kEWPrrT6xc9
 9cwRZHWvG+1XAoB2EbXKcwWhn4lKxPL9OEhA7t7F2hJaIkxrtql8YBbytcoOw4D/FIU6
 FZWurSXamtlgFNm03MgHqMzPqR5ItGjxeqkp+pHWHmqP0XUtSeqNGijAuUgLoKhgns/f
 AAHIQ7TmvBQ1bqmr7ky4oJM3YE2XvZ0Zmk0MbL1DZFXWkRVnsYcayVNmibCjLKKueWj+
 3+jwz/Wj25dbaXhwHbDqr4986Jl0nJfAleZESriHIyPLg7xOK3TCViJCJ84NJC/34ByU ZA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mehje0e71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 07:16:28 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BD7GQ6p029285
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 07:16:27 GMT
Received: from [10.252.221.242] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 12 Dec
 2022 23:16:22 -0800
Message-ID: <c1c7b1eb-08e7-2ba5-d89a-e0be8f76fd69@quicinc.com>
Date:   Tue, 13 Dec 2022 12:46:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sc8280xp: add missing spi nodes
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <johan+linaro@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ahalaney@redhat.com>, <echanude@redhat.com>
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-5-bmasney@redhat.com>
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
In-Reply-To: <20221212182314.1902632-5-bmasney@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -4n2rnhqbXqbmuwH9BBYaZn2DWiqUCwJ
X-Proofpoint-ORIG-GUID: -4n2rnhqbXqbmuwH9BBYaZn2DWiqUCwJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1011 malwarescore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/2022 11:53 PM, Brian Masney wrote:
> Add the missing nodes for the spi buses that's present on this SoC.
> 
> This work was derived from various patches that Qualcomm delivered
> to Red Hat in a downstream kernel.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 384 +++++++++++++++++++++++++
>   1 file changed, 384 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 392a1509f0be..b50db09feae2 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -829,6 +829,22 @@ qup2_i2c16: i2c@880000 {
>   				status = "disabled";
>   			};
>   
> +			qup2_spi16: spi@880000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00880000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
> +				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
> +				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;

This is device property not host and same applicable for all below spi 
nodes.
Also FYI let's enable below SPI for Qdrive usecases once spidev 
compatible name is confirmed.
SE9  0x00A84000
SE22 0x00898000

-Shazad

> +				status = "disabled";
> +			};
> +
>   			qup2_i2c17: i2c@884000 {
>   				compatible = "qcom,geni-i2c";
>   				reg = <0 0x00884000 0 0x4000>;
> @@ -845,6 +861,22 @@ qup2_i2c17: i2c@884000 {
>   				status = "disabled";
>   			};
>   
> +			qup2_spi17: spi@884000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00884000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP2_S1_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
> +				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
> +				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;
> +				status = "disabled";
> +			};
> +
>   			qup2_uart17: serial@884000 {
>   				compatible = "qcom,geni-uart";
>   				reg = <0 0x00884000 0 0x4000>;
> @@ -875,6 +907,22 @@ qup2_i2c18: i2c@888000 {
>   				status = "disabled";
>   			};
>   
> +			qup2_spi18: spi@888000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00888000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP2_S2_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
> +				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
> +				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;
> +				status = "disabled";
> +			};
> +
>   			qup2_i2c19: i2c@88c000 {
>   				compatible = "qcom,geni-i2c";
>   				reg = <0 0x0088c000 0 0x4000>;
> @@ -891,6 +939,22 @@ qup2_i2c19: i2c@88c000 {
>   				status = "disabled";
>   			};
>   
> +			qup2_spi19: spi@88c000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x0088c000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
> +				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
> +				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;
> +				status = "disabled";
> +			};
> +
>   			qup2_i2c20: i2c@890000 {
>   				compatible = "qcom,geni-i2c";
>   				reg = <0 0x00890000 0 0x4000>;
> @@ -907,6 +971,22 @@ qup2_i2c20: i2c@890000 {
>   				status = "disabled";
>   			};
>   
> +			qup2_spi20: spi@890000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00890000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP2_S4_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
> +				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
> +				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;
> +				status = "disabled";
> +			};
> +
>   			qup2_i2c21: i2c@894000 {
>   				compatible = "qcom,geni-i2c";
>   				reg = <0 0x00894000 0 0x4000>;
> @@ -923,6 +1003,22 @@ qup2_i2c21: i2c@894000 {
>   				status = "disabled";
>   			};
>   
> +			qup2_spi21: spi@894000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00894000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP2_S5_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 587 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
> +				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
> +				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;
> +				status = "disabled";
> +			};
> +
>   			qup2_i2c22: i2c@898000 {
>   				compatible = "qcom,geni-i2c";
>   				reg = <0 0x00898000 0 0x4000>;
> @@ -939,6 +1035,22 @@ qup2_i2c22: i2c@898000 {
>   				status = "disabled";
>   			};
>   
> +			qup2_spi22: spi@898000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00898000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP2_S6_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
> +				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
> +				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;
> +				status = "disabled";
> +			};
> +
>   			qup2_i2c23: i2c@89c000 {
>   				compatible = "qcom,geni-i2c";
>   				reg = <0 0x0089c000 0 0x4000>;
> @@ -954,6 +1066,22 @@ qup2_i2c23: i2c@89c000 {
>   				interconnect-names = "qup-core", "qup-config", "qup-memory";
>   				status = "disabled";
>   			};
> +
> +			qup2_spi23: spi@89c000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x0089c000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP2_S7_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 834 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
> +				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
> +				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;
> +				status = "disabled";
> +			};
>   		};
>   
>   		qup0: geniqup@9c0000 {
> @@ -986,6 +1114,22 @@ qup0_i2c0: i2c@980000 {
>   				status = "disabled";
>   			};
>   
> +			qup0_spi0: spi@980000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00980000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
> +						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;
> +				status = "disabled";
> +			};
> +
>   			qup0_i2c1: i2c@984000 {
>   				compatible = "qcom,geni-i2c";
>   				reg = <0 0x00984000 0 0x4000>;
> @@ -1002,6 +1146,22 @@ qup0_i2c1: i2c@984000 {
>   				status = "disabled";
>   			};
>   
> +			qup0_spi1: spi@984000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00984000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP2_S1_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
> +						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;
> +				status = "disabled";
> +			};
> +
>   			qup0_i2c2: i2c@988000 {
>   				compatible = "qcom,geni-i2c";
>   				reg = <0 0x00988000 0 0x4000>;
> @@ -1018,6 +1178,22 @@ qup0_i2c2: i2c@988000 {
>   				status = "disabled";
>   			};
>   
> +			qup0_spi2: spi@988000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00988000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP2_S2_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
> +						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;
> +				status = "disabled";
> +			};
> +
>   			qup0_i2c3: i2c@98c000 {
>   				compatible = "qcom,geni-i2c";
>   				reg = <0 0x0098c000 0 0x4000>;
> @@ -1034,6 +1210,22 @@ qup0_i2c3: i2c@98c000 {
>   				status = "disabled";
>   			};
>   
> +			qup0_spi3: spi@98c000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x0098c000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
> +						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;
> +				status = "disabled";
> +			};
> +
>   			qup0_i2c4: i2c@990000 {
>   				compatible = "qcom,geni-i2c";
>   				reg = <0 0x00990000 0 0x4000>;
> @@ -1050,6 +1242,22 @@ qup0_i2c4: i2c@990000 {
>   				status = "disabled";
>   			};
>   
> +			qup0_spi4: spi@990000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00990000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP2_S4_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
> +						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;
> +				status = "disabled";
> +			};
> +
>   			qup0_i2c5: i2c@994000 {
>   				compatible = "qcom,geni-i2c";
>   				reg = <0 0x00994000 0 0x4000>;
> @@ -1066,6 +1274,22 @@ qup0_i2c5: i2c@994000 {
>   				status = "disabled";
>   			};
>   
> +			qup0_spi5: spi@994000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00994000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP2_S5_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
> +						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;
> +				status = "disabled";
> +			};
> +
>   			qup0_i2c6: i2c@998000 {
>   				compatible = "qcom,geni-i2c";
>   				reg = <0 0x00998000 0 0x4000>;
> @@ -1082,6 +1306,22 @@ qup0_i2c6: i2c@998000 {
>   				status = "disabled";
>   			};
>   
> +			qup0_spi6: spi@998000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00998000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP2_S6_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
> +						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;
> +				status = "disabled";
> +			};
> +
>   			qup0_i2c7: i2c@99c000 {
>   				compatible = "qcom,geni-i2c";
>   				reg = <0 0x0099c000 0 0x4000>;
> @@ -1097,6 +1337,22 @@ qup0_i2c7: i2c@99c000 {
>   				interconnect-names = "qup-core", "qup-config", "qup-memory";
>   				status = "disabled";
>   			};
> +
> +			qup0_spi7: spi@99c000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x0099c000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP2_S7_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
> +						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;
> +				status = "disabled";
> +			};
>   		};
>   
>   		qup1: geniqup@ac0000 {
> @@ -1129,6 +1385,22 @@ qup1_i2c8: i2c@a80000 {
>   				status = "disabled";
>   			};
>   
> +			qup1_spi8: spi@a80000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00a80000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
> +				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
> +				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;
> +				status = "disabled";
> +			};
> +
>   			qup1_i2c9: i2c@a84000 {
>   				compatible = "qcom,geni-i2c";
>   				reg = <0 0x00a84000 0 0x4000>;
> @@ -1145,6 +1417,22 @@ qup1_i2c9: i2c@a84000 {
>   				status = "disabled";
>   			};
>   
> +			qup1_spi9: spi@a84000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00a84000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
> +				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
> +				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;
> +				status = "disabled";
> +			};
> +
>   			qup1_i2c10: i2c@a88000 {
>   				compatible = "qcom,geni-i2c";
>   				reg = <0 0x00a88000 0 0x4000>;
> @@ -1161,6 +1449,22 @@ qup1_i2c10: i2c@a88000 {
>   				status = "disabled";
>   			};
>   
> +			qup1_spi10: spi@a88000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00a88000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
> +				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
> +				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;
> +				status = "disabled";
> +			};
> +
>   			qup1_i2c11: i2c@a8c000 {
>   				compatible = "qcom,geni-i2c";
>   				reg = <0 0x00a8c000 0 0x4000>;
> @@ -1177,6 +1481,22 @@ qup1_i2c11: i2c@a8c000 {
>   				status = "disabled";
>   			};
>   
> +			qup1_spi11: spi@a8c000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00a8c000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
> +				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
> +				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;
> +				status = "disabled";
> +			};
> +
>   			qup1_i2c12: i2c@a90000 {
>   				compatible = "qcom,geni-i2c";
>   				reg = <0 0x00a90000 0 0x4000>;
> @@ -1193,6 +1513,22 @@ qup1_i2c12: i2c@a90000 {
>   				status = "disabled";
>   			};
>   
> +			qup1_spi12: spi@a90000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00a90000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
> +				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
> +				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;
> +				status = "disabled";
> +			};
> +
>   			qup1_i2c13: i2c@a94000 {
>   				compatible = "qcom,geni-i2c";
>   				reg = <0 0x00a94000 0 0x4000>;
> @@ -1209,6 +1545,22 @@ qup1_i2c13: i2c@a94000 {
>   				status = "disabled";
>   			};
>   
> +			qup1_spi13: spi@a94000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00a94000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
> +				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
> +				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;
> +				status = "disabled";
> +			};
> +
>   			qup1_i2c14: i2c@a98000 {
>   				compatible = "qcom,geni-i2c";
>   				reg = <0 0x00a98000 0 0x4000>;
> @@ -1225,6 +1577,22 @@ qup1_i2c14: i2c@a98000 {
>   				status = "disabled";
>   			};
>   
> +			qup1_spi14: spi@a98000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00a98000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 835 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
> +				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
> +				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;
> +				status = "disabled";
> +			};
> +
>   			qup1_i2c15: i2c@a9c000 {
>   				compatible = "qcom,geni-i2c";
>   				reg = <0 0x00a9c000 0 0x4000>;
> @@ -1240,6 +1608,22 @@ qup1_i2c15: i2c@a9c000 {
>   				interconnect-names = "qup-core", "qup-config", "qup-memory";
>   				status = "disabled";
>   			};
> +
> +			qup1_spi15: spi@a9c000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00a9c000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
> +				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
> +				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				spi-max-frequency = <50000000>;
> +				status = "disabled";
> +			};
>   		};
>   
>   		pcie4: pcie@1c00000 {
