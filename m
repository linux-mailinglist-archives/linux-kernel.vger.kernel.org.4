Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CAD6698EA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241024AbjAMNo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242061AbjAMNoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:44:01 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABD758F9D;
        Fri, 13 Jan 2023 05:37:24 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DBqPaG028139;
        Fri, 13 Jan 2023 13:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4bXhPkketjLur3urkiMOHLcnfwXWVqg4tEG9styfBNg=;
 b=oN+qORGKD8TNZVPVY/Njo0eYJYYaiWv8KYiDpohZa5tEMhFKd+V4kFvSNQVzb6bYP+30
 X2oNdxe3OWkzAIW1Jd52M0dLqDL6Lv6e4n5oi5LPWik4udKALxJAR0fgXdd2cPwF8b4G
 kmL02iCLJRtpNuQ6ayef3Q+YCwlNs3DXJ3CWed7Q2n46PfTmLtjPu6TZ6yS+WihlM1Fu
 5qSSDdu3oxojA1HYPcxd1t9/Ye/7CgWkTCzQ6KHrD0vad45QG4zEzlK84b8GdnAT9cAK
 DxdslX98ehgZpkmLynvc/50VaAzqdgLsdw7MENZF/5CCVz9mSOaoU0HL1sJqIcm9SsYe Eg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2wun1kbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 13:37:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DDbJVG005344
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 13:37:19 GMT
Received: from [10.50.20.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 05:37:02 -0800
Message-ID: <0061aac5-e96f-64b4-6c57-6a67a759d886@quicinc.com>
Date:   Fri, 13 Jan 2023 19:06:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V4] clk: qcom: clk-alpha-pll: Add support for Stromer PLLs
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        Sricharan R <quic_srichara@quicinc.com>
References: <20221227132507.2506-1-quic_kathirav@quicinc.com>
 <fd150fa2b35e1e07808e3d1e67e1def7.sboyd@kernel.org>
Content-Language: en-US
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <fd150fa2b35e1e07808e3d1e67e1def7.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SzIGtWlXuqY-lDo1HTuJbRCd6nt4QTES
X-Proofpoint-GUID: SzIGtWlXuqY-lDo1HTuJbRCd6nt4QTES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_06,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130089
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thanks for taking time to review the patch.


