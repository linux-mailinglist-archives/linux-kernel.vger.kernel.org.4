Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BAD73BCB4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjFWQhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjFWQhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:37:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156EA1A1;
        Fri, 23 Jun 2023 09:37:06 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NExmDW007898;
        Fri, 23 Jun 2023 16:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HI56RhtwnXaAm/6DfveMHPxSqKnbhP8KVTVf6/mKBDA=;
 b=LqaAli/vXUtfM6Yz/I6QYJ442Zo2bAVl/kxr4A+l8EJb/Tv7mAXp95Nszj5i2Fj6kuOi
 b/5jrMlSm2TpFXiZkhVzjaVgQ5ziZ39wDzTXXw/IhdMzlxJNEgJXolVqp5AczcB32OI6
 RRW4ASJIX4bC7NsBxKxzv4z4MuYc2wPorBbvOwnTCLcAsFjLXlojq3eiUXhEEYxlSKB+
 zaxFlIhOzL6jPY3WmhzynzsKHjSz4/OJdeXE8pqDgpU9Lz+F0oKYjaNg5xBJx1GwDWOm
 4yhDXfN9GRrZfGhvZTi98ywJMfGf98kyXshVlFHA2XZgLw9bgC4Vy30+2iXOTaNBgZhq pQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rcurrj9y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 16:37:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35NGb0cc001652
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 16:37:00 GMT
Received: from [10.216.8.45] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 23 Jun
 2023 09:36:54 -0700
Message-ID: <6a464bfc-821f-d892-93d4-d8881f1b4ddc@quicinc.com>
Date:   Fri, 23 Jun 2023 22:06:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V4 2/4] clk: qcom: camcc-sm8550: Add camera clock
 controller driver for SM8550
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230609115058.9059-1-quic_jkona@quicinc.com>
 <20230609115058.9059-3-quic_jkona@quicinc.com>
 <CAA8EJpr-iKMzYP7HVQV8pzXbxzLvBaq38aovJ5Ffny18yXvJZg@mail.gmail.com>
 <6dc9f36a-f003-06eb-744c-0ebe645dfdf0@quicinc.com>
 <CAA8EJppY1Ff+zLF4PDxxTzpVj25VKCK9z+is_M0VaTi1iahbBw@mail.gmail.com>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <CAA8EJppY1Ff+zLF4PDxxTzpVj25VKCK9z+is_M0VaTi1iahbBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fv7ZpConYiBAlTPGxvk7fqT7o4eIZtr2
