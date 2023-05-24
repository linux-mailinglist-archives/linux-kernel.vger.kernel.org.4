Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBB570F884
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbjEXOUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjEXOU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:20:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF293119;
        Wed, 24 May 2023 07:20:27 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OCelIk018004;
        Wed, 24 May 2023 14:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FfIUZHOHpcLbU5HBca+VgpgQEMlYe+fHPzpTBYhzp6k=;
 b=SimTO1WC6iBpNg4s2T32q5nrQ1TLybO4tpAQYsQ/sPTGenKDeflZ5V+hpGV+FBfC7rFT
 79qZL62RudAt4a5H8IaKNLFSy6QmsVETbdMZCfHwtN51wd/STkIIF+HAhyaknlWL3SU2
 3+vgItoFrZN75TB+k2UZq/sL767YFf6PnpIqZPuXXCe0xEx5pvZBLYMRziTfaaCORGAt
 h4xhw73T+nCuhKlot36xgO5B8ebg5uHEB0MiI3YWEjP3cp4zJE6E03Z0w9GVdFZheqJU
 Jmhaudmh0m149VsK/1z/er0d/9EJ5ujTJOVJGTWNmG3O2irYLts/0b5Y2BUmJEiZb2o0 wg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qscpms2eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 14:20:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34OEKKxp001881
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 14:20:20 GMT
Received: from [10.217.216.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 24 May
 2023 07:20:16 -0700
Message-ID: <a101f5f2-4458-8284-cc7f-1ce22389c26f@quicinc.com>
Date:   Wed, 24 May 2023 19:50:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/4] clk: qcom: videocc-sm8550: Add video clock controller
 driver for SM8550
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Conor Dooley <conor+dt@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230509161218.11979-1-quic_jkona@quicinc.com>
 <20230509161218.11979-4-quic_jkona@quicinc.com>
 <CAA8EJppn9=gPFk1RRB9y50aU_G3J6QrsOVQ9GH5gT86D_hOAgQ@mail.gmail.com>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <CAA8EJppn9=gPFk1RRB9y50aU_G3J6QrsOVQ9GH5gT86D_hOAgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0PIp1uK_OZaGeK9qMccerJPMP9Sfd1zP
X-Proofpoint-GUID: 0PIp1uK_OZaGeK9qMccerJPMP9Sfd1zP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_09,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305240117
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thanks for your review!

On 5/9/2023 10:45 PM, Dmitry Baryshkov wrote:
> On Tue, 9 May 2023 at 19:14, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>>
>> Add support for the video clock controller for video clients to be able
>> to request for videocc clocks on SM8550 platform.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> ---
>>   drivers/clk/qcom/Kconfig          |  10 +
>>   drivers/clk/qcom/Makefile         |   1 +
>>   drivers/clk/qcom/videocc-sm8550.c | 468 ++++++++++++++++++++++++++++++
>>   3 files changed, 479 insertions(+)
>>   create mode 100644 drivers/clk/qcom/videocc-sm8550.c
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 12be3e2371b3..6bb9b4aff047 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -925,6 +925,16 @@ config SM_VIDEOCC_8250
>>            Say Y if you want to support video devices and functionality such as
>>            video encode and decode.
>>
>> +config SM_VIDEOCC_8550
>> +       tristate "SM8550 Video Clock Controller"
>> +       select SM_GCC_8550
>> +       select QCOM_GDSC
>> +       help
>> +         Support for the video clock controller on Qualcomm Technologies, Inc.
>> +         SM8550 devices.
>> +         Say Y if you want to support video devices and functionality such as
>> +         video encode/decode.
>> +
>>   config SPMI_PMIC_CLKDIV
>>          tristate "SPMI PMIC clkdiv Support"
>>          depends on SPMI || COMPILE_TEST
>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>> index 9ff4c373ad95..f0b95fc217aa 100644
>> --- a/drivers/clk/qcom/Makefile
>> +++ b/drivers/clk/qcom/Makefile
>> @@ -127,6 +127,7 @@ obj-$(CONFIG_SM_GPUCC_8350) += gpucc-sm8350.o
>>   obj-$(CONFIG_SM_TCSRCC_8550) += tcsrcc-sm8550.o
>>   obj-$(CONFIG_SM_VIDEOCC_8150) += videocc-sm8150.o
>>   obj-$(CONFIG_SM_VIDEOCC_8250) += videocc-sm8250.o
>> +obj-$(CONFIG_SM_VIDEOCC_8550) += videocc-sm8550.o
>>   obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
>>   obj-$(CONFIG_KPSS_XCC) += kpss-xcc.o
>>   obj-$(CONFIG_QCOM_HFPLL) += hfpll.o
>> diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
>> new file mode 100644
>> index 000000000000..10e4b2725ddf
>> --- /dev/null
>> +++ b/drivers/clk/qcom/videocc-sm8550.c
>> @@ -0,0 +1,468 @@
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
>> +#include <dt-bindings/clock/qcom,sm8550-videocc.h>
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
>> +       DT_BI_TCXO,
> 
> Any additional handling for gcc_video_ahb clk? It doesn't seem to be
> used as a parent. Probably you intended to use it as a pm_clk?
> Yes it is a pm_clk, but no additional handling is required from driver side.

