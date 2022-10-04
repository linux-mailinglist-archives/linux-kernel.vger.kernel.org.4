Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DEE5F49FC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 22:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiJDUAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 16:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiJDUAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 16:00:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D612D2CE07;
        Tue,  4 Oct 2022 13:00:12 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294JI1s1015121;
        Tue, 4 Oct 2022 20:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VKHps6I+brOum8EWob8JK7AysTpk9LF7YiCF0O4Jwa8=;
 b=cNGTtApou03Jlc3cQDqPfNCs1Me53dU1cCCta37OEcNFfACWF0eURabDF0KZbFRxaUhX
 uhEOuR7tE+2nFvWLo3/ZIpRMoUu7FnWaa3QCj2xB19VndQ8W1h01CR06PQDeFQB2N/QU
 S0oGPedCGnRoslG2eQIfI/qIymfrABRsEO5H6PucTq6WcbQNWcsOjAQRS8leBQgZ0bFH
 cpxjI7A9yAL3tsvInbqBjS7ZXdM9MAEHNg2Ep4xKYrpKuCqHXACskNcskoCcmEBBfB6c
 IJ/BR+KLG3hBHW3JZfe/mkKZdKqGVaqJ1B/KcSSmaWUPDVYGV6qax0Kyo4hJS64glRVH /Q== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0sq5r654-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 20:00:02 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 294K01C4017616
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Oct 2022 20:00:01 GMT
Received: from [10.110.73.50] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 13:00:00 -0700
Message-ID: <3906a857-3672-fea2-2ccb-d7f07a7ca836@quicinc.com>
Date:   Tue, 4 Oct 2022 14:59:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] pinctrl: qcom: Add QDU1000/QRU1000 pinctrl driver
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221001030546.28220-1-quic_molvera@quicinc.com>
 <20221001030546.28220-3-quic_molvera@quicinc.com>
 <CAA8EJprJqDHvSxB0DKDg6EGNF6Tr3cf73Pm6dQ_O1fiNHjR0mw@mail.gmail.com>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <CAA8EJprJqDHvSxB0DKDg6EGNF6Tr3cf73Pm6dQ_O1fiNHjR0mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: p7KawGSSeo9bud1gij50Nkdq5eTAqaYl
