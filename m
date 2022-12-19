Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF78A651053
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 17:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiLSQZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 11:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiLSQZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 11:25:26 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C05EA6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 08:25:19 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o6so9557116lfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 08:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fNyn0PpuSglmkM8Psu8dQpHECb58eTLylKFGSiHL0SU=;
        b=DlolQGOmhJNKbhCiRFDqsFeg+OSXo8kPVu9KShgQtQ8b1OP1K5iZJcsmROskXLNLu+
         bGmDlB+bCD9bNqTyC6GgrmwkDuDf3uvxTzEZIaeU+CEH3ZOpvPMhVAv0J8JxPgyf9Cbj
         MNbOA8Ls+/9/A6e0qKrhiLlh9iqjXNfV5hThtQODBmz9HgsuFl5lspondEiKI7N2c/ix
         8FJeE1vDmnQDgKIrsWd9zvyBMHbX3oFBvnRxrFeFtLvdcC1B8So/ntb8JlCmALsMdbp+
         dzW/wDmcqYd0bb2ZWEJZl9nYmkd6roo1FfKmqxGHun2tJPMhHXbDii3ahEx/Cs53D2+v
         fC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNyn0PpuSglmkM8Psu8dQpHECb58eTLylKFGSiHL0SU=;
        b=Ss2YCLdek1UrqmYGalZnRJB1qxVxwUApW+meHXh9Bn3QcG+bBVWoTJB6mrPXrSLYdp
         i6v3aGbkvZV0er8FTZNqtWievOpdLgQT8qxakLI8YjrWrTIw8m4ZvamkOt3pa+KDJo4V
         5R6oRXJgxCOOBsqEyL4rKJlUUEWh7xpYftOZlz1Lo0JFVOKY0OpcZ46MMV9/JDBltB+f
         kY5BRilTcR1W6D5hT//e+fMlSKrw9oKQm0W/G3i+w6n7pKq80oBlSINTLdVTzi2Z73VJ
         ffqahjQbJRIH/aUYgeF1B+O+wH2KPCPW0DEBK+Qh+2Z+Zi1vjvnKkbdnB+58RcKkT7R2
         8aDw==
X-Gm-Message-State: ANoB5pkB4KVCj+zWvaJOrQfbRCTZF0SwWcOEdbCIG3hgikYSCHVlXoWZ
        /ToL3bgVKFczV1LkADSGC2xjIA==
X-Google-Smtp-Source: AA0mqf6fU4TisrkCdG5np/psi1flj2dVajvvjT+FaVgyyeHktwzR/cNIhYmY3wNbhmPMhGPRuRbw4Q==
X-Received: by 2002:ac2:4f16:0:b0:4a4:68b8:9c4b with SMTP id k22-20020ac24f16000000b004a468b89c4bmr11891630lfr.51.1671467118075;
        Mon, 19 Dec 2022 08:25:18 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id e13-20020a05651236cd00b004b5a85e369asm1142082lfs.252.2022.12.19.08.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 08:25:17 -0800 (PST)
Message-ID: <8dc05650-428c-2995-a365-d397c92e7a6a@linaro.org>
Date:   Mon, 19 Dec 2022 18:25:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 2/2] clk: qcom: Add QDU1000 and QRU1000 GCC support
Content-Language: en-GB
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221216230722.21404-1-quic_molvera@quicinc.com>
 <20221216230722.21404-3-quic_molvera@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221216230722.21404-3-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/2022 01:07, Melody Olvera wrote:
> From: Taniya Das <quic_tdas@quicinc.com>
> 
> Add Global Clock Controller (GCC) support for QDU1000 and QRU1000 SoCs.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>   drivers/clk/qcom/Kconfig       |    8 +
>   drivers/clk/qcom/Makefile      |    1 +
>   drivers/clk/qcom/gcc-qdu1000.c | 2653 ++++++++++++++++++++++++++++++++
>   3 files changed, 2662 insertions(+)
>   create mode 100644 drivers/clk/qcom/gcc-qdu1000.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 70d43f0a8919..d2e9ff7536f5 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -569,6 +569,14 @@ config QCS_Q6SSTOP_404
>   	  Say Y if you want to use the Q6SSTOP branch clocks of the WCSS clock
>   	  controller to reset the Q6SSTOP subsystem.
>   
> +config QDU_GCC_1000
> +	tristate "QDU1000/QRU1000 Global Clock Controller"
> +	select QCOM_GDSC
> +	help
> +	  Support for the global clock controller on QDU1000 and
> +	  QRU1000 devices. Say Y if you want to use peripheral
> +	  devices such as UART, SPI, I2C, USB, SD, PCIe, etc.
> +
>   config SDM_GCC_845
>   	tristate "SDM845/SDM670 Global Clock Controller"
>   	select QCOM_GDSC
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index f18c446a97ea..c1615c76d3df 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -62,6 +62,7 @@ obj-$(CONFIG_QCM_DISPCC_2290) += dispcc-qcm2290.o
>   obj-$(CONFIG_QCS_GCC_404) += gcc-qcs404.o
>   obj-$(CONFIG_QCS_Q6SSTOP_404) += q6sstop-qcs404.o
>   obj-$(CONFIG_QCS_TURING_404) += turingcc-qcs404.o
> +obj-$(CONFIG_QDU_GCC_1000) += gcc-qdu1000.o
>   obj-$(CONFIG_SC_CAMCC_7180) += camcc-sc7180.o
>   obj-$(CONFIG_SC_CAMCC_7280) += camcc-sc7280.o
>   obj-$(CONFIG_SC_DISPCC_7180) += dispcc-sc7180.o
> diff --git a/drivers/clk/qcom/gcc-qdu1000.c b/drivers/clk/qcom/gcc-qdu1000.c
> new file mode 100644
> index 000000000000..144073562f8d
> --- /dev/null
> +++ b/drivers/clk/qcom/gcc-qdu1000.c
> @@ -0,0 +1,2653 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,qdu1000-gcc.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "clk-regmap-divider.h"
> +#include "clk-regmap-mux.h"
> +#include "clk-regmap-phy-mux.h"
> +#include "reset.h"
> +
> +enum {
> +	P_BI_TCXO,
> +	P_GCC_GPLL0_OUT_EVEN,
> +	P_GCC_GPLL0_OUT_MAIN,
> +	P_GCC_GPLL1_OUT_MAIN,
> +	P_GCC_GPLL2_OUT_MAIN,
> +	P_GCC_GPLL3_OUT_MAIN,
> +	P_GCC_GPLL4_OUT_MAIN,
> +	P_GCC_GPLL5_OUT_MAIN,
> +	P_GCC_GPLL6_OUT_MAIN,
> +	P_GCC_GPLL7_OUT_MAIN,
> +	P_GCC_GPLL8_OUT_MAIN,
> +	P_PCIE_0_PHY_AUX_CLK,
> +	P_PCIE_0_PIPE_CLK,
> +	P_SLEEP_CLK,
> +	P_USB3_PHY_WRAPPER_GCC_USB30_PIPE_CLK,
> +};
> +
> +enum {
> +	TCXO_IDX,
> +	SLEEP_CLK_IDX,
> +	PCIE_0_PIPE_CLK_IDX,
> +	PCIE_0_PHY_AUX_CLK_IDX,
> +	USB3_PHY_WRAPPER_PIPE_CLK_IDX,
> +};

Please prefix these names with DT_, so that it's clear that they are 
indices in the device tree.

With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

