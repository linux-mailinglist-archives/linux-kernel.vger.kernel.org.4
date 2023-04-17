Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B196E3E85
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 06:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjDQEh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 00:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjDQEh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 00:37:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9441210E2;
        Sun, 16 Apr 2023 21:37:20 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H3p5CS000631;
        Mon, 17 Apr 2023 04:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nw/MuJkDBG6W1UmpIBSOl1ANSUQT5HXQpSJ734fymmg=;
 b=ZZftgUpDe5VRv+J3r5Yvwh74wTphXm8sxnGS9re1hLsoQA9h490L+AY15AfHaEnlzAPy
 Hqm5eihp+5nZsx4lSdHd4cZ4RtR/mwX8WcBqFW4cwq2Nu+y6++KYyh3CN0dmXHw7wbwE
 47JQ1PGun+W2CjxU/OJBUuKg1JI31ZENVyi5x3KCAD9W3zIz7M93F/CD1R1ndHOnM6TM
 1VDqozOSJdFn/WFk8hAHTxyfxpl97um3EGExSGbFh4iv6Zdsq6uJOqACML6oZAiswck7
 4A77TTk43tAtQkMz7S2mTriGhK+dfihLhGcJZlOASuFbaoNy0Mw8RpWXK51AvF/SyVsR JA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pyn2x2gnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 04:37:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33H4bDX3007729
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 04:37:13 GMT
Received: from [10.217.216.152] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 16 Apr
 2023 21:37:09 -0700
Message-ID: <793f8b14-033f-f9ec-12f2-32d3a9e01bf6@quicinc.com>
Date:   Mon, 17 Apr 2023 10:07:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] clk: qcom: videocc-sm8450: Add video clock controller
 driver for SM8450
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_skakitap@quicinc.com>, <quic_jkona@quicinc.com>
References: <20230316083049.29979-1-quic_tdas@quicinc.com>
 <20230316083049.29979-3-quic_tdas@quicinc.com>
 <CAA8EJpqxtRyVKoqNsY01FmHaa10WK9LT49ydenztoJ1q0ah0+A@mail.gmail.com>
From:   Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <CAA8EJpqxtRyVKoqNsY01FmHaa10WK9LT49ydenztoJ1q0ah0+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TB7mcnz0b93qVf9jLZvnxwJ-QySGQnEU
X-Proofpoint-ORIG-GUID: TB7mcnz0b93qVf9jLZvnxwJ-QySGQnEU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_01,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170039
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thank you for the comments.

