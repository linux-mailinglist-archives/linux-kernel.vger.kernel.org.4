Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E719E73B4D6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjFWKK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjFWKKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:10:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4692D5B;
        Fri, 23 Jun 2023 03:08:44 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N9w40p030536;
        Fri, 23 Jun 2023 10:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=37tZDaA6Rqkmwovv9ycj0K+p7H4yxo6JjswKg59b6gY=;
 b=oNOa6znfEl4SFABskhpLzWtjFLtGaG+QFHAErwNl3fIrxI+jbipN7re8hzkjyyWteXsj
 guX4yIh2GFVLcmHabfUTZGCbP50MIUME8dKvXngwMeIa+IyHJ/OSxGUnbh+UmEqmdwRT
 V45Lcs5Vrhwo04UC5rWfwtMasRSakoZFJlRVzZANBl0Lif8l+/5QQKkwnJZZPIoPq8mr
 LEyG9WQtgutrzzvJXi2g6Rv4rDL8war5lfDUKM9ZX1XpAXfz/ZQQkJcmleR1Z2+qtXDO
 +KxFnDEYwm8BqAS5dM1zcFLcUGWn9tH8OCT4bcfI3/QDBFNg9jWzU1Swz3vJ2BwpztHS Mg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rcpjhafbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 10:08:40 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35NA8dD8000812
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 10:08:39 GMT
Received: from [10.218.48.111] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 23 Jun
 2023 03:08:33 -0700
Message-ID: <66da39ad-33bf-2de8-949d-9f2f93e915e3@quicinc.com>
Date:   Fri, 23 Jun 2023 15:38:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] clk: qcom: gcc-qdu1000: Update GCC clocks and add
 support for GDSCs
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Melody Olvera <quic_molvera@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230616104941.921555-1-quic_imrashai@quicinc.com>
 <20230616104941.921555-3-quic_imrashai@quicinc.com>
 <acc8d1e4-e899-2ea4-947f-2bdcef7b7263@linaro.org>
From:   Imran Shaik <quic_imrashai@quicinc.com>
In-Reply-To: <acc8d1e4-e899-2ea4-947f-2bdcef7b7263@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rPOZ41UFaPwjsFVwl2hV9cmaFq9EInDI
X-Proofpoint-GUID: rPOZ41UFaPwjsFVwl2hV9cmaFq9EInDI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_04,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 clxscore=1011 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230091
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/2023 4:50 PM, Dmitry Baryshkov wrote:
> On 16/06/2023 13:49, Imran Shaik wrote:
>> Update the GCC clocks and add support for GDSCs for QDU1000 and
>> QRU1000 SoCs. While at it, fix the PCIe pipe clock handling and
>> add support for v2 variant.
> 
> Please split this into individual chunks instead of squashing everything 
> together. For each change please describe the logic behind the change in 
> the commit message. Please describe why, not what is changed.
> 

Sure, will split this patch and post the next series.

>>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> 
> This doesn't look fully logical. Who is the author of the patch? If 
> there are two authors, please add Co-developed-by tag.
> 

Yes, will use Co-developed-by tag in the next patch series.

