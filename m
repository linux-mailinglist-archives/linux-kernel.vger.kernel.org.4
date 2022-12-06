Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7486444EE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiLFNvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiLFNvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:51:13 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228602A942;
        Tue,  6 Dec 2022 05:51:11 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B63wmOT004231;
        Tue, 6 Dec 2022 13:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zl3Ghn1lfg9PII5lHlpDMdR89VqR/sd6LQJbi2HHqJo=;
 b=AX1TlU7mGk4fQCNc9juJx7dT8mxiB2ixm5LDjvFhSu/fBcIRTCSKMmA5IdiNtIaEAbXF
 7XnMQG7rC7jWTVP1eSFN2f7BLFs2qg7MiOr5po7wCdTihVArFEQxmzt1dbmyZ0POZ3y8
 YveleBn08+QfBRFSi6I9kgyhfUC7rJgwOHRP20/9vjBRxS5w+btmtWR0CG0cSBIC0uHJ
 /8134+3XrVn+fbdRaQ86ViFZLBDlIJJb9fXBkEqcAqaFhcLrooadhl7idDrAJ4/JOsBk
 X5eGoNXjKnSl+JgdgG4iBI5n8ThYYyECE0N3dobaNDfnkmIkq6KB6AcCVSz8Jjw7+s2L yg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m9rypa64d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 13:51:01 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B6Dp1LR013202
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Dec 2022 13:51:01 GMT
Received: from [10.206.12.35] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 6 Dec 2022
 05:50:57 -0800
Message-ID: <aa0134fc-e34d-e437-7d1e-f060dfa1526d@quicinc.com>
Date:   Tue, 6 Dec 2022 19:20:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3] arm64: dts: qcom: sa8540p-ride: enable PCIe support
To:     Brian Masney <bmasney@redhat.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <psodagud@quicinc.com>, <ahalaney@redhat.com>,
        <echanude@redhat.com>
References: <20221202120918.2252647-1-bmasney@redhat.com>
Content-Language: en-US
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
In-Reply-To: <20221202120918.2252647-1-bmasney@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: roh21xPZiP6EbhrgwQVN5zHc2PY7p3wY
X-Proofpoint-GUID: roh21xPZiP6EbhrgwQVN5zHc2PY7p3wY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_09,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060113
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/2/2022 5:39 PM, Brian Masney wrote:
> Add the vreg_l11a, pcie3a, pcie3a_phy, and tlmm nodes that are necessary
> in order to get PCIe working on the QDrive3.
> 
> This patch also increases the width of the ranges property for the PCIe
> switch that's found on this platform. Note that this change requires
> the latest trustzone (TZ) firmware that's available from Qualcomm as
> of November 2022. If this is used against a board with the older
> firmware, then the board will go into ramdump mode when PCIe is probed
> on startup.
> 
> The ranges property is overridden in this sa8540p-ride.dts file since
> this is what's used to describe the QDrive3 variant with dual SoCs.
> There's another variant of this board that only has a single SoC where
> this change is not applicable, and hence why this specific change was
> not done in sa8540p.dtsi.
> 
> These changes were derived from various patches that Qualcomm
> delivered to Red Hat in a downstream kernel.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Tested-by: Shazad Hussain <quic_shazhuss@quicinc.com>

This patch seems to work on both SOC1 and SOC2 for qdrive3 
(sa8540p-ride) board.

-Shazad

> ---
> Changes since v2:
> - Dropped regulator-allow-set-load (Bjorn)
> - Updated first member of ranges property to match downstream:
>    s/0x32200000/0x40200000/ (Andrew)
> 
> Changes since v1:
> - Add -state and -pins suffixes to tlmm (Krzysztof)
> 
> This patch depends on the following series that hasn't made it's way
> into linux-next yet:
> 
> [PATCH v10 0/2] arm64: dts: qcom: add dts for sa8540p-ride board
> https://lore.kernel.org/lkml/20221118025158.16902-1-quic_ppareek@quicinc.com/
> 
> I can't find the specific TZ firmware version that we have so that's why
> I included the date instead.
> 
>   arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 53 +++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> index a5f87a8629d6..a638e3784543 100644
> --- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> @@ -51,6 +51,13 @@ vreg_l7a: ldo7 {
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   		};
>   
> +		vreg_l11a: ldo11 {
> +			regulator-name = "vreg_l11a";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
>   		vreg_l13a: ldo13 {
>   			regulator-name = "vreg_l13a";
>   			regulator-min-microvolt = <3072000>;
> @@ -139,6 +146,27 @@ vreg_l8g: ldo8 {
>   	};
>   };
>   
> +&pcie3a {
> +	ranges = <0x01000000 0x0 0x40200000 0x0 0x40200000 0x0 0x100000>,
> +	         <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x20000000>,
> +	         <0x03000000 0x6 0x00000000 0x6 0x00000000 0x2 0x00000000>;
> +
> +	perst-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 56 GPIO_ACTIVE_HIGH>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie3a_default>;
> +
> +	status = "okay";
> +};
> +
> +&pcie3a_phy {
> +	vdda-phy-supply = <&vreg_l11a>;
> +	vdda-pll-supply = <&vreg_l3a>;
> +
> +	status = "okay";
> +};
> +
>   &qup2 {
>   	status = "okay";
>   };
> @@ -158,6 +186,31 @@ &remoteproc_nsp1 {
>   	status = "okay";
>   };
>   
> +&tlmm {
> +	pcie3a_default: pcie3a-default-state {
> +		perst-pins {
> +			pins = "gpio151";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +
> +		clkreq-pins {
> +			pins = "gpio150";
> +			function = "pcie3a_clkreq";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		wake-pins {
> +			pins = "gpio56";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +};
> +
>   &ufs_mem_hc {
>   	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
>   
