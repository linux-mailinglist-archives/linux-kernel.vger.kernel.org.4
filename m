Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AC8664330
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbjAJOXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238373AbjAJOX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:23:26 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2D881D6E;
        Tue, 10 Jan 2023 06:23:25 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ABg6Lx029247;
        Tue, 10 Jan 2023 14:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8wZrOfG4wZ4NmHzZU5ZeitpgG0nH+0uCnaWIJ4V3we0=;
 b=JgPyJ3orQuDjvyViYGqmYWYi/xahgKIxrwhFYvzETM0ztcNwxdmNjTdDEp23BMFQRHdq
 gqPgc35JArvcxjaC2lH08TjfzzEZ1IAq1NQv3xa3XCr6gkjLvkTgcxJ7JYiAPQ3hejAB
 V8P/J1FgYUXJEDS2Q17YTKyH0Sb4eksorV0sA0MiID6+nzyGf+9zs6x5iaciaGzgvyBr
 RU2F0pwYoan+IJWqX0EFxXKfYeXkso7mimLqi1zyhiiq7FZJT17rkllubqjVFEwE4V3V
 /QMO2dZKaJIqg0AkGUzAX7laUWyGZxCURg1WaFak0wGo4MXjnSFoz3Yhf+HQ9aQPBCfj VA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n113p140w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 14:23:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30AENKCG004658
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 14:23:20 GMT
Received: from [10.50.29.234] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 10 Jan
 2023 06:23:10 -0800
Message-ID: <168bd49c-9abe-d90c-a4a4-4a76e2ba7f10@quicinc.com>
Date:   Tue, 10 Jan 2023 19:53:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V4] clk: qcom: clk-alpha-pll: Add support for Stromer PLLs
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        Sricharan R <quic_srichara@quicinc.com>
References: <20221227132507.2506-1-quic_kathirav@quicinc.com>
Content-Language: en-US
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <20221227132507.2506-1-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ASoXYtkKZflGRlQ3Y33GWf4oVJHuyros
X-Proofpoint-ORIG-GUID: ASoXYtkKZflGRlQ3Y33GWf4oVJHuyros
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_04,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100090
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/27/2022 6:55 PM, Kathiravan T wrote:
> From: Varadarajan Narayanan <quic_varada@quicinc.com>
>
> Add programming sequence support for managing the Stromer
> PLLs.
>
> Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>

Gentle ping!...