>> ---
>>   drivers/clk/qcom/gcc-qdu1000.c | 162 ++++++++++++++++++++++-----------
>>   1 file changed, 110 insertions(+), 52 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/gcc-qdu1000.c 
>> b/drivers/clk/qcom/gcc-qdu1000.c
>> index 5051769ad90c..5d8125c0eacc 100644
>> --- a/drivers/clk/qcom/gcc-qdu1000.c
>> +++ b/drivers/clk/qcom/gcc-qdu1000.c
>> @@ -1,6 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /*
>> - * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>>    */
>>   #include <linux/clk-provider.h>
>> @@ -17,6 +17,7 @@
>>   #include "clk-regmap-divider.h"
>>   #include "clk-regmap-mux.h"
>>   #include "clk-regmap-phy-mux.h"
>> +#include "gdsc.h"
>>   #include "reset.h"
>>   enum {
>> @@ -370,16 +371,6 @@ static const struct clk_parent_data 
>> gcc_parent_data_6[] = {
>>       { .index = DT_TCXO_IDX },
>>   };
>> -static const struct parent_map gcc_parent_map_7[] = {
>> -    { P_PCIE_0_PIPE_CLK, 0 },
>> -    { P_BI_TCXO, 2 },
>> -};
>> -
>> -static const struct clk_parent_data gcc_parent_data_7[] = {
>> -    { .index = DT_PCIE_0_PIPE_CLK_IDX },
>> -    { .index = DT_TCXO_IDX },
>> -};
>> -
>>   static const struct parent_map gcc_parent_map_8[] = {
>>       { P_BI_TCXO, 0 },
>>       { P_GCC_GPLL0_OUT_MAIN, 1 },
>> @@ -439,16 +430,15 @@ static struct clk_regmap_mux 
>> gcc_pcie_0_phy_aux_clk_src = {
>>       },
>>   };
>> -static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
>> +static struct clk_regmap_phy_mux gcc_pcie_0_pipe_clk_src = {
>>       .reg = 0x9d064,
>> -    .shift = 0,
>> -    .width = 2,
>> -    .parent_map = gcc_parent_map_7,
>>       .clkr = {
>>           .hw.init = &(const struct clk_init_data) {
>>               .name = "gcc_pcie_0_pipe_clk_src",
>> -            .parent_data = gcc_parent_data_7,
>> -            .num_parents = ARRAY_SIZE(gcc_parent_data_7),
>> +            .parent_data = &(const struct clk_parent_data){
>> +                .index = DT_PCIE_0_PIPE_CLK_IDX,
>> +            },
>> +            .num_parents = 1,
>>               .ops = &clk_regmap_phy_mux_ops,
>>           },
>>       },
>> @@ -485,7 +475,7 @@ static struct clk_rcg2 
>> gcc_aggre_noc_ecpri_dma_clk_src = {
>>           .name = "gcc_aggre_noc_ecpri_dma_clk_src",
>>           .parent_data = gcc_parent_data_4,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_4),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
>> @@ -505,7 +495,7 @@ static struct clk_rcg2 
>> gcc_aggre_noc_ecpri_gsi_clk_src = {
>>           .name = "gcc_aggre_noc_ecpri_gsi_clk_src",
>>           .parent_data = gcc_parent_data_5,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_5),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
> 
> This is probably some kind of NoC or NIU clock. If it is not to be 
> touched by Linux, the recent clk_rcg2_ro_ops patch looks promising here.
> 

This is not a NoC or NIU clock and Linux will use this clock.

>>       },
>>   };
>> @@ -524,7 +514,7 @@ static struct clk_rcg2 gcc_gp1_clk_src = {
>>           .name = "gcc_gp1_clk_src",
>>           .parent_data = gcc_parent_data_1,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_1),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
> 
> But why? GP clocks are not shared.
> The 'why?' question applies to all such changes. As I wrote, please 
> split & describe the reason.
> 

We want to park all the RCGs at safe clock source (XO) during disable. 
Hence using the clk_rcg2_shared_ops for all the RCGs.

Will split and post the next patch series.

