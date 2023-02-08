Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A818868EBE2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjBHJmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjBHJl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:41:56 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153B0442F8;
        Wed,  8 Feb 2023 01:41:25 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3189Dnn9023278;
        Wed, 8 Feb 2023 09:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mP4LubzJ2urSBkzpOLTo8lj/x1I0b/0nAvkIOvDsbrg=;
 b=CoxGMpwof00vqQHb/C6iu98MJph21VcjKP6Er+iLRmWryRpL2cE59lstVY0zhBJoykFA
 yRkVoRLVowvd7Ab+Shrvp34+tnFo11gOb9xMqMcssITpJvF1ak6wC7DH6WFaT8fAzaRl
 F1j2o1m+WtxfHm/YNPgltKAnVFjIvS11DrrNuJqEPSVfGeNzLd331WmDa5hjNDyCbZ5c
 xLv9LjUq/AwCwgRqiUr+6GTflCU4DZhu3aHoE8TPHXp/M9K2aM/pBUuLUKXWCSasnFG0
 tlLWyy5hRUhOch+cslsGKXC1AaCU1b16Qv2UNUR/QUGmY1fy+w3pcKDMoOz3W+2XYbBW VA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nm8x1r283-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 09:40:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3189ercw030362
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 09:40:53 GMT
Received: from [10.50.23.208] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 01:40:43 -0800
Message-ID: <aadb5fb5-5aa8-fdc0-68e6-7a716073756e@quicinc.com>
Date:   Wed, 8 Feb 2023 15:10:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V7 2/7] clk: qcom: Add Global Clock Controller driver for
 IPQ9574
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230206103337.21000-1-quic_devipriy@quicinc.com>
 <20230206103337.21000-3-quic_devipriy@quicinc.com>
 <94fc3698-3568-87d8-7263-68de9ca53eab@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <94fc3698-3568-87d8-7263-68de9ca53eab@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zUo0LoeF43W7QOkU4BXLTUNJyk3jRFyL
X-Proofpoint-ORIG-GUID: zUo0LoeF43W7QOkU4BXLTUNJyk3jRFyL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_03,2023-02-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302080087
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking time to review the patch!

