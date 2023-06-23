Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B7873BA12
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjFWO0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjFWO0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:26:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1CC2689;
        Fri, 23 Jun 2023 07:25:59 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NEElfF011869;
        Fri, 23 Jun 2023 14:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6rRQOoaMJFYHs1mnoBn1PWbT1N5+OSvm+DKY0uctovk=;
 b=Wjb0Sns8PHemE8CgLpSyUCFS3+d8jqxJCiTNNrfhrfx4HRsLjzBm8guuOQJ+UpQFlBJf
 fLYkMOLqi7Gdgulz3NFQmB6/Gte4ri9tByBIHvgoWlaveHp+SEAKutDWCOfELzRNI1jm
 B+Arqkz682iy049ni0m+T+ceqqkTuQ9j4EsK5gF1IcfyvY1oi7yIYoyUSDHeUy1OYMWT
 ZpT6SSe3PJ7/ewvt/98Td2ms3ORPz6TUS0oWX8uprLJaQ8t3ZTtOQZlrom0lPIjexPtN
 SHuJAyniGsd6b8z4MEv+Tt5m2uz95ZDNdanLDuuL9xwwQ0UBG86t2NaseGZVXZAke+Et Vg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rcurrhwmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 14:25:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35NEPORb006989
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 14:25:24 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 23 Jun
 2023 07:25:23 -0700
Message-ID: <b170cfa5-7b6a-7582-94cb-005de44f7863@quicinc.com>
Date:   Fri, 23 Jun 2023 08:25:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 7/9] clk: qcom: gcc-msm8998: Don't poke at some BIMC GPU
 clocks
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
CC:     Marijn Suijten <marijn.suijten@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230622-topic-8998clk-v1-0-5b7a0d6e98b1@linaro.org>
 <20230622-topic-8998clk-v1-7-5b7a0d6e98b1@linaro.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230622-topic-8998clk-v1-7-5b7a0d6e98b1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2opyMDX7WwCqPRIs7zCVG8hj4EHXKKwI
X-Proofpoint-ORIG-GUID: 2opyMDX7WwCqPRIs7zCVG8hj4EHXKKwI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230130
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/2023 5:57 AM, Konrad Dybcio wrote:
> Linux should apparently not be concerned with gcc_gpu_bimc_gfx_src_clk and
> gcc_gpu_bimc_gfx_src_clk on MSM8998, as they're preconfigured for us.
> Unregister them to prevent issues.

You mention the bimc_gfx clock twice here.  One of them has to be a typo.

Also, can you clarify the reasoning?  The RCG is controlled by the RPM, 
but the branch clock is under the control of Linux.

> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/clk/qcom/gcc-msm8998.c | 28 ----------------------------
>   1 file changed, 28 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
> index ef410f52f09f..980b5a1b58ae 100644
> --- a/drivers/clk/qcom/gcc-msm8998.c
> +++ b/drivers/clk/qcom/gcc-msm8998.c
> @@ -2136,19 +2136,6 @@ static struct clk_branch gcc_gpu_bimc_gfx_clk = {
>   	},
>   };
>   
> -static struct clk_branch gcc_gpu_bimc_gfx_src_clk = {
> -	.halt_reg = 0x7100c,
> -	.halt_check = BRANCH_HALT,
> -	.clkr = {
> -		.enable_reg = 0x7100c,
> -		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data){
> -			.name = "gcc_gpu_bimc_gfx_src_clk",
> -			.ops = &clk_branch2_ops,
> -		},
> -	},
> -};
> -
>   static struct clk_branch gcc_gpu_cfg_ahb_clk = {
>   	.halt_reg = 0x71004,
>   	.halt_check = BRANCH_HALT_SKIP,
> @@ -2168,19 +2155,6 @@ static struct clk_branch gcc_gpu_cfg_ahb_clk = {
>   	},
>   };
>   
> -static struct clk_branch gcc_gpu_snoc_dvm_gfx_clk = {
> -	.halt_reg = 0x71018,
> -	.halt_check = BRANCH_HALT,
> -	.clkr = {
> -		.enable_reg = 0x71018,
> -		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data){
> -			.name = "gcc_gpu_snoc_dvm_gfx_clk",
> -			.ops = &clk_branch2_ops,
> -		},
> -	},
> -};
> -
>   static struct clk_branch gcc_hmss_ahb_clk = {
>   	.halt_reg = 0x48000,
>   	.halt_check = BRANCH_HALT_VOTED,
> @@ -3032,9 +3006,7 @@ static struct clk_regmap *gcc_msm8998_clocks[] = {
>   	[GCC_GP3_CLK] = &gcc_gp3_clk.clkr,
>   	[GCC_BIMC_GFX_CLK] = &gcc_bimc_gfx_clk.clkr,
>   	[GCC_GPU_BIMC_GFX_CLK] = &gcc_gpu_bimc_gfx_clk.clkr,
> -	[GCC_GPU_BIMC_GFX_SRC_CLK] = &gcc_gpu_bimc_gfx_src_clk.clkr,
>   	[GCC_GPU_CFG_AHB_CLK] = &gcc_gpu_cfg_ahb_clk.clkr,
> -	[GCC_GPU_SNOC_DVM_GFX_CLK] = &gcc_gpu_snoc_dvm_gfx_clk.clkr,
>   	[GCC_HMSS_AHB_CLK] = &gcc_hmss_ahb_clk.clkr,
>   	[GCC_HMSS_AT_CLK] = &gcc_hmss_at_clk.clkr,
>   	[GCC_HMSS_RBCPR_CLK] = &gcc_hmss_rbcpr_clk.clkr,
> 