>> +};
>> +
>> +enum {
>> +       P_BI_TCXO,
>> +       P_VIDEO_CC_PLL0_OUT_MAIN,
>> +       P_VIDEO_CC_PLL1_OUT_MAIN,
>> +};
[skipped]

>> +static struct clk_regmap *video_cc_sm8550_clocks[] = {
>> +       [VIDEO_CC_MVS0_CLK] = &video_cc_mvs0_clk.clkr,
>> +       [VIDEO_CC_MVS0_CLK_SRC] = &video_cc_mvs0_clk_src.clkr,
>> +       [VIDEO_CC_MVS0_DIV_CLK_SRC] = &video_cc_mvs0_div_clk_src.clkr,
>> +       [VIDEO_CC_MVS0C_CLK] = &video_cc_mvs0c_clk.clkr,
>> +       [VIDEO_CC_MVS0C_DIV2_DIV_CLK_SRC] = &video_cc_mvs0c_div2_div_clk_src.clkr,
>> +       [VIDEO_CC_MVS1_CLK] = &video_cc_mvs1_clk.clkr,
>> +       [VIDEO_CC_MVS1_CLK_SRC] = &video_cc_mvs1_clk_src.clkr,
>> +       [VIDEO_CC_MVS1_DIV_CLK_SRC] = &video_cc_mvs1_div_clk_src.clkr,
>> +       [VIDEO_CC_MVS1C_CLK] = &video_cc_mvs1c_clk.clkr,
>> +       [VIDEO_CC_MVS1C_DIV2_DIV_CLK_SRC] = &video_cc_mvs1c_div2_div_clk_src.clkr,
>> +       [VIDEO_CC_PLL0] = &video_cc_pll0.clkr,
>> +       [VIDEO_CC_PLL1] = &video_cc_pll1.clkr,
>> +};
>> +
>> +static struct gdsc *video_cc_sm8550_gdscs[] = {
>> +       [VIDEO_CC_MVS0C_GDSC] = &video_cc_mvs0c_gdsc,
>> +       [VIDEO_CC_MVS0_GDSC] = &video_cc_mvs0_gdsc,
>> +       [VIDEO_CC_MVS1C_GDSC] = &video_cc_mvs1c_gdsc,
>> +       [VIDEO_CC_MVS1_GDSC] = &video_cc_mvs1_gdsc,
>> +};
>> +
>> +static const struct qcom_reset_map video_cc_sm8550_resets[] = {
>> +       [CVP_VIDEO_CC_INTERFACE_BCR] = { 0x80f0 },
>> +       [CVP_VIDEO_CC_MVS0_BCR] = { 0x80a0 },
>> +       [CVP_VIDEO_CC_MVS0C_BCR] = { 0x8048 },
>> +       [CVP_VIDEO_CC_MVS1_BCR] = { 0x80c8 },
>> +       [CVP_VIDEO_CC_MVS1C_BCR] = { 0x8074 },
> 
> Please rename them to start with the VIDEO_CC prefix.
> 
These names are coming from hardware plan and clients will
refer to hardware plan for these names. So we would like to
keep the names intact same as from hardware plan.

>> +       [VIDEO_CC_MVS0C_CLK_ARES] = { 0x8064, 2 },
>> +       [VIDEO_CC_MVS1C_CLK_ARES] = { 0x8090, 2 },
>> +};
>> +
>> +static const struct regmap_config video_cc_sm8550_regmap_config = {
>> +       .reg_bits = 32,
>> +       .reg_stride = 4,
>> +       .val_bits = 32,
>> +       .max_register = 0x9f4c,
>> +       .fast_io = true,
>> +};
>> +
>> +static struct qcom_cc_desc video_cc_sm8550_desc = {
>> +       .config = &video_cc_sm8550_regmap_config,
>> +       .clks = video_cc_sm8550_clocks,
>> +       .num_clks = ARRAY_SIZE(video_cc_sm8550_clocks),
>> +       .resets = video_cc_sm8550_resets,
>> +       .num_resets = ARRAY_SIZE(video_cc_sm8550_resets),
>> +       .gdscs = video_cc_sm8550_gdscs,
>> +       .num_gdscs = ARRAY_SIZE(video_cc_sm8550_gdscs),
>> +};
>> +
>> +static const struct of_device_id video_cc_sm8550_match_table[] = {
>> +       { .compatible = "qcom,sm8550-videocc" },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, video_cc_sm8550_match_table);
>> +
>> +static int video_cc_sm8550_probe(struct platform_device *pdev)
>> +{
>> +       struct regmap *regmap;
>> +       int ret;
>> +
>> +       ret = devm_pm_runtime_enable(&pdev->dev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = pm_runtime_resume_and_get(&pdev->dev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       regmap = qcom_cc_map(pdev, &video_cc_sm8550_desc);
>> +       if (IS_ERR(regmap)) {
>> +               pm_runtime_put(&pdev->dev);
>> +               return PTR_ERR(regmap);
>> +       }
>> +
>> +       clk_lucid_ole_pll_configure(&video_cc_pll0, regmap, &video_cc_pll0_config);
>> +       clk_lucid_ole_pll_configure(&video_cc_pll1, regmap, &video_cc_pll1_config);
>> +
>> +       /*
>> +        * Keep clocks always enabled:
>> +        *      video_cc_ahb_clk
>> +        *      video_cc_sleep_clk
>> +        *      video_cc_xo_clk
>> +        */
>> +       regmap_update_bits(regmap, 0x80f4, BIT(0), BIT(0));
>> +       regmap_update_bits(regmap, 0x8140, BIT(0), BIT(0));
>> +       regmap_update_bits(regmap, 0x8124, BIT(0), BIT(0));
>> +
>> +       ret = qcom_cc_really_probe(pdev, &video_cc_sm8550_desc, regmap);
>> +
>> +       pm_runtime_put(&pdev->dev);
>> +
>> +       return ret;
>> +}
>> +
>> +static struct platform_driver video_cc_sm8550_driver = {
>> +       .probe = video_cc_sm8550_probe,
>> +       .driver = {
>> +               .name = "video_cc-sm8550",
>> +               .of_match_table = video_cc_sm8550_match_table,
>> +       },
>> +};
>> +
>> +static int __init video_cc_sm8550_init(void)
>> +{
>> +       return platform_driver_register(&video_cc_sm8550_driver);
>> +}
>> +subsys_initcall(video_cc_sm8550_init);
> 
> module_platform_driver() instead? There is no need to register videocc
> at the subsys level.
> 
We need to evaluate and validate if module_platform_driver works for us 
in all scenarios. We will post a cleanup patch once we conclude 
module_platform_driver works for us in all cases.

Thanks & Regards,
Jagadeesh
