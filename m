Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F7F6AD852
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 08:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjCGH2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 02:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCGH2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 02:28:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8219C1ABC7;
        Mon,  6 Mar 2023 23:28:37 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3277IocE024564;
        Tue, 7 Mar 2023 07:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=F6QABCKHWqbxtVM4XSn7cntHysY136Cm7OTjlv9CQ5g=;
 b=AD3pmUo3hlWH0V5NTY96aUvd8UVh/R+96zGFk89KQ1HGCdb+hLOzBPsxzJfvaIXcqbEb
 s7lQbGV6sRPHwBuirDSea+sun0kdxDCvNER91lrEr7Tyu+6+g/D0vD7eFVSTXBsG2PvY
 X4d6hli3uKYXaLsBNCOgC5EhtnMIk44xWRGN1sLyPNs5sMKasVdJJGDwfAzykkxuuQxZ
 gD6MqADDJ14LTugY0Wsnq/giQ6wz7Yc8yGm7nyx7bk1MzkEf5wdKDvt6cuLypUjvCBDJ
 uo3u1ZxYU6c/XTzJmhrxK7CpxIgmrJLK4YIUKdJEbkXAf3qLlJjBf9TQiw4eRaQMESMB kg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p5nkw9jj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 07:28:32 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3277SVaO024116
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 07:28:31 GMT
Received: from [10.201.3.182] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 6 Mar 2023
 23:28:23 -0800
Message-ID: <3298e7f6-ec63-077e-7dc9-2243670bc026@quicinc.com>
Date:   Tue, 7 Mar 2023 12:58:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 06/11] clk: qcom: IPQ9574: Add q6/wcss clocks
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
CC:     <quic_gokulsri@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-7-git-send-email-quic_mmanikan@quicinc.com>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <1678164097-13247-7-git-send-email-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ijw2X5OLzAv1OQ5dn1V7rR9QN-cvyVV1
X-Proofpoint-ORIG-GUID: ijw2X5OLzAv1OQ5dn1V7rR9QN-cvyVV1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_02,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 malwarescore=0 mlxlogscore=900 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070066
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
> Some of the clocks required for q6/wcss bring up
> are missing. So this patch adds clocks.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>   drivers/clk/qcom/gcc-ipq9574.c | 119 +++++++++++++++++++++++++++++++++
>   1 file changed, 119 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
> index 1bf33d582dc2..355f2e12d9c6 100644
> --- a/drivers/clk/qcom/gcc-ipq9574.c
> +++ b/drivers/clk/qcom/gcc-ipq9574.c
> @@ -2697,6 +2697,22 @@ static struct clk_branch gcc_wcss_acmt_clk = {
>   	},
>   };
>   
> +static struct clk_branch gcc_wcss_ahb_s_clk = {
> +	.halt_reg = 0x25060,
> +	.clkr = {
> +		.enable_reg = 0x25060,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_wcss_ahb_s_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +					&wcss_ahb_clk_src.clkr.hw },
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
>   static struct clk_branch gcc_sys_noc_wcss_ahb_clk = {
>   	.halt_reg = 0x2e030,
>   	.clkr = {
> @@ -2734,6 +2750,22 @@ static struct clk_rcg2 wcss_axi_m_clk_src = {
>   	},
>   };
>   
> +static struct clk_branch gcc_wcss_axi_m_clk = {
> +	.halt_reg = 0x25064,
> +	.clkr = {
> +		.enable_reg = 0x25064,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_wcss_axi_m_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +					&wcss_axi_m_clk_src.clkr.hw },
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
>   static struct clk_branch gcc_anoc_wcss_axi_m_clk = {
>   	.halt_reg = 0x2e0a8,
>   	.clkr = {
> @@ -2803,6 +2835,22 @@ static struct clk_branch gcc_wcss_dbg_ifc_atb_clk = {
>   	},
>   };
>   
> +static struct clk_branch gcc_wcss_dbg_ifc_atb_bdg_clk = {
> +	.halt_reg = 0x2504C,
> +	.clkr = {
> +		.enable_reg = 0x2504C,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_wcss_dbg_ifc_atb_bdg_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +					&qdss_at_clk_src.clkr.hw },
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
>   static struct clk_branch gcc_nssnoc_atb_clk = {
>   	.halt_reg = 0x17014,
>   	.clkr = {
> @@ -3073,6 +3121,22 @@ static struct clk_branch gcc_wcss_dbg_ifc_nts_clk = {
>   	},
>   };
>   
> +static struct clk_branch gcc_wcss_dbg_ifc_nts_bdg_clk = {
> +	.halt_reg = 0x25050,
> +	.clkr = {
> +		.enable_reg = 0x25050,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_wcss_dbg_ifc_nts_bdg_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +					&qdss_tsctr_div2_clk_src.hw },
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
>   static struct clk_branch gcc_qdss_tsctr_div2_clk = {
>   	.halt_reg = 0x2d044,
>   	.clkr = {
> @@ -3315,6 +3379,38 @@ static struct clk_branch gcc_wcss_dbg_ifc_dapbus_clk = {
>   	},
>   };
>   
> +static struct clk_branch gcc_wcss_dbg_ifc_apb_bdg_clk = {
> +	.halt_reg = 0x25048,
> +	.clkr = {
> +		.enable_reg = 0x25048,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_wcss_dbg_ifc_apb_bdg_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +					&qdss_dap_sync_clk_src.hw },
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_wcss_dbg_ifc_dapbus_bdg_clk = {
> +	.halt_reg = 0x25054,
> +	.clkr = {
> +		.enable_reg = 0x25054,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_wcss_dbg_ifc_dapbus_bdg_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +					&qdss_dap_sync_clk_src.hw },
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
>   static struct clk_branch gcc_qdss_dap_clk = {
>   	.halt_reg = 0x2d058,
>   	.clkr = {
> @@ -3513,6 +3609,22 @@ static struct clk_rcg2 q6_axim2_clk_src = {
>   	},
>   };
>   
> +static struct clk_branch gcc_q6_axim2_clk = {
> +	.halt_reg = 0x25010,
> +	.clkr = {
> +		.enable_reg = 0x25010,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_q6_axim2_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +					&q6_axim2_clk_src.clkr.hw },
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +

These clocks does not seem to be used in the driver, where are they used ?

Regards,
  Sricharan
