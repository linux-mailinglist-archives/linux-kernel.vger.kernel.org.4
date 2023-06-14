Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7697972FE21
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243862AbjFNMPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244576AbjFNMOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:14:51 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E171FCB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:14:39 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-bc43a73ab22so889103276.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686744878; x=1689336878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4byCaI3hLGi5X054xdozNmq02gRpZ7o7e5d0Whg0jp0=;
        b=jhhpbZQ1sCqTcMAZj9YEqHDiWteGLGTnSpQzHIV/CotfoIERYaGiOT5/w3Pely4IDG
         XcPKzi+Me0jR2oLPGsx8BzClEVBbHHRbA73ueCuLIZkdbUL+XjWCWus4QNF2Au1syRTD
         L1Gzhu2GGcLYZOQW8d/QA+UqQ0PsHMhh/6cV1KC426G6Gj52vGn5Vw+zqnRgMOK/WRQh
         Uhhhi6hf5H2gyvO0loXfS3i4AzMUZ1Pom6pr+lUkN6TG7dnb9G9yDag0j8toLT2aWGIT
         oajnBULCGP5RMDQCeBJlTBHkg/0yc419WgUvm3WjL+F+5fK5vSj8zWTJCAVTSIDphNY2
         9bOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686744878; x=1689336878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4byCaI3hLGi5X054xdozNmq02gRpZ7o7e5d0Whg0jp0=;
        b=TUeu2jeRku2u1VITDIm3xylFhVgJHomBPIv1YaIESKTyz8UlMxROO4r7MhGToqZP1/
         mkaNv78009FOBEWga5kDwKWpv+V/jqUcWT3RfMcP8Bo37dr6tFu2srvW/ivvufRU7oIe
         kEdlbx7vE4iuyqlRXQClsFWylIRe5AO2EXNxtvmKxsOiDDPFT3V4xWo/7WJ8VzCt2l28
         TF2mcHSnNmIYFjBBy9YTbQ8tha+FlG1OhoL1qc+D/vZ7ax5hPDXoGf0C2aHVjwQP3HPK
         lnX4BlNd+kFH8nt1UuY7rq4pezmoZTpiwCqYVr+gVwmeP+bbpCb2afQ03orKM6skZKVD
         h0QA==
X-Gm-Message-State: AC+VfDy63F0zlkAVzLYKDLs120pZLDZt4wmpu4mSYQmBdGNXf8RcsEzw
        7MFFYhoxZFSfxJ0LWaLBHqvzm25+1dQx+8p5hfO3DQ==
X-Google-Smtp-Source: ACHHUZ6UKHyZY7NGQrQNB9I+73ebkiptVm7+GCwRYyTiaq5m9BNnvjsfgKgzX9XmpAwQzdvObVt4bNfhSbcV0AqLNh0=
X-Received: by 2002:a25:341:0:b0:bad:3b62:a822 with SMTP id
 62-20020a250341000000b00bad3b62a822mr1878828ybd.16.1686744878136; Wed, 14 Jun
 2023 05:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230609115058.9059-1-quic_jkona@quicinc.com> <20230609115058.9059-3-quic_jkona@quicinc.com>
 <CAA8EJpr-iKMzYP7HVQV8pzXbxzLvBaq38aovJ5Ffny18yXvJZg@mail.gmail.com> <6dc9f36a-f003-06eb-744c-0ebe645dfdf0@quicinc.com>
In-Reply-To: <6dc9f36a-f003-06eb-744c-0ebe645dfdf0@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 14 Jun 2023 15:14:26 +0300
Message-ID: <CAA8EJppY1Ff+zLF4PDxxTzpVj25VKCK9z+is_M0VaTi1iahbBw@mail.gmail.com>
Subject: Re: [PATCH V4 2/4] clk: qcom: camcc-sm8550: Add camera clock
 controller driver for SM8550
