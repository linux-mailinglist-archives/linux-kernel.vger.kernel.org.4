Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984D36ECA02
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjDXKQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjDXKP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:15:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF257135;
        Mon, 24 Apr 2023 03:15:52 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33O7UTCm002834;
        Mon, 24 Apr 2023 10:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ElZBHT4F9yIlU00dNDpYXq9Y4XO0pIpsD+JT/+phUeI=;
 b=KuMZQADZYOy+ArAQJKjHfeEJ2znjaKi+ptyoAsig0KKnqP6wqOtwyn8AeDymQhM4ZxSg
 RCWydWKRx8FyR7rlM3n95ZiFcuKSIp2Iq3tRTYDJEteN3JpUbfO9YIO/fbVDebXINUgi
 wp36Jx/KEpQU1fG7yZp+x5JribAcw0Xq+CC3v6pxSbGT7OlaK2qW4CSmiFIrZNkkOx+o
 zQx3gYCKPlI6rSJ1qIaPU5Mytu2rm4oAKctsGKMuMq9GZ0c2zpiTax8zkvA2nBOQraRE
 iBjQUcDgtZJIbb4LZxxt57V+omJ2/ye2UVBRmjPITjXzghrKZWRLgAIOz7AApl3BJUz1 rg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q488s33kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 10:15:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33OAFOjR024274
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 10:15:24 GMT
Received: from [10.216.49.0] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 24 Apr
 2023 03:15:17 -0700
Message-ID: <9113b69d-538d-2442-7723-07e7ef30c068@quicinc.com>
Date:   Mon, 24 Apr 2023 15:45:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 2/4] clk: qcom: gcc-ipq9574: Drop bias_pll_ubi_nc_clk &
 add const to clk_init_data
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
References: <20230417053355.25691-1-quic_devipriy@quicinc.com>
 <20230417053355.25691-3-quic_devipriy@quicinc.com>
 <1a9f8ca2-37ab-6b63-c209-a5d10abcbfe1@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <1a9f8ca2-37ab-6b63-c209-a5d10abcbfe1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IncbOTTvAvU24dHe9rSEcLLW1h7NfDWH