>>       },
>>   };
>> @@ -538,7 +528,7 @@ static struct clk_rcg2 gcc_gp2_clk_src = {
>>           .name = "gcc_gp2_clk_src",
>>           .parent_data = gcc_parent_data_1,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_1),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
>> @@ -552,7 +542,7 @@ static struct clk_rcg2 gcc_gp3_clk_src = {
>>           .name = "gcc_gp3_clk_src",
>>           .parent_data = gcc_parent_data_1,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_1),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
>> @@ -571,7 +561,7 @@ static struct clk_rcg2 gcc_pcie_0_aux_clk_src = {
>>           .name = "gcc_pcie_0_aux_clk_src",
>>           .parent_data = gcc_parent_data_3,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_3),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
>> @@ -591,7 +581,7 @@ static struct clk_rcg2 
>> gcc_pcie_0_phy_rchng_clk_src = {
>>           .name = "gcc_pcie_0_phy_rchng_clk_src",
>>           .parent_data = gcc_parent_data_0,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
>> @@ -610,7 +600,7 @@ static struct clk_rcg2 gcc_pdm2_clk_src = {
>>           .name = "gcc_pdm2_clk_src",
>>           .parent_data = gcc_parent_data_0,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
>> @@ -632,7 +622,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap0_s0_clk_src_init = {
>>       .name = "gcc_qupv3_wrap0_s0_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
>> @@ -648,7 +638,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap0_s1_clk_src_init = {
>>       .name = "gcc_qupv3_wrap0_s1_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src = {
>> @@ -664,7 +654,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap0_s2_clk_src_init = {
>>       .name = "gcc_qupv3_wrap0_s2_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src = {
>> @@ -680,7 +670,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap0_s3_clk_src_init = {
>>       .name = "gcc_qupv3_wrap0_s3_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src = {
>> @@ -696,7 +686,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap0_s4_clk_src_init = {
>>       .name = "gcc_qupv3_wrap0_s4_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src = {
>> @@ -717,7 +707,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap0_s5_clk_src_init = {
>>       .name = "gcc_qupv3_wrap0_s5_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src = {
>> @@ -733,7 +723,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap0_s6_clk_src_init = {
>>       .name = "gcc_qupv3_wrap0_s6_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s6_clk_src = {
>> @@ -749,7 +739,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap0_s7_clk_src_init = {
>>       .name = "gcc_qupv3_wrap0_s7_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s7_clk_src = {
>> @@ -765,7 +755,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap1_s0_clk_src_init = {
>>       .name = "gcc_qupv3_wrap1_s0_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src = {
>> @@ -781,7 +771,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap1_s1_clk_src_init = {
>>       .name = "gcc_qupv3_wrap1_s1_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src = {
>> @@ -797,7 +787,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap1_s2_clk_src_init = {
>>       .name = "gcc_qupv3_wrap1_s2_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s2_clk_src = {
>> @@ -813,7 +803,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap1_s3_clk_src_init = {
>>       .name = "gcc_qupv3_wrap1_s3_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src = {
>> @@ -829,7 +819,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap1_s4_clk_src_init = {
>>       .name = "gcc_qupv3_wrap1_s4_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src = {
>> @@ -845,7 +835,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap1_s5_clk_src_init = {
>>       .name = "gcc_qupv3_wrap1_s5_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src = {
>> @@ -861,7 +851,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap1_s6_clk_src_init = {
>>       .name = "gcc_qupv3_wrap1_s6_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s6_clk_src = {
>> @@ -877,7 +867,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap1_s7_clk_src_init = {
>>       .name = "gcc_qupv3_wrap1_s7_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s7_clk_src = {
>> @@ -913,7 +903,7 @@ static struct clk_rcg2 gcc_sdcc5_apps_clk_src = {
>>           .name = "gcc_sdcc5_apps_clk_src",
>>           .parent_data = gcc_parent_data_8,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_8),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_floor_ops,
>>       },
>>   };
>> @@ -932,7 +922,7 @@ static struct clk_rcg2 gcc_sdcc5_ice_core_clk_src = {
>>           .name = "gcc_sdcc5_ice_core_clk_src",
>>           .parent_data = gcc_parent_data_2,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_2),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_floor_ops,
>>       },
>>   };
>> @@ -946,7 +936,7 @@ static struct clk_rcg2 gcc_sm_bus_xo_clk_src = {
>>           .name = "gcc_sm_bus_xo_clk_src",
>>           .parent_data = gcc_parent_data_2,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_2),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
>> @@ -965,7 +955,7 @@ static struct clk_rcg2 gcc_tsc_clk_src = {
>>           .name = "gcc_tsc_clk_src",
>>           .parent_data = gcc_parent_data_9,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_9),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
>> @@ -985,7 +975,7 @@ static struct clk_rcg2 
>> gcc_usb30_prim_master_clk_src = {
>>           .name = "gcc_usb30_prim_master_clk_src",
>>           .parent_data = gcc_parent_data_0,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
>> @@ -999,7 +989,7 @@ static struct clk_rcg2 
>> gcc_usb30_prim_mock_utmi_clk_src = {
>>           .name = "gcc_usb30_prim_mock_utmi_clk_src",
>>           .parent_data = gcc_parent_data_0,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
>> @@ -1013,7 +1003,7 @@ static struct clk_rcg2 
>> gcc_usb3_prim_phy_aux_clk_src = {
>>           .name = "gcc_usb3_prim_phy_aux_clk_src",
>>           .parent_data = gcc_parent_data_3,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_3),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
>> @@ -1142,6 +1132,26 @@ static struct clk_branch 
>> gcc_ddrss_ecpri_dma_clk = {
>>       },
>>   };
>> +static struct clk_branch gcc_ddrss_ecpri_gsi_clk = {
>> +    .halt_reg = 0x54298,
>> +    .halt_check = BRANCH_HALT_VOTED,
>> +    .hwcg_reg = 0x54298,
>> +    .hwcg_bit = 1,
>> +    .clkr = {
>> +        .enable_reg = 0x54298,
>> +        .enable_mask = BIT(0),
>> +        .hw.init = &(const struct clk_init_data) {
>> +            .name = "gcc_ddrss_ecpri_gsi_clk",
>> +            .parent_hws = (const struct clk_hw*[]) {
>> +                &gcc_aggre_noc_ecpri_gsi_clk_src.clkr.hw,
>> +            },
>> +            .num_parents = 1,
>> +            .flags = CLK_SET_RATE_PARENT,
>> +            .ops = &clk_branch2_aon_ops,
>> +        },
>> +    },
>> +};
>> +
>>   static struct clk_branch gcc_ecpri_ahb_clk = {
>>       .halt_reg = 0x3a008,
>>       .halt_check = BRANCH_HALT_VOTED,
>> @@ -1458,14 +1468,13 @@ static struct clk_branch 
>> gcc_pcie_0_cfg_ahb_clk = {
>>   static struct clk_branch gcc_pcie_0_clkref_en = {
>>       .halt_reg = 0x9c004,
>> -    .halt_bit = 31,
> 
> Why?
> 

clk_branch2_ops doesn't require the halt_bit. Hence removed the same.

>>       .halt_check = BRANCH_HALT_ENABLE,
>>       .clkr = {
>>           .enable_reg = 0x9c004,
>>           .enable_mask = BIT(0),
>>           .hw.init = &(const struct clk_init_data) {
>>               .name = "gcc_pcie_0_clkref_en",
>> -            .ops = &clk_branch_ops,
>> +            .ops = &clk_branch2_ops,
> 
> Separate commit, Fixes tag.
> 

Sure, will push this change in a seperate commit in the next series.

>>           },
>>       },
>>   };
>> @@ -2285,14 +2294,13 @@ static struct clk_branch gcc_tsc_etu_clk = {
>>   static struct clk_branch gcc_usb2_clkref_en = {
>>       .halt_reg = 0x9c008,
>> -    .halt_bit = 31,
> 
> Why?
> 

clk_branch2_ops doesn't require the halt_bit. Hence removed the same.

>>       .halt_check = BRANCH_HALT_ENABLE,
>>       .clkr = {
>>           .enable_reg = 0x9c008,
>>           .enable_mask = BIT(0),
>>           .hw.init = &(const struct clk_init_data) {
>>               .name = "gcc_usb2_clkref_en",
>> -            .ops = &clk_branch_ops,
>> +            .ops = &clk_branch2_ops,
> 
> And here.
> 

Will push this change in a seperate commit in the next series.

>>           },
>>       },
>>   };
>> @@ -2402,6 +2410,39 @@ static struct clk_branch 
>> gcc_usb3_prim_phy_pipe_clk = {
>>       },
>>   };
>> +static struct gdsc pcie_0_gdsc = {
>> +    .gdscr = 0x9d004,
>> +    .en_rest_wait_val = 0x2,
>> +    .en_few_wait_val = 0x2,
>> +    .clk_dis_wait_val = 0xf,
>> +    .pd = {
>> +        .name = "gcc_pcie_0_gdsc",
>> +    },
>> +    .pwrsts = PWRSTS_OFF_ON,
>> +};
>> +
>> +static struct gdsc pcie_0_phy_gdsc = {
>> +    .gdscr = 0x7c004,
>> +    .en_rest_wait_val = 0x2,
>> +    .en_few_wait_val = 0x2,
>> +    .clk_dis_wait_val = 0x2,
>> +    .pd = {
>> +        .name = "gcc_pcie_0_phy_gdsc",
>> +    },
>> +    .pwrsts = PWRSTS_OFF_ON,
>> +};
>> +
>> +static struct gdsc usb30_prim_gdsc = {
>> +    .gdscr = 0x49004,
>> +    .en_rest_wait_val = 0x2,
>> +    .en_few_wait_val = 0x2,
>> +    .clk_dis_wait_val = 0xf,
>> +    .pd = {
>> +        .name = "gcc_usb30_prim_gdsc",
>> +    },
>> +    .pwrsts = PWRSTS_OFF_ON,
>> +};
>> +
>>   static struct clk_regmap *gcc_qdu1000_clocks[] = {
>>       [GCC_AGGRE_NOC_ECPRI_DMA_CLK] = &gcc_aggre_noc_ecpri_dma_clk.clkr,
>>       [GCC_AGGRE_NOC_ECPRI_DMA_CLK_SRC] = 
>> &gcc_aggre_noc_ecpri_dma_clk_src.clkr,
>> @@ -2534,6 +2575,14 @@ static struct clk_regmap *gcc_qdu1000_clocks[] = {
>>       [GCC_AGGRE_NOC_ECPRI_GSI_CLK] = &gcc_aggre_noc_ecpri_gsi_clk.clkr,
>>       [GCC_PCIE_0_PHY_AUX_CLK_SRC] = &gcc_pcie_0_phy_aux_clk_src.clkr,
>>       [GCC_PCIE_0_PIPE_CLK_SRC] = &gcc_pcie_0_pipe_clk_src.clkr,
>> +    [GCC_GPLL1_OUT_EVEN] = &gcc_gpll1_out_even.clkr,
>> +    [GCC_DDRSS_ECPRI_GSI_CLK] = NULL,
>> +};
>> +
>> +static struct gdsc *gcc_qdu1000_gdscs[] = {
>> +    [PCIE_0_GDSC] = &pcie_0_gdsc,
>> +    [PCIE_0_PHY_GDSC] = &pcie_0_phy_gdsc,
>> +    [USB30_PRIM_GDSC] = &usb30_prim_gdsc,
>>   };
>>   static const struct qcom_reset_map gcc_qdu1000_resets[] = {
>> @@ -2597,10 +2646,13 @@ static const struct qcom_cc_desc 
>> gcc_qdu1000_desc = {
>>       .num_clks = ARRAY_SIZE(gcc_qdu1000_clocks),
>>       .resets = gcc_qdu1000_resets,
>>       .num_resets = ARRAY_SIZE(gcc_qdu1000_resets),
>> +    .gdscs = gcc_qdu1000_gdscs,
>> +    .num_gdscs = ARRAY_SIZE(gcc_qdu1000_gdscs),
>>   };
>>   static const struct of_device_id gcc_qdu1000_match_table[] = {
>>       { .compatible = "qcom,qdu1000-gcc" },
>> +    { .compatible = "qcom,qdu1000-gcc-v2" },
> 
> What is the actual hardware version being shipped in the end-user 
> devices? Generally we do support only the latest hw revision. If you 
> want to support v1 for some reason, please invert the logic here:
> make "qcom,qdu1000-gcc" be the latest and grates and provide a reason 
> for supporting v1 (via "qcom,qdu1000-gcc-v1").
> 

Will update the next series with the changes to support only latest 
hardware version.

Thanks,
Imran

>>       { }
>>   };
>>   MODULE_DEVICE_TABLE(of, gcc_qdu1000_match_table);
>> @@ -2617,6 +2669,12 @@ static int gcc_qdu1000_probe(struct 
>> platform_device *pdev)
>>       /* Update FORCE_MEM_CORE_ON for gcc_pcie_0_mstr_axi_clk */
>>       regmap_update_bits(regmap, 0x9d024, BIT(14), BIT(14));
>> +    if (of_device_is_compatible(pdev->dev.of_node, 
>> "qcom,qdu1000-gcc-v2")) {
>> +        gcc_qdu1000_clocks[GCC_DDRSS_ECPRI_GSI_CLK] = 
>> &gcc_ddrss_ecpri_gsi_clk.clkr;
>> +        gcc_pcie_0_clkref_en.halt_check = BRANCH_HALT_DELAY;
>> +        gcc_usb2_clkref_en.halt_check = BRANCH_HALT_DELAY;
>> +    }
>> +
>>       ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
>>                          ARRAY_SIZE(gcc_dfs_clocks));
>>       if (ret)
> 