On 1/13/2023 5:23 AM, Stephen Boyd wrote:
> Quoting Kathiravan T (2022-12-27 05:25:07)
>> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
>> index f9e4cfd7261c..29866100df08 100644
>> --- a/drivers/clk/qcom/clk-alpha-pll.c
>> +++ b/drivers/clk/qcom/clk-alpha-pll.c
>> @@ -204,9 +204,24 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
>>                  [PLL_OFF_CONFIG_CTL] = 0x1C,
>>                  [PLL_OFF_STATUS] = 0x20,
>>          },
>> +       [CLK_ALPHA_PLL_TYPE_STROMER] = {
>> +               [PLL_OFF_L_VAL] = 0x08,
>> +               [PLL_OFF_ALPHA_VAL] = 0x10,
>> +               [PLL_OFF_ALPHA_VAL_U] = 0x14,
>> +               [PLL_OFF_USER_CTL] = 0x18,
>> +               [PLL_OFF_USER_CTL_U] = 0x1c,
>> +               [PLL_OFF_CONFIG_CTL] = 0x20,
>> +               [PLL_OFF_CONFIG_CTL_U] = 0xff,
>> +               [PLL_OFF_TEST_CTL] = 0x30,
>> +               [PLL_OFF_TEST_CTL_U] = 0x34,
>> +               [PLL_OFF_STATUS] = 0x28,
>> +       },
>>   };
>>   EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
>>   
>> +static unsigned long
>> +alpha_pll_round_rate(unsigned long rate, unsigned long prate, u32 *l, u64 *a,
> Is this necessary?


Not really, will re-arrange the functions and drop this.


>
>> +                    u32 alpha_width);
>>   /*
>>    * Even though 40 bits are present, use only 32 for ease of calculation.
>>    */
>> @@ -215,6 +230,8 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
>>   #define ALPHA_BITWIDTH         32U
>>   #define ALPHA_SHIFT(w)         min(w, ALPHA_BITWIDTH)
>>   
>> +#define        ALPHA_PLL_STATUS_REG_SHIFT      8
>> +
>>   #define PLL_HUAYRA_M_WIDTH             8
>>   #define PLL_HUAYRA_M_SHIFT             8
>>   #define PLL_HUAYRA_M_MASK              0xff
>> @@ -325,7 +342,7 @@ static void clk_alpha_pll_write_config(struct regmap *regmap, unsigned int reg,
>>   void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>>                               const struct alpha_pll_config *config)
>>   {
>> -       u32 val, mask;
>> +       u32 val, val_u, mask, mask_u;
>>   
>>          regmap_write(regmap, PLL_L_VAL(pll), config->l);
>>          regmap_write(regmap, PLL_ALPHA_VAL(pll), config->alpha);
>> @@ -355,14 +372,85 @@ void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>>          mask |= config->pre_div_mask;
>>          mask |= config->post_div_mask;
>>          mask |= config->vco_mask;
>> +       mask |= config->alpha_en_mask;
>> +       mask |= config->alpha_mode_mask;
>>   
>>          regmap_update_bits(regmap, PLL_USER_CTL(pll), mask, val);
>>   
>> +       /* Stromer APSS PLL does not enable LOCK_DET by default, so enable it */
> Instead of adding these things to clk_alpha_pll_configure() can you
> introduce another api like clk_stromer_pll_configure() that sets these
> values unconditionally? That way we don't have to think or worry about
> the other alpha PLLs (of which there are many).


Sure, will introduce the new API.

>
>> +       val_u = config->status_reg_val << ALPHA_PLL_STATUS_REG_SHIFT;
>> +       val_u |= config->lock_det;
>> +
>> +       mask_u = config->status_reg_mask;
>> +       mask_u |= config->lock_det;
>> +
>> +       if (val_u)
>> +               regmap_update_bits(regmap, PLL_USER_CTL_U(pll), mask_u, val_u);
>> +
>> +       if (config->test_ctl_val)
>> +               regmap_write(regmap, PLL_TEST_CTL(pll), config->test_ctl_val);
>> +
>> +       if (config->test_ctl_hi_val)
>> +               regmap_write(regmap, PLL_TEST_CTL_U(pll), config->test_ctl_hi_val);
>> +
>>          if (pll->flags & SUPPORTS_FSM_MODE)
>>                  qcom_pll_set_fsm_mode(regmap, PLL_MODE(pll), 6, 0);
>>   }
>>   EXPORT_SYMBOL_GPL(clk_alpha_pll_configure);
>>   
>> +static int clk_alpha_pll_stromer_determine_rate(struct clk_hw *hw,
>> +                                               struct clk_rate_request *req)
>> +{
>> +       u32 l;
>> +       u64 a;
>> +
>> +       req->rate = alpha_pll_round_rate(req->rate, req->best_parent_rate,
>> +                                        &l, &a, ALPHA_REG_BITWIDTH);
>> +
>> +       return 0;
>> +}
>> +
>> +static int clk_alpha_pll_stromer_set_rate(struct clk_hw *hw, unsigned long rate,
>> +                                         unsigned long prate)
>> +{
>> +       struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
>> +       u32 l;
>> +       int ret;
>> +       u64 a;
>> +
>> +       rate = alpha_pll_round_rate(rate, prate, &l, &a, ALPHA_REG_BITWIDTH);
>> +
>> +       regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
>> +       regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
>> +       regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL_U(pll),
>> +                    a >> ALPHA_BITWIDTH);
>> +
>> +       regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll),
>> +                          PLL_ALPHA_EN, PLL_ALPHA_EN);
>> +
>> +       if (!clk_hw_is_enabled(hw))
>> +               return 0;
>> +
>> +       /*
>> +        * Stromer PLL supports Dynamic programming.
>> +        * It allows the PLL frequency to be changed on-the-fly without first
>> +        * execution of a shutdown procedure followed by a bring up procedure.
>> +        */
>> +
> Drop newline above please.


Ack.


>
>> +       regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_UPDATE,
>> +                          PLL_UPDATE);
>> +
>> +       ret = wait_for_pll_update(pll);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = wait_for_pll_enable_lock(pll);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return 0;
> Just use
>
> 	return wait_for_pll_enable_lock(pll);


Ack.


>
>> +}
>> +
>>   static int clk_alpha_pll_hwfsm_enable(struct clk_hw *hw)
>>   {
>>          int ret;
>> @@ -1013,6 +1101,16 @@ const struct clk_ops clk_alpha_pll_hwfsm_ops = {
>>   };
>>   EXPORT_SYMBOL_GPL(clk_alpha_pll_hwfsm_ops);
>>   
>> +const struct clk_ops clk_alpha_pll_stromer_ops = {
>> +       .enable = clk_alpha_pll_enable,
>> +       .disable = clk_alpha_pll_disable,
>> +       .is_enabled = clk_alpha_pll_is_enabled,
>> +       .recalc_rate = clk_alpha_pll_recalc_rate,
>> +       .determine_rate = clk_alpha_pll_stromer_determine_rate,
>> +       .set_rate = clk_alpha_pll_stromer_set_rate,
>> +};
>> +EXPORT_SYMBOL_GPL(clk_alpha_pll_stromer_ops);
>> +
>>   const struct clk_ops clk_alpha_pll_fixed_trion_ops = {
>>          .enable = clk_trion_pll_enable,
>>          .disable = clk_trion_pll_disable,
>> diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
>> index 2bdae362c827..1d122919e275 100644
>> --- a/drivers/clk/qcom/clk-alpha-pll.h
>> +++ b/drivers/clk/qcom/clk-alpha-pll.h
>> @@ -1,5 +1,5 @@
>>   /* SPDX-License-Identifier: GPL-2.0 */
>> -/* Copyright (c) 2015, 2018, The Linux Foundation. All rights reserved. */
>> +/* Copyright (c) 2015, 2018, 2021 The Linux Foundation. All rights reserved. */
> 2022 or 2023?


Will make it as 2023.

I'm on vacation next week. I will post the V5 once I'm back.

Thanks,

Kathiravan T.