X-Proofpoint-ORIG-GUID: fv7ZpConYiBAlTPGxvk7fqT7o4eIZtr2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230148
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/2023 5:44 PM, Dmitry Baryshkov wrote:
> On Wed, 14 Jun 2023 at 14:55, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>>
>>
>>
>> On 6/9/2023 9:52 PM, Dmitry Baryshkov wrote:
>>> On Fri, 9 Jun 2023 at 14:52, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>>>>
>>>> Add support for the camera clock controller for camera clients to be
>>>> able to request for camcc clocks on SM8550 platform.
>>>>
>>>> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
>>>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>> ---
>>>> Changes since V3:
>>>>    - No changes
>>>> Changes since V2:
>>>>    - No changes
>>>> Changes since V1:
>>>>    - Sorted the PLL names in proper order
>>>>    - Updated all PLL configurations to lower case hex
>>>>    - Reused evo ops instead of adding new ops for ole pll
>>>>    - Moved few clocks to separate patch to fix patch too long error
>>>>
>>>>    drivers/clk/qcom/Kconfig        |    7 +
>>>>    drivers/clk/qcom/Makefile       |    1 +
>>>>    drivers/clk/qcom/camcc-sm8550.c | 3405 +++++++++++++++++++++++++++++++
>>>>    3 files changed, 3413 insertions(+)
>>>>    create mode 100644 drivers/clk/qcom/camcc-sm8550.c
>>>>
>>>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>>>> index 9cd1f05d436b..85efed78dc9a 100644
>>>> --- a/drivers/clk/qcom/Kconfig
>>>> +++ b/drivers/clk/qcom/Kconfig
>>>> @@ -756,6 +756,13 @@ config SM_CAMCC_8450
>>>>             Support for the camera clock controller on SM8450 devices.
>>>>             Say Y if you want to support camera devices and camera functionality.
>>>>
>>>> +config SM_CAMCC_8550
>>>> +       tristate "SM8550 Camera Clock Controller"
>>>> +       select SM_GCC_8550
>>>> +       help
>>>> +         Support for the camera clock controller on SM8550 devices.
>>>> +         Say Y if you want to support camera devices and camera functionality.
>>>> +
>>>>    config SM_DISPCC_6115
>>>>           tristate "SM6115 Display Clock Controller"
>>>>           depends on ARM64 || COMPILE_TEST
>>>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>>>> index 75d035150118..97c8cefc2fd0 100644
>>>> --- a/drivers/clk/qcom/Makefile
>>>> +++ b/drivers/clk/qcom/Makefile
>>>> @@ -101,6 +101,7 @@ obj-$(CONFIG_SDX_GCC_75) += gcc-sdx75.o
>>>>    obj-$(CONFIG_SM_CAMCC_6350) += camcc-sm6350.o
>>>>    obj-$(CONFIG_SM_CAMCC_8250) += camcc-sm8250.o
>>>>    obj-$(CONFIG_SM_CAMCC_8450) += camcc-sm8450.o
>>>> +obj-$(CONFIG_SM_CAMCC_8550) += camcc-sm8550.o
>>>>    obj-$(CONFIG_SM_DISPCC_6115) += dispcc-sm6115.o
>>>>    obj-$(CONFIG_SM_DISPCC_6125) += dispcc-sm6125.o
>>>>    obj-$(CONFIG_SM_DISPCC_6350) += dispcc-sm6350.o
>>>> diff --git a/drivers/clk/qcom/camcc-sm8550.c b/drivers/clk/qcom/camcc-sm8550.c
>>>> new file mode 100644
>>>> index 000000000000..85f0c1e09b2b
>>>> --- /dev/null
>>>> +++ b/drivers/clk/qcom/camcc-sm8550.c
>>>> @@ -0,0 +1,3405 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + */
>>>> +
>>>> +#include <linux/clk-provider.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/of_device.h>
>>>> +#include <linux/pm_runtime.h>
>>>> +#include <linux/regmap.h>
>>>> +
>>>> +#include <dt-bindings/clock/qcom,sm8550-camcc.h>
>>>> +
>>>> +#include "clk-alpha-pll.h"
>>>> +#include "clk-branch.h"
>>>> +#include "clk-rcg.h"
>>>> +#include "clk-regmap.h"
>>>> +#include "common.h"
>>>> +#include "gdsc.h"
>>>> +#include "reset.h"
>>>> +
>>>> +enum {
>>>> +       DT_IFACE,
>>>> +       DT_BI_TCXO,
>>>> +};
>>>> +
>>>> +enum {
>>>> +       P_BI_TCXO,
>>>> +       P_CAM_CC_PLL0_OUT_EVEN,
>>>> +       P_CAM_CC_PLL0_OUT_MAIN,
>>>> +       P_CAM_CC_PLL0_OUT_ODD,
>>>> +       P_CAM_CC_PLL1_OUT_EVEN,
>>>> +       P_CAM_CC_PLL2_OUT_EVEN,
>>>> +       P_CAM_CC_PLL2_OUT_MAIN,
>>>> +       P_CAM_CC_PLL3_OUT_EVEN,
>>>> +       P_CAM_CC_PLL4_OUT_EVEN,
>>>> +       P_CAM_CC_PLL5_OUT_EVEN,
>>>> +       P_CAM_CC_PLL6_OUT_EVEN,
>>>> +       P_CAM_CC_PLL7_OUT_EVEN,
>>>> +       P_CAM_CC_PLL8_OUT_EVEN,
>>>> +       P_CAM_CC_PLL9_OUT_EVEN,
>>>> +       P_CAM_CC_PLL9_OUT_ODD,
>>>> +       P_CAM_CC_PLL10_OUT_EVEN,
>>>> +       P_CAM_CC_PLL11_OUT_EVEN,
>>>> +       P_CAM_CC_PLL12_OUT_EVEN,
>>>> +};
>>>> +
>>>> +static const struct pll_vco lucid_ole_vco[] = {
>>>> +       { 249600000, 2300000000, 0 },
>>>> +};
>>>> +
>>>> +static const struct pll_vco rivian_ole_vco[] = {
>>>> +       { 777000000, 1285000000, 0 },
>>>> +};
>>>> +
>>>> +static const struct alpha_pll_config cam_cc_pll0_config = {
>>>> +       /* .l includes RINGOSC_CAL_L_VAL, CAL_L_VAL, L_VAL fields */
>>>> +       .l = 0x4444003e,
>>>
>>> I'd still insist on not touching the config.l field semantics.
>>>
>>
>> We feel it is better to update config->l field and reuse existing code
>> than adding separate function for lucid ole pll configure.
> 
> As you probably got it, I'm not convinced that it is a better
> approach. You are feeding additional data in a single configuration
> field and passing constant data as variadic one.
> 

Will avoid this approach and will add separate lucid ole pll configure 
function in next series.

>>
>>>> +       .alpha = 0x8000,
>>>> +       .config_ctl_val = 0x20485699,
>>>> +       .config_ctl_hi_val = 0x00182261,
>>>> +       .config_ctl_hi1_val = 0x82aa299c,
>>>> +       .test_ctl_val = 0x00000000,
>>>> +       .test_ctl_hi_val = 0x00000003,
>>>> +       .test_ctl_hi1_val = 0x00009000,
>>>> +       .test_ctl_hi2_val = 0x00000034,
>>>> +       .user_ctl_val = 0x00008400,
>>>> +       .user_ctl_hi_val = 0x00000005,
>>>> +};
>>>> +
>>>
>>> [skipped the rest, LGTM]
>>>
>>>> +
>>>> +static struct platform_driver cam_cc_sm8550_driver = {
>>>> +       .probe = cam_cc_sm8550_probe,
>>>> +       .driver = {
>>>> +               .name = "cam_cc-sm8550",
>>>> +               .of_match_table = cam_cc_sm8550_match_table,
>>>> +       },
>>>> +};
>>>> +
>>>> +static int __init cam_cc_sm8550_init(void)
>>>> +{
>>>> +       return platform_driver_register(&cam_cc_sm8550_driver);
>>>> +}
>>>> +subsys_initcall(cam_cc_sm8550_init);
>>>
>>> As it was pointed out, this driver is built as a module by default.
>>> Please perform the tesing and cleanup before sending the driver and
>>> use module_platform_driver.
>>>
>>
>> We want clock drivers to be probed early in the bootup to avoid any
>> probe deferrals of consumer drivers. If there is any scenario where
>> clock drivers are built statically into kernel, then subsys_initcall()
>> will ensure clock drivers are probed earlier. When built as module,
>> subsys_initcall() will fallback to module_init() which is same as
>> module_platform_driver().
> 
> Consumer driver probe deferrals are nowadays significantly prevented
> by using devlink rather than depending on the initialisation level.
> And I think both GKI and defconfig build camcc as modules.
> 

Will use module_platform_driver() in next series.

Thanks,
Jagadeesh

>>
>> Thanks,
>> Jagadeesh
>>
>>>> +
>>>> +static void __exit cam_cc_sm8550_exit(void)
>>>> +{
>>>> +       platform_driver_unregister(&cam_cc_sm8550_driver);
>>>> +}
>>>> +module_exit(cam_cc_sm8550_exit);
>>>> +
>>>> +MODULE_DESCRIPTION("QTI CAMCC SM8550 Driver");
>>>> +MODULE_LICENSE("GPL");
>>>> --
>>>> 2.40.1
>>>>
>>>
>>>
> 
> 
> 