To:     Jagadeesh Kona <quic_jkona@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 at 14:55, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>
>
>
> On 6/9/2023 9:52 PM, Dmitry Baryshkov wrote:
> > On Fri, 9 Jun 2023 at 14:52, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
> >>
> >> Add support for the camera clock controller for camera clients to be
> >> able to request for camcc clocks on SM8550 platform.
> >>
> >> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
> >> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> >> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> >> ---
> >> Changes since V3:
> >>   - No changes
> >> Changes since V2:
> >>   - No changes
> >> Changes since V1:
> >>   - Sorted the PLL names in proper order
> >>   - Updated all PLL configurations to lower case hex
> >>   - Reused evo ops instead of adding new ops for ole pll
> >>   - Moved few clocks to separate patch to fix patch too long error
> >>
> >>   drivers/clk/qcom/Kconfig        |    7 +
> >>   drivers/clk/qcom/Makefile       |    1 +
> >>   drivers/clk/qcom/camcc-sm8550.c | 3405 +++++++++++++++++++++++++++++++
> >>   3 files changed, 3413 insertions(+)
> >>   create mode 100644 drivers/clk/qcom/camcc-sm8550.c
> >>
> >> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> >> index 9cd1f05d436b..85efed78dc9a 100644
> >> --- a/drivers/clk/qcom/Kconfig
> >> +++ b/drivers/clk/qcom/Kconfig
> >> @@ -756,6 +756,13 @@ config SM_CAMCC_8450
> >>            Support for the camera clock controller on SM8450 devices.
> >>            Say Y if you want to support camera devices and camera functionality.
> >>
> >> +config SM_CAMCC_8550
> >> +       tristate "SM8550 Camera Clock Controller"
> >> +       select SM_GCC_8550
> >> +       help
> >> +         Support for the camera clock controller on SM8550 devices.
> >> +         Say Y if you want to support camera devices and camera functionality.
> >> +
> >>   config SM_DISPCC_6115
> >>          tristate "SM6115 Display Clock Controller"
> >>          depends on ARM64 || COMPILE_TEST
> >> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> >> index 75d035150118..97c8cefc2fd0 100644
> >> --- a/drivers/clk/qcom/Makefile
> >> +++ b/drivers/clk/qcom/Makefile
> >> @@ -101,6 +101,7 @@ obj-$(CONFIG_SDX_GCC_75) += gcc-sdx75.o
> >>   obj-$(CONFIG_SM_CAMCC_6350) += camcc-sm6350.o
> >>   obj-$(CONFIG_SM_CAMCC_8250) += camcc-sm8250.o
> >>   obj-$(CONFIG_SM_CAMCC_8450) += camcc-sm8450.o
> >> +obj-$(CONFIG_SM_CAMCC_8550) += camcc-sm8550.o
> >>   obj-$(CONFIG_SM_DISPCC_6115) += dispcc-sm6115.o
> >>   obj-$(CONFIG_SM_DISPCC_6125) += dispcc-sm6125.o
> >>   obj-$(CONFIG_SM_DISPCC_6350) += dispcc-sm6350.o
> >> diff --git a/drivers/clk/qcom/camcc-sm8550.c b/drivers/clk/qcom/camcc-sm8550.c
> >> new file mode 100644
> >> index 000000000000..85f0c1e09b2b
> >> --- /dev/null
> >> +++ b/drivers/clk/qcom/camcc-sm8550.c
> >> @@ -0,0 +1,3405 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> >> + */
> >> +
> >> +#include <linux/clk-provider.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of_device.h>
> >> +#include <linux/pm_runtime.h>
> >> +#include <linux/regmap.h>
> >> +
> >> +#include <dt-bindings/clock/qcom,sm8550-camcc.h>
> >> +
> >> +#include "clk-alpha-pll.h"
> >> +#include "clk-branch.h"
> >> +#include "clk-rcg.h"
> >> +#include "clk-regmap.h"
> >> +#include "common.h"
> >> +#include "gdsc.h"
> >> +#include "reset.h"
> >> +
> >> +enum {
> >> +       DT_IFACE,
> >> +       DT_BI_TCXO,
> >> +};
> >> +
> >> +enum {
> >> +       P_BI_TCXO,
> >> +       P_CAM_CC_PLL0_OUT_EVEN,
> >> +       P_CAM_CC_PLL0_OUT_MAIN,
> >> +       P_CAM_CC_PLL0_OUT_ODD,
> >> +       P_CAM_CC_PLL1_OUT_EVEN,
> >> +       P_CAM_CC_PLL2_OUT_EVEN,
> >> +       P_CAM_CC_PLL2_OUT_MAIN,
> >> +       P_CAM_CC_PLL3_OUT_EVEN,
> >> +       P_CAM_CC_PLL4_OUT_EVEN,
> >> +       P_CAM_CC_PLL5_OUT_EVEN,
> >> +       P_CAM_CC_PLL6_OUT_EVEN,
> >> +       P_CAM_CC_PLL7_OUT_EVEN,
> >> +       P_CAM_CC_PLL8_OUT_EVEN,
> >> +       P_CAM_CC_PLL9_OUT_EVEN,
> >> +       P_CAM_CC_PLL9_OUT_ODD,
> >> +       P_CAM_CC_PLL10_OUT_EVEN,
> >> +       P_CAM_CC_PLL11_OUT_EVEN,
> >> +       P_CAM_CC_PLL12_OUT_EVEN,
> >> +};
> >> +
> >> +static const struct pll_vco lucid_ole_vco[] = {
> >> +       { 249600000, 2300000000, 0 },
> >> +};
> >> +
> >> +static const struct pll_vco rivian_ole_vco[] = {
> >> +       { 777000000, 1285000000, 0 },
> >> +};
> >> +
> >> +static const struct alpha_pll_config cam_cc_pll0_config = {
> >> +       /* .l includes RINGOSC_CAL_L_VAL, CAL_L_VAL, L_VAL fields */
> >> +       .l = 0x4444003e,
> >
> > I'd still insist on not touching the config.l field semantics.
> >
>
> We feel it is better to update config->l field and reuse existing code
> than adding separate function for lucid ole pll configure.

As you probably got it, I'm not convinced that it is a better
approach. You are feeding additional data in a single configuration
field and passing constant data as variadic one.

>
> >> +       .alpha = 0x8000,
> >> +       .config_ctl_val = 0x20485699,
> >> +       .config_ctl_hi_val = 0x00182261,
> >> +       .config_ctl_hi1_val = 0x82aa299c,
> >> +       .test_ctl_val = 0x00000000,
> >> +       .test_ctl_hi_val = 0x00000003,
> >> +       .test_ctl_hi1_val = 0x00009000,
> >> +       .test_ctl_hi2_val = 0x00000034,
> >> +       .user_ctl_val = 0x00008400,
> >> +       .user_ctl_hi_val = 0x00000005,
> >> +};
> >> +
> >
> > [skipped the rest, LGTM]
> >
> >> +
> >> +static struct platform_driver cam_cc_sm8550_driver = {
> >> +       .probe = cam_cc_sm8550_probe,
> >> +       .driver = {
> >> +               .name = "cam_cc-sm8550",
> >> +               .of_match_table = cam_cc_sm8550_match_table,
> >> +       },
> >> +};
> >> +
> >> +static int __init cam_cc_sm8550_init(void)
> >> +{
> >> +       return platform_driver_register(&cam_cc_sm8550_driver);
> >> +}
> >> +subsys_initcall(cam_cc_sm8550_init);
> >
> > As it was pointed out, this driver is built as a module by default.
> > Please perform the tesing and cleanup before sending the driver and
> > use module_platform_driver.
> >
>
> We want clock drivers to be probed early in the bootup to avoid any
> probe deferrals of consumer drivers. If there is any scenario where
> clock drivers are built statically into kernel, then subsys_initcall()
> will ensure clock drivers are probed earlier. When built as module,
> subsys_initcall() will fallback to module_init() which is same as
> module_platform_driver().

Consumer driver probe deferrals are nowadays significantly prevented
by using devlink rather than depending on the initialisation level.
And I think both GKI and defconfig build camcc as modules.

>
> Thanks,
> Jagadeesh
>
> >> +
> >> +static void __exit cam_cc_sm8550_exit(void)
> >> +{
> >> +       platform_driver_unregister(&cam_cc_sm8550_driver);
> >> +}
> >> +module_exit(cam_cc_sm8550_exit);
> >> +
> >> +MODULE_DESCRIPTION("QTI CAMCC SM8550 Driver");
> >> +MODULE_LICENSE("GPL");
> >> --
> >> 2.40.1
> >>
> >
> >



-- 
With best wishes
Dmitry
