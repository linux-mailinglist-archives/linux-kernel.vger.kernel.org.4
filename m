Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59296FC2B2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbjEIJXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbjEIJWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:22:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD76106C0;
        Tue,  9 May 2023 02:21:57 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34960gdo009077;
        Tue, 9 May 2023 09:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jtmJ+i5HRbbl60SILuYyyKayi/NHpbtpA/qZRIgVTOE=;
 b=M+vmu4xLI+hClmS4gImODLNogxYXwFMWwvDKZh+rYvgMqkhqENmZZGmh/a7J13ywZDFI
 2n9SqgtUoW5KB5AO7WsOgJKSR5F4j1Ff6nHsBSzGEc/jVtEnju0jmiuvJ3p2u5Bodr40
 Xtp6hyKLUtO9KkXnZG2TBDC0LBFSYh4X3lX/KcLc5WsCr+vYJCoxgiO+yVuDnoZO00P5
 rAsf8pJ6m6ILvTLJgyyiZFK/o9QHrQTbq/gt7yI9eTTBmy1fIkqAIBvyv8pDn67/5fRH
 oRnAwtk+Ar3mzUoDRgUw5ToS8GGmcitXNWLTX2rgevDesdlrKR1CBF6OcDpzWS3v4bf2 FQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf78899hd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 09:21:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3499LWZm031511
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 09:21:32 GMT
Received: from [10.216.33.39] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 9 May 2023
 02:21:28 -0700
Message-ID: <721ee430-a8d8-eb60-889e-ee28bf179eb8@quicinc.com>
Date:   Tue, 9 May 2023 14:51:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V3 2/3] clk: qcom: videocc-sm8450: Add video clock
 controller driver for SM8450
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>
CC:     Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_skakitap@quicinc.com>, <quic_jkona@quicinc.com>
References: <20230503105937.24911-1-quic_tdas@quicinc.com>
 <20230503105937.24911-3-quic_tdas@quicinc.com>
 <4c09119e-2a18-d98f-d3ee-9b88e1b87d8e@linaro.org>
From:   Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <4c09119e-2a18-d98f-d3ee-9b88e1b87d8e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HTDy6mpjawZUzcEqnKBe72Of52L3vk93
X-Proofpoint-GUID: HTDy6mpjawZUzcEqnKBe72Of52L3vk93
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_05,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 mlxscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090072
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your review.

