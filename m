Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA65C6203A4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 00:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiKGXUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 18:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiKGXUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:20:02 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD67D26AED;
        Mon,  7 Nov 2022 15:20:01 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A7LW55p025114;
        Mon, 7 Nov 2022 23:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZH8/YoYPMWTivQ0j+TQjnMyauY4UExY1dnSgQnRNGPk=;
 b=m/eJI2d+0zu9Ys9D0oEZ9MbIAaIUAQr0UQeDGrBZtxWYBBtV1r98Lzaa/SiFTMJQWAVg
 4mkUuS9PlRFzFq6U4sMAtX3Qt6EbHUWIkCqayG8cOQ1mXcN7c2+MBNh1X1UvFoRoX4Ug
 E5ewIg4zYFe0SMRfRirEdLVn6shBoxrOWQfeh6kRE21lAR3+lXPCcz9xQcevTbP+7AYJ
 vN03Hy/HGKtWSyIRYnYNpUltoh1Hp3ramJSqRy06GKUqxWg9oOHR+m2VOKJxmY2EIuYO
 9mtwfYmEPIgm49tOrKiXp/tG3Fesw/s0uTAduK4B15Z2c8TczCcWvpZDA/326eda9WqC ag== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kq5s38t6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 23:19:45 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A7NJi1c023138
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Nov 2022 23:19:44 GMT
Received: from [10.110.0.244] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 7 Nov 2022
 15:19:44 -0800
Message-ID: <f3fb0b66-66bb-b39b-8d45-f5c4105e2076@quicinc.com>
Date:   Mon, 7 Nov 2022 15:19:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 3/5] clk: qcom: Add QDU1000 and QRU1000 GCC support
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221026190441.4002212-1-quic_molvera@quicinc.com>
 <20221026190441.4002212-4-quic_molvera@quicinc.com>
 <20221107173237.xkeigtihoes3vsux@builder.lan>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <20221107173237.xkeigtihoes3vsux@builder.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zJtG6TbzauyUkd9Ke6miLMauZ2Pw16sT
X-Proofpoint-ORIG-GUID: zJtG6TbzauyUkd9Ke6miLMauZ2Pw16sT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211070174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2022 9:32 AM, Bjorn Andersson wrote:
> On Wed, Oct 26, 2022 at 12:04:39PM -0700, Melody Olvera wrote:
>> diff --git a/drivers/clk/qcom/gcc-qdu1000.c b/drivers/clk/qcom/gcc-qdu1000.c
>> new file mode 100644
>> index 000000000000..7bd8ebf0ddb5
>> --- /dev/null
>> +++ b/drivers/clk/qcom/gcc-qdu1000.c
>> @@ -0,0 +1,2645 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/regmap.h>
>> +
>> +#include <dt-bindings/clock/qcom,gcc-qdu1000.h>
>> +
>> +#include "clk-alpha-pll.h"
>> +#include "clk-branch.h"
>> +#include "clk-rcg.h"
>> +#include "clk-regmap.h"
>> +#include "clk-regmap-divider.h"
>> +#include "clk-regmap-mux.h"
>> +#include "clk-regmap-phy-mux.h"
>> +#include "reset.h"
>> +
>> +enum {
>> +	P_BI_TCXO,
>> +	P_GCC_GPLL0_OUT_EVEN,
>> +	P_GCC_GPLL0_OUT_MAIN,
>> +	P_GCC_GPLL1_OUT_MAIN,
>> +	P_GCC_GPLL2_OUT_MAIN,
>> +	P_GCC_GPLL3_OUT_MAIN,
>> +	P_GCC_GPLL4_OUT_MAIN,
>> +	P_GCC_GPLL5_OUT_MAIN,
>> +	P_GCC_GPLL6_OUT_MAIN,
>> +	P_GCC_GPLL7_OUT_MAIN,
>> +	P_GCC_GPLL8_OUT_MAIN,
>> +	P_PCIE_0_PHY_AUX_CLK,
>> +	P_PCIE_0_PIPE_CLK,
>> +	P_SLEEP_CLK,
>> +	P_USB3_PHY_WRAPPER_GCC_USB30_PIPE_CLK,
>> +};
> [..]
>> +static const struct clk_parent_data gcc_parent_data_1[] = {
>> +	{ .index = P_BI_TCXO },
>> +	{ .hw = &gcc_gpll0.clkr.hw },
>> +	{ .index = P_SLEEP_CLK },
> .index here refers to the index in the clocks property in DT.
>
> I think it's okay to reuse the parent-enum, but the entries within must
> then match the order defined in the DT binding. So you need to ensure
> that the first N entires in the enum matches the binding.
>
> Perhaps it's cleaner to just carry a separate enum for the clocks order,
> as we've done in the other drivers?
>
> If nothing else it makes it clear that one number space is arbitrary and
> internal to the driver and the other is ABI.

Yeah that makes plenty of sense. Will update the driver with a separate enum.

>
>> +	{ .hw = &gcc_gpll0_out_even.clkr.hw },
>> +};
>> +
> [..]
>> +static struct clk_regmap_mux gcc_pcie_0_phy_aux_clk_src = {
>> +	.reg = 0x9d080,
>> +	.shift = 0,
>> +	.width = 2,
>> +	.parent_map = gcc_parent_map_6,
>> +	.clkr = {
>> +		.hw.init = &(const struct clk_init_data){
> Sorry for being picky, but I do like when there's a space between the
> ')' and '{' in these lines...

No worries. Will fix.

>
>> +			.name = "gcc_pcie_0_phy_aux_clk_src",
>> +			.parent_data = gcc_parent_data_6,
>> +			.num_parents = ARRAY_SIZE(gcc_parent_data_6),
>> +			.ops = &clk_regmap_mux_closest_ops,
>> +		},
>> +	},
>> +};
>
Thanks,
Melody
