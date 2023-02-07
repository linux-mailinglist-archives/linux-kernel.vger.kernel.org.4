Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C8368CE39
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjBGEca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjBGEcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:32:25 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7012613DDB;
        Mon,  6 Feb 2023 20:32:23 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3174I1Y0011209;
        Tue, 7 Feb 2023 04:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dDG9jZi8NNGifa3TxlUih9e+cN+KpyacXCMrVoKssXg=;
 b=lNwz7D2zT1rFRpY478YJOQa8zHWEVL+Cs5VF6mb5WY80JfjiJYqBSz20tYCY0nEIdIQb
 WmaxscjV+2I0uwjqAAPEO1GMM8GsTKrWa1QDT6w3/9/1UDfocKzZuR4+OKmu4+aIsJuq
 NXrxruv2en17P16s/rGLTZjJphVu/kZ9a49Y7JtOo67/bHb5hy4y2f/l3qNXchezoSMW
 3QHmKTCFQ1pNSko+6xxg7tV/kj9TSzV8NtCMA9dtCiyHJo1HHyQkQLTuZmXbxFeYNLHE
 CrBDOzh8a4Qvj6rRtK9lmAQoz17RadjU7KCVhIX1AsCCVwWwvj7ZGfoQJOUWPNkjxv6X Bw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhgng5aar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 04:32:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3174W60P006581
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Feb 2023 04:32:06 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 20:31:58 -0800
Message-ID: <e59d133e-40a9-0dae-b272-20d82e8c9b76@quicinc.com>
Date:   Tue, 7 Feb 2023 10:01:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V3 5/9] clk: qcom: add Global Clock controller (GCC)
 driver for IPQ5332 SoC
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <dmitry.baryshkov@linaro.org>, <marcel.ziswiler@toradex.com>,
        <nfraprado@collabora.com>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_varada@quicinc.com>,
        <quic_srichara@quicinc.com>
References: <20230206071217.29313-1-quic_kathirav@quicinc.com>
 <20230206071217.29313-6-quic_kathirav@quicinc.com>
 <20230207034108.bypitlfxicpz6wqb@ripper>
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <20230207034108.bypitlfxicpz6wqb@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4VfyI-KjiMDmNKzm7rj--9gij9Vn1Nna
X-Proofpoint-ORIG-GUID: 4VfyI-KjiMDmNKzm7rj--9gij9Vn1Nna
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070039
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Bjorn for the review!


On 2/7/2023 9:11 AM, Bjorn Andersson wrote:
> On Mon, Feb 06, 2023 at 12:42:13PM +0530, Kathiravan T wrote:
>> diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
> [..]
>> +
>> +enum {
>> +	DT_SLEEP_CLK,
>> +	DT_XO,
>> +	DT_PCIE_2LANE_PHY_PIPE_CLK,
>> +	DT_PCIE_2LANE_PHY_PIPE_X1_CLK,
>> +	DT_USB_PCIE_WRAPPER_PIPE_CLK,
> This list does not match the clocks as defined in the binding.


Ack. will fix this in next spin.


>
>> +};
>> +
>> +enum {
>> +	P_PCIE3X2_PIPE,
>> +	P_PCIE3X1_0_PIPE,
>> +	P_PCIE3X1_1_PIPE,
>> +	P_USB3PHY_0_PIPE,
>> +	P_CORE_BI_PLL_TEST_SE,
>> +	P_GCC_GPLL0_OUT_MAIN_DIV_CLK_SRC,
>> +	P_GPLL0_OUT_AUX,
>> +	P_GPLL0_OUT_MAIN,
>> +	P_GPLL2_OUT_AUX,
>> +	P_GPLL2_OUT_MAIN,
>> +	P_GPLL4_OUT_AUX,
>> +	P_GPLL4_OUT_MAIN,
>> +	P_SLEEP_CLK,
>> +	P_XO,
>> +};
>> +
>> +static const struct clk_parent_data gcc_parent_data_xo = { .index = DT_XO };
>> +
>> +static struct clk_alpha_pll gpll0_main = {
>> +	.offset = 0x20000,
>> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
>> +	.clkr = {
>> +		.enable_reg = 0xb000,
>> +		.enable_mask = BIT(0),
>> +		.hw.init = &(const struct clk_init_data){
> Please add a space between ')' and '{ on all these.


Ack.


>
>> +			.name = "gpll0_main",
>> +			.parent_data = &gcc_parent_data_xo,
>> +			.num_parents = 1,
>> +			.ops = &clk_alpha_pll_stromer_ops,
>> +		},
>> +	},
>> +};
> [..]
>> +static const struct qcom_cc_desc gcc_ipq5332_desc = {
>> +	.config = &gcc_ipq5332_regmap_config,
>> +	.clks = gcc_ipq5332_clocks,
>> +	.num_clks = ARRAY_SIZE(gcc_ipq5332_clocks),
>> +	.resets = gcc_ipq5332_resets,
>> +	.num_resets = ARRAY_SIZE(gcc_ipq5332_resets),
>> +	.clk_hws = gcc_ipq5332_hws,
>> +	.num_clk_hws = ARRAY_SIZE(gcc_ipq5332_hws),
> No GDSCs?

No, there is no GDSC support.


>
> Regards,
> Bjorn
