Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476A7711146
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239296AbjEYQsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjEYQsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:48:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C17198;
        Thu, 25 May 2023 09:48:03 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PFTP8P004878;
        Thu, 25 May 2023 16:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=r8SJZaREmvE27qw5TAXmQKP4A9B8ScnCqRpG1rQr450=;
 b=JYw9flaiN56t79m9OX4apBmzykg8zc9CkLC7Dd10dhas5ufir/Xf/hGs3bpLriDfDCxi
 sd+Hv0OJSJYpNK2DO56qusxs+Cy3XqfS6G0qTdwEAnh8Tb1Usy8NM7lZlxSFKdm08jRt
 ScW2ko/VLMtlIdOSMBNZ8CJI0K9CasX0AVaexvgvDJID3bHmh/DOVRjq9kcLHaRhtkzU
 Y9xVxHDRB3F5xexH6TsU7Wq8KnTKns15zgo98LIJ3dmEuAMm9xAill0tNz6ZqGf6HId+
 gSTRgUSDKlV9MbFvsNay4GwF2ARmPUHQYx/UpATlmRtp2RRl3NP29eUDtyNChcd6b8yf gQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qsuc223wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 16:48:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34PGlx0Y013777
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 16:47:59 GMT
Received: from [10.216.52.104] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 09:47:50 -0700
Message-ID: <4a5b596d-e404-30b5-6c14-c093420e15bb@quicinc.com>
Date:   Thu, 25 May 2023 22:17:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/4] clk: qcom: camcc-sm8550: Add camera clock controller
 driver for SM8550
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        <quic_imrashai@quicinc.com>, <quic_ajipan@quicinc.com>
References: <20230519155602.6642-1-quic_jkona@quicinc.com>
 <20230519155602.6642-4-quic_jkona@quicinc.com>
 <f78d73b3-5cec-ca0e-fceb-b70f52fee29b@linaro.org>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <f78d73b3-5cec-ca0e-fceb-b70f52fee29b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZzXqzZpt5CIjkw5eCsA_TyWZPbnij8aN
X-Proofpoint-GUID: ZzXqzZpt5CIjkw5eCsA_TyWZPbnij8aN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_09,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250139
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

Thanks for your review!

