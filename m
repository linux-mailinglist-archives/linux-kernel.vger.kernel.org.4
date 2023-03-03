Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9154D6A939A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjCCJSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjCCJSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:18:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE24EB50;
        Fri,  3 Mar 2023 01:18:43 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3236akCa013897;
        Fri, 3 Mar 2023 09:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gUI1yC+uuduVJlDVD0QE0jzuVzJYjKZBctyZzQ2MU0M=;
 b=h9g22qFZ7VGeHOHwEIPQVx0ZtZofd9KwsZxXCqkFECpBy+6oZbChAcWwR8/O11Kgt4ti
 m6qv9gRYE0iPHURJ2/Ealb5j03P3WsaXsZqBnpwdFEC8qsIbL99F7vhh9q43zZw/9Ksq
 o1xtCVSa2N1kgkkBbyJLBXc9pnCuqt7U6T1DTQyOBcUdO2GJ2h60GVITyPAXZsZ9UpLX
 E6NpTF5MO4zIyNQdVNJBsxgUdkwqo47Qx1Dx6kamRY7z35m0phbgZEPkIU4h7ha3wMqT
 Nb+8b3l6IJamgMzYRBcGMPpXEZYq6Zxl5XMKgJfqg7o3mmud+8kgu4ZfgfcEELMvVXFQ IA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p3bry8c0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 09:18:40 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3239Id78008215
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Mar 2023 09:18:39 GMT
Received: from [10.50.35.127] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 3 Mar 2023
 01:18:35 -0800
Message-ID: <72a83822-b2e1-eac8-4e0d-54e34a405867@quicinc.com>
Date:   Fri, 3 Mar 2023 14:48:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 4/8] clk: qcom: gcc-ipq9574: Add USB related clocks
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <cover.1677749625.git.quic_varada@quicinc.com>
 <07ea204c6488e7e78956bca09f59bf9c49353780.1677749625.git.quic_varada@quicinc.com>
 <CAA8EJpoyKB3AqvA6R06L9K_dYc97+JK3SwY5TKR1FiC30w8=Yw@mail.gmail.com>
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <CAA8EJpoyKB3AqvA6R06L9K_dYc97+JK3SwY5TKR1FiC30w8=Yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eAC7hBEXw49TSXVOr879JPj-4oQOMTXZ
X-Proofpoint-ORIG-GUID: eAC7hBEXw49TSXVOr879JPj-4oQOMTXZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030082
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/2/2023 9:54 PM, Dmitry Baryshkov wrote:
> On Thu, 2 Mar 2023 at 11:56, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
>> Add the clocks needed for enabling USB in IPQ9574
>>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> ---
>>   drivers/clk/qcom/gcc-ipq9574.c               | 35 ++++++++++++++++++++++++++++
>>   include/dt-bindings/clock/qcom,ipq9574-gcc.h |  2 ++
>>   2 files changed, 37 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
>> index 1bf33d5..85cc6a5 100644
>> --- a/drivers/clk/qcom/gcc-ipq9574.c
>> +++ b/drivers/clk/qcom/gcc-ipq9574.c
>> @@ -2041,6 +2041,39 @@ static struct clk_regmap_mux usb0_pipe_clk_src = {
>>          },
>>   };
>>
>> +static struct clk_branch gcc_usb0_pipe_clk = {
>> +       .halt_reg = 0x2c054,
>> +       .halt_check = BRANCH_HALT_DELAY,
>> +       .clkr = {
>> +               .enable_reg = 0x2c054,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "gcc_usb0_pipe_clk",
>> +                       .parent_hws = (const struct clk_hw *[]){
>> +                               &usb0_pipe_clk_src.clkr.hw },
> Please move the closing bracket to the next line.

Sure. Will post a revised patch.

Thanks

Varada

>
>> +                       .num_parents = 1,
>> +                       .flags = CLK_SET_RATE_PARENT,
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch gcc_usb0_sleep_clk = {
>> +       .halt_reg = 0x2c058,
>> +       .clkr = {
>> +               .enable_reg = 0x2c058,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "gcc_usb0_sleep_clk",
>> +                       .parent_hws = (const struct clk_hw *[]){
>> +                               &gcc_sleep_clk_src.clkr.hw },
>> +                       .num_parents = 1,
>> +                       .flags = CLK_SET_RATE_PARENT,
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>>   static const struct freq_tbl ftbl_sdcc_apps_clk_src[] = {
>>          F(144000, P_XO, 16, 12, 125),
>>          F(400000, P_XO, 12, 1, 5),
>> @@ -4008,6 +4041,8 @@ static struct clk_regmap *gcc_ipq9574_clks[] = {
>>          [GCC_USB0_MOCK_UTMI_CLK] = &gcc_usb0_mock_utmi_clk.clkr,
>>          [USB0_PIPE_CLK_SRC] = &usb0_pipe_clk_src.clkr,
>>          [GCC_USB0_PHY_CFG_AHB_CLK] = &gcc_usb0_phy_cfg_ahb_clk.clkr,
>> +       [GCC_USB0_PIPE_CLK] = &gcc_usb0_pipe_clk.clkr,
>> +       [GCC_USB0_SLEEP_CLK] = &gcc_usb0_sleep_clk.clkr,
>>          [SDCC1_APPS_CLK_SRC] = &sdcc1_apps_clk_src.clkr,
>>          [GCC_SDCC1_APPS_CLK] = &gcc_sdcc1_apps_clk.clkr,
>>          [SDCC1_ICE_CORE_CLK_SRC] = &sdcc1_ice_core_clk_src.clkr,
>> diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
>> index c89e96d..96b7c0b 100644
>> --- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
>> +++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
>> @@ -214,4 +214,6 @@
>>   #define GCC_SNOC_PCIE1_1LANE_S_CLK                     205
>>   #define GCC_SNOC_PCIE2_2LANE_S_CLK                     206
>>   #define GCC_SNOC_PCIE3_2LANE_S_CLK                     207
>> +#define GCC_USB0_PIPE_CLK                              208
>> +#define GCC_USB0_SLEEP_CLK                             209
>>   #endif
>> --
>> 2.7.4
>>
>
