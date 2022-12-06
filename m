Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9125C64492F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbiLFQ1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiLFQ1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:27:35 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37DBDF3;
        Tue,  6 Dec 2022 08:27:34 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6FJENR028294;
        Tue, 6 Dec 2022 16:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7c9rUUN7a3dR7QSdFDzCgZSOVng77nFk6H1OiFv6SGM=;
 b=MCipxe8THHv/9DW5+rX4GrGGfKh0E6vw0zH7Qfan69fsdVAxhKiAMEjFNHnd3aIT8x3X
 /+pAOIKD8TPItzmGUa2iiDvEfwyeCl3wnumhxceBMy8EGE0xpIWcHtq2xqyVCxe7TxrK
 IV2ZFUCmwd2lGNMq9SLCFFcTm2vu2NKw6SSd3Gtb40tNZvIgZEcg1Z6vmaK4rNzS6j4U
 3cgEYFb0NfZYn+iuWpoTbZs9PJVRMlPhsKTD6HK+IsxMtoUwj6R+/6yb9ZUcx1btPyY8
 8NeIiN7CuNSgzPpa+eaq02vyL76LiGsTdKu63NRZezbz3+URyCa/eajdEDep2UgiCVmN QA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ma1661e4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 16:27:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B6GRP8A022789
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Dec 2022 16:27:25 GMT
Received: from [10.50.39.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 6 Dec 2022
 08:27:21 -0800
Message-ID: <03048338-449d-6d4b-dfa9-d4eccba5cabb@quicinc.com>
Date:   Tue, 6 Dec 2022 21:57:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v6 02/10] arm64: dts: qcom: Add base SM8550 dtsi
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20221206131252.977369-1-abel.vesa@linaro.org>
 <20221206131252.977369-3-abel.vesa@linaro.org>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20221206131252.977369-3-abel.vesa@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4qtcHSvXVKEvRAKcAP_RZOnVilkFH2mM
X-Proofpoint-GUID: 4qtcHSvXVKEvRAKcAP_RZOnVilkFH2mM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_10,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060137
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On 12/6/2022 6:42 PM, Abel Vesa wrote:
> Add base dtsi for SM8550 SoC and includes base description of
> CPUs, GCC, RPMHCC, UART, interrupt controller, TLMM, reserved
> memory, RPMh PD, TCSRCC, ITS, IPCC, AOSS QMP, LLCC, cpufreq,
> interconnect, thermal sensor, cpu cooling maps and SMMU nodes
> which helps boot to shell with console on boards with this SoC.
> 
> Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> 
> Changes since v5:
>   * changed the include of qcom,sm8550-tcsrcc.h to qcom,sm8550-tcsr.h
>

<snip>...


> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;

This should be IRQ_TYPE_LEVEL_LOW


> +
> +		intc: interrupt-controller@17100000 {
> +			compatible = "arm,gic-v3";
> +			reg = <0 0x17100000 0 0x10000>,	/* GICD */
> +			      <0 0x17180000 0 0x200000>;	/* GICR * 8 */
> +			ranges;
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			#redistributor-regions = <1>;
> +			redistributor-stride = <0 0x40000>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;

And here as well, IRQ_TYPE_LEVEL_LOW

With these 2 corrections,

Reviewed-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>


Thanks,
Sai
