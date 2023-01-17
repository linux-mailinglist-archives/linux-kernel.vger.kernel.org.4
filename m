Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75756670D27
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjAQXUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjAQXTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:19:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F17053E45;
        Tue, 17 Jan 2023 13:07:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCDF2B819B0;
        Tue, 17 Jan 2023 21:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FAAC433D2;
        Tue, 17 Jan 2023 21:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673989617;
        bh=CysGW8OdPPONp0Zukni5r38vCtpff9N6XeNykqoQOXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CEc2eLqrLqFqh6QCXhO2xYmHbtppsBHl+wfbUatH19HEKa5NMpfRp1igSqm+S0Zrk
         kAe3W2IMfiO+srDEdo/GwE0shTpOxJGH1IqalWuMRAP8PHs01KmEtIirQkySpYEbSB
         C5UMSGup7X29ksarUC6tgD7jr0QYLrjD7CF0/AQFlZXGVcInj8BGY9sOtXjFuTnbBr
         BwSJi6EeTX12L1SLecF4bXu4428e4xeoHDIenelc9wPuboI2Agt7gDmM+LYfa3rVPd
         ELfTR+qJ9pPM0KLXT+bfo/uXSuJ+/2nc1cc28NFrpEQlWNUN2zPPyfrdsu2/6FIVrn
         lGFmvcRyaaCUg==
Date:   Tue, 17 Jan 2023 15:06:54 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>
Subject: Re: [PATCH v3 7/8] arm64: dts: qcom: Add Square apq8039-t2 board
Message-ID: <20230117210654.ojrhlt6c5hdy3whm@builder.lan>
References: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
 <20230117024846.1367794-8-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117024846.1367794-8-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 02:48:45AM +0000, Bryan O'Donoghue wrote:
> The apq8039-t2 is an apq8039 based board paired with a wcn3680b WiFi
> chipset.
> 
> Co-developed-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Co-developed-by: Jun Nie <jun.nie@linaro.org>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> Co-developed-by: Benjamin Li <benl@squareup.com>
> Signed-off-by: Benjamin Li <benl@squareup.com>
> Co-developed-by: James Willcox <jwillcox@squareup.com>
> Signed-off-by: James Willcox <jwillcox@squareup.com>
> Co-developed-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Co-developed-by: Joseph Gates <jgates@squareup.com>
> Signed-off-by: Joseph Gates <jgates@squareup.com>
> Co-developed-by: Max Chen <mchen@squareup.com>
> Signed-off-by: Max Chen <mchen@squareup.com>
> Co-developed-by: Zac Crosby <zac@squareup.com>
> Signed-off-by: Zac Crosby <zac@squareup.com>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile       |   1 +
>  arch/arm64/boot/dts/qcom/apq8039-t2.dts | 557 ++++++++++++++++++++++++
>  2 files changed, 558 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/apq8039-t2.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index e442a81895d04..5c47d1fb50b01 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
> diff --git a/arch/arm64/boot/dts/qcom/apq8039-t2.dts b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
> new file mode 100644
> index 0000000000000..21f5a21f76135
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
> @@ -0,0 +1,557 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2020-2023, Linaro Ltd.
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include "msm8939.dtsi"
> +#include "msm8939-pm8916.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/sound/apq8016-lpass.h>
> +
> +/ {
> +	model = "Square, Inc. T2 Devkit";
> +	compatible = "square,apq8039-t2", "qcom,msm8939";
> +
> +	qcom,board-id = <0x53 0x54>;
> +	qcom,msm-id = <239 0>, <239 0x30000>, <241 0x30000>, <263 0x30000>;

Would it be possible to include and use dt-bindings/arm/qcom,ids.h here?

> +
> +	aliases {
> +		mmc0 = &sdhc_1;
> +		mmc1 = &sdhc_2;
> +		serial0 = &blsp1_uart1;
> +		serial1 = &blsp1_uart2;
> +	};
[..]
> +&pm8916_gpios {
> +	gpio-line-names =
> +		"PM_GPIO1",     /* WIFI_GPIO1_PRE */
> +		"PM_GPIO2",     /* WIFI_GPIO2_PRE */
> +		"PM_GPIO3",
> +		"PM_GPIO4";
> +};
> +
> +&pronto {

As mentioned in the dtsi patch, please sort your nodes by label,
alphabetically. You may choose to group the pinctrl nodes last in the
file...

Regards,
Bjorn

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wcnss_pin_a>;
> +	status = "okay";
> +
> +	iris {
> +		compatible = "qcom,wcn3680";
> +	};
> +};