X-Proofpoint-GUID: p7KawGSSeo9bud1gij50Nkdq5eTAqaYl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_09,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210040130
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/2022 2:47 AM, Dmitry Baryshkov wrote:
> On Sat, 1 Oct 2022 at 06:07, Melody Olvera <quic_molvera@quicinc.com> wrote:
>> Add pin control driver for the TLMM block found in the QDU1000
>> and QRU1000 SoC.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  .../pinctrl/qcom,qdru1000-pinctrl.yaml        |  177 +-
>>  drivers/pinctrl/qcom/Kconfig                  |   10 +
>>  drivers/pinctrl/qcom/Makefile                 |    1 +
>>  drivers/pinctrl/qcom/pinctrl-qdru1000.c       |   59 +
>>  drivers/pinctrl/qcom/pinctrl-qdru1000.h       | 1896 +++++++++++++++++
>>  5 files changed, 2050 insertions(+), 93 deletions(-)
>>  create mode 100644 drivers/pinctrl/qcom/pinctrl-qdru1000.c
>>  create mode 100644 drivers/pinctrl/qcom/pinctrl-qdru1000.h
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml
>> index e8d938303231..42176247862c 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml
> This should go to the bindings patch, shan't it ?
Yup; my mistake. Next PS will have this separate.
>
>> @@ -10,7 +10,11 @@ maintainers:
> [skipped]
>
>> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
>> index f415c13caae0..c8a7d6e44a81 100644
>> --- a/drivers/pinctrl/qcom/Kconfig
>> +++ b/drivers/pinctrl/qcom/Kconfig
>> @@ -390,6 +390,16 @@ config PINCTRL_SM8450
>>           Qualcomm Technologies Inc TLMM block found on the Qualcomm
>>           Technologies Inc SM8450 platform.
>>
>> +config PINCTRL_QDRU1000
>> +       tristate "Qualcomm Tehcnologies Inc QDU1000/QRU1000 pin controller driver"
>> +       depends on GPIOLIB && OF
>> +       depends on PINCTRL_MSM
>> +       help
>> +         This is the pinctrl, pinmux, pinconf, and gpiolib driver for the
>> +         Qualcomm Technologies Inc TLMM block found on the Qualcomm
>> +         Technologies Inc QDU1000 and QRU1000 platforms.
>> +
>> +
>>  config PINCTRL_LPASS_LPI
>>         tristate "Qualcomm Technologies Inc LPASS LPI pin controller driver"
>>         select PINMUX
>> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
>> index fbd64853a24d..431a845b4e2d 100644
>> --- a/drivers/pinctrl/qcom/Makefile
>> +++ b/drivers/pinctrl/qcom/Makefile
>> @@ -45,4 +45,5 @@ obj-$(CONFIG_PINCTRL_SM8250) += pinctrl-sm8250.o
>>  obj-$(CONFIG_PINCTRL_SM8250_LPASS_LPI) += pinctrl-sm8250-lpass-lpi.o
>>  obj-$(CONFIG_PINCTRL_SM8350) += pinctrl-sm8350.o
>>  obj-$(CONFIG_PINCTRL_SM8450) += pinctrl-sm8450.o
>> +obj-$(CONFIG_PINCTRL_QDRU1000) += pinctrl-qdru1000.o
> Please move it before sc7180
Will do.
>
>>  obj-$(CONFIG_PINCTRL_LPASS_LPI) += pinctrl-lpass-lpi.o
>> diff --git a/drivers/pinctrl/qcom/pinctrl-qdru1000.c b/drivers/pinctrl/qcom/pinctrl-qdru1000.c
>> new file mode 100644
>> index 000000000000..8b931ff80bb4
>> --- /dev/null
>> +++ b/drivers/pinctrl/qcom/pinctrl-qdru1000.c
>> @@ -0,0 +1,59 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pinctrl/pinctrl.h>
>> +
>> +#include "pinctrl-msm.h"
>> +#include "pinctrl-qdru1000.h"
> No need to split all defs to a header file. Please merge them here.
Will do.
>
>> +
>> +static const struct msm_pinctrl_soc_data qdru1000_tlmm = {
>> +       .pins = qdru1000_pins,
>> +       .npins = ARRAY_SIZE(qdru1000_pins),
>> +       .functions = qdru1000_functions,
>> +       .nfunctions = ARRAY_SIZE(qdru1000_functions),
>> +       .groups = qdru1000_groups,
>> +       .ngroups = ARRAY_SIZE(qdru1000_groups),
>> +       .ngpios = 151,
>> +};
>> +
>> +static int qdru1000_tlmm_probe(struct platform_device *pdev)
>> +{
>> +       return msm_pinctrl_probe(pdev, &qdru1000_tlmm);
>> +}
>> +
>> +static const struct of_device_id qdru1000_tlmm_of_match[] = {
>> +       { .compatible = "qcom,qdu1000-tlmm", },
>> +       { .compatible = "qcom,qru1000-tlmm", },
>> +       { },
>> +};
>> +
>> +static struct platform_driver qdru1000_tlmm_driver = {
>> +       .driver = {
>> +               .name = "qdru1000-tlmm",
>> +               .of_match_table = qdru1000_tlmm_of_match,
>> +       },
>> +       .probe = qdru1000_tlmm_probe,
>> +       .remove = msm_pinctrl_remove,
>> +};
>> +
>> +static int __init qdru1000_tlmm_init(void)
>> +{
>> +       return platform_driver_register(&qdru1000_tlmm_driver);
>> +}
>> +arch_initcall(qdru1000_tlmm_init);
>> +
>> +static void __exit qdru1000_tlmm_exit(void)
>> +{
>> +       platform_driver_unregister(&qdru1000_tlmm_driver);
>> +}
>> +module_exit(qdru1000_tlmm_exit);
>> +
>> +MODULE_DESCRIPTION("QTI QDRU1000 TLMM driver");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DEVICE_TABLE(of, qdru1000_tlmm_of_match);
>> diff --git a/drivers/pinctrl/qcom/pinctrl-qdru1000.h b/drivers/pinctrl/qcom/pinctrl-qdru1000.h
>> new file mode 100644
>> index 000000000000..3c1f703ae53b
>> --- /dev/null
>> +++ b/drivers/pinctrl/qcom/pinctrl-qdru1000.h
>> @@ -0,0 +1,1896 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#define FUNCTION(fname)                                        \
>> +       [msm_mux_##fname] = {                           \
>> +               .name = #fname,                         \
>> +               .groups = fname##_groups,               \
>> +               .ngroups = ARRAY_SIZE(fname##_groups),  \
>> +       }
>> +
> [skipped]
>
>> +
>> +static const unsigned int sdc1_rclk_pins[] = { 151 };
>> +static const unsigned int sdc1_clk_pins[] = { 152 };
>> +static const unsigned int sdc1_cmd_pins[] = { 153 };
>> +static const unsigned int sdc1_data_pins[] = { 154 };
>> +
>> +enum qdru1000_functions {
>> +       msm_mux_gpio,
>> +       msm_mux_CMO_PRI,
>> +       msm_mux_SI5518_INT,
> Ugh. Is there really a function for the Si5518 interrupt? And what is CMO_PRI?
Yeah we need the Si5518 for userspace processes. Admittedly I'm not sure what uses CMO_PRI; can probably remove it.
>> +       msm_mux_atest_char_start,
>> +       msm_mux_atest_char_status0,
>> +       msm_mux_atest_char_status1,
>> +       msm_mux_atest_char_status2,
>> +       msm_mux_atest_char_status3,
>> +       msm_mux_atest_usb0_atereset,
>> +       msm_mux_atest_usb0_testdataout00,
>> +       msm_mux_atest_usb0_testdataout01,
>> +       msm_mux_atest_usb0_testdataout02,
>> +       msm_mux_atest_usb0_testdataout03,
>> +       msm_mux_char_exec_pending,
>> +       msm_mux_char_exec_release,
>> +       msm_mux_cmu_rng_entropy0,
>> +       msm_mux_cmu_rng_entropy1,
>> +       msm_mux_cmu_rng_entropy2,
>> +       msm_mux_cmu_rng_entropy3,
>> +       msm_mux_dbg_out_clk,
>> +       msm_mux_ddr_bist_complete,
>> +       msm_mux_ddr_bist_fail,
>> +       msm_mux_ddr_bist_start,
>> +       msm_mux_ddr_bist_stop,
>> +       msm_mux_ddr_pxi0_test,
>> +       msm_mux_ddr_pxi1_test,
>> +       msm_mux_ddr_pxi2_test,
>> +       msm_mux_ddr_pxi3_test,
>> +       msm_mux_ddr_pxi4_test,
>> +       msm_mux_ddr_pxi5_test,
>> +       msm_mux_ddr_pxi6_test,
>> +       msm_mux_ddr_pxi7_test,
>> +       msm_mux_eth012_int_n,
>> +       msm_mux_eth345_int_n,
>> +       msm_mux_eth6_int_n,
>> +       msm_mux_gcc_gp1_clk,
>> +       msm_mux_gcc_gp2_clk,
>> +       msm_mux_gcc_gp3_clk,
>> +       msm_mux_gps_pps_in,
>> +       msm_mux_hardsync_pps_in,
>> +       msm_mux_intr_c_raw0,
>> +       msm_mux_intr_c_raw1,
>> +       msm_mux_intr_c_raw2,
>> +       msm_mux_jitter_bist_ref,
>> +       msm_mux_pcie0,
>> +       msm_mux_pcie0_clkreqn,
>> +       msm_mux_pcie0_wake,
>> +       msm_mux_phase_flag_status0,
>> +       msm_mux_phase_flag_status1,
>> +       msm_mux_phase_flag_status10,
>> +       msm_mux_phase_flag_status11,
>> +       msm_mux_phase_flag_status12,
>> +       msm_mux_phase_flag_status13,
>> +       msm_mux_phase_flag_status14,
>> +       msm_mux_phase_flag_status15,
>> +       msm_mux_phase_flag_status16,
>> +       msm_mux_phase_flag_status17,
>> +       msm_mux_phase_flag_status18,
>> +       msm_mux_phase_flag_status19,
>> +       msm_mux_phase_flag_status2,
>> +       msm_mux_phase_flag_status20,
>> +       msm_mux_phase_flag_status21,
>> +       msm_mux_phase_flag_status22,
>> +       msm_mux_phase_flag_status23,
>> +       msm_mux_phase_flag_status24,
>> +       msm_mux_phase_flag_status25,
>> +       msm_mux_phase_flag_status26,
>> +       msm_mux_phase_flag_status27,
>> +       msm_mux_phase_flag_status28,
>> +       msm_mux_phase_flag_status29,
>> +       msm_mux_phase_flag_status3,
>> +       msm_mux_phase_flag_status30,
>> +       msm_mux_phase_flag_status31,
>> +       msm_mux_phase_flag_status4,
>> +       msm_mux_phase_flag_status5,
>> +       msm_mux_phase_flag_status6,
>> +       msm_mux_phase_flag_status7,
>> +       msm_mux_phase_flag_status8,
>> +       msm_mux_phase_flag_status9,
>> +       msm_mux_pll_bist_sync,
>> +       msm_mux_pll_clk_aux,
>> +       msm_mux_prng_rosc_test0,
>> +       msm_mux_prng_rosc_test1,
>> +       msm_mux_prng_rosc_test2,
>> +       msm_mux_prng_rosc_test3,
>> +       msm_mux_qdss_cti_trig0,
>> +       msm_mux_qdss_cti_trig1,
>> +       msm_mux_qdss_cti_trig2,
>> +       msm_mux_qdss_cti_trig3,
>> +       msm_mux_qdss_cti_trig4,
>> +       msm_mux_qdss_gpio_traceclk,
>> +       msm_mux_qdss_gpio_tracectl,
>> +       msm_mux_qdss_gpio_tracedata0,
>> +       msm_mux_qdss_gpio_tracedata1,
>> +       msm_mux_qdss_gpio_tracedata10,
>> +       msm_mux_qdss_gpio_tracedata11,
>> +       msm_mux_qdss_gpio_tracedata12,
>> +       msm_mux_qdss_gpio_tracedata13,
>> +       msm_mux_qdss_gpio_tracedata14,
>> +       msm_mux_qdss_gpio_tracedata15,
>> +       msm_mux_qdss_gpio_tracedata2,
>> +       msm_mux_qdss_gpio_tracedata3,
>> +       msm_mux_qdss_gpio_tracedata4,
>> +       msm_mux_qdss_gpio_tracedata5,
>> +       msm_mux_qdss_gpio_tracedata6,
>> +       msm_mux_qdss_gpio_tracedata7,
>> +       msm_mux_qdss_gpio_tracedata8,
>> +       msm_mux_qdss_gpio_tracedata9,
>> +       msm_mux_qlink0_enable,
>> +       msm_mux_qlink0_request,
>> +       msm_mux_qlink0_wmss_reset,
>> +       msm_mux_qlink1_enable,
>> +       msm_mux_qlink1_request,
>> +       msm_mux_qlink1_wmss_reset,
>> +       msm_mux_qlink2_enable,
>> +       msm_mux_qlink2_request,
>> +       msm_mux_qlink2_wmss_reset,
>> +       msm_mux_qlink3_enable,
>> +       msm_mux_qlink3_request,
>> +       msm_mux_qlink3_wmss_reset,
>> +       msm_mux_qlink4_enable,
>> +       msm_mux_qlink4_request,
>> +       msm_mux_qlink4_wmss_reset,
>> +       msm_mux_qlink5_enable,
>> +       msm_mux_qlink5_request,
>> +       msm_mux_qlink5_wmss_reset,
>> +       msm_mux_qlink6_enable,
>> +       msm_mux_qlink6_request,
>> +       msm_mux_qlink6_wmss_reset,
>> +       msm_mux_qlink7_enable,
>> +       msm_mux_qlink7_request,
>> +       msm_mux_qlink7_wmss_reset,
>> +       msm_mux_qspi_clk,
>> +       msm_mux_qspi_cs_n,
>> +       msm_mux_qspi_data_0,
>> +       msm_mux_qspi_data_1,
>> +       msm_mux_qspi_data_2,
>> +       msm_mux_qspi_data_3,
>> +       msm_mux_qup0_se0_l0,
>> +       msm_mux_qup0_se0_l1,
>> +       msm_mux_qup0_se0_l2,
>> +       msm_mux_qup0_se0_l3,
>> +       msm_mux_qup0_se1_l0,
>> +       msm_mux_qup0_se1_l1,
>> +       msm_mux_qup0_se1_l2,
>> +       msm_mux_qup0_se1_l3,
>> +       msm_mux_qup0_se2_l0,
>> +       msm_mux_qup0_se2_l1,
>> +       msm_mux_qup0_se2_l2,
>> +       msm_mux_qup0_se2_l3,
>> +       msm_mux_qup0_se3_l0,
>> +       msm_mux_qup0_se3_l1,
>> +       msm_mux_qup0_se3_l2,
>> +       msm_mux_qup0_se3_l3,
>> +       msm_mux_qup0_se4_l0,
>> +       msm_mux_qup0_se4_l1,
>> +       msm_mux_qup0_se4_l2,
>> +       msm_mux_qup0_se4_l3,
>> +       msm_mux_qup0_se5_l0,
>> +       msm_mux_qup0_se5_l1,
>> +       msm_mux_qup0_se5_l2,
>> +       msm_mux_qup0_se5_l3,
>> +       msm_mux_qup0_se6_l0,
>> +       msm_mux_qup0_se6_l1,
>> +       msm_mux_qup0_se6_l2,
>> +       msm_mux_qup0_se6_l3,
>> +       msm_mux_qup0_se7_l0,
>> +       msm_mux_qup0_se7_l1,
>> +       msm_mux_qup0_se7_l2,
>> +       msm_mux_qup0_se7_l3,
>> +       msm_mux_qup1_se0_l0,
>> +       msm_mux_qup1_se0_l1,
>> +       msm_mux_qup1_se0_l2,
>> +       msm_mux_qup1_se0_l3,
>> +       msm_mux_qup1_se1_l0,
>> +       msm_mux_qup1_se1_l1,
>> +       msm_mux_qup1_se1_l2,
>> +       msm_mux_qup1_se1_l3,
>> +       msm_mux_qup1_se2_l0,
>> +       msm_mux_qup1_se2_l1,
>> +       msm_mux_qup1_se2_l2,
>> +       msm_mux_qup1_se2_l3,
>> +       msm_mux_qup1_se3_l0,
>> +       msm_mux_qup1_se3_l1,
>> +       msm_mux_qup1_se3_l2,
>> +       msm_mux_qup1_se3_l3,
>> +       msm_mux_qup1_se4_l0,
>> +       msm_mux_qup1_se4_l1,
>> +       msm_mux_qup1_se4_l2,
>> +       msm_mux_qup1_se4_l3,
>> +       msm_mux_qup1_se5_l0,
>> +       msm_mux_qup1_se5_l1,
>> +       msm_mux_qup1_se5_l2,
>> +       msm_mux_qup1_se5_l3,
>> +       msm_mux_qup1_se6_l0,
>> +       msm_mux_qup1_se6_l1,
>> +       msm_mux_qup1_se6_l2,
>> +       msm_mux_qup1_se6_l3,
>> +       msm_mux_qup1_se6_l4,
>> +       msm_mux_qup1_se6_l5,
>> +       msm_mux_qup1_se6_l6,
>> +       msm_mux_qup1_se7_l0,
>> +       msm_mux_qup1_se7_l1,
>> +       msm_mux_qup1_se7_l2,
>> +       msm_mux_qup1_se7_l3,
>> +       msm_mux_qup1_se7_l4,
>> +       msm_mux_qup1_se7_l5,
>> +       msm_mux_qup1_se7_l6,
>> +       msm_mux_qup2_se0_l0,
>> +       msm_mux_qup2_se0_l1,
>> +       msm_mux_qup2_se0_l2,
>> +       msm_mux_qup2_se0_l3,
>> +       msm_mux_qup2_se1_l0,
>> +       msm_mux_qup2_se1_l1,
>> +       msm_mux_qup2_se1_l2,
>> +       msm_mux_qup2_se1_l3,
>> +       msm_mux_qup2_se2_l0,
>> +       msm_mux_qup2_se2_l1,
>> +       msm_mux_qup2_se2_l2,
>> +       msm_mux_qup2_se2_l3,
> We usually use the 'qupN' naming here.
>
> Overall comment to the function definitions. You seem to be splitting
> them too much. Please consider how other pinctrl drivers handle the
> functions. There is no need to define a function per each pin. Group
> them logically for all the pins belonging to a specific logical
> function/device.
Will do.
>
>> +       msm_mux_smb_alert,
>> +       msm_mux_smb_alert_n,
>> +       msm_mux_smb_clk,
>> +       msm_mux_smb_dat,
>> +       msm_mux_tb_trig_sdc1,
>> +       msm_mux_tgu_ch0_trigout,
>> +       msm_mux_tgu_ch1_trigout,
>> +       msm_mux_tgu_ch2_trigout,
>> +       msm_mux_tgu_ch3_trigout,
>> +       msm_mux_tgu_ch4_trigout,
>> +       msm_mux_tgu_ch5_trigout,
>> +       msm_mux_tgu_ch6_trigout,
>> +       msm_mux_tgu_ch7_trigout,
>> +       msm_mux_tmess_prng_rosc0,
>> +       msm_mux_tmess_prng_rosc1,
>> +       msm_mux_tmess_prng_rosc2,
>> +       msm_mux_tmess_prng_rosc3,
>> +       msm_mux_tod_pps_in,
>> +       msm_mux_tsense_pwm1_out,
>> +       msm_mux_tsense_pwm2_out,
>> +       msm_mux_usb2phy_ac_en,
>> +       msm_mux_usb_con_det,
>> +       msm_mux_usb_dfp_en,
>> +       msm_mux_usb_phy_ps,
>> +       msm_mux_vfr_0,
>> +       msm_mux_vfr_1,
>> +       msm_mux_vsense_trigger_mirnat,
>> +       msm_mux__,
>> +};
> [skipped]
>
Thanks,
Melody
