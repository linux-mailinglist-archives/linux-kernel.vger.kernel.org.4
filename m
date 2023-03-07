Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D696AE25A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCGO1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjCGO1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:27:37 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7D42D5C;
        Tue,  7 Mar 2023 06:22:56 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327DdHq0022356;
        Tue, 7 Mar 2023 14:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jLhYtsYcLckmbBLT5Zurw4k3j2sS8FptlRtzyXGuJxw=;
 b=apIuMFbrHvHNUyRBW1ltbrfmhRQeWJXQuVMbqKqFpj1IuCFcjXxy8lN14C90BYWvU21r
 /Q2mvvqnbv6AX3yz3ZIQnZIwcevFK0plBitAGJ6NmHxefeB6aY7PxZ9FUNZOiPm+24bM
 ddYSVRjP2aGvM/zgF5HM5cQgeSZ/HRiGiv9FW+zb/reqyl+8RdCixWNE5+yooAp6MzkK
 O0KdwlPfpi9nL4/8t6v8fAGjFRMBulW4BT9s25SVdVPrzuQ3NRmjTCJSfbY7m/PFJDbZ
 BJHlmbPDq+0gr/yE9JNfIvKvuRa5heweecaG3Qv+Rpk43Fd1V+I2zCwTf7s7tT98dTZm 0w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p60bx942n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 14:22:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 327EMlwC020071
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 14:22:47 GMT
Received: from [10.50.22.82] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Mar 2023
 06:22:38 -0800
Message-ID: <aec18281-f3c4-8631-acd8-337a0aa04316@quicinc.com>
Date:   Tue, 7 Mar 2023 19:52:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 09/11] arm64: dtsi: qcom: ipq5018: enable nodes required
 for multipd
