Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8B17499CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjGFKvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjGFKv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:51:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54B01BF1;
        Thu,  6 Jul 2023 03:51:23 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36680taB013222;
        Thu, 6 Jul 2023 10:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hQcxAbgU6XRxEZHjAzEUWwqx9w9pka5zGZIQt7QElK8=;
 b=W+Fstp8E4wHQfBOSXQvnUKFwDJH9yUmJUCN4Jlr0a4cJ9EuKV1IJvpw2Xf8COPDbKoEn
 lXznHMcq4HblxlgJyZ7KcwmsqFO1WROxpSHT8wCEcq97mODWLZ/METALrmVqtEA8693b
 uQnWyE45rkVPpdoAgcNcaJflZBjoKy1jyuIojRlH1G8t3paAMQQXZ4YWGu/ffbL10WzM
 xNp2nMUPF8Y+q6lB97fsirqzfqozDSnErY3rAXPSwC0kamyhpvbotqzfIV2Q4HtBl13K
 Lx6Ebp6MdTYm46txcGWtAnCpgamgtpsnw3B76FhsN3VfDUulkQr+Srm3/X94mTQSk20D iQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rmxpnbkae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 10:51:19 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366ApIa5019621
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 10:51:18 GMT
Received: from [10.216.36.60] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 6 Jul
 2023 03:51:13 -0700
Message-ID: <05f3459f-a2cd-3e4d-bbc6-f0109dbae778@quicinc.com>
Date:   Thu, 6 Jul 2023 16:21:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 3/5] clk: qcom: gcc-qdu1000: Update GCC clocks as per
 the latest hw version
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230628092837.3090801-1-quic_imrashai@quicinc.com>
 <20230628092837.3090801-4-quic_imrashai@quicinc.com>
 <afde2981-3801-a93e-3cf2-2ab5d24ee3e1@linaro.org>
Content-Language: en-US
From:   Imran Shaik <quic_imrashai@quicinc.com>
In-Reply-To: <afde2981-3801-a93e-3cf2-2ab5d24ee3e1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yyt43i6N-IdV8hn1QVtZUEhNeMT8RKma
X-Proofpoint-GUID: yyt43i6N-IdV8hn1QVtZUEhNeMT8RKma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_06,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307060095
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/28/2023 4:36 PM, Konrad Dybcio wrote:
> On 28.06.2023 11:28, Imran Shaik wrote:
>> Add support for gcc_ddrss_ecpri_gsi_clk and update the GCC clkref clocks
>> as per the latest hardware version of QDU1000 and QRU100 SoCs.
>>
>> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
>> ---
>> Changes since v1:
>>   - Newly added
>>
>>   drivers/clk/qcom/gcc-qdu1000.c | 32 ++++++++++++++++++++++++++------
>>   1 file changed, 26 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/gcc-qdu1000.c b/drivers/clk/qcom/gcc-qdu1000.c
>> index c00d26a3e6df..991fb2bc97e9 100644
>> --- a/drivers/clk/qcom/gcc-qdu1000.c
>> +++ b/drivers/clk/qcom/gcc-qdu1000.c
>> @@ -1131,6 +1131,26 @@ static struct clk_branch gcc_ddrss_ecpri_dma_clk = {
>>   	},
>>   };
>>   
>> +static struct clk_branch gcc_ddrss_ecpri_gsi_clk = {
>> +	.halt_reg = 0x54298,
>> +	.halt_check = BRANCH_HALT_VOTED,
>> +	.hwcg_reg = 0x54298,
>> +	.hwcg_bit = 1,
>> +	.clkr = {
>> +		.enable_reg = 0x54298,
>> +		.enable_mask = BIT(0),
>> +		.hw.init = &(const struct clk_init_data) {
>> +			.name = "gcc_ddrss_ecpri_gsi_clk",
>> +			.parent_hws = (const struct clk_hw*[]) {
>> +				&gcc_aggre_noc_ecpri_gsi_clk_src.clkr.hw,
>> +			},
>> +			.num_parents = 1,
>> +			.flags = CLK_SET_RATE_PARENT,
>> +			.ops = &clk_branch2_aon_ops,
>> +		},
>> +	},
>> +};
>> +
>>   static struct clk_branch gcc_ecpri_ahb_clk = {
>>   	.halt_reg = 0x3a008,
>>   	.halt_check = BRANCH_HALT_VOTED,
>> @@ -1447,14 +1467,13 @@ static struct clk_branch gcc_pcie_0_cfg_ahb_clk = {
>>   
>>   static struct clk_branch gcc_pcie_0_clkref_en = {
>>   	.halt_reg = 0x9c004,
>> -	.halt_bit = 31,
>> -	.halt_check = BRANCH_HALT_ENABLE,
>> +	.halt_check = BRANCH_HALT,
>>   	.clkr = {
>>   		.enable_reg = 0x9c004,
>>   		.enable_mask = BIT(0),
>>   		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_pcie_0_clkref_en",
>> -			.ops = &clk_branch_ops,
>> +			.ops = &clk_branch2_ops,
> This sounds like a separate fix, clk_branch_ops seems to only concern
> 10+yo chips.
> 
> Konrad

Sure, will split this patch and push the next series.

Thanks,
Imran

>>   		},
>>   	},
>>   };
>> @@ -2274,14 +2293,13 @@ static struct clk_branch gcc_tsc_etu_clk = {
>>   
>>   static struct clk_branch gcc_usb2_clkref_en = {
>>   	.halt_reg = 0x9c008,
>> -	.halt_bit = 31,
>> -	.halt_check = BRANCH_HALT_ENABLE,
>> +	.halt_check = BRANCH_HALT,
>>   	.clkr = {
>>   		.enable_reg = 0x9c008,
>>   		.enable_mask = BIT(0),
>>   		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_usb2_clkref_en",
>> -			.ops = &clk_branch_ops,
>> +			.ops = &clk_branch2_ops,
>>   		},
>>   	},
>>   };
>> @@ -2523,6 +2541,8 @@ static struct clk_regmap *gcc_qdu1000_clocks[] = {
>>   	[GCC_AGGRE_NOC_ECPRI_GSI_CLK] = &gcc_aggre_noc_ecpri_gsi_clk.clkr,
>>   	[GCC_PCIE_0_PHY_AUX_CLK_SRC] = &gcc_pcie_0_phy_aux_clk_src.clkr,
>>   	[GCC_PCIE_0_PIPE_CLK_SRC] = &gcc_pcie_0_pipe_clk_src.clkr,
>> +	[GCC_GPLL1_OUT_EVEN] = &gcc_gpll1_out_even.clkr,
>> +	[GCC_DDRSS_ECPRI_GSI_CLK] = &gcc_ddrss_ecpri_gsi_clk.clkr,
>>   };
>>   
>>   static const struct qcom_reset_map gcc_qdu1000_resets[] = {