> ---
> Changes since V3:
> 	- Updated the title with correct patch version
>
> Changes since V2:
> 	- splitted this patch from IPQ5018 series[1]
> 	- Rebased on linux-6.2-rc1
> [1]
> https://lore.kernel.org/linux-arm-msm/20220621161126.15883-1-quic_srichara@quicinc.com/
>
>   drivers/clk/qcom/clk-alpha-pll.c | 100 ++++++++++++++++++++++++++++++-
>   drivers/clk/qcom/clk-alpha-pll.h |   7 ++-
>   2 files changed, 105 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> index f9e4cfd7261c..29866100df08 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -204,9 +204,24 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
>   		[PLL_OFF_CONFIG_CTL] = 0x1C,
>   		[PLL_OFF_STATUS] = 0x20,
>   	},
> +	[CLK_ALPHA_PLL_TYPE_STROMER] = {
> +		[PLL_OFF_L_VAL] = 0x08,
> +		[PLL_OFF_ALPHA_VAL] = 0x10,
> +		[PLL_OFF_ALPHA_VAL_U] = 0x14,
> +		[PLL_OFF_USER_CTL] = 0x18,
> +		[PLL_OFF_USER_CTL_U] = 0x1c,
> +		[PLL_OFF_CONFIG_CTL] = 0x20,
> +		[PLL_OFF_CONFIG_CTL_U] = 0xff,
> +		[PLL_OFF_TEST_CTL] = 0x30,
> +		[PLL_OFF_TEST_CTL_U] = 0x34,
> +		[PLL_OFF_STATUS] = 0x28,
> +	},
>   };
>   EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
>   
> +static unsigned long
> +alpha_pll_round_rate(unsigned long rate, unsigned long prate, u32 *l, u64 *a,
> +		     u32 alpha_width);
>   /*
>    * Even though 40 bits are present, use only 32 for ease of calculation.
>    */
> @@ -215,6 +230,8 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
>   #define ALPHA_BITWIDTH		32U
>   #define ALPHA_SHIFT(w)		min(w, ALPHA_BITWIDTH)
>   
> +#define	ALPHA_PLL_STATUS_REG_SHIFT	8
> +
>   #define PLL_HUAYRA_M_WIDTH		8
>   #define PLL_HUAYRA_M_SHIFT		8
>   #define PLL_HUAYRA_M_MASK		0xff
> @@ -325,7 +342,7 @@ static void clk_alpha_pll_write_config(struct regmap *regmap, unsigned int reg,
>   void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>   			     const struct alpha_pll_config *config)
>   {
> -	u32 val, mask;
> +	u32 val, val_u, mask, mask_u;
>   
>   	regmap_write(regmap, PLL_L_VAL(pll), config->l);
>   	regmap_write(regmap, PLL_ALPHA_VAL(pll), config->alpha);
> @@ -355,14 +372,85 @@ void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>   	mask |= config->pre_div_mask;
>   	mask |= config->post_div_mask;
>   	mask |= config->vco_mask;
> +	mask |= config->alpha_en_mask;
> +	mask |= config->alpha_mode_mask;
>   
>   	regmap_update_bits(regmap, PLL_USER_CTL(pll), mask, val);
>   
> +	/* Stromer APSS PLL does not enable LOCK_DET by default, so enable it */
> +	val_u = config->status_reg_val << ALPHA_PLL_STATUS_REG_SHIFT;
> +	val_u |= config->lock_det;
> +
> +	mask_u = config->status_reg_mask;
> +	mask_u |= config->lock_det;
> +
> +	if (val_u)
> +		regmap_update_bits(regmap, PLL_USER_CTL_U(pll), mask_u, val_u);
> +
> +	if (config->test_ctl_val)
> +		regmap_write(regmap, PLL_TEST_CTL(pll), config->test_ctl_val);
> +
> +	if (config->test_ctl_hi_val)
> +		regmap_write(regmap, PLL_TEST_CTL_U(pll), config->test_ctl_hi_val);
> +
>   	if (pll->flags & SUPPORTS_FSM_MODE)
>   		qcom_pll_set_fsm_mode(regmap, PLL_MODE(pll), 6, 0);
>   }
>   EXPORT_SYMBOL_GPL(clk_alpha_pll_configure);
>   
> +static int clk_alpha_pll_stromer_determine_rate(struct clk_hw *hw,
> +						struct clk_rate_request *req)
> +{
> +	u32 l;
> +	u64 a;
> +
> +	req->rate = alpha_pll_round_rate(req->rate, req->best_parent_rate,
> +					 &l, &a, ALPHA_REG_BITWIDTH);
> +
> +	return 0;
> +}
> +
> +static int clk_alpha_pll_stromer_set_rate(struct clk_hw *hw, unsigned long rate,
> +					  unsigned long prate)
> +{
> +	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
> +	u32 l;
> +	int ret;
> +	u64 a;
> +
> +	rate = alpha_pll_round_rate(rate, prate, &l, &a, ALPHA_REG_BITWIDTH);
> +
> +	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
> +	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
> +	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL_U(pll),
> +		     a >> ALPHA_BITWIDTH);
> +
> +	regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll),
> +			   PLL_ALPHA_EN, PLL_ALPHA_EN);
> +
> +	if (!clk_hw_is_enabled(hw))
> +		return 0;
> +
> +	/*
> +	 * Stromer PLL supports Dynamic programming.
> +	 * It allows the PLL frequency to be changed on-the-fly without first
> +	 * execution of a shutdown procedure followed by a bring up procedure.
> +	 */
> +
> +	regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_UPDATE,
> +			   PLL_UPDATE);
> +
> +	ret = wait_for_pll_update(pll);
> +	if (ret)
> +		return ret;
> +
> +	ret = wait_for_pll_enable_lock(pll);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>   static int clk_alpha_pll_hwfsm_enable(struct clk_hw *hw)
>   {
>   	int ret;
> @@ -1013,6 +1101,16 @@ const struct clk_ops clk_alpha_pll_hwfsm_ops = {
>   };
>   EXPORT_SYMBOL_GPL(clk_alpha_pll_hwfsm_ops);
>   
> +const struct clk_ops clk_alpha_pll_stromer_ops = {
> +	.enable = clk_alpha_pll_enable,
> +	.disable = clk_alpha_pll_disable,
> +	.is_enabled = clk_alpha_pll_is_enabled,
> +	.recalc_rate = clk_alpha_pll_recalc_rate,
> +	.determine_rate = clk_alpha_pll_stromer_determine_rate,
> +	.set_rate = clk_alpha_pll_stromer_set_rate,
> +};
> +EXPORT_SYMBOL_GPL(clk_alpha_pll_stromer_ops);
> +
>   const struct clk_ops clk_alpha_pll_fixed_trion_ops = {
>   	.enable = clk_trion_pll_enable,
>   	.disable = clk_trion_pll_disable,
> diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
> index 2bdae362c827..1d122919e275 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.h
> +++ b/drivers/clk/qcom/clk-alpha-pll.h
> @@ -1,5 +1,5 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright (c) 2015, 2018, The Linux Foundation. All rights reserved. */
> +/* Copyright (c) 2015, 2018, 2021 The Linux Foundation. All rights reserved. */
>   
>   #ifndef __QCOM_CLK_ALPHA_PLL_H__
>   #define __QCOM_CLK_ALPHA_PLL_H__
> @@ -22,6 +22,7 @@ enum {
>   	CLK_ALPHA_PLL_TYPE_RIVIAN_EVO,
>   	CLK_ALPHA_PLL_TYPE_DEFAULT_EVO,
>   	CLK_ALPHA_PLL_TYPE_BRAMMO_EVO,
> +	CLK_ALPHA_PLL_TYPE_STROMER,
>   	CLK_ALPHA_PLL_TYPE_MAX,
>   };
>   
> @@ -131,6 +132,9 @@ struct alpha_pll_config {
>   	u32 post_div_mask;
>   	u32 vco_val;
>   	u32 vco_mask;
> +	u32 status_reg_val;
> +	u32 status_reg_mask;
> +	u32 lock_det;
>   };
>   
>   extern const struct clk_ops clk_alpha_pll_ops;
> @@ -139,6 +143,7 @@ extern const struct clk_ops clk_alpha_pll_hwfsm_ops;
>   extern const struct clk_ops clk_alpha_pll_postdiv_ops;
>   extern const struct clk_ops clk_alpha_pll_huayra_ops;
>   extern const struct clk_ops clk_alpha_pll_postdiv_ro_ops;
> +extern const struct clk_ops clk_alpha_pll_stromer_ops;
>   
>   extern const struct clk_ops clk_alpha_pll_fabia_ops;
>   extern const struct clk_ops clk_alpha_pll_fixed_fabia_ops;