On 5/19/2023 10:22 PM, Konrad Dybcio wrote:
> 
> 
> On 19.05.2023 17:56, Jagadeesh Kona wrote:
>> Add support for the camera clock controller for camera clients to be
>> able to request for camcc clocks on SM8550 platform.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> ---
>>   drivers/clk/qcom/Kconfig        |    7 +
>>   drivers/clk/qcom/Makefile       |    1 +
>>   drivers/clk/qcom/camcc-sm8550.c | 3572 +++++++++++++++++++++++++++++++
>>   3 files changed, 3580 insertions(+)
>>   create mode 100644 drivers/clk/qcom/camcc-sm8550.c
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 6bb9b4aff047..c8eccd428736 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -700,6 +700,13 @@ config SM_CAMCC_8450
>>   	  Support for the camera clock controller on SM8450 devices.
>>   	  Say Y if you want to support camera devices and camera functionality.
>>   
>> +config SM_CAMCC_8550
>> +	tristate "SM8550 Camera Clock Controller"
>> +	select SM_GCC_8550
>> +	help
>> +	  Support for the camera clock controller on SM8550 devices.
>> +	  Say Y if you want to support camera devices and camera functionality.
>> +
>>   config SM_DISPCC_6115
>>   	tristate "SM6115 Display Clock Controller"
>>   	depends on SM_GCC_6115
>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>> index f0b95fc217aa..2b1fcd5c920a 100644
>> --- a/drivers/clk/qcom/Makefile
>> +++ b/drivers/clk/qcom/Makefile
>> @@ -100,6 +100,7 @@ obj-$(CONFIG_SDX_GCC_65) += gcc-sdx65.o
>>   obj-$(CONFIG_SM_CAMCC_6350) += camcc-sm6350.o
>>   obj-$(CONFIG_SM_CAMCC_8250) += camcc-sm8250.o
>>   obj-$(CONFIG_SM_CAMCC_8450) += camcc-sm8450.o
>> +obj-$(CONFIG_SM_CAMCC_8550) += camcc-sm8550.o
>>   obj-$(CONFIG_SM_DISPCC_6115) += dispcc-sm6115.o
>>   obj-$(CONFIG_SM_DISPCC_6125) += dispcc-sm6125.o
>>   obj-$(CONFIG_SM_DISPCC_6350) += dispcc-sm6350.o
>> diff --git a/drivers/clk/qcom/camcc-sm8550.c b/drivers/clk/qcom/camcc-sm8550.c
>> new file mode 100644
>> index 000000000000..2c3d2436da0f
>> --- /dev/null
>> +++ b/drivers/clk/qcom/camcc-sm8550.c
>> @@ -0,0 +1,3572 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/regmap.h>
>> +
>> +#include <dt-bindings/clock/qcom,sm8550-camcc.h>
>> +
>> +#include "clk-alpha-pll.h"
>> +#include "clk-branch.h"
>> +#include "clk-rcg.h"
>> +#include "clk-regmap.h"
>> +#include "common.h"
>> +#include "gdsc.h"
>> +#include "reset.h"
>> +
>> +enum {
>> +	DT_BI_TCXO,
>> +	DT_BI_TCXO_AO,
>> +	DT_SLEEP_CLK,
>> +};
>> +
>> +enum {
>> +	P_BI_TCXO,
>> +	P_CAM_CC_PLL0_OUT_EVEN,
>> +	P_CAM_CC_PLL0_OUT_MAIN,
>> +	P_CAM_CC_PLL0_OUT_ODD,
>> +	P_CAM_CC_PLL10_OUT_EVEN,
>> +	P_CAM_CC_PLL11_OUT_EVEN,
>> +	P_CAM_CC_PLL12_OUT_EVEN,
> While it makes sense for a computer, I think it would make more
> sense to keep the >=10 entries after 9
> 
Yes, will take care of this in next series

>> +	P_CAM_CC_PLL1_OUT_EVEN,
>> +	P_CAM_CC_PLL2_OUT_EVEN,
>> +	P_CAM_CC_PLL2_OUT_MAIN,
>> +	P_CAM_CC_PLL3_OUT_EVEN,
>> +	P_CAM_CC_PLL4_OUT_EVEN,
>> +	P_CAM_CC_PLL5_OUT_EVEN,
>> +	P_CAM_CC_PLL6_OUT_EVEN,
>> +	P_CAM_CC_PLL7_OUT_EVEN,
>> +	P_CAM_CC_PLL8_OUT_EVEN,
>> +	P_CAM_CC_PLL9_OUT_EVEN,
>> +	P_CAM_CC_PLL9_OUT_ODD,
>> +	P_SLEEP_CLK,
>> +};
>> +
>> +static const struct pll_vco lucid_ole_vco[] = {
>> +	{ 249600000, 2300000000, 0 },
>> +};
>> +
>> +static const struct pll_vco rivian_ole_vco[] = {
>> +	{ 777000000, 1285000000, 0 },
>> +};
>> +
>> +static const struct alpha_pll_config cam_cc_pll0_config = {
>> +	.l = 0x4400003E,
> Lowercase hex, everywhere, please.
> 
Will take care of this in next series
>> +	.alpha = 0x8000,
>> +	.config_ctl_val = 0x20485699,
>> +	.config_ctl_hi_val = 0x00182261,
>> +	.config_ctl_hi1_val = 0x82AA299C,
>> +	.test_ctl_val = 0x00000000,
>> +	.test_ctl_hi_val = 0x00000003,
>> +	.test_ctl_hi1_val = 0x00009000,
>> +	.test_ctl_hi2_val = 0x00000034,
>> +	.user_ctl_val = 0x00008400,
>> +	.user_ctl_hi_val = 0x00000005,
>> +};
>> +
> [...]
> 
>> +
>> +	clk_lucid_ole_pll_configure(&cam_cc_pll0, regmap, &cam_cc_pll0_config);
>> +	clk_lucid_ole_pll_configure(&cam_cc_pll1, regmap, &cam_cc_pll1_config);
>> +	clk_lucid_ole_pll_configure(&cam_cc_pll10, regmap, &cam_cc_pll10_config);
> Same as the first comment
> 
Will take care in next series
> Konrad
>> +	clk_lucid_ole_pll_configure(&cam_cc_pll11, regmap, &cam_cc_pll11_config);
>> +	clk_lucid_ole_pll_configure(&cam_cc_pll12, regmap, &cam_cc_pll12_config);
>> +	clk_rivian_ole_pll_configure(&cam_cc_pll2, regmap, &cam_cc_pll2_config);
>> +	clk_lucid_ole_pll_configure(&cam_cc_pll3, regmap, &cam_cc_pll3_config);
>> +	clk_lucid_ole_pll_configure(&cam_cc_pll4, regmap, &cam_cc_pll4_config);
>> +	clk_lucid_ole_pll_configure(&cam_cc_pll5, regmap, &cam_cc_pll5_config);
>> +	clk_lucid_ole_pll_configure(&cam_cc_pll6, regmap, &cam_cc_pll6_config);
>> +	clk_lucid_ole_pll_configure(&cam_cc_pll7, regmap, &cam_cc_pll7_config);
>> +	clk_lucid_ole_pll_configure(&cam_cc_pll8, regmap, &cam_cc_pll8_config);
>> +	clk_lucid_ole_pll_configure(&cam_cc_pll9, regmap, &cam_cc_pll9_config);
>> +
[skipped]
>> +MODULE_DESCRIPTION("QTI CAM_CC SM8550 Driver");
>> +MODULE_LICENSE("GPL");

Thanks & Regards,
Jagadeesh
