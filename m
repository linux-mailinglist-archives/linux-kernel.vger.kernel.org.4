Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826646AE2D9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjCGOkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjCGOjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:39:45 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E9C85A4E;
        Tue,  7 Mar 2023 06:35:34 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327B5E8R017812;
        Tue, 7 Mar 2023 14:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=22F4noZPb63n/Fu8WfKBMwmtnCYP0DerF7zoTtdP7tA=;
 b=CL7L7fhEO46kgHviiR6q7B4au2uBuAm0A4Vz8+NiLC4geYiCkuOySXtk73xobNYf9CfU
 mbWBUYVhazB6b8NyFR1dFmxvuIt//TPEULFHE5Jkcl2WEd6LQXMbRRKdjjgE2ra48JiY
 s6XTyADRNvbU50k2oGNLtxSiIAfz/LKI917ICiJqKQBLvIZMLOz4CxnymqK19J/NtPyo
 YhNHCQtQZruv2knudCGCPkO4t5lNvtRmN97LwV6QE5efk+YhFD6z6e9xm55temF4fpey
 if3LlOUCIv1O1YJR2Bt4BuFPiWPoG1fneLo+2UW18nHKnQ7RpiKQv7Tau6DVHbXzD0DN Tg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p60bx93j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 14:15:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 327EFXt4011566
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 14:15:33 GMT
Received: from [10.50.22.82] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Mar 2023
 06:15:24 -0800
Message-ID: <918ea75e-a890-b9cf-0f85-ed5ea102b7ec@quicinc.com>
Date:   Tue, 7 Mar 2023 19:45:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 10/11] arm64: dts: qcom: ipq5018: Add MP03.5-c1 board
 support
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <mathieu.poirier@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_gurus@quicinc.com>,
        <loic.poulain@linaro.org>, <quic_eberman@quicinc.com>,
        <robimarko@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-11-git-send-email-quic_mmanikan@quicinc.com>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <1678164097-13247-11-git-send-email-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: erFlmWjba7D_nHM6VxB3s50gPP6iK8c8
X-Proofpoint-ORIG-GUID: erFlmWjba7D_nHM6VxB3s50gPP6iK8c8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_08,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070128
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/7/2023 10:11 AM, Manikanta Mylavarapu wrote:
> Add initial device tree support for the MP03.5-C1 board.
>
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/Makefile             |  1 +
>   .../arm64/boot/dts/qcom/ipq5018-mp03.5-c1.dts | 64 +++++++++++++++++++
>   2 files changed, 65 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-mp03.5-c1.dts
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index b77a95e97a56..10d1eafe57e4 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-mp03.1-c2.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-mp03.5-c1.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c1.dtb
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018-mp03.5-c1.dts b/arch/arm64/boot/dts/qcom/ipq5018-mp03.5-c1.dts
> new file mode 100644
> index 000000000000..51ddd7367ac6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq5018-mp03.5-c1.dts
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> +/*
> + * IPQ5018 CP01 board device tree source
> + *
> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "ipq5018.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ5018/AP-MP03.5-C1";
> +	compatible = "qcom,ipq5018-mp03.5-c1", "qcom,ipq5018";
> +
> +	aliases {
> +		serial0 = &blsp1_uart1;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyMSM0,115200,n8 rw init=/init swiotlb=1 coherent_pool=2M";


Is the bootargs required?


> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&tlmm {
> +	blsp0_uart_pins: uart_pins {


node name should be uart-state {. Didn't dtbs_check complain it or am I 
missing something?


> +		pins = "gpio20", "gpio21";
> +		function = "blsp0_uart0";
> +		bias-disable;
> +	};
> +};
> +
> +&blsp1_uart1 {
> +	pinctrl-0 = <&blsp0_uart_pins>;
> +	pinctrl-names = "default";
> +	status = "ok";


s/ok/okay/


> +};
> +
> +&q6v5_wcss {
> +	q6_wcss_pd1: remoteproc_pd1 {
> +		interrupts-extended = <&wcss_smp2p_in 8 0>,
> +				<&wcss_smp2p_in 9 0>,
> +				<&wcss_smp2p_in 12 0>,
> +				<&wcss_smp2p_in 11 0>;


please align all these entries


> +		interrupt-names = "fatal",
> +				"ready",
> +				"spawn-ack",
> +				"stop-ack";
> +		qcom,smem-states = <&wcss_smp2p_out 8>,
> +				<&wcss_smp2p_out 9>,
> +				<&wcss_smp2p_out 10>;
> +		qcom,smem-state-names = "shutdown",
> +					"stop",
> +					"spawn";
> +	};


leave a blank line


> +	q6_wcss_pd2: remoteproc_pd2 {
> +		status = "okay";
> +	};
> +
> +	q6_wcss_pd3: remoteproc_pd3 {
> +		status = "okay";
> +	};
> +};
