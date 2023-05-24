Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5B470ED1C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbjEXFbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239434AbjEXFbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:31:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03E21B0;
        Tue, 23 May 2023 22:31:30 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O4qwR4029948;
        Wed, 24 May 2023 05:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=N8dCo+fSH4BbOaNI+Pps9tRlJmwJT9ZWwK4a73Q6ICI=;
 b=Kca/ULd1+v/amqLPEqojR0HrMgUlGwN7u4ED/JtJsoIqvvG+DYDD2K9BfEIQ+5i+vkLr
 N9T+Q1PKDPIjtkPu7jK3Lr/m7rMTaCezejwuEKlig2Rgju0fAeN2x1KM/9oC14TANZFp
 FqxtnDgFyl0Rs8GrGdOOqpgAgTXJqNKJ+sw9J3QZ5yjgvHm1DVWR6flW9TrTBr0OxGXo
 cHQXIko8TGmBRHA746vYogBRRMuvLKB2X9yBw5zLVS55Ztdqmc5FCNSpCwPMXhkGDvBz
 McRdNyQih20GGuGlx+0OZbfRBeckM85XERer+qOaLCMOpAMb2pOBNpb5xJ2trR/b+0CM tQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qrsx0tpcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 05:31:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34O5VINA013184
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 05:31:18 GMT
Received: from [10.216.39.178] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 23 May
 2023 22:31:10 -0700
Message-ID: <8464057e-2092-ef48-8f51-f37766b98a5a@quicinc.com>
Date:   Wed, 24 May 2023 11:01:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V3 2/4] clk: qcom: gcc-ipq9574: Enable crypto clocks
To:     <bhupesh.sharma@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <thara.gopinath@gmail.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-arm-msm@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_poovendh@quicinc.com>
References: <20230518141105.24741-1-quic_anusha@quicinc.com>
 <20230518141105.24741-3-quic_anusha@quicinc.com>
 <c451dc43-b5a2-df42-c4a5-0db4c6641b1c@linaro.org>
