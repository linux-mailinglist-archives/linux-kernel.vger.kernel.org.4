Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C766CB6BE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjC1GQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjC1GQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:16:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC4230FC;
        Mon, 27 Mar 2023 23:16:10 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32S6C7jK010531;
        Tue, 28 Mar 2023 06:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iRrp4ZVtHf6+VfJjNdWEkd8OHn2fcSeeKtKC2EYmZqI=;
 b=oDJO0GnxXGX/pXQnqDScTGS7qLfCVyxGW5Ggatsn9zRS/JRaBGNtMxl5TIdv1Hx3ls04
 gwxSJD5rYPKwPXqibHUvYl2koRaOKuzqFtYQq8rkLeDFp3j0F9jKAerg7COsUp8kS+Ro
 uf6/ezOiBQbhb11pFSpIhwU3RC9OxuKwUAVSzE3xZrnoZdf+ak2Q8X7RucRW1w9TMIix
 1VNPUfEECqRkXRjEwMkEOETpp1tEVhQ+ZSAf8XGT/5WOSpitHonK14vbPmocLXJ9cy7x
 xjXcxV1qOm8hSC4Xs33OYdVqkDojLYCA7G0lZrqOQB65L2WC9b4BVXPTn/y2cU9x0FaZ ug== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pk7h8tu7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 06:15:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32S6Fl1R002528
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 06:15:47 GMT
Received: from [10.216.32.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Mar
 2023 23:15:38 -0700
Message-ID: <2484518b-bcf6-7fb1-6bfb-b96b3682397b@quicinc.com>
Date:   Tue, 28 Mar 2023 11:45:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V10 2/4] clk: qcom: Add Global Clock Controller driver for
 IPQ9574
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <arnd@arndb.de>, <broonie@kernel.org>,
        <catalin.marinas@arm.com>, <devicetree@vger.kernel.org>,
        <dmitry.baryshkov@linaro.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <marcel.ziswiler@toradex.com>, <mturquette@baylibre.com>,
        <nfraprado@collabora.com>, <p.zabel@pengutronix.de>,
        <robh+dt@kernel.org>, <shawnguo@kernel.org>, <will@kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230327132718.573-1-quic_devipriy@quicinc.com>
 <20230327132718.573-3-quic_devipriy@quicinc.com>
 <0af15083921c5d3c89392209654f0c9b.sboyd@kernel.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <0af15083921c5d3c89392209654f0c9b.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NKZ7h8yzMq3DFkKuh5KMdGewxq-VMlB_
X-Proofpoint-ORIG-GUID: NKZ7h8yzMq3DFkKuh5KMdGewxq-VMlB_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280050
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/2023 10:18 PM, Stephen Boyd wrote:
> Quoting Devi Priya (2023-03-27 06:27:16)
>> diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
>> new file mode 100644
>> index 000000000000..b2a2d618a5ec
>> --- /dev/null
>> +++ b/drivers/clk/qcom/gcc-ipq9574.c
>> @@ -0,0 +1,4248 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +/*
>> + * Copyright (c) 2023 The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/err.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
> 
> What is this include for?
This include actually don't seem necessary. But, I see that of.h & 
platform_device.h are being included via of_device.h
Would you suggest to drop of_device.h or the other two
headers instead?
> 
>> +#include <linux/regmap.h>
> 
> Need to include clk-provider.h
> 
>> +
>> +#include <linux/reset-controller.h>
> 
> Put a newline here.
Okay
> 
>> +#include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>> +#include <dt-bindings/reset/qcom,ipq9574-gcc.h>
>> +
>> +#include "clk-rcg.h"
>> +#include "clk-branch.h"
>> +#include "clk-alpha-pll.h"
>> +#include "clk-regmap-divider.h"
>> +#include "clk-regmap-mux.h"
>> +#include "clk-regmap-phy-mux.h"
>> +#include "reset.h"
>> +
>> +/* Need to match the order of clocks in DT binding */
>> +enum {
>> +       DT_XO,
>> +       DT_SLEEP_CLK,
>> +       DT_BIAS_PLL_UBI_NC_CLK,
>> +       DT_PCIE30_PHY0_PIPE_CLK,
>> +       DT_PCIE30_PHY1_PIPE_CLK,
>> +       DT_PCIE30_PHY2_PIPE_CLK,
>> +       DT_PCIE30_PHY3_PIPE_CLK,
>> +       DT_USB3PHY_0_CC_PIPE_CLK,
>> +};
>> +
>> +enum {
>> +       P_XO,
>> +       P_PCIE30_PHY0_PIPE,
>> +       P_PCIE30_PHY1_PIPE,
>> +       P_PCIE30_PHY2_PIPE,
>> +       P_PCIE30_PHY3_PIPE,
>> +       P_USB3PHY_0_PIPE,
>> +       P_GPLL0,
>> +       P_GPLL0_DIV2,
>> +       P_GPLL0_OUT_AUX,
>> +       P_GPLL2,
>> +       P_GPLL4,
>> +       P_PI_SLEEP,
>> +       P_BIAS_PLL_UBI_NC_CLK,
>> +};
>> +
>> +static const struct parent_map gcc_xo_map[] = {
>> +       { P_XO, 0 },
>> +};
>> +
>> +static const struct clk_parent_data gcc_xo_data[] = {
>> +       { .index = DT_XO },
>> +};
>> +
>> +static const struct clk_parent_data gcc_sleep_clk_data[] = {
>> +       { .index = DT_SLEEP_CLK },
>> +};
>> +
>> +static struct clk_alpha_pll gpll0_main = {
>> +       .offset = 0x20000,
>> +       .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
>> +       .clkr = {
>> +               .enable_reg = 0x0b000,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data) {
> 
> All these clk_init_data structs should be const.
Okay
> 
>> +                       .name = "gpll0_main",
>> +                       .parent_data = gcc_xo_data,
>> +                       .num_parents = ARRAY_SIZE(gcc_xo_data),
>> +                       .ops = &clk_alpha_pll_ops,
>> +               },
>> +       },
>> +};
Thanks,
Devi Priya
