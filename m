Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEEE6FCC83
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjEIRQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjEIRQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:16:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3481E71;
        Tue,  9 May 2023 10:16:48 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349Gg89T012569;
        Tue, 9 May 2023 17:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qI45RyaeiSVGGtld+kEpMAI9UE2lNL2CaZZmt75kPww=;
 b=VAnJdxSeXAFHP4N0fq0UrtckJJLNGGoDPTSl4FXeAIqLAs/blbNIaQDUENCbtqAnPDG1
 1M4wAd6UMvwn0LUaST+GT3HL0i1j5feb424eEgg7YH+Yyud43BZuzXpSDFk67tiRYp1W
 nyeStaIP3EYMhZ1lvqG6oJYq6AwA7gxwiZSJ/7ydsHKc3fejrm2RK640dqk0te0iAYJq
 FfCBQtDhVm0HpRX+08EJygPebUWvL4b3MuRrfiZ44NOhgmwsva/4UQju+gbpEeIT6TR3
 gkEd2Y5ld3JKvUK434++4COb28/4AhgrAo6zByRwgrDaI22xAGzcVtzsbioTeHOof4Xk tQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qfrvm07k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 17:03:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 349H35FJ030496
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 17:03:05 GMT
Received: from [10.216.5.187] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 9 May 2023
 10:02:57 -0700
Message-ID: <5d719c21-7820-b67f-ba63-adee0431cae7@quicinc.com>
Date:   Tue, 9 May 2023 22:32:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 06/11] clk: qcom: IPQ9574: Add q6/wcss clocks
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <mathieu.poirier@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_gurus@quicinc.com>,
        <loic.poulain@linaro.org>, <quic_eberman@quicinc.com>,
        <robimarko@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_gokulsri@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-7-git-send-email-quic_mmanikan@quicinc.com>
 <3298e7f6-ec63-077e-7dc9-2243670bc026@quicinc.com>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <3298e7f6-ec63-077e-7dc9-2243670bc026@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fjcwsU8JXGhDunl7NH2vLhH2qz6N5A7K