On 2/6/2023 7:37 PM, Dmitry Baryshkov wrote:
> On 06/02/2023 12:33, Devi Priya wrote:
>> Add Global Clock Controller (GCC) driver for ipq9574 based devices
>>
>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   Changes in V7:
>>     - Used qcom_cc_probe instead of qcom_cc_really_probe in
>>       gcc_ipq9574_probe
>>
>>   drivers/clk/qcom/Kconfig       |    8 +
>>   drivers/clk/qcom/Makefile      |    1 +
>>   drivers/clk/qcom/gcc-ipq9574.c | 4295 ++++++++++++++++++++++++++++++++
>>   3 files changed, 4304 insertions(+)
>>   create mode 100644 drivers/clk/qcom/gcc-ipq9574.c
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 5ab4b7dfe3c2..a9f01d67a500 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -173,6 +173,14 @@ config IPQ_GCC_8074
>>         i2c, USB, SD/eMMC, etc. Select this for the root clock
>>         of ipq8074.
>> +config IPQ_GCC_9574
>> +    tristate "IPQ9574 Global Clock Controller"
>> +    help
>> +      Support for global clock controller on ipq9574 devices.
>> +      Say Y if you want to use peripheral devices such as UART, SPI,
>> +      i2c, USB, SD/eMMC, etc. Select this for the root clock
>> +      of ipq9574.
>> +
>>   config MSM_GCC_8660
>>       tristate "MSM8660 Global Clock Controller"
>>       help
>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>> index 3194465dd02c..51e6e5eb187b 100644
>> --- a/drivers/clk/qcom/Makefile
>> +++ b/drivers/clk/qcom/Makefile
>> @@ -27,6 +27,7 @@ obj-$(CONFIG_IPQ_GCC_4019) += gcc-ipq4019.o
>>   obj-$(CONFIG_IPQ_GCC_6018) += gcc-ipq6018.o
>>   obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
>>   obj-$(CONFIG_IPQ_GCC_8074) += gcc-ipq8074.o
>> +obj-$(CONFIG_IPQ_GCC_9574) += gcc-ipq9574.o
>>   obj-$(CONFIG_IPQ_LCC_806X) += lcc-ipq806x.o
>>   obj-$(CONFIG_MDM_GCC_9607) += gcc-mdm9607.o
>>   obj-$(CONFIG_MDM_GCC_9615) += gcc-mdm9615.o
>> diff --git a/drivers/clk/qcom/gcc-ipq9574.c 
>> b/drivers/clk/qcom/gcc-ipq9574.c
>> new file mode 100644
>> index 000000000000..718106a9ac7b
>> --- /dev/null
>> +++ b/drivers/clk/qcom/gcc-ipq9574.c
> 
> [skipped]
> 
>> +static struct clk_branch gcc_snoc_pcie3_2lane_s_clk = {
>> +    .halt_reg = 0x2e054,
>> +    .clkr = {
>> +        .enable_reg = 0x2e054,
>> +        .enable_mask = BIT(0),
>> +        .hw.init = &(struct clk_init_data) {
>> +            .name = "gcc_snoc_pcie3_2lane_s_clk",
>> +            .parent_hws = (const struct clk_hw *[]) {
>> +                &pcie3_axi_s_clk_src.clkr.hw
>> +            },
>> +            .num_parents = 1,
>> +            .flags = CLK_SET_RATE_PARENT,
>> +            .ops = &clk_branch2_ops,
>> +        },
>> +    },
>> +};
>> +
>> +static struct clk_regmap_mux pcie0_pipe_clk_src = {
>> +    .reg = 0x28064,
>> +    .shift = 8,
>> +    .width = 2,
>> +    .parent_map = gcc_pcie30_phy0_pipe_clk_xo_map,
>> +    .clkr = {
>> +        .hw.init = &(struct clk_init_data) {
>> +            .name = "pcie0_pipe_clk_src",
>> +            .parent_data = gcc_pcie30_phy0_pipe_clk_xo,
>> +            .num_parents = ARRAY_SIZE(gcc_pcie30_phy0_pipe_clk_xo),
>> +            .flags = CLK_SET_RATE_PARENT,
>> +            .ops = &clk_regmap_mux_closest_ops,
> 
> 
> clk_regmap_phy_mux_ops ?
Okay, will update the ops and struct accordingly in the next series
> 
>> +        },
>> +    },
>> +};
>> +
>> +static struct clk_regmap_mux pcie1_pipe_clk_src = {
>> +    .reg = 0x29064,
>> +    .shift = 8,
>> +    .width = 2,
>> +    .parent_map = gcc_pcie30_phy1_pipe_clk_xo_map,
>> +    .clkr = {
>> +        .hw.init = &(struct clk_init_data) {
>> +            .name = "pcie1_pipe_clk_src",
>> +            .parent_data = gcc_pcie30_phy1_pipe_clk_xo,
>> +            .num_parents = ARRAY_SIZE(gcc_pcie30_phy1_pipe_clk_xo),
>> +            .flags = CLK_SET_RATE_PARENT,
>> +            .ops = &clk_regmap_mux_closest_ops,
>> +        },
>> +    },
>> +};
>> +
>> +static struct clk_regmap_mux pcie2_pipe_clk_src = {
>> +    .reg = 0x2a064,
>> +    .shift = 8,
>> +    .width = 2,
>> +    .parent_map = gcc_pcie30_phy2_pipe_clk_xo_map,
>> +    .clkr = {
>> +        .hw.init = &(struct clk_init_data) {
>> +            .name = "pcie2_pipe_clk_src",
>> +            .parent_data = gcc_pcie30_phy2_pipe_clk_xo,
>> +            .num_parents = ARRAY_SIZE(gcc_pcie30_phy2_pipe_clk_xo),
>> +            .flags = CLK_SET_RATE_PARENT,
>> +            .ops = &clk_regmap_mux_closest_ops,
> 
> clk_regmap_phy_mux_ops ?
Okay
> 
> 
>> +        },
>> +    },
>> +};
>> +
>> +static struct clk_regmap_mux pcie3_pipe_clk_src = {
>> +    .reg = 0x2b064,
>> +    .shift = 8,
>> +    .width = 2,
>> +    .parent_map = gcc_pcie30_phy3_pipe_clk_xo_map,
>> +    .clkr = {
>> +        .hw.init = &(struct clk_init_data) {
>> +            .name = "pcie3_pipe_clk_src",
>> +            .parent_data = gcc_pcie30_phy3_pipe_clk_xo,
>> +            .num_parents = ARRAY_SIZE(gcc_pcie30_phy3_pipe_clk_xo),
>> +            .flags = CLK_SET_RATE_PARENT,
>> +            .ops = &clk_regmap_mux_closest_ops,
> 
> clk_regmap_phy_mux_ops ?
Okay
> 
>> +        },
>> +    },
>> +};
> 
Best Regards,
Devi Priya