Content-Language: en-US
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
 <1678164097-13247-10-git-send-email-quic_mmanikan@quicinc.com>
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <1678164097-13247-10-git-send-email-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gkPbN-rr4zED9jjQA9pmD-c_mGA6OD2f
X-Proofpoint-ORIG-GUID: gkPbN-rr4zED9jjQA9pmD-c_mGA6OD2f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_08,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=952 spamscore=0 phishscore=0
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
> Enable nodes required for multipd remoteproc bring up
>
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 130 ++++++++++++++++++++++++++
>   1 file changed, 130 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> index 084fb7b30dfd..4fa0990ab543 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -95,6 +95,24 @@ tz: tz@4ac00000 {
>   			reg = <0x0 0x4ac00000 0x0 0x00400000>;
>   			no-map;
>   		};
> +
> +		q6_region: wcnss@4b000000 {
> +			no-map;
> +			reg = <0x0 0x4b000000 0x0 0x01700000>;


move the no-map after reg property to keep it consistent with other 
nodes. Also no need to pad the size in reg property


> +		};
> +
> +		smem@4ab00000 {
> +			compatible = "qcom,smem";
> +			reg = <0x0 0x4ab00000 0x0 0x00100000>;
> +			hwlocks = <&tcsr_mutex 0>;
> +			no-map;
> +		};
> +	};
> +
> +	firmware {


nodes should be in sorted order, please take care of this throughout the 
changes.


> +		scm {
> +			compatible = "qcom,scm-ipq5018", "qcom,scm";
> +		};
>   	};
>   
>   	timer {
> @@ -105,6 +123,30 @@ timer {
>   			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>   	};
>   
> +	wcss: wcss-smp2p {
> +		compatible = "qcom,smp2p";
> +		qcom,smem = <435>, <428>;
> +
> +		interrupt-parent = <&intc>;
> +		interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
> +
> +		mboxes = <&apcs_glb 9>;
> +
> +		qcom,local-pid = <0>;
> +		qcom,remote-pid = <1>;
> +
> +		wcss_smp2p_out: master-kernel {
> +			qcom,entry-name = "master-kernel";
> +			#qcom,smem-state-cells = <1>;
> +		};
> +
> +		wcss_smp2p_in: slave-kernel {
> +			qcom,entry-name = "slave-kernel";
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
>   	soc: soc@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
> @@ -217,5 +259,93 @@ frame@b128000 {
>   				status = "disabled";
>   			};
>   		};
> +
> +		tcsr_mutex: hwlock@1905000 {
> +			compatible = "qcom,tcsr-mutex";
> +			reg = <0x01905000 0x8000>;


Please cover the entire region of size 128KB


> +			#hwlock-cells = <1>;
> +		};
> +
> +		apcs_glb: mailbox@b111000 {
> +			compatible = "qcom,ipq5018-apcs-apps-global";
> +			reg = <0x0b111000 0x1000>;
> +			#clock-cells = <1>;
> +			#mbox-cells = <1>;
> +		};
> +
> +		q6v5_wcss: remoteproc@cd00000 {
> +			compatible = "qcom,ipq5018-q6-mpd";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			reg = <0x0cd00000 0x4040>;


reg can be moved after compatible


> +			interrupts-extended = <&intc GIC_SPI 291 IRQ_TYPE_EDGE_RISING>,
> +					      <&wcss_smp2p_in 0 0>,
> +					      <&wcss_smp2p_in 1 0>,
> +					      <&wcss_smp2p_in 2 0>,
> +					      <&wcss_smp2p_in 3 0>;
> +			interrupt-names = "wdog",
> +					  "fatal",
> +					  "ready",
> +					  "handover",
> +					  "stop-ack";
> +
> +			qcom,smem-states = <&wcss_smp2p_out 0>,
> +					   <&wcss_smp2p_out 1>;
> +			qcom,smem-state-names = "shutdown",
> +						"stop";
> +			memory-region = <&q6_region>;
> +
> +			glink-edge {
> +				interrupts = <GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
> +				label = "rtr";
> +				qcom,remote-pid = <1>;
> +				mboxes = <&apcs_glb 8>;
> +			};
> +
> +			q6_wcss_pd1: remoteproc_pd1 {
> +				compatible = "qcom,ipq5018-wcss-ahb-mpd";
> +			};
> +
> +			q6_wcss_pd2: remoteproc_pd2 {
> +				compatible = "qcom,ipq5018-wcss-pcie-mpd";
> +				interrupts-extended = <&wcss_smp2p_in 16 0>,
> +					<&wcss_smp2p_in 17 0>,


Please take care of the alignment


> +					<&wcss_smp2p_in 20 0>,
> +					<&wcss_smp2p_in 19 0>;
> +				interrupt-names = "fatal",
> +					"ready",
> +					"spawn-ack",
> +					"stop-ack";
> +
> +				qcom,smem-states = <&wcss_smp2p_out 16>,
> +						<&wcss_smp2p_out 17>,
> +						<&wcss_smp2p_out 18>;
> +				qcom,smem-state-names = "shutdown",
> +							"stop",
> +							"spawn";
> +				status = "disabled";
> +			};
> +
> +			q6_wcss_pd3: remoteproc_pd3 {
> +				compatible = "qcom,ipq5018-wcss-pcie-mpd";
> +				interrupts-extended = <&wcss_smp2p_in 24 0>,
> +							<&wcss_smp2p_in 25 0>,
> +							<&wcss_smp2p_in 28 0>,
> +							<&wcss_smp2p_in 27 0>;
> +				interrupt-names = "fatal",
> +						"ready",
> +						"spawn-ack",
> +						"stop-ack";
> +
> +				qcom,smem-states = <&wcss_smp2p_out 24>,
> +						<&wcss_smp2p_out 25>,
> +						<&wcss_smp2p_out 26>;
> +				qcom,smem-state-names = "shutdown",
> +							"stop",
> +							"spawn";
> +				status = "disabled";
> +			};
> +		};
>   	};
>   };
