Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59C36CA803
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjC0OpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjC0OpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:45:16 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE25F30DC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:45:13 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5416698e889so174955597b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679928313;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L12ayakUPlP/19pA0REczduySKLGqF0UobwpxbA4vYI=;
        b=HCMDYbOpcls0l7uJ+OcpKeY9i+39w/6k34p7qzXuauPoRiiQ/iBrgNX6plxv3DaduO
         LYUg1kmkuYUu1ASohU87q45xXcF5zZwjhZcjxLHNRqunmGVyvdE0ncfAbM4jYGL2a6Hi
         ZQrZHvwxbn7Qj9gGrEo+lSWNxtJMehoP7+sMxooTClbw9a72tymMpZDtFWW9QK55dq7j
         tZzKAyZROkTUGYIO6A8fULGQ90NIoJvIq/X31peKCSn6/V/RtSMVwdv2Xr54SK5CP77n
         J/+otEjjHgbrbE2HS1bwHf02GJDWrMg5vm71JCafQx1tGYW2IJIyWC5MrHLym5gAKPjm
         rKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679928313;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L12ayakUPlP/19pA0REczduySKLGqF0UobwpxbA4vYI=;
        b=JB75/2wSDvkA+uhifojWHfsYQE9HEvDOckXFIwE6OjaK0eDhvjjfIfcoM/lzZ+WJa0
         Mi1daqPdp2od1JFaW5n+0qLiKhIf2EB+uN9iBkovLiRx+SmG/0UK2urE5BJ3n8Z/FVqz
         K9Fx38HFuP2o+nKLx1Y1/2V0GCIYHXQqMuTev1axubqApbG5ju9IPzhBrBqfERIwVmAA
         OJKOcJ5XZXATlxjTkt9ZkSuSDO+EG1EP3xRZyQQuPwoleW2EvSpJCua24GY5s0H4/N4b
         inU08QkgUzJD+utzycZ5dKxpHVsMDg5r0fYGoWNHricZXYC8gjEv1GCI8qC3g0t52O+n
         UPSg==
X-Gm-Message-State: AAQBX9ehIYtvW0ciidlmKuolVEbRnL9H465uuTvXFD2lBcAg4xJgJsw3
        svxQSeynuCZEOvBi1GUczeeg5XaChdZofTeBAG6onA==
X-Google-Smtp-Source: AKy350ZjBUkCK3zk3r6esLgw2CWtnPJs9phaPxb0j+BPMz06Xywjq1t0XhIWnlijihL/e6IBy3vNDh1mPbmMAfJ9vJ8=
X-Received: by 2002:a81:b617:0:b0:541:7f69:aa8b with SMTP id
 u23-20020a81b617000000b005417f69aa8bmr5256500ywh.5.1679928312880; Mon, 27 Mar
 2023 07:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230327132718.573-1-quic_devipriy@quicinc.com> <20230327132718.573-4-quic_devipriy@quicinc.com>
In-Reply-To: <20230327132718.573-4-quic_devipriy@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 27 Mar 2023 17:45:02 +0300
Message-ID: <CAA8EJprTm1sZ8fnfNee+NJTiaFq17QwWaEnSoJWVYs_GY65xFg@mail.gmail.com>
Subject: Re: [PATCH V10 3/4] arm64: dts: qcom: Add support for ipq9574 SoC and
 RDP433 variant
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, shawnguo@kernel.org, arnd@arndb.de,
        marcel.ziswiler@toradex.com, nfraprado@collabora.com,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_srichara@quicinc.com,
        quic_gokulsri@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_poovendh@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 at 16:28, Devi Priya <quic_devipriy@quicinc.com> wrote:
>
> Add initial device tree support for Qualcomm IPQ9574 SoC and
> Reference Design Platform(RDP) 433 which is based on IPQ9574
> family of SoCs
>
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V10:
>         - Renamed the Board Device Tree Source to use the RDP numbers
>         - Updated the Makefile, subject and commit message accordingly
>
>  arch/arm64/boot/dts/qcom/Makefile           |   1 +
>  arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts |  84 ++++++
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi       | 270 ++++++++++++++++++++
>  3 files changed, 355 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq9574.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 1a29403400b7..52f1f92c5195 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_QCOM) += ipq6018-cp01-c1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += ipq8074-hk01.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += ipq8074-hk10-c1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += ipq8074-hk10-c2.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += ipq9574-rdp433.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8916-acer-a1-724.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8916-alcatel-idol347.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8916-asus-z00l.dtb
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> new file mode 100644
> index 000000000000..2ce8e09e7565
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * IPQ9574 RDP433 board device tree source
> + *
> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "ipq9574.dtsi"
> +
> +/ {
> +       model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7";
> +       compatible = "qcom,ipq9574-ap-al02-c7", "qcom,ipq9574";
> +
> +       aliases {
> +               serial0 = &blsp1_uart2;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +};
> +
> +&blsp1_uart2 {
> +       pinctrl-0 = <&uart2_pins>;
> +       pinctrl-names = "default";
> +       status = "okay";
> +};
> +
> +&sdhc_1 {
> +       pinctrl-0 = <&sdc_default_state>;
> +       pinctrl-names = "default";
> +       mmc-ddr-1_8v;
> +       mmc-hs200-1_8v;
> +       mmc-hs400-1_8v;
> +       mmc-hs400-enhanced-strobe;
> +       max-frequency = <384000000>;
> +       bus-width = <8>;
> +       status = "okay";
> +};
> +
> +&sleep_clk {
> +       clock-frequency = <32000>;
> +};
> +
> +&tlmm {
> +       sdc_default_state: sdc-default-state {
> +               clk-pins {
> +                       pins = "gpio5";
> +                       function = "sdc_clk";
> +                       drive-strength = <8>;
> +                       bias-disable;
> +               };
> +
> +               cmd-pins {
> +                       pins = "gpio4";
> +                       function = "sdc_cmd";
> +                       drive-strength = <8>;
> +                       bias-pull-up;
> +               };
> +
> +               data-pins {
> +                       pins = "gpio0", "gpio1", "gpio2",
> +                              "gpio3", "gpio6", "gpio7",
> +                              "gpio8", "gpio9";
> +                       function = "sdc_data";
> +                       drive-strength = <8>;
> +                       bias-pull-up;
> +               };
> +
> +               rclk-pins {
> +                       pins = "gpio10";
> +                       function = "sdc_rclk";
> +                       drive-strength = <8>;
> +                       bias-pull-down;
> +               };
> +       };
> +};
> +
> +&xo_board_clk {
> +       clock-frequency = <24000000>;
> +};
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> new file mode 100644
> index 000000000000..3bb7435f5e7f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -0,0 +1,270 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * IPQ9574 SoC device tree source
> + *
> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,ipq9574-gcc.h>
> +#include <dt-bindings/reset/qcom,ipq9574-gcc.h>
> +
> +/ {
> +       interrupt-parent = <&intc>;
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       clocks {
> +               bias_pll_ubi_nc_clk: bias-pll-ubi-nc-clk {
> +                       compatible = "fixed-clock";
> +                       clock-frequency = <353000000>;
> +                       #clock-cells = <0>;
> +               };

What is the source for this clock? With it clocking at 353 MHz, I
doubt that it is an external clock.

> +
> +               sleep_clk: sleep-clk {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +               };
> +
> +               xo_board_clk: xo-board-clk {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +               };
> +       };

[skipped the rest]

-- 
With best wishes
Dmitry
