Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9395467D20B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjAZQpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjAZQpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:45:36 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912364EE1;
        Thu, 26 Jan 2023 08:45:35 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QGjC0r027852;
        Thu, 26 Jan 2023 16:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0DhafgZeBu6HoCEQt1MHmaUDfE+Qyo6YP+SijjNjXz0=;
 b=UGeVHheLaY+xz1iWUuxipjPRsekOxBu8ossFpFVG1PLVOysG3kCHcXA/IfN8WSUo6lfI
 kNm/NQ/u1aiKClA3dWec7isCoPN1f1NkDTDj+wAGJKtUZ4GVCeWMA1t7xioupJGDeZRw
 ShjFY5fOJqG3Qbf6nq1bSj4z0+ZyPb8qSG60SYpv4VKg8YPH/GDa6xn3UAaGH6wh0tSh
 9dSZV+tOwSAf25ohsT/++wB9dvn1JKq8CzBHXG2CSkXd9UnICdYSIXb1Ep8QTZECb3V1
 Nfi44kraf+VH3/GCmJ0QrGZz7rXhJ40FJnVV01slM/D4abs99DROAIH9SvyIiS0RjWiO RA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nasr0kkq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 16:45:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30QGjBVv020425
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 16:45:11 GMT
Received: from [10.50.43.212] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 26 Jan
 2023 08:45:03 -0800
Message-ID: <37fccf60-75e7-3170-4e63-cafa62777596@quicinc.com>
Date:   Thu, 26 Jan 2023 22:15:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 05/10] clk: qcom: add Global Clock controller (GCC) driver
 for IPQ5332 SoC
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <arnd@arndb.de>,
        <bhupesh.sharma@linaro.org>, <broonie@kernel.org>,
        <catalin.marinas@arm.com>, <devicetree@vger.kernel.org>,
        <dmitry.baryshkov@linaro.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <marcel.ziswiler@toradex.com>,
        <mturquette@baylibre.com>, <nfraprado@collabora.com>,
        <quic_gurus@quicinc.com>, <robh+dt@kernel.org>,
        <robimarko@gmail.com>, <shawnguo@kernel.org>,
        <ulf.hansson@linaro.org>, <will@kernel.org>
References: <20230125104520.89684-1-quic_kathirav@quicinc.com>
 <20230125104520.89684-6-quic_kathirav@quicinc.com>
 <9cf8a94f7ec4d8912bcf507631991999.sboyd@kernel.org>
Content-Language: en-US
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <9cf8a94f7ec4d8912bcf507631991999.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8YFMf9iChCf7TO-g8rvLTswHK1rj14mB
X-Proofpoint-ORIG-GUID: 8YFMf9iChCf7TO-g8rvLTswHK1rj14mB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_07,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301260162
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/26/2023 2:24 AM, Stephen Boyd wrote:
> Quoting Kathiravan Thirumoorthy (2023-01-25 02:45:15)
>> diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
>> new file mode 100644
>> index 000000000000..8351096a4d32
>> --- /dev/null
>> +++ b/drivers/clk/qcom/gcc-ipq5332.c
>> @@ -0,0 +1,3954 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/regmap.h>
> [...]
>> +
>> +static const struct freq_tbl ftbl_gcc_pcnoc_bfdcd_clk_src[] = {
>> +       F(24000000, P_XO, 1, 0, 0),
>> +       F(50000000, P_GPLL0_OUT_MAIN, 16, 0, 0),
>> +       F(100000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
>> +       { }
>> +};
>> +
>> +static struct clk_rcg2 gcc_pcnoc_bfdcd_clk_src = {
>> +       .cmd_rcgr = 0x31004,
>> +       .mnd_width = 0,
>> +       .hid_width = 5,
>> +       .parent_map = gcc_parent_map_0,
>> +       .freq_tbl = ftbl_gcc_pcnoc_bfdcd_clk_src,
>> +       .clkr.hw.init = &(const struct clk_init_data){
>> +               .name = "gcc_pcnoc_bfdcd_clk_src",
>> +               .parent_data = gcc_parent_data_0,
>> +               .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +               .ops = &clk_rcg2_ops,
>> +               .flags = CLK_IS_CRITICAL,
> Why not just turn these clks on in probe and never register them with
> the framework? That saves some memory for clks that there is no desire
> to control from linux. This is an RCG, so in theory the frequency can
> change, but does it really? Usually bus clks are controlled by the
> interconnect driver.

Thanks Stephen for reviewing the patch. I will look into this and make 
changes appropriately in V2.