From:   Anusha Canchi <quic_anusha@quicinc.com>
In-Reply-To: <c451dc43-b5a2-df42-c4a5-0db4c6641b1c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UfzkQLZWGDQ73FgkYU3RVG4E6KoyffPo
X-Proofpoint-GUID: UfzkQLZWGDQ73FgkYU3RVG4E6KoyffPo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_02,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240046
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/2023 2:28 PM, bhupesh.sharma@linaro.org wrote:
>
>
> On 5/18/23 7:41 PM, Anusha Rao <quic_anusha@quicinc.com> wrote:
>> Enable the clocks required for crypto operation.
>>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> ---
>>   Changes in V3:
>>     - Added GCC prefix to CRYPTO_CLK_SRC.
>>
>>   drivers/clk/qcom/gcc-ipq9574.c | 72 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 72 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/gcc-ipq9574.c 
>> b/drivers/clk/qcom/gcc-ipq9574.c
>> index 7b0505f5c255..73663168d72a 100644
>> --- a/drivers/clk/qcom/gcc-ipq9574.c
>> +++ b/drivers/clk/qcom/gcc-ipq9574.c
>> @@ -728,6 +728,41 @@ static struct clk_rcg2 blsp1_uart6_apps_clk_src = {
>>       },
>>   };
>>   +static const struct freq_tbl ftbl_gcc_crypto_clk_src[] = {
>> +    F(160000000, P_GPLL0, 5, 0, 0),
>> +    { }
>> +};
>> +
>> +static struct clk_rcg2 gcc_crypto_clk_src = {
>> +    .cmd_rcgr = 0x16004,
>> +    .freq_tbl = ftbl_gcc_crypto_clk_src,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_crypto_clk_src",
>> +        .parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
>> +        .num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
>> +        .ops = &clk_rcg2_ops,
>> +    },
>> +};
>> +
>> +static struct clk_branch gcc_crypto_clk = {
>> +    .halt_reg = 0x1600c,
>> +    .halt_check = BRANCH_HALT_VOTED,
>> +    .clkr = {
>> +        .enable_reg = 0x0b004,
>> +        .enable_mask = BIT(14),
>> +        .hw.init = &(const struct clk_init_data) {
>> +            .name = "gcc_crypto_clk",
>> +            .parent_hws = (const struct clk_hw *[]) {
>> +                &gcc_crypto_clk_src.clkr.hw },
>> +            .num_parents = 1,
>> +            .flags = CLK_SET_RATE_PARENT,
>> +            .ops = &clk_branch2_ops,
>> +        },
>> +    },
>> +};
>> +
>>   static struct clk_branch gcc_apss_ahb_clk = {
>>       .halt_reg = 0x24018,
>>       .halt_check = BRANCH_HALT_VOTED,
>> @@ -2071,6 +2106,38 @@ static struct clk_rcg2 pcnoc_bfdcd_clk_src = {
>>       },
>>   };
>>   +static struct clk_branch gcc_crypto_axi_clk = {
>> +    .halt_reg = 0x16010,
>> +    .clkr = {
>> +        .enable_reg = 0x16010,
>> +        .enable_mask = BIT(0),
>> +        .hw.init = &(const struct clk_init_data) {
>> +            .name = "gcc_crypto_axi_clk",
>> +            .parent_hws = (const struct clk_hw *[]) {
>> +                &pcnoc_bfdcd_clk_src.clkr.hw },
>> +            .num_parents = 1,
>> +            .flags = CLK_SET_RATE_PARENT,
>> +            .ops = &clk_branch2_ops,
>> +        },
>> +    },
>> +};
>> +
>> +static struct clk_branch gcc_crypto_ahb_clk = {
>> +    .halt_reg = 0x16014,
>> +    .clkr = {
>> +        .enable_reg = 0x16014,
>> +        .enable_mask = BIT(0),
>> +        .hw.init = &(const struct clk_init_data) {
>> +            .name = "gcc_crypto_ahb_clk",
>> +            .parent_hws = (const struct clk_hw *[]) {
>> +                &pcnoc_bfdcd_clk_src.clkr.hw },
>> +            .num_parents = 1,
>> +            .flags = CLK_SET_RATE_PARENT,
>> +            .ops = &clk_branch2_ops,
>> +        },
>> +    },
>> +};
>> +
>>   static struct clk_branch gcc_nsscfg_clk = {
>>       .halt_reg = 0x1702c,
>>       .clkr = {
>> @@ -4036,6 +4103,10 @@ static struct clk_regmap *gcc_ipq9574_clks[] = {
>>       [GCC_SNOC_PCIE1_1LANE_S_CLK] = &gcc_snoc_pcie1_1lane_s_clk.clkr,
>>       [GCC_SNOC_PCIE2_2LANE_S_CLK] = &gcc_snoc_pcie2_2lane_s_clk.clkr,
>>       [GCC_SNOC_PCIE3_2LANE_S_CLK] = &gcc_snoc_pcie3_2lane_s_clk.clkr,
>> +    [GCC_CRYPTO_CLK_SRC] = &gcc_crypto_clk_src.clkr,
>> +    [GCC_CRYPTO_CLK] = &gcc_crypto_clk.clkr,
>> +    [GCC_CRYPTO_AXI_CLK] = &gcc_crypto_axi_clk.clkr,
>> +    [GCC_CRYPTO_AHB_CLK] = &gcc_crypto_ahb_clk.clkr,
>>   };
>
> Can we please add these in alphabetical order. For e.g. here these 
> entries would follow those for '[GCC_CMN_BLK_APU_ARES] = { 0x3a010, 2 },'
Okay, will update.

Thanks,
Anusha
>
>>   static const struct qcom_reset_map gcc_ipq9574_resets[] = {
>> @@ -4193,6 +4264,7 @@ static const struct qcom_reset_map 
>> gcc_ipq9574_resets[] = {
>>       [GCC_WCSS_ECAHB_ARES] = { 0x25070, 0 },
>>       [GCC_WCSS_Q6_BCR] = { 0x18000, 0 },
>>       [GCC_WCSS_Q6_TBU_BCR] = { 0x12054, 0 },
>> +    [GCC_CRYPTO_BCR] = { 0x16000, 0 },
>
> Same as above.
Okay.

Thanks,
Anusha
>
> With the above addressed:
> Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>
> Thanks.
>
>>   };
>>     static const struct of_device_id gcc_ipq9574_match_table[] = {
>>