X-Proofpoint-GUID: fjcwsU8JXGhDunl7NH2vLhH2qz6N5A7K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=903 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090141
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/2023 12:58 PM, Sricharan Ramabadhran wrote:
> 
> 
> On 3/7/2023 10:11 AM, Manikanta Mylavarapu wrote:
>> Some of the clocks required for q6/wcss bring up
>> are missing. So this patch adds clocks.
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>>   drivers/clk/qcom/gcc-ipq9574.c | 119 +++++++++++++++++++++++++++++++++
>>   1 file changed, 119 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/gcc-ipq9574.c 
>> b/drivers/clk/qcom/gcc-ipq9574.c
>> index 1bf33d582dc2..355f2e12d9c6 100644
>> --- a/drivers/clk/qcom/gcc-ipq9574.c
>> +++ b/drivers/clk/qcom/gcc-ipq9574.c
>> @@ -2697,6 +2697,22 @@ static struct clk_branch gcc_wcss_acmt_clk = {
>>       },
>>   };
>> +static struct clk_branch gcc_wcss_ahb_s_clk = {
>> +    .halt_reg = 0x25060,
>> +    .clkr = {
>> +        .enable_reg = 0x25060,
>> +        .enable_mask = BIT(0),
>> +        .hw.init = &(struct clk_init_data){
>> +            .name = "gcc_wcss_ahb_s_clk",
>> +            .parent_hws = (const struct clk_hw *[]){
>> +                    &wcss_ahb_clk_src.clkr.hw },
>> +            .num_parents = 1,
>> +            .flags = CLK_SET_RATE_PARENT,
>> +            .ops = &clk_branch2_ops,
>> +        },
>> +    },
>> +};
>> +
>>   static struct clk_branch gcc_sys_noc_wcss_ahb_clk = {
>>       .halt_reg = 0x2e030,
>>       .clkr = {
>> @@ -2734,6 +2750,22 @@ static struct clk_rcg2 wcss_axi_m_clk_src = {
>>       },
>>   };
>> +static struct clk_branch gcc_wcss_axi_m_clk = {
>> +    .halt_reg = 0x25064,
>> +    .clkr = {
>> +        .enable_reg = 0x25064,
>> +        .enable_mask = BIT(0),
>> +        .hw.init = &(struct clk_init_data){
>> +            .name = "gcc_wcss_axi_m_clk",
>> +            .parent_hws = (const struct clk_hw *[]){
>> +                    &wcss_axi_m_clk_src.clkr.hw },
>> +            .num_parents = 1,
>> +            .flags = CLK_SET_RATE_PARENT,
>> +            .ops = &clk_branch2_ops,
>> +        },
>> +    },
>> +};
>> +
>>   static struct clk_branch gcc_anoc_wcss_axi_m_clk = {
>>       .halt_reg = 0x2e0a8,
>>       .clkr = {
>> @@ -2803,6 +2835,22 @@ static struct clk_branch 
>> gcc_wcss_dbg_ifc_atb_clk = {
>>       },
>>   };
>> +static struct clk_branch gcc_wcss_dbg_ifc_atb_bdg_clk = {
>> +    .halt_reg = 0x2504C,
>> +    .clkr = {
>> +        .enable_reg = 0x2504C,
>> +        .enable_mask = BIT(0),
>> +        .hw.init = &(struct clk_init_data){
>> +            .name = "gcc_wcss_dbg_ifc_atb_bdg_clk",
>> +            .parent_hws = (const struct clk_hw *[]){
>> +                    &qdss_at_clk_src.clkr.hw },
>> +            .num_parents = 1,
>> +            .flags = CLK_SET_RATE_PARENT,
>> +            .ops = &clk_branch2_ops,
>> +        },
>> +    },
>> +};
>> +
>>   static struct clk_branch gcc_nssnoc_atb_clk = {
>>       .halt_reg = 0x17014,
>>       .clkr = {
>> @@ -3073,6 +3121,22 @@ static struct clk_branch 
>> gcc_wcss_dbg_ifc_nts_clk = {
>>       },
>>   };
>> +static struct clk_branch gcc_wcss_dbg_ifc_nts_bdg_clk = {
>> +    .halt_reg = 0x25050,
>> +    .clkr = {
>> +        .enable_reg = 0x25050,
>> +        .enable_mask = BIT(0),
>> +        .hw.init = &(struct clk_init_data){
>> +            .name = "gcc_wcss_dbg_ifc_nts_bdg_clk",
>> +            .parent_hws = (const struct clk_hw *[]){
>> +                    &qdss_tsctr_div2_clk_src.hw },
>> +            .num_parents = 1,
>> +            .flags = CLK_SET_RATE_PARENT,
>> +            .ops = &clk_branch2_ops,
>> +        },
>> +    },
>> +};
>> +
>>   static struct clk_branch gcc_qdss_tsctr_div2_clk = {
>>       .halt_reg = 0x2d044,
>>       .clkr = {
>> @@ -3315,6 +3379,38 @@ static struct clk_branch 
>> gcc_wcss_dbg_ifc_dapbus_clk = {
>>       },
>>   };
>> +static struct clk_branch gcc_wcss_dbg_ifc_apb_bdg_clk = {
>> +    .halt_reg = 0x25048,
>> +    .clkr = {
>> +        .enable_reg = 0x25048,
>> +        .enable_mask = BIT(0),
>> +        .hw.init = &(struct clk_init_data){
>> +            .name = "gcc_wcss_dbg_ifc_apb_bdg_clk",
>> +            .parent_hws = (const struct clk_hw *[]){
>> +                    &qdss_dap_sync_clk_src.hw },
>> +            .num_parents = 1,
>> +            .flags = CLK_SET_RATE_PARENT,
>> +            .ops = &clk_branch2_ops,
>> +        },
>> +    },
>> +};
>> +
>> +static struct clk_branch gcc_wcss_dbg_ifc_dapbus_bdg_clk = {
>> +    .halt_reg = 0x25054,
>> +    .clkr = {
>> +        .enable_reg = 0x25054,
>> +        .enable_mask = BIT(0),
>> +        .hw.init = &(struct clk_init_data){
>> +            .name = "gcc_wcss_dbg_ifc_dapbus_bdg_clk",
>> +            .parent_hws = (const struct clk_hw *[]){
>> +                    &qdss_dap_sync_clk_src.hw },
>> +            .num_parents = 1,
>> +            .flags = CLK_SET_RATE_PARENT,
>> +            .ops = &clk_branch2_ops,
>> +        },
>> +    },
>> +};
>> +
>>   static struct clk_branch gcc_qdss_dap_clk = {
>>       .halt_reg = 0x2d058,
>>       .clkr = {
>> @@ -3513,6 +3609,22 @@ static struct clk_rcg2 q6_axim2_clk_src = {
>>       },
>>   };
>> +static struct clk_branch gcc_q6_axim2_clk = {
>> +    .halt_reg = 0x25010,
>> +    .clkr = {
>> +        .enable_reg = 0x25010,
>> +        .enable_mask = BIT(0),
>> +        .hw.init = &(struct clk_init_data){
>> +            .name = "gcc_q6_axim2_clk",
>> +            .parent_hws = (const struct clk_hw *[]){
>> +                    &q6_axim2_clk_src.clkr.hw },
>> +            .num_parents = 1,
>> +            .flags = CLK_SET_RATE_PARENT,
>> +            .ops = &clk_branch2_ops,
>> +        },
>> +    },
>> +};
>> +
> 
> These clocks does not seem to be used in the driver, where are they used ?
> 
> Regards,
>   Sricharan
Clocks in multipd architecture will be handled by QDSP6 firmware.
So i am going to remove clock handling and drop this patch.

Thanks & Regards,
Manikanta.