X-Proofpoint-GUID: IncbOTTvAvU24dHe9rSEcLLW1h7NfDWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_06,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304240092
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/2023 4:22 PM, Konrad Dybcio wrote:
> 
> 
> On 17.04.2023 07:33, Devi Priya wrote:
>> Drop the unused backup source bias_pll_ubi_nc_clk and make clk_init_data
>> struct constant. Also, sort the includes alphabetically and include
>> clk-provider.h, clk-rcg.h, common.h and drop few unnecessary ones.
>>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   Changes since V9:
>> 	- Dropped unnecessary includes of_device.h & err.h
>> 	  and added few necessary ones clk-provider.h, clk-rcg.h and common.h
>> 	- Modified struct clk_init_data to const struct clk_init_data throughout
>> 	- Removed the unused backup source (bias_pll_ubi_nc_clk) entries
>>
>>   drivers/clk/qcom/gcc-ipq9574.c | 475 ++++++++++++++++-----------------
>>   1 file changed, 226 insertions(+), 249 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
>> index b2a2d618a5ec..ca40cb810a95 100644
>> --- a/drivers/clk/qcom/gcc-ipq9574.c
>> +++ b/drivers/clk/qcom/gcc-ipq9574.c
>> @@ -3,31 +3,30 @@
>>    * Copyright (c) 2023 The Linux Foundation. All rights reserved.
>>    */
>>   
>> +#include <linux/clk-provider.h>
>>   #include <linux/kernel.h>
>> -#include <linux/err.h>
>> -#include <linux/platform_device.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>> -#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>>   #include <linux/regmap.h>
>>   
>> -#include <linux/reset-controller.h>
>>   #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>>   #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
>>   
>> -#include "clk-rcg.h"
>> -#include "clk-branch.h"
>>   #include "clk-alpha-pll.h"
>> +#include "clk-branch.h"
>> +#include "clk-rcg.h"
>> +#include "clk-regmap.h"
>>   #include "clk-regmap-divider.h"
>>   #include "clk-regmap-mux.h"
>>   #include "clk-regmap-phy-mux.h"
>> +#include "common.h"
>>   #include "reset.h"
>>   
>>   /* Need to match the order of clocks in DT binding */
>>   enum {
>>   	DT_XO,
>>   	DT_SLEEP_CLK,
>> -	DT_BIAS_PLL_UBI_NC_CLK,
>>   	DT_PCIE30_PHY0_PIPE_CLK,
> bye ABI compatibility..

Okay, will leave the clock entry as zero in the DT as suggested
and retain the DT_BIAS_PLL_UBI_NC_CLK entries here.

> 
> On a note, this patch should have probably been 3 separate ones:
> 
> - clean up headers
> - constify structs
> - drop these clocks (but not break the DT ABI while at it..)
Okay, Got it.
> 
Thanks,
Devi Priya
> Konrad
>>   	DT_PCIE30_PHY1_PIPE_CLK,
>>   	DT_PCIE30_PHY2_PIPE_CLK,
>> @@ -48,7 +47,6 @@ enum {
>>   	P_GPLL2,
>>   	P_GPLL4,
>>   	P_PI_SLEEP,
>> -	P_BIAS_PLL_UBI_NC_CLK,
>>   };
>>   
>>   static const struct parent_map gcc_xo_map[] = {
>> @@ -69,7 +67,7 @@ static struct clk_alpha_pll gpll0_main = {
>>   	.clkr = {
>>   		.enable_reg = 0x0b000,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gpll0_main",
>>   			.parent_data = gcc_xo_data,
>>   			.num_parents = ARRAY_SIZE(gcc_xo_data),
>> @@ -81,7 +79,7 @@ static struct clk_alpha_pll gpll0_main = {
>>   static struct clk_fixed_factor gpll0_out_main_div2 = {
>>   	.mult = 1,
>>   	.div = 2,
>> -	.hw.init = &(struct clk_init_data) {
>> +	.hw.init = &(const struct clk_init_data) {
>>   		.name = "gpll0_out_main_div2",
>>   		.parent_hws = (const struct clk_hw *[]) {
>>   			&gpll0_main.clkr.hw
>> @@ -96,7 +94,7 @@ static struct clk_alpha_pll_postdiv gpll0 = {
>>   	.offset = 0x20000,
>>   	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
>>   	.width = 4,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "gpll0",
>>   		.parent_hws = (const struct clk_hw *[]) {
>>   			&gpll0_main.clkr.hw
>> @@ -113,7 +111,7 @@ static struct clk_alpha_pll gpll4_main = {
>>   	.clkr = {
>>   		.enable_reg = 0x0b000,
>>   		.enable_mask = BIT(2),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gpll4_main",
>>   			.parent_data = gcc_xo_data,
>>   			.num_parents = ARRAY_SIZE(gcc_xo_data),
>> @@ -126,7 +124,7 @@ static struct clk_alpha_pll_postdiv gpll4 = {
>>   	.offset = 0x22000,
>>   	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
>>   	.width = 4,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "gpll4",
>>   		.parent_hws = (const struct clk_hw *[]) {
>>   			&gpll4_main.clkr.hw
>> @@ -143,7 +141,7 @@ static struct clk_alpha_pll gpll2_main = {
>>   	.clkr = {
>>   		.enable_reg = 0x0b000,
>>   		.enable_mask = BIT(1),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gpll2_main",
>>   			.parent_data = gcc_xo_data,
>>   			.num_parents = ARRAY_SIZE(gcc_xo_data),
>> @@ -156,7 +154,7 @@ static struct clk_alpha_pll_postdiv gpll2 = {
>>   	.offset = 0x21000,
>>   	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
>>   	.width = 4,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "gpll2",
>>   		.parent_hws = (const struct clk_hw *[]) {
>>   			&gpll2_main.clkr.hw
>> @@ -172,7 +170,7 @@ static struct clk_branch gcc_sleep_clk_src = {
>>   	.clkr = {
>>   		.enable_reg = 0x3400c,
>>   		.enable_mask = BIT(1),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_sleep_clk_src",
>>   			.parent_data = gcc_sleep_clk_data,
>>   			.num_parents = ARRAY_SIZE(gcc_sleep_clk_data),
>> @@ -256,20 +254,6 @@ static const struct parent_map gcc_xo_gpll0_core_pi_sleep_clk_map[] = {
>>   	{ P_PI_SLEEP, 6 },
>>   };
>>   
>> -static const struct clk_parent_data gcc_xo_gpll0_gpll4_bias_pll_ubi_nc_clk[] = {
>> -	{ .index = DT_XO },
>> -	{ .hw = &gpll0.clkr.hw },
>> -	{ .hw = &gpll4.clkr.hw },
>> -	{ .index = DT_BIAS_PLL_UBI_NC_CLK },
>> -};
>> -
>> -static const struct parent_map gcc_xo_gpll0_gpll4_bias_pll_ubi_nc_clk_map[] = {
>> -	{ P_XO, 0 },
>> -	{ P_GPLL0, 1 },
>> -	{ P_GPLL4, 2 },
>> -	{ P_BIAS_PLL_UBI_NC_CLK, 3 },
>> -};
>> -
>>   static const struct clk_parent_data
>>   			gcc_xo_gpll0_gpll0_aux_core_pi_sleep_clk[] = {
>>   	{ .index = DT_XO },
>> @@ -420,7 +404,7 @@ static struct clk_rcg2 apss_ahb_clk_src = {
>>   	.freq_tbl = ftbl_apss_ahb_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "apss_ahb_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
>> @@ -438,7 +422,7 @@ static struct clk_rcg2 apss_axi_clk_src = {
>>   	.freq_tbl = ftbl_apss_axi_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_div2_gpll0_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "apss_axi_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_div2_gpll0,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_div2_gpll0),
>> @@ -458,7 +442,7 @@ static struct clk_rcg2 blsp1_qup1_i2c_apps_clk_src = {
>>   	.freq_tbl = ftbl_blsp1_qup_i2c_apps_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "blsp1_qup1_i2c_apps_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
>> @@ -483,7 +467,7 @@ static struct clk_rcg2 blsp1_qup1_spi_apps_clk_src = {
>>   	.mnd_width = 8,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "blsp1_qup1_spi_apps_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
>> @@ -496,7 +480,7 @@ static struct clk_rcg2 blsp1_qup2_i2c_apps_clk_src = {
>>   	.freq_tbl = ftbl_blsp1_qup_i2c_apps_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "blsp1_qup2_i2c_apps_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
>> @@ -510,7 +494,7 @@ static struct clk_rcg2 blsp1_qup2_spi_apps_clk_src = {
>>   	.mnd_width = 8,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "blsp1_qup2_spi_apps_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
>> @@ -523,7 +507,7 @@ static struct clk_rcg2 blsp1_qup3_i2c_apps_clk_src = {
>>   	.freq_tbl = ftbl_blsp1_qup_i2c_apps_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "blsp1_qup3_i2c_apps_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
>> @@ -537,7 +521,7 @@ static struct clk_rcg2 blsp1_qup3_spi_apps_clk_src = {
>>   	.mnd_width = 8,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "blsp1_qup3_spi_apps_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
>> @@ -550,7 +534,7 @@ static struct clk_rcg2 blsp1_qup4_i2c_apps_clk_src = {
>>   	.freq_tbl = ftbl_blsp1_qup_i2c_apps_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "blsp1_qup4_i2c_apps_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
>> @@ -564,7 +548,7 @@ static struct clk_rcg2 blsp1_qup4_spi_apps_clk_src = {
>>   	.mnd_width = 8,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "blsp1_qup4_spi_apps_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
>> @@ -577,7 +561,7 @@ static struct clk_rcg2 blsp1_qup5_i2c_apps_clk_src = {
>>   	.freq_tbl = ftbl_blsp1_qup_i2c_apps_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "blsp1_qup5_i2c_apps_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
>> @@ -591,7 +575,7 @@ static struct clk_rcg2 blsp1_qup5_spi_apps_clk_src = {
>>   	.mnd_width = 8,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "blsp1_qup5_spi_apps_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
>> @@ -604,7 +588,7 @@ static struct clk_rcg2 blsp1_qup6_i2c_apps_clk_src = {
>>   	.freq_tbl = ftbl_blsp1_qup_i2c_apps_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "blsp1_qup6_i2c_apps_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
>> @@ -618,7 +602,7 @@ static struct clk_rcg2 blsp1_qup6_spi_apps_clk_src = {
>>   	.mnd_width = 8,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "blsp1_qup6_spi_apps_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
>> @@ -650,7 +634,7 @@ static struct clk_rcg2 blsp1_uart1_apps_clk_src = {
>>   	.mnd_width = 16,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "blsp1_uart1_apps_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
>> @@ -664,7 +648,7 @@ static struct clk_rcg2 blsp1_uart2_apps_clk_src = {
>>   	.mnd_width = 16,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "blsp1_uart2_apps_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
>> @@ -678,7 +662,7 @@ static struct clk_rcg2 blsp1_uart3_apps_clk_src = {
>>   	.mnd_width = 16,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "blsp1_uart3_apps_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
>> @@ -692,7 +676,7 @@ static struct clk_rcg2 blsp1_uart4_apps_clk_src = {
>>   	.mnd_width = 16,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "blsp1_uart4_apps_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
>> @@ -706,7 +690,7 @@ static struct clk_rcg2 blsp1_uart5_apps_clk_src = {
>>   	.mnd_width = 16,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "blsp1_uart5_apps_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
>> @@ -720,7 +704,7 @@ static struct clk_rcg2 blsp1_uart6_apps_clk_src = {
>>   	.mnd_width = 16,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "blsp1_uart6_apps_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
>> @@ -734,7 +718,7 @@ static struct clk_branch gcc_apss_ahb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x0b004,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_apss_ahb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&apss_ahb_clk_src.clkr.hw
>> @@ -752,7 +736,7 @@ static struct clk_branch gcc_apss_axi_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x0b004,
>>   		.enable_mask = BIT(1),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_apss_axi_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&apss_axi_clk_src.clkr.hw
>> @@ -769,7 +753,7 @@ static struct clk_branch gcc_blsp1_qup1_i2c_apps_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2024,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_blsp1_qup1_i2c_apps_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&blsp1_qup1_i2c_apps_clk_src.clkr.hw
>> @@ -786,7 +770,7 @@ static struct clk_branch gcc_blsp1_qup1_spi_apps_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x02020,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_blsp1_qup1_spi_apps_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&blsp1_qup1_spi_apps_clk_src.clkr.hw
>> @@ -803,7 +787,7 @@ static struct clk_branch gcc_blsp1_qup2_i2c_apps_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x03024,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_blsp1_qup2_i2c_apps_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&blsp1_qup2_i2c_apps_clk_src.clkr.hw
>> @@ -820,7 +804,7 @@ static struct clk_branch gcc_blsp1_qup2_spi_apps_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x03020,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_blsp1_qup2_spi_apps_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&blsp1_qup2_spi_apps_clk_src.clkr.hw
>> @@ -837,7 +821,7 @@ static struct clk_branch gcc_blsp1_qup3_i2c_apps_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x04024,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_blsp1_qup3_i2c_apps_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&blsp1_qup3_i2c_apps_clk_src.clkr.hw
>> @@ -854,7 +838,7 @@ static struct clk_branch gcc_blsp1_qup3_spi_apps_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x04020,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_blsp1_qup3_spi_apps_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&blsp1_qup3_spi_apps_clk_src.clkr.hw
>> @@ -871,7 +855,7 @@ static struct clk_branch gcc_blsp1_qup4_i2c_apps_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x05024,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_blsp1_qup4_i2c_apps_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&blsp1_qup4_i2c_apps_clk_src.clkr.hw
>> @@ -888,7 +872,7 @@ static struct clk_branch gcc_blsp1_qup4_spi_apps_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x05020,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_blsp1_qup4_spi_apps_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&blsp1_qup4_spi_apps_clk_src.clkr.hw
>> @@ -905,7 +889,7 @@ static struct clk_branch gcc_blsp1_qup5_i2c_apps_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x06024,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_blsp1_qup5_i2c_apps_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&blsp1_qup5_i2c_apps_clk_src.clkr.hw
>> @@ -922,7 +906,7 @@ static struct clk_branch gcc_blsp1_qup5_spi_apps_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x06020,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_blsp1_qup5_spi_apps_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&blsp1_qup5_spi_apps_clk_src.clkr.hw
>> @@ -939,7 +923,7 @@ static struct clk_branch gcc_blsp1_qup6_i2c_apps_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x07024,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_blsp1_qup6_i2c_apps_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&blsp1_qup6_i2c_apps_clk_src.clkr.hw
>> @@ -956,7 +940,7 @@ static struct clk_branch gcc_blsp1_qup6_spi_apps_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x07020,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_blsp1_qup6_spi_apps_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&blsp1_qup6_spi_apps_clk_src.clkr.hw
>> @@ -973,7 +957,7 @@ static struct clk_branch gcc_blsp1_uart1_apps_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x02040,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_blsp1_uart1_apps_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&blsp1_uart1_apps_clk_src.clkr.hw
>> @@ -990,7 +974,7 @@ static struct clk_branch gcc_blsp1_uart2_apps_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x03040,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_blsp1_uart2_apps_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&blsp1_uart2_apps_clk_src.clkr.hw
>> @@ -1007,7 +991,7 @@ static struct clk_branch gcc_blsp1_uart3_apps_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x04054,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_blsp1_uart3_apps_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&blsp1_uart3_apps_clk_src.clkr.hw
>> @@ -1024,7 +1008,7 @@ static struct clk_branch gcc_blsp1_uart4_apps_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x05040,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_blsp1_uart4_apps_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&blsp1_uart4_apps_clk_src.clkr.hw
>> @@ -1041,7 +1025,7 @@ static struct clk_branch gcc_blsp1_uart5_apps_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x06040,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_blsp1_uart5_apps_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&blsp1_uart5_apps_clk_src.clkr.hw
>> @@ -1058,7 +1042,7 @@ static struct clk_branch gcc_blsp1_uart6_apps_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x07040,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_blsp1_uart6_apps_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&blsp1_uart6_apps_clk_src.clkr.hw
>> @@ -1080,7 +1064,7 @@ static struct clk_rcg2 pcie0_axi_m_clk_src = {
>>   	.freq_tbl = ftbl_pcie0_axi_m_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll4_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "pcie0_axi_m_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll4,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4),
>> @@ -1093,7 +1077,7 @@ static struct clk_branch gcc_pcie0_axi_m_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x28038,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie0_axi_m_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie0_axi_m_clk_src.clkr.hw
>> @@ -1110,7 +1094,7 @@ static struct clk_branch gcc_anoc_pcie0_1lane_m_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2e07c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_anoc_pcie0_1lane_m_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie0_axi_m_clk_src.clkr.hw
>> @@ -1127,7 +1111,7 @@ static struct clk_rcg2 pcie1_axi_m_clk_src = {
>>   	.freq_tbl = ftbl_pcie0_axi_m_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll4_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "pcie1_axi_m_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll4,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4),
>> @@ -1140,7 +1124,7 @@ static struct clk_branch gcc_pcie1_axi_m_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x29038,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie1_axi_m_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie1_axi_m_clk_src.clkr.hw
>> @@ -1157,7 +1141,7 @@ static struct clk_branch gcc_anoc_pcie1_1lane_m_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2e08c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_anoc_pcie1_1lane_m_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie1_axi_m_clk_src.clkr.hw
>> @@ -1178,11 +1162,11 @@ static struct clk_rcg2 pcie2_axi_m_clk_src = {
>>   	.cmd_rcgr = 0x2a018,
>>   	.freq_tbl = ftbl_pcie2_axi_m_clk_src,
>>   	.hid_width = 5,
>> -	.parent_map = gcc_xo_gpll0_gpll4_bias_pll_ubi_nc_clk_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.parent_map = gcc_xo_gpll0_gpll4_map,
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "pcie2_axi_m_clk_src",
>> -		.parent_data = gcc_xo_gpll0_gpll4_bias_pll_ubi_nc_clk,
>> -		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4_bias_pll_ubi_nc_clk),
>> +		.parent_data = gcc_xo_gpll0_gpll4,
>> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4),
>>   		.ops = &clk_rcg2_ops,
>>   	},
>>   };
>> @@ -1192,7 +1176,7 @@ static struct clk_branch gcc_pcie2_axi_m_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2a038,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie2_axi_m_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie2_axi_m_clk_src.clkr.hw
>> @@ -1209,7 +1193,7 @@ static struct clk_branch gcc_anoc_pcie2_2lane_m_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2e080,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_anoc_pcie2_2lane_m_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie2_axi_m_clk_src.clkr.hw
>> @@ -1225,11 +1209,11 @@ static struct clk_rcg2 pcie3_axi_m_clk_src = {
>>   	.cmd_rcgr = 0x2b018,
>>   	.freq_tbl = ftbl_pcie2_axi_m_clk_src,
>>   	.hid_width = 5,
>> -	.parent_map = gcc_xo_gpll0_gpll4_bias_pll_ubi_nc_clk_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.parent_map = gcc_xo_gpll0_gpll4_map,
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "pcie3_axi_m_clk_src",
>> -		.parent_data = gcc_xo_gpll0_gpll4_bias_pll_ubi_nc_clk,
>> -		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4_bias_pll_ubi_nc_clk),
>> +		.parent_data = gcc_xo_gpll0_gpll4,
>> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4),
>>   		.ops = &clk_rcg2_ops,
>>   	},
>>   };
>> @@ -1239,7 +1223,7 @@ static struct clk_branch gcc_pcie3_axi_m_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2b038,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie3_axi_m_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie3_axi_m_clk_src.clkr.hw
>> @@ -1256,7 +1240,7 @@ static struct clk_branch gcc_anoc_pcie3_2lane_m_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2e090,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_anoc_pcie3_2lane_m_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie3_axi_m_clk_src.clkr.hw
>> @@ -1273,7 +1257,7 @@ static struct clk_rcg2 pcie0_axi_s_clk_src = {
>>   	.freq_tbl = ftbl_pcie0_axi_m_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll4_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "pcie0_axi_s_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll4,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4),
>> @@ -1286,7 +1270,7 @@ static struct clk_branch gcc_pcie0_axi_s_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2803c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie0_axi_s_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie0_axi_s_clk_src.clkr.hw
>> @@ -1303,7 +1287,7 @@ static struct clk_branch gcc_pcie0_axi_s_bridge_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x28040,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie0_axi_s_bridge_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie0_axi_s_clk_src.clkr.hw
>> @@ -1320,7 +1304,7 @@ static struct clk_branch gcc_snoc_pcie0_1lane_s_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2e048,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_snoc_pcie0_1lane_s_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie0_axi_s_clk_src.clkr.hw
>> @@ -1337,7 +1321,7 @@ static struct clk_rcg2 pcie1_axi_s_clk_src = {
>>   	.freq_tbl = ftbl_pcie0_axi_m_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll4_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "pcie1_axi_s_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll4,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4),
>> @@ -1350,7 +1334,7 @@ static struct clk_branch gcc_pcie1_axi_s_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2903c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie1_axi_s_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie1_axi_s_clk_src.clkr.hw
>> @@ -1367,7 +1351,7 @@ static struct clk_branch gcc_pcie1_axi_s_bridge_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x29040,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie1_axi_s_bridge_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie1_axi_s_clk_src.clkr.hw
>> @@ -1384,7 +1368,7 @@ static struct clk_branch gcc_snoc_pcie1_1lane_s_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2e04c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_snoc_pcie1_1lane_s_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie1_axi_s_clk_src.clkr.hw
>> @@ -1401,7 +1385,7 @@ static struct clk_rcg2 pcie2_axi_s_clk_src = {
>>   	.freq_tbl = ftbl_pcie0_axi_m_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll4_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "pcie2_axi_s_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll4,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4),
>> @@ -1414,7 +1398,7 @@ static struct clk_branch gcc_pcie2_axi_s_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2a03c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie2_axi_s_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie2_axi_s_clk_src.clkr.hw
>> @@ -1431,7 +1415,7 @@ static struct clk_branch gcc_pcie2_axi_s_bridge_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2a040,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie2_axi_s_bridge_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie2_axi_s_clk_src.clkr.hw
>> @@ -1448,7 +1432,7 @@ static struct clk_branch gcc_snoc_pcie2_2lane_s_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2e050,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_snoc_pcie2_2lane_s_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie2_axi_s_clk_src.clkr.hw
>> @@ -1465,7 +1449,7 @@ static struct clk_rcg2 pcie3_axi_s_clk_src = {
>>   	.freq_tbl = ftbl_pcie0_axi_m_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll4_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "pcie3_axi_s_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll4,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4),
>> @@ -1478,7 +1462,7 @@ static struct clk_branch gcc_pcie3_axi_s_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2b03c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie3_axi_s_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie3_axi_s_clk_src.clkr.hw
>> @@ -1495,7 +1479,7 @@ static struct clk_branch gcc_pcie3_axi_s_bridge_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2b040,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie3_axi_s_bridge_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie3_axi_s_clk_src.clkr.hw
>> @@ -1512,7 +1496,7 @@ static struct clk_branch gcc_snoc_pcie3_2lane_s_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2e054,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_snoc_pcie3_2lane_s_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie3_axi_s_clk_src.clkr.hw
>> @@ -1527,7 +1511,7 @@ static struct clk_branch gcc_snoc_pcie3_2lane_s_clk = {
>>   static struct clk_regmap_phy_mux pcie0_pipe_clk_src = {
>>   	.reg = 0x28064,
>>   	.clkr = {
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "pcie0_pipe_clk_src",
>>   			.parent_data = &(const struct clk_parent_data) {
>>   				.index = DT_PCIE30_PHY0_PIPE_CLK,
>> @@ -1541,7 +1525,7 @@ static struct clk_regmap_phy_mux pcie0_pipe_clk_src = {
>>   static struct clk_regmap_phy_mux pcie1_pipe_clk_src = {
>>   	.reg = 0x29064,
>>   	.clkr = {
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "pcie1_pipe_clk_src",
>>   			.parent_data = &(const struct clk_parent_data) {
>>   				.index = DT_PCIE30_PHY1_PIPE_CLK,
>> @@ -1555,7 +1539,7 @@ static struct clk_regmap_phy_mux pcie1_pipe_clk_src = {
>>   static struct clk_regmap_phy_mux pcie2_pipe_clk_src = {
>>   	.reg = 0x2a064,
>>   	.clkr = {
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "pcie2_pipe_clk_src",
>>   			.parent_data = &(const struct clk_parent_data) {
>>   				.index = DT_PCIE30_PHY2_PIPE_CLK,
>> @@ -1569,7 +1553,7 @@ static struct clk_regmap_phy_mux pcie2_pipe_clk_src = {
>>   static struct clk_regmap_phy_mux pcie3_pipe_clk_src = {
>>   	.reg = 0x2b064,
>>   	.clkr = {
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "pcie3_pipe_clk_src",
>>   			.parent_data = &(const struct clk_parent_data) {
>>   				.index = DT_PCIE30_PHY3_PIPE_CLK,
>> @@ -1591,7 +1575,7 @@ static struct clk_rcg2 pcie0_rchng_clk_src = {
>>   	.freq_tbl = ftbl_pcie_rchng_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "pcie0_rchng_clk_src",
>>   		.parent_data = gcc_xo_gpll0,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>> @@ -1604,7 +1588,7 @@ static struct clk_branch gcc_pcie0_rchng_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x28028,
>>   		.enable_mask = BIT(1),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie0_rchng_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie0_rchng_clk_src.clkr.hw
>> @@ -1622,7 +1606,7 @@ static struct clk_rcg2 pcie1_rchng_clk_src = {
>>   	.freq_tbl = ftbl_pcie_rchng_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "pcie1_rchng_clk_src",
>>   		.parent_data = gcc_xo_gpll0,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>> @@ -1635,7 +1619,7 @@ static struct clk_branch gcc_pcie1_rchng_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x29028,
>>   		.enable_mask = BIT(1),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie1_rchng_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie1_rchng_clk_src.clkr.hw
>> @@ -1652,7 +1636,7 @@ static struct clk_rcg2 pcie2_rchng_clk_src = {
>>   	.freq_tbl = ftbl_pcie_rchng_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "pcie2_rchng_clk_src",
>>   		.parent_data = gcc_xo_gpll0,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>> @@ -1665,7 +1649,7 @@ static struct clk_branch gcc_pcie2_rchng_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2a028,
>>   		.enable_mask = BIT(1),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie2_rchng_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie2_rchng_clk_src.clkr.hw
>> @@ -1682,7 +1666,7 @@ static struct clk_rcg2 pcie3_rchng_clk_src = {
>>   	.freq_tbl = ftbl_pcie_rchng_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "pcie3_rchng_clk_src",
>>   		.parent_data = gcc_xo_gpll0,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>> @@ -1695,7 +1679,7 @@ static struct clk_branch gcc_pcie3_rchng_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2b028,
>>   		.enable_mask = BIT(1),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie3_rchng_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie3_rchng_clk_src.clkr.hw
>> @@ -1718,7 +1702,7 @@ static struct clk_rcg2 pcie_aux_clk_src = {
>>   	.mnd_width = 16,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_aux_core_pi_sleep_clk_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "pcie_aux_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_aux_core_pi_sleep_clk,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_aux_core_pi_sleep_clk),
>> @@ -1731,7 +1715,7 @@ static struct clk_branch gcc_pcie0_aux_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x28034,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie0_aux_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie_aux_clk_src.clkr.hw
>> @@ -1748,7 +1732,7 @@ static struct clk_branch gcc_pcie1_aux_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x29034,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie1_aux_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie_aux_clk_src.clkr.hw
>> @@ -1765,7 +1749,7 @@ static struct clk_branch gcc_pcie2_aux_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2a034,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie2_aux_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie_aux_clk_src.clkr.hw
>> @@ -1782,7 +1766,7 @@ static struct clk_branch gcc_pcie3_aux_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2b034,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie3_aux_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcie_aux_clk_src.clkr.hw
>> @@ -1805,7 +1789,7 @@ static struct clk_rcg2 usb0_aux_clk_src = {
>>   	.mnd_width = 16,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_core_pi_sleep_clk_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "usb0_aux_clk_src",
>>   		.parent_data = gcc_xo_gpll0_core_pi_sleep_clk,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_core_pi_sleep_clk),
>> @@ -1818,7 +1802,7 @@ static struct clk_branch gcc_usb0_aux_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2c048,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_usb0_aux_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&usb0_aux_clk_src.clkr.hw
>> @@ -1842,7 +1826,7 @@ static struct clk_rcg2 usb0_master_clk_src = {
>>   	.mnd_width = 8,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_out_main_div2_gpll0_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "usb0_master_clk_src",
>>   		.parent_data = gcc_xo_gpll0_out_main_div2_gpll0,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_out_main_div2_gpll0),
>> @@ -1855,7 +1839,7 @@ static struct clk_branch gcc_usb0_master_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2c044,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_usb0_master_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&usb0_master_clk_src.clkr.hw
>> @@ -1872,7 +1856,7 @@ static struct clk_branch gcc_snoc_usb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2e058,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_snoc_usb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&usb0_master_clk_src.clkr.hw
>> @@ -1889,7 +1873,7 @@ static struct clk_branch gcc_anoc_usb_axi_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2e084,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_anoc_usb_axi_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&usb0_master_clk_src.clkr.hw
>> @@ -1913,7 +1897,7 @@ static struct clk_rcg2 usb0_mock_utmi_clk_src = {
>>   	.mnd_width = 8,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll4_gpll0_gpll0_out_main_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "usb0_mock_utmi_clk_src",
>>   		.parent_data = gcc_xo_gpll4_gpll0_gpll0_out_main_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll4_gpll0_gpll0_out_main_div2),
>> @@ -1925,7 +1909,7 @@ static struct clk_regmap_div usb0_mock_utmi_div_clk_src = {
>>   	.reg = 0x2c040,
>>   	.shift = 0,
>>   	.width = 2,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "usb0_mock_utmi_div_clk_src",
>>   		.parent_data = &(const struct clk_parent_data) {
>>   			.hw = &usb0_mock_utmi_clk_src.clkr.hw,
>> @@ -1941,7 +1925,7 @@ static struct clk_branch gcc_usb0_mock_utmi_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2c04c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_usb0_mock_utmi_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&usb0_mock_utmi_div_clk_src.clkr.hw
>> @@ -1959,7 +1943,7 @@ static struct clk_regmap_mux usb0_pipe_clk_src = {
>>   	.width = 2,
>>   	.parent_map = gcc_usb3phy_0_cc_pipe_clk_xo_map,
>>   	.clkr = {
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "usb0_pipe_clk_src",
>>   			.parent_data = gcc_usb3phy_0_cc_pipe_clk_xo,
>>   			.num_parents = ARRAY_SIZE(gcc_usb3phy_0_cc_pipe_clk_xo),
>> @@ -1988,7 +1972,7 @@ static struct clk_rcg2 sdcc1_apps_clk_src = {
>>   	.mnd_width = 8,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll2_gpll0_out_main_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "sdcc1_apps_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll2_gpll0_out_main_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll2_gpll0_out_main_div2),
>> @@ -2001,7 +1985,7 @@ static struct clk_branch gcc_sdcc1_apps_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x3302c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_sdcc1_apps_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&sdcc1_apps_clk_src.clkr.hw
>> @@ -2024,7 +2008,7 @@ static struct clk_rcg2 sdcc1_ice_core_clk_src = {
>>   	.mnd_width = 8,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll4_gpll0_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "sdcc1_ice_core_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll4_gpll0_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4_gpll0_div2),
>> @@ -2037,7 +2021,7 @@ static struct clk_branch gcc_sdcc1_ice_core_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x33030,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_sdcc1_ice_core_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&sdcc1_ice_core_clk_src.clkr.hw
>> @@ -2062,7 +2046,7 @@ static struct clk_rcg2 pcnoc_bfdcd_clk_src = {
>>   	.freq_tbl = ftbl_pcnoc_bfdcd_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "pcnoc_bfdcd_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
>> @@ -2076,7 +2060,7 @@ static struct clk_branch gcc_nsscfg_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x1702c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_nsscfg_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcnoc_bfdcd_clk_src.clkr.hw
>> @@ -2093,7 +2077,7 @@ static struct clk_branch gcc_nssnoc_nsscc_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x17030,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_nssnoc_nsscc_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcnoc_bfdcd_clk_src.clkr.hw
>> @@ -2110,7 +2094,7 @@ static struct clk_branch gcc_nsscc_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x17034,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_nsscc_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcnoc_bfdcd_clk_src.clkr.hw
>> @@ -2127,7 +2111,7 @@ static struct clk_branch gcc_nssnoc_pcnoc_1_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x17080,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_nssnoc_pcnoc_1_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcnoc_bfdcd_clk_src.clkr.hw
>> @@ -2144,7 +2128,7 @@ static struct clk_branch gcc_qdss_dap_ahb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2d064,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_qdss_dap_ahb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcnoc_bfdcd_clk_src.clkr.hw
>> @@ -2161,7 +2145,7 @@ static struct clk_branch gcc_qdss_cfg_ahb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2d068,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_qdss_cfg_ahb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcnoc_bfdcd_clk_src.clkr.hw
>> @@ -2178,7 +2162,7 @@ static struct clk_branch gcc_qpic_ahb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x32010,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_qpic_ahb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcnoc_bfdcd_clk_src.clkr.hw
>> @@ -2195,7 +2179,7 @@ static struct clk_branch gcc_qpic_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x32014,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_qpic_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcnoc_bfdcd_clk_src.clkr.hw
>> @@ -2213,7 +2197,7 @@ static struct clk_branch gcc_blsp1_ahb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x0b004,
>>   		.enable_mask = BIT(4),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_blsp1_ahb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcnoc_bfdcd_clk_src.clkr.hw
>> @@ -2230,7 +2214,7 @@ static struct clk_branch gcc_mdio_ahb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x17040,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_mdio_ahb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcnoc_bfdcd_clk_src.clkr.hw
>> @@ -2248,7 +2232,7 @@ static struct clk_branch gcc_prng_ahb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x0b004,
>>   		.enable_mask = BIT(10),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_prng_ahb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcnoc_bfdcd_clk_src.clkr.hw
>> @@ -2265,7 +2249,7 @@ static struct clk_branch gcc_uniphy0_ahb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x1704c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_uniphy0_ahb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcnoc_bfdcd_clk_src.clkr.hw
>> @@ -2282,7 +2266,7 @@ static struct clk_branch gcc_uniphy1_ahb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x1705c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_uniphy1_ahb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcnoc_bfdcd_clk_src.clkr.hw
>> @@ -2299,7 +2283,7 @@ static struct clk_branch gcc_uniphy2_ahb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x1706c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_uniphy2_ahb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcnoc_bfdcd_clk_src.clkr.hw
>> @@ -2316,7 +2300,7 @@ static struct clk_branch gcc_cmn_12gpll_ahb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x3a004,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_cmn_12gpll_ahb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcnoc_bfdcd_clk_src.clkr.hw
>> @@ -2333,7 +2317,7 @@ static struct clk_branch gcc_cmn_12gpll_apu_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x3a00c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_cmn_12gpll_apu_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcnoc_bfdcd_clk_src.clkr.hw
>> @@ -2350,7 +2334,7 @@ static struct clk_branch gcc_pcie0_ahb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x28030,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie0_ahb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcnoc_bfdcd_clk_src.clkr.hw
>> @@ -2367,7 +2351,7 @@ static struct clk_branch gcc_pcie1_ahb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x29030,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie1_ahb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcnoc_bfdcd_clk_src.clkr.hw
>> @@ -2384,7 +2368,7 @@ static struct clk_branch gcc_pcie2_ahb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2a030,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie2_ahb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcnoc_bfdcd_clk_src.clkr.hw
>> @@ -2401,7 +2385,7 @@ static struct clk_branch gcc_pcie3_ahb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2b030,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie3_ahb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcnoc_bfdcd_clk_src.clkr.hw
>> @@ -2418,7 +2402,7 @@ static struct clk_branch gcc_usb0_phy_cfg_ahb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2c05c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_usb0_phy_cfg_ahb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcnoc_bfdcd_clk_src.clkr.hw
>> @@ -2435,7 +2419,7 @@ static struct clk_branch gcc_sdcc1_ahb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x33034,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_sdcc1_ahb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&pcnoc_bfdcd_clk_src.clkr.hw
>> @@ -2460,7 +2444,7 @@ static struct clk_rcg2 system_noc_bfdcd_clk_src = {
>>   	.freq_tbl = ftbl_system_noc_bfdcd_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll4_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "system_noc_bfdcd_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll4,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4),
>> @@ -2475,7 +2459,7 @@ static struct clk_branch gcc_q6ss_boot_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x25080,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_q6ss_boot_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&system_noc_bfdcd_clk_src.clkr.hw
>> @@ -2492,7 +2476,7 @@ static struct clk_branch gcc_nssnoc_snoc_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x17028,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_nssnoc_snoc_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&system_noc_bfdcd_clk_src.clkr.hw
>> @@ -2509,7 +2493,7 @@ static struct clk_branch gcc_nssnoc_snoc_1_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x1707c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_nssnoc_snoc_1_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&system_noc_bfdcd_clk_src.clkr.hw
>> @@ -2526,7 +2510,7 @@ static struct clk_branch gcc_qdss_etr_usb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2d060,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_qdss_etr_usb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&system_noc_bfdcd_clk_src.clkr.hw
>> @@ -2549,7 +2533,7 @@ static struct clk_rcg2 wcss_ahb_clk_src = {
>>   	.freq_tbl = ftbl_wcss_ahb_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "wcss_ahb_clk_src",
>>   		.parent_data = gcc_xo_gpll0,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>> @@ -2562,7 +2546,7 @@ static struct clk_branch gcc_q6_ahb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x25014,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_q6_ahb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&wcss_ahb_clk_src.clkr.hw
>> @@ -2579,7 +2563,7 @@ static struct clk_branch gcc_q6_ahb_s_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x25018,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_q6_ahb_s_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&wcss_ahb_clk_src.clkr.hw
>> @@ -2596,7 +2580,7 @@ static struct clk_branch gcc_wcss_ecahb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x25058,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_wcss_ecahb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&wcss_ahb_clk_src.clkr.hw
>> @@ -2613,7 +2597,7 @@ static struct clk_branch gcc_wcss_acmt_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2505c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_wcss_acmt_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&wcss_ahb_clk_src.clkr.hw
>> @@ -2630,7 +2614,7 @@ static struct clk_branch gcc_sys_noc_wcss_ahb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2e030,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_sys_noc_wcss_ahb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&wcss_ahb_clk_src.clkr.hw
>> @@ -2654,7 +2638,7 @@ static struct clk_rcg2 wcss_axi_m_clk_src = {
>>   	.freq_tbl = ftbl_wcss_axi_m_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "wcss_axi_m_clk_src",
>>   		.parent_data = gcc_xo_gpll0,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>> @@ -2667,7 +2651,7 @@ static struct clk_branch gcc_anoc_wcss_axi_m_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2e0a8,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_anoc_wcss_axi_m_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&wcss_axi_m_clk_src.clkr.hw
>> @@ -2689,7 +2673,7 @@ static struct clk_rcg2 qdss_at_clk_src = {
>>   	.freq_tbl = ftbl_qdss_at_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll4_gpll0_gpll0_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "qdss_at_clk_src",
>>   		.parent_data = gcc_xo_gpll4_gpll0_gpll0_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll4_gpll0_gpll0_div2),
>> @@ -2702,7 +2686,7 @@ static struct clk_branch gcc_q6ss_atbm_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2501c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_q6ss_atbm_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&qdss_at_clk_src.clkr.hw
>> @@ -2719,7 +2703,7 @@ static struct clk_branch gcc_wcss_dbg_ifc_atb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2503c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_wcss_dbg_ifc_atb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&qdss_at_clk_src.clkr.hw
>> @@ -2736,7 +2720,7 @@ static struct clk_branch gcc_nssnoc_atb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x17014,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_nssnoc_atb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&qdss_at_clk_src.clkr.hw
>> @@ -2753,7 +2737,7 @@ static struct clk_branch gcc_qdss_at_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2d038,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_qdss_at_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&qdss_at_clk_src.clkr.hw
>> @@ -2770,7 +2754,7 @@ static struct clk_branch gcc_sys_noc_at_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2e038,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_sys_noc_at_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&qdss_at_clk_src.clkr.hw
>> @@ -2787,7 +2771,7 @@ static struct clk_branch gcc_pcnoc_at_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x31024,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcnoc_at_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&qdss_at_clk_src.clkr.hw
>> @@ -2802,7 +2786,7 @@ static struct clk_branch gcc_pcnoc_at_clk = {
>>   static struct clk_fixed_factor gcc_eud_at_div_clk_src = {
>>   	.mult = 1,
>>   	.div = 6,
>> -	.hw.init = &(struct clk_init_data) {
>> +	.hw.init = &(const struct clk_init_data) {
>>   		.name = "gcc_eud_at_div_clk_src",
>>   		.parent_hws = (const struct clk_hw *[]) {
>>   			&qdss_at_clk_src.clkr.hw
>> @@ -2818,7 +2802,7 @@ static struct clk_branch gcc_usb0_eud_at_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x30004,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_usb0_eud_at_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&gcc_eud_at_div_clk_src.hw
>> @@ -2835,7 +2819,7 @@ static struct clk_branch gcc_qdss_eud_at_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2d06c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_qdss_eud_at_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&gcc_eud_at_div_clk_src.hw
>> @@ -2858,7 +2842,7 @@ static struct clk_rcg2 qdss_stm_clk_src = {
>>   	.freq_tbl = ftbl_qdss_stm_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "qdss_stm_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
>> @@ -2871,7 +2855,7 @@ static struct clk_branch gcc_qdss_stm_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2d03c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_qdss_stm_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&qdss_stm_clk_src.clkr.hw
>> @@ -2888,7 +2872,7 @@ static struct clk_branch gcc_sys_noc_qdss_stm_axi_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2e034,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_sys_noc_qdss_stm_axi_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&qdss_stm_clk_src.clkr.hw
>> @@ -2910,7 +2894,7 @@ static struct clk_rcg2 qdss_traceclkin_clk_src = {
>>   	.freq_tbl = ftbl_qdss_traceclkin_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll4_gpll0_gpll0_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "qdss_traceclkin_clk_src",
>>   		.parent_data = gcc_xo_gpll4_gpll0_gpll0_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll4_gpll0_gpll0_div2),
>> @@ -2923,7 +2907,7 @@ static struct clk_branch gcc_qdss_traceclkin_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2d040,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_qdss_traceclkin_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&qdss_traceclkin_clk_src.clkr.hw
>> @@ -2945,7 +2929,7 @@ static struct clk_rcg2 qdss_tsctr_clk_src = {
>>   	.freq_tbl = ftbl_qdss_tsctr_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll4_gpll0_gpll0_div2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "qdss_tsctr_clk_src",
>>   		.parent_data = gcc_xo_gpll4_gpll0_gpll0_div2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll4_gpll0_gpll0_div2),
>> @@ -2956,7 +2940,7 @@ static struct clk_rcg2 qdss_tsctr_clk_src = {
>>   static struct clk_fixed_factor qdss_tsctr_div2_clk_src = {
>>   	.mult = 1,
>>   	.div = 2,
>> -	.hw.init = &(struct clk_init_data) {
>> +	.hw.init = &(const struct clk_init_data) {
>>   		.name = "qdss_tsctr_div2_clk_src",
>>   		.parent_hws = (const struct clk_hw *[]) {
>>   			&qdss_tsctr_clk_src.clkr.hw
>> @@ -2972,7 +2956,7 @@ static struct clk_branch gcc_q6_tsctr_1to2_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x25020,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_q6_tsctr_1to2_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&qdss_tsctr_div2_clk_src.hw
>> @@ -2989,7 +2973,7 @@ static struct clk_branch gcc_wcss_dbg_ifc_nts_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x25040,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_wcss_dbg_ifc_nts_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&qdss_tsctr_div2_clk_src.hw
>> @@ -3006,7 +2990,7 @@ static struct clk_branch gcc_qdss_tsctr_div2_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2d044,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_qdss_tsctr_div2_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&qdss_tsctr_div2_clk_src.hw
>> @@ -3029,7 +3013,7 @@ static struct clk_rcg2 uniphy_sys_clk_src = {
>>   	.mnd_width = 8,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "uniphy_sys_clk_src",
>>   		.parent_data = gcc_xo_data,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_data),
>> @@ -3043,7 +3027,7 @@ static struct clk_rcg2 nss_ts_clk_src = {
>>   	.mnd_width = 8,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "nss_ts_clk_src",
>>   		.parent_data = gcc_xo_data,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_data),
>> @@ -3056,7 +3040,7 @@ static struct clk_branch gcc_qdss_ts_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2d078,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_qdss_ts_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&nss_ts_clk_src.clkr.hw
>> @@ -3071,7 +3055,7 @@ static struct clk_branch gcc_qdss_ts_clk = {
>>   static struct clk_fixed_factor qdss_dap_sync_clk_src = {
>>   	.mult = 1,
>>   	.div = 4,
>> -	.hw.init = &(struct clk_init_data) {
>> +	.hw.init = &(const struct clk_init_data) {
>>   		.name = "qdss_dap_sync_clk_src",
>>   		.parent_hws = (const struct clk_hw *[]) {
>>   			&qdss_tsctr_clk_src.clkr.hw
>> @@ -3086,7 +3070,7 @@ static struct clk_branch gcc_qdss_tsctr_div4_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2d04c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_qdss_tsctr_div4_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&qdss_dap_sync_clk_src.hw
>> @@ -3101,7 +3085,7 @@ static struct clk_branch gcc_qdss_tsctr_div4_clk = {
>>   static struct clk_fixed_factor qdss_tsctr_div8_clk_src = {
>>   	.mult = 1,
>>   	.div = 8,
>> -	.hw.init = &(struct clk_init_data) {
>> +	.hw.init = &(const struct clk_init_data) {
>>   		.name = "qdss_tsctr_div8_clk_src",
>>   		.parent_hws = (const struct clk_hw *[]) {
>>   			&qdss_tsctr_clk_src.clkr.hw
>> @@ -3116,7 +3100,7 @@ static struct clk_branch gcc_nss_ts_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x17018,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_nss_ts_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&nss_ts_clk_src.clkr.hw
>> @@ -3133,7 +3117,7 @@ static struct clk_branch gcc_qdss_tsctr_div8_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2d050,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_qdss_tsctr_div8_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&qdss_tsctr_div8_clk_src.hw
>> @@ -3148,7 +3132,7 @@ static struct clk_branch gcc_qdss_tsctr_div8_clk = {
>>   static struct clk_fixed_factor qdss_tsctr_div16_clk_src = {
>>   	.mult = 1,
>>   	.div = 16,
>> -	.hw.init = &(struct clk_init_data) {
>> +	.hw.init = &(const struct clk_init_data) {
>>   		.name = "qdss_tsctr_div16_clk_src",
>>   		.parent_hws = (const struct clk_hw *[]) {
>>   			&qdss_tsctr_clk_src.clkr.hw
>> @@ -3163,7 +3147,7 @@ static struct clk_branch gcc_qdss_tsctr_div16_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2d054,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_qdss_tsctr_div16_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&qdss_tsctr_div16_clk_src.hw
>> @@ -3180,7 +3164,7 @@ static struct clk_branch gcc_q6ss_pclkdbg_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x25024,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_q6ss_pclkdbg_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&qdss_dap_sync_clk_src.hw
>> @@ -3197,7 +3181,7 @@ static struct clk_branch gcc_q6ss_trig_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x25068,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_q6ss_trig_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&qdss_dap_sync_clk_src.hw
>> @@ -3214,7 +3198,7 @@ static struct clk_branch gcc_wcss_dbg_ifc_apb_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x25038,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_wcss_dbg_ifc_apb_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&qdss_dap_sync_clk_src.hw
>> @@ -3231,7 +3215,7 @@ static struct clk_branch gcc_wcss_dbg_ifc_dapbus_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x25044,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_wcss_dbg_ifc_dapbus_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&qdss_dap_sync_clk_src.hw
>> @@ -3248,7 +3232,7 @@ static struct clk_branch gcc_qdss_dap_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2d058,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_qdss_dap_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&qdss_dap_sync_clk_src.hw
>> @@ -3265,7 +3249,7 @@ static struct clk_branch gcc_qdss_apb2jtag_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2d05c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_qdss_apb2jtag_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&qdss_dap_sync_clk_src.hw
>> @@ -3280,7 +3264,7 @@ static struct clk_branch gcc_qdss_apb2jtag_clk = {
>>   static struct clk_fixed_factor qdss_tsctr_div3_clk_src = {
>>   	.mult = 1,
>>   	.div = 3,
>> -	.hw.init = &(struct clk_init_data) {
>> +	.hw.init = &(const struct clk_init_data) {
>>   		.name = "qdss_tsctr_div3_clk_src",
>>   		.parent_hws = (const struct clk_hw *[]) {
>>   			&qdss_tsctr_clk_src.clkr.hw
>> @@ -3295,7 +3279,7 @@ static struct clk_branch gcc_qdss_tsctr_div3_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2d048,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_qdss_tsctr_div3_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&qdss_tsctr_div3_clk_src.hw
>> @@ -3321,7 +3305,7 @@ static struct clk_rcg2 qpic_io_macro_clk_src = {
>>   	.freq_tbl = ftbl_qpic_io_macro_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "qpic_io_macro_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll2),
>> @@ -3334,7 +3318,7 @@ static struct clk_branch gcc_qpic_io_macro_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x3200c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data){
>> +		.hw.init = &(const struct clk_init_data){
>>   			.name = "gcc_qpic_io_macro_clk",
>>   			.parent_hws = (const struct clk_hw *[]){
>>   				&qpic_io_macro_clk_src.clkr.hw
>> @@ -3356,7 +3340,7 @@ static struct clk_rcg2 q6_axi_clk_src = {
>>   	.freq_tbl = ftbl_q6_axi_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll2_gpll4_pi_sleep_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "q6_axi_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll2_gpll4_pi_sleep,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll2_gpll4_pi_sleep),
>> @@ -3369,7 +3353,7 @@ static struct clk_branch gcc_q6_axim_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x2500c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_q6_axim_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&q6_axi_clk_src.clkr.hw
>> @@ -3387,7 +3371,7 @@ static struct clk_branch gcc_wcss_q6_tbu_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0xb00c,
>>   		.enable_mask = BIT(6),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_wcss_q6_tbu_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&q6_axi_clk_src.clkr.hw
>> @@ -3404,7 +3388,7 @@ static struct clk_branch gcc_mem_noc_q6_axi_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x19010,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_mem_noc_q6_axi_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&q6_axi_clk_src.clkr.hw
>> @@ -3421,22 +3405,15 @@ static const struct freq_tbl ftbl_q6_axim2_clk_src[] = {
>>   	{ }
>>   };
>>   
>> -static const struct parent_map gcc_xo_gpll0_gpll4_bias_pll_ubinc_clk_map[] = {
>> -	{ P_XO, 0 },
>> -	{ P_GPLL0, 1 },
>> -	{ P_GPLL4, 2 },
>> -	{ P_BIAS_PLL_UBI_NC_CLK, 4 },
>> -};
>> -
>>   static struct clk_rcg2 q6_axim2_clk_src = {
>>   	.cmd_rcgr = 0x25028,
>>   	.freq_tbl = ftbl_q6_axim2_clk_src,
>>   	.hid_width = 5,
>> -	.parent_map = gcc_xo_gpll0_gpll4_bias_pll_ubinc_clk_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.parent_map = gcc_xo_gpll0_gpll4_map,
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "q6_axim2_clk_src",
>> -		.parent_data = gcc_xo_gpll0_gpll4_bias_pll_ubi_nc_clk,
>> -		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4_bias_pll_ubi_nc_clk),
>> +		.parent_data = gcc_xo_gpll0_gpll4,
>> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4),
>>   		.ops = &clk_rcg2_ops,
>>   	},
>>   };
>> @@ -3451,7 +3428,7 @@ static struct clk_rcg2 nssnoc_memnoc_bfdcd_clk_src = {
>>   	.freq_tbl = ftbl_nssnoc_memnoc_bfdcd_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_aux_gpll2_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "nssnoc_memnoc_bfdcd_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_aux_gpll2,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_aux_gpll2),
>> @@ -3464,7 +3441,7 @@ static struct clk_branch gcc_nssnoc_memnoc_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x17024,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_nssnoc_memnoc_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&nssnoc_memnoc_bfdcd_clk_src.clkr.hw
>> @@ -3481,7 +3458,7 @@ static struct clk_branch gcc_nssnoc_mem_noc_1_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x17084,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_nssnoc_mem_noc_1_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&nssnoc_memnoc_bfdcd_clk_src.clkr.hw
>> @@ -3498,7 +3475,7 @@ static struct clk_branch gcc_nss_tbu_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0xb00c,
>>   		.enable_mask = BIT(4),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_nss_tbu_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&nssnoc_memnoc_bfdcd_clk_src.clkr.hw
>> @@ -3515,7 +3492,7 @@ static struct clk_branch gcc_mem_noc_nssnoc_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x19014,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_mem_noc_nssnoc_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&nssnoc_memnoc_bfdcd_clk_src.clkr.hw
>> @@ -3537,7 +3514,7 @@ static struct clk_rcg2 lpass_axim_clk_src = {
>>   	.freq_tbl = ftbl_lpass_axim_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "lpass_axim_clk_src",
>>   		.parent_data = gcc_xo_gpll0,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>> @@ -3550,7 +3527,7 @@ static struct clk_rcg2 lpass_sway_clk_src = {
>>   	.freq_tbl = ftbl_lpass_axim_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "lpass_sway_clk_src",
>>   		.parent_data = gcc_xo_gpll0,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>> @@ -3569,7 +3546,7 @@ static struct clk_rcg2 adss_pwm_clk_src = {
>>   	.freq_tbl = ftbl_adss_pwm_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "adss_pwm_clk_src",
>>   		.parent_data = gcc_xo_gpll0,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>> @@ -3582,7 +3559,7 @@ static struct clk_branch gcc_adss_pwm_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x1c00c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_adss_pwm_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&adss_pwm_clk_src.clkr.hw
>> @@ -3605,7 +3582,7 @@ static struct clk_rcg2 gp1_clk_src = {
>>   	.freq_tbl = ftbl_gp1_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_sleep_clk_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "gp1_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_sleep_clk,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_sleep_clk),
>> @@ -3618,7 +3595,7 @@ static struct clk_rcg2 gp2_clk_src = {
>>   	.freq_tbl = ftbl_gp1_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_sleep_clk_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "gp2_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_sleep_clk,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_sleep_clk),
>> @@ -3631,7 +3608,7 @@ static struct clk_rcg2 gp3_clk_src = {
>>   	.freq_tbl = ftbl_gp1_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = gcc_xo_gpll0_gpll0_sleep_clk_map,
>> -	.clkr.hw.init = &(struct clk_init_data) {
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>>   		.name = "gp3_clk_src",
>>   		.parent_data = gcc_xo_gpll0_gpll0_sleep_clk,
>>   		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_sleep_clk),
>> @@ -3644,7 +3621,7 @@ static struct clk_branch gcc_xo_clk_src = {
>>   	.clkr = {
>>   		.enable_reg = 0x34004,
>>   		.enable_mask = BIT(1),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_xo_clk_src",
>>   			.parent_data = gcc_xo_data,
>>   			.num_parents = ARRAY_SIZE(gcc_xo_data),
>> @@ -3659,7 +3636,7 @@ static struct clk_branch gcc_nssnoc_xo_dcd_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x17074,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_nssnoc_xo_dcd_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&gcc_xo_clk_src.clkr.hw
>> @@ -3676,7 +3653,7 @@ static struct clk_branch gcc_xo_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x34018,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_xo_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&gcc_xo_clk_src.clkr.hw
>> @@ -3693,7 +3670,7 @@ static struct clk_branch gcc_uniphy0_sys_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x17048,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_uniphy0_sys_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&uniphy_sys_clk_src.clkr.hw
>> @@ -3710,7 +3687,7 @@ static struct clk_branch gcc_uniphy1_sys_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x17058,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_uniphy1_sys_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&uniphy_sys_clk_src.clkr.hw
>> @@ -3727,7 +3704,7 @@ static struct clk_branch gcc_uniphy2_sys_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x17068,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_uniphy2_sys_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&uniphy_sys_clk_src.clkr.hw
>> @@ -3744,7 +3721,7 @@ static struct clk_branch gcc_cmn_12gpll_sys_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x3a008,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_cmn_12gpll_sys_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&uniphy_sys_clk_src.clkr.hw
>> @@ -3759,7 +3736,7 @@ static struct clk_branch gcc_cmn_12gpll_sys_clk = {
>>   static struct clk_fixed_factor gcc_xo_div4_clk_src = {
>>   	.mult = 1,
>>   	.div = 4,
>> -	.hw.init = &(struct clk_init_data) {
>> +	.hw.init = &(const struct clk_init_data) {
>>   		.name = "gcc_xo_div4_clk_src",
>>   		.parent_hws = (const struct clk_hw *[]) {
>>   			&gcc_xo_clk_src.clkr.hw
>> @@ -3775,7 +3752,7 @@ static struct clk_branch gcc_nssnoc_qosgen_ref_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x1701c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_nssnoc_qosgen_ref_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&gcc_xo_div4_clk_src.hw
>> @@ -3792,7 +3769,7 @@ static struct clk_branch gcc_nssnoc_timeout_ref_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x17020,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_nssnoc_timeout_ref_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&gcc_xo_div4_clk_src.hw
>> @@ -3809,7 +3786,7 @@ static struct clk_branch gcc_xo_div4_clk = {
>>   	.clkr = {
>>   		.enable_reg = 0x3401c,
>>   		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data) {
>> +		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_xo_div4_clk",
>>   			.parent_hws = (const struct clk_hw *[]) {
>>   				&gcc_xo_div4_clk_src.hw