On 3/16/2023 3:41 PM, Dmitry Baryshkov wrote:
> On Thu, 16 Mar 2023 at 10:31, Taniya Das <quic_tdas@quicinc.com> wrote:
>>
>> Add support for the video clock controller driver for peripheral clock
>> clients to be able to request for video cc clocks.
>>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> ---
>>   drivers/clk/qcom/Kconfig          |   9 +
>>   drivers/clk/qcom/Makefile         |   1 +
>>   drivers/clk/qcom/videocc-sm8450.c | 464 ++++++++++++++++++++++++++++++
>>   3 files changed, 474 insertions(+)
>>   create mode 100644 drivers/clk/qcom/videocc-sm8450.c
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 5ab4b7dfe3c2..81909e179bc7 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -892,4 +892,13 @@ config CLK_GFM_LPASS_SM8250
>>            Support for the Glitch Free Mux (GFM) Low power audio
>>             subsystem (LPASS) clocks found on SM8250 SoCs.
>>
>> +config SM_VIDEOCC_8450
>> +       tristate "SM8450 Video Clock Controller"
>> +       select SM_GCC_8450
>> +       select QCOM_GDSC
>> +       help
>> +         Support for the video clock controller on Qualcomm Technologies, Inc.
>> +         SM8450 devices.
>> +         Say Y if you want to support video devices and functionality such as
>> +         video encode/decode.
>>   endif
>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>> index c743805a9cbb..5cbd0eedd6d9 100644
>> --- a/drivers/clk/qcom/Makefile
>> +++ b/drivers/clk/qcom/Makefile
>> @@ -119,6 +119,7 @@ obj-$(CONFIG_SM_GPUCC_8350) += gpucc-sm8350.o
>>   obj-$(CONFIG_SM_TCSRCC_8550) += tcsrcc-sm8550.o
>>   obj-$(CONFIG_SM_VIDEOCC_8150) += videocc-sm8150.o
>>   obj-$(CONFIG_SM_VIDEOCC_8250) += videocc-sm8250.o
>> +obj-$(CONFIG_SM_VIDEOCC_8450) += videocc-sm8450.o
>>   obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
>>   obj-$(CONFIG_KPSS_XCC) += kpss-xcc.o
>>   obj-$(CONFIG_QCOM_HFPLL) += hfpll.o
>> diff --git a/drivers/clk/qcom/videocc-sm8450.c b/drivers/clk/qcom/videocc-sm8450.c
>> new file mode 100644
>> index 000000000000..ca60f3be587d
>> --- /dev/null
>> +++ b/drivers/clk/qcom/videocc-sm8450.c
>> @@ -0,0 +1,464 @@
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
>> +#include <dt-bindings/clock/qcom,videocc-sm8450.h>
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
>> +       P_BI_TCXO,
>> +       P_VIDEO_CC_PLL0_OUT_MAIN,
>> +       P_VIDEO_CC_PLL1_OUT_MAIN,
>> +};
>> +
>> +static const struct pll_vco lucid_evo_vco[] = {
>> +       { 249600000, 2020000000, 0 },
>> +};
>> +
>> +static const struct alpha_pll_config video_cc_pll0_config = {
>> +       .l = 0x1E,
>> +       .alpha = 0x0,
>> +       .config_ctl_val = 0x20485699,
>> +       .config_ctl_hi_val = 0x00182261,
>> +       .config_ctl_hi1_val = 0x32AA299C,
>> +       .user_ctl_val = 0x00000000,
>> +       .user_ctl_hi_val = 0x00000805,
>> +};
>> +
>> +static struct clk_alpha_pll video_cc_pll0 = {
>> +       .offset = 0x0,
>> +       .vco_table = lucid_evo_vco,
>> +       .num_vco = ARRAY_SIZE(lucid_evo_vco),
>> +       .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
>> +       .clkr = {
>> +               .hw.init = &(const struct clk_init_data){
>> +                       .name = "video_cc_pll0",
>> +                       .parent_data = &(const struct clk_parent_data){
>> +                               .fw_name = "bi_tcxo",
> 
> Could you please follow the last of recent drivers and use DT indices
> instead of clock-names?
> 

Thanks, will fix them in the next patch set.

> Also, as a syntax nit, could you please add whitespaces between ) and { ?
> 

Done.

>> +                       },
>> +                       .num_parents = 1,
>> +                       .ops = &clk_alpha_pll_lucid_evo_ops,
>> +               },
>> +       },
>> +};
>> +
> 
> [skipped]
> 
> 
>> +
>> +static void video_cc_sm8450_pm_runtime_disable(void *data)
>> +{
>> +       pm_runtime_disable(data);
>> +}
>> +
>> +static int video_cc_sm8450_probe(struct platform_device *pdev)
>> +{
>> +       struct regmap *regmap;
>> +       int ret;
>> +
>> +       pm_runtime_enable(&pdev->dev);
>> +
>> +       ret = devm_add_action_or_reset(&pdev->dev, video_cc_sm8450_pm_runtime_disable, &pdev->dev);
>> +       if (ret)
>> +               return ret;
> 
> Could you please shift to using devm_pm_runtime_enable()?
> 

Done.

>> +
>> +       ret = pm_runtime_resume_and_get(&pdev->dev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       regmap = qcom_cc_map(pdev, &video_cc_sm8450_desc);
>> +       if (IS_ERR(regmap)) {
>> +               pm_runtime_put(&pdev->dev);
>> +               return PTR_ERR(regmap);
>> +       }
>> +
>> +       clk_lucid_evo_pll_configure(&video_cc_pll0, regmap, &video_cc_pll0_config);
>> +       clk_lucid_evo_pll_configure(&video_cc_pll1, regmap, &video_cc_pll1_config);
>> +
>> +       /*
>> +        * Keep clocks always enabled:
>> +        *      video_cc_ahb_clk
>> +        *      video_cc_sleep_clk
>> +        *      video_cc_xo_clk
>> +        */
>> +       regmap_update_bits(regmap, 0x80e4, BIT(0), BIT(0));
>> +       regmap_update_bits(regmap, 0x8130, BIT(0), BIT(0));
>> +       regmap_update_bits(regmap, 0x8114, BIT(0), BIT(0));
>> +
>> +       ret = qcom_cc_really_probe(pdev, &video_cc_sm8450_desc, regmap);
>> +
>> +       pm_runtime_put(&pdev->dev);
>> +
>> +       return ret;
>> +}
>> +
>> +static struct platform_driver video_cc_sm8450_driver = {
>> +       .probe = video_cc_sm8450_probe,
>> +       .driver = {
>> +               .name = "video_cc-sm8450",
>> +               .of_match_table = video_cc_sm8450_match_table,
>> +       },
>> +};
>> +
>> +static int __init video_cc_sm8450_init(void)
>> +{
>> +       return platform_driver_register(&video_cc_sm8450_driver);
>> +}
>> +subsys_initcall(video_cc_sm8450_init);
>> +
>> +static void __exit video_cc_sm8450_exit(void)
>> +{
>> +       platform_driver_unregister(&video_cc_sm8450_driver);
>> +}
>> +module_exit(video_cc_sm8450_exit);
>> +
>> +MODULE_DESCRIPTION("QTI VIDEO_CC SM8450 Driver");
>> +MODULE_LICENSE("GPL v2");
> 
> I think this should be just "GPL" nowaways.
> 

Will take care in the next patch set.

>> --
>> 2.17.1
>>
> 
> 

-- 
Thanks & Regards,
Taniya Das.