On 5/4/2023 1:14 PM, Konrad Dybcio wrote:
> 
> 
> On 3.05.2023 12:59, Taniya Das wrote:
>> Add support for the video clock controller driver for peripheral clock
>> clients to be able to request for video cc clocks.
>>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> ---
>> Changes since V2:
>>   - Update the header file name to match the latest upstream header
>>     files.
>>
>> Changes since V1:
>>   - Use DT indices instead of fw_name.
>>   - Replace pm_runtime_enable with devm_pm_runtime_enable.
>>   - Change license to GPL from GPL V2.
>>
>>   drivers/clk/qcom/Kconfig          |   9 +
>>   drivers/clk/qcom/Makefile         |   1 +
>>   drivers/clk/qcom/videocc-sm8450.c | 459 ++++++++++++++++++++++++++++++
>>   3 files changed, 469 insertions(+)
>>   create mode 100644 drivers/clk/qcom/videocc-sm8450.c
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 12be3e2371b3..927aa5983464 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -962,4 +962,13 @@ config CLK_GFM_LPASS_SM8250
>>   	  Support for the Glitch Free Mux (GFM) Low power audio
>>             subsystem (LPASS) clocks found on SM8250 SoCs.
>>   
>> +config SM_VIDEOCC_8450
>> +	tristate "SM8450 Video Clock Controller"
>> +	select SM_GCC_8450
>> +	select QCOM_GDSC
>> +	help
>> +	  Support for the video clock controller on Qualcomm Technologies, Inc.
>> +	  SM8450 devices.
>> +	  Say Y if you want to support video devices and functionality such as
>> +	  video encode/decode.
>>   endif
>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>> index 9ff4c373ad95..1960ad8e8713 100644
>> --- a/drivers/clk/qcom/Makefile
>> +++ b/drivers/clk/qcom/Makefile
>> @@ -127,6 +127,7 @@ obj-$(CONFIG_SM_GPUCC_8350) += gpucc-sm8350.o
>>   obj-$(CONFIG_SM_TCSRCC_8550) += tcsrcc-sm8550.o
>>   obj-$(CONFIG_SM_VIDEOCC_8150) += videocc-sm8150.o
>>   obj-$(CONFIG_SM_VIDEOCC_8250) += videocc-sm8250.o
>> +obj-$(CONFIG_SM_VIDEOCC_8450) += videocc-sm8450.o
>>   obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
>>   obj-$(CONFIG_KPSS_XCC) += kpss-xcc.o
>>   obj-$(CONFIG_QCOM_HFPLL) += hfpll.o
>> diff --git a/drivers/clk/qcom/videocc-sm8450.c b/drivers/clk/qcom/videocc-sm8450.c
>> new file mode 100644
>> index 000000000000..ce0ab764eb35
>> --- /dev/null
>> +++ b/drivers/clk/qcom/videocc-sm8450.c
>> @@ -0,0 +1,459 @@
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
>> +#include <dt-bindings/clock/qcom,sm8450-videocc.h>
>> +
>> +#include "clk-alpha-pll.h"
>> +#include "clk-branch.h"
>> +#include "clk-rcg.h"
>> +#include "clk-regmap.h"
>> +#include "clk-regmap-divider.h"
>> +#include "common.h"
>> +#include "gdsc.h"
>> +#include "reset.h"
>> +
>> +enum {
>> +	DT_BI_TCXO,
>> +};
>> +
>> +enum {
>> +	P_BI_TCXO,
>> +	P_VIDEO_CC_PLL0_OUT_MAIN,
>> +	P_VIDEO_CC_PLL1_OUT_MAIN,
>> +};
>> +
>> +static const struct pll_vco lucid_evo_vco[] = {
>> +	{ 249600000, 2020000000, 0 },
>> +};
>> +
>> +static const struct alpha_pll_config video_cc_pll0_config = {
>> +	.l = 0x1E,
> lowercase hex, please, everywhere
> 

Sure, will take care.

>> +	.alpha = 0x0,
>> +	.config_ctl_val = 0x20485699,
>> +	.config_ctl_hi_val = 0x00182261,
>> +	.config_ctl_hi1_val = 0x32AA299C,
>> +	.user_ctl_val = 0x00000000,
>> +	.user_ctl_hi_val = 0x00000805,
>> +};
> [...]
> 
>> +static int video_cc_sm8450_probe(struct platform_device *pdev)
>> +{
>> +	struct regmap *regmap;
>> +	int ret;
>> +
>> +	devm_pm_runtime_enable(&pdev->dev);
> Please check the return value here and bail out early on failure.
> 

Will take care in the next patchset.

>> +
>> +	ret = pm_runtime_resume_and_get(&pdev->dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	regmap = qcom_cc_map(pdev, &video_cc_sm8450_desc);
>> +	if (IS_ERR(regmap)) {
>> +		pm_runtime_put(&pdev->dev);
>> +		return PTR_ERR(regmap);
>> +	}
>> +
>> +	clk_lucid_evo_pll_configure(&video_cc_pll0, regmap, &video_cc_pll0_config);
>> +	clk_lucid_evo_pll_configure(&video_cc_pll1, regmap, &video_cc_pll1_config);
>> +
>> +	/*
>> +	 * Keep clocks always enabled:
>> +	 *	video_cc_ahb_clk
>> +	 *	video_cc_sleep_clk
>> +	 *	video_cc_xo_clk
>> +	 */
>> +	regmap_update_bits(regmap, 0x80e4, BIT(0), BIT(0));
>> +	regmap_update_bits(regmap, 0x8130, BIT(0), BIT(0));
>> +	regmap_update_bits(regmap, 0x8114, BIT(0), BIT(0));
>> +
>> +	ret = qcom_cc_really_probe(pdev, &video_cc_sm8450_desc, regmap);
>> +
>> +	pm_runtime_put(&pdev->dev);
>> +
>> +	return ret;
>> +}
>> +
>> +static struct platform_driver video_cc_sm8450_driver = {
>> +	.probe = video_cc_sm8450_probe,
>> +	.driver = {
>> +		.name = "video_cc-sm8450",
>> +		.of_match_table = video_cc_sm8450_match_table,
>> +	},
>> +};
>> +
>> +static int __init video_cc_sm8450_init(void)
>> +{
>> +	return platform_driver_register(&video_cc_sm8450_driver);
>> +}
>> +subsys_initcall(video_cc_sm8450_init);
> module_platform_driver?
> 
> Venus won't probe earlier
> 

Clock drivers should be earlier than any consumer drivers.

> Konrad
>> +
>> +static void __exit video_cc_sm8450_exit(void)
>> +{
>> +	platform_driver_unregister(&video_cc_sm8450_driver);
>> +}
>> +module_exit(video_cc_sm8450_exit);
>> +
>> +MODULE_DESCRIPTION("QTI VIDEO_CC SM8450 Driver");
>> +MODULE_LICENSE("GPL");

-- 
Thanks & Regards,
Taniya Das.
